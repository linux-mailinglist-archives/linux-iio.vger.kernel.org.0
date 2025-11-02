Return-Path: <linux-iio+bounces-25813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E336C29892
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D34188C991
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B82923D29A;
	Sun,  2 Nov 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N141O+gD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5A1C5D57
	for <linux-iio@vger.kernel.org>; Sun,  2 Nov 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122950; cv=none; b=fhxnU50Lr5+XqJZf78qQPQv+8VBfjqXgXPUrXTBiygOLM+LrmDlp87vjTxwvqeIGqX6B0rYn4EhjntKsmzovknTpo1p2NAOxnmVhKBdhnn52YXjjqYJ64sZQS/IqpTeFDKz9JgLLw/JxVRxcQ5BE9tuOKXR0XTlwN2lPKT2aw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122950; c=relaxed/simple;
	bh=zHLJyI1B0tQ7hDcTDpYEVBdJEhuTUsIfsTItFBBZTB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpnYuVOkL2Y1vijCnNU1Y+jgkl09HU2Xww9wfOoO6cnTPv57+0EXsMJCBmHIkaekqLn0/Ev5GW9Rj0CqxEbaOhnd8FwEN133nZM3+qs4+0hX/J/JZOGSG2RlYbRgxHzrxkk+eznROO3xUFDy/+9HPnlVAz6LOYr/AVBHtuFckcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N141O+gD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-292fd52d527so38644015ad.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Nov 2025 14:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762122946; x=1762727746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Pa3OHQ3FbNoagKUAESzu74YyfMwxV8hg5SUVSdQaE=;
        b=N141O+gDz/iJfKnhN2O09iCUFKJ9m68PRn/QfssDLWs5UqBV9rPqpFPKNRd6nQsK9B
         0z+ib3z365iSS5ROXY8le/bAb6npWnMKE0wV+3c/VlnByLMh4ZC3VKBORt8Pd1hlgAME
         RZRk6yVO8/qFIuIHFjRcIn8FuCd1/wOI0SZLzAqQt6cdLvIPSHgigAYWCiIMZO4pTUYK
         lGjajOA2QkxWop3kwQbTbiDuo7522RVJj1UItjrS1oyxhePtKuQWzZGOpHXdnSLHb40c
         xPKH14lpNw6S+auzV4g8vbc5qc6KcArbIOwxmjfgNeqs+USTXBtJBUG0F0wSGu59NJBO
         8QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122946; x=1762727746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Pa3OHQ3FbNoagKUAESzu74YyfMwxV8hg5SUVSdQaE=;
        b=kexSXK+/I4WUaxsTjxc19VbJc07FKCJo9XwBzvGQ3N5EcqqTE2umBZ3QilAJw1+i5d
         9K5igvQ9sSybpLQGTbTG47cWgaZ7QhEJaPKKoJmq4DzOLrFKn1sbHhkMAcgvn0KboEDH
         kqlsXq2L4ssjI5TTG6t4pGbOrkL3jpvFoVrb0CuqmYqsNq7jTDySzmDDETdIULOSWzOm
         kxBTn6sJaNSiOniI1vjlbeyOs1G9hsEAwk1mCxEZvJxE9nMBN7tG32Uwuko3iMXQM6Bp
         laduZkAlnXrjeDRGVEEvOjOWeDowgNDHzgdxwtooq3RH9QRR/jlvVe6q3IkBF4FE/H+l
         OiZw==
X-Forwarded-Encrypted: i=1; AJvYcCWV+1WE/gIxR1wFGQnRlFnFlfrslnMbpgT1vtLBUEmQEf0ZX1UvqhCvgdWmUNe+8FOmAJ25OdbvVUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhUmfwwaB3nvEKT7Dv429c0i5G5DpCyD8dXFcegwBmeqXC7Mw
	g/IfsiTDEFTXUO0cASW7DcJExvZIsNwE8WOg3MT2zVjTiuLAvEYIf+m8
X-Gm-Gg: ASbGncsgT2n3W2tTgZTAou22tcyqo/E6zTc0uxKCf+8pCgxx/GZ+tvOuuMm8Q1G0Mkf
	rcpIWOdeOPiqiNAPQQymkloPAHwu24/Z+3ZLMYNTI3/iUsxU5e0zyDHQowSAx/ddwkNqYaCd+qn
	QnAXIKozLAJ5ZKeB80xaiXnl0eAGZuNvKVkdG5wbM5AfzjVSiys8Via7wcC8GG2yCfx/7AL/RPV
	6EC/pno3VchciUCLWkFN6UpxpukZXQxQ3g69xc3J21b5qw0/7PT81WtMhLD1dMHFTu2JQjexoUt
	s5+WPp1DtmFdgMqO7x43Zkf05naPelVnpJYrQssyP4QDsOgdmgSnBHse3OVbMbivFWb4uh+ZGoF
	BFXRwW98ostcuKSkttWcOhrqODt/S5Aopi9b8uz9y845HfuEzzf9gHaqGLW/wAFsKqU/nOrzabn
	PFfrxuQcbLq/xQ9o7bopsgoEkqgz8KCv3xEg==
X-Google-Smtp-Source: AGHT+IFslqE5PZW8WOH32oKkpjAT+nE3kdUaE93ZVDSdYVX9RgOGkUJh9awov+E/yE9W4J1l4QVD3A==
X-Received: by 2002:a17:902:db0b:b0:295:59ef:809e with SMTP id d9443c01a7336-29559ef820emr63430415ad.24.1762122946016;
        Sun, 02 Nov 2025 14:35:46 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295cd210613sm2460885ad.107.2025.11.02.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:35:45 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: bmi270: fix dev_err_probe error msg
Date: Sun,  2 Nov 2025 19:30:18 -0300
Message-ID: <20251102223539.11837-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
during probe, if devm_regmap_init() fails, it should print the "spi"
term rather "i2c".

Fixes: 92cc50a00574 ("iio: imu: bmi270: Add spi driver for bmi270 imu")
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog:
v2: add trailing and fixes tag
v1: https://lore.kernel.org/all/20251010191055.28708-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/iio/imu/bmi270/bmi270_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 19dd7734f9d0..80c9fa1d685a 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
 				  &bmi270_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to init i2c regmap");
+				     "Failed to init spi regmap\n");
 
 	return bmi270_core_probe(dev, regmap, chip_info);
 }
-- 
2.48.1


