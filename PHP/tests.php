<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;
include_once('RPNparser.php');

final class BasicTest extends TestCase
{
    public function testBasic(): void
    {
        $this->assertEquals(
        	parser('2 3 - 6 3 + * 5 * 100 +'),
            '55'
        );
    }
}

# ex: ts=4 sw=4 et filetype=php:
?>
