Return-Path: <linux-iio+bounces-18714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075FA9DCF2
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821491B673BE
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580AB1E1A3D;
	Sat, 26 Apr 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaJzwHG5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582814D2A0
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745696512; cv=none; b=gGp6YmT62RswMdLtZQeBQSYqhLCAzgYpVH+y1iNimdyL8o9s74DLTYQAsub7a0QQQFMSRnkLhQpk6UCBbyIvDHEuu6s13hCzrqlaQAC+QQMOhqjaWGzlTuYHx1q6qwDlvDLZSvoGegnMNFJyEnQ2i8oTyL+il+vxSAyRZMFP/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745696512; c=relaxed/simple;
	bh=nGiTzkgyWV3UJ6h50X/MleghppYjjyzOOb7IapZ0VYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KhMlOAtX2tuMXdLBVDk/clAaMvVDnH/jhIdQ84++/yGWvXe7PUKGLrfDQlfj4wNA1qmnt1ZH1ml6HFPcfbtDCtTbHkLP3Cjb7voRY7KA/CU6ZVqcbJP2MIXVkURnQ+bbtYMH335APsqJvPKOAJ9DGlth1cJwucRB1EAyGsKlu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaJzwHG5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7396f13b750so3836703b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745696510; x=1746301310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Byw1vIhkwK+9EDJmuXnFTb5afdvZ/3chefa4MUKhA=;
        b=kaJzwHG51V0I5uNHcMNt2zHPsL/frqlJeLGyFcJnYxRg3PAHfy72bvKz38pw4WhDDp
         wEvxbJBZe28dxyg6fBVbig2B0qztc+Imi6fH7AEDn9klPBbkFcEFsGxMVUX6AMC6Ltmm
         JW4rw3vvK8WWPbvISk/vmO0PE215WMAdEuHMvTNxcVq0Q/yBa5cgSDGkejoXFtigslxO
         1/eM/tlSLVn++BCx1xaWt6lGA0wW5c56OuSa/eFHLxEngp+7ZwDr1LRuhGtMxYqNzIUw
         fllYZUIf0/swv6d2RGbRyHp9hX81gyEFZr2BI2OrTK6ProY77Mq4PK4PvYaia69zCgJD
         n2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745696510; x=1746301310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Byw1vIhkwK+9EDJmuXnFTb5afdvZ/3chefa4MUKhA=;
        b=bd96z0U0Biv0xWJfgYD8EizAD8b98+i5vY39F7i5LQX3GfNVEJRQ0jQAgVjLI7fq2j
         hMDyU2qMNX7gEAOprbfggsnGa+IRNYMGCZa6uxs4bsOYDeumPR1gRRbBXi3b0WxnFBI8
         EActEKXR0/rZvAFmfIizgMMKI+bAC6pQkEeSyU4PHX47nL5IE4Sz1IMkpoXeVmVOinUI
         lbJRXGaargxDz3QmP5NpJLpbhD0KswF5ehcX8KFr7fSvZm18u5OmGb3us8gUgKxFUzoV
         zJMT+4+p4dza7fdmwXgIUhA/sZtlcx5zrlp5g369FWfrx9K91GvDbis2mmt3Z2zf4eEU
         lZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjWysSrsl/YJPmD1L4Y+keODcWmkadwWYRqNWBW3/KJZXxCWTb9sOPp2VpG43SM8Ie40P/gFrImtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrosD7Z6u5DQ5F8FKlAkRZt/qwmxbhlkRMUvaoMTktUoO32jo7
	A0/87hEclsOlLXHgpbudFPkeqX0LmPlrFdz7V37vjcHKY9u9te0D
X-Gm-Gg: ASbGncujdk3la8pKNMeJyNg5Ayzik5Cku09JSK1umlmeSYrhy8VpafSwDYCE/VLE5VL
	Ze9Sbf1DKhIQ+e987x2kE0NpPn4tKzVitwA9+7e1hEYGHkp3fQk6E3WkcxfzY9vKsukYnp6CJJ0
	hVRrIfthtMRa35P7Ww4S+9RoLKEswDOWM/34mZw5rk3vynCja/XX70qEhuSnYbRuoJr4zatZZFy
	49qxtzsf300U8d/S6wL67GjhxGqE9uKNriT2BPQe4N+1lc3FM+/FDZhtKIwk0bc4Zq1BgWRqANc
	3I/2JTCc+uSPf90MJC1oyTcVD5OK2veIn/g=
X-Google-Smtp-Source: AGHT+IEHYJyyGNLWMh5yLkVp8kBRFRP+co2gPyAPMINw8cejbXR2a95ExOqwPJmWybPIMmpd8Hc75w==
X-Received: by 2002:a05:6a00:99f:b0:73b:71a9:a5ad with SMTP id d2e1a72fcca58-73fd897ac9amr8771183b3a.16.1745696509592;
        Sat, 26 Apr 2025 12:41:49 -0700 (PDT)
Received: from BMO.. ([2804:1b3:a782:2d0e:d658:de4:4ebe:f6c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a17csm5168372b3a.111.2025.04.26.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:41:49 -0700 (PDT)
From: =?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancalvao@gmail.com>
To: jic23@kernel.org
Cc: =?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancagalvao@usp.br>,
	=?UTF-8?q?J=C3=BAlia=20Calixto=20Rosa?= <juliacalixtorosa@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: magnetometer: mmc35240: refactor volatile and writeable reg functions
Date: Sat, 26 Apr 2025 16:41:32 -0300
Message-ID: <20250426194135.244774-1-biancalvao@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bianca Costa Galvão <biancagalvao@usp.br>

Refactor 'mmc35240_is_volatile_reg' and 'mmc35240_is_writeable_reg' as they
share similar logic, returning the inverse of each other.

Introduce a new helper function 'mmc35240_reg_check' to generalize this
behavior, which is then used by both 'mmc35240_is_volatile_reg' and
'mmc35240_is_writeable_reg'.

Signed-off-by: Bianca Costa Galvão <biancagalvao@usp.br>
Co-developed-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
Signed-off-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
---
 drivers/iio/magnetometer/mmc35240.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index e08a57cd6de2..07f58567e521 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -418,15 +418,14 @@ static const struct iio_info mmc35240_info = {
 	.attrs		= &mmc35240_attribute_group,
 };
 
+static bool mmc35240_reg_check(unsigned int reg)
+{
+	return reg == MMC35240_REG_CTRL0 || reg == MMC35240_REG_CTRL1;
+}
+
 static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case MMC35240_REG_CTRL0:
-	case MMC35240_REG_CTRL1:
-		return true;
-	default:
-		return false;
-	}
+	return mmc35240_reg_check(reg);
 }
 
 static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
@@ -448,13 +447,7 @@ static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
 
 static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case MMC35240_REG_CTRL0:
-	case MMC35240_REG_CTRL1:
-		return false;
-	default:
-		return true;
-	}
+	return !mmc35240_reg_check(reg);
 }
 
 static const struct reg_default mmc35240_reg_defaults[] = {
-- 
2.43.0


