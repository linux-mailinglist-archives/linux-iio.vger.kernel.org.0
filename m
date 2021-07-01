Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F763B8B81
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhGABDX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhGABDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EE4C0617A8;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j14so2138431qvu.6;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbDfZozObI/RLzFxxZO5jRP/LNwXBS0TE70JwFVMSgE=;
        b=PlOZmrxvjKaWD80nxE76Gw0QhZg1lrLkH/7mGXseTE01wyneXkEcGCLwnrFWKuD2hK
         qMkI4aO8MT1mS1EUwzLgpVbQxeKjtWL723+frQUp8AfJ1aLsV6DnwbfHoVaCa6lWh+Co
         ieaSV9ZVnFYrgt9obFIVlXrMWG/p/IMtMeZKTSUP2DQKk7/VnmJK6xpVZEPtJF38td90
         Bk3EjMe6BpmPKSvnA5k5vMRXe5clfxZ/tagk2lw/+TqwwSa04892z49cfP8S5+DEcumS
         4B3xO+r9saD2+0JRgEukMBk2WkxsQy3kVNsUZjPOjGEzaZbp/oJuNASn1x2bnEY2125e
         5eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbDfZozObI/RLzFxxZO5jRP/LNwXBS0TE70JwFVMSgE=;
        b=UF0VGDnriKR/mjPI/Ps/a5yq+zsatX7py5pbUqALtjjjxzu3asIRvIyBND+b4Xp3Rz
         0U2v/lVmkm5TuASgVlefU47z9DCEZ8LykztuFwYvAQMEk1GjslcPlugBJint/r2o2jbn
         K10PLjd2LaGgRi6t2EVWfu8Ueu0roMuYy+gxhAb8hiCQ/CBJTkEEVUlECYZlsspitSq4
         BlG1rQ9RPaiEQXOfpEVM3X8LCMN6JSGumaFn1qkE9bRIXtnOOPqCllOJulNV75Fc+I5C
         md17B/f+S+C3wUJEFB/R3MsCUHySSrrQqQfupoRCSifyPVcvQADLWHYRKMReAJJ0oxRD
         TPIg==
X-Gm-Message-State: AOAM530iMs7mAhE/sxYiLh1xEPImfsQ0iO9uIM9LsqRr1qt0HuETCgbN
        1hipHUoaL9EsRPclf3ht708=
X-Google-Smtp-Source: ABdhPJxkKFDCt1/qnBgRagfoVmuoI0vuvJj9ZpV1adZElzyuKS2g8c4Dce19QhqlD/yJQxnt+9DgLA==
X-Received: by 2002:ad4:4bc6:: with SMTP id l6mr16075419qvw.42.1625101246192;
        Wed, 30 Jun 2021 18:00:46 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:45 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 00/10] iio: afe: add temperature rescaling support
Date:   Wed, 30 Jun 2021 21:00:24 -0400
Message-Id: <20210701010034.303088-1-liambeguin@gmail.com>
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

 .../iio/afe/temperature-sense-rtd.yaml        | 101 +++++++++++
 .../iio/afe/temperature-transducer.yaml       | 111 ++++++++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/afe/iio-rescale.c                 | 163 +++++++++++++++++-
 drivers/iio/inkern.c                          |  44 ++++-
 5 files changed, 415 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

Range-diff against v2:
 1:  eb81d6b5ed88 =  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 2:  d132d86c0dd2 =  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 3:  7a659ccc5d7b !  3:  e74ff6b2f663 iio: inkern: error out on unsupported offset type
    @@ Metadata
     Author: Liam Beguin <liambeguin@gmail.com>
     
      ## Commit message ##
    -    iio: inkern: error out on unsupported offset type
    +    iio: inkern: make a best effort on offset calculation
     
         iio_convert_raw_to_processed_unlocked() assumes the offset is an
    -    integer.
    -    Make that clear to the consumer by returning an error on unsupported
    -    offset types without breaking valid implicit truncations.
    +    integer. Make a best effort to get a valid offset value for fractional
    +    cases without breaking implicit truncations.
     
    +    Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
      ## drivers/iio/inkern.c ##
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +	int offset_type, offset_val, offset_val2;
      	s64 raw64 = raw;
     -	int ret;
    ++	int tmp;
      
     -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
     -	if (ret >= 0)
    @@ drivers/iio/inkern.c: EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
     +		case IIO_VAL_INT:
     +			break;
     +		case IIO_VAL_INT_PLUS_MICRO:
    -+			if (offset_val2 > 1000)
    -+				return -EINVAL;
    -+			break;
    ++			fallthrough;
     +		case IIO_VAL_INT_PLUS_NANO:
    -+			if (offset_val2 > 1000000)
    -+				return -EINVAL;
    ++			/*
    ++			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
    ++			 * implicitely truncate the offset to it's integer form.
    ++			 */
    ++			break;
     +		case IIO_VAL_FRACTIONAL:
    -+			if (offset_val2 != 1)
    -+				return -EINVAL;
    ++			tmp = offset_val / offset_val2;
    ++			offset_val = tmp;
     +			break;
     +		case IIO_VAL_FRACTIONAL_LOG2:
    -+			if (offset_val2)
    -+				return -EINVAL;
    ++			tmp = offset_val / (1 << offset_val2);
    ++			offset_val = tmp;
     +			break;
     +		default:
     +			return -EINVAL;
 4:  272d29f21eac <  -:  ------------ iio: inkern: return valid type on raw to processed conversion
 5:  ab38421fbae2 <  -:  ------------ iio: afe: rescale: add upstream offset support
 -:  ------------ >  4:  a5696ca3c14f iio: afe: rescale: reduce risk of integer overflow
 -:  ------------ >  5:  2b435a2f58e8 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 6:  59e93788dd28 !  6:  577020b8326b iio: afe: rescale: add offset support
    @@ drivers/iio/afe/iio-rescale.c: struct rescale {
      
      static int rescale_read_raw(struct iio_dev *indio_dev,
     @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio_dev,
    - 		default:
    + 			    int *val, int *val2, long mask)
    + {
    + 	struct rescale *rescale = iio_priv(indio_dev);
    ++	int scale, scale2;
    ++	int schan_off = 0;
    + 	s64 tmp, tmp2;
    + 	u32 factor;
    + 	int ret;
    +@@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio_dev,
    + 			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
      			return -EOPNOTSUPP;
      		}
     +	case IIO_CHAN_INFO_OFFSET:
    -+		*val = rescale->offset;
    ++		/*
    ++		 * Processed channels are scaled 1-to-1 and source offset is
    ++		 * already taken into account.
    ++		 *
    ++		 * In other cases, the final offset value is defined by:
    ++		 *	offset = schan_offset + rescaler_offset / schan_scale
    ++		 */
    ++		if (rescale->chan_processed) {
    ++			*val = rescale->offset;
    ++			return IIO_VAL_INT;
    ++		}
    ++
    ++		if (iio_channel_has_info(rescale->source->channel,
    ++					 IIO_CHAN_INFO_OFFSET)) {
    ++			ret = iio_read_channel_offset(rescale->source,
    ++						      &schan_off, NULL);
    ++			if (ret < 0)
    ++				return ret;
    ++			else if (ret != IIO_VAL_INT)
    ++				return -EOPNOTSUPP;
    ++		}
     +
    -+		return IIO_VAL_INT;
    ++		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
    ++		switch (ret) {
    ++		case IIO_VAL_FRACTIONAL:
    ++			tmp = (s64)rescale->offset * scale2;
    ++			*val = div_s64(tmp, scale) + schan_off;
    ++			return IIO_VAL_INT;
    ++		case IIO_VAL_INT:
    ++			*val = div_s64(rescale->offset, scale) + schan_off;
    ++			return IIO_VAL_INT;
    ++		case IIO_VAL_FRACTIONAL_LOG2:
    ++			tmp = (s64)rescale->offset * (1 << scale2);
    ++			*val = div_s64(tmp, scale) + schan_off;
    ++			return IIO_VAL_INT;
    ++		case IIO_VAL_INT_PLUS_NANO:
    ++			tmp = (s64)rescale->offset * 1000000000UL;
    ++			tmp2 = ((s64)scale * 1000000000UL) + scale2;
    ++			factor = gcd(tmp, tmp2);
    ++			tmp /= factor;
    ++			tmp2 /= factor;
    ++			*val = div_s64(tmp, tmp2) + schan_off;
    ++			return IIO_VAL_INT;
    ++		case IIO_VAL_INT_PLUS_MICRO:
    ++			tmp = (s64)rescale->offset * 1000000UL;
    ++			tmp2 = ((s64)scale * 1000000UL) + scale2;
    ++			factor = gcd(tmp, tmp2);
    ++			tmp /= factor;
    ++			tmp2 /= factor;
    ++			*val = div_s64(tmp, tmp2) + schan_off;
    ++			return IIO_VAL_INT;
    ++		default:
    ++			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
    ++			return -EOPNOTSUPP;
    ++		}
      	default:
      		return -EINVAL;
      	}
 7:  b413cb4f190b <  -:  ------------ iio: afe: rescale: add temperature sensor support
 8:  3f6564f5a346 <  -:  ------------ dt-bindings: iio: afe: add binding for temperature-sense-amplifier
 -:  ------------ >  7:  0add5863ff00 iio: afe: rescale: add RTD temperature sensor support
 -:  ------------ >  8:  0306e16020d4 iio: afe: rescale: add temperature transducers
 -:  ------------ >  9:  6906c5a21861 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
 -:  ------------ > 10:  ac8d4eef179b dt-bindings: iio: afe: add bindings for temperature transducers

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

