Return-Path: <linux-iio+bounces-26251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8470BC610A1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 07:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 550014E2F66
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722C227E82;
	Sun, 16 Nov 2025 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="HSEzlr3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CC154425
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763273948; cv=none; b=ablq6yBdPO1KYcfP0jd8m9adBIcpL4Eis1sIA5s3/49lyHPzeIu3IMNfE3vEghW2DKrIoLeROtUiQ2TLAqzrhryu0rQ+T4pNmrY0C0uf5b2atmpShVscMNjxOVYYU4gdfwEZZRvK+w3Khka8Kn3KKhRLdjafvOOJmfby4hjSUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763273948; c=relaxed/simple;
	bh=fBaEBd5kyCKKTJZUJ+qaBkp8cWy13KJ1jwsOgUtlbwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B/Bid9iT0TFTWIfy7qzN5Jn3AZNQRZNer9D8UlsHHmdcrLS5tB0nnTox5GN68L3mF/XAgsZYnxWkFXS+cxqyRT/F0CRFpuXO+erooqePldYoo82ssofJMMr8+gwmugrfMErMYSiiZZTaCg6xTWSmedEzeyncZEOE6GWsnQZ4IjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=HSEzlr3A; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 295FC104CBA7
	for <linux-iio@vger.kernel.org>; Sun, 16 Nov 2025 11:48:58 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 295FC104CBA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1763273938; bh=fBaEBd5kyCKKTJZUJ+qaBkp8cWy13KJ1jwsOgUtlbwI=;
	h=Date:From:To:Cc:Subject:From;
	b=HSEzlr3AjHC+biQjTq0KT/64CHoi17xOAIeXxhGn9h/1oKRcpmbxZjQZo6sbZA+us
	 7R5vFPNwMQMMJ1ZHCb5Z6h56wLd7ANBCXz279UZ5cfy0ttSMHcLCMdI4fc66qr31yK
	 XeunEdxNdnUfCtrJL4I/Ib9qr263w1brLZ5i9HHo=
Received: (qmail 7646 invoked by uid 510); 16 Nov 2025 11:48:58 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(-6.0/7.0):. Processed in 2.806526 secs; 16 Nov 2025 11:48:58 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 16 Nov 2025 11:48:55 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id D05F9360047;
	Sun, 16 Nov 2025 11:48:54 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id A5C121E8156B;
	Sun, 16 Nov 2025 11:48:54 +0530 (IST)
Date: Sun, 16 Nov 2025 11:48:49 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, akhilesh@ee.iitb.ac.in
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] iio: pressure: Arrange Makefile alphabetically
Message-ID: <20251116-61849-3277029@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix hp206c and st_pressure_* entries in pressure Makefiles to follow
alphabetical order as per guideline mentioned in iio/pressure/Makefile.

Fixes: 217494e5b780 ("iio:pressure: Add STMicroelectronics pressures driver")
Fixes: fa4c9c93e93f ("hp206c: Initial support for reading sensor values")
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
This is the follow up patch from action item on:
Link: https://lore.kernel.org/lkml/20251023182721.00002112@huawei.com/
This is on top of linux-next

 drivers/iio/pressure/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 47bf7656f975..a21443e992b9 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
+obj-$(CONFIG_HP206C) += hp206c.o
 obj-$(CONFIG_HSC030PA) += hsc030pa.o
 obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
 obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
@@ -35,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
 obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
 st_pressure-y := st_pressure_core.o
 st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
+obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
+obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
 obj-$(CONFIG_T5403) += t5403.o
-obj-$(CONFIG_HP206C) += hp206c.o
 obj-$(CONFIG_ZPA2326) += zpa2326.o
 obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
 obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
-
-obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
-obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
-- 
2.34.1


