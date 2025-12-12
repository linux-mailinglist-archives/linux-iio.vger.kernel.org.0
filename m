Return-Path: <linux-iio+bounces-27036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792BBCB7B46
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791273071968
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B704299A87;
	Fri, 12 Dec 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRohjAg9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A94EEAB
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507552; cv=none; b=sIgoaFxXw8bRVhhLqTF39+B8jZ5Bpy7d9n/yGElt7HQSbsqnpf7rQC8ZL90hF6ZW9Z/PUux/UuimclQo8sZeXoS7ppMGVs7SC10aipg++JUw+/7fMxS2zY9o+SCsfDScipvN5wrMoR+lV2HOJS77wrJH5ytbIedZpsAXujz9Yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507552; c=relaxed/simple;
	bh=ROdGE9UYn9t3GKB795F+w4NovlxCcnGyj52uJR8yT5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVU0hCY8aiJ6ZT2lrKTMFCUeN+kT+WCiaTKiOD/L+tS+jrMuB+Vt1Utl7K3YOYbPEu7c2kATgq7oQdMSVNDuGSmxVoIeL279puivUqp5VkT+5ne05CEx81IlwB0dTbyd46lB2dzk9nG/s0wwnbZVZFsudMBR5PxRZDu9K5WIsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRohjAg9; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b6a66f155so313670e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507548; x=1766112348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYZRIuaNXC2L9F0wrej4K4cGwCXMfBa56Esw3K/nF6w=;
        b=KRohjAg9pi+ViCK3zzHXWnMXcvkwZP/iDMOdPEiQBEvZmIy9FLLlAQG095/jimVBkT
         WWTOvTNA/IdaovkqNwRV6FrFa/+AFQd6VXS3CvwTfHMkRjmiVF6Jal0jeHAcC5+8WWrt
         nPq/JXJVeNV+NL0k1defaXVdON9Q3yxoO9YiESfXbQtgizjRtEXJH0eqsUtBX/+cgEZc
         Ph/V0zrKykgUYCKcY4y1gLLogIwA2QHAVWkmFlhIsob3SNNV+UN6F9fAEdCPYh8LsLsx
         J99osHEdEd1wg+C7NWkBxARlYA6xh5Igw50Y3JIWRXrADJ4JIgmywtfTDce6HMefjgD1
         X1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507548; x=1766112348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYZRIuaNXC2L9F0wrej4K4cGwCXMfBa56Esw3K/nF6w=;
        b=rQrYFD3xVajpcpC3Uo17dQ0vtoNhPSWdbbmyo601UCtAqzpH1R9anpRy/GrU6WPhh6
         l1NLQWquyIIBTATbNFtca+dEcNB0QdX0uWReVIHDOM4ovgkz/0B63DxMsL7Js2QEOLgz
         xnjRocFbhinHPoe/NtjdB0Ch+7pDXKSP8o+zwlL6gH6iYYS98i9pQRHv/RXkmFVTg8v6
         o8YZJXAc/zpEu0xksTeqqSyabnPj2HCz8cq94nj3vN+C8Gap3Vey4DX8a2HbEgu5eeUK
         WmdgIPcLT4zZNbdgQKhQCA+CUqN/vndZnbPh1IJWHHhcaZG3HviigXZug0EXLmH4HHCv
         Tk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM6iFjN9yeJg0fR6C6+x2S2Ao2eoZbk8PMggYcDJsHBqBXM5Q69XswU1v5qJr3DwuuKNiG6iDAnu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYmS5DW/F1C5utK8S7dPuPRfTn1f554rZwul8h4xkVY8+lEMp
	yiFLCLwgYYf3+0DYewIK5baQvKLiMmVafXinX6bVyIOQBlDUR/iUF2Ps
X-Gm-Gg: AY/fxX68pJIYIaZqkf7lrwjLCfF4dwwXqM/l+ZMYVCv/8ECnbDoUT7B2LSLsb3mQNpJ
	0Vk6bybK39H0AIm1z7Pnr0+VN3jCisFKF5vaoWqlLScorBioyKQoiSZkGRjWXB/QUbCRUhjA0V/
	kb8V7jM5oCzSgV5pp34uNn8kofvMbUCSWG2paA+o0I0jLPCjQWLhtUdVjN+UEJBTfnp5igqvUNP
	CXjIpAU73q1QQhmnuA+9741u2CNoTE3kw4d3p4I5QfZ/ozKv16nBa80aFziEStyZc52DagOwNNA
	Agm1zO6FO4PyVtQnpD2iNJyyFE1XX3qpKgS9cNBnETfam3fiN7lvPYIdjIJLeVWis/tJGcXIx5x
	3ijYGi+RRGphjdvh9nbVzm6FbgMlDHAL5ZytiN+L3DHqpeXTqehUtN9ZO6tEKhiQ/MBKy7FhkHJ
	NOZongrd5CxuG5sgHcy+OjwcE=
X-Google-Smtp-Source: AGHT+IH5i7dtBfVcr5pIDPh38IKpcxO7iBsFvqjyiDMjJP75f9PBiuTE5pSrUZG3ggjTiJvDMCDRxw==
X-Received: by 2002:a05:6102:54a2:b0:5dd:c568:d30d with SMTP id ada2fe7eead31-5e82783585dmr129533137.30.1765507548500;
        Thu, 11 Dec 2025 18:45:48 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:48 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:25 -0500
Subject: [PATCH v2 7/7] iio: light: opt4060: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-7-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
In-Reply-To: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ROdGE9UYn9t3GKB795F+w4NovlxCcnGyj52uJR8yT5g=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSeZoj/PfmBy4cD3SRt/BpS75GZkG51a/1Wv7M4Rx
 w1behXWdJSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEXrYyMrSsPeb+OkilQE3R
 dts/rp81J080b85Kv6J0cPaRT25H7jYxMiysck6yNzwq+1b2Vs9Snvy5DCqSH+etDbdJ+12cmu8
 wiwMA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_ANY_MODE() cleanup helper to simplify and drop
busy-waiting code in opt4060_set_driver_state().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/opt4060.c | 52 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 8cb3fa38077e..943e5963d568 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -302,41 +302,23 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 				    bool continuous_irq)
 {
 	struct opt4060_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
-any_mode_retry:
-	if (!iio_device_claim_buffer_mode(indio_dev)) {
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
-		iio_device_release_buffer_mode(indio_dev);
-	}
-	return ret;
+
+	IIO_DEV_GUARD_ANY_MODE(indio_dev);
+
+	/*
+	 * If we manage to claim buffer mode and we are using our own trigger,
+	 * IRQ and sampling must go to or remain continuous.
+	 */
+	if (iio_buffer_enabled(indio_dev) &&
+	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
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


