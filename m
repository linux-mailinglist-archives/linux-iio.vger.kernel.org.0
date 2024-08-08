Return-Path: <linux-iio+bounces-8329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FF94C09C
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F4EB249C4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA018EFE8;
	Thu,  8 Aug 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk0vuUOr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC918C355;
	Thu,  8 Aug 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129971; cv=none; b=brVE/6ZFhrrrJJhcdxXqKnNdJ4ethCYUJP0Bt/GSIrQdvbamF5YE9kVVVFe80evIGprMi+kFHI8sf2ZcM1PPDtoIyJGhLqgRL4WY9Oxtm7IVE9th9coJLgFqNqc58BgDABy46IrwmSOBUgLG7FEF41EiV/bQxjoEYELmbyB8pFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129971; c=relaxed/simple;
	bh=ca0M/lgnDfsmI9N2dHuUiExLnhm74NvrG+D1yePsoeY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=asz2ZV/QbYzBfx41CoNR4YSQoWMiVZftpcjuiwHYRQgwwwL/cnhOHDHF7aoB0PKC4Rv80Resa0y3x4N+HTRtGCdcxHDRMWAtPhbwMwoUQAbq13RsL2zWxLc+RrVWQeI4kqL+gsb2dYUiGTXbhCBNHS+w7eV8D1eKwUQz6zw3Tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk0vuUOr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428243f928fso11136015e9.0;
        Thu, 08 Aug 2024 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129968; x=1723734768; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KtF+zsK4gh5wBrd2V369YVuRxfiS/GTtNKOYSm0scE=;
        b=Uk0vuUOrwRS0ULwOgGVAXziLOTSAFpnyb9/9lm2xKhq+7t6C95Cty2tycTB30WFqGq
         FpwpsP6kco5Rrapb6SgcuIgpknSLYlD2m3G4VnJuRLFiIBSGZjlbQ5Yf2l5TIGn1VLVc
         AWA2YyeCBkEuoa1D8mN9D4JCjbzxOeq9i+ihMH8Q+G+V79LaR9o62lVEmpDaxL+D68Wi
         O5s6523QboR8uTKU34SeimFxDu59BCryVCUf2Xq4WO6i80cJXE5zDxfA1x3fITU8KdD4
         Pb/N0jRSzC++qYwz60xjkwWsCDU/sCsw+qV/jDgadZxuxrzrtm9JBinra4mFZHZj0+IV
         pFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129968; x=1723734768;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KtF+zsK4gh5wBrd2V369YVuRxfiS/GTtNKOYSm0scE=;
        b=wfrwfItorn0kvn5vZE0eQctLVRfWhsUxdJt2uef8Z75dNHW/t1ZqGaC/skEZIWDWhn
         lQL4lz1GbCuMfglDkS7vorYVmLzmNs/Nm0ZZ86qfQvXMRxzWO18NPCZ0J2ISGfZj36We
         XdeZ9qqDQkx7LGrmYI9fyYNpyvGXkV7zMf4TORbqro8s3PDpx1BIaexBKFoz2D1R8xe1
         fVEHdzP54509xQyYWAM6EdyvgTyXWpxcBDT1932q27yzhGE85zvpmqFocYAw46y5Os2A
         4DICWsabE3YbLs3O29e9YG9bVwoWqhsDcI5S4yUU5AlJFQs3kS6/CWw/agr9Pi6StBUt
         MLsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3iiAcles8s1JsZzfjZ05RbDM5RW+PR4GLDuNN/pvqmEALOlHaZETMyoXsHpn9I1VUxDcGAVCJDx0LaKlTtAu+yQsI7KQM0CekOptQ/C8SCo6s8vSkyjBjKVGqYaNkk5YH96DyGzJBArJvBs6plyIyUFzfOqNVcwXGsgrxqDj9vUTgMw==
X-Gm-Message-State: AOJu0YwF7bw/TyrNUSO1UBmy9bLaRCIqSmM79qPqtGb/O1FokemurGVW
	5lVB0Hv5g2Y/sqIk5kJYkK0bFZu2yvQ3ir+v+iTDNT2KxRc7KENWKpAAZb41
X-Google-Smtp-Source: AGHT+IEmQ+Wjo1pu8wA3o8BPezfHpD/QX+EMqKP6+lIS8jhtcWqtGNQnCja/XUgJv2rBNpHXvbjTIw==
X-Received: by 2002:a05:6000:1f81:b0:368:7868:2d76 with SMTP id ffacd0b85a97d-36d27590b52mr2494620f8f.51.1723129967661;
        Thu, 08 Aug 2024 08:12:47 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27157145sm2179881f8f.12.2024.08.08.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:12:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/3] use device_for_each_child_node_scoped to access
 device child nodes
Date: Thu, 08 Aug 2024 17:12:36 +0200
Message-Id: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTgtGYC/3WNzQrCMBCEX6Xs2Uiy/VF78j2klJhs2oU2kUSKU
 vruxnr2+A0z36yQKDIlaIsVIi2cOPgMeCjAjNoPJNhmBpRYyRPWwuaSod6MPNneB0u9NoZSElW
 FdVlelNSNgzx/RHL82tW3LvPI6Rnie39a1Df9Sc9S/ZcuSkhhrdOo7uQah9dh1jwdTZih27btA
 0Pd+TnAAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723129965; l=2074;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ca0M/lgnDfsmI9N2dHuUiExLnhm74NvrG+D1yePsoeY=;
 b=ghu7H7XxFXYSwhyp49247Tu3pYhOgsX5bojOozYtl1FnGKmyaJQwxZjOeLEggBHab41H902Om
 o7omPSe2nfLDlC7/I1iY+bgxjk96KWSJ8krWFeiR/pGW4xE/53ZqP5U
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series removes accesses to the device `fwnode` to iterate over its
own child nodes. Using the `device_for_each_child_node` macro provides
direct access to the device child nodes, and given that in all cases
they are only required within the loop, the scoped variant of the macro
can be used.

It has been stated in previous discussions [1] that `device_for_each_*`
should be used to access device child nodes, removing the need to access
its internal fwnode, and restricting `fwnode_for_each_*` to traversing
subnodes when required.

Note that `device_for_each_*` implies availability, which means that
after this conversion, unavailable nodes will not be accessible within
the loop. The affected drivers does not seem to have any reason to
iterate over unavailable nodes, though. But if someone has a case where
the affected drivers might require accessing unavailable nodes, please
let me know.

Link: https://lore.kernel.org/linux-hwmon/cffb5885-3cbc-480c-ab6d-4a442d1afb8a@gmail.com/ [1]
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rebase onto next-20240808, drop upstreamed patches (changes for ad7768-1)
- xilinx-ams.c: drop fwnode_device_is_available(child) (implicit in the
  loop).
- Link to v1: https://lore.kernel.org/r/20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com

---
Javier Carrasco (3):
      coresight: cti: use device_* to iterate over device child nodes
      iio: adc: xilinx-ams: use device_* to iterate over device child nodes
      leds: as3645a: use device_* to iterate over device child nodes

 drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
 drivers/iio/adc/xilinx-ams.c                         | 15 +++++----------
 drivers/leds/flash/leds-as3645a.c                    |  8 +++-----
 3 files changed, 11 insertions(+), 22 deletions(-)
---
base-commit: 222a3380f92b8791d4eeedf7cd750513ff428adf
change-id: 20240725-device_child_node_access-442533910a6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


