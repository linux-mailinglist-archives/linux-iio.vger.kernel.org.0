Return-Path: <linux-iio+bounces-18987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143EAA7396
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBA9A77C9
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF925524C;
	Fri,  2 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aWDCjKfj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C9246778
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192501; cv=none; b=eaAjRh6BhXhu+qLz6+OeU8MaqM+UO/qCf+vG2qwCYImyBEHuj2t2dtzgsXScbqxTBm8Dby5V+8sGI5O2ANeP23B6+KU7CCdpXMuyloYdty72FZ5/4HkvpMvmDIpoN3JtRCpEratScNVM3ol6JBtV6YAmgrpqfjHiiBugKEC6rmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192501; c=relaxed/simple;
	bh=qbrPqkUDgwSkcQYVdhd9p+ipQal/Codst5ae/wMd8XE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tL0PcqBaDprXqRnLOjqOum179pVlg/g40cC4WxNam9UBDPJQvPUrlBZbUXk9USorRNHYrGoJjrXhhV/d5nmzNt+yOaI5vVfMTmQTCTp44v4rxs9m32o1tBkM7x63yguLUo6f0Qz74gp0eZSVnzlkhwf2Wwj0zdfEPBm7Qc8sHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aWDCjKfj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so11914615e9.2
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746192496; x=1746797296; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc6dYzRr+WLHPKZvP88SXQhEISiGcYMlFgsD6Npr5Ik=;
        b=aWDCjKfjnNGQr9lkDJE0FT2EgWf7a6Xr9ajw7J5k5IUTPjGLq9d95VesyT/GtHeEQv
         PfxFRrTV7NED+dxMI6na7nfFCsTQdwYsvKj1MDzJszJ8EAUu5fQcTQGdJLixAZkAHL0r
         v+1gOayjV5wHgbWdgXw/2MvctLCr0ikSHxi8YMhw7ibKeTcvkYmNjTAl+YY63xld2T/p
         I2i822tXFdT8kmIZcnJwCbZM8qGVbyC45QS3IVlGVuO6cDVx7qexistS0zEfdiIv4l3W
         Fm4L3uG5K88ccRZKIRI2J1l51QTXX533MB+7wDrKsFbIU40sKrFETVoSxSHc+zGn5kkG
         3/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192496; x=1746797296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc6dYzRr+WLHPKZvP88SXQhEISiGcYMlFgsD6Npr5Ik=;
        b=ey939Xs/Psq2IQkHW0blsQzwVulCDCHeNC9xGq7FcMohp+5cnCrrj+mhGSnb73FqjA
         1BF3+Pxs3CfLnZCU476YpkNYwIu6PFzxMQU/wqhIWDoPxQxzEiAcs+1DIFWe5RwTNqZs
         /zGHQEqK/ijBUNsQ4I3CXJKMK7lNE5rpIImKMg1yoLuD/tVmZRccp2gGinAuK9LbZdcN
         bBLp65Qw8oFxx/KuaKkGv3zaXunim9DqncsMCYtbB91lSTTPPWLC5dU/E3uoOJVEsiKL
         rNA535w0idAGpfkCVaxOA2H5FUfNhTbhHxVdmF5Hr3qGEXDdgnVErpuv7Qbzf2FNNinU
         I85A==
X-Gm-Message-State: AOJu0YyyobDJncTdZo4MVyJNTV49LEeyzfJW1buJSuWg0Fi6GNJaa2Rn
	gALaGMR5j7J+5zvyw1QtQsg8HdeIcVESkkQibbL4ycaRCcm495UBvRhHK4E60as=
X-Gm-Gg: ASbGncslSnHQZGSUGqSMP5HIpQth/a63qO+Rk9WZaebZXKFPwtdfBPeXEqJdYxOqtN1
	8Y7WCCIVhFTaTDGlkmsQqhgDV/IIZ4wjyeHRueNAxbyJ8KdfsucIMS9eqtVAba6RRib3kx2UH7E
	RAVDEWeZmSr8IN9XBvGnKy7KH3LFsXqhAARS0jYEgAz6SFWcFAwueTVL8x5a3jhS1Yp4kK6zWly
	wMqSR4qrLLEXesh30AjJp06vI/7F6GeU5BFmtIJ6gqDEU9ZzYWO4zdE+D+hR2rZJ3PEA67u5XrU
	BSF/oSD0kw4nFmdfWAZBtjsDA5AzetAmwapjoAXLFRET
X-Google-Smtp-Source: AGHT+IGKCVL7KbLY8bvxzJab5K/pyhT17TTUTeyPO1FDr69xAKZBIDvzYRHwNZgAcFOaUN4Vif30vA==
X-Received: by 2002:a05:600c:3485:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-441bbf37f1fmr29539265e9.30.1746192495894;
        Fri, 02 May 2025 06:28:15 -0700 (PDT)
Received: from [192.168.0.2] ([87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm45761065e9.8.2025.05.02.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:28:14 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v2 0/5] iio: adc: add ad7606 calibration support
Date: Fri, 02 May 2025 15:26:57 +0200
Message-Id: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHIFGgC/42NQQ6CMBBFr0Jm7Zh2gCKsvIdhMYUqkyCQlqCEc
 HcLJ3D5/s/7f4PgvLgAVbKBd4sEGYcIdEmg6Xh4OZQ2MpCiXGVU4kcmtD1yWxhlsOFerOc5Wki
 K09KwUWlOEP3Ju6d8z+1HHbmTMI9+Pa8WfaT/rC4aFTqbtdmNtNUF3S2vR+2uzfiGet/3H8FSm
 tjFAAAA
X-Change-ID: 20250429-wip-bl-ad7606-calibration-20a396a60352
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=qbrPqkUDgwSkcQYVdhd9p+ipQal/Codst5ae/wMd8XE=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOaGuE9Vtbelc7C6u/ULVYaEy5zL1MoOfFxf0XNfcU
 rk7Qqq0o5SFQYyLQVZMkaUuMcIk9HaolPICxtkwc1iZQIYwcHEKwETkJjMy7PzkJ3E9/1evwxy5
 O8s9vHXuKNR1pKW8qj5078V31657Hxn+yt7cUx56Xjhat7zlyNIY344ZO/VfqUw9al55eua+U7o
 XWQA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add gain, offset and phase (as a delay) calibration support, for
ad7606b, ad7606c16 and ad7606c18.

Calibration is available for devices with software mode capability. 

Offset and phase calibration is configurable by sysfs attributes, while
gain calibration value in ohms must match the external RFilter value,
when an external RFilter is available, so implemented through a specific
devicetree "adi,rfilter-ohms" property.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- change phase_delay to calib_delay,
- fix dt_bindings,
- fix gain calibarion fdt parsing,
- fix ad7606c-18 calib offset range,
- fix calib offset calculation,
- fix calib gain range,
- Link to v1: https://lore.kernel.org/r/20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com

---
Angelo Dureghello (5):
      Documentation: ABI: IIO: add calibconv_delay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  20 ++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 +++
 drivers/iio/adc/ad7606.c                           | 217 +++++++++++++++++++++
 drivers/iio/adc/ad7606.h                           |  13 ++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 281 insertions(+)
---
base-commit: e22e3d5089987cb4250801623026992b2ba4645d
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


