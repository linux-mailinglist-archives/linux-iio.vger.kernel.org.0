Return-Path: <linux-iio+bounces-24759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362ABB975B
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C47C034772D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC8289378;
	Sun,  5 Oct 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="eAIyKqeu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E57262F;
	Sun,  5 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670416; cv=none; b=nTNWe6DMEERyCuurBXSALrYnDgkpXgi4jhrUqLjlF77wscfUjl9dYM2M5I8kgfHYMygJnlbQOk2wGaeJymtvfErwSFrOnkgq6p9I7dyXVx3yXe0VBernJZw1BVz1h8YC4c6EaUE1t0EJ11RpMxctGJH6xzWbDkJkxBXOwHR6iOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670416; c=relaxed/simple;
	bh=ZStNtnEoYdfEbR3uu3+8+mqIenUQ1N3Oztdq+aRQtGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1kQC20Xf2VPUAblKSiSAgBCbNk9RBFS7HEw4tzx2daUbJ6dyrLW5aWbV8wVHx4XvuCzvL//+02LnhE9MHc8ja5JTMZJmEnTe/Lrghz8syYLmPV9JiBExbGBpvRQF+wUHC0bp0rNBThkp4B4MHzYXE0JZfRjY6NMy662P/mtqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=eAIyKqeu; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 66F74173BEC;
	Sun, 05 Oct 2025 16:13:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/p4iPPjtngh6Ss7ODkaKYCF+f3L1GxI5+ozT/nhNihw=;
	b=eAIyKqeuO9l0QjYFZxuGGLs1VDZyw2v23yI6YwnOH0YPcJteQidgdy1Fh+7WBovWpyQ02F
	P13hYqEyB99jIyVwdYNXxEb3wZkW1X4/6r2iHtwDbP6qD0H3TUMIJvZBzzS9vU287ka8f1
	UuLN/k3sbZBKOiSFj/QYjjtQOSUeYlX6uRrFc6TsyDUQ2oYyRtguJTMxUhc1kYbKBZWQjb
	XsiGYmAnfjJl4fN/QYHnqUbZZmnS2Jz7jSN4OSfJ0nBqqofvjICRktuC9L2DLr1w837Pl2
	kiqnYn9f04O2YM3rlkiGqlcvkrS258y/JRdFNWikRdKa6RDZx99YKTmsYXK2EQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:13 +0300
Subject: [PATCH v4 04/19] iio: accel: bma220: shorten spi->dev calls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-4-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=ZStNtnEoYdfEbR3uu3+8+mqIenUQ1N3Oztdq+aRQtGc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnJYekhsZkRwY1lKdFF4aFR5MXFjVG53CitpR0NhZlI4ek4rT0VzWUcz
 UVpNTFlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNjF
 BQW9KRUhRcko2ZGpPa2xqMkVvUC8wMVZoYlFjL0dpdjJmekJObkhQWWFNcjNLT1RUdGxubFo3aw
 pibUhCWGUzaFhIbytQRTNCVXV2VEluUzM4aEVqUHR3Q0FtTnNkaTAxZndvYTkrK2llSHMwc1ZRR
 Wkyb2VYbytDCjdCTW9veHBzeXovcXJmVy9WakE5eXJ3M3phblpWUXQrS2NUVmRTVWNWTzhORXMr
 RzZaK1NHcUlmWnZ0QTh6a2EKT3gwZVhnRjU5LytpMzg0NGllaE1nQkpEM1J3K0hxemFhVFIwSnJ
 qU1B6MCt6UklZcEJmaVJGSU5BWFQwNTFLWQpzM0cvTzJWUGJQR25JWEZ1VnlBS21TNFZUY0ljWT
 VUV1FjeHJhSWZsUEpYT0QwaXVEWnVzbWZwd3ZGRUUzUXAzCmdMcDhIY1EreGY2MXZpNDVhSWFQU
 k1MRVB5TlFKekY2QmFRSUg0S2lOQXNrMXN5MGFjSzZPdE5jeTc0OWVuR2YKclE2VzYrNytTczNC
 d1lHQkpEanFuWi9aMDhmakJxbks1ZDJOdkdRSkJnNTF2aWtIMmgwZTdTaUtyQVpCRlJkeApuU2h
 pdHNhR3R0d3BkMUlKYUtRNnUxcEtXL3l3bDZvYXF6SWtKMzRkMkZqUlBWem1hbUovRnVhdnRZdl
 ZTWmNECjhya0hRTGdhanZDcXRpcWZIVTZ4S01YNGFaS0J0b1lEZUM0K0FWclRLbFEyMUhiK0FoY
 kZKVm1jQ0VvMUZyZlMKTVZzZmlSWG1rcFJoUklRUVhUZVZQa3dHclJhUURSR1RJUndaYjJsNVYv
 MDVRTmFhdlVuYzJXL1RjQ1pJaDVldwpYTlp4bHFNVnQ3L0Q0VFJ4b2U0c25CcEZNVEVIbHVCNXB
 pYVo2Q3duZW5iL1hXUS9jRU5pdnZENWpEMGhnS24xCnN5ajBXTmVVbjZFWExBPT0KPW1iK28KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Provide functions easier access to device struct.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 - split from bigger patch (Andy)
---
 drivers/iio/accel/bma220_spi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 8c313debc1dff7f4bae7c165bc555ee190996291..a5d2906321ae5fc67c0e1dc44651833c5e7fcb39 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -258,8 +258,9 @@ static int bma220_probe(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bma220_data *data;
+	struct device *dev = &spi->dev;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -278,19 +279,19 @@ static int bma220_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
+	ret = devm_add_action_or_reset(dev, bma220_deinit, spi);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bma220_trigger_handler, NULL);
 	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int bma220_suspend(struct device *dev)

-- 
2.49.1


