Return-Path: <linux-iio+bounces-26711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F91CA1663
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3174E30C1295
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF03346A2;
	Wed,  3 Dec 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJxZg9eW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5B33509A
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789593; cv=none; b=TRKukFKmJMLPL4aGxntvjaOLsVsEvFYm6O+ZCZSo4iNOqLTFoW4NxqKFKfxpno+nonT+H3d7yBNSNktgheuFsqXZpywbNugAYu2Do659QvDJ1CZ3Yc5h3WMT8LTPaFQZ7VUvVzxFJAC3vFo5nwDYrS1LflOMcmevi71AK11NsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789593; c=relaxed/simple;
	bh=lqcYYe7AZ30b7MzwBteS2grXWL8UwmcL6GouD48/H9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIf+G3D/xnpgMW9YsLvVFni2A+iZWiVd+76Cbqo6J8bPIttUGcZDGwbYKs4/Ddg1ats3ONFNbwZ2LN+4KvYnzCDruLe//FaX1YbOnluYJ9fZKN15b3feqZeLxa2W+hOR/4jgMwXV1AmKwzOHPURwia+e62KL/n85jKTKz5p3Ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJxZg9eW; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55b155c9ab2so37686e0c.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789590; x=1765394390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvhotR7uliWVKseskW3+3ecpMP3/rDb6UoeROr3/zNU=;
        b=aJxZg9eWA2S1SQZt7D1gPSDIeCb2g4yC5sJHhSo/UpkA2F1ZIgPm9bi9otjIPOEtUM
         UCFLqMVQrmU3b4uHJoa4bCDu3+7T4sDffdttaON/zqsaQIZLgNN0Z7S6bevJVR9NnMX1
         lJxHX+3NJPUaF/ydca2FlzxPcuzUDS/k1IyHFsSxTEWVNfQ6srXLRSMimybRmPFPPedi
         v/Pt9yIZcd46bKaXANmxZ07EKOSfklQeu/YoIN5hRkS07jy4Q9iyH2bTUIr/yrONV2hu
         3jFH1dX3WIVRzWOy9yin3y++4Biul33Jx9wOtzdxWAQ5tqlu3h8PQdsJ773nzuCyWHK3
         92Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789590; x=1765394390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvhotR7uliWVKseskW3+3ecpMP3/rDb6UoeROr3/zNU=;
        b=enBAVtUA2EU39VzV4dOoQRRBJ2NnXitL6DYZH1Tr9w+TAtckbfqNSTuPLdNa/KNcHx
         beVzyAKFetCMIreXZRILFZRqcp6rmo2KHXLGvomnSBIt89Vz2VJO7QCdcir8SD0CzUUd
         K0n5WmfPLJdiywJYAfnOfJfAv6foAosw2KztAcx4dLUUkDyj35qmqiOhijJ8h4mhZTnI
         erh7JfaBNphgsdvhJtBSxOn2fA1K89JWy1ku3tNBHdBnRmh/5fsJorhGSqIgw93zxsMF
         RJSmMUn3MphffhX1Ky3wK2j0KsxbjncuAWV9kilX4QEubNKcTVZ8vz9vvhQT+6l6IvXI
         lTQA==
X-Forwarded-Encrypted: i=1; AJvYcCXtlxP5heAjVhfez4IhptvQQvbOFuvAzmk9LzkCv4cko+s4az0EZOWB6v8AozXFxEuJEi/ksiYyzBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4szFxLhWmWURx0aKwxoOY6I2QKO1NMJbYeFHzArYsNUAMopS
	OqrxgZiXhBDSFUJCO0ElyLDkEzozRxR00TE9i6dk1dmDmF3mIwvyK0Um
X-Gm-Gg: ASbGncttv4Q4nE3vO7K+b9qlmBiMa63o6IUeNcMy5fEniFyErvQR6dn+NGLeMMXatxy
	K8oIj+v87PmbXeZuU0dLoiTP5S4pLicROCOiYnQiX3PtO7M0aqby21i8oMmzUNqfDSOGHT+z2Jy
	+hWw/t0oNLeYQusw4IdFa/gfjwOX731BqqwknyM9k1jtPzUO1NRdn78rUKmkX8jxh0SmQ8cbRfZ
	VwPBpqlJZuSEuU0Z8y4rzSsm3sBoPDaJY7k5jBL4H7NMKMvlvA7Nd9nNjbFxKErpFl7zTv2xdn2
	4qf3ib9coHcvqF3SAdhY2tvjipHebKmtkyAeVL1W0yzw/y9fFa3WtmVxmcVScLC6N3XvReyWR1V
	lI0Tfjtc5OH2WvBO5CW+Tgq/FVBB5M+IWbd9EeNWCA6+ZAIVXIsaTRh7jvNnyqiC1gGOzTA51oH
	OL2kJpjQnTLGWpd8PvjoFNpeU=
X-Google-Smtp-Source: AGHT+IEiyV/ibtFwtwc2oJeqPoNV2V0Meff0ZG7V5RD5OILO+sXnR+xZAqsZFXXrkZ4mMtkHgjGHvw==
X-Received: by 2002:a05:6122:17a6:b0:55b:305b:4e3a with SMTP id 71dfb90a1353d-55e5bff301emr1398630e0c.21.1764789590234;
        Wed, 03 Dec 2025 11:19:50 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:49 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:20 -0500
Subject: [PATCH RFC 6/6] iio: light: opt4060: Use cleanup.h for IIO locks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2746; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=lqcYYe7AZ30b7MzwBteS2grXWL8UwmcL6GouD48/H9o=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGva7H2y5++/DiqlrvmoU/2pwcO1/tmTl1a/H1xgq1r
 nmsyxnfd5SyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEAicwMqzpepWxZ0FO7O6M
 1W4nDZQefwxWlVVPiM5oE/nb4P0v7DTDPx21L9OXFed6Llo51e3Tmz+HDi3I+rpsjnpRm9T6312
 fPrEAAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Simplify and drop "hacky" busy-waiting code in
opt4060_set_driver_state() by using guard().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/opt4060.c | 52 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 500899d7bd62..903963606143 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -22,6 +22,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/cleanup.h>
 
 /* OPT4060 register set */
 #define OPT4060_RED_MSB				0x00
@@ -302,41 +303,22 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 				    bool continuous_irq)
 {
 	struct opt4060_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
-any_mode_retry:
-	if (!iio_device_claim_buffer(indio_dev)) {
-		/*
-		 * This one is a *bit* hacky. If we cannot claim buffer mode,
-		 * then try direct mode so that we make sure things cannot
-		 * concurrently change. And we just keep trying until we get one
-		 * of the modes...
-		 */
-		if (!iio_device_claim_direct(indio_dev))
-			goto any_mode_retry;
-		/*
-		 * This path means that we managed to claim direct mode. In
-		 * this case the buffer isn't enabled and it's okay to leave
-		 * continuous mode for sampling and/or irq.
-		 */
-		ret = opt4060_set_state_common(chip, continuous_sampling,
-					       continuous_irq);
-		iio_device_release_direct(indio_dev);
-		return ret;
-	} else {
-		/*
-		 * This path means that we managed to claim buffer mode. In
-		 * this case the buffer is enabled and irq and sampling must go
-		 * to or remain continuous, but only if the trigger is from this
-		 * device.
-		 */
-		if (!iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
-			ret = opt4060_set_state_common(chip, true, true);
-		else
-			ret = opt4060_set_state_common(chip, continuous_sampling,
-						       continuous_irq);
-		iio_device_release_buffer(indio_dev);
-	}
-	return ret;
+
+	guard(iio_device_claim)(indio_dev);
+
+	/*
+	 * If we manage to claim buffer mode and we are using our own trigger,
+	 * IRQ and sampling must go to or remain continuous.
+	 */
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		return opt4060_set_state_common(chip, true, true);
+
+	/*
+	 * This path means that we managed to claim direct mode. In this case
+	 * the buffer isn't enabled and it's okay to leave continuous mode for
+	 * sampling and/or irq.
+	 */
+	return opt4060_set_state_common(chip, continuous_sampling, continuous_irq);
 }
 
 /*

-- 
2.52.0


