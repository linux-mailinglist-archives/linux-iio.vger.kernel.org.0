Return-Path: <linux-iio+bounces-10618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0C99E51B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309E71F23F8F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9FB1EC01F;
	Tue, 15 Oct 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFSkbutG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608751EBA0B;
	Tue, 15 Oct 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990417; cv=none; b=ZuiDD2ndDgwztnMuaF8WZkV4P9HjbXsuKdMK3aYevQ2O4Wf3jRX+PrP4ugWYqRM4xtwFS4NBSWy7qcjWORSI+eJW/qqfYsPGMmrHBFf8VGjeY3Wgz5D9dpdFXtPioE6U4N0VrT9yUujX3jqi5RGhePW+yfjNs/pcPNxSY81J0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990417; c=relaxed/simple;
	bh=zPhyRDG9F+zgzh0+HIEmtXBb7OQBzROgLZ7mJASXsvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAeLNbKzK+90R0rOOqCWvmGLjHBkrqf8Oj93yEuBHbh96f59yDp9zYoLIrybFBY2UHneEnOvHgk2plpPwZCALmKtBjlerfoJPAEPNNmuY2PBfhkO6lamiyrbuYPy8wWgioJSKVnLc/tDDsZ93fTmhaWsOsT/LO4dlnmHgNuMoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFSkbutG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-430576ff251so45679815e9.0;
        Tue, 15 Oct 2024 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990414; x=1729595214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg5C99O5lFsD3GMjKIKiUiVjWoF4T1zlBP/PbUaocsA=;
        b=AFSkbutG0edBJinqvX3i2EInMETdxjTZImq/9HnTG9GAXnonnmNMKcdQThG2O8kxaf
         RhCpcDCxfIcWLDJaNwtSOEyXEp1bNuGcpRIn2NTHoYiikQ7+4uolBSOj59nZ2Xdi8HvQ
         4Eh6INlypp0UIwlOd1GPDsH/EUP8jFXEe8HIa9i2udzdp45lxuRSyOHdrr9pLhgtMtLV
         pkw1w3sTJw4bEXqFNJ2pn216L07Rqh2Q7nvVgpDy/8tbzdV5Z/QGo38fgFsQUluXdaBr
         tqR/x8ThOWyXP2y3PPKwsYM9KJ5TEGh49fVwVnl5vKS8XtA6f4piNmB4gvdjEnEtWj3s
         RakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990414; x=1729595214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg5C99O5lFsD3GMjKIKiUiVjWoF4T1zlBP/PbUaocsA=;
        b=eYkjUOP4o2JPjuW8/QvBdnnaR2juZj1bdEz5QX7e84BU3kpPGCm/1Wy+EJK7bxjnKr
         k2gHaDvk58WG6uLEqp6f08vXPKXCVaeQMEvNdyKJUDGLjx9+rwwlo/6KQRpcSPdONJMc
         jFPVvihcFB6PgNmFMXUpRKc/3xJOFO2F6u1syEAkBkvor6SGam7cnHDUXG+IHEzQQWo/
         4WkpJbb+UZePa0pIRNk1QExWgJUpIlwItHymBIMBlFPfVADMLOzLkdrvYVA5L7u+YjID
         d0Avl0+CddXj8FKXt3F6ivefivfVk00iX4jtttx2tPyxfSJx8vzbqM2g4v0mDE6Ht9e+
         vVaw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMWRy3rXVtYwrOw/ck9Caw1SDg71YAwpJROT0eisovofPJ4JH5X6zci1NoIc3t+uU0PydMGbuZxNuiB4=@vger.kernel.org, AJvYcCVl6nQc/BR2N1ldXUzxluFlLl2Zyn+f42+eanTYuOKyufuH7llrAu7/zOn3j5AkkCZkx5pTBH3LXntEJQ==@vger.kernel.org, AJvYcCW6ya1iBRnyq+28fQMWgM+sYNumDSKlMIksF5+R35jk/3Pyl/9Iw4QOk4gFxsj4HVKyOrmBWfYR5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYY7yXvPakMxu+BIl/bxd88Trj0wTtgqjiOHikPdb765FGku/
	+Q692S0RaAb3Mr3qcco+ehPQYFJlBjGyl6claBxaR+tHgarvgbkA
X-Google-Smtp-Source: AGHT+IG60MSlabhsrBA6bEZ2PUeFwZkstarjm4Ih1FAL5vlJRowBO16QYUrs13k4ISoJBISPOpLwkA==
X-Received: by 2002:a05:600c:4e8a:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-4311df435e7mr136981645e9.28.1728990413655;
        Tue, 15 Oct 2024 04:06:53 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a10dsm1289181f8f.2.2024.10.15.04.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:53 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 15 Oct 2024 13:06:38 +0200
Subject: [PATCH v3 5/5] iio: as73211: copy/release available integration
 times to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-iio-read-avail-release-v3-5-ac3e08f25cb3@gmail.com>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
In-Reply-To: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

While available integration times are being printed to sysfs by iio core
(iio_read_channel_info_avail), the sampling frequency might be changed.
This could cause the buffer shared with iio core to be corrupted. To
prevent it, make a copy of the integration times buffer and free it in
the read_avail_release_resource callback.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/light/as73211.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebbbb37fdfb252b67a77b302ff725f6..c4c94873e6a1cc926cfb724d906b07222773c43f 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -108,7 +108,8 @@ struct as73211_spec_dev_data {
  * @creg1:  Cached Configuration Register 1.
  * @creg2:  Cached Configuration Register 2.
  * @creg3:  Cached Configuration Register 3.
- * @mutex:  Keeps cached registers in sync with the device.
+ * @mutex:  Keeps cached registers in sync with the device and protects
+ *          int_time_avail concurrent access for updating and reading.
  * @completion: Completion to wait for interrupt.
  * @int_time_avail: Available integration times (depend on sampling frequency).
  * @spec_dev: device-specific configuration.
@@ -493,17 +494,32 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 
-	case IIO_CHAN_INFO_INT_TIME:
+	case IIO_CHAN_INFO_INT_TIME: {
 		*length = ARRAY_SIZE(data->int_time_avail);
-		*vals = data->int_time_avail;
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
 
+		guard(mutex)(&data->mutex);
+
+		*vals = kmemdup_array(data->int_time_avail, *length,
+				      sizeof(int), GFP_KERNEL);
+		if (!*vals)
+			return -ENOMEM;
+
+		return IIO_AVAIL_LIST;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_INT_TIME)
+		kfree(vals);
+}
+
 static int _as73211_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan __always_unused,
 			       int val, int val2, long mask)
@@ -699,6 +715,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 static const struct iio_info as73211_info = {
 	.read_raw = as73211_read_raw,
 	.read_avail = as73211_read_avail,
+	.read_avail_release_resource = as73211_read_avail_release_res,
 	.write_raw = as73211_write_raw,
 };
 

-- 
2.47.0


