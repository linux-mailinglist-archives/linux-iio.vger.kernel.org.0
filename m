Return-Path: <linux-iio+bounces-27170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD0CCB907
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECD44301CD21
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB5315D32;
	Thu, 18 Dec 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="reEptIXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176F31283A;
	Thu, 18 Dec 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056469; cv=none; b=kaxcDmDTf/sSZ1uZDJO+48UlxU7u8PUH+YiHg2pNBfe4f2J7xBovpdSClhn8jFnFiOlkNVrR5ErmoyHRFM1tPchdi5pq7PO/MI3OToumnZOKxIIYJNHQhJBqKEVtij6vb8Ybx21dlgLhkpZTSwjDSrT3DVdGjFOAdl9rI6Zr7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056469; c=relaxed/simple;
	bh=XSdGMOB3rRzh359mI12D/ax0XdyDOTtw4nPSx825r2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKKxPUrK7q5qPAiYgvOqus1Zaydd/wXNel50kuxsOA8AXiqQwtxKOSkrX00csVCZjSFaKbRCCF48L/SVPU5XMZH7YS8gHcsTE1G5x5xPgizSfJo1p0GjDORceHrhmQ/DrGlxKDJz1VTjQ3lSjlbnDyeGgjL3jPeDeAGTnRq0XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=reEptIXI; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 34A6716020A;
	Thu, 18 Dec 2025 13:06:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVIOyIOESd4wkc1FWbJueLTErVXe9VdBH1S86VEToqQ=;
	b=reEptIXIKLsUzSIWNwSlXQUm9PdgfNQ8yHGKnWNADoTvmi6ShhQKCH5jpihu4WXsHBDe6O
	vcJ/d8NCHGw0M0LcJBC1s5gfYwesIJHx4kaNoKuCOGTjIf2JQ901YJucDOAkol1QIKasDA
	b2MMwJnd9QKtMxgVgwJ1gDbhvoOIQ53aE5x4AI8+/Z0NIg00Rl7TewiOoGdJyXFLd/RGvk
	qjU5pq7xXUliEHqd0k7irPPzvWHuTuENiwrUIfoRtpjhL9k4dV5GRgfrACQIzKb4Q3klfV
	UuXowgZbxIIKWnr7bTbsm/fqkQ5TlMaULAqHIEzNCmAZGpuGd5JFd0GaygQS3w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:43 +0200
Subject: [PATCH 01/14] iio: pressure: mprls0025pa: Kconfig allow bus
 selection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-1-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=XSdGMOB3rRzh359mI12D/ax0XdyDOTtw4nPSx825r2k=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2xENEF5aWJDWVBJcE9PUWNybzdVaTRGbWl4WFRCeXpMMVlESEd4CklwbGJSd0ZQejRrQ013UUFB
 UW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpwUStBTUFBb0oKRUhRcko2ZGp
 Pa2xqT3VBUC9SeC9VQ0VxVWtqZkh6c1lsQkdUZ21oekQ0ekd0K2lCWWlBcEZuR0JiUk96RzQvMA
 ptNld5ZXF5WVgwNlpjZWxsMVpzb0pPOEU4ampyODI0TXBqQVUzWWVPTC9HRXhkR0MvSm5TZmJIZ
 TFhOFM1T3haCldjYk1oOUUrVE5DYnprR1gvTnd1RUlUUU5DOEphazgvZDl2U1BrRkcvdXhrTllm
 ZFkyVmhUMXV4bmJCVDlDRlIKQis4UjBBdXhXeDFoT2xOYTU1c2YxZmdKN3c5NUZnNjVOd1doUXZ
 KcjRrdHpRSHkraG1wN3NuQ0xMR05FWGZ1NQp2aHQvNHFZK2xQcURlMUdHUy90N0kzSWJwV2Z0RG
 JLdGNpVlJ5MjYwaURTM1JQeS9ZSVdpSjRCZXk2Y1R0Y2dwCk91eHFERG5CL2xKeEVvdDg1TE9TU
 Wp3MTNWZlhGbWRsMTJaMUx0dmFVb2pxS2hMODdDeGFWQitkVG1hK2xTMDIKdkx5VGtnc1RrYU51
 SS9pL2hSeTJTTEFGYnBKa0Q2T1FQbFBwYTE5UEF4cnF5R0c5TUVYU0ZTcHQ2RG94ZTFjbwpIL2p
 vTmRzT2FrbG1lanU5c25xM0JpYzEwNnpLazB3bTMvb0x2Ung2RHBhellmUTNOZy9qZmg4dE1jTl
 I1RlZkCkg2SUlkYzI0ZGRyOXBweUhreVhSUnBTdVIzUjFJMGhXQnpJVDlmcmYwN1NtWUxNdVZQe
 XhPTVVSWjhJRkk5L3UKYXZ0Y2VzUllOMmVTUmVUL056NnBlUXZuYjhxUGlHbUVPbkNLNTZ6S2ZQ
 QTFIcmpNT0YvMm5UdUlNT1lDU2VmcQpSMnlOZmVpbzNKeEd5cFdBcXR1RlovZzN0aWtzdDJuODV
 UV05uOEs0YzRSR2R5cTN1bUwxSXlxK3RkeHUKPVp5aDUKLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS
 0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Allow the user to select either the SPI or the i2c bus specific
module and autoselect core if needed.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/Kconfig | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 2fe9dc90cceb..cbbbcbebf144 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -187,29 +187,33 @@ config MPL3115
 	  will be called mpl3115.
 
 config MPRLS0025PA
-	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
-	depends on (I2C || SPI_MASTER)
-	select MPRLS0025PA_I2C if I2C
-	select MPRLS0025PA_SPI if SPI_MASTER
+	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	help
-	  Say Y here to build support for the Honeywell MicroPressure pressure
-	  sensor series. There are many different types with different pressure
-	  range. These ranges can be set up in the device tree.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called mprls0025pa.
 
 config MPRLS0025PA_I2C
-	tristate
-	depends on MPRLS0025PA
+	tristate "Honeywell MPR pressure sensor series I2C driver"
 	depends on I2C
+	select MPRLS0025PA
+	help
+	  Say Y here to build I2C bus support for the Honeywell MicroPressure
+	  series sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mprls0025pa_i2c and you will also get mprls0025pa
+	  for the core module.
 
 config MPRLS0025PA_SPI
-	tristate
-	depends on MPRLS0025PA
+	tristate "Honeywell MPR pressure sensor series SPI driver"
 	depends on SPI_MASTER
+	select MPRLS0025PA
+	help
+	  Say Y here to build SPI bus support for the Honeywell MicroPressure
+	  series sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mprls0025pa_spi and you will also get mprls0025pa
+	  for the core module.
 
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"

-- 
2.51.2


