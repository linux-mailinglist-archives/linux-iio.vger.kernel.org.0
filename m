Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1637446213
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhKEKT6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhKEKT5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 06:19:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73722C061714;
        Fri,  5 Nov 2021 03:17:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w1so31566253edd.10;
        Fri, 05 Nov 2021 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxS+teCMlbvtTm/Hjy1qwKiXkuYaNC03ztUq8ZtPmME=;
        b=S2YjR1XDbGJvR5itXa5PWQeRDOQdbnu2+b5+8ySW0q/bHEyWHtkOiVy4GR5Pd6YO3z
         ZGU0Kj7mAB072ZzLX5Rv/apegH7I+XmN7N8fXQkNC+1ald+uqfwuvJk6z/C8dtZaQaAE
         qCGK9I6N21tBOTCNToRHYyce7M+B42Kjl1+R5cjDE+HfTEJxpAAiLIPgce1I/tvHtoAU
         vK2e2BQgj0+3gVxGXiIVWy1jc1ecqvL6LH3NyW5yAmLQwJUQ1gOTz12qzCY70KnmFx5w
         SvVAbB80X4eATApmqSHSV/4wJvHc/8xevBnnXce7yhfvAq1JPAGJwP9HOhFo4xGtXd93
         6eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxS+teCMlbvtTm/Hjy1qwKiXkuYaNC03ztUq8ZtPmME=;
        b=RlPQNvkWxtAD5hFuDLHtMmjCIg+Tt6n7etmgUYIsAbu5F2ljtJnrFVji+XikS0Sos/
         RgPgNpNXpC47lxUyryUscwpF/veTd7tlDKcO6R1cYBlA9OvK4GoUO8qhQkUgiS5BU2iG
         vX96kYs2WvZvmt9TAIjBigRkDh4Br/6rYZlv6NePKVTAD+ELHAYrI7mL9wm4RsMrOLye
         mVojCcd+E7TcPVhoVqMwsikM484/mkn+xg6HbCHbJ4tXf8wV/7vsiTVFg7erMnD0HAtN
         yGjRnzGhnzJkHXaFKywagE8Rg5W2JDhRVLPLDExVOCebprNldICLBcrTQ45wTzhLUl3p
         zc8A==
X-Gm-Message-State: AOAM5328Tc9ZgZEuvSx06xxrBhDLUpgBuvo6JKv0G6w0RvEF2Hee9UDj
        aPxRf6yR8MvzgZRT6g9cPLbU9C1ZYHLga83Ameo=
X-Google-Smtp-Source: ABdhPJwfy3H9/8A17I9QKXpbpzwU+ftTlEEDvvR5PETZYjqEH7ZrMlY+70sGOCgUZ0/1xFcJJ4sp4qCxp+AqQkEP5uI=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr4946710ejb.128.1636107436973;
 Fri, 05 Nov 2021 03:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com> <20211105100501.1904-2-andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211105100501.1904-2-andriy.tryshnivskyy@opensynergy.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Nov 2021 12:16:40 +0200
Message-ID: <CAHp75Ve7AoPaPUv699kEu3jMGRWTysLd932NZCfi8cjwuDmcOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: test: Add check against NULL for buffer in tests.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     jbhayana@google.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 5, 2021 at 12:05 PM Andriy Tryshnivskyy
<andriy.tryshnivskyy@opensynergy.com> wrote:
>
> Add KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) for every test.
> Also use ARRAY_SIZE(values) where it is possible.

Strictly speaking 'also' and similar in the commit message means you
have to split. Here are two patches in one. But these are test cases
and I don't care so much about the rules. Up to maintainers.

>
> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> ---
>  drivers/iio/test/iio-test-format.c | 69 ++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
> index f1e951eddb43..b746d00bc0ea 100644
> --- a/drivers/iio/test/iio-test-format.c
> +++ b/drivers/iio/test/iio-test-format.c
> @@ -14,10 +14,13 @@
>
>  static void iio_test_iio_format_value_integer(struct kunit *test)
>  {
> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       char *buf;
>         int val;
>         int ret;
>
> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
>         val = 42;
>         ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
> @@ -41,142 +44,154 @@ static void iio_test_iio_format_value_integer(struct kunit *test)
>
>  static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
>  {
> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>         int values[2];
> +       char *buf;
>         int ret;
>
> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
>         /* positive >= 1 */
>         values[0] = 1;
>         values[1] = 10;
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
>
>         /* positive < 1 */
>         values[0] = 0;
>         values[1] = 12;
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
>
>         /* negative <= -1 */
>         values[0] = -1;
>         values[1] = 10;
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
>
>         /* negative > -1 */
>         values[0] = 0;
>         values[1] = -123;
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
>
> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
>  }
>
>  static void iio_test_iio_format_value_fractional(struct kunit *test)
>  {
> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>         int values[2];
> +       char *buf;
>         int ret;
>
> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
>         /* positive < 1 */
>         values[0] = 1;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
>
>         /* positive >= 1 */
>         values[0] = 100;
>         values[1] = 3;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
>
>         /* negative > -1 */
>         values[0] = -1;
>         values[1] = 1000000000;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
>
>         /* negative <= -1 */
>         values[0] = -200;
>         values[1] = 3;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
>
>         /* Zero */
>         values[0] = 0;
>         values[1] = -10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
>  }
>
>  static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
>  {
> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>         int values[2];
> +       char *buf;
>         int ret;
>
> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
>         /* positive < 1 */
>         values[0] = 123;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
>
>         /* positive >= 1 */
>         values[0] = 1234567;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
>
>         /* negative > -1 */
>         values[0] = -123;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
>
>         /* negative <= -1 */
>         values[0] = -1234567;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
>
>         /* Zero */
>         values[0] = 0;
>         values[1] = 10;
> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
>  }
>
>  static void iio_test_iio_format_value_multiple(struct kunit *test)
>  {
> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>         int values[] = {1, -2, 3, -4, 5};
> +       char *buf;
>         int ret;
>
> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
>         ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
>                                ARRAY_SIZE(values), values);
>         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
