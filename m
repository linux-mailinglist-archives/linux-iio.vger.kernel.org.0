Return-Path: <linux-iio+bounces-27160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE93CCB883
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A00330133CE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5057314B84;
	Thu, 18 Dec 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="JwYTSNxg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F068274FD3;
	Thu, 18 Dec 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055987; cv=none; b=u7Xlp4Tg1uJKUWERYnJHCUI8B6v/iRBMc06iTCOxgfp3zJNd61esdIer7yGlXj0CqUynUpJc6WOMkCZw1FrCfI0X0hPOC0YovRSF+Ln4RmtQR7sKAqPDXAV9QmQVJK7Ov5awOJ4L5hstjHOSoQFIbsnceyFPXPGCvg2PuZ8aB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055987; c=relaxed/simple;
	bh=YtdLkwaEn/Njh+9YgIYuZTDDL97h5UEgYVTAhMkgLO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3I2Qtjr+DzW33AFR6tLjgvrdxBpVYtYFWCba4cT50TKPlHkz4Wfv4PYOENokKA48wZB3Zp0ofjbbaTuhdPMVJyvWpfp89c0z7Iw47NBm8tcSpyFGTsrAN5F/GDLoOSjzwVu3zi2aR2TA3bRlPxcaS9ZMKs3jDDcGyuP0nxrakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=JwYTSNxg; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D465816020E;
	Thu, 18 Dec 2025 13:06:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5GrPTT2kTPYZpkdo9apif/m7Zhj1Oz7ayLuuaoyHDg=;
	b=JwYTSNxgCzoojkgu7MXGYelyfquE2+h6LHNe6eSo49PsvCmXgUJ06oxRpQfKTFKdhOGP0k
	FqL/WMe/Rv6Nb0jHXYgZnyCjatnQoPPLzcmr1SKrMqbdyf+IGq15fd239zxEg/FFZqqp/q
	oV8uFI28TlHKtUSzoHJ0Ol0B/FM+UGw1bwMY4ZAeA4KieTafGm2dxaoRnzTYLKFloGu9dA
	QrPrjYbz8wF+xypIGKTpTh+veP7+s3k6gfH+iHemaz2N4vCX4UNzpe30/lCT5R8suWsia8
	x7mxMOqFonBxQ3/f23EK6+Xz4r0/pqUm680+nPsEWvLHpxq+XcyjCVr+KAkKdA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:47 +0200
Subject: [PATCH 05/14] iio: pressure: mprls0025pa: zero out spi_transfer
 struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-5-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=YtdLkwaEn/Njh+9YgIYuZTDDL97h5UEgYVTAhMkgLO8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEJNb1RCVjFKb3VCZ21KaXBlS2ZXbFdZCnNNdzhYSHdFOXljMFlpMElQ
 aXpmVW9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQVR
 BQW9KRUhRcko2ZGpPa2xqSmdrUCtRR3ZISC9Bc0N2L09nMlZ4RGtUbmRyOFpJbGtjNE56M3hqbA
 pwaXVaSFhmWGxZUEIwRWVsOWdaeHlDeExCR2RxV3ZwS1hqL0c2SVB4M3o4d2FqaGRsZVEvOGNza
 U52OUVoSXFYCjJmSHhPcXJQVy9rMUpyU2R2YXpEaE90TGtEL0FQV3NZaHhvSjVhR1JGQ3ByUldD
 QlRuYnhoclNNSE42VEZ6RzgKZEJaQkpFWWgrcWtRL1lrOW9HdHVEdUtVcERuczFmY2Q2aE1DZmp
 Qdy9jNTBIU0lKY0gwNVZVQktlZnpmd0trUwpKdU5EcUluWkV0Y2VXaG9QWndzTFFLWlJwWGtwR1
 hMZDg0Y0FxZVB2dXNqemM0K0luL2hkeW1uQjNKdFBJR2QzClNsSXgvRGRQaFpVMFpwa3k1Y0I0Y
 mpXbjVrL0Zqd0c2d25NUHRrTFFXdCtadVp5TnJSVC9JL2pQZ2lrU1JPQ3UKTHN3dmVIOEFmck9r
 ZUlzdGt0MlR0b0Z3NmNpREFEWGJpWGltR1Z4NU9aTmZhWEpCc3YzbFduckI3K2RIZGpGSgpqR2w
 3Vkd6ZHdJUi8va0U0MnlnVGE5Q0lWU2FleS9ZV2Y4YVZ2REVFdHdRbk9YRC9uTnYxTThBWkxRYU
 MrbGZhCjVERld2Qm5GdkVESjdyc2wwanFWcEJrTHEvS21VZXNQQ3FUUU9ldHdkR2ZORjhMTW81Z
 Ho3dFV2T0FLQ0pXWEgKSVJodi9aSXFTYXBFTE50OHdvamhMMSs0dDhqUEdnT09HMTJhTmQzTWVE
 RmNCWGhkUWxxZlRLbTExL0xNUE9MYwpPTWhiYjVCUXlkMnFqVHRRSklrTkZ5V2J2YjZ3QkNiSkN
 FTXE4N0xSTXRWajlRT3BHbzdzbEp6Sk5hZjFyYXFDCnFFZXJObzhick1nZ0dnPT0KPXBTaXoKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Make sure that the spi_transfer struct is zeroed out before use.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index 021c0ed812c0..73f0714f66ca 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -21,7 +21,7 @@
 static int mpr_spi_xfer(struct mpr_data *data, const u8 cmd, const u8 pkt_len)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
-	struct spi_transfer xfer;
+	struct spi_transfer xfer = { };
 
 	if (pkt_len > MPR_MEASUREMENT_RD_SIZE)
 		return -EOVERFLOW;

-- 
2.51.2


