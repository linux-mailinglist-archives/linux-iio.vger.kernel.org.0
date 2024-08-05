Return-Path: <linux-iio+bounces-8251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598894805E
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 19:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B33B1F23930
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351515ECF6;
	Mon,  5 Aug 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE+l0mzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D215C13D;
	Mon,  5 Aug 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879222; cv=none; b=Agse7iyqyQbCRpMSxLuUf/G5CKsmRZbulryRPjKP7vv2YYcSz61HJpuuDdm2MuaiZBFtD7CV4u3sT6iOc+ze3DA+O+MQZjG3YrQBEsjXqnlRZMvz7bZ/zLpAVAxjpLttegd+nEMhBIZeBIaApok5VtTQ1vZtLwbsj0aWn9Ff7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879222; c=relaxed/simple;
	bh=VDS7j49BPsnFZeqpRirK8AxjIZsyvDDjwjimYbyb+A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDumPMU9LClHX3mmL6DECi3VrForATD9bJJv1ysOC6R9sf0aQOduU/T7tw1ZimvxcPUi9gJHDV888HDlH2nQx3yLi7UDWUl1JENp5BXSiduzuuJUtYhTIWCNf8efwsr2fSgp+YVsHG/X8uJRCkolkhPQV5SOzw1fLKrCX7yROrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE+l0mzk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7107b16be12so1970606b3a.3;
        Mon, 05 Aug 2024 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879220; x=1723484020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BC58ALjQ0k/p2Nsr/D+i4BGJm6NI6tNXoREVe12sSXQ=;
        b=eE+l0mzk8gGTGmOpTSzHI/4aEWkE+MVT7oKpLPK+NhNoFNrll74K6MfTd3Ttcfhj6K
         gDtishSmPwCThgdolvNx4MEEc1VM0/Zt9YwaoiMRG+V/yzYDhPTlQQy+NMtcanWgxt9J
         GnrbH7oLoVWR0qcIaR0mjcX0I2mACIN1mH7sFTziJRxp1jjRh2hfQVZOw0D1Qb0Cbk9N
         feCtwjMh+OC0hoVtMfi9SbkxvPZNfNw9lgc8IZlroFHxJe6/4mxNZFcXPbgf26kE80rz
         XhG/YFaEwxt93zy+ZHM4n9iE8oiKHOBL4SRR2iJYuEvYi3V+hsN3gyub42n5X3x8FGrJ
         Hs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879220; x=1723484020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BC58ALjQ0k/p2Nsr/D+i4BGJm6NI6tNXoREVe12sSXQ=;
        b=ppMqaoJWqyFubzdlMMuwbfNHc21lwrDCisOQZshr1BYtWcnbMjwH7Et11GdsFaS9cJ
         cFfa9/22YB2tAQRAZCzQ2J0NgYeniIcM5/4uHO7bJscHgqYyHec/F8F+4Rgo5fzsKvoJ
         2y6Ogr8/mQCTff9UfZ6r/TRlr0t0fGBGfEGEs2znufY8bFolziYwpI9okqgQCkAv9Zsk
         o/Aof9QBNju/B/ECS9RdMRYPPRbHHVoXTbhh8u75DrV0f6BQhHtI1W1QFn8zFV8nWts7
         FrlGUv1gCWczdctMN75jeupgiYKqmeifjfebq5KTjNrv9ETLlfFtxgPVBt03HWbb4sWQ
         BFmg==
X-Forwarded-Encrypted: i=1; AJvYcCVWMFtlJvI7KFvA0wSGdeI8v/MTrScsPVjU1MKl8DTbY8mg6VI5PPDySA4so5Nj0x88aV6oT5e04TSHckNq@vger.kernel.org, AJvYcCVdGbzRD/CY6eUwpiath3NjuAEuSBokSgU3+gEElHzptWiWFMD1Lv+kUFyERO8BJGi5QU87kFw10u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPc6gj3x6ArA3wYQjHBjRmrsx2CKv1kVgJ6hQEUG0yuSe4DUa
	sHqTQ7Z+RN13xryEkou5i2m+MDun/OtmJFCIvphP5NaAeP+deOCN
X-Google-Smtp-Source: AGHT+IG09fbbSSvmY0g0CZtZReU/Xafert7x3pxP12VhBGiXyRrY3gH9XY2qrh3kran4KU/jGnehWg==
X-Received: by 2002:a05:6a00:4b4f:b0:70e:8f75:35b2 with SMTP id d2e1a72fcca58-7106cfa6ddbmr11487080b3a.12.1722879219928;
        Mon, 05 Aug 2024 10:33:39 -0700 (PDT)
Received: from embed-PC.. ([122.169.160.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfed4sm5620807b3a.119.2024.08.05.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:33:39 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	biju.das.jz@bp.renesas.com,
	nuno.sa@analog.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: bma180: Fix dataready interrupt to use INT2 pin
Date: Mon,  5 Aug 2024 23:02:37 +0530
Message-Id: <20240805173237.475797-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the interrupt configuration to use the INT2 pin for
the dataready interrupt.

Address the FIXME: support using the INT2 pin.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/iio/accel/bma180.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 6581772cb0c4..d44409afffbf 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -126,7 +126,7 @@ struct bma180_part_info {
 #define BMA250_SUSPEND_MASK	BIT(7) /* chip will sleep */
 #define BMA250_LOWPOWER_MASK	BIT(6)
 #define BMA250_DATA_INTEN_MASK	BIT(4)
-#define BMA250_INT1_DATA_MASK	BIT(0)
+#define BMA250_INT2_DATA_MASK	BIT(7)
 #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
 
 struct bma180_data {
@@ -425,10 +425,9 @@ static int bma250_chip_config(struct bma180_data *data)
 	if (ret)
 		goto err;
 	/*
-	 * This enables dataready interrupt on the INT1 pin
-	 * FIXME: support using the INT2 pin
+	 * This enables dataready interrupt on the INT2 pin
 	 */
-	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT1_DATA_MASK, 1);
+	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT2_DATA_MASK, 1);
 	if (ret)
 		goto err;
 
-- 
2.34.1


