Return-Path: <linux-iio+bounces-13287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77639E9DC4
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 19:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B2E1883CFA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A61547FE;
	Mon,  9 Dec 2024 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM6E+uUW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D1F5F6
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767373; cv=none; b=LMLfCZ7AAY4sWkvX++VQwtSqpSu4bJAIDSv1uYotbxgm5uMrzFGZbKXSAK87r60lFNLk7SUeXSU3aA2OPAjbDCbROWDSl51GIKaZtw+eQUXXcd1b4EqXgig4Xg4spseKVuTI7B27DyPwE1V/LOMVe7QdXN3CxVBTeGzkO+QF9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767373; c=relaxed/simple;
	bh=ZhmNF7in13BqxBaJU9AvphG1nT83gebGKRdGzWIrx9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L35Vdvc/DfIvLB5+2cO45oM1PkpdO4fKlPPOEp3+nkYMAmbKuYUEE/BU5+k47KBSTZgK5+BjKNzu/SUkWMbE1IDJVnxf1TUvrFnjt7BXaou4M3NnGFoRDcZjGr4IdyQOMofqtjPbuuxjaZdeBHiVeVdNIUzU30TD7sCMR3b9Kv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM6E+uUW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725c86bbae7so2467682b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733767372; x=1734372172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVVtS2G5EIoT5AAsbQl6KKyn7ZhWJ3okvaSoycJlsL8=;
        b=eM6E+uUWM4VqDQJe4nAdy+OzglXktVG0h6SC6N0x2xNxJfw1+sQecspry4Oekylw+F
         uYw5xYm14dxDe1AGER6R4/Jn36VYm9fYfHSohmBcxnYbVTBMgBChh+Op4xYYvclQrfpR
         SWooED7cfXtdqGeuGoAP1zCnTBXoS9rExJMmcUcs50OHo5io4IZ07pU7kn1Lmrt+o0Rj
         R010CpeduUdF8xdNViD5Ia2WlhwcEhKo3WkgtykvnkAT/Y4ghOyHdtSMJhYLEfgjgUCg
         IF2F8JIA4GnOE9XzjtcmvszILzVsB2VTrW1uJW4ws/Uu9dN+bUPnj6Frvb7rZQsBURWa
         /4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767372; x=1734372172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVtS2G5EIoT5AAsbQl6KKyn7ZhWJ3okvaSoycJlsL8=;
        b=S0yKiNzRtAVQECZ9nQgKR4TCJJtp5gmzuE7f3TSxJgWrCUaMFEOYtFMHAx00f1QXRk
         RO/ME0xW/YXgxcgI/PohNFBJgW57Awo343hAXn1OAe0WNvYQH17u17LFGFRSGH4C3QMY
         sJV7nF/0/7OWrR9tLPgVbA3UbTiinOwXNQrqycqCzaQIn3xUeNqj5zi9mBcurI5rA1Qw
         0BQaK3kg3do/96u/hxSarBjdDJ84UXKzYy07sza/4lNw36oX3/w6qzsisektQAMaexkR
         Y5ro8FfUssvBHXMI8MnqUXXq/eOUWevts85+pIrEsCDEMjiLIZBSQK568tq789Y0FeSd
         VWSw==
X-Gm-Message-State: AOJu0YxzYU69uKooVTi6qXR2qOhFQFs7Db6D52zB2tSVMYruJER7cZ7J
	77xtRXs3VqEN91VSGohJ4KlzZ6STUgpu3v9J4Vm+LhE5OHhefshK
X-Gm-Gg: ASbGnctmW0fQojXEagEtBTwETkue9Fq27vk9KSVbmf4ki+g+0qSXDKD20SDcK5l7E7t
	VTIGlHJvILEkeKywQrOO624MGPKpnncBN1BpQV6cRCUSjn6SgXxD56G59wfsOH9H8MP+K/WT9dY
	nV0lMx1BLEBS1dXBwTkvK0vDZrxYqMVPv6m0eWniIg8jIgvaSgUIEW/BgEBnBqFdn9e9+cKrhqu
	r34GNOcylPrsBDJFsetVyB9ahS0wlJ6wRCrOmieSL0I0rwtE8IUvow69qItMdJm2VFK
X-Google-Smtp-Source: AGHT+IF/dRmR/WJdzNGQYrwksKVbAdkrT1khZKoGw4FeTwej3hUSd0U5GJYSsYvMNbQfvb5tFw1Gwg==
X-Received: by 2002:a05:6a00:2282:b0:725:4109:5ac0 with SMTP id d2e1a72fcca58-7273c8e36f1mr1770693b3a.5.1733767371551;
        Mon, 09 Dec 2024 10:02:51 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fdbe:460b:c250:a651])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e7c98efbsm2919509b3a.186.2024.12.09.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:02:51 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	andriy.shevchenko@intel.com,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] iio: adc: ti-ads124s08: Switch to fsleep()
Date: Mon,  9 Dec 2024 15:02:42 -0300
Message-Id: <20241209180242.1258587-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

According to Documentation/timers/delay_sleep_functions.rst,
fsleep() is the preferred delay function to be used in non-atomic
context, so switch to it accordingly.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/iio/adc/ti-ads124s08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index f452f57f11c9..77c299bb4ebc 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -184,7 +184,7 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 
 	if (priv->reset_gpio) {
 		gpiod_set_value_cansleep(priv->reset_gpio, 0);
-		udelay(200);
+		fsleep(200);
 		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
-- 
2.34.1


