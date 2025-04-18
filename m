Return-Path: <linux-iio+bounces-18291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A2A93D21
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837A51B660B9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B522422D;
	Fri, 18 Apr 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="px+AmD9r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894A21B9E7
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001549; cv=none; b=p17uJCHSxnI/8S+yj44QJ4MCcRafUffCqg1iOi/hpX20tRQ54pq/iAta0G2t8i0JeZfDDBGeF9TnfCHt9Btj0su93vjsNr/HbD3zeVvF904S91Es9vqNa6hhVpIMEBvQimzPRTYJr0IUA2aoKArzWKQN0MfTxaZOFqrJpdRe2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001549; c=relaxed/simple;
	bh=Bv/8pmkVSLEHKs/mav/QyQx2gx+A9OyyTn67MfrVslE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=puSAm76n5NXRJmN41uwkN5TNVM+crnL/sNPZ2RnD9Cp9z81YJRwexTCW1evlc5gQnd5UJvBa5och08i6mjGwmCVMyZgEB06T0SbyJb9KKzJ/zsGE/LowxlRf+fV7Ddvanes5ltBR0QQ2FwNsCecaij5G3U83Lw161kNrzajGduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=px+AmD9r; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso14451325e9.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745001545; x=1745606345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdOyOpClnf46r1G0w0n1z533KfjfW03By15fERgN3ao=;
        b=px+AmD9rvf6F1yCAvzy0GdYQb5BJWDgK/eoaPubZs7HClc1OQ++HiHlsXg7RNKq25d
         agjhT1dz/aR/rQeGtA/MHkGQdrJ6zRh5EkCN+QOJGbrHnMa6bIzGS8bgy83fwsmyDiDU
         1UPwO4RxifOTEYFxoxKgyyYXvPObzIpZiGmsXhHyjEdD9kZkMXMNLMnphRNA2z0WKBih
         dC8cEQqOQ+cnGWzdl1gyC9v/+jzfz+AjLAj50TLSb1XUj40fhHvI80K5zIowfi2cwS4L
         oZv1oTQooaykylXvagdc8uBqlowLgAd2AGMJXRdBxuDna+CF7Z4cIws+pH53cC+7YJmj
         GPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001545; x=1745606345;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdOyOpClnf46r1G0w0n1z533KfjfW03By15fERgN3ao=;
        b=LNFLwQhqFNiTY9RFoOCesOeAWhCeT9IqIWLPVoLDD1WVaZrlMjVdfHsylczHMJHE1N
         OiBMdEkOv1PCzU7oIXyyotlrwNpMh1oFIMdXo10ztAv0DtDt+JHl3LcoEtxEO3HUYNsC
         ldEhOGf24NvWCLA84R+8L51Ren0jByArbL2tJGt27dQheGuHTk9coR9KhZcHwzuxpYdG
         8K25pV0Eu8ozlfrNtt1EPUyr0Nd1qeTnOKtrq46Hfw+mSEBitjnDS4M5vjKYSoGtQXcv
         2y5ywoz6uwhi3vtalU1MyZZ4J7GpIgTeDS6Hp2UtNk7nvHv50faJQE4NeLPtrga8rT1h
         sjEw==
X-Forwarded-Encrypted: i=1; AJvYcCWlISoxKcLSPnbdwv3EycfemvpB4pMA1ettj5PW5A/lgk9LwULOM7sHJaFCRW/7S0KkGjtaDS/KKL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfJd9JSHuL39+HHBzpxU5C7M88PwGe4Vrh1RxN9WzCdSmLfuq
	UWNU6H3XWq8eT8i6wpxRxI7LSkM2EvyUWVbMe8EKX4W/WTtpJlIeg6UPk6FJHfI=
X-Gm-Gg: ASbGncuiGJULSc7XQIVYh7vLlVAlIby028rnIHjZLqyGC9fAIYan1/nzaZCyOYqM9Sz
	BpMVSpMlGEFajNJHIhSf1ez6LyGc+Pl7tQTWsFwqdYVf0h1n+dwlRLKVYIRdcxW02rW8gcgvcw6
	fNjrKRSPPknDzRLnJpxuSCFO8Iw1uTwqBo6AgYnFgPgdPKGaDdANUV9svpvt0mtVp8xsSBe+qFc
	1BaoboYtayWtHh5kSmUVDH7Cj9l1fl/fS3mG7wZdezw7JwZ95WliIntX8RX6hyA6bqCsjtPWq30
	sDbPTEeQ816vY/BLFnh/r/n6wba+2jgIqovHb7uKNrQkyO/lu4ijpVEoYBko2baGvRAKw10XulA
	izhfHNt53It2+OdsvTA==
X-Google-Smtp-Source: AGHT+IG5u79osLOJyjW/HnZsIL0/4QcAMEJjPNjmGPE4qL92+wsrfxd5ANNR1y0fi/i1c5rfxy70Qw==
X-Received: by 2002:a05:600c:524f:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-4406ab7ff18mr30012915e9.1.1745001544822;
        Fri, 18 Apr 2025 11:39:04 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db117sm31044565e9.26.2025.04.18.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:39:04 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 18 Apr 2025 20:37:53 +0200
Subject: [PATCH v3] iio: adc: ad7606: fix serial register access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-wip-bl-ad7606-fix-reg-access-v3-1-d5eeb440c738@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAACcAmgC/43NTQ6CMBCG4auQrh3TKT+trryHcVGGAZogkNagh
 HB3CyvjRpfvl8kziwjsHQdxThbheXLBDX2M9JAIam3fMLgqtlBS5TJDDU83QtmBrXQhC6jdCzw
 3YIk4BNDqRAozbSqsRSRGz/Fi56+32K0Lj8HP+7cJt/VPeEJAkMRphnVKNaWX0s6dKz0fabiLz
 Z7Up2d+eCp6pkRbcaEZTf7lrev6BotFIgMbAQAA
X-Change-ID: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=xDLDsBY+0buT4niZ2UTLenrevFoj/yl6I/WTIFIhTHE=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshgmsP4u1lm3beujIUdU/Z2dtl4rzwYlR76I+fqBOXSx
 Avx5i3/OkpZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExk32VGhmeTJv3Vsb5WJCfU
 fOivUN+GuO1SP1m/rbnzaVG2lVfQw0OMDB0fd0aes757MIeb9cy8piOyx5gyTARP7p0SOk1D/F/
 tR1YA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix register read/write routine as per datasheet.

When reading multiple consecutive registers, only the first one is read
properly. This is due to missing chip select deassert and assert again
between first and second 16bit transfer, as shown in the datasheet
AD7606C-16, rev 0, figure 110.

Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v3:
- fix typo in commit descritpion.
- Link to v2: https://lore.kernel.org/r/20250418-wip-bl-ad7606-fix-reg-access-v2-1-8b1ade67e185@baylibre.com

Changes in v2:
- improve bug description.
- Link to v1: https://lore.kernel.org/r/20250417-wip-bl-ad7606-fix-reg-access-v1-1-0ce341f3cfc3@baylibre.com
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 997be483ebb93293481b922e13ece4edb47e940a..bd05357a542cf7234d5bb6b718829d6b720262cd 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -103,7 +103,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,

---
base-commit: 8dc6b228d746b1a900bed28568defb2266fa4c43
change-id: 20250417-wip-bl-ad7606-fix-reg-access-729c21478d1f

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


