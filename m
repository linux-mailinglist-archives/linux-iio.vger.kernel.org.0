Return-Path: <linux-iio+bounces-24741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13012BB9691
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F6B189652F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F02882BC;
	Sun,  5 Oct 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="lVcVGMPe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BC2836B5;
	Sun,  5 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669992; cv=none; b=GT8FyToJyBQBMN1OBCJ3GgN/JlKhh2YW8iy58iQV8KEYGDTv0hE0s7FnFx2D4RCalrr9kWSiJroOnFhhUPbZJ1iBsaJ+Ibc7nV8oa9NJal1URA32MkgNxfI2LvFO906PIPLHtO2v/eocFX8DCLlD7KmkMMD7EL7xD+bIUzn/9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669992; c=relaxed/simple;
	bh=9z9iaV0kcIBckzkASDSpSEvlASqUUDNUq9wXYBNiKd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMypHTj8WdwHxkGn+3/83NTNA3hRCRlSM0hjTVjk9IDRwsp5tyaE/1IWASER1cWZZg9/2toE+5FeyC5bCKM/PdyB05y7gxdZsa1s+WdWRBqc+DyGUg9+DXEUzKSlKuoFd1g4vtt+BP9ZO1fWtChfsSEUQpPFsuG1GeIF1J12Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=lVcVGMPe; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BDDAE173BF2;
	Sun, 05 Oct 2025 16:13:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N3QOAb8TA2ZdEDRy0PgYLrjDQo06YJfWtZNDbxgXUQ=;
	b=lVcVGMPe1tI0RAaFaRFUfcSfh8XoXoV7Wko+eszLbpCmY1Ppr2uF2q5hK97Jm8Ebq6/l/U
	z9fo8pjREZLa4a0K9D8S43ZdV7L5gt+QY3kVA0j+kGU7dzdn6Ujp2nKmQJgcCFlr/XXeln
	RJyAckflkypyE+zzolkt68T2zZ/bwC+QMctHAE5ruBqZbaeCsPnh25LRsK79/22EAcJTz/
	YS3IjyXKRVmSyU/oKeLOGVkjRjIMFu6xlbJsvD7ii64O6nFRkG8p8hKlnGkKzZpt1J0c6X
	+RVlOXylFirdiBH8FO7AWKvYjC2uk+BeLaLfKToUqSH9NLllSlCQX006/dAInw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:19 +0300
Subject: [PATCH v4 10/19] iio: accel: bma220: reset registers during init
 stage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-10-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=9z9iaV0kcIBckzkASDSpSEvlASqUUDNUq9wXYBNiKd8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2ppYnNTalNmajEwcHZwenNWb2pTd2pxUnVrUGpkMzZ3ZFQ4emVQCkZ3eDlIZEd3dklrQ013UUFB
 UW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpvNG03RUFBb0oKRUhRcko2ZGp
 Pa2xqMzQ4UUFKa1NGM2F0SVZjS3hxRXVkVFNSNlhRR0lHdUR0Wkh4QVRjTjBLWkNjSFBMVXZFYQ
 p2eVRxb096TFl4czY1WVBIYitKYWpyclM4MGt6eW9LMUswb0lTSnBuQnVBV0lueUVEcFRNSFFzd
 Dk3S1duY2wzCk8rMEpPMjFUNDhDUjVLV2FyYUtuaWlSaVF3QWl4R0NIM0F3b3h2NGYzZEJNUWgy
 UURDV1NoN01lQmxRYzlWeWkKbGhCZG9BSi93bDM5VXFqOHdOdGM2ZHhkMFJpbFR1Zi9iVTdJUDh
 oa2RrbW5FeTRJZ2RhTWQ2TlRTU2hnTHhURQpsVDh5MWtkMS9qb3VsZmpXSzAwOUJDSzRibDVLbj
 dJUkhma29KUFVacENNMHFJZ2dPcUthQU5vTFV3NzdnT1FZCk1HYU1LY3Bpb1NFZkNhQmxCci9QM
 2RYREtRWVpmK2ZiM3BOZzVTYkVXaVJsSVlhbDNDNVdSQTh2YUhUTVlFczYKcTR5S1ZTWGZ1a0o3
 M3dXZTZ2dlVJbGpNUVNNVlluTUZnOHVPaEQ4WUMrL1ZZbVQ2eWJKWnFFT3BWNnVqUUJHeApOYTl
 aNEcxYzgwV3J6UkRXNis4K0lnMHoxVDVSMUVaMS8zeSswMEpac0ZML2M3eE1hOWNiOWo5Kzhrdl
 FwSzk1CklYYzJuUmEwejFuUjNER1hFc0ZiNWxrbEpGV2NGZys2ZFFnVEV5VmR0aTFUelBhWVE4N
 mszOG5nUEJBY2I4SkQKSTc0VXdCeFBhM3RiNjBXekdCckliMjJpYTE1aXhzZjZMSWVuNC9sU2oy
 akQ4OEtnTEhvZzNnWHh5U3NHT2VLeQpWUGdXQnZWblloQ2pIalFEQTl0eDVkMnlWcGJKMkEvMVd
 SL1I2bTNtb0FMODFHb1VFdDBMSU5DWEF6TGYKPUpiR2kKLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS
 0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Bring all configuration registers to default values during
device probe().
Remove trivial code duplication regarding bma220_power() in
_init()

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 dev ptr (Andy)
---
 drivers/iio/accel/bma220_core.c | 44 +++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 319a3d6867ee5ac2da64c9baf02a760865302ee8..1b118a9fce3f16f0cd805a68b9887c6eaf24973a 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -28,12 +28,15 @@
 #define BMA220_REG_ACCEL_Z			0x04
 #define BMA220_REG_RANGE			0x11
 #define BMA220_REG_SUSPEND			0x18
+#define BMA220_REG_SOFTRESET			0x19
 
 #define BMA220_CHIP_ID				0xDD
 #define BMA220_READ_MASK			BIT(7)
 #define BMA220_RANGE_MASK			GENMASK(1, 0)
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
+#define BMA220_RESET_MODE			0xFF
+#define BMA220_NONRESET_MODE			0x00
 
 #define BMA220_DEVICE_NAME			"bma220"
 
@@ -202,6 +205,31 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
+static int bma220_reset(struct spi_device *spi, bool up)
+{
+	int ret;
+	unsigned int i;
+
+	/*
+	 * The chip can be reset by a simple register read.
+	 * We need up to 2 register reads of the softreset register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SOFTRESET);
+		if (ret < 0)
+			return ret;
+
+		if (up && ret == BMA220_RESET_MODE)
+			return 0;
+
+		if (!up && ret == BMA220_NONRESET_MODE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
 static int bma220_power(struct spi_device *spi, bool up)
 {
 	int ret;
@@ -246,14 +274,14 @@ static int bma220_init(struct spi_device *spi)
 	if (ret != BMA220_CHIP_ID)
 		dev_info(dev, "Unknown chip found: 0x%02x\n", ret);
 
-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
+	/* Make sure the chip is powered on and config registers are reset */
+	ret = bma220_power(spi, true);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power-on chip\n");
+
+	ret = bma220_reset(spi, true);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
 	return 0;
 }

-- 
2.49.1


