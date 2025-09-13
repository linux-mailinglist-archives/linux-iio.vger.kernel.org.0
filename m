Return-Path: <linux-iio+bounces-24073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A7B561F7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41C7A032C7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E892F60BC;
	Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="3FtmIt+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB62F3C25;
	Sat, 13 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778018; cv=none; b=Myo7cSAu9gIHmbbaU/avM8ELrVAE9/F59XXqh7TkwN7U8JK8qF3hab9lYAQvhsjiUYnqMxz/ht3M8W9+spPIPjbyT/2U2KIjKOy5gvnet3VjgVFHrpUetpa/eBCgF9xfj7buRoEPCXdJDXcHfWZlwL+Ni3yNUlpghBNS7P6h0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778018; c=relaxed/simple;
	bh=q9F8ym1zAoiBANpZ3eFvKr8O9iTkRIkPpVEpgfAzDn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olRMee9WHVAyxsK+QqPwDj0n7mE4csdWJOb1NIutzfY6fzohDupDsxK65icn+n1H2VvwfhoT0XTEGnj4YSKbqczAQk0PVyLACjVNpSp0GYuxmVszUfW+sljFVWe+IqZ8o2lbKsgtvNAARzKEXqc2ryZBhFpOHzQIrVvPMP7VAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=3FtmIt+O; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 07343173BF3;
	Sat, 13 Sep 2025 18:40:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Qdrrn79fEoUwqtYHfjMe1WJcl835xDJC7SRGwc0Ds=;
	b=3FtmIt+OoKPXegTeKnfpn58a90YeXVAJYu7v3+QWnwwwQtzhXkbUuYLN7eBBHeAwYaztWb
	Rs/pOot0fSc0wJeqwPxGDrQbzUeeD0lLcoCzDz1TBF3rDFAwlghRadNb6hkw4iXTZyFhY1
	PBUjnY3YL/N6gVht3Bu4pH2xqol/4J2INvSRIiU1rFMqvdtbg3WhGxlCCFSG3DLpRGqSyZ
	oXzp3AVq2noXd40sTsA+JbWVjBcqokcoVYm2oE49yE/YDsvKMogC9EviIG+3GztrYaLDwk
	1qQaSv8TAwd5xcVRyqBLmIVXgtMpK8nsR33sxRh7IABCNamP98walNfNVTeFsA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:32 +0300
Subject: [PATCH v3 11/18] iio: accel: bma220: populate buffer ts in trigger
 handler
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-11-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=q9F8ym1zAoiBANpZ3eFvKr8O9iTkRIkPpVEpgfAzDn0=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSUcUcN/1qUu1tQb5KHAk13qOHhtQkjjCzU
 JFk1SCN86GJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MOzSEACSCIlEBMUfFedceyuZW4pFF1UKmNh0Mf85kjwA0B2H693mWdLd5Ytlf8iIUUxr/ujZZlZ
 N4iHeUt5kLWJSGL9oDlwYgoXhjRFRzLQHjqOOg7ph9fzYBN1Xi0e8+lxjWKdJ9GiIMqGvRo2c1z
 gFP5C35jwuY/aM0vaav4VNFaTa/lUdHkRpJTveTRnsWVd4+n8Whx29x2KZU82PQr1w9XOYBzul2
 MymF4zV0CIboOvS/NTTtLJKtNQtt37czrMghd9hbAbZhv1IvzoGeOm9HZ4BUs0GL6DqsKKyRY1i
 xh/l3RCbf5p1jiBdTklrce3lBybVA1D3KI1CtXi5K2RZkJ/LC6t8xkNUue4NiHM0Azii3wY6pNk
 7KI0+GtP4JUBlE1UORGgnY9qPfRJeRmp6gJi0rClivTAlcZ2PMhTAVQ4NBCwkrQSHtSQKnmzjiN
 41GOF0V3DlsAWgmTsqr8vURZ8pLnjwcPi2XJbToaWHZ4IXrxDFMdd4Hy/5DAfbeU0wJ/tReIoEq
 ieoWkIyb1E5+zW5Xod+uZjlyxXH7IUSNGCqlpLDWZZf/lcm1LQrJ8g/hSNNcumOOmmClpbJ4Q4C
 D5lmt7J3lR4GYBmW+lydHnQJOD3KKkNuPyb/N/jKD0vhaGNHuy526FPAbCGJnIO5NEBwArNg/Uu
 BJgmpnsh59qU3YQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Populate buffer timestamps in trigger handler instead of in the
top half. Otherwise all timestamps read zero.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 split out from bigger patch (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 73ce9a9511734961c2c6dadc99c21418070dce00..728bf08c2cfb250266be56e69b11af4b6c4a1347 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -188,7 +188,7 @@ static irqreturn_t bma220_trigger_handler(int irq, void *p)
 		return IRQ_NONE;
 
 	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
-				    pf->timestamp);
+				    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -409,8 +409,7 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bma220_trigger_handler, NULL);
 	if (ret < 0)
 		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");

-- 
2.49.1


