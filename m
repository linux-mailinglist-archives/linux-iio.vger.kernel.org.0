Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A74600FD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355850AbhK0SxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 13:53:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60552 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355895AbhK0SvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 13:51:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A7960F06;
        Sat, 27 Nov 2021 18:48:03 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 6F802C53FAD;
        Sat, 27 Nov 2021 18:47:59 +0000 (UTC)
Date:   Sat, 27 Nov 2021 18:53:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        jbhayana@google.com, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
Subject: Re: [PATCH v1 1/2] iio: test: Add check against NULL for buffer in
 tests.
Message-ID: <20211127185300.23b4f0df@jic23-huawei>
In-Reply-To: <20211113165214.1e84a925@jic23-huawei>
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
        <20211105100501.1904-2-andriy.tryshnivskyy@opensynergy.com>
        <CAHp75Ve7AoPaPUv699kEu3jMGRWTysLd932NZCfi8cjwuDmcOw@mail.gmail.com>
        <20211113165214.1e84a925@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Nov 2021 16:52:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 5 Nov 2021 12:16:40 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Fri, Nov 5, 2021 at 12:05 PM Andriy Tryshnivskyy
> > <andriy.tryshnivskyy@opensynergy.com> wrote:  
> > >
> > > Add KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) for every test.
> > > Also use ARRAY_SIZE(values) where it is possible.    
> > 
> > Strictly speaking 'also' and similar in the commit message means you
> > have to split. Here are two patches in one. But these are test cases
> > and I don't care so much about the rules. Up to maintainers.  
> 
> Ideally I'd agree, but sometimes it's just not worth wasting anyones time
> if both parts are mechanical as here.
> 
> Given this is Lars' code I'll leave a bit longer for him to give any tags
> he wishes before picking it up.
> 
> Give me a poke if I seem to have lost it in a few weeks.  In theory I
> shouldn't given I'm using patchwork as a backup tracker these days, but
> meh - I've lost series before!

Enough time I think. Applied to the togreg branch of iio.git and pushed out
as testing for 0-day to have a quick sanity check.  I'll push it out so
linux-next picks it up later in the week.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> >   
> > >
> > > Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> > > ---
> > >  drivers/iio/test/iio-test-format.c | 69 ++++++++++++++++++------------
> > >  1 file changed, 42 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
> > > index f1e951eddb43..b746d00bc0ea 100644
> > > --- a/drivers/iio/test/iio-test-format.c
> > > +++ b/drivers/iio/test/iio-test-format.c
> > > @@ -14,10 +14,13 @@
> > >
> > >  static void iio_test_iio_format_value_integer(struct kunit *test)
> > >  {
> > > -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       char *buf;
> > >         int val;
> > >         int ret;
> > >
> > > +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> > > +
> > >         val = 42;
> > >         ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
> > > @@ -41,142 +44,154 @@ static void iio_test_iio_format_value_integer(struct kunit *test)
> > >
> > >  static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
> > >  {
> > > -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > >         int values[2];
> > > +       char *buf;
> > >         int ret;
> > >
> > > +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> > > +
> > >         /* positive >= 1 */
> > >         values[0] = 1;
> > >         values[1] = 10;
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
> > >
> > >         /* positive < 1 */
> > >         values[0] = 0;
> > >         values[1] = 12;
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
> > >
> > >         /* negative <= -1 */
> > >         values[0] = -1;
> > >         values[1] = 10;
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
> > >
> > >         /* negative > -1 */
> > >         values[0] = 0;
> > >         values[1] = -123;
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
> > >
> > > -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
> > >  }
> > >
> > >  static void iio_test_iio_format_value_fractional(struct kunit *test)
> > >  {
> > > -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > >         int values[2];
> > > +       char *buf;
> > >         int ret;
> > >
> > > +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> > > +
> > >         /* positive < 1 */
> > >         values[0] = 1;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
> > >
> > >         /* positive >= 1 */
> > >         values[0] = 100;
> > >         values[1] = 3;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
> > >
> > >         /* negative > -1 */
> > >         values[0] = -1;
> > >         values[1] = 1000000000;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
> > >
> > >         /* negative <= -1 */
> > >         values[0] = -200;
> > >         values[1] = 3;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
> > >
> > >         /* Zero */
> > >         values[0] = 0;
> > >         values[1] = -10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
> > >  }
> > >
> > >  static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
> > >  {
> > > -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > >         int values[2];
> > > +       char *buf;
> > >         int ret;
> > >
> > > +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> > > +
> > >         /* positive < 1 */
> > >         values[0] = 123;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
> > >
> > >         /* positive >= 1 */
> > >         values[0] = 1234567;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
> > >
> > >         /* negative > -1 */
> > >         values[0] = -123;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
> > >
> > >         /* negative <= -1 */
> > >         values[0] = -1234567;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
> > >
> > >         /* Zero */
> > >         values[0] = 0;
> > >         values[1] = 10;
> > > -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
> > > +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
> > >  }
> > >
> > >  static void iio_test_iio_format_value_multiple(struct kunit *test)
> > >  {
> > > -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > >         int values[] = {1, -2, 3, -4, 5};
> > > +       char *buf;
> > >         int ret;
> > >
> > > +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> > > +
> > >         ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
> > >                                ARRAY_SIZE(values), values);
> > >         IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
> > > --
> > > 2.17.1
> > >    
> > 
> >   
> 

