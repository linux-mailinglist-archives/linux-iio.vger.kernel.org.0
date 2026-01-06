Return-Path: <linux-iio+bounces-27498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C7CF747A
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854FC30CB13E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDE320A20;
	Tue,  6 Jan 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1BgVE3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38931E11F
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686849; cv=none; b=QpN/Z2bQRichHJ5ZMuDTR3WlTgMdmhu8SMHbhWxnth9tmfgq6UXfpo2sctT0iPs8jo9cfw/C6bBO124p71sq+CsspbBrjpN6lG7DuHs4ZXHtZReuhUOltvliVmDiX8EqS5xhVZ4qQ90RRt56UF1qC82XAu6D0V5N4FMcZY8hov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686849; c=relaxed/simple;
	bh=wLQkfH84L3nWLNYNBgcXpFCEELbehsGmWWxLa2vh72M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AE5U68Y9zv+IiNxDL3R56APVZWxMQkczjFZfbNvOlBHNzuFeI0+mrmZtygdYWvX3+qCNGmm/OQkk6wxIrHQlNb582NstRxqHJjOiplU6dcZpi0/kaIjBlIxoMGOvtMXWFzlTHyt1rbQvSBj8hnbqzW/lTc48E/JLAP6aOfdh4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1BgVE3m; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbde7f4341so1956130137.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 00:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767686846; x=1768291646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IydZnnaEgCiF4tRpM0JqQAl0iXFoV2F5d6i1TSIygpQ=;
        b=H1BgVE3m5tnJ7/5O8mlB3fHP9NgtX1JuzKUrYjBFoXeA+8uw3PfDu5Ac9qEDyjjok7
         mrKvBresRsxRwwczmJuKRsPf3QzsYeADHPjh/kflUWSbeY/D4VB4M7t/woy3047Wwy+2
         SjkQfrowiNi3F23o4zsIwVFhKFUYlZ86Xpd4ws9KXplrVMMf92I8z3ujEbESTbHQ1w6f
         OmT9yTtuUIU+uwfWRTF0P1r9GFoiI/n/AQz+yQ4XKiGn6uo/UYQsjhLMTeS9NE/YJ+bE
         hgDtxTlr6roxiUPvvS6V6NGTDCdzN2KiqwdkpRXVsUvtakdXwQJIh2mxW2lIhFbhfOj+
         dFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767686846; x=1768291646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IydZnnaEgCiF4tRpM0JqQAl0iXFoV2F5d6i1TSIygpQ=;
        b=wWiN5h67RU4iMTVze86Go2PR8sixjKsAHtnwZ1LuSF/lP4JanYRSNc7XC0KQ6JQMrl
         1tue5zq09chHBcwcHURXU4EtehKvZDutbTDXTUk5iSw6OcOKttulDOQf9cxUdAcU4KP1
         GLD1UUeibF9c+xjVWA57bR5GSPuy1OuSgfUzdRlbaIwugldtoxGJ+mCpEcFqh1cEBirC
         H6EZ2UZpdqJi8FJia1WFSlVJcixHOkHmcg10x0BsRGFE0xXwmSMdR/n3SPbt/ppBTfdH
         8dBNlQXXFciTZOtw5lvvhejt7OjVrQvhlT7yVzadWi1mYyYYncPMTtrvemMNx9Vp65dn
         Vmxg==
X-Forwarded-Encrypted: i=1; AJvYcCWJwKBwMcFH9zG0/Yql3b2e0OuMG1eqs+L/+3skMgo42pbFrKiJueSEX4ELXzMoxWsHS2IZ2K16/M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUP0dMwMjj/1lxJU1ADwa9Hc6XSSiA3vmzgl2Epn713tbXSkT
	cIzlPHcc2Joyvf5PRr6h9qX4ggrcFIC/J7Y+LjkAvMyrPYJJhabA8iPK
X-Gm-Gg: AY/fxX5OEsvS73WidT9jCDyoxQaxA0+62a2IYq5KS/+vlx5wOm6z3InLGmE1b/p7+7A
	TZmZ7yqpfROob9ruv/Mcr33St1e9wt/1LWI4GGPd6eUR41A22Ul2JcUoDIRHjZD0i1m6Um5INkV
	lxeE8uXo9Kg+TkmZkLoNf//4CI0hZfCYm46qer5ZaGgSgmwimrc97eXPCCJL9JBAY9sxiG3GuJN
	RMqbW6524SQtGwn7KGtCSE+Yl+eEAU7Ynh6cLIahU1E8QMaEiqQ2FDzI0X/7yOm6Bksz3XOtdg3
	Ll2u2xAQqCn2CAQqu9PH5ghlzYdzthmF0qHeQCs7ML1YYaxkXNp7JOAcgOOmv6XD2PgASWzXtpx
	pkZ+b2/6qlG5hgt8dx2Ln8UtwcmGl/RqBDDRlTmuqsf2KSz4HJrTMWYE4MJKb8h+75+Jk3VQ2iV
	GyX5JPsa5ugeQ5
X-Google-Smtp-Source: AGHT+IGMzI/cOqZ43QXZ7a5RlfUrH5CNRBYOY+ps8BI9qD34V+0PqH3koe/uQqhNWbT7bakQngPE0Q==
X-Received: by 2002:a05:6102:41a5:b0:5d5:f6ae:3903 with SMTP id ada2fe7eead31-5ec75772675mr663970137.20.1767686846422;
        Tue, 06 Jan 2026 00:07:26 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm457615241.11.2026.01.06.00.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:07:25 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 06 Jan 2026 03:07:02 -0500
Subject: [PATCH v3 7/7] iio: light: opt4060: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-lock-impr-v3-7-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=wLQkfH84L3nWLNYNBgcXpFCEELbehsGmWWxLa2vh72M=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkxh1ZZLly6fU/3oVnceUXdgQrl5s9XfjBatl7l8LvJE
 8SeHfH52lHKwiDGxSArpsjSnrDo26OovLd+B0Lvw8xhZQIZwsDFKQATcZNm+F/+RFrepeK68zpN
 lvAJXpZuJr9u9bomyiUc76pf6te5goWR4f+5Ssv1Z9lFLX76L/g4K0Fs7Vcfv7/lFtturOAN3Ht
 2Ew8A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_CURRENT_MODE() cleanup helper to simplify and drop
busy-waiting code in opt4060_set_driver_state().

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


