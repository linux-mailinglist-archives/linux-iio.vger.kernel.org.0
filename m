Return-Path: <linux-iio+bounces-23925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C209B51041
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E49E461461
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B93115BC;
	Wed, 10 Sep 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="3EwRyub1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914430FC2E;
	Wed, 10 Sep 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491096; cv=none; b=XHVTbXUkoVaiUXLL6RlSxDtv1KEVibGAGYDNlD0/S83TWHXiIPFhY2muhYfrZN4H6zOAUW0nNB0SLrz3+s+vcYp/bV7v+xv4GKIob0TgMUKbbXpVszmLQZDz9apmlCfZGGibOeY1+I0Z3iPtlJDR1cnAG+4skW7S1Syhm1zTn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491096; c=relaxed/simple;
	bh=r8E2kS8o52+1PDCkrtd3/+EP0uEZzLwaZ9SfpLhys78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dE4NK7WzUOiqJ30QzmryVrNmIG64hX1VTicZlQ4+tuYKgKxqlEFBWG5TbU0/CRV301Q+9U2lQZhjBFanJ1pHCKjMmoza0ftpkdPg/RcwXYxDMJ2DQfZPwumqhy2sS61LqFbNaq1jgycV4SHCMQi0yqrLFoKYDrkAIm9KBqdt+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=3EwRyub1; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 560D5173BF5;
	Wed, 10 Sep 2025 10:58:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iVjreKN1foDjJrC6jfgK3nQqEZmjmSpIa1S7kHOMC0=;
	b=3EwRyub13DY26Q09buH5Eloz8DFApaGLtHjWxThfLUOqb8i2bBelVayi8BNv6zP4hBfmlX
	u23ICEQZtsFEqwkoIwAN0v3sX2yOn2AZcHrH+3lQjfgPbY+4jSb6II7tG4QVZR8c+Ut1VR
	kEYxu0naw3agqpLdhIRE0bstiwr/A5E8ZO5HhBKmvfO63278R5g8yK1OmSNMLcu6GFXUcq
	IohBvpdWIX6u1+Zbf6+5eu8jQ1H0a1M/zp6Sw1H31WTYucWam82jeCK2DUMg9/0PRqWCR7
	qx/LTHqC1A04jE9kzA6XzMjQSsKJQnl3IaXiP1mu7bX7Xx2L1bAH3jz+7CPHFw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:18 +0300
Subject: [PATCH v2 13/14] iio: accel: bma220: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-13-e23f4f2b9745@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=r8E2kS8o52+1PDCkrtd3/+EP0uEZzLwaZ9SfpLhys78=;
 b=kA0DAAgBzyaZmYROfzAByyZiAGjBL4ehctbbFBr0YYeRcrWJDYc2zL6i21MVoNC5iX39Xlqep
 YkCMwQAAQgAHRYhBNgKf8F2FRk17D5fqc8mmZmETn8wBQJowS+HAAoJEM8mmZmETn8wPisQAJpR
 mDdmZ/RQrhy3vWt8XMbHtLbsOS2dN9kUaHUnIcMOyhphBqj1+k89qX0ZVKaLtYCZhIWafDt6VNS
 rMdFgrgmPSn34funSame97dLznPviJTAcc8kIIFlGwPjEkV4aNOxlyJkvumdJNdrci4NZgivURt
 S2ckhmFgbWRkvwDUxMfU7DkOygesi1FbuLVeX07r+8tf2yBs81y16wdVyVxFAHyRP6ta5jOFsxB
 6G7xHebbVoJgoYNmAljoTCIAdMgt0HHUpN/sRLWWsj6MTt/NyaKngNDwTJfZaSNXzxSIyfvx7jO
 TU9Yl8Qy2sSlL/BoDJjNz/26RlQTP8X8tomsjUjC5tt3xOv6wezC3R+XWAmtWyMI6socppdb0WP
 2XIQwoUPOFq85K6ojEf9+z57nkqu6eMu9a7o3uJNb1BTDqmKcrXj0ox53m0nUbFqR9gu6nSCgrs
 dtPR0XOeCb7eVm+urVE6GXyY+FLT2zlyj/jlPlxLT5QCO+XRSy1Rv3tOxM++LMCbEtrEemKciWZ
 UBlDbgfqne+ONpPy7BpOeouAyw8GqA87czqZNnsO8ZGTkKUzRFPVrB+M8odaur474xm+jHwd1rN
 yr5lVpJ0i5cQbB2drH7IcSRt/bgXixhkGD7XB433fpyTkcWYSYuOFoBiW3qSXobOAnZfvy3pUsV
 v3bWN
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Allow read/write access to sensor registers for use in unit-tests.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change
---
 drivers/iio/accel/bma220_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 16a1aac5aa178ec06dc26e7e632f8ec5f43b5f78..981b0fdc306e936ce9fc45439f7c164f50de50c4 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -379,10 +379,21 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.debugfs_reg_access	= &bma220_reg_access,
 };
 
 static int bma220_reset(struct bma220_data *data, bool up)

-- 
2.49.1


