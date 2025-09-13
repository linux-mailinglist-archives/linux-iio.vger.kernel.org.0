Return-Path: <linux-iio+bounces-24067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C5B561E1
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B880417F9FB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255C2F3634;
	Sat, 13 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="dgZnVUzd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A28261B78;
	Sat, 13 Sep 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778015; cv=none; b=kV/WI+3ocKqzJgDa2vNXlQhU96BkiJCpeWKXYAsW8zOpRjig6P5ngbHGUM+XPDD10awcs3zlvKAnIgxwtm+dMvIFgQMPV89iNuzcmGPEfW9Q2AKe0ULRqt+BsgKsobn/EZoGrGReZpXY1xdbJXLyM+s5SvwaTHiPmt2QTyCXRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778015; c=relaxed/simple;
	bh=ZjQlujz+dTmeks6So5/AUz9N0e0nT7HBHjX8jna68iw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WhKBaZpowUzjLK0AnMRFBirMJwFPizWSvlITaabf/Lv7iFh55T4Yjd0+HEnUrAb3FiazlH/WNeLTkssiF99WINXiDaoLgvyIglMj2OnaPIRa6Lv2fO40gIUISxKIw7AkYGfHLQahTtwcvpFCUwH70WNlrsfywyxKfPBtmTwZJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=dgZnVUzd; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 940A3173BE2;
	Sat, 13 Sep 2025 18:40:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YuJlTEq4iC9diOhjtHSyJ6vfDj4XlHO7Wzpl6BnpBpM=;
	b=dgZnVUzdvxbccYkIs8pzVvpujITAXfm1VuhTVLgOGAS3kAFvTrx+ML5n/O64VNjq8SEke7
	/z6sW27Dm3Dx9cYvOkYw2Ful/refaNDkUYI4A1p/72fP4XpIlpATAj6QXPCTWB9zwISER/
	DyBdoZOhU3M4Ol0QnxgW+m/p99e6r5gdagBjR69JQYFzVE0+s0cKb7r61OHeD8AW8q5/ru
	LuwQgwy8cKFMhdh7VuLv1Bd/1tOJey375b39+EQF68AY4XYEaQT1p7fnp6UAlBTtGneB5F
	pCtDEWt0q/lUD/vEIURFnIfWkfknBjqRo5tIctybu75sk1DTrwnDKJGozU55Eg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v3 00/18] iio: accel: bma220 improvements
Date: Sat, 13 Sep 2025 18:39:21 +0300
Message-Id: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmQxWgC/x2MQQqAIBAAvxJ7TjCtQ30lItzcag9qaEgg/T3pO
 DAzBRJFpgRTUyBS5sTBV9BtA9tp/EGCbWVQUg1y7LTAXqAzSsmV3RVDJkf+TsJYidru1UKEGl+
 Rdn7+8by87weU3ylQaAAAAA==
X-Change-ID: 20250913-b4-bma220_improvements-ad0b3df025bb
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=ZjQlujz+dTmeks6So5/AUz9N0e0nT7HBHjX8jna68iw=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRWfgpBj7N8kGhhrKas8mDeg/klvOZc8uMK
 uRCzB2W34OJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MKNSEACBaY4CAdy/gpC94t1CzGaBNFUxqLio1bVIQXtgDooOw51tf/u3DEmQ64y/c5uiqrazhUQ
 wL1TBBrReJ9FRc4LtL2Sjqgz+BINe2AtjKLOwTa8X72V1Ho5zf22DTde8KlFwsYb/ckRQRsMVS7
 pZsE6GbRvZVrNJ4ho0+sIg7V8hoAR6fEx/oVduucMf8t7KUshw5NX3KEMQ0IpByi1ciRvlpYu2C
 +3+L/OW1ydnsVlH/y7vebaG99VVbmS9URD+miuE6zP8TI4CKmhwSKpgbv5owgRruQ25hYP5kneo
 FSFKG6LxNloVGvO/mPwYZl1KcACTPK9KNd9AzE4lDFYYWW4AHj6y78HTwt8a6QJ13lv0QPviIOp
 KbFkyrj12M9QfDMwnKeLKUMHRtn8/wmFopiWmKFyY2vcJpdXFvM6jgX3HeDj5nfzSQBZGJhiAxe
 k8W2f84BIsLZ0OuccRzMAF/DGJE/8ZgZs0pkRn0EgXQMlMA771tC1idSjQRCCORLGvTFXTtPD5L
 kJIOrCc2DfG096X6zbkjWdmC0ax67g7MQuC0SXeou7YgzeR1iIitQeqeatyNeijpl1/fN/6dvgz
 egl3i11nEU45kkk7wVlV9lO2EMRZLYT1s6PoVdGiJKnyfmx0tkN1Y+1TXUzBfc2wACswBYr8Nfr
 /pbzK4s3Xia5OEw==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Series of patches that switch the driver to the regmap API and add
i2c connectivity.

Tested in I2C and SPI modes with two different sensors.

Event-related code was skipped since the patch series was getting too
large.

Contains fixes based on feedback from Krzysztof, David and Jonathan.

b4 lost track [1] of the patch series after the v2->v3 rebase.
probably my fault. expecting weirdness.

[1] CRITICAL: This is not a prep-managed branch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Petre Rodan (18):
      dt-bindings: iio: accel: bosch,bma220 cleanup typo
      dt-bindings: iio: accel: bosch,bma220 setup SPI clock mode
      dt-bindings: iio: accel: bosch,bma220 set irq type in example block
      iio: accel: bma220: split original driver
      iio: accel: bma220: add open firmware table
      iio: accel: bma220: turn power supplies on
      iio: accel: bma220: move bma220_power() fct
      iio: accel: bma220: reset registers during init stage
      iio: accel: bma220: relax constraints during probe()
      iio: accel: bma220: migrate to regmap API
      iio: accel: bma220: populate buffer ts in trigger handler
      iio: accel: bma220: use find_match_table fct
      iio: accel: bma220: add i2c module
      iio: accel: bma220: add i2c watchdog feature
      iio: accel: bma220: add interrupt trigger
      iio: accel: bma220: add LPF cut-off frequency mapping
      iio: accel: bma220: add debugfs reg access
      iio: accel: bma220: add maintainer

 .../bindings/iio/accel/bosch,bma220.yaml           |   9 +-
 MAINTAINERS                                        |   7 +
 drivers/iio/accel/Kconfig                          |  19 +-
 drivers/iio/accel/Makefile                         |   4 +-
 drivers/iio/accel/bma220.h                         |  20 +
 drivers/iio/accel/bma220_core.c                    | 611 +++++++++++++++++++++
 drivers/iio/accel/bma220_i2c.c                     |  58 ++
 drivers/iio/accel/bma220_spi.c                     | 318 +----------
 8 files changed, 749 insertions(+), 297 deletions(-)
---
base-commit: 661facba437e37c1685606825b9fd59be3f78771
change-id: 20250913-b4-bma220_improvements-ad0b3df025bb

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


