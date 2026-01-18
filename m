Return-Path: <linux-iio+bounces-27907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B93D39478
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 12:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29BF300E03A
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C342D5C76;
	Sun, 18 Jan 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Sh6f7vcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85822500967;
	Sun, 18 Jan 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768735215; cv=none; b=C3VPSwIXggaYU2mOCzg4WloV4sYhGA9ThfP9K6G0qh7HTVP3iISPQSOPq2xe2gE6+KDzAROSu9v98KmC3RhNFI7BvoVWyNTVwffk+zyQzUa+d9EpbEyrXON255Dl1nNM5dj1CgNGjJfO8hXZ7AJKenHU0BlsBFVzokEvGj0A1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768735215; c=relaxed/simple;
	bh=BUyE4hofyI1hsP2Y3IVu4KMGlUYAWhE/U/syf8VNKa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eZOLmMoYoY2NM+EHCkqDZJlVJ01DS6WBrKM+e5cBRvJU14ltPo51j2uwkr9LPAFlNJUsYRQMwZWkzUhxIpPGnJ0OJKAg5L0zT/E65ipXA6XtiV6YMdRXCVEIT05HdHShhHjbh4+D1h87AM62WesWVKAC9hq3ybZDp1bioOG0Uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Sh6f7vcS; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:501:4600:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 6010A160209;
	Sun, 18 Jan 2026 13:20:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768735201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cPYr0DpiX4M8/eA1UlTNkHULF3sR2JTqimn7+eJAIRQ=;
	b=Sh6f7vcSZU1Zx1O3fBo6GgYOYWYet7g+vwbWuNpW+2JXoSMTjk1bwsx8U7flhUhIdAjyz3
	xCb+FpZ8Oa5OUtWpX2LA2G+oR4RxkfNwaLzIN/FElNHcWqAVsR/pyBIr4DcTxHChI4Beop
	73zSO/L6o13Nf5GIPZB6nymnS/b5MM3zwEz+FXykoi0VXYx83QR6HapbU2jW/HwVrGUwdG
	wNHyzrD9hGATriyZwBFImWdyEg0EJza740gCnoIsij0EYJM2C3OAvRWIROVHXjQEHMR/Zo
	+2lshp5STNFDR4MuWiT092VAuQwmGwE+BT3q1HHlbApZREcDdmfXwniFSMHd2A==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 18 Jan 2026 13:19:39 +0200
Subject: [PATCH] iio: pressure: mprls0025pa: remove error message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-mprl_driver_followup-v1-1-5d5d6b03350b@subdimension.ro>
X-B4-Tracking: v=1; b=H4sIAMrBbGkC/x3MSwqAMAwA0atI1hZsURGvIiLaRA1UW1L8gHh3i
 8u3mHkgkjBFaLMHhE6O7PcEnWdg13FfSDEmgylMXWjdqC2IG1D4JBlm75y/jqAmHCdTYWmsRUh
 pEJr5/rdd/74fWZ9wmmYAAAA=
X-Change-ID: 20260118-mprl_driver_followup-bdab25d42ccd
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=BUyE4hofyI1hsP2Y3IVu4KMGlUYAWhE/U/syf8VNKa4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xzd2QvQkpkS1NtYW5zMUVTQlNQNmdJZW1qCkFwb2FVV0J3czRoQ2VHWlRT
 T0tpRjRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcGJNSGZ
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXhlTg
 pELzljdHNkeHNtYnJGUmNRekw2ODlVMTEzdFBsSUZIQUtMZnB4cW9zK3lJU0tBZm1Yb052UDRwU
 zIyeGJrayt5CmhSdUQ4dzAyWjNiZ0tLQWNVRC9EMHY1R1VsSlRzU2x3d2NvRjNVbDYwS1ByTUJV
 YWRaQmpSOWVOUUtOblZrVUQKY2VTQ0tlQWtCR2dDWk9PL1NKYjJSOGVhcTlqMk1mZ0VhekNLK3Z
 3K01VcFFCbWo3TTZZeHBwVXo1WGh3WXBjYgpSMVgvMm5TTlFGU2NkU0lnVnFXTE5DVlBXenFRam
 xWSVdHRUNneW5KZ0luSHpNRkFlaDBRSEtHM3Z6VjExaDFWCjIrc3BMSm8rMElLT0V3MWtSTk8zc
 TdXODhodVhQVlJzbTkxNGFWdWdPWXJtNFdnNVpvZ2JjbDJ1cHorRHhHQ28KK2tjeUJzYVVDdElO
 bXQ3YUFRU2dBdFJ1eW9nQW1KTXdESGpmZDVmU3VNa2kwZGdkVG1mK3lTamNzcVUxbC9lTQpOSnB
 VM1JmaTVlTmN3bjB4U003d1VoZlU4bkpzQkhneDJ4RThHNm1kcUZRdEFRa2pGUjNxN1QrRHA3Wk
 1YcFdBCmFFZkd2Z1JWOWp1cm9YVXJER3JieEdQbjROUGtFdE5UelVOZnRkclNpTDJRSnNzK1RBU
 mtGOEYwZEc2di94dGMKOFV5cVJWd1ZNQnZqbGNQZ0xKTjVoOW81SGpDVXZkODB1aWdPSEZkcXMw
 amRKaG81QW4wUTVLU2xVWVJJQmVQQgp3UjBuMzVuQXRadXNSSnA3Y2lYbnQ0TTZya0piTDgrRWM
 yOFZhTjRvQllZemlMRE5YWkN1UEhjVno1Si9XSmdMCkY0N29CYisveEZKZU9LY2I4UWxPTkpZWT
 grbGd6bnp2aTNVWVpZMENYd0kxYzJpREh6az0KPXp4Um4KLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Do not print a duplicate error message if devm_request_irq() fails.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
A tiny followup to the mprls driver cleanup, as requested by Andy [1]

This patch is against testing, since at the time of my pull the
cleanup was not present in the togreg branch. I hope it's fine.

best regards,
peter

Link: https://lore.kernel.org/linux-iio/20260116190153.082b9cc0@jic23-huawei/T/#mbf1be48fe2bc58c0c065f8598e80d623326976f3 [1]
---
 drivers/iio/pressure/mprls0025pa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 587d0dcad89b..e8c495f336ff 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -413,8 +413,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
 		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler, 0,
 				       dev_name(dev), data);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					  "request irq %d failed\n", data->irq);
+			return ret;
 	}
 
 	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",

---
base-commit: c30e80d68a7afb334fde7147ee0106f25dd58d3a
change-id: 20260118-mprl_driver_followup-bdab25d42ccd

Best regards,
-- 
Petre Rodan <petre.rodan@subdimension.ro>


