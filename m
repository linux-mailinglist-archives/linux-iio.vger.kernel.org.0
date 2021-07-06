Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC323BDB13
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGFQMk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGFQMa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B00EC061574;
        Tue,  6 Jul 2021 09:09:50 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w13so14824097qtc.0;
        Tue, 06 Jul 2021 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kqT32/5c/ZxywbX7jV+5ehOOW0Fuzi3oVM2IO0aUmI=;
        b=KQP1UBBkZLo47IG0mW68Sm9hK/FCHaEOkZcvRl8Mkqk2h49OInqcpOxq6DZd9PsC2M
         /JDizXgg8WD4oE/xogaplVohuI42mLvnM+IO+KrcZB6x5E0UV0anuheUTaKek49Tz3mx
         2vEHNgju+J1r3ktvYoEVlIXvh+yqiOfmbPdL8RJlT/shtDUTYon3fNQaY3l38zLblc49
         DmVO2s3LgJ9BjMDd51cBHMJZauB9YMwD6saCXpccBkIsI6FXHdE3BsOxo2+MbClZzNVo
         dfFG3/vTNpsGbiTBTQwFuAf6BKcvXaaTsr5jM8hAayMHhRxaEjEJ+OlymXlhZC29PkVS
         DHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1kqT32/5c/ZxywbX7jV+5ehOOW0Fuzi3oVM2IO0aUmI=;
        b=nmk5oHF+JlzCEPBS0J+7zBjDDx0tcKOODixHWonRfftbO/sysAKoJhtdS4FTePUpnX
         o+wbKx66epwqOOnPGHw8Rbl8b5GPZEmSOaCHKxU7kXtHMXa6tIcvcaFV4RKW3fyg6V1X
         V7x84j2mhYMBL1P1W92WSDREVaAhLgZwvaK1X9SWiJjIkEjqkRW9EoXQzw4jTJ5CHQ07
         58e7hPvFblJm1ch0hflfCoDgo+jyTy2GRcny7BYSpe3F+NaMGF/cQs53/sFZkM2ziLXX
         XG6fpvANDH7yC60ROFraGqfDZoipt2o0q8ESmk1TTSHdzPw4jQyfeVk5dO6HlQQsQoEz
         V/RQ==
X-Gm-Message-State: AOAM531WMNww/beKyE5iuINfIIU+ITkPhxfqtQcBmdCTTFV+OthXIZbV
        AKDzTfZHiY28QJILDedZIOE=
X-Google-Smtp-Source: ABdhPJxKPXUuUGCvAXdHxQCZ0GJczCmu4ZmYrg/MpBYSdqT+IMkUvNzNtwhZ49hzTkaG5sElBrD99A==
X-Received: by 2002:ac8:4799:: with SMTP id k25mr2361973qtq.333.1625587789031;
        Tue, 06 Jul 2021 09:09:49 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:48 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 00/10] iio: afe: add temperature rescaling support
Date:   Tue,  6 Jul 2021 12:09:32 -0400
Message-Id: <20210706160942.3181474-1-liambeguin@gmail.com>
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

Related to: https://patchwork.kernel.org/project/linux-iio/list/?series=483087

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
 .../iio/afe/temperature-transducer.yaml       | 111 +++++++++++
 drivers/iio/afe/iio-rescale.c                 | 173 +++++++++++++++++-
 drivers/iio/inkern.c                          |  40 +++-
 4 files changed, 413 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

Range-diff against v3:
 -:  ------------ >  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 1:  e74ff6b2f663 !  3:  ed0721fb6bd1 iio: inkern: make a best effort on offset calculation
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +	int offset_type, offset_val, offset_val2;
      	s64 raw64 = raw;
     -	int ret;
    -+	int tmp;
      
     -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
     -	if (ret >= 0)
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +		case IIO_VAL_INT:
     +			break;
     +		case IIO_VAL_INT_PLUS_MICRO:
    -+			fallthrough;
     +		case IIO_VAL_INT_PLUS_NANO:
     +			/*
     +			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +			 */
     +			break;
     +		case IIO_VAL_FRACTIONAL:
    -+			tmp = offset_val / offset_val2;
    -+			offset_val = tmp;
    ++			offset_val /= offset_val2;
     +			break;
     +		case IIO_VAL_FRACTIONAL_LOG2:
    -+			tmp = offset_val / (1 << offset_val2);
    -+			offset_val = tmp;
    ++			offset_val /= (1 << offset_val2);
     +			break;
     +		default:
     +			return -EINVAL;
 2:  a5696ca3c14f !  4:  e23e6cb26b92 iio: afe: rescale: reduce risk of integer overflow
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     +			tmp = (s64)*val * rescale->numerator;
     +			tmp2 = (s64)*val2 * rescale->denominator;
     +			factor = gcd(tmp, tmp2);
    -+			*val = tmp / factor;
    -+			*val2 = tmp2 / factor;
    ++			do_div(tmp, factor);
    ++			*val = tmp;
    ++			do_div(tmp2, factor);
    ++			*val2 = tmp2;
      			return ret;
      		case IIO_VAL_INT:
      			*val *= rescale->numerator;
 3:  2b435a2f58e8 !  5:  28203b672942 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
      			*val = tmp;
      			return ret;
     +		case IIO_VAL_INT_PLUS_NANO:
    -+			fallthrough;
     +		case IIO_VAL_INT_PLUS_MICRO:
     +			tmp = (s64)*val * rescale->numerator;
     +			*val = div_s64(tmp, rescale->denominator);
 4:  577020b8326b !  6:  a6c944ae0f99 iio: afe: rescale: add offset support
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     +		 * Processed channels are scaled 1-to-1 and source offset is
     +		 * already taken into account.
     +		 *
    -+		 * In other cases, the final offset value is defined by:
    ++		 * In other cases, real world measurement are expressed as:
    ++		 *
    ++		 *	schan_scale * (raw + schan_offset)
    ++		 *
    ++		 * Given that the rescaler parameters are applied recursively:
    ++		 *
    ++		 *	rescaler_scale * (schan_scale * (raw + schan_offset) +
    ++		 *		rescaler_offset)
    ++		 *
    ++		 * Or,
    ++		 *
    ++		 *	(rescaler_scale * schan_scale) * (raw +
    ++		 *		(schan_offset +	rescaler_offset / schan_scale)
    ++		 *
    ++		 * Thus, reusing the original expression the parameters exposed
    ++		 * to userspace are:
    ++		 *
    ++		 *	scale = schan_scale * rescaler_scale
     +		 *	offset = schan_offset + rescaler_offset / schan_scale
     +		 */
     +		if (rescale->chan_processed) {
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     +					 IIO_CHAN_INFO_OFFSET)) {
     +			ret = iio_read_channel_offset(rescale->source,
     +						      &schan_off, NULL);
    -+			if (ret < 0)
    -+				return ret;
    -+			else if (ret != IIO_VAL_INT)
    -+				return -EOPNOTSUPP;
    ++			if (ret != IIO_VAL_INT)
    ++				return ret < 0 ? ret : -EOPNOTSUPP;
     +		}
     +
     +		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     +		case IIO_VAL_INT_PLUS_NANO:
     +			tmp = (s64)rescale->offset * 1000000000UL;
     +			tmp2 = ((s64)scale * 1000000000UL) + scale2;
    -+			factor = gcd(tmp, tmp2);
    -+			tmp /= factor;
    -+			tmp2 /= factor;
     +			*val = div_s64(tmp, tmp2) + schan_off;
     +			return IIO_VAL_INT;
     +		case IIO_VAL_INT_PLUS_MICRO:
     +			tmp = (s64)rescale->offset * 1000000UL;
     +			tmp2 = ((s64)scale * 1000000UL) + scale2;
    -+			factor = gcd(tmp, tmp2);
    -+			tmp /= factor;
    -+			tmp2 /= factor;
     +			*val = div_s64(tmp, tmp2) + schan_off;
     +			return IIO_VAL_INT;
     +		default:
 5:  0add5863ff00 =  7:  cc5eb96512d5 iio: afe: rescale: add RTD temperature sensor support
 6:  0306e16020d4 =  8:  d8aa257aad35 iio: afe: rescale: add temperature transducers
 7:  6906c5a21861 !  9:  f038d6a08ea2 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new)
     +      Channel node of a voltage io-channel.
     +
     +  '#io-channel-cells':
    -+    const: 1
    ++    const: 0
     +
     +  excitation-current-microamp:
     +    description: The current fed through the RTD sensor.
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new)
     +  - |
     +    pt1000_1: temperature-sensor0 {
     +        compatible = "temperature-sense-rtd";
    -+        #io-channel-cells = <1>;
    ++        #io-channel-cells = <0>;
     +        io-channels = <&temp_adc1 0>;
     +
     +        excitation-current-microamp = <1000>; /* i = U/R = 5 / 5000 */
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new)
     +        r-naught-ohms = <1000>;
     +    };
     +...
    -
    - ## MAINTAINERS ##
    -@@ MAINTAINERS: F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
    - F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
    - F:	drivers/iio/afe/iio-rescale.c
    - 
    -+IIO UNIT CONVERTER (TEMPERATURE)
    -+M:	Liam Beguin <liambeguin@gmail.com>
    -+R:	Peter Rosin <peda@axentia.se>
    -+L:	linux-iio@vger.kernel.org
    -+S:	Maintained
    -+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
    -+
    - IKANOS/ADI EAGLE ADSL USB DRIVER
    - M:	Matthieu Castet <castet.matthieu@free.fr>
    - M:	Stanislaw Gruszka <stf_xl@wp.pl>
 8:  ac8d4eef179b ! 10:  1db42cb25254 dt-bindings: iio: afe: add bindings for temperature transducers
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +      Channel node of a voltage io-channel.
     +
     +  '#io-channel-cells':
    -+    const: 1
    ++    const: 0
     +
     +  sense-offset-millicelsius:
     +    description: |
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +  - |
     +    ad950: temperature-sensor-0 {
     +        compatible = "temperature-transducer";
    -+        #io-channel-cells = <1>;
    ++        #io-channel-cells = <0>;
     +        io-channels = <&temp_adc 3>;
     +
     +        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +  - |
     +    znq_tmp: temperature-sensor-1 {
     +        compatible = "temperature-transducer";
    -+        #io-channel-cells = <1>;
    ++        #io-channel-cells = <0>;
     +        io-channels = <&temp_adc 2>;
     +
     +        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
     +        alpha-ppm-per-celsius = <4000>; /* 4 mV/K */
     +    };
     +...
    -
    - ## MAINTAINERS ##
    -@@ MAINTAINERS: R:	Peter Rosin <peda@axentia.se>
    - L:	linux-iio@vger.kernel.org
    - S:	Maintained
    - F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
    -+F:	Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
    - 
    - IKANOS/ADI EAGLE ADSL USB DRIVER
    - M:	Matthieu Castet <castet.matthieu@free.fr>

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

