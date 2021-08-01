Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679D3DCD4C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhHATkV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHATkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C357C06175F;
        Sun,  1 Aug 2021 12:40:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c18so14763720qke.2;
        Sun, 01 Aug 2021 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgAV2Tx4JaOgQ/w1ciFu9dSQbNnnPjfTyQHZyoR4mpA=;
        b=bSP0TqxxGXlafUHs/FOi3TnFde5jWNTreSbRAg9SuYSQFafIkm1LjmeNJ8iXsRyOmy
         sDLOegP2W2rXtpyyGeDR4UUnitZZozDL/fyxawiEDxOfWE36xBQyq4GESLQqW4XLajs6
         A+OufPfZmux2bxbx2i46Qmyw2dQm9j5LE/4wRNyRNYYKDS7d3EOgKcfDN1dcY6EJXcbQ
         ycXZishT43j1uP5IDdhT1MrVMtcxlnpOG2QR6kOVprjj3Dd2HtnFF2gj33zcAXacjJWy
         ly5jAEBB0pDvHEC7wsiv9Sj5J++7fX/i4EIWBVQLIb7WyTo/objSUqmlEN8noKxGnCp8
         WH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgAV2Tx4JaOgQ/w1ciFu9dSQbNnnPjfTyQHZyoR4mpA=;
        b=ninnGnq2lr5zcn615G0/ku0FBAmZ61JvqFInDFFf60XB+luK4b9SVWNrci4yJFKFHo
         emHQnBkCMaZsXKWM6hd5HIMuqCzwmaUzlFwQsAnd2IVp7W/cdk1OXIvWlWmkWdeNwWwG
         Xu6BJccO6D5psSleepEYMUVq+triQcSLksb70g1XX0hpLVPVHKbMN6UjVivAq6rFBWuD
         KXwFSICQyNHPc34NjQYoLd12/mDCoipmbXXxlhGD/X3o+dVdlaUv1nXXMHDWu7RJldku
         mt2BDDx0gnoLyjlTT7/o8LeDL/wikuUfrrql8MVsFtUm525vmz76kwBgXnaGcH0GG57c
         0zRg==
X-Gm-Message-State: AOAM531nv/pCanrgwY/cEAkLGhAgjKEKhrm40dJanzZdDzfiWB7tNiKE
        vRGnBBLtu88asQ2CrFVcL58=
X-Google-Smtp-Source: ABdhPJzoIPz5IF5ngHFbLiLyAEttvJOpzeTR0bpDyRreopKSaWxt4ALFmqLydFo0ndlJtFuN/nFcHg==
X-Received: by 2002:a37:a6d2:: with SMTP id p201mr12617547qke.98.1627846810682;
        Sun, 01 Aug 2021 12:40:10 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:10 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 00/13] iio: afe: add temperature rescaling support
Date:   Sun,  1 Aug 2021 15:39:47 -0400
Message-Id: <20210801194000.3646303-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add temperature rescaling support to the IIO Analog Front End driver.

This series includes minor bug fixes and adds support for RTD temperature
sensors as well as temperature transducers.

At first I tried to use iio_convert_raw_to_processed() to get more
precision out of processed values but ran into issues when one of my
ADCs didn't provide a scale. I tried to address this in the first few
patches.

When adding offset support to iio-rescale, I also noticed that
iio_read_channel_processed() assumes that the offset is always an
integer which I tried to address in the third patch without breaking
valid implicit truncations.

As Jonathan suggested, I also started a Kunit test suite for the
iio-rescale driver.
Adding these test cases, I found that the IIO_VAL_FRACTIONAL_LOG2
rescaling wasn't as precise as expected so I tried to fix that as well.

Changes since v6:
- rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
- combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
- add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
- force use of positive integers with gcd()
- reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
- fix duplicate symbol build error
- apply Reviewed-by

Changes since v5:
- add include/linux/iio/afe/rescale.h
- expose functions use to process scale and offset
- add basic iio-rescale kunit test cases
- fix integer overflow case
- improve precision for IIO_VAL_FRACTIONAL_LOG2

Changes since v4:
- only use gcd() when necessary in overflow mitigation
- fix INT_PLUS_{MICRO,NANO} support
- apply Reviewed-by
- fix temperature-transducer bindings

Changes since v3:
- drop unnecessary fallthrough statements
- drop redundant local variables in some calculations
- fix s64 divisions on 32bit platforms by using do_div
- add comment describing iio-rescaler offset calculation
- drop unnecessary MAINTAINERS entry

Changes since v2:
- don't break implicit offset truncations
- make a best effort to get a valid value for fractional types
- drop return value change in iio_convert_raw_to_processed_unlocked()
- don't rely on processed value for offset calculation
- add INT_PLUS_{MICRO,NANO} support in iio-rescale
- revert generic implementation in favor of temperature-sense-rtd and
  temperature-transducer
- add separate section to MAINTAINERS file

Changes since v1:
- rebase on latest iio `testing` branch
- also apply consumer scale on integer channel scale types
- don't break implicit truncation in processed channel offset
  calculation
- drop temperature AFE flavors in favor of a simpler generic
  implementation

Thanks for your time

Liam Beguin (13):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: make a best effort on offset calculation
  iio: afe: rescale: expose scale processing function
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: reduce risk of integer overflow
  iio: afe: rescale: fix precision on fractional log scale
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++
 .../iio/afe/temperature-transducer.yaml       | 114 +++++
 drivers/iio/afe/iio-rescale.c                 | 271 ++++++++--
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 483 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  34 ++
 8 files changed, 1010 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v6:
 1:  16627ca44022 <  -:  ------------ iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 -:  ------------ >  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  ed0721fb6bd1 iio: inkern: make a best effort on offset calculation
 -:  ------------ >  4:  f8fb78bb1112 iio: afe: rescale: expose scale processing function
 -:  ------------ >  5:  014363f5f703 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 2:  dec2a933fbf3 =  6:  e4e3bcd752dd iio: afe: rescale: add offset support
 4:  f2f4af324d5d !  7:  23efde61c576 iio: afe: rescale: reduce risk of integer overflow
    @@ drivers/iio/afe/iio-rescale.c
     -	unsigned long long tmp;
     +	s64 tmp, tmp2;
     +	u32 factor;
    + 	u32 mult;
    + 	u32 rem;
    + 	u32 neg;
      
      	switch (scale_type) {
      	case IIO_VAL_FRACTIONAL:
    @@ drivers/iio/afe/iio-rescale.c
     +		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
     +			tmp = (s64)*val * rescale->numerator;
     +			tmp2 = (s64)*val2 * rescale->denominator;
    -+			factor = gcd(tmp, tmp2);
    ++			factor = gcd(abs(tmp), abs(tmp2));
     +			tmp = div_s64(tmp, factor);
     +			tmp2 = div_s64(tmp2, factor);
     +		}
 5:  4a8d77501f32 !  8:  e16f69d61f09 iio: afe: rescale: fix precision on fractional log scale
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     -		do_div(tmp, rescale->denominator);
     -		tmp *= rescale->numerator;
     -		do_div(tmp, 1000000000LL);
    --		*val = tmp;
    ++		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
    ++		    check_mul_overflow(rescale->denominator, (1 << *val2), (s32 *)&tmp2)) {
    ++			tmp = (s64)*val * rescale->numerator;
    ++			tmp2 = (s64)rescale->denominator * (1 << *val2);
    ++			factor = gcd(abs(tmp), abs(tmp2));
    ++			tmp = div_s64(tmp, factor);
    ++			tmp2 = div_s64(tmp2, factor);
    ++		}
    + 		*val = tmp;
     -		return scale_type;
    -+		*val = rescale->numerator * *val;
    -+		*val2 = rescale->denominator * (1 << *val2);
    ++		*val2 = tmp2;
     +		return IIO_VAL_FRACTIONAL;
      	case IIO_VAL_INT_PLUS_NANO:
    - 		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
    - 		tmp = div_s64(tmp, rescale->denominator);
    + 	case IIO_VAL_INT_PLUS_MICRO:
    + 		if (scale_type == IIO_VAL_INT_PLUS_NANO)
 3:  60bd09555300 !  9:  88ad312c5a1b iio: test: add basic tests for the iio-rescale driver
    @@ drivers/iio/test/Kconfig
      # Keep in alphabetical order
     +config IIO_RESCALE_KUNIT_TEST
     +	bool "Test IIO rescale conversion functions"
    -+	depends on KUNIT=y
    ++	depends on KUNIT && !IIO_RESCALE
     +	default KUNIT_ALL_TESTS
     +	help
     +	  If you want to run tests on the iio-rescale code say Y here.
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
    ++		.schan_val2 = 123456,
    ++		.expected = "1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
    ++		.numerator = -1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = 10,
    ++		.schan_val2 = 123456,
    ++		.expected = "-1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
    ++		.numerator = 1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = 10,
    ++		.schan_val2 = 1234,
    ++		.expected = "1240.847890\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
    ++		.numerator = -1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = 10,
    ++		.schan_val2 = 1234,
    ++		.expected = "-1240.847890\n",
    ++	},
    ++	/*
    ++	 * INT_PLUS_{MICRO,NANO} positive/negative corner cases
    ++	 */
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, negative schan",
    ++		.numerator = 1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 123456,
    ++		.expected = "-1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, both negative",
    ++		.numerator = -1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 123456,
    ++		.expected = "1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, 3 negative",
    ++		.numerator = -1000000,
    ++		.denominator = -8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 123456,
    ++		.expected = "-1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, 4 negative",
    ++		.numerator = -1000000,
    ++		.denominator = -8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = -123456,
    ++		.expected = "-1240.710106203\n",
    ++	},
    ++	{
    ++		.name = "typical IIO_VAL_INT_PLUS_NANO, negative, *val = 0",
    ++		.numerator = 1,
    ++		.denominator = -10,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = 0,
    ++		.schan_val2 = 123456789,
    ++		.expected = "-0.012345678\n",
    ++	},
    ++	/*
    ++	 * INT_PLUS_{MICRO,NANO} decimal part overflow
    ++	 */
    ++	{
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, positive",
    ++		.numerator = 1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = 10,
     +		.schan_val2 = 123456789,
     +		.expected = "1256.012008560\n",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative",
     +		.numerator = -1000000,
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.expected = "-1256.012008560\n",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative schan",
    ++		.numerator = 1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 123456789,
    ++		.expected = "-1256.012008560\n",
    ++	},
    ++	{
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, positive",
     +		.numerator = 1000000,
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.expected = "16557.914267\n",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative",
     +		.numerator = -1000000,
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val2 = 123456789,
     +		.expected = "-16557.914267\n",
     +	},
    ++	{
    ++		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
    ++		.numerator = 1000000,
    ++		.denominator = 8060,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 123456789,
    ++		.expected = "-16557.914267\n",
    ++	},
     +	/*
     +	 * 32-bit overflow conditions
     +	 */
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.expected = "-214748364.700000000\n",
     +	},
     +	{
    ++		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, positive",
    ++		.numerator = 0x7FFFFFFF,
    ++		.denominator = 53,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = 4096,
    ++		.schan_val2 = 16,
    ++		.expected = "2532409.961084905\n",
    ++	},
    ++	{
    ++		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, negative",
    ++		.numerator = 0x7FFFFFFF,
    ++		.denominator = 53,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = -4096,
    ++		.schan_val2 = 16,
    ++		.expected = "-2532409.961084905\n",
    ++	},
    ++	{
     +		.name = "overflow IIO_VAL_INT_PLUS_NANO, positive",
     +		.numerator = 2,
     +		.denominator = 20,
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.expected = "-1.214748364\n",
     +	},
     +	{
    ++		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative schan",
    ++		.numerator = 2,
    ++		.denominator = 20,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 0x7fffffff,
    ++		.expected = "-1.214748364\n",
    ++	},
    ++	{
     +		.name = "overflow IIO_VAL_INT_PLUS_MICRO, positive",
     +		.numerator = 2,
     +		.denominator = 20,
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val2 = 0x7fffffff,
     +		.expected = "-215.748364\n",
     +	},
    ++	{
    ++		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
    ++		.numerator = 2,
    ++		.denominator = 20,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = -10,
    ++		.schan_val2 = 0x7fffffff,
    ++		.expected = "-215.748364\n",
    ++	},
     +};
     +
     +const struct rescale_tc_data offset_cases[] = {
 6:  2b6e4f47c974 = 10:  2c4a31e62c31 iio: afe: rescale: add RTD temperature sensor support
 7:  715e1877e30f = 11:  d1258a38d194 iio: afe: rescale: add temperature transducers
 8:  0bc8546f13e5 = 12:  01fa34bf5362 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
 9:  4bc54afa3e94 ! 13:  107e61e09eec dt-bindings: iio: afe: add bindings for temperature transducers
    @@ Commit message
         through a temperature transducer (either voltage or current).
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Reviewed-by: Rob Herring <robh@kernel.org>
     
      ## Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new) ##
     @@

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

