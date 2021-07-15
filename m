Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41CF3C962B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhGODP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhGODP3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2826EC06175F;
        Wed, 14 Jul 2021 20:12:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 201so3809905qkj.13;
        Wed, 14 Jul 2021 20:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkhJrswLVJIO+8urmoZXW8/LV2xKjgqG2cY2ReRL5Zk=;
        b=eIWB4b60S73qiC3CgsCMpqYfHr6pNogtYRAuZju49k0T9riqTz+li2mocTb88F9e/v
         ILQ7hxeuX/+AFxd22YEJhdA6l+Gs/YxvPGeH0+ghgtZrZblCpUHBiZaeZ+ogSmpbT94e
         U1Wls5XdxtAqsSotDn3j5hmh7mpOH9+jVy3nsVk+N5lwuYcnn/GtuswpB7nwqcSsIFRz
         BKwmX75NLaKgRyQm83378OzF/NZeijs7LsUi3wMrqAvrsemsXvmAi2QzjCpbWAM5ol+h
         9RTnhzq/Sa7xvUGdo0BOl+NTse4MUf1cvIed4kn+pCltu0//nZzxvqLUZ2+M1M7HtMA/
         Nutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kkhJrswLVJIO+8urmoZXW8/LV2xKjgqG2cY2ReRL5Zk=;
        b=KZvtXyAAdBCOWgKZnfwwR/ygG+8MAyC4vHtrp67gJgkM4Tme86CyJYKNbgKYGof+M9
         nNO6iI84WaRyvI/8tSLfmS+aVfQvhpS/+q6TrXLr/0L4sdNb1HaDGwve8EcRU9YdxrON
         SEJj/Cwvq5sqLGAmRWx6oKmdhUQr9ue4qnDTBMT85dr4wPfwLBV6MWiRsLT2Xlz/YVFx
         dpL/u3SuMjxCP5doIh295LqGyte1wAblWmeAuXsMgAS9RygalFZcF0PV7D4eR7j+2SCU
         44DUSbXX7Sn/e1PTcYYt3kqwg6DPh4BiikITwjXY6OFNvCAb16flyx4Ag/9lKRKn2gnR
         jRyA==
X-Gm-Message-State: AOAM530dheY7aGupm9gcHkVKIGSb3NXj4Md+QDuEDahSvfLFPKHboJ01
        OT2xrlnv+c78bBFDvDO38+c=
X-Google-Smtp-Source: ABdhPJwzH+tvJbShzIsSkSiCJS4NZk84h0yCal8j7/cvhofx6ZK4CMOfKx2XFJ6+NyrEEkaWX3SGEw==
X-Received: by 2002:a05:620a:4007:: with SMTP id h7mr1541085qko.76.1626318756321;
        Wed, 14 Jul 2021 20:12:36 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 00/10] iio: afe: add temperature rescaling support
Date:   Wed, 14 Jul 2021 23:12:05 -0400
Message-Id: <20210715031215.1534938-1-liambeguin@gmail.com>
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
ADCs didn't provide a scale. I tried to address this in the first two
patches.

When adding offset support to iio-rescale, I also noticed that
iio_read_channel_processed() assumes that the offset is always an
integer which I tried to address in the third patch without breaking
valid implicit truncations.

As was suggested by Jonathan [1], I started implementing Kunit tests for
some of these cases[2]. It's pretty far from being ready but it still
helped test things faster this time around!

I'll send another series with the tests once I've cleaned it up and
figured out how to avoid copying part of the driver...

[1] https://patchwork.kernel.org/project/linux-iio/patch/20210701010034.303088-5-liambeguin@gmail.com/#24290449
[2] https://git.sr.ht/~liambeguin/Linux/commit/iio-rescale-test/v1

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

Liam Beguin (10):
  iio: inkern: apply consumer scale on IIO_VAL_INT cases
  iio: inkern: apply consumer scale when no channel scale is available
  iio: inkern: make a best effort on offset calculation
  iio: afe: rescale: reduce risk of integer overflow
  iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
  iio: afe: rescale: add offset support
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++
 .../iio/afe/temperature-transducer.yaml       | 114 +++++++++++
 drivers/iio/afe/iio-rescale.c                 | 183 +++++++++++++++++-
 drivers/iio/inkern.c                          |  40 +++-
 4 files changed, 426 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

Range-diff against v4:
 -:  ------------ >  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  ed0721fb6bd1 iio: inkern: make a best effort on offset calculation
 1:  e23e6cb26b92 !  4:  7b3e374eb7ad iio: afe: rescale: reduce risk of integer overflow
    @@ Commit message
     
         Reduce the risk of integer overflow by doing the scale calculation with
         64bit integers and looking for a Greatest Common Divider for both parts
    -    of the fractional value.
    +    of the fractional value when required.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     -			*val2 *= rescale->denominator;
     +			tmp = (s64)*val * rescale->numerator;
     +			tmp2 = (s64)*val2 * rescale->denominator;
    -+			factor = gcd(tmp, tmp2);
    -+			do_div(tmp, factor);
    ++			if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
    ++			check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
    ++				factor = gcd(tmp, tmp2);
    ++				do_div(tmp, factor);
    ++				do_div(tmp2, factor);
    ++			}
     +			*val = tmp;
    -+			do_div(tmp2, factor);
     +			*val2 = tmp2;
      			return ret;
      		case IIO_VAL_INT:
 2:  28203b672942 !  5:  1d334090e974 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ Metadata
      ## Commit message ##
         iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
     
    -    Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
    -    Scale the integer part and the decimal parts individually and keep the
    -    original scaling type.
    +    Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
    +    Add support for these to allow using the iio-rescaler with them.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
      			*val = tmp;
      			return ret;
     +		case IIO_VAL_INT_PLUS_NANO:
    ++			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
    ++			do_div(tmp, rescale->denominator);
    ++
    ++			*val = div_s64(tmp, 1000000000LL);
    ++			*val2 = tmp - *val * 1000000000LL;
    ++			return ret;
     +		case IIO_VAL_INT_PLUS_MICRO:
    -+			tmp = (s64)*val * rescale->numerator;
    -+			*val = div_s64(tmp, rescale->denominator);
    -+			tmp = (s64)*val2 * rescale->numerator;
    -+			*val2 = div_s64(tmp, rescale->denominator);
    ++			tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
    ++			do_div(tmp, rescale->denominator);
    ++
    ++			*val = div_s64(tmp, 1000000LL);
    ++			*val2 = tmp - *val * 1000000LL;
     +			return ret;
      		default:
     +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
 3:  a6c944ae0f99 =  6:  61873203c140 iio: afe: rescale: add offset support
 4:  cc5eb96512d5 =  7:  4e6117b9c663 iio: afe: rescale: add RTD temperature sensor support
 5:  d8aa257aad35 =  8:  bc647d45e293 iio: afe: rescale: add temperature transducers
 6:  f038d6a08ea2 !  9:  570b418eed85 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
    @@ Commit message
         voltage across an RTD resistor such as a PT1000.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Reviewed-by: Rob Herring <robh@kernel.org>
     
      ## Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new) ##
     @@
 7:  1db42cb25254 ! 10:  3c44ea89754e dt-bindings: iio: afe: add bindings for temperature transducers
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +
     +  sense-offset-millicelsius:
     +    description: |
    -+      Temperature offset. The default is <0>.
    ++      Temperature offset.
     +      This offset is commonly used to convert from Kelvins to degrees Celsius.
     +      In that case, sense-offset-millicelsius would be set to <(-273150)>.
    ++    default: 0
     +
     +  sense-resistor-ohms:
     +    description: |
    -+      The sense resistor. Defaults to <1>.
    -+      Set sense-resistor-ohms to <1> when using a temperature to voltage
    -+      transducer.
    ++      The sense resistor.
    ++      By default sense-resistor-ohms cancels out the resistor making the
    ++      circuit behave like a temperature transducer.
    ++    default: 1
     +
     +  alpha-ppm-per-celsius:
     +    description: |
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +      datasheet.
     +
     +additionalProperties: false
    ++
     +required:
     +  - compatible
     +  - io-channels

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

