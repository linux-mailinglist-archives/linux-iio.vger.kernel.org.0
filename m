Return-Path: <linux-iio+bounces-24328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130AB8CD6E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 18:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8977E0C3A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4829BDB3;
	Sat, 20 Sep 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MnY5Crvb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C491EB5C2
	for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758386679; cv=none; b=YMH7v5yjtJNW/xK+N0nIdNg/Jm7ByQoXi26FeCX4Q/j3ZQuRlQlelb7n3DWqI62xrkeuTpEtqULwPVmWw+d4B6kFpZyGmckHIr9x/jWCdkjRooDeeyK+CXbdJDaYh0sQPVVFWuxjTKYDgSPiOUQA+ChNGm/I4Jrvz1yNnBAkwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758386679; c=relaxed/simple;
	bh=+KkVAUbjvzLqQ372TaC6mYdwu51f82R/koh/j0LBnXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pn8BdKJDk1oKgyXO9CJtPpMTQTVKhfE3Sc4KbuBLfg1wQL7z3fu1ShTsiQT0JfmhhzF+goaYOMHUFs1vDk0VAhXn0aXftYAJESMkT2SeRxfVCEqKeX1M0yRJRdBjW1YeIFQbYNbcyMWd2T896KsGqqQJFnd0aQe7ZHhPh7aawME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MnY5Crvb; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-621cecfcc04so1624048eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758386677; x=1758991477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrLTZ7Rl/iAlP5NeobqvU69yd5e90hi+ZynPAnpcxH8=;
        b=MnY5CrvbUYEcYcg93JYgDpEORIHfjdj6wjFa8auvioqOGhX1YYRW0gAPGO0J5iiSZO
         XKY2t+do3FW5dB2TNX9YqQapIe8W8lnb7HfYilPZITt6i2gNimwaBoOMMybidV0Jsp+y
         0iZrb+j3BPKcGooFQn61nDsF8IBzLRVBhqTciC5ZSrj2TlgIzQrpFNxx95Aq6NivCEE1
         SCiXu7MaztlNCfDHqCvy0oewLfNfqmdpqMN6oWCStbtpPDqJOqEzF8qNIBr5K0XHd0Dd
         nqAVq69WlT02/YcAwMpN1dsoIZS1IYRD1j3SvPyzbW/3wrW0KiH8GVgWCB93K08HqV58
         dwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758386677; x=1758991477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrLTZ7Rl/iAlP5NeobqvU69yd5e90hi+ZynPAnpcxH8=;
        b=fN2Dooc/Z1Pn7vc0I6+wZONhf5Agp1bAZP4mU+Dt1PWj/JuWfy8fOmKcqNLjXue9HG
         UBKsbT4h/qqaTC7H2KXaPalyqhPYDMARFvOihGmGI3ThdFfzhGndrdh+u+NfkqvjygrV
         FQFPZ22QaI6yttVxGxN19FfB3RUyc7DRB6CY2EoHMfiuYhmk9baKXhAp2R0ZNT8sdyhb
         T/qr3o8fNXHYnGZNmKily4BxLEYj4CLy7m+y1wQ4o9P2ktctf43GDF8FAYM2HRr/+PpD
         fCFCTdG3Uq9QjEFZ7zHbpK/3SKKadASE92g8MCiBpxiveBksA8jQ6hqisCUhjm27s1ul
         dIuw==
X-Gm-Message-State: AOJu0Yy3Ct7YMxYCRiyFX/0tgkqkZZf48NKD4VD6RbLS6dSl0SBJ81tQ
	sy80vwMIPj6I+XFktP1kUl82XIeNHuAWCy7h1q4JC9HPRuPV4jkj9QBdMx2KS337RwI=
X-Gm-Gg: ASbGncul0UdcaW+2emig7j/+mNtx49Z/3HfVP6UwYszDGVC2aRzxkzmgDtgCIMXwylq
	Q4xkXAEB0fhIY8zl4HA9ReTddjCEHXcyPnPzaVleNBtOCcKXhNrlW6cmM89DImsWTO4qkjy805P
	JXysw3AQRpMXyCUwqSmz1khgu8n8Bjx0uDYMZ0JKH33115VJ9ye197sx7HwH2pjMNt9KYXb1wLY
	Itgd5PPZkphglpPdCzIfsM4pHhO+jCcraOLCKzF1X+gDOU8cmbg6+XVCIvZd5iigwCS8HTnKapM
	y27DetWuyBTFRIOz4kYswX58CCK9M4OD1yt43VD0GLfsPxOZ8PhwM0xgb5au58MqoLAoGX04JfT
	dm9qraCvHekXQv8NzIYl5X+EfcYiUDBFMCTTii0w=
X-Google-Smtp-Source: AGHT+IHh3ERXstA5DE7ysHRecHHXbKMa8uwlY9kNdhsVCzCl9/CU4gwGE1Ebp2Q0PUXXb8p15ahb8Q==
X-Received: by 2002:a05:6820:2218:b0:61f:f591:8a2c with SMTP id 006d021491bc7-627256b01b1mr3146123eaf.0.1758386677042;
        Sat, 20 Sep 2025 09:44:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db6d4e4csm2738142eaf.20.2025.09.20.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 09:44:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 20 Sep 2025 11:44:26 -0500
Subject: [PATCH] iio: adc: at91-sama5d2_adc: explain why indio_dev->name =
 dev_name() is wrong
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-iio-indio_dev-name-wrong-v1-1-d376436abbb6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOnZzmgC/x2MwQqDMBAFf0X27EISFGt/pYiEZmPfwU1JQIXgv
 zf0OAwzlYpkSKFnVynLgYKkDWzf0fvjdRNGaEzOuNHM1jGQGBqQ1iAHq9+Fz5x049j8I7hhmKK
 lln+zRFz/9Wu57x8t98rVagAAAA==
X-Change-ID: 20250912-iio-indio_dev-name-wrong-f5098d2447f1
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+KkVAUbjvzLqQ372TaC6mYdwu51f82R/koh/j0LBnXQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoztnt4EI83nJVNgPFT3zACkJTkiVAF2gkuvMgL
 tO6punI8keJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaM7Z7QAKCRDCzCAB/wGP
 wEXIB/9E9AyAd97dAArJLyEWpfyyRsU8VSkAM80UT+sSsOWflQLHDKf+U6qVsyZ3d/4SttHykyy
 j188+VF6Xy5XnAGPskyvca5iQ8c2J5TYAn3FK+Wjb1E+MJ/i6j+kU5S2aF5eLxdtsqPG7beYm85
 MX055IwHDekH8D90IKE0LoZhAXPtDeG8Y7fYI0P0LLqFSfH/V/Y6auBzNg0KKik8MPZDshsOjk6
 GqI69MYAcVUKwf6KGUJj9z7CmKTMwlNx/2N2F3ygnfyX/+trVsok13TWcLYplpZ61dYGAf//4A3
 C2l3Wg9VOEre11GC5n+lBoGyoz/ONyQBAQr7p4CQBVcSTdCu
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add an explanatory comment on why indio_dev->name = dev_name(dev) is
wrong, and that we can't fix it without breaking userspace.

The idea is to prevent future drivers from making the same mistake by
copying this code. And if this driver is ever modified again, we can
at least make sure any new compatible IDs use the correct name.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
It came up in a recent review that there are some (mostly older) IIO
drivers that are incorrectly setting indio_dev->name = dev_name()
instead of the "part number" of the device and that we can't fix these
without breaking userspace.

There are actually about 40 instances of this that I found, so it is
likely that these will be copied to new drivers and we don't catch it
like happened somewhat recently with magnetometer/si7210.

I'm just submitting a single patch for now to see if this is looks like
the right approach. After we refine it, then I can make a series that
fixes it everywhere. I assume we would want one patch per file for this?
---
 drivers/iio/adc/at91-sama5d2_adc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b4c36e6a7490aa9002a702e70a8b37ee3eae6324..cac408fda8eb6f45ab79531a71d5ad868115d735 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2318,6 +2318,13 @@ static int at91_adc_probe(struct platform_device *pdev)
 	else
 		num_channels = st->soc_info.platform->max_channels;
 
+	/*
+	 * The device name is supposed to be the "part number", not the kobject
+	 * name. Do not copy this code for new drivers. We can't "fix" this
+	 * without breaking userspace, so we have to live with it. However, if
+	 * any new compatible IDs are added, please do something similar to
+	 * adc/ltc2497-core.c so that at least the new part numbers are correct.
+	 */
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->info = &at91_adc_info;

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250912-iio-indio_dev-name-wrong-f5098d2447f1

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


