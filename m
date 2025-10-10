Return-Path: <linux-iio+bounces-24928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64BBCE55E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15388407FFE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66F24676C;
	Fri, 10 Oct 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV+7V9eB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559921FF4A
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123465; cv=none; b=l84uCQ2v0Gk4MxT2sdE0+WVAqgI/kW5GcDoMYOMLxZKlMa5A+pboGwLEeU2VxDwIuHGZKeE111lnwBLPOrAFOKJ8Fg873HkCX8hpqFYxDXr5XZIMMlcaOB1aZ9ALCqJSUps7dSpJeg6l6nmqRo6uTlPR3a1fUi3dPoZ9fiu/Bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123465; c=relaxed/simple;
	bh=D46Tb12nmUmndhtqFCfahDJvapdpQA7Xdz9pjuL8Y7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDJJm4ngyhWjVaUBkLARq2v+M222vXP6zjXLpxTGSai/0jzz/oL7b0Yo9ATiVF9T7pQSK89Qq3aDQLygewNTrq9qFlr4u+2tFw/oMMPOG4dViV/ukYyoTMJMYQ4mI2jTo0h4JAH/AikG4bmDLEVKoujU8lXEPZ/l99kfP30izak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV+7V9eB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2088979b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760123463; x=1760728263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+U0Y94PCfWWUoXrVPKAH49E0+Bg479gJuRHep4at91M=;
        b=FV+7V9eBqH0IGz/F9Py+kc2hZ3mtdjgY9dhYxUu7k73zCxYz3X3Wyj6LHD8qewNCzx
         qFP5kwQbbBzGrcJ2lliBt71ifTbYMEL2odmjD6TekICJUMUymrP23tDbv3FhkVGU+W0Q
         UvhrKcGyJjuZlf3ATKkVgWXbYm3y2tHplUog8DenDA7fPFnwjlFbgznBCTAvxFcBH6p3
         gTocgWAXkLQhPuxQJLrrnAL3A7c1Jg+vMFBD+Om+kAx1TLLngzoYYIC3jZE1jN/kWZ9K
         JPFm/8hT/0mzIOla1/dJBzELBQcfJuFTi2JHm7KdRPoMZ6ootlgKOpL6qmz75ENBBFm6
         V36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760123463; x=1760728263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U0Y94PCfWWUoXrVPKAH49E0+Bg479gJuRHep4at91M=;
        b=iTKhrbml3HKX/YVMyC1D01xQUuiypvW1mYx5srrLK/s1DhrdXxG9/dVj/D36bCnl85
         s8IE36RsCdWxZ/pT8z10Tr9Gzn1t9x863em9H3nm6rA/7L1iYq5XrRJndcZ/j7VN59yh
         l5ja2t232PzOBjeatos3xch8J3ZCwBkWnJBF7QTIZHfTutSL3h2MkDEB8yv55UNJfk15
         fbQ8I0k/j5+lcxHZ00wHOhQ6+yDLrEUxrpSCAki3vtIni4Cgv8G9D6kvxFxxCKDpy/DQ
         17rToLpY/0RSr3COikckg/bmit7rRg+tLQO1lVo1IwrgKRloeda6e/2rwfns9u+JyF/E
         I0bw==
X-Forwarded-Encrypted: i=1; AJvYcCWsbyD6eCikyry31QzTBR6IC3pYKohXOGIrIiE+NJkJUflqPj03fVf+IZGNUTURdZtTKaX+wVgt5cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzznoEZ7B/RPz3vwFlLXtsWoI6we9Yfv0IpS/5uofKVTa1NRxZG
	sOuEMYA4NGTKAZsZbSLdsqQ/asDkuKuryZe1GmPdvPWoWpw93sXsHjDY
X-Gm-Gg: ASbGncvA8LKP6B8VcDjR7hLMqx/vuCKbqmjkDfBa7kQU0Oq7y7zDlrser8j3GI9hHbi
	t7kIw0zd42COJefiy5QamroVDhuUpmBGWPeAKmZrXWtfoJoIMVyxtfM5OyAxs5r5xirIPdEeZ8O
	OPPHYObuRbz3dUsCwtM02xw/UbWpt6R2Ip99KS8vr8Fc1HqxSw+LAMzwQOfHvxZzK0km/kW4cKO
	TdPdJC6pviaguPzLbHEMvOXewHX2WdIpQDErG7YhCbpcSALow12g9A9Elp72xvzd+BQyjz2p7we
	IpjEsfGHHSn9qnObE4M/QritiSqHLXzkIMpJt0yqpudMxwHhOGF5Z+Tv/sbTHwUzfqKS/2hte0e
	l1OyA1L1RoAomdDlhohagB/HiUTdXnW1n2QMQuUc23mm5PS5nkI1oxV5x9qpbZTxJ
X-Google-Smtp-Source: AGHT+IFN5WjIYZZRb/4TngbfzeAJu9kbhU7Ke04fdJ3b0HKiaP9SE5AjXmpdtHtn0LFsJ06yZYxEiQ==
X-Received: by 2002:a05:6a00:1146:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-793859f31cemr16464830b3a.6.1760123462963;
        Fri, 10 Oct 2025 12:11:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:5abf:20b2:7217:3f90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm3717462b3a.69.2025.10.10.12.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:11:02 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: bmi270: fix dev_err_probe error msg
Date: Fri, 10 Oct 2025 16:06:46 -0300
Message-ID: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
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

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Just fixing this little "typo", definitely it was copied from the bmi270_i2c.c [1],
which has the same dev_err_probe logic.
Tks and regards.

[1] https://github.com/torvalds/linux/blob/master/drivers/iio/imu/bmi270/bmi270_i2c.c#L30
---
 drivers/iio/imu/bmi270/bmi270_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
index 19dd7734f9d0..5e625586681d 100644
--- a/drivers/iio/imu/bmi270/bmi270_spi.c
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
 				  &bmi270_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to init i2c regmap");
+				     "Failed to init spi regmap");
 
 	return bmi270_core_probe(dev, regmap, chip_info);
 }
-- 
2.48.1


