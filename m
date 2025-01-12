Return-Path: <linux-iio+bounces-14150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E8A0A6B5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6D01888B71
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D30A48;
	Sun, 12 Jan 2025 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNmAcDVZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF34A41;
	Sun, 12 Jan 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736640502; cv=none; b=YIbbgCXzp/5KSAKPo9J0JpqopEo1n70ufn/HZO5UgAkLlyAT9YJ17IWG5s0tNRSan0il6vVUjOV9wPZ4FgnTUDKtJ1zq4wDwYUszGevwDzfvgd6XlLra27SmDEd0ttP4p1wwXeFMQBfDdG63xJ6J36hcwXE/jyuYB+GgNYV7ceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736640502; c=relaxed/simple;
	bh=iqBhd43mkdtS9aD5xGBtaqDrnBDHduns4LWfV74YurA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ecINZVEqKLSudSLrsjunY1EHHnHKhHO30Lh67jYb1uxZYBx5Iqb0XNPQ4sUZG2rbLLKa+mEmT7/ynD/yR9tGESnPOZ168ARLEsMxJO2y6SEt8J85Szki/kuoHgj2bgcnf80uO1Lb9apgCeBczoDQjR0IYlkDdddx9IhSM0mZwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNmAcDVZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38634c35129so2327270f8f.3;
        Sat, 11 Jan 2025 16:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736640498; x=1737245298; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNcE9rRkfqd+CjcLWGnWJO7BXBrf7j/EAjv+3Lghpn0=;
        b=MNmAcDVZ5ZMsPaZ3OsfJ2asH6m2Ks4VH2tTE/EuW5lyk62+XP53FwbSaOOo3WsSOES
         dDzwU32udjbp6wCZb8F2rK8dkft/ReHYiaDzkjqrdY8qimbEXYXY/xF15pggbqNr6aKL
         iv10BFz2NH8hDtO1QK6yeFo139CdXCrhitShKHnqm+Qm3no+LhPgMbDUN0cl50czLbr8
         aG+9hl9I3N3UVMbZZzGnkevySWfAids1qmLMwwicUZRHmGoR/h9YaI7yG+vqnAlDthIg
         ZfllXBO0ghsL5wwi4Ww1pVAH8iJjRsdpi/R8RZfXJQvPQmcmY4xXBW6jE/GmLcFVdKLI
         QJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736640498; x=1737245298;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNcE9rRkfqd+CjcLWGnWJO7BXBrf7j/EAjv+3Lghpn0=;
        b=KzIjdoaDwJDbp1tILieQFPbOp39PJIphPATYrARVDW4t9oOEC9fgEUhVKtzclYcJXM
         5gm1ib/12sv0/SopdrE9wN8+012972vu4Fzf1tJj9z4v1jHsjnKVv8cJhc+TyXYOyy7L
         txvd+B1wUR59xAaa1Oht69NMUFEFzVmF9ojfhR57SqB8plnHVif1gVt3Ze3L83MQLOFY
         ShV307bi1OcK8teQHyVI4JudWgi0yU+PG8zBjaH46dArm/rnPunsWyA8xv7P0zhmt0IZ
         fdR5wn6OkMdo400xN816lN6smdJo7jnmS+PotvcsQVoXaWv+FT1bXOd6wSFIXOSVTHQf
         bnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5I2HOEfv7ZS8UebZ8CriNVJJdk2NyCbqFR/VHxUx8q4nf8JdpDvrXKqYmBTSMvIiqmUsZBTr9@vger.kernel.org, AJvYcCX9T21QXVP6uuxLMk9oB/ROEoBYQ908getcQhuKj/D39DkDEFTXsxrJ11rbgWNsgdSfX4zVxDbW6+2jpnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGd1HYX8yvb11hBGBWjdWpoLisyRSCWb/Om0wavfDdOSkAY8b
	UmPeg+3M6y2dhLeG2xqY6/qtAQf82m8Og5JcWLNR6VxdM0C09h4QFk2UZA==
X-Gm-Gg: ASbGncsYYhbF911MOpmSDOOq0iUW3R/8/QPRK+GGHHe59FpGzQjSRIH33Fbbd7o8pES
	SqCZAkRiqR/4RW2tx0PZChjanEok8+Z5zQZEz2lYmOFOh9SJCuhLrE6u4wkg6Q580BK6OGsUl0n
	lG5eNJ0wyDL3E/IJreiwtfRiZPNt1Hm1akoexgSCe7el/YKfK+/tBrWMly/dVP1mp5zUeWRQiD3
	6GgJQI8a9oYapokXZzlgZ5/IBYM5eRanFvZ3WpU/Ns6u0wMduPiCNQ9tUoUQGc27ut/2tOs3pg4
	jAuy3pOeoymz5kr9CnEieQKe/z+UNwaI+w3rUnZ/8ShKW4YWWXzeSt3TZJT3EfZMPJ1hr/tzwO/
	u/Xk=
X-Google-Smtp-Source: AGHT+IEiRIMt9zk6hiJxLM+1+YNejjE/rYIBU98GeYPCDvzwbXQv3LuZkH5QmBfaRYA0SyNTfkLGAw==
X-Received: by 2002:a05:6000:2a9:b0:385:df43:2179 with SMTP id ffacd0b85a97d-38a8730547bmr12991372f8f.17.1736640498501;
        Sat, 11 Jan 2025 16:08:18 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2fc0-c4dc-2412-28da.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2fc0:c4dc:2412:28da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89f29sm130438295e9.28.2025.01.11.16.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 16:08:17 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 12 Jan 2025 01:08:11 +0100
Subject: [PATCH] iio: light: apds9306: fix max_scale_nano values
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOoHg2cC/x3MQQqAMAwAwa9IzhbaKFL9ikgJNmpAqjQggvh3i
 8c57D6gnIUVhuqBzJeoHKnA1RXMG6WVjcRiQIutQ+cNnVH7xnYhUTrCRbua6L1F15PHBaGEZ+Z
 F7n86Tu/7AQV5qx1kAAAA
X-Change-ID: 20241218-apds9306_nano_vals-d880219a82f2
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736640495; l=1521;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=iqBhd43mkdtS9aD5xGBtaqDrnBDHduns4LWfV74YurA=;
 b=+1tD9GB237al6K7KqoDBDYJpW0rB1OMDZVC2Bt8i10MU3Of2u0urcLnlYPDZYKrQgL1m72OQp
 VmkK0SkZ1Y6CPfxvMIl+LV48pXosRrNBFuM87Mr1I/2iL5wRg7PGUzh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The two provided max_scale_nano values must be multiplied by 100 and 10
respectively to achieve nano units. According to the comments:

Max scale for apds0306 is 16.326432 → the fractional part is 0.326432,
which is 326432000 in NANO. The current value is 3264320.

Max scale for apds0306-065 is 14.09721 → the fractional part is 0.09712,
which is 97120000 in NANO. The current value is 9712000.

Update max_scale_nano initialization to use the right NANO fractional
parts.

Cc: stable@vger.kernel.org
Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/apds9306.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 69a0d609cffc91cc3daba160f309f511270be385..5ed7e17f49e76206609aba83c85e8144c536d17d 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
 	{
 		.part_id = 0xB1,
 		.max_scale_int = 16,
-		.max_scale_nano = 3264320,
+		.max_scale_nano = 326432000,
 	}, {
 		.part_id = 0xB3,
 		.max_scale_int = 14,
-		.max_scale_nano = 9712000,
+		.max_scale_nano = 97120000,
 	},
 };
 

---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20241218-apds9306_nano_vals-d880219a82f2

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


