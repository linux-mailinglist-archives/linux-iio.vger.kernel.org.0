Return-Path: <linux-iio+bounces-15880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C4A3E17C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13F0189F25F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED724214A6C;
	Thu, 20 Feb 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5XJ5N8L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761421324F;
	Thu, 20 Feb 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070222; cv=none; b=mIMU5dsexT9kup5QHzwaje5D7G/xjkpLBS/f1l5TcQZYX87nUa+gF8ziXiA0L2lAysAbwbvNX305P5cU7HZiLsWaq6YDAC5bhPv5ecXxTQlNZqsUb3Hubs6IQDfPynI3TQ58c7cYZVItnpXK8GiXvtYYsU3ojSIKj8Y6E1Ta6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070222; c=relaxed/simple;
	bh=Gd9SxygxTLKOh9h22adGoLu8IsmJ5HnvKN/I+YS9u5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQDORDDQXzbpN9kxPZdMlZ6RUof5wkI5SSqUMGRzfXVfcOzlpSb7F6T9Na5eUiZMT/VKdgOkzzWcZB4MiUZDjO7KjWiBT/ceLuluK+eFh0aQVXetfh3OI+Vcm+hkvjbfp7f/8eWsrGVytPGYKQNl1y2Tm5r9AUKZEiMiO6pWwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5XJ5N8L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22113560c57so23130895ad.2;
        Thu, 20 Feb 2025 08:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740070220; x=1740675020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDtM3LKTpyGDe7HA8GkkT9qfwrfKuIszVf5WOPbYasI=;
        b=P5XJ5N8LFM4LgtqX7q7SmTzCrJpelQLUmvNnGruS+iE/a9UoXpPu7yzbyU+/zdMu+N
         /m8DjOmzg3lYknLrPRK7ezpUUIeSjpjGp5es9LU/eZOEzJOFDIP7jindGdzBtfWzMp6W
         IXTF7b7SG6xA28pntnkwKFJ1wPI7HFQvokGWw02ei5dxR5BfaNUL7cGDFbj+MSRutQG6
         jnjbBgc/cs2ihJt4nfO51pHXqloGFWdOLCpUtilShLhqyfhoeBZ0qmxtYkDqdEhhQnG0
         CeJ5bi/WvMAS3Qu94FpJn+xuL50er79HtbARwwR+pQxwxgyK2Y4+f12CS5ovsF7cmX7b
         YAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070220; x=1740675020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDtM3LKTpyGDe7HA8GkkT9qfwrfKuIszVf5WOPbYasI=;
        b=EM+UnBwUt1Eygaisvq4rROk/F0bIvoMRSltLSnq5dynM8gO87kNMI+X0pmDOHfr3JI
         lKWpvcg5BTR2JKwCC+Vlrb5r++nZiznmb3ou/ZhSBrwbAl4+AaECoWYXnCp1x2Pjskpt
         jUEPIfU405sZ6bLpvRbz8FPoE9IDBPwSimaS8t1C2BRoMQFJRqxzHixXX9Gyo5iGbie2
         NCLVOO+8V9kz/9SWXJKd3Oil4ST6cx4p9UmhMhFSU2yS+0R0/Tj1VwfA2TLO+ip/1d1L
         HTjQPTCLEIn2HdE1NoBO4igCWiid5eA4b1wRSTDnTRy27gxd+9FV10G0P0UmxQAPgaYB
         bfbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2wzUhBXPMExhuKam21jPpMWmt6LfTgfOMPJNzdp6sw2Mxe5cLP5PO7JlkUoaY/QGjhO54yvOPjeRHko3x@vger.kernel.org, AJvYcCXJLmL+pp9ob7suhz0IRS65I+UoRVU4PUC2dAWgH5mtyjXBxRu0DsrZnDWYxdKrkcanMiHc+CIWvW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPeAzIx9gKQZnt+SIzIykHIfKDLUwqXmgCC1Nc5yJH2s2cTP4a
	oMLIygaP913dhoJNWCcKXPp2iwFzBnSZXdQ08k34+jSSqMNOAAvhRfJNYm46
X-Gm-Gg: ASbGncvmNYCXQM0X4CskVoR3v3DT5rnx45AcG8wr9bO9yqa3F1/CtwRdSESy0y/7Vak
	vVpNDrxXDVQMbCbF8NUiVNtppzi4lQHPbWgcN8NbP8AB4rYINo0c6oINcxYzPNoCXxfeZN1IqZO
	FzYGXL2kmXpLS21tlRxmw7F8d6PXhKhje+32LJ6ZTLpopIKQod+SZ7V6fQ1IGH02/m/VSmwKdXF
	cgKh/gFpWuYM1Dznni6+mcW06+7k5l+zaPhX+TBAA5WYyqPdD6UqyMdWMt1ZhESZ06Ie5zqbXgt
	/cZUSAdXIydktXmc
X-Google-Smtp-Source: AGHT+IGoAK/EtNJ++0cwAc3sCjSoBEwAwWELFcIhbDWUSuMqxfTvSdJjp1QCL1QOrtJf57PhnX/PnA==
X-Received: by 2002:a17:902:db10:b0:220:c067:7be0 with SMTP id d9443c01a7336-22103ef5275mr338765895ad.6.1740070220168;
        Thu, 20 Feb 2025 08:50:20 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1caa::2db:85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558fe46sm122454895ad.239.2025.02.20.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:50:19 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 2/2] iio: gyro: bmg160_i2c: add BMI088 to of_match_table
Date: Fri, 21 Feb 2025 00:50:01 +0800
Message-ID: <20250220165001.273325-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220165001.273325-1-jerrysteve1101@gmail.com>
References: <20250220165001.273325-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BMI088 is missing from the of_match_table. Let's complete it.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/gyro/bmg160_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 9c5d7e8ee99c..e6caab49f98a 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -58,6 +58,7 @@ MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
 static const struct of_device_id bmg160_of_match[] = {
 	{ .compatible = "bosch,bmg160" },
 	{ .compatible = "bosch,bmi055_gyro" },
+	{ .compatible = "bosch,bmi088_gyro" },
 	{ }
 };
 
-- 
2.48.1


