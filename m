Return-Path: <linux-iio+bounces-27917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3831D397A6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A737C3041CCD
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A11F0991;
	Sun, 18 Jan 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eONvwQ+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3723EAA5
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751115; cv=none; b=qlu8BKFro83TfLlclH/U62ItI1WpU2OIWwiFlXGnWIMrrVnZvAOZJAb3n73P6sXoc96qnl4e7AXZ9Y2gppJSn9x3szc8Y7X91Ly7GdruGw3ZsH+DHq+2a1/ecEEPq1wCw4PLJp3DFlMVQuhWNIwbSrUpJosZ9Cy1UtJ1eZ7997o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751115; c=relaxed/simple;
	bh=K/GzZXmVDH5d3ajOh9Vses0jzRTbszvo9JEIlad+htc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7CnbMhnILJs6e5X7X44FM7G7w3TJDl7rlyzZT8cUwQr7t5tBxoS0taTaYn0y69ODBF6Vzv9BVRGZlMNjF2WLnnYFPLo1bwNGdt6RWwBt4xZd9vY1KBjyZS2DDJEv7FYM5CC533TAcSa9rxGdgOMedT5TrqX0Q9T0YYcYfm/p3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eONvwQ+1; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eef115c781so1509816137.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751108; x=1769355908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUuEqo1bBPTtYvx/6MqHHwRERlW4p1/ugxXmq/ssirA=;
        b=eONvwQ+1y3RaaoDq2SjOK+W8t4cWq5V727BqcxUo3q0zexkDCy+ePe0EJiBokHg48x
         50PbRgXmGDls/cUqflqS7GPNGQJpk2UuW/aKfwwoB2NWc2A5OVysb4fqcRuYCz4GVyjU
         W1puEEVZ6XXzN8CtF3wzVz7jAV67G4gm1/5j4pkWFNE0rn66LaH3R6z86ydo4mfmVqQl
         wKmmLGZUuSu6ylKYcf7mtCRf6z+Ldbo8RACZgxp1QPF2zPFGN8IjG7kpVKqydtVsFEDv
         HGZ2noJCw6ZwlAlo8YZSZx9h98W0Wcpj+NDeVdQ1eL1r2QkKmldmlu0VIoyCPvtyYU4S
         5sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751108; x=1769355908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SUuEqo1bBPTtYvx/6MqHHwRERlW4p1/ugxXmq/ssirA=;
        b=PdkIMyN669ytatQtXC09oOPAkzT5jcTRNHdZ1/r+ufswDbUccDcCetp/dfrV60mWSu
         pG6lMAnV8mMadhk5bod1cVkWxwrSkkgdj/QK7zmR6WoRMeAq4YxvD8qDRC7WVUZXwqKp
         L6Dd8eb3LM0psJlOLeAd3uu/e6yqMay6KCSdmjNDtkiJ5zN5MUUFI1+dwd/A2tRcbStL
         BajHDNLaHA1IBSe1ItGuscsUo+LbDCVcw2qR9LR/ajpLK5BgZSGPpzdZ+Z/2PgfTVNdO
         YlElKari0qbf/LeklWKRctZoIxUamVYTSyDAjjmvvTPIBVv/u8tThW2qZ0edSFyhFJR4
         tq/w==
X-Forwarded-Encrypted: i=1; AJvYcCV4TaJ3bmj8hEp3G8/Kj65NgJlOg/CSeU0NWN5VIWdPKQwcM17QAAfbGCnEdysWEgLOEjTJB/aiN88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLANsxYhaBv921DHxjPrpL9wCICyQMr9EEbrV7Q8u9D8rBhP7R
	1W1nribPzM78zM1GoU3o9iHID3tdnijL9fhw2gfF1GyGawfMKnh6kAk7
X-Gm-Gg: AY/fxX7VXbiDapn6okVCZhCaRL/LgIquZkJzl9+U1u+rETC5B3aW+gUMG8JiLns9Qcb
	RvEA2ZyNZkF1f1x+loU6vXTnMF7mjh2MiXwnuZnizM+eld9grqoJ2+5wwBBTOgIGbFM+VF5HWFC
	3xf5hBQu/WN40j3qefFR1qCdUyOTOWEuM7A3gKb2c7ARrS6og7U4YXHhJ0qexkcDssl3uuuc3HC
	N9sVZhm8nmVCGRl9qm3Hv5RG3Un0YAGOmXHCZmXsqlLMaTyTIh4PkhYwlimaIRxtiEf40dhMPK7
	h1np9pad/AV8tyACaVEZPd1i6EKjRwiaEt2C8YibYlNsEjFRu8k1Sovagz18k6w//Arq5MuLf9Z
	NUONsPGHqEl5bfeCpoXxNwAWGcQE125OmKMeMrAbo6u7U4UeFZBeR80Y9mqm/Xx3/yRXG/3jDkx
	eRBIyRq5+R3b66
X-Received: by 2002:a05:6102:38c9:b0:5db:d60a:6b24 with SMTP id ada2fe7eead31-5f1a5527da2mr2484137137.22.1768751107999;
        Sun, 18 Jan 2026 07:45:07 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:45:07 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:34 -0500
Subject: [PATCH v4 7/7] iio: light: opt4060: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-7-6c8d0aee8ed2@gmail.com>
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
In-Reply-To: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
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
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z9efWr+Xjwq72RES8m2CyrWnD3Hl+pwmrgYfxLYr
 ZO1amNlRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAExEQ4WR4V1Q1p3SkOX1NZxR
 6XZG2W/4HgQtZT74dGqV7PYjx4+9SWP4w8lyUSt/QbZJTPfrdVk19xOLD16O6vD6OcNm6lEdPt0
 HjAA=
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


