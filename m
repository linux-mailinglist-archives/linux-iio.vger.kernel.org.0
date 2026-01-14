Return-Path: <linux-iio+bounces-27796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1430D20627
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9B93086983
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C253A7822;
	Wed, 14 Jan 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ByM/8SdR"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF823A6417;
	Wed, 14 Jan 2026 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409791; cv=none; b=nVXXYlXVfAYNizZ2JoYEkvZI2MiqIF7YO2fcBf+cdUD609ONnVlc3jtuZ8EjRctLXrcHuFHKrPE+lYRI29FVrRge8HXMhVd27k+gubzs76JdE3wBRMwmvGbk66eSRb6hwr24Ln2c+mVdrjY3kATY9O2AlKGxlkyemXr9mFqsC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409791; c=relaxed/simple;
	bh=K9doTAmMpJQPo51nBOAYTEIrIgqVurzpij9z1HOFz8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShnfPbY7Vg19kZ+2Q8oRcV/uX9QRwqH4B+Zk/Hms7ddwh0b/iGFn9sX1KpLYLjDEqv56EORNnBFrEmXmjMt00dsIwVaJetc7MoywTGRSlgvKCNhJx+UxDX6eklpwT6pZeCbaLi28VLq/jByW2U9CE8w/O674L98ehY1D4r/ercs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ByM/8SdR; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 1276016020A;
	Wed, 14 Jan 2026 18:56:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiC9iaiV8awOskqcgc08keIp89xcVBMR59YYHfFjAnY=;
	b=ByM/8SdRnv+U5BJQLu2W5IyUDNvLdzTQJ/S1I2Us72KXkybQhgTg/xOBmkKJx3JnX3e4hF
	WTCvvskrrDlwXZlXG2r2pqTQzGMC9rMMV6AOOLXC5+sfLUPKd8Z6m5dEwoG8YaEUDRimSM
	5vUTYgO8nFpcympoDsWVcH90hFZpl3rdog+0DYe9Ecvedx9OeQIQzbo0B4ZgfKOBhzve9f
	OGpg2NdkjmCr6EAA6impZa9viNEihVhn130/wqBOG+I4Vh62u6kStl/GmCjWH0nKT5l8cb
	ETLXJN9l/OU3EDz0BS1FfmdjN9jx+1tmLjSpObsHgvcuZh7CfPU0H2m7xgI8DQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:30 +0200
Subject: [PATCH v3 01/13] iio: pressure: mprls0025pa: fix spi_transfer
 struct initialisation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-1-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=K9doTAmMpJQPo51nBOAYTEIrIgqVurzpij9z1HOFz8s=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXBhdVErdFdLSlN1cTdHSklhOXVtSlJTCnNNNVJHQ3RUR3ZaWFNGRG9a
 QVptNVlrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cVd
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXdtdw
 pELzlvbEFLQnNoMzVVVDFzMzNDcitZbkZjSjVzQmt0SlZRKytrRUV1SmZSQ25BK3ZHV3FhRTEwb
 0xXZWpvTUxQCnJyVVhhcTJ0N3hlNzJMV3dRUHBLc0kvMzJlbWkySTRIMGpIc3MrTmJoQXo5UlZT
 UFZabTNteW5QWlFSVnJ3V0kKQldkL1NsTDlDdTBVSFBhZXV1Z2MrS09NNWdKNStjd0tDN2lpb3F
 JdE5EaGxQRmF6cHZRYlplVWtFL1h2dE1wYgowb1VGQ0F0a0dsVmpLR2tIbUdLUVROcmdkZnJLdU
 REMkVzL1IvNmtyTVJBTWdVRGZ6aEx1eU5td1lqSTZyQk4xCndWaFJQS3VqNnI5bW9pL2thZ2VIR
 2wveHZzRUdnRGw1QlIydU82d3d6N0xhNFExdGRIRzdzZnUwb2g4OU84bkQKUVoyTW43cG1BcW5S
 aUxmeFNBTUVzdXNPQk43THZCVFpXVktWUkFGNTFGUlp6bEIrc0RIWGNldURHRGgxYi9SMwpvNWJ
 tNjl2dE1DSW80Tkd2ZjZuN20zM0hZWDVOWDdQWU1kbnVDZEp1WkZjQXRKVmdzZUQ3TnJxTFpPSU
 ZPaG01CklIV2lHQ2MxZ2pWanRwQ2RONDN6TFA3NkgxMjBNNkNPY3l3ekk3WEpYN0hsNVRCdHdGM
 GJXeXFUV3BYUXVyczIKcjBYTitESnV3cGtwV1pUM3RRQlh4NWRXRGdJQUpLSDRURm51Q2c1Qm96
 c3NLV2w5ZlV5OVpYWURhUlNubUFJdQpMS1ZFOWU3VGZrTVpkcUY5YUJHK0Y4WjFSU2RRcGwyLzl
 QOGJFUVlBdTdiaHpSMnJnblZFMjUxb0V2K1pPWlF6Ckd5RDhFUyt5a3JEVjU1bzRNTzJOUjducn
 FPUU9oaGlZY2lkNno5cXBOQk1hUGhtdUpIcz0KPVdFajUKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure that the spi_transfer struct is zeroed out before use.

Fixes: a0858f0cd28e ("iio: pressure: mprls0025pa add SPI driver")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v3 no change
---
 drivers/iio/pressure/mprls0025pa_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index d04102f8a4a0..e6bb75de3411 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -40,7 +40,7 @@ static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
 	struct mpr_spi_buf *buf = spi_get_drvdata(spi);
-	struct spi_transfer xfer;
+	struct spi_transfer xfer = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;

-- 
2.52.0


