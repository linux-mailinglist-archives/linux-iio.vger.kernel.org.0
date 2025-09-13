Return-Path: <linux-iio+bounces-24070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3DB561E7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6733F1B202DF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6F2F530A;
	Sat, 13 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="XC8lbWD8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DF2F39D1;
	Sat, 13 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778017; cv=none; b=qSZMWhRszzWTOlvluXBmYYXJ+C5R+aS/QpAz935VFr0jefFPLuU9xZtxszZiwgO9UPpCn60ofHkvyycwgdkoBXVr45bAnuY8bRozAju1NWy8JjFIXPyAE4Xeyec4iy3+tQNaELODTRJ1NJ4yGcJVdf5EP0jMdH/YM6YGPOeZX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778017; c=relaxed/simple;
	bh=OHJ4r2UhWXoad4ezbOvnzHrBuNRSzuisdgv6HjeeqcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2JuOvYyg9VK8If3hMby/r6KmG0mCHWDgavLHhumnC3EdX3I2FbIU2u9f2yi4xbblTueHTgcYyVYoRpITLMP85OLHBr3/tOXIwGzxhWDlINO6x2UuTjLuTYnj3zi9ZoancHqrWQ2ThNY3SvcsAEv/nX4Xz7SSWjrKxVOwIfh0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=XC8lbWD8; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 37BBD173BEF;
	Sat, 13 Sep 2025 18:40:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLSHO5yDS8PTwMEW/Tqx3kDVp6uqBHCxdLqAzZrh9n0=;
	b=XC8lbWD8dpsFb3aCTsZpEz7wQXFESs0A8NHSn2GOEMYZxftp2MmAyEmBcDNID9l0QdotDc
	yAe9BzgizDji9rEJV5csgqtz547Pa0XhhJdhA5yajuedCI/YuHlieQOJTcbJNc2+13Vh0w
	X+pworq3gfqw+FgVoeNEGRVhF/J+6UFYH5m9Q4RJZIq+uAJ+9yfzRpuglVKODtIJVlJock
	xHu4Obq+Ds0WVqQk754gvzIjkYOF9zZJ4Zn755E7QL2YmmYtPSy5Dvm8zzmLIMdUqQ36PP
	DDsv7vFFhsKnovRh6Vwzn/Ts7FPEU6jytnx1v1bSFJAHcSCgrJtkiqpeNmKrVw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:28 +0300
Subject: [PATCH v3 07/18] iio: accel: bma220: move bma220_power() fct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=OHJ4r2UhWXoad4ezbOvnzHrBuNRSzuisdgv6HjeeqcU=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBS4HwOghJfCH/vrhKd4s0KMYwhHZk/Xtv4v
 FdpEfK/jyKJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MPM8D/9m1kfk8eUPYf1CS32CTC5E2CtBr6G5UjCLvIR/q2QAoBfink2tyIu72iH6+dz5GKCHm1w
 ldwy9rPxT2q4m41mB/fbJ6IziipqmsxHdAmOBbLp3VZbWvBIo2bx7NSSGI7lvesaqJm9+/jom7U
 /j0p5MwtLdxCS0EUKSsAaLxtB3Yb65aId+z3sy4oAPDUQD7//bxK/CXVT+hY7lSUwaBKsQlMNif
 qbHF5KdG6JJGoo2Nq0sV/3fEyUpE4ah/NGs467tUesLRCpJ7201HRhS/slF4cfyXDLU1a/SdgzW
 9O/qqHYOq4rk/Ak68EMRMlwwdA077jmfueOnae8+vRrAST5Pp3/fFxAbI089VZ9fNN5eX7XXqGY
 7gyVumg2W6BxlGDFRw7UWpQfa6VbrK8M5f5RseRwN+sC4hnfIX37/Q5VxGrcEO9crZd5dJe1DIm
 Rtn5KblG0OQnAUt2JmBh7e2BIux8VZt19y17KmOT5Tk+mst2ULY2RwepGFvRAPDbLkWvetIFue+
 srQ8Kfj4APnO764VgoJord9KyinGa3nyYe9TuhY1P0lQD4FZ25J2ttwqXqD+8mSdrPs+gbcEW9C
 0h3FAKVUehRdJhv28yiXPjOJI1B55mhX1M2TD/HvAX1NJfVyMJ3HM3AKO5T/a/CNH+I8k1AM97u
 tKukNAkekyxWmXg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Move bma220_power() fct before bma220_init() since it will make the
next patch cleaner.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 split from bigger patch (Krzysztof, Jonathan)
---
 drivers/iio/accel/bma220_core.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index b6f1374a9cca52966c1055113710061a7284cf5a..dc156fcc1435ace9bda5fabc87864f38ae7bee05 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -203,6 +203,30 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
+static int bma220_power(struct spi_device *spi, bool up)
+{
+	int i, ret;
+
+	/**
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
@@ -230,30 +254,6 @@ static int bma220_init(struct spi_device *spi)
 	return 0;
 }
 
-static int bma220_power(struct spi_device *spi, bool up)
-{
-	int i, ret;
-
-	/**
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


