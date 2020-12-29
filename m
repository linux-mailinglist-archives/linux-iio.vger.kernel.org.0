Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA82E72F3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2SRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 13:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2SRn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 13:17:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F236522209;
        Tue, 29 Dec 2020 18:17:01 +0000 (UTC)
Date:   Tue, 29 Dec 2020 18:16:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add basic unit test for iio_format_value()
Message-ID: <20201229181658.5aa5e8d4@archlinux>
In-Reply-To: <20201215191743.2725-3-lars@metafoo.de>
References: <20201215191743.2725-1-lars@metafoo.de>
        <20201215191743.2725-3-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Dec 2020 20:17:43 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The IIO core provides a function to do formatting of fixedpoint numbers.
> 
> In the past there have been some issues with the implementation of the
> function where for example negative numbers were not handled correctly.
> 
> Introduce a basic unit test based on kunit that tests the function and
> ensures that the generated output matches the expected output.
> 
> This gives us some confidence that future modifications to the function
> implementation will not break ABI compatibility.
> 
> To run the unit tests follow the kunit documentation and add
> 
>   CONFIG_IIO=y
>   CONFIG_IIO_TEST_FORMAT=y
> 
> to the .kunitconfig and run
> 
>   > ./tools/testing/kunit/kunit.py run  
>   Configuring KUnit Kernel ...
>   Building KUnit Kernel ...
>   Starting KUnit Kernel ...
>   ============================================================
>   ======== [PASSED] iio-format ========
>   [PASSED] iio_test_iio_format_value_integer
>   [PASSED] iio_test_iio_format_value_fixedpoint
>   [PASSED] iio_test_iio_format_value_fractional
>   [PASSED] iio_test_iio_format_value_fractional_log2
>   [PASSED] iio_test_iio_format_value_multiple
>   ============================================================
>   Testing complete. 21 tests run. 0 failed. 0 crashed.
>   Elapsed time: 8.242s total, 0.001s configuring, 3.865s building, 0.000s running
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Series looks good to me, but I wonder.  What is convention wrt to 
MAINTAINERS / Acks etc for self tests?

Jonathan


> ---
>  drivers/iio/Kconfig                |   1 +
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/test/Kconfig           |   9 ++
>  drivers/iio/test/Makefile          |   7 +
>  drivers/iio/test/iio-test-format.c | 198 +++++++++++++++++++++++++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 drivers/iio/test/Kconfig
>  create mode 100644 drivers/iio/test/Makefile
>  create mode 100644 drivers/iio/test/iio-test-format.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 267553386c71..b35e0c33b5e2 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -85,6 +85,7 @@ source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
>  source "drivers/iio/multiplexer/Kconfig"
>  source "drivers/iio/orientation/Kconfig"
> +source "drivers/iio/test/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 1712011c0f4a..2561325aaa74 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -38,4 +38,5 @@ obj-y += pressure/
>  obj-y += proximity/
>  obj-y += resolver/
>  obj-y += temperature/
> +obj-y += test/
>  obj-y += trigger/
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> new file mode 100644
> index 000000000000..679a7794af20
> --- /dev/null
> +++ b/drivers/iio/test/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Industrial I/O subsystem unit tests configuration
> +#
> +
> +# Keep in alphabetical order
> +config IIO_TEST_FORMAT
> +        bool "Test IIO formatting functions"
> +        depends on KUNIT=y
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> new file mode 100644
> index 000000000000..f1099b495301
> --- /dev/null
> +++ b/drivers/iio/test/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the industrial I/O unit tests.
> +#
> +
> +# Keep in alphabetical order
> +obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
> new file mode 100644
> index 000000000000..55a0cfe9181d
> --- /dev/null
> +++ b/drivers/iio/test/iio-test-format.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unit tests for IIO formatting functions
> + *
> + * Copyright (c) 2020 Lars-Peter Clausen <lars@metafoo.de>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/iio/iio.h>
> +
> +#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do { \
> +		KUNIT_EXPECT_EQ(_test, (int)strlen(_buf), _ret); \
> +		KUNIT_EXPECT_STREQ(_test, (_buf), (_val)); \
> +	} while (0)
> +
> +static void iio_test_iio_format_value_integer(struct kunit *test)
> +{
> +	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	int val;
> +	int ret;
> +
> +	val = 42;
> +	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
> +
> +	val = -23;
> +	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-23\n");
> +
> +	val = 0;
> +	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
> +
> +	val = INT_MAX;
> +	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "2147483647\n");
> +
> +	val = INT_MIN;
> +	ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-2147483648\n");
> +}
> +
> +static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
> +{
> +	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	int values[2];
> +	int ret;
> +
> +	/* positive >= 1 */
> +	values[0] = 1;
> +	values[1] = 10;
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
> +
> +	/* positive < 1 */
> +	values[0] = 0;
> +	values[1] = 12;
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
> +
> +	/* negative <= -1 */
> +	values[0] = -1;
> +	values[1] = 10;
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
> +
> +	/* negative > -1 */
> +	values[0] = 0;
> +	values[1] = -123;
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
> +}
> +
> +static void iio_test_iio_format_value_fractional(struct kunit *test)
> +{
> +	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	int values[2];
> +	int ret;
> +
> +	/* positive < 1 */
> +	values[0] = 1;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
> +
> +	/* positive >= 1 */
> +	values[0] = 100;
> +	values[1] = 3;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
> +
> +	/* negative > -1 */
> +	values[0] = -1;
> +	values[1] = 1000000000;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
> +
> +	/* negative <= -1 */
> +	values[0] = -200;
> +	values[1] = 3;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
> +
> +	/* Zero */
> +	values[0] = 0;
> +	values[1] = -10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
> +}
> +
> +static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
> +{
> +	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	int values[2];
> +	int ret;
> +
> +	/* positive < 1 */
> +	values[0] = 123;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
> +
> +	/* positive >= 1 */
> +	values[0] = 1234567;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
> +
> +	/* negative > -1 */
> +	values[0] = -123;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
> +
> +	/* negative <= -1 */
> +	values[0] = -1234567;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
> +
> +	/* Zero */
> +	values[0] = 0;
> +	values[1] = 10;
> +	ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
> +}
> +
> +static void iio_test_iio_format_value_multiple(struct kunit *test)
> +{
> +	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	int values[] = {1, -2, 3, -4, 5};
> +	int ret;
> +
> +	ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
> +			       ARRAY_SIZE(values), values);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
> +}
> +
> +static struct kunit_case iio_format_test_cases[] = {
> +		KUNIT_CASE(iio_test_iio_format_value_integer),
> +		KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
> +		KUNIT_CASE(iio_test_iio_format_value_fractional),
> +		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
> +		KUNIT_CASE(iio_test_iio_format_value_multiple),
> +		{}
> +};
> +
> +static struct kunit_suite iio_format_test_suite = {
> +	.name = "iio-format",
> +	.test_cases = iio_format_test_cases,
> +};
> +kunit_test_suite(iio_format_test_suite);

