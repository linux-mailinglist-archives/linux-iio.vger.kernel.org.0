Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E83D0713
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhGUC00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhGUC0X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:23 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D5C061574;
        Tue, 20 Jul 2021 20:07:01 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id p10so295005qvk.7;
        Tue, 20 Jul 2021 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fN5CTkvQXkjw5WGSVvn50DKuHpr1wkyz+M+sBy6PMDI=;
        b=QKUTqeX8v8DvTeC01/tpLNVH/hFW8be8nZATyYUW+zXGcC4bPAFx4fuDNisvSw77pp
         nsIrjmuNudQV8GZoi+5N4N//BQ2w/nrnNCEjXS1fFSefJQ1tQ4AqedHERqbii9nFDm+W
         vn4CtZmqkZGpCJ+T2q2qOopi6CFPRJHEf5gsywwE5w1nBkQXduks8JzIxC35RGiZZi3O
         gICdwO+UDvOE48tkiiIw1yzO4Nk2bgiI20JqO6M3M5RGO1rbSuGzASvKB04BhJxMQxdT
         QmU1ZLEDIlDpgwOci2Dp1JUasl5a4ky4JfeEV9vd61SSwrczn1/Z/dFeum6XRzcdEgOl
         TbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fN5CTkvQXkjw5WGSVvn50DKuHpr1wkyz+M+sBy6PMDI=;
        b=BoA5NZy2CQyu3npYq1OMYGFg/o4T4l9elCU8m/yInMInhblrtmcU+cFgOnfq6wFV7y
         dKJCd6mKBv0uybyr+7+6FYEqJZikOpusQYShvfjEkcU0anCHyWbdZprjk37DuGiPagIy
         FEfQSfOAKjkYL9cdxGXAyk+EBtURI7TcgAhde+Wd/xEgf860DOnPb12SkUQjoRFl0VrJ
         QHnUJF3tHtHgem3+M7OGus30X44hxJ4GD92aof8qzYNnadncRYdiz/06CGuZSlUIbpOT
         CEhFCPFpIKmtBfJY0RhyajbWoDlo3oDhdljDpI9brd0GUGowi6mBmPxh2+XoXw24FMeR
         10Vw==
X-Gm-Message-State: AOAM532a9dHnim6ZnbcTVc7+GBTPkvP2auDYorRH0uvepGgTZGCamjYT
        Np7oZQTX/worjRiybIQyA3XVtRljx9hp9w==
X-Google-Smtp-Source: ABdhPJxMdocmgrApop/LEWW9vVz6cxxFNqCRal62AfFPJGKE1bZG77TeROL4P6JaQFEAB7dBOqBcAA==
X-Received: by 2002:a05:6214:dad:: with SMTP id h13mr27124807qvh.26.1626836819732;
        Tue, 20 Jul 2021 20:06:59 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:06:59 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 00/13] iio: afe: add temperature rescaling support
Date:   Tue, 20 Jul 2021 23:06:00 -0400
Message-Id: <20210721030613.3105327-1-liambeguin@gmail.com>
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
  iio: test: add basic tests for the iio-rescale driver
  iio: afe: rescale: reduce risk of integer overflow
  iio: afe: rescale: fix precision on fractional log scale
  iio: afe: rescale: add RTD temperature sensor support
  iio: afe: rescale: add temperature transducers
  dt-bindings: iio: afe: add bindings for temperature-sense-rtd
  dt-bindings: iio: afe: add bindings for temperature transducers

 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++
 .../iio/afe/temperature-transducer.yaml       | 114 ++++++
 drivers/iio/afe/iio-rescale.c                 | 242 +++++++++++--
 drivers/iio/inkern.c                          |  40 +-
 drivers/iio/test/Kconfig                      |  10 +
 drivers/iio/test/Makefile                     |   1 +
 drivers/iio/test/iio-test-rescale.c           | 342 ++++++++++++++++++
 include/linux/iio/afe/rescale.h               |  34 ++
 8 files changed, 840 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 create mode 100644 drivers/iio/test/iio-test-rescale.c
 create mode 100644 include/linux/iio/afe/rescale.h

Range-diff against v5:
 1:  7b3e374eb7ad <  -:  ------------ iio: afe: rescale: reduce risk of integer overflow
 2:  1d334090e974 <  -:  ------------ iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 -:  ------------ >  1:  42a7a1047edc iio: inkern: apply consumer scale on IIO_VAL_INT cases
 -:  ------------ >  2:  a1cd89fdad11 iio: inkern: apply consumer scale when no channel scale is available
 -:  ------------ >  3:  ed0721fb6bd1 iio: inkern: make a best effort on offset calculation
 -:  ------------ >  4:  f8fb78bb1112 iio: afe: rescale: expose scale processing function
 -:  ------------ >  5:  16627ca44022 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
 3:  61873203c140 !  6:  dec2a933fbf3 iio: afe: rescale: add offset support
    @@ Commit message
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
      ## drivers/iio/afe/iio-rescale.c ##
    -@@ drivers/iio/afe/iio-rescale.c: struct rescale {
    - 	bool chan_processed;
    - 	s32 numerator;
    - 	s32 denominator;
    -+	s32 offset;
    - };
    +@@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
    + 	}
    + }
      
    ++int rescale_process_offset(struct rescale *rescale, int scale_type,
    ++			   int scale, int scale2, int schan_off,
    ++			   int *val, int *val2)
    ++{
    ++	s64 tmp, tmp2;
    ++
    ++	switch (scale_type) {
    ++	case IIO_VAL_FRACTIONAL:
    ++		tmp = (s64)rescale->offset * scale2;
    ++		*val = div_s64(tmp, scale) + schan_off;
    ++		return IIO_VAL_INT;
    ++	case IIO_VAL_INT:
    ++		*val = div_s64(rescale->offset, scale) + schan_off;
    ++		return IIO_VAL_INT;
    ++	case IIO_VAL_FRACTIONAL_LOG2:
    ++		tmp = (s64)rescale->offset * (1 << scale2);
    ++		*val = div_s64(tmp, scale) + schan_off;
    ++		return IIO_VAL_INT;
    ++	case IIO_VAL_INT_PLUS_NANO:
    ++		tmp = (s64)rescale->offset * 1000000000;
    ++		tmp2 = ((s64)scale * 1000000000L) + scale2;
    ++		*val = div64_s64(tmp, tmp2) + schan_off;
    ++		return IIO_VAL_INT;
    ++	case IIO_VAL_INT_PLUS_MICRO:
    ++		tmp = (s64)rescale->offset * 1000000L;
    ++		tmp2 = ((s64)scale * 1000000L) + scale2;
    ++		*val = div64_s64(tmp, tmp2) + schan_off;
    ++		return IIO_VAL_INT;
    ++	default:
    ++		return -EOPNOTSUPP;
    ++	}
    ++}
    ++
      static int rescale_read_raw(struct iio_dev *indio_dev,
    -@@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio_dev,
    + 			    struct iio_chan_spec const *chan,
      			    int *val, int *val2, long mask)
      {
      	struct rescale *rescale = iio_priv(indio_dev);
     +	int scale, scale2;
     +	int schan_off = 0;
    - 	s64 tmp, tmp2;
    - 	u32 factor;
      	int ret;
    + 
    + 	switch (mask) {
     @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio_dev,
    - 			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
    - 			return -EOPNOTSUPP;
    + 			ret = iio_read_channel_scale(rescale->source, val, val2);
      		}
    + 		return rescale_process_scale(rescale, ret, val, val2);
     +	case IIO_CHAN_INFO_OFFSET:
     +		/*
     +		 * Processed channels are scaled 1-to-1 and source offset is
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_read_raw(struct iio_dev *indio
     +		}
     +
     +		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
    -+		switch (ret) {
    -+		case IIO_VAL_FRACTIONAL:
    -+			tmp = (s64)rescale->offset * scale2;
    -+			*val = div_s64(tmp, scale) + schan_off;
    -+			return IIO_VAL_INT;
    -+		case IIO_VAL_INT:
    -+			*val = div_s64(rescale->offset, scale) + schan_off;
    -+			return IIO_VAL_INT;
    -+		case IIO_VAL_FRACTIONAL_LOG2:
    -+			tmp = (s64)rescale->offset * (1 << scale2);
    -+			*val = div_s64(tmp, scale) + schan_off;
    -+			return IIO_VAL_INT;
    -+		case IIO_VAL_INT_PLUS_NANO:
    -+			tmp = (s64)rescale->offset * 1000000000UL;
    -+			tmp2 = ((s64)scale * 1000000000UL) + scale2;
    -+			*val = div_s64(tmp, tmp2) + schan_off;
    -+			return IIO_VAL_INT;
    -+		case IIO_VAL_INT_PLUS_MICRO:
    -+			tmp = (s64)rescale->offset * 1000000UL;
    -+			tmp2 = ((s64)scale * 1000000UL) + scale2;
    -+			*val = div_s64(tmp, tmp2) + schan_off;
    -+			return IIO_VAL_INT;
    -+		default:
    -+			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
    -+			return -EOPNOTSUPP;
    -+		}
    ++		return rescale_process_offset(rescale, ret, scale, scale2,
    ++					      schan_off, val, val2);
      	default:
      		return -EINVAL;
      	}
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_configure_channel(struct devic
      		BIT(IIO_CHAN_INFO_SCALE);
      
     +	if (rescale->offset)
    -+	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
    ++		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
     +
      	/*
      	 * Using .read_avail() is fringe to begin with and makes no sense
    @@ drivers/iio/afe/iio-rescale.c: static int rescale_probe(struct platform_device *
      
      	ret = rescale->cfg->props(dev, rescale);
      	if (ret)
    +
    + ## include/linux/iio/afe/rescale.h ##
    +@@ include/linux/iio/afe/rescale.h: struct rescale {
    + 	bool chan_processed;
    + 	s32 numerator;
    + 	s32 denominator;
    ++	s32 offset;
    + };
    + 
    + int rescale_process_scale(struct rescale *rescale, int scale_type,
    + 			  int *val, int *val2);
    ++int rescale_process_offset(struct rescale *rescale, int scale_type,
    ++			   int scale, int scale2, int schan_off,
    ++			   int *val, int *val2);
    + #endif /* __IIO_RESCALE_H__ */
 -:  ------------ >  7:  60bd09555300 iio: test: add basic tests for the iio-rescale driver
 -:  ------------ >  8:  f2f4af324d5d iio: afe: rescale: reduce risk of integer overflow
 -:  ------------ >  9:  4a8d77501f32 iio: afe: rescale: fix precision on fractional log scale
 4:  4e6117b9c663 = 10:  2b6e4f47c974 iio: afe: rescale: add RTD temperature sensor support
 5:  bc647d45e293 = 11:  715e1877e30f iio: afe: rescale: add temperature transducers
 6:  570b418eed85 ! 12:  0bc8546f13e5 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
    @@ Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml (new)
     +title: Temperature Sense RTD
     +
     +maintainers:
    -+  - Liam Beguin <lvb@xiphos.com>
    ++  - Liam Beguin <liambeguin@gmail.com>
     +
     +description: |
     +  RTDs (Resistance Temperature Detectors) are a kind of temperature sensors
 7:  3c44ea89754e ! 13:  4bc54afa3e94 dt-bindings: iio: afe: add bindings for temperature transducers
    @@ Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml (new)
     +title: Temperature Transducer
     +
     +maintainers:
    -+  - Liam Beguin <lvb@xiphos.com>
    ++  - Liam Beguin <liambeguin@gmail.com>
     +
     +description: |
     +  A temperature transducer is a device that converts a thermal quantity

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

