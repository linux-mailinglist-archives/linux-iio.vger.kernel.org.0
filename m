Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6114B3905
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 03:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiBMC5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Feb 2022 21:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiBMC5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Feb 2022 21:57:50 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2660074;
        Sat, 12 Feb 2022 18:57:45 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a19so12014106qvm.4;
        Sat, 12 Feb 2022 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HRCV6DS/62wgbPH4QXSub3KX4nTwyh+sNMdTd32Gck=;
        b=l4Ma84j0TzJAmI/oOa0VcKCxoVLbdowxAk2rYzzR19KOxb/0JsOhaMPYsTI5Z2Lw/x
         AFwC6HQidySWnuiznUJFmqgYhKYPame1rHnSTtlbNiHr5rUs9rfzwYCk1PLz95opGVf0
         ix1ekDlYdfjWQyIbvMNJeraMbPxavO8Cj+GqZQbIKuAWF4a0uIAun/V7jEN+VrkayJ4n
         r1lfDPOzwqechhtxOSInaCArl2X8H51QfwKYkJjvEncX/T6FWhG2bzezBlWKjzjLfwAT
         1TVWb9Pe8k/ax+/JnpcfxKKzGfz/Po0UoiTh7qdv/bsJR8oC4w+blaMXbC/FtQZTzKE4
         2Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HRCV6DS/62wgbPH4QXSub3KX4nTwyh+sNMdTd32Gck=;
        b=yOlgE0nd+Cn5PvUBqru3epI5ZoiUSzIndYrLLGej/+bxBIk3ywsIXlC+6tRTlRHGAm
         1MyPzLdE06xK3wK0oIikXoIIrrx68QZ4BWHeO/OMW9UBtbRUq6M4s3QIimPdJSaemjWw
         0R/msOCph63FgKsaKFkhprEquKSYFNj0c+9yyy45zs2mmOr4oE5QIziHA6Ms+4iiZVp/
         admDhHU6DuZ08gtk6in7227icUiupT3FRLbF0wpkFMC1vvLtAtEdHZiDwR2O6HWZMbSB
         sbNonV9JZOTDYb4I0dJLVLgsb7fQuxHAJqAImTFh3CLlz5PXLQqycNws+E+73zLyEwTr
         8iLg==
X-Gm-Message-State: AOAM531N0cg1pIoJLzb0G7PMoCHdWIrhetmhWDMv7VLXuj9zEeJHQ6BT
        BnYaZ8hq9hVr5P4NO3LeEvEeOLn2FdA=
X-Google-Smtp-Source: ABdhPJyBgDh+4l0roNDDtewgzmJ8Y9qwDO0hkGoVqRqjBYf2OyhqqQlTL5UvECd4QkIWJieKcDTVwg==
X-Received: by 2002:a05:6214:19cb:: with SMTP id j11mr5732402qvc.12.1644721064311;
        Sat, 12 Feb 2022 18:57:44 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:43 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 00/10] iio: afe: add temperature rescaling support
Date:   Sat, 12 Feb 2022 21:57:29 -0500
Message-Id: <20220213025739.2561834-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan, Peter, Andy,

This series focuses on adding temperature rescaling support to the IIO
Analog Front End (AFE) driver.

The main changes to the AFE driver include an initial Kunit test suite,
support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
and temperature transducer sensors.

Thanks for your time,
Liam

Changes since v14:
- Revert units.h changes in favor of "raw" values

Changes since v13:
- fix SI prefix in rescale_temp_sense_rtd_props()
- add comment explaining SI prefixes are sometimes used as mathematical
  multipliers with no particular physical meaning associated.

Changes since v12:
- rebase on latest testing branch
- fix copyright holder in newly created header file
- add myself as a copyright holder of the iio-rescale.c driver at
  Peter's suggestion
- fix undefined behavior on left-shift operation

Changes since v11:
- update commits with my personal email since all this work was done on
  my own time
- apply Peter's Reviewed-by to my local tree
- fix use of units.h
- make use of units.h more consistently in iio-rescale.c and in the
  tests
- fix #include ordering
- treat 04/16 as a fix. Move it, and add a Fixes: tag
- fix undefined behavior on left-shift operation
- add comment about fract_mult with iio_str_to_fixpoint()
- reword commit message for 14/16, based on Andy's comments

Changes since v10:
- apply Andy's suggestion for offset calculations
- make use of units.h more consistently

Changes since v9:
- make use of linux/units.h
- reorder commits, fix fract_log2 before merging fract
- keep fractional representation when not overflowing

Changes since v8:
- reword comment
- fix erroneous 64-bit division
- optimize and use 32-bit divisions when values are know to not overflow
- keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
  point
- add test cases
- use nano precision in test cases
- simplify offset calculation in rtd_props()

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

Liam Beguin (10):
  iio: afe: rescale: expose scale processing function
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: fix accuracy for small fractional scales
  iio: afe: rescale: reduce risk of integer overflow
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
 .../iio/afe/temperature-transducer.yaml       | 114 +++
 drivers/iio/afe/iio-rescale.c                 | 283 ++++++-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 710 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  36 +
 7 files changed, 1220 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v14:
 -:  ------------ >  1:  ee26b0eeac65 iio: afe: rescale: expose scale processing function
 1:  a510097c83f1 !  2:  78f9d37575a5 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ Commit message
         Reviewed-by: Peter Rosin <peda@axentia.se>
     
      ## drivers/iio/afe/iio-rescale.c ##
    -@@
    - #include <linux/of_device.h>
    - #include <linux/platform_device.h>
    - #include <linux/property.h>
    -+#include <linux/units.h>
    - 
    - #include <linux/iio/afe/rescale.h>
    - #include <linux/iio/consumer.h>
     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
      			  int *val, int *val2)
      {
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		return scale_type;
     +	case IIO_VAL_INT_PLUS_NANO:
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
    ++		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
     +
     +		/*
     +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
 2:  8f2f2699a9b4 !  3:  5be82bd72453 iio: afe: rescale: add offset support
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		*val = div_s64(tmp, scale) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_NANO:
    -+		tmp = (s64)rescale->offset * GIGA;
    -+		tmp2 = ((s64)scale * GIGA) + scale2;
    ++		tmp = (s64)rescale->offset * 1000000000LL;
    ++		tmp2 = ((s64)scale * 1000000000LL) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	case IIO_VAL_INT_PLUS_MICRO:
    -+		tmp = (s64)rescale->offset * MEGA;
    -+		tmp2 = ((s64)scale * MEGA) + scale2;
    ++		tmp = (s64)rescale->offset * 1000000LL;
    ++		tmp2 = ((s64)scale * 1000000LL) + scale2;
     +		*val = div64_s64(tmp, tmp2) + schan_off;
     +		return IIO_VAL_INT;
     +	default:
 3:  2efa970bad26 !  4:  95ec184759f6 iio: afe: rescale: fix accuracy for small fractional scales
    @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
     +		return IIO_VAL_INT_PLUS_NANO;
      	case IIO_VAL_INT_PLUS_NANO:
      	case IIO_VAL_INT_PLUS_MICRO:
    - 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
    + 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
 4:  201037c0ead8 =  5:  2e1d41ef69d9 iio: afe: rescale: reduce risk of integer overflow
 5:  a0037cc3ee90 <  -:  ------------ iio: afe: rescale: make use of units.h
 6:  f8d47728f482 !  6:  0b6c029dea1d iio: test: add basic tests for the iio-rescale driver
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +
     +#include <linux/gcd.h>
     +#include <linux/overflow.h>
    -+#include <linux/units.h>
     +
     +#include <linux/iio/afe/rescale.h>
     +#include <linux/iio/iio.h>
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +	if (tmp < 0)
     +		tmp2 *= -1;
     +
    -+	*nano = (s64)tmp * GIGA + tmp2;
    ++	*nano = (s64)tmp * 1000000000UL + tmp2;
     +
     +	return ret;
     +}
    @@ drivers/iio/test/iio-test-rescale.c (new)
     +		return -EINVAL;
     +	}
     +
    -+	err = MEGA * abs(exp - real);
    ++	err = 1000000UL * abs(exp - real);
     +
     +	return (int)div64_u64(err, abs(exp));
     +}
 7:  a04685586340 !  7:  951ea44d0f5c iio: afe: rescale: add RTD temperature sensor support
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_voltage_divider_props(struct d
     +		return ret;
     +	}
     +
    -+	tmp = r0 * iexc * alpha / MEGA;
    -+	factor = gcd(tmp, MEGA);
    -+	rescale->numerator = MEGA / factor;
    ++	tmp = r0 * iexc * alpha / 1000000;
    ++	factor = gcd(tmp, 1000000);
    ++	rescale->numerator = 1000000 / factor;
     +	rescale->denominator = tmp / factor;
     +
    -+	rescale->offset = -1 * ((r0 * iexc) / KILO);
    ++	rescale->offset = -1 * ((r0 * iexc) / 1000);
     +
     +	return 0;
     +}
 8:  e3b716aaee50 !  8:  56516fdc67bf iio: afe: rescale: add temperature transducers
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_temp_sense_rtd_props(struct de
     +		return ret;
     +	}
     +
    -+	rescale->numerator = MEGA;
    ++	rescale->numerator = 1000000;
     +	rescale->denominator = alpha * sense;
     +
     +	rescale->offset = div_s64((s64)offset * rescale->denominator,
 9:  22ae1458eb8b =  9:  8c409050990b dt-bindings: iio: afe: add bindings for temperature-sense-rtd
10:  33825ad452d6 = 10:  bb39296590f3 dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: cd717ac6f69db4953ca701c6220c7cb58e17f35a
-- 
2.35.1.4.g5d01301f2b86

