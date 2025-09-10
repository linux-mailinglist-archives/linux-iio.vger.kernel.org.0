Return-Path: <linux-iio+bounces-23917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEFB51028
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F301F460E00
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5F30FC39;
	Wed, 10 Sep 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="jq8ZgLop"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597530F554;
	Wed, 10 Sep 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491093; cv=none; b=EaW3rlFluVA8b6vyiBVLwVuE76aOtELkh69jM/HhH1yonOJ71kpSCJsW/4z9BCpe5CXyAMBmaz9ek4rfq65cwFKN/iHv0KxyeNO+kV9BDXviW+Q9q4M8GK3o1+QPY6zopBEVM7qg8f+6ZJLWoBzhx2bp921vkf8vyjnA7E2d6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491093; c=relaxed/simple;
	bh=xCQ4R5IipziaPFirWiYAT8NBRrNTDlTpdFlbr3ypQUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWtAEnC4Z2VtvmTvXrd5r/MdbFdflzFNNCqTouRfUltmA9cCq0uWpX2T5BL8Yi8WcUe0PwZEoXyidzifJgyMMM3JSTrcoFhRv8dLamMN6MjjXlJ42c3zr5IOtQ4vrYcxsiWjEO9pcEJ00TbnWKfwNyWQgMY8Wo/KAi1xWVkFopY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=jq8ZgLop; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 16981173BED;
	Wed, 10 Sep 2025 10:58:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdEGmUJ4rrZAPa1caKgA6NkLY7Tuz7+KbeKrR9ouOgY=;
	b=jq8ZgLopmWzKvNx9ItTgcPQtTr5e8B1fJvag2PW97RB4qpqVPze6b+/zwyVGi6QSn/oDYa
	s7/b6H/NRvAygkQjEbO0S17AiTMCb1WUTBIkAhGPCc6NbPgqZPdw6+o94l4YDKAfWPJ+wx
	WTGipaolSGVIsDj8gMJjnGMyADDIsK02ts5lSGBPUohnv4Two5kDaA5GCRtnJVKJGnn05Q
	ugo1+3TWsS15HbLaR0BGl8rQd2e92UXg8YFC2DVFjLSGPSk5RjD9j1FaP/gQBq+N0GGIO7
	Mf9ljkNH+a8ABuNZ13uo/a/hO92hJnSIxXIDPfMxkEUiqj71tOus09Mqb1CbQw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:10 +0300
Subject: [PATCH v2 05/14] iio: accel: bma220: add open firmware table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-5-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=xCQ4R5IipziaPFirWiYAT8NBRrNTDlTpdFlbr3ypQUA=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+HssSDDQ8jhhQO7AnxHyi3PU5LdXf9CtEC8
 OQxdLZi55KJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MPdaEACaVKrrAeuji+1wneND0Qor5d6hDsQ3OpBywT4R48HXFYpd3RzfKYds1SXQ3I4lAsCsjmJ
 JXpqWiFgCBxhmXs6BPBr1M4+rmwA9Ej/3ORJcT7sVhGcuPeXhziJFJ9r08etFiiTD2/ewfHLSLY
 Pn40KCmkaZKWnTGaok2YEUDd+1a8UiyKMhMNTPgfNNWmUZkfADa7A1bZagJhthF8kvr74oGDKjT
 YBu1bs8Wnr+JKK5woxqtsIjVl8PSIeaVYTYqN/WghCxR4fiRjCWnYgEKW4n8jw3YidwIGrt1LU9
 MdWdZS404TT1OqDVVraWGriU5eKykUjFh1BK6AHKhT8wGflai2uQguQtUyDvLi+My0E1Lnn1cNv
 shG1ZQSKlwUgpiYQq16HohPAUlQXwfcV8bksywEWRcRhgCX4NrmZXjQfK1sFOL3JBgHxnCAfC8z
 K1HL6iYiTpkOxKSWMXwOuuJoN5ChVxgaOZ3L0DavcHVs2Hoty/rw/n45UabbHTP+nFwkglk/JlT
 SM6SBa3NiRchFKn6ladej+zQdoztPp262Jgur0Mv6DTzI8++8xplSC0Fdd5yAwUb+7+lkjA9GW7
 KzyjZwZqOCmClBddwBA8lwJ3t5eGn32s4dtYHjnYWihdxZ4GGIvdtS3iCbMivubeM3uyFzSgDaa
 05ZAv7VqWjLfK2g==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add open firmware entry to the spi driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change
---
 drivers/iio/accel/bma220_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3ad5e43aae496d265a8cf198595bf824f8e73692..78820d90e39119d9755b6266a8329e11ffd55723 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -32,10 +32,17 @@ static const struct acpi_device_id bma220_acpi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
+static const struct of_device_id bma220_of_spi_match[] = {
+	{ .compatible = "bosch,bma220" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma220_of_spi_match);
+
 static struct spi_driver bma220_spi_driver = {
 	.driver = {
 		.name = "bma220_spi",
 		.pm = pm_sleep_ptr(&bma220_pm_ops),
+		.of_match_table = bma220_of_spi_match,
 		.acpi_match_table = bma220_acpi_id,
 	},
 	.probe =            bma220_spi_probe,

-- 
2.49.1


