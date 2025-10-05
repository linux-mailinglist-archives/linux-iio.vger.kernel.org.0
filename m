Return-Path: <linux-iio+bounces-24743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65862BB96A0
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CE318965A7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33862288535;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Eb3x5DVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2A274B48;
	Sun,  5 Oct 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=IzskPOfvYAFH3I4EGQIMc5g/T1IIeRIamwfCyzPqmX9heUg8gxIyEGRJYRR/WPZANIffF4NdxBMEz7rb8rBaSTFX2aKvDuDrpzeC027BTulzn3hJ9kaPx+ktPhWHvw0aG8N+YQ3akcOmFSK3mU7N5d4Wrd0Y3Mk0hGyyrfe738A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=bESRm6KHeFdhIgKWEqzxTGSHEOvBjPJPD6ZECPUFHo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BG4XgqTW4RGoGgpQEAKYfyYNEnep3sEh/P6lG44PH4Tu4kD/xZDC+ORGmsstRh0tCJynpPGquF6LIsgZbxQnNmkmruY055g7N95rAf9sVrZs4Bi6y4ZsFRekW0hB7GhNiCX6Xsq0yifaCHj/nifJYUv9kJw9lQRB3D0xSn5LHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Eb3x5DVQ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id CB481173BED;
	Sun, 05 Oct 2025 16:13:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpf7JvsHD7foLXPGXmmVPDrW1g+beJLPvpuHuZ2gqQw=;
	b=Eb3x5DVQ5tHaInwqi+m4NtL4zLlXtRIbntjyTLXkZZMeyb0OfQmXXu/NJ9eMHj5NXwvarW
	TqDLnN1dZE4P4bJwemeYu2eua0JEnL30IcefSa+xyKFAXuPhRBj0mg5lj+BlkaBpuN/caA
	QJXM1bCh1QB2ZVhl2a0X6A3/iM3vCnjyacHW4VM1Ay5wsA9tQbdtpNpiIBrTRTRZXSDox1
	k2KGAGbWIWgDs+dLdYUPqaeUCTixSf+z227Fs8Sw49UHn5BySPddemRkcd2lDP629sGvr3
	npoQFq8BcOed22kujhr1WcJQ5lagSwjz1q5CSVSsiusr4/KYPrbc5WzQ9f/sXA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:14 +0300
Subject: [PATCH v4 05/19] iio: accel: bma220: move bma220_power function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-5-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=bESRm6KHeFdhIgKWEqzxTGSHEOvBjPJPD6ZECPUFHo8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnJiS2FtUlo3aDNqeFQ0QkdkUlhNaVNICnR6SStiZTRZcW5Ma1JIOEQ1
 UDFCNElrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNjJ
 BQW9KRUhRcko2ZGpPa2xqZ0p3UC8ybXUvUFV5ZjZsMjhLdnc1TWI1Wks1UkxGalBFNUdJejZKOA
 pLbzk2NFBUVW9TUmx3SDRGZ2l1dHI5NDBXcWZsRVRnZjFyQzZGeDh3REo1WnpKemhDdk4zVDgrM
 Go5bkdLakw2CkxrR04vSEZEN2hhREZlb0tUSW1vNWoyMnREc29HZEU2TW5tUmloZ1NqdmNuVExJ
 azlmTk9TaUVseEtsR1IyZkQKQk5UN1BxeHphSDNobFo0QXk1Q3kzUS9OY3lDTnZ3MjVMLzlqTkN
 xNzlRWVhERmFOQmRIbEFhd3dNSGRBenJuNApVZ2hiMVBXYWttYVRZTjJEWFdRZjRKSlU1RE9END
 dWUnFiU2tKOThnWkd0UFJrbG1maXBlOVJjcGZ5VDFCWTVmCmdwL0xTTWZZN3V4bmtjM3pDRW13c
 lJLWjhGQW5jK2JyRE1JMDlsNlhCNm1oT09Sd1pwR094VDhrVFNvbGxacWMKRTZaRWpWeXJucUNN
 cTFLOTkxUGdUQ0FPSFpLUVBUZzk5cFpzMWtBQ2o5c3ZwWGQvMXBLYktQb0U2bDF6Q3RMWgovQlR
 FMnlSdU1hMkJqVUF6QVFKTnVZQUF1bmtQUm04Q1NucWFaOXNLelpKc0RPRmord2JtNzFRMnAxdC
 9QeEZiCkpkc3pwbnlRREVJWmF0bGV2dmlYNkI1cTZGVzgyc0tvV1NKaHRQOGJyYlRqZ25kc0dVU
 DR2TS9MQkNMeWl3aDQKbUNxcXNxMXQxdEgyWVVONUtDUlR2ZGJBTUtQNU5uSEY2T1pzbU9CT2RN
 dHFmZUlINjFNeVVaSlBYS08xS1J6OAo4dzNwVDliWHNrVDRRUGxJRlNSY2IrZXZiM1pTOHJoZm4
 va0s0RVJvN05EVGsyb0tSejZ0VlVPODVORi9naGV1CnY0VVBpZVp0dGhvbTZBPT0KPUxvM3MKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Move bma220_power() before bma220_init() as a precursor to a
patch that removes code duplication.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v3->v4
- unsigned i (Andy)
---
 drivers/iio/accel/bma220_spi.c | 49 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index a5d2906321ae5fc67c0e1dc44651833c5e7fcb39..45ac0d7ee27de65b204bd2766f26024e4ed57f4c 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -199,6 +199,31 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
+static int bma220_power(struct spi_device *spi, bool up)
+{
+	int ret;
+	unsigned int i;
+
+	/*
+	 * The chip can be suspended/woken up by a simple register read.
+	 * So, we need up to 2 register reads of the suspend register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		if (ret < 0)
+			return ret;
+
+		if (up && ret == BMA220_SUSPEND_SLEEP)
+			return 0;
+
+		if (!up && ret == BMA220_SUSPEND_WAKE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
 static int bma220_init(struct spi_device *spi)
 {
 	int ret;
@@ -224,30 +249,6 @@ static int bma220_init(struct spi_device *spi)
 	return 0;
 }
 
-static int bma220_power(struct spi_device *spi, bool up)
-{
-	int i, ret;
-
-	/*
-	 * The chip can be suspended/woken up by a simple register read.
-	 * So, we need up to 2 register reads of the suspend register
-	 * to make sure that the device is in the desired state.
-	 */
-	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-		if (ret < 0)
-			return ret;
-
-		if (up && ret == BMA220_SUSPEND_SLEEP)
-			return 0;
-
-		if (!up && ret == BMA220_SUSPEND_WAKE)
-			return 0;
-	}
-
-	return -EBUSY;
-}
-
 static void bma220_deinit(void *spi)
 {
 	bma220_power(spi, false);

-- 
2.49.1


