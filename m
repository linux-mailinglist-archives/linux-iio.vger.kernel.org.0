Return-Path: <linux-iio+bounces-23938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F03ABB51CAD
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CC1188C69B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0432ED23;
	Wed, 10 Sep 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wae7y6si"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981032BF40
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519892; cv=none; b=cQ96R1Lrlyc+QDYMTgtaD0LSTZmd1TyJIbPplQtL4GZwzxYKpvupWfa+znozUlGj3RGMyR9I3x6Rf7HCfyRUPt39pS44KmOifg6d0VPOvBLo71N5lIo0RkdSMRsCSI8drMzMvQlJ75sXzpmxVXEe/rA9WIablS1xDv45KNZ94cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519892; c=relaxed/simple;
	bh=0OXy0pIlk1rrTtpMa3bUiDD9A6fnxy7GK4ztvEBXy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyKs+qrPR4FRvi6yssn4ZVJULomEXdVKXpuJWMmRMHagjz7Lp/VseLdReJ7nbNsq8S2gJ2GhkMZMtJOoRIpElH2urM3DBQFJbJYFyMThI7ikOnzcse5IRxGps57TLB44f17UaZtKiWCjdTNXJsplZ/cnu0sEsNFjhS3+BdShhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wae7y6si; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e7512c8669so1538398f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757519889; x=1758124689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ6CTb9QgukTBV6bS9gxx7JwKyJl+T8wYIdJWg2p/8g=;
        b=wae7y6si1VBXkptU5+3lrvpOAFWKnRnsgnzI9bC7CTWms/wbYzebfs0OGaId6vbFM2
         Genj9Nv5rFGhBfJqA9KPOWAgWDlHdl5YD7AY6YGpnVe817DqJlJ88u5YdtAnkQCJepQ7
         dLDJqinLSS+tUBU8oL/kBomRV7caxRJ0H6QQSnZPpKK7lDZFHB9M3e3GY1TVs2je6PJn
         a1SikCox5MKCnd6giCjcwFkyxCzqgVwksqH80/B8t2Jh+Lrnxcp9SgAKxx+48ycw062V
         pUHEYRkiNwbE4mNIPoGnJS/jRxTGV+ysXKD9ym+GO9nrwtquYuOMxEsIDeW5QAGshyzy
         PbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519889; x=1758124689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ6CTb9QgukTBV6bS9gxx7JwKyJl+T8wYIdJWg2p/8g=;
        b=OqoSNdkab6f+SuRay9Q01Lf+MRojo9PWxGt5IlmthHhPgF3lfQkFECvwySpN4ktiYA
         UySrm+/gIXR472fcQp66DZJ0yAOHC2+4LLld+SarRgESzV8YYpum8GRbtmB0b+pEjvb7
         6vMBFB20pzrlEZ2huqkHLdZAqAie851u4Uex93AlSivdSWG5wFv1sgiCpOalZk88aRWZ
         eUKjJq1UjMaDqEbXGT4Ips2WdvrB8VXYsfn/+XzJ2kETXieTy2mFUQdU4q16iEhnrryn
         bkfhhIUlNnCfK979xiGFlwDR2oJoXJ02YLl6sXfBOGtYmQiXWcBuG5IHr2rlcmT7IEzn
         4QcQ==
X-Gm-Message-State: AOJu0Ywd1FXYGZuQkqoo5wgTzwdFNxvp2CPgxaDDg56Hadma/qeela4S
	eappfGdALlrw6sUD0079jXILH0qQjZyzqPFV7FKdfV62oge3q36z3eHuJcnm1p0WEaQ=
X-Gm-Gg: ASbGncvS5bPrcGuPaNcDKtNZlZYW5f38mdgyAGjZO/Yy5n0k4Bn7XH1h81PUr+dG4ih
	7jfFwy9Jzddz/J8VtDNuo0JTfhz9NCkymdAUxeF/dtk5jjK2uUxpwn1X40NcaHf09jXRXoRE7Pq
	JsmkqqrMs5oPVd27uUGDcrXrQPUTlXOlQQv7M6z6qof6zUNzypQ0mjpGB7DNs/Zy+McrIdZJ7P9
	aRqtiJlnyNCYS+wU7pRbLx/NQ+TgxTRmibpxFtUv855mh+Qw8BdnJg8xIBEPlDdTYc+Qu3b/MFj
	LN3WmUAzRK5kRLx2iWaC3lu5pxpJhnWmA+1inW9IFLHWd7/G0QyJM/R4Sm+VglAF/oXlbFnRrpk
	NF19Sw7J2mRYc3u6EaH/AdMK4uQDBYPhGd6pQQ+uTZ94=
X-Google-Smtp-Source: AGHT+IGxtk8aUU60lUW/tWlArM0SdaxDZo6GGAqsTWAWeM6Yie0aGFijwOZEXm4dntS9JpH0TcFNHA==
X-Received: by 2002:a05:6000:24c1:b0:3e2:ac0:8c55 with SMTP id ffacd0b85a97d-3e643c1a48cmr13871860f8f.55.1757519889267;
        Wed, 10 Sep 2025 08:58:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea3csm7490325f8f.49.2025.09.10.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:58:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed, 10 Sep 2025 17:57:54 +0200
Message-ID: <20250910155759.75380-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 platforms have a couple of successive
approximation register (SAR) ADCs with eight channels and 12-bit
resolution. These changes provide the driver support for these ADCs
and the bindings describing them.

The driver is derived from the BSP driver version. It has been partly
rewritten to conform to upstream criteria.

https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c

After the V1 posting there were some discussions around the DMA code
to be converted to use the IIO DMA API [1]. Unfortunately this one is
not yet fully implemented and merged in the framework to support the
cyclic DMA. The current DMA code in the driver has been used in
production since several years and even if I agree it can be improved
with a dedicated IIO DMA API in the future, IMO, it sounds reasonable
to keep it as is until the IIO DMA API supporting the cyclic DMA is
merged. I'll be glad to convert the driver code if such an API exists
and allows to remove code inside the driver.

[1] https://lore.kernel.org/all/c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com/

Changelog:
	* V2:
	  - Massaged the cover letter changelog to explain the DMA
	  ** Andriy Shevchenko **
	  - Added missing headers and use proper header for of.h
	  - Changed macro offset zero to be consistent
	  - Remove macros REG_ADC_MCR_NRSMPL_* as they are unused
	  - Changed delays macro under the form 100000 => 100 * USEC_PER_MSEC
	  - Replaced PAGE_SIZE by a NXP_PAGE_SIZE = SZ_4K macro
	  - Replaced read_poll_timeout() by readl_poll_timeout()
	  - Changed error pattern "error first"
	  - Replaced variable type 'int' to 'unsigned int'
	  - Fixed bug right instead of left shift, use BIT(channel)
	  - Returned directly from switch-case
	  - Used guard(spinlock_irqsave)()
	  - One liner function call
	  - Remove redundant {}
	  - Write default values litterals instead of temporary variables
	  - Changed variable name vref -> vref_mV
	  - Removed unneeded error message
	  - Used dev_err_probe() consistently
	  - Removed successful driver probe message
	  - Removed redundant blank line

	  ** Nuno Sa **
	  - Replaced of_device_get_match_data() by device_get_match_data()
	  - Removed iio_device_unregister() because devm_iio_device_register() is used
	  - Removed "/* sentinel */" comment
	  - Removed CONFIG_PM_SLEEP defiries

	  ** Krzysztof Kozlowski / David Lechner **
	  - Removed clock-names in DT bindings
	  - Fixed minItems by maxItems

	* V1:
	  - Initial post

Daniel Lezcano (2):
  dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
  iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   63 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1026 +++++++++++++++++
 4 files changed, 1103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


