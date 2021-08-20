Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08C3F346A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhHTTSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHTTSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC79C061575;
        Fri, 20 Aug 2021 12:17:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v1so6060944qva.7;
        Fri, 20 Aug 2021 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAqdM7A4DYriKGrtHrpIrQXTQpg2CEVHrXQyntzO0gk=;
        b=Af4Eax/Hu/ZbeUzm8jApRRt3Bxg81aqQ6Q/S68FN14vwOR6GDXNaAhK/XetO/a9oj5
         uVJqZBwx/pvgamxwU9GvHXv7HjGr/EXshACi+j3dPd7y2tEGDFQTeOHXShIhWQKYYAtS
         ru5mqOiJN4QqSBsFJotoRyls0lZquQOnbqZ7dSpmwGfjWdPHcWYA+70e2d/egOpgljtb
         uND4mvBm06FHSCYE2cFsLgVOInECy8B5jkQetl2TBWjXrJk7rhkHNq0+TkBv7nvGWT+o
         fYU8v8a8IYSKbfoYMEP8NsC3kEuw4GUfgnh8kZaThwEQWAm6IazxJCfgw8GF2MaxOM7Q
         9QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAqdM7A4DYriKGrtHrpIrQXTQpg2CEVHrXQyntzO0gk=;
        b=b3KFUnQkqJ24FrYSNb7lDGeMvMqARSE+eYyZKNj1hVfq0q71S/t+BCo1R7dt070UoK
         XH92aXJFa48zkHOMhBLzSd8H1MfNkQcm0l/0y0krD4TkRvsr1FK6eGK95q3Cpsb+xhhI
         VWjRJyR+5JPsXFgTm81YagcYpwM/HypuLmD1g15vU5fCqh9hEitm7oEKlxdHUVkGSCLo
         WxflWSjTgwt7JSP5dRtvNjuNW7B6Dvbua0W1CiKgdaArRWJiaDIWx+1R+sKKqT+6hycQ
         HiAT/vqd+ZmnL9sLRUZy+b+BGMKckHmAuXZruKbt0u9Hlt2b/gciF28z2y6nwvaF8LIV
         BrEg==
X-Gm-Message-State: AOAM531IK7GjnsGb7YTLtcPDjNdEPAWBwW+NjD0B+/wJuusv4vB0qlUL
        YMziuQBHqDBAtfKraylF0Ag=
X-Google-Smtp-Source: ABdhPJzqTzXen52FSxqc4UiKE6KPlzODoKwoPR0/ziz/qdGEZ46VZv3sajzvvdR5uX1p6KYduFa3+w==
X-Received: by 2002:ad4:54f2:: with SMTP id k18mr21878749qvx.24.1629487072447;
        Fri, 20 Aug 2021 12:17:52 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:51 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 00/14] iio: afe: add temperature rescaling support
Date:   Fri, 20 Aug 2021 15:17:00 -0400
Message-Id: <20210820191714.69898-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add temperature rescaling support to the IIO Analog Front End driver.

This series includes minor bug fixes and adds support for RTD temperature
sensors as well as temperature transducers.

At first I tried to use iio_convert_raw_to_processed() to get more
precision out of processed values but ran into issues when one of my
ADCs didn't provide a scale. This was addressed in the first few
patches.

When adding offset support to iio-rescale, I also noticed that
iio_read_channel_processed() assumes that the offset is always an
integer which I tried to address in the third patch without breaking
valid implicit truncations.

As Jonathan suggested, I also started a Kunit test suite for the
iio-rescale driver. Adding the test cases, I ran into accuracy and
overflow issues, these was addressed in 07-09/14.

Changes since v7:
- drop gcd() logic in rescale_process_scale()
- use div_s64() instead of do_div() for signed 64-bit divisions
- combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
- switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
- rework test logic to allow for small relative error
- rename test variables to align error output messages

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
  iio: afe: rescale: use s64 for temporary scale calculations
  iio: afe: rescale: reduce risk of integer overflow
  iio: afe: rescale: fix accuracy for small fractional scales
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
 .../iio/afe/temperature-transducer.yaml       | 114 ++++
 drivers/iio/afe/iio-rescale.c                 | 277 +++++++-
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 637 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  34 +
 8 files changed, 1170 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v7:
 -:  ------------ >  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  ed0721fb6bd1 iio: inkern: make a best effort on offset calculation
 -:  ------------ >  4:  f8fb78bb1112 iio: afe: rescale: expose scale processing function
 1:  014363f5f703 !  5:  504b7a3f830b iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
      			  int *val, int *val2)
      {
      	unsigned long long tmp;
    ++	s32 rem;
     +	u32 mult;
    -+	u32 rem;
     +	u32 neg;
      
      	switch (scale_type) {
 2:  e4e3bcd752dd =  6:  c254e9ae813e iio: afe: rescale: add offset support
 3:  23efde61c576 <  -:  ------------ iio: afe: rescale: reduce risk of integer overflow
 4:  e16f69d61f09 <  -:  ------------ iio: afe: rescale: fix precision on fractional log scale
 -:  ------------ >  7:  ee8814d6abe4 iio: afe: rescale: use s64 for temporary scale calculations
 -:  ------------ >  8:  62cdcfbc9836 iio: afe: rescale: reduce risk of integer overflow
 -:  ------------ >  9:  88309a5136ee iio: afe: rescale: fix accuracy for small fractional scales
 5:  88ad312c5a1b ! 10:  fb505a9f42f1 iio: test: add basic tests for the iio-rescale driver
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT,
     +		.schan_val = 42,
    -+		.expected = "5210.918114143\n",
    ++		.expected = "5210.918114143",
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT,
     +		.schan_val = 42,
    -+		.expected = "-5210.918114143\n",
    ++		.expected = "-5210.918114143",
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_FRACTIONAL,
     +		.schan_val = 42,
     +		.schan_val2 = 20,
    -+		.expected = "260.545905707\n",
    ++		.expected = "260.545905707",
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_FRACTIONAL,
     +		.schan_val = 42,
     +		.schan_val2 = 20,
    -+		.expected = "-260.545905707\n",
    ++		.expected = "-260.545905707",
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
     +		.schan_val = 4096,
     +		.schan_val2 = 16,
    -+		.expected = "0.049528301\n",
    ++		.expected = "0.049528301",
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
     +		.schan_val = 4096,
     +		.schan_val2 = 16,
    -+		.expected = "-0.049528301\n",
    ++		.expected = "-0.049528301",
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456,
    -+		.expected = "1240.710106203\n",
    ++		.expected = "1240.710106203",
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456,
    -+		.expected = "-1240.710106203\n",
    ++		.expected = "-1240.710106203",
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
     +		.schan_val2 = 1234,
    -+		.expected = "1240.847890\n",
    ++		.expected = "1240.84789",
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
     +		.schan_val2 = 1234,
    -+		.expected = "-1240.847890\n",
    ++		.expected = "-1240.84789",
    ++	},
    ++	/*
    ++	 * Use cases with small scales involving divisions
    ++	 */
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL, 0 < scale < 1",
    ++		.numerator = 6,
    ++		.denominator = 6,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
    ++		.schan_val = 1,
    ++		.schan_val2 = 3,
    ++		.expected = "0.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL, -1 < scale < 0",
    ++		.numerator = -6,
    ++		.denominator = 6,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
    ++		.schan_val = 1,
    ++		.schan_val2 = 3,
    ++		.expected = "-0.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL, 0 < scale < 2",
    ++		.numerator = 8,
    ++		.denominator = 2,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
    ++		.schan_val = 1,
    ++		.schan_val2 = 3,
    ++		.expected = "1.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL, -2 < scale < 0",
    ++		.numerator = -8,
    ++		.denominator = 2,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL,
    ++		.schan_val = 1,
    ++		.schan_val2 = 3,
    ++		.expected = "-1.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 1",
    ++		.numerator = 16,
    ++		.denominator = 3,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = 1,
    ++		.schan_val2 = 4,
    ++		.expected = "0.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, -1 < scale < 0",
    ++		.numerator = -16,
    ++		.denominator = 3,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = 1,
    ++		.schan_val2 = 4,
    ++		.expected = "-0.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 2",
    ++		.numerator = 8,
    ++		.denominator = 3,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = 1,
    ++		.schan_val2 = 1,
    ++		.expected = "1.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_FRACTIONAL_LOG2, -2 < scale < 0",
    ++		.numerator = -8,
    ++		.denominator = 3,
    ++		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
    ++		.schan_val = 1,
    ++		.schan_val2 = 1,
    ++		.expected = "-1.3333333333333333",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_INT_PLUS_MICRO, positive",
    ++		.numerator = 1,
    ++		.denominator = 2,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = 5,
    ++		.schan_val2 = 1234,
    ++		.expected = "2.500617",
    ++	},
    ++	{
    ++		.name = "small IIO_VAL_INT_PLUS_MICRO, negative",
    ++		.numerator = -1,
    ++		.denominator = 2,
    ++		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
    ++		.schan_val = 5,
    ++		.schan_val2 = 1234,
    ++		.expected = "-2.500617",
     +	},
     +	/*
     +	 * INT_PLUS_{MICRO,NANO} positive/negative corner cases
     +	 */
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative schan",
    ++		.name = "negative IIO_VAL_INT_PLUS_NANO, negative schan",
     +		.numerator = 1000000,
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
     +		.schan_val2 = 123456,
    -+		.expected = "-1240.710106203\n",
    ++		.expected = "-1240.710106203",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, both negative",
    ++		.name = "negative IIO_VAL_INT_PLUS_NANO, both negative",
     +		.numerator = -1000000,
     +		.denominator = 8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
     +		.schan_val2 = 123456,
    -+		.expected = "1240.710106203\n",
    ++		.expected = "1240.710106203",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, 3 negative",
    ++		.name = "negative IIO_VAL_INT_PLUS_NANO, 3 negative",
     +		.numerator = -1000000,
     +		.denominator = -8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
     +		.schan_val2 = 123456,
    -+		.expected = "-1240.710106203\n",
    ++		.expected = "-1240.710106203",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, 4 negative",
    ++		.name = "negative IIO_VAL_INT_PLUS_NANO, 4 negative",
     +		.numerator = -1000000,
     +		.denominator = -8060,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
     +		.schan_val2 = -123456,
    -+		.expected = "-1240.710106203\n",
    ++		.expected = "-1240.710106203",
     +	},
     +	{
    -+		.name = "typical IIO_VAL_INT_PLUS_NANO, negative, *val = 0",
    ++		.name = "negative IIO_VAL_INT_PLUS_NANO, negative, *val = 0",
     +		.numerator = 1,
     +		.denominator = -10,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 0,
     +		.schan_val2 = 123456789,
    -+		.expected = "-0.012345678\n",
    ++		.expected = "-0.012345678",
     +	},
     +	/*
     +	 * INT_PLUS_{MICRO,NANO} decimal part overflow
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
    -+		.expected = "1256.012008560\n",
    ++		.expected = "1256.01200856",
     +	},
     +	{
     +		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
    -+		.expected = "-1256.012008560\n",
    ++		.expected = "-1256.01200856",
     +	},
     +	{
     +		.name = "decimal overflow IIO_VAL_INT_PLUS_NANO, negative schan",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
     +		.schan_val2 = 123456789,
    -+		.expected = "-1256.012008560\n",
    ++		.expected = "-1256.01200856",
     +	},
     +	{
     +		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
    -+		.expected = "16557.914267\n",
    ++		.expected = "16557.914267",
     +	},
     +	{
     +		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
    -+		.expected = "-16557.914267\n",
    ++		.expected = "-16557.914267",
     +	},
     +	{
     +		.name = "decimal overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = -10,
     +		.schan_val2 = 123456789,
    -+		.expected = "-16557.914267\n",
    ++		.expected = "-16557.914267",
     +	},
     +	/*
     +	 * 32-bit overflow conditions
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.numerator = 2,
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_FRACTIONAL,
    -+		.schan_val = 0x7FFFFFFF,
    ++		.schan_val = S32_MAX,
     +		.schan_val2 = 1,
    -+		.expected = "214748364.700000000\n",
    ++		.expected = "214748364.7",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_FRACTIONAL, negative",
     +		.numerator = -2,
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_FRACTIONAL,
    -+		.schan_val = 0x7FFFFFFF,
    ++		.schan_val = S32_MAX,
     +		.schan_val2 = 1,
    -+		.expected = "-214748364.700000000\n",
    ++		.expected = "-214748364.7",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, positive",
    -+		.numerator = 0x7FFFFFFF,
    -+		.denominator = 53,
    ++		.numerator = S32_MAX,
    ++		.denominator = 4096,
     +		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
     +		.schan_val = 4096,
     +		.schan_val2 = 16,
    -+		.expected = "2532409.961084905\n",
    ++		.expected = "32767.99998474121",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_FRACTIONAL_LOG2, negative",
    -+		.numerator = 0x7FFFFFFF,
    -+		.denominator = 53,
    ++		.numerator = S32_MAX,
    ++		.denominator = 4096,
     +		.schan_scale_type = IIO_VAL_FRACTIONAL_LOG2,
     +		.schan_val = -4096,
     +		.schan_val2 = 16,
    -+		.expected = "-2532409.961084905\n",
    ++		.expected = "-32767.99998474121",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_NANO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "1.214748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "1.214748364",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = 10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "-1.214748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "-1.214748364",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_NANO, negative schan",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
     +		.schan_val = -10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "-1.214748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "-1.214748364",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_MICRO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "215.748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "215.748364",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = 10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "-215.748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "-215.748364",
     +	},
     +	{
     +		.name = "overflow IIO_VAL_INT_PLUS_MICRO, negative schan",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.denominator = 20,
     +		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
     +		.schan_val = -10,
    -+		.schan_val2 = 0x7fffffff,
    -+		.expected = "-215.748364\n",
    ++		.schan_val2 = S32_MAX,
    ++		.expected = "-215.748364",
     +	},
     +};
     +
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 123,
     +		.schan_val2 = 0,
     +		.schan_off = 14,
    -+		.expected_off = "24\n", /* 23.872 */
    ++		.expected_off = "24", /* 23.872 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 12,
     +		.schan_val2 = 0,
     +		.schan_off = 14,
    -+		.expected_off = "-88\n", /* -88.83333333333333 */
    ++		.expected_off = "-88", /* -88.83333333333333 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 12,
     +		.schan_val2 = 34,
     +		.schan_off = 14,
    -+		.expected_off = "3510\n", /* 3510.333333333333 */
    ++		.expected_off = "3510", /* 3510.333333333333 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 12,
     +		.schan_val2 = 34,
     +		.schan_off = 14,
    -+		.expected_off = "-3482\n", /* -3482.333333333333 */
    ++		.expected_off = "-3482", /* -3482.333333333333 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL_LOG2, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 12,
     +		.schan_val2 = 16,
     +		.schan_off = 14,
    -+		.expected_off = "6739299\n", /* 6739299.333333333 */
    ++		.expected_off = "6739299", /* 6739299.333333333 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_FRACTIONAL_LOG2, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 12,
     +		.schan_val2 = 16,
     +		.schan_off = 14,
    -+		.expected_off = "-6739271\n", /* -6739271.333333333 */
    ++		.expected_off = "-6739271", /* -6739271.333333333 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_NANO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
     +		.schan_off = 14,
    -+		.expected_off = "135\n", /* 135.8951219647469 */
    ++		.expected_off = "135", /* 135.8951219647469 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_NANO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
     +		.schan_off = 14,
    -+		.expected_off = "-107\n", /* -107.89512196474689 */
    ++		.expected_off = "-107", /* -107.89512196474689 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_MICRO, positive",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
     +		.schan_off = 14,
    -+		.expected_off = "23\n", /* 23.246438560723952 */
    ++		.expected_off = "23", /* 23.246438560723952 */
     +	},
     +	{
     +		.name = "typical IIO_VAL_INT_PLUS_MICRO, negative",
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		.schan_val = 10,
     +		.schan_val2 = 123456789,
     +		.schan_off = 14,
    -+		.expected_off = "-78\n", /* -78.50185091745313 */
    ++		.expected_off = "-78", /* -78.50185091745313 */
     +	},
     +};
     +
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);
     +KUNIT_ARRAY_PARAM(iio_rescale_offset, offset_cases, case_to_desc);
     +
    ++/**
    ++ * iio_str_to_micro() - Parse a fixed-point string to get an
    ++ *                      IIO_VAL_INT_PLUS_MICRO value
    ++ * @str: The string to parse
    ++ * @micro: The number as an integer
    ++ *
    ++ * Returns 0 on success, or a negative error code if the string cound not be
    ++ * parsed.
    ++ */
    ++static int iio_str_to_micro(const char *str, s64 *micro)
    ++{
    ++	int fract_mult = 100000LL;
    ++	int tmp, tmp2;
    ++	int ret = 0;
    ++
    ++	ret = iio_str_to_fixpoint(str, fract_mult, &tmp, &tmp2);
    ++	if (ret < 0)
    ++		return ret;
    ++
    ++	if (tmp < 0)
    ++		tmp2 *= -1;
    ++
    ++	*micro = (s64)tmp * 10 * fract_mult + tmp2;
    ++
    ++	return ret;
    ++}
    ++
    ++/**
    ++ * iio_test_relative_error_ppm() - Compute relative error (in ppm) between two
    ++ *                                 fixed-point strings
    ++ * @real_str: The real value as a string
    ++ * @exp_str: The expected value as a string
    ++ *
    ++ * Returns a negative error code if the strings cound not be parsed, or the
    ++ * relative error in ppm.
    ++ */
    ++static int iio_test_relative_error_ppm(const char *real_str, const char *exp_str)
    ++{
    ++	s64 real, exp, err;
    ++	int ret;
    ++
    ++	ret = iio_str_to_micro(real_str, &real);
    ++	if (ret < 0)
    ++		return ret;
    ++
    ++	ret = iio_str_to_micro(exp_str, &exp);
    ++	if (ret < 0)
    ++		return ret;
    ++
    ++	err = 1000000 * abs(exp - real);
    ++	err = div64_u64(err, abs(exp));
    ++	return (int)err;
    ++}
    ++
     +static void iio_rescale_test_scale(struct kunit *test)
     +{
     +	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
    -+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
    ++	char *buff = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
     +	struct rescale rescale;
     +	int values[2];
    ++	int rel_ppm;
     +	int ret;
     +
     +	rescale.numerator = t->numerator;
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +	values[1] = t->schan_val2;
     +
     +	ret = rescale_process_scale(&rescale, t->schan_scale_type,
    -+				&values[0], &values[1]);
    ++				    &values[0], &values[1]);
    ++
    ++	ret = iio_format_value(buff, ret, 2, values);
    ++	KUNIT_EXPECT_EQ(test, (int)strlen(buff), ret);
     +
    -+	ret = iio_format_value(buf, ret, 2, values);
    ++	rel_ppm = iio_test_relative_error_ppm(buff, t->expected);
    ++	KUNIT_EXPECT_GE_MSG(test, rel_ppm, 0, "failed to compute ppm\n");
     +
    -+	KUNIT_EXPECT_EQ(test, (int)strlen(buf), ret);
    -+	KUNIT_EXPECT_STREQ(test, buf, t->expected);
    ++	KUNIT_EXPECT_LT_MSG(test, rel_ppm, 500,
    ++			    "\t    real=%s"
    ++			    "\texpected=%s\n",
    ++			    buff, t->expected);
     +}
     +
     +static void iio_rescale_test_offset(struct kunit *test)
     +{
     +	struct rescale_tc_data *t = (struct rescale_tc_data *)test->param_value;
    -+	char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
    ++	char *buff_off = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
     +	struct rescale rescale;
     +	int values[2];
     +	int ret;
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +				     t->schan_val, t->schan_val2, t->schan_off,
     +				     &values[0], &values[1]);
     +
    -+	ret = iio_format_value(buf, ret, 2, values);
    ++	ret = iio_format_value(buff_off, ret, 2, values);
    ++	KUNIT_EXPECT_EQ(test, (int)strlen(buff_off), ret);
     +
    -+	KUNIT_EXPECT_EQ(test, (int)strlen(buf), ret);
    -+	KUNIT_EXPECT_STREQ(test, buf, t->expected_off);
    ++	KUNIT_EXPECT_STREQ(test, strim(buff_off), t->expected_off);
     +}
     +
     +static struct kunit_case iio_rescale_test_cases[] = {
 6:  2c4a31e62c31 = 11:  050487186e14 iio: afe: rescale: add RTD temperature sensor support
 7:  d1258a38d194 = 12:  f36a44a5d898 iio: afe: rescale: add temperature transducers
 8:  01fa34bf5362 = 13:  63be647fd110 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
 9:  107e61e09eec = 14:  c2f5c19dece3 dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.32.0.452.g940fe202adcb

