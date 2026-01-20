Return-Path: <linux-iio+bounces-28034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01845D3BF1D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1582D4F23C1
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226F3815DB;
	Tue, 20 Jan 2026 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYYuH+kx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC737E2E4
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890089; cv=none; b=ltXtap0v7cMpp+9lu1/QlorCLbQXYwrXH9Nu9n/nakv/NN5HQhDAvjeYZ5Whfy4Ct8HcLtDRbsJCvIjr7WvYoGPL4+A3jgRX72dnbbKoY28OwukYq9Z3zDFBC6OuFDa3xhOLzLq/2V1rVMjA4ARusSEsJ9yCpu2v8ayEBYmkecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890089; c=relaxed/simple;
	bh=K/GzZXmVDH5d3ajOh9Vses0jzRTbszvo9JEIlad+htc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4pOEIylUz4e5BG7fG92VLDorjR2OQJXLPTLpmHD3CJrxXDegF1Qih9WSFw/t6dymgB+PFfufZOeq71QK2CieCpOJmslGM/skGGh3XHilCcxUxydFDuYTsVXMy5T7ZJwvPDGjnbZsR5qhMOVDF5HKNE6luoXYJONSLMc7h1hypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYYuH+kx; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5efa4229bd2so3299390137.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890087; x=1769494887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUuEqo1bBPTtYvx/6MqHHwRERlW4p1/ugxXmq/ssirA=;
        b=FYYuH+kxM1EGSoCC3HVZbHB6CGQjjBoqCO9fH5NY+5uq5ECQ5hV0w6Nuz3KBeAfTBW
         Q43b296pQ+H/76mHpGFhtd6voE+ahyBaqxRAJXTGENvElue+9ujKy7eUOaSxbCTo5/E9
         f6NYk5HmnipR8KH2yl5jQD+cim6VTai204uKAs6IeoVebeeAEqKliL+60+/IwfvH8+hl
         qlLWQsU0QF2zxu62z2suYxrbHmsiuVfV5XYoyR/vPAGhAetCo3Cop7wleGlvVimO4nWs
         ElozcjgoWvAB8A/NNYuLQ/UABdULgnYFm6qNWySiyW+gJG0EZn4izvYcnRfL1r/B0NdC
         RN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890087; x=1769494887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUuEqo1bBPTtYvx/6MqHHwRERlW4p1/ugxXmq/ssirA=;
        b=UBYVCejoDO20jGh5oyk0rtEBkiYBBecguQTdEi+PnaFAo30n4AaooayWuTfUgyTto2
         uZ/OrP1478vq3xDkCSH3Nctngq6G5Q4rwgtH7e1gdPQ5i+oHWDafcvRwssQC+5+hMQMY
         AJzafVfvy0S+fB4BdFSsWzAzmHQ6uKGi/gCPqeB+wSubFP7u2zJjrBciGiaP5ABF2xEY
         NcKxDPM1G7IPruhC0cg0ldugYQAV/Mj+C6eiJ3KFW2YRVouXFKzGhbPhbEoh8HmEoeiW
         cIqKspND82XlKsd6BVhZFf+dSARP7qA/B9yBk0mW7db7TjrezuszBmxVzDQcvbmYuh5K
         Tczw==
X-Forwarded-Encrypted: i=1; AJvYcCUSv4CjcfLI8LDCIpfj6Jswv96l53BN8N3DjBxDapIf0s6DAn1M6GPz9+dJq8MzUfEbZIjj4OdqqOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ui90K8gqe1OU7G8VRjdWp8cThv4FBd4V0vqkyfD/yAIBkPBJ
	hrhWyxpVzGtoANuTzMUIuMUfeIKn9iFGVJSXmA256jf0/8Suw6fYYU5k
X-Gm-Gg: AZuq6aL2rjmQkBx19Dc+RD2OTxtVzuhnSGT9Ntb8tmK+ONhn31bAFJhc0MohCTOXucN
	nDDg4yoAKHc7B2tWfVZu6iDkdb3A8hgPTPqGFEmB5cUY5ePlGIq/k7kQZuHMydwoDPe0eK1omWC
	qk9eBk56NKOBPcDoIuAwitNoby3E/+6barZgLaVl+bmQNePd1qY9nO5/FAMZo+9gC1nUYgS5Xys
	rOPBpVu1al/4GOfcOz59Sb624x8pqakuFV/O8hBtqqiMcRCCpjKkFX+XUlTSvMFrZyfGnwI//iX
	nS3RzcXDiFs7nbAm5CF5+aL6S4DdB0+i+LUWS/5qZwbPJlZ3gd26+iaYzNIElbJg11erkyZUzRI
	F5T1seIMzkCGVMruwyzgmPR0rpD47QMKV+OzturTexLnZzZVxtTF0JAsRUTgAf5yBEV09KUO6LT
	brIeK7a0kPudpS
X-Received: by 2002:a05:6102:3584:b0:5ef:aeff:82fc with SMTP id ada2fe7eead31-5f50aa1028emr250763137.37.1768890087050;
        Mon, 19 Jan 2026 22:21:27 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:26 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:47 -0500
Subject: [PATCH v5 7/7] iio: light: opt4060: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-7-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
In-Reply-To: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=K/GzZXmVDH5d3ajOh9Vses0jzRTbszvo9JEIlad+htc=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGlvHtSjrwC1JnQanLoLExLJTwrpwdoltjp5KmS8n1f6i+dHS
 Yh1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmlvHtQACgkQFmBDOPSf1Gb/KAD7BdoF
 qUPP0diCbpCK9p45EPoIqdtrwlBjt1YOYDEaEvAA/2iqEPiM5dVqGN7bLWinI7Y1nD5Qgy9ZPUt
 10sazV1EN
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_CURRENT_MODE() cleanup helper to simplify and drop
busy-waiting code in opt4060_set_driver_state().

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/opt4060.c | 52 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 8c4a1f562a83..d6e915ab355d 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -302,41 +302,23 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 				    bool continuous_irq)
 {
 	struct opt4060_chip *chip = iio_priv(indio_dev);
-	int ret = 0;
-any_mode_retry:
-	if (!iio_device_try_claim_buffer_mode(indio_dev)) {
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
+	IIO_DEV_GUARD_CURRENT_MODE(indio_dev);
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


