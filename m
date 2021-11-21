Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5C458574
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhKURdP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 12:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbhKURdN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Nov 2021 12:33:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971CEC061574;
        Sun, 21 Nov 2021 09:30:08 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id n15so14489497qta.0;
        Sun, 21 Nov 2021 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ia8p8wbWqDBltqeZQzzSvYFrlNq98f2IDOwCAG1SWso=;
        b=Q4BDrWOQjkeIdJYurGqVU5Lxter2VIYtO6o7QRvBRo8qXsNf87XE9qa20brCtO5z3o
         LftHPlIF4pTBE467hAIurR0TRCR4sian1hd+fV+0viUyGATAF0Fqi26VXggbuRzlg5pm
         NknnZXecnyf284i7lMEXO624/Sknuo3gabv9uhS82nrT90G7Y/FpezJP7jXlTCNUEcY4
         hpjvOrB5sefw8sVBKYVuCwdOmQjzpabPzVMoPUOMWtb/NnXuu0eKxsrpKIHMsBI1ZLO6
         EMl4F51eBtYetroOaFao4efkNHDPEQU0V9DCmabDM/HGeUUZ9vzC0OATTVZ4KGPXf8+L
         myjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ia8p8wbWqDBltqeZQzzSvYFrlNq98f2IDOwCAG1SWso=;
        b=49MhFTsF+5H0QXxH29GpPcDVx9nkcanP5Z31WZV6pYCSfwr7Azbt4irimE8qDIevOc
         osvUpO8pWZ/qnCl2+/6CTgdkvFLoaTN0L2NIYgg2QzTHy5fgUiDANahoRCb+cS7GioKB
         4smPmES1Uk6eG/R+svt1iO3hEAcZtsCH+zEOGIHbXGIItM6T/CVLhnFBlTK5sYo5lta1
         PgGAvpyl85K+LemlZAWzdxSczPoeawrwdqkJTZo4cIvviNwr3O5EqcLDZpV2Ns1kDfoB
         MkM/UCcA04m8bUlSNJXtV8VfGZu65C9UKk/+dtrdin6GTHILvJbTlOjKmrcFduOogrn+
         Eegw==
X-Gm-Message-State: AOAM533Teb+Ib0dKvGG8wfgo9sICWM5eR95eXi8LW9FoiO3HD9MmEIRz
        KHNlU/oPgCwwYPZUOkVgTqs=
X-Google-Smtp-Source: ABdhPJzSqFrqhZEde6qXijcw6vDjRqx4v6mTEJ/53+B4gxg5mSfdN5OXQ6QhntqFBYjZtaAeBYYk2g==
X-Received: by 2002:ac8:4e96:: with SMTP id 22mr25189902qtp.76.1637515807441;
        Sun, 21 Nov 2021 09:30:07 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p10sm3233131qtw.97.2021.11.21.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 09:30:06 -0800 (PST)
Date:   Sun, 21 Nov 2021 12:30:04 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     peda@axentia.se, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v9 00/14] iio: afe: add temperature rescaling support
Message-ID: <YZqCHE4K+oqR7vNj@shaak>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
 <20211121112556.2b5b161c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121112556.2b5b161c@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 21, 2021 at 11:25:56AM +0000, Jonathan Cameron wrote:
> On Sun, 14 Nov 2021 22:43:20 -0500
> Liam Beguin <liambeguin@gmail.com> wrote:
> 
> > Hi Jonathan, Peter,
> > 
> > Apologies for not getting back to you sooner. I got caught up on other
> > work and wasn't able to dedicate time to this earlier. Hopefully, this
> > time around, I'll be able to get this to the finish line :-)
> > 
> > I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> > the rest of these changes pulled in, but I don't mind adding a patch for
> > that later on.
> > 
> > This series focuses on adding temperature rescaling support to the IIO
> > Analog Front End (AFE) driver.
> > 
> > The first few patches address minor bugs in IIO inkernel functions, and
> > prepare the AFE driver for the additional features.
> > 
> > The main changes to the AFE driver include an initial Kunit test suite,
> > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > and temperature transducer sensors.
> > 
> > Thanks for your time,
> > Liam
> 
> Hi Liam,

Hi Jonathan,

> I'm fine with these.  The comment about using the MICRO etc defines can
> be handled as as trivial follow up patch. Hopefully someone else can
> figure out the 0-day build issue as I didn't managed to.

I'll prepare the MICRO, NANO changes if we have a v10, otherwise I'll
send them as a follow up patch as you suggest.

I'll also try to find more time to dig more into that 0-day build issue.

> However, I've long ago lost track of the various precision discussions
> you and Peter were having so would like Peter's input before taking these.

That's my fault, apologies for letting this sit for so long.

> Thanks again for your persistence with this,

No worries, thanks for your patience :)

Cheers,
Liam

> 
> Jonathan
> 
> > 
> > Changes since v8:
> > - reword comment
> > - fix erroneous 64-bit division
> > - optimize and use 32-bit divisions when values are know to not overflow
> > - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
> >   point
> > - add test cases
> > - use nano precision in test cases
> > - simplify offset calculation in rtd_props()
> > 
> > Changes since v7:
> > - drop gcd() logic in rescale_process_scale()
> > - use div_s64() instead of do_div() for signed 64-bit divisions
> > - combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
> > - switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
> > - rework test logic to allow for small relative error
> > - rename test variables to align error output messages
> > 
> > Changes since v6:
> > - rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
> > - combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
> > - add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
> > - force use of positive integers with gcd()
> > - reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
> > - fix duplicate symbol build error
> > - apply Reviewed-by
> > 
> > Changes since v5:
> > - add include/linux/iio/afe/rescale.h
> > - expose functions use to process scale and offset
> > - add basic iio-rescale kunit test cases
> > - fix integer overflow case
> > - improve precision for IIO_VAL_FRACTIONAL_LOG2
> > 
> > Changes since v4:
> > - only use gcd() when necessary in overflow mitigation
> > - fix INT_PLUS_{MICRO,NANO} support
> > - apply Reviewed-by
> > - fix temperature-transducer bindings
> > 
> > Changes since v3:
> > - drop unnecessary fallthrough statements
> > - drop redundant local variables in some calculations
> > - fix s64 divisions on 32bit platforms by using do_div
> > - add comment describing iio-rescaler offset calculation
> > - drop unnecessary MAINTAINERS entry
> > 
> > Changes since v2:
> > - don't break implicit offset truncations
> > - make a best effort to get a valid value for fractional types
> > - drop return value change in iio_convert_raw_to_processed_unlocked()
> > - don't rely on processed value for offset calculation
> > - add INT_PLUS_{MICRO,NANO} support in iio-rescale
> > - revert generic implementation in favor of temperature-sense-rtd and
> >   temperature-transducer
> > - add separate section to MAINTAINERS file
> > 
> > Changes since v1:
> > - rebase on latest iio `testing` branch
> > - also apply consumer scale on integer channel scale types
> > - don't break implicit truncation in processed channel offset
> >   calculation
> > - drop temperature AFE flavors in favor of a simpler generic
> >   implementation
> > 
> > Liam Beguin (14):
> >   iio: inkern: apply consumer scale on IIO_VAL_INT cases
> >   iio: inkern: apply consumer scale when no channel scale is available
> >   iio: inkern: make a best effort on offset calculation
> >   iio: afe: rescale: expose scale processing function
> >   iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
> >   iio: afe: rescale: add offset support
> >   iio: afe: rescale: use s64 for temporary scale calculations
> >   iio: afe: rescale: reduce risk of integer overflow
> >   iio: afe: rescale: fix accuracy for small fractional scales
> >   iio: test: add basic tests for the iio-rescale driver
> >   iio: afe: rescale: add RTD temperature sensor support
> >   iio: afe: rescale: add temperature transducers
> >   dt-bindings: iio: afe: add bindings for temperature-sense-rtd
> >   dt-bindings: iio: afe: add bindings for temperature transducers
> > 
> >  .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
> >  .../iio/afe/temperature-transducer.yaml       | 114 +++
> >  drivers/iio/afe/iio-rescale.c                 | 271 ++++++-
> >  drivers/iio/inkern.c                          |  40 +-
> >  drivers/iio/test/Kconfig                      |  10 +
> >  drivers/iio/test/Makefile                     |   1 +
> >  drivers/iio/test/iio-test-rescale.c           | 705 ++++++++++++++++++
> >  include/linux/iio/afe/rescale.h               |  34 +
> >  8 files changed, 1232 insertions(+), 44 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
> >  create mode 100644 drivers/iio/test/iio-test-rescale.c
> >  create mode 100644 include/linux/iio/afe/rescale.h
> > 
> > Range-diff against v8:
> >  1:  42a7a1047edc =  1:  ae3cc93baee6 iio: inkern: apply consumer scale on IIO_VAL_INT cases
> >  2:  a1cd89fdad11 =  2:  06f66e7f7403 iio: inkern: apply consumer scale when no channel scale is available
> >  3:  ed0721fb6bd1 =  3:  2dbf6b3bbaeb iio: inkern: make a best effort on offset calculation
> >  4:  f8fb78bb1112 =  4:  b083cf307268 iio: afe: rescale: expose scale processing function
> >  5:  504b7a3f830b !  5:  a0bde29ecc8c iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
> >     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
> >      +		else
> >      +			mult = 1000000LL;
> >      +		/*
> >     -+		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> >     -+		 * *val2 is negative the schan scale is negative
> >     ++		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
> >     ++		 * OR *val2 is negative the schan scale is negative, i.e.
> >     ++		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
> >      +		 */
> >      +		neg = *val < 0 || *val2 < 0;
> >      +
> >  6:  c254e9ae813e =  6:  c3d0e6248033 iio: afe: rescale: add offset support
> >  7:  ee8814d6abe4 =  7:  2a81fa735103 iio: afe: rescale: use s64 for temporary scale calculations
> >  8:  62cdcfbc9836 =  8:  8315548d0fce iio: afe: rescale: reduce risk of integer overflow
> >  9:  88309a5136ee !  9:  223ed0569cd2 iio: afe: rescale: fix accuracy for small fractional scales
> >     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
> >      +
> >      +		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> >       		*val = tmp;
> >     +-		return scale_type;
> >     ++
> >     ++		if (!rem)
> >     ++			return scale_type;
> >      +
> >     -+		/*
> >     -+		 * For small values, the approximation can be costly,
> >     -+		 * change scale type to maintain accuracy.
> >     -+		 *
> >     -+		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> >     -+		 */
> >      +		if (scale_type == IIO_VAL_FRACTIONAL)
> >      +			tmp = *val2;
> >      +		else
> >      +			tmp = 1 << *val2;
> >      +
> >     -+		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> >     -+			 *val = div_s64_rem(*val, tmp, &rem2);
> >     -+
> >     -+			 *val2 = div_s64(rem, tmp);
> >     -+			 if (rem2)
> >     -+				 *val2 += div_s64(rem2 * 1000000000LL, tmp);
> >     ++		rem2 = *val % (int)tmp;
> >     ++		*val = *val / (int)tmp;
> >      +
> >     -+			 return IIO_VAL_INT_PLUS_NANO;
> >     -+		 }
> >     ++		*val2 = rem / (int)tmp;
> >     ++		if (rem2)
> >     ++			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> >      +
> >     - 		return scale_type;
> >     ++		return IIO_VAL_INT_PLUS_NANO;
> >       	case IIO_VAL_INT_PLUS_NANO:
> >       	case IIO_VAL_INT_PLUS_MICRO:
> >     + 		if (scale_type == IIO_VAL_INT_PLUS_NANO)
> > 10:  fb505a9f42f1 ! 10:  90044efdf8be iio: test: add basic tests for the iio-rescale driver
> >     @@ drivers/iio/test/Makefile
> >       # Keep in alphabetical order
> >      +obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
> >       obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> >     + CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> >      
> >       ## drivers/iio/test/iio-test-rescale.c (new) ##
> >      @@
> >     @@ drivers/iio/test/iio-test-rescale.c (new)
> >      +	 * Use cases with small scales involving divisions
> >      +	 */
> >      +	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL, 261/509 scaled by 90/1373754273",
> >     ++		.numerator = 261,
> >     ++		.denominator = 509,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
> >     ++		.schan_val = 90,
> >     ++		.schan_val2 = 1373754273,
> >     ++		.expected = "0.000000033594",
> >     ++	},
> >     ++	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL, 90/1373754273 scaled by 261/509",
> >     ++		.numerator = 90,
> >     ++		.denominator = 1373754273,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
> >     ++		.schan_val = 261,
> >     ++		.schan_val2 = 509,
> >     ++		.expected = "0.000000033594",
> >     ++	},
> >     ++	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL, 760/1373754273 scaled by 427/2727",
> >     ++		.numerator = 760,
> >     ++		.denominator = 1373754273,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
> >     ++		.schan_val = 427,
> >     ++		.schan_val2 = 2727,
> >     ++		.expected = "0.000000086626",
> >     ++	},
> >     ++	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL, 761/1373754273 scaled by 427/2727",
> >     ++		.numerator = 761,
> >     ++		.denominator = 1373754273,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
> >     ++		.schan_val = 427,
> >     ++		.schan_val2 = 2727,
> >     ++		.expected = "0.000000086740",
> >     ++	},
> >     ++	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL, 5/32768 scaled by 3/10000",
> >     ++		.numerator = 5,
> >     ++		.denominator = 32768,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
> >     ++		.schan_val = 3,
> >     ++		.schan_val2 = 10000,
> >     ++		.expected = "0.0000000457763671875",
> >     ++	},
> >     ++	{
> >      +		.name = "small IIO_VAL_FRACTIONAL, 0 < scale < 1",
> >      +		.numerator = 6,
> >      +		.denominator = 6,
> >     @@ drivers/iio/test/iio-test-rescale.c (new)
> >      +		.expected = "-1.3333333333333333",
> >      +	},
> >      +	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, 760/32768 scaled by 15/22",
> >     ++		.numerator = 760,
> >     ++		.denominator = 32768,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
> >     ++		.schan_val = 15,
> >     ++		.schan_val2 = 22,
> >     ++		.expected = "0.000000082946",
> >     ++	},
> >     ++	{
> >     ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, 761/32768 scaled by 15/22",
> >     ++		.numerator = 761,
> >     ++		.denominator = 32768,
> >     ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
> >     ++		.schan_val = 15,
> >     ++		.schan_val2 = 22,
> >     ++		.expected = "0.000000083055",
> >     ++	},
> >     ++	{
> >      +		.name = "small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 1",
> >      +		.numerator = 16,
> >      +		.denominator = 3,
> >     @@ drivers/iio/test/iio-test-rescale.c (new)
> >      +KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
> >      +
> >      +/**
> >     -+ * iio_str_to_micro() - Parse a fixed-point string to get an
> >     -+ *                      IIO_VAL_INT_PLUS_MICRO value
> >     ++ * iio_str_to_nano() - Parse a fixed-point string to get an
> >     ++ *                      IIO_VAL_INT_PLUS_NANO value
> >      + * @str: The string to parse
> >     -+ * @micro: The number as an integer
> >     ++ * @nano: The number as an integer
> >      + *
> >      + * Returns 0 on success, or a negative error code if the string cound not be
> >      + * parsed.
> >      + */
> >     -+static int iio_str_to_micro(const char *str, s64 *micro)
> >     ++static int iio_str_to_nano(const char *str, s64 *nano)
> >      +{
> >     -+	int fract_mult = 100000LL;
> >     ++	int fract_mult = 100000000LL;
> >      +	int tmp, tmp2;
> >      +	int ret = 0;
> >      +
> >     @@ drivers/iio/test/iio-test-rescale.c (new)
> >      +	if (tmp < 0)
> >      +		tmp2 *= -1;
> >      +
> >     -+	*micro = (s64)tmp * 10 * fract_mult + tmp2;
> >     ++	*nano = (s64)tmp * 10 * fract_mult + tmp2;
> >      +
> >      +	return ret;
> >      +}
> >      +
> >      +/**
> >     -+ * iio_test_relative_error_ppm() - Compute relative error (in ppm) between two
> >     -+ *                                 fixed-point strings
> >     ++ * iio_test_relative_error_ppm() - Compute relative error (in parts-per-million)
> >     ++ *                                 between two fixed-point strings
> >      + * @real_str: The real value as a string
> >      + * @exp_str: The expected value as a string
> >      + *
> >      + * Returns a negative error code if the strings cound not be parsed, or the
> >     -+ * relative error in ppm.
> >     ++ * relative error in parts-per-million.
> >      + */
> >      +static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str)
> >      +{
> >      +	s64 real, exp, err;
> >      +	int ret;
> >      +
> >     -+	ret = iio_str_to_micro(real_str, &real);
> >     ++	ret = iio_str_to_nano(real_str, &real);
> >      +	if (ret < 0)
> >      +		return ret;
> >      +
> >     -+	ret = iio_str_to_micro(exp_str, &exp);
> >     ++	ret = iio_str_to_nano(exp_str, &exp);
> >      +	if (ret < 0)
> >      +		return ret;
> >      +
> >     ++	if (!exp) {
> >     ++		pr_err("Expected value is null, relative error is undefined\n");
> >     ++		return -EINVAL;
> >     ++	}
> >     ++
> >      +	err = 1000000 * abs(exp - real);
> >      +	err = div64_u64(err, abs(exp));
> >      +	return (int)err;
> >     @@ drivers/iio/test/iio-test-rescale.c (new)
> >      +	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
> >      +	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
> >      +
> >     -+	KUNIT_EXPECT_LT_MSG(test, rel_ppm, 500,
> >     ++	KUNIT_EXPECT_EQ_MSG(test, rel_ppm, 0,
> >      +			    "\t    real=%s"
> >      +			    "\texpected=%s\n",
> >      +			    buff, t->expected);
> > 11:  050487186e14 = 11:  c4ed463e5fb0 iio: afe: rescale: add RTD temperature sensor support
> > 12:  f36a44a5d898 ! 12:  ff2f0dc248a7 iio: afe: rescale: add temperature transducers
> >     @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
> >      +	s32 offset = 0;
> >      +	s32 sense = 1;
> >      +	s32 alpha;
> >     -+	s64 tmp;
> >      +	int ret;
> >      +
> >      +	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
> >     @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
> >      +	rescale->numerator = 1000000;
> >      +	rescale->denominator = alpha * sense;
> >      +
> >     -+	tmp = (s64)offset * (s64)alpha * (s64)sense;
> >     -+	rescale->offset = div_s64(tmp, (s32)1000000);
> >     ++	rescale->offset = div_s64((s64)offset * rescale->denominator,
> >     ++				  rescale->numerator);
> >      +
> >      +	return 0;
> >      +}
> > 13:  63be647fd110 = 13:  84bc1f7d1ab5 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
> > 14:  c2f5c19dece3 = 14:  1b76cfb37e23 dt-bindings: iio: afe: add bindings for temperature transducers
> > 
> > base-commit: 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
> 
