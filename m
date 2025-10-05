Return-Path: <linux-iio+bounces-24758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CABBB9752
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9EC3A4DD4
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A0288505;
	Sun,  5 Oct 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="UR/GKyRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5727404E;
	Sun,  5 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670415; cv=none; b=ibxVsLGU/n0ZAqzKspU+L2oz665MBYvGzToR+pUf3B9JFn/DbKonAwdGBXv/Q68pB6BVuR3ta1vQN7yI71zxE3YIosw4q6FC55SBzIag/UMYsUUGH9d+6GUzpVCWHnvgeRORI0nmFu6vR651H7UkCES1GIzFB9a7ThkUo6cj1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670415; c=relaxed/simple;
	bh=f7KLDAodIHfk17l27mAPyJygswUhI6CzvIQ+CXzSVBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BAE1MszzJ99v1EPIjC9JJNtm0HNkGKF+TfjlzRVd4BwYG/ZNCvCagH2lily0f34nHWii5prxJEmjhH+UsP8nRGdpWou3ZVlZkAX9vlPMsOtZPa+2ERKXehePZtrKzgObZemyesio+1yCic8ENhZkO6QouPMG7hDUvYtYUJ91OEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=UR/GKyRv; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5D198173BE2;
	Sun, 05 Oct 2025 16:12:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UzX+EUuxYZCKZQCIkyxrwphKqB7kjA8IgCPgmxiC86c=;
	b=UR/GKyRvkAb6Kdeh2qruTdOthQqm326b+jMmsrw1McqIyljwTIDA9EXvJNJhFKjyzgHTRS
	Xr07jWt+wjjENE/GgRKlvcUKiLZs7BQsIGZw3sWgdoS9SB0MXFRO+hQHvco9kIozmFMjMu
	ZugTSej5CB3Wv3lc9vVTfBMUiTwr5PzFbaqALAmfersxueFSARnEt09IXNkFZcesaFWo+W
	7zZODiX+zWq13E8ejnFjdA4gDghKcQxr/2/Eq9n0HciRQ9ULfPGDAegX89LfBrUh5uIIQV
	NKqWq0PFsZ48tIDbObMNgnRG8nVp79CijJ98fWUDYg3Y8D4IwuBcxyxCyITWag==
From: Petre Rodan <petre.rodan@subdimension.ro>
Subject: [PATCH v4 00/19] iio: accel: bma220 improvements
Date: Sun, 05 Oct 2025 16:12:09 +0300
Message-Id: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlu4mgC/4WOQQ7CIBBFr9LMWgwCTVNX3sM0hpGpnQXQQCWap
 neX9gIu38z/b2aFTIkpw7VZIVHhzDFUMKcGnpMNLxLsKoOSqpX9RQs0Ar1VSj7YzykW8hSWLKy
 TqN1YU4hQy3OikT+H+D5UnjgvMX2PO0Xv07/KooUUEvtOdT0aMu0tv9FxXe5PnlOEYdu2HyV3l
 oDCAAAA
X-Change-ID: 20250913-b4-bma220_improvements-ad0b3df025bb
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2267;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=f7KLDAodIHfk17l27mAPyJygswUhI6CzvIQ+CXzSVBo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnF6MEVKdVp5RzZUU1h5RjZkSlhTL3FYCncxRkZpeVAzOUJReTExWU1Z
 bEErcG9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNnN
 BQW9KRUhRcko2ZGpPa2xqRFdjUC9pK1c1VUt1NWJFZllJdCtERlh0ZktadWRDS1dHd25ZcGlhWQ
 pKYVBzZ3hwSGNmN3BsWjBVQXZoS3dsL3pHRC9xUE4zU20rc0wxeHpacGdVV2xLVUttM2YzQ2Uve
 llpemFueTZUCk9teTlTcU1JNzZsVmRuMkRMeUVIWEVLNkpzSks4c1ZXVGNBZGZZeWFQYXQ1TUxZ
 TDF0azAxYzJuSWkyZjVEaGwKcFlZQytXcHFIL3d3Y3FjYzduQ3FoQVU3TVhpcmFpSERneW1zVUQ
 2dThZY2NFampBelNraWN0QUE0c2lYL1JsaApJRC9naVZCVzVTcEwxb2xsYmgyMGNUcGkxcU9zZW
 RRTDBTUHlZRzFyeHFHVzh2VmVldGJWMlc3T2VWbDZUMGdYCld5cmliTklaZEIwMHduY2N6dHhtW
 loya1lITWtKQVZKUjZlSXlqOXFjMVpWMllSS3o1dXUvNFgyU3dNbVBtK3IKamNubGNyV3c1MU1u
 dW5PTEtITVVvTTh3R2VhbXdnZC91blNWRTEvUTNjcHA1ZWlYY2lab3FDbUpSSEljNFgxegp0RmM
 4REZRYldKMHlWQ1E0ZTJFV2pMMTZCeXdlanE2SkJhMHhzRVdUaHloTzhvUnFMcmVZeWMxS0NPdT
 JBbnVUCklKWit6Nks3RGpmN2hHU3ljQ0hPaGJQV1dZaGt6OVg2TWtTVERGUzl5aitFa095NnFsM
 mFuNW53cUJWSlRGc2kKQ2Ruei85ZERmMW84UEtoS0FPSzdwZEc3SWc5cjVyaGxmeXluWVVlLzQw
 L1J4dVpqT1Nuc25SWXBJTGJMckpBRwo2Z1QwSXBoMFRodTB2SHhneVlVYkUyeDFTQUMwNndxdmx
 qdG9MTDJBVEJONHNJdG4zdno3bk9xSFJ0bjdGV2hVCmNnQnZyeVd0aHh3ZStnPT0KPUUxZkwKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Series of patches that switch the driver to the regmap API and add
i2c connectivity.

Tested in I2C and SPI modes with two different sensors.

Event-related code was skipped since the patch series was getting too
large.

Bindings have been merged into testing branch, but this series is still
based on 'togreg'.

Contains fixes based on feedback from Krzysztof, David, Jonathan and Andy.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Changes in v4:
- fixes based on Andy's feedback
- patch reordering (Andy)
- Link to v3: https://lore.kernel.org/r/20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro

---
Petre Rodan (19):
      iio: accel: bma220: remove incorrect kernel-doc marking
      iio: accel: bma220: relax constraints during probe()
      iio: accel: bma220: cleanup license string
      iio: accel: bma220: shorten spi->dev calls
      iio: accel: bma220: move bma220_power function
      iio: accel: bma220: cleanup includes
      iio: accel: bma220: split original driver
      iio: accel: bma220: add open firmware table
      iio: accel: bma220: turn power supplies on
      iio: accel: bma220: reset registers during init stage
      iio: accel: bma220: migrate to regmap API
      iio: accel: bma220: populate buffer ts in trigger handler
      iio: accel: bma220: use find_match_table fct
      iio: accel: bma220: add i2c module
      iio: accel: bma220: add i2c watchdog feature
      iio: accel: bma220: add interrupt trigger
      iio: accel: bma220: add LPF cut-off frequency mapping
      iio: accel: bma220: add debugfs reg access
      iio: accel: bma220: add maintainer

 MAINTAINERS                     |   7 +
 drivers/iio/accel/Kconfig       |  19 +-
 drivers/iio/accel/Makefile      |   4 +-
 drivers/iio/accel/bma220.h      |  22 ++
 drivers/iio/accel/bma220_core.c | 603 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma220_i2c.c  |  58 ++++
 drivers/iio/accel/bma220_spi.c  | 319 ++-------------------
 7 files changed, 735 insertions(+), 297 deletions(-)
---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250913-b4-bma220_improvements-ad0b3df025bb

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


