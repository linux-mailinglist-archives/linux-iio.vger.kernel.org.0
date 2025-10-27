Return-Path: <linux-iio+bounces-25455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF06C0CA56
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1523AA6E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE112EF64C;
	Mon, 27 Oct 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF+BQEob"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4702EF65F
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556952; cv=none; b=uN8QmF9xJ3MebJgGef0BGcaWIoxXioxVopNVyKjdjJc8u6bPIV35ASsCtlr7tSsfyH31B8Uje0u8GINZ6YtzwZfin6h+hSum1oLbNO17MUj+TxU6bf2tpL9TqVY4IhHjcsDcyNzmr5vv/THWWxXYhISuf0wem70FNTdMz+ERXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556952; c=relaxed/simple;
	bh=xYwtmwuJN16UYCCSQN8XegEXdxrET5pvT1doRsmv3E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuDLchFH/xdod8ei84WJpMAilsv4bHGNUi+TTHaQq1Z/I8myW3J9XH30mpCmugIa8l9NF2euwnUCv6s2AM5yf9Wr27/IPwrWaSjvQuOUbPV40GW0dU7jjHOsPc1G+rWWEvOa3NuOL6Ek/czIZM6yOOHKg2RgFpBKwdzGlfddlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF+BQEob; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4095871b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761556950; x=1762161750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6nduzgu7uJv/ofQU5aPueTUIbSwgz6Tuyh1NKtEMbzw=;
        b=PF+BQEobK7D0zbxYfd0kE2ABm0+wJ9bJfwYkjqd1jTMoV+FKUN6OrTi2j64vhuRSEg
         nzVKGZmbKULQNBnzrGV17L026LmMKEaUhTI2I8ZZoeVCjt+LCS8N8BFIoJ16xgTJORIB
         IwiYfWsYq/GrMfDdxA8XKUX+DU3IS5wsVIgKZNlzYsEuZPsAzGA8sfT02xyXB2ODpaOq
         hu4lwZxNugWxSD+rXe2I2dB965e1dyIJHgc8v0ECpvSL8xRNQ6SrausFHiASuPGc6Hj8
         BKMaVRyIMco4DL+1qLHtrc+4pPi5D6KrhAo8QcgFjobs9SD82bO0+CX5Pb1Kf8WYksE2
         3yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556950; x=1762161750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nduzgu7uJv/ofQU5aPueTUIbSwgz6Tuyh1NKtEMbzw=;
        b=s+QVk7i4IssUDH+/JQwXChsiHu+HwjbuGruGhGliSGgJw68mDluFnP+71MsNj56KqX
         vUuxjMheHi76cELV1B8AXTEfLbdzXghM2jEtORLGsQQ25oRM3qLaPM2a3nvjKjej873Z
         R1dklhCTzZQ3O6CBe2nBpT+pzv9ZyLne0uso/4uBaV2GwR3hd/B8Ch4B2ypsIXufVwGC
         gSI1FZpVKnJWDYeKi+Tqps8A+QqZC18+WEkICh7imFgG8PZXN8g2R98AQFQ8F7Cy4A+H
         K+a3+OdwPFMpIyQ1VpeqYhN8pXSE2JS8M5K738gH4JoPnft9Q2qIO2d1g4cHpzlGWN00
         w1WQ==
X-Gm-Message-State: AOJu0YyBBqe/CKUsR5859bQ06ws4ebQHVWjhwo/j/RKOXJbihuGAS11Q
	r5JFlGXeAqJL1TQr+j+h4pGUvM88y16swiN7pQHIxyygTVwfN6OAAVih
X-Gm-Gg: ASbGnctnu1KDqd1IAev/Rn6Z4X0e6tnMYb1NOQY+mUqu5YRILlFA/GtEdrsjV43NSlH
	R4Y2lD5KxRhVFHGf0bpchLfAm5/gUkBmi6KeMjLVupJW3CBsXFK8G5QXGYuSGLbF9WxFQrlqAZ6
	yCfrPWGGVFxDvuZ6yVqnOn6sxxtDlGBZDyF1xv9v9X5xBX7ATotS/yfBfxOAtBs2c32ij4AR2aM
	PT/Q5efltvdmzr2zrrYf11ZOp6JLb5bBVN7QUqQWO52GFa+nfbaW6h700fEhJWSBjBtXsV6oQ8u
	U74u2fsuNKIy5soQF56+XHnlsJtyCP/xWohExjJmYWRWj39KYNp0NmsaeJMIJxomi6TIJ+0dWpU
	RbgeGliJooF29yvPT86o7GHTBwIC1JaoIlBSrk87yz6Oa5Hwq+o3r0G4wVQJcMrWEsD8wpADZN0
	5CEJMjz4gRCwugQ4TWNfcFFpVDX9U=
X-Google-Smtp-Source: AGHT+IHwKsgYliTV2wTCbc/bXnkML5X5seoRKr9zuhkrIEJy2H+HHcWXKc/mPlJxZe1MtqxZedPn8w==
X-Received: by 2002:a17:903:11cd:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-2948b976577mr140872255ad.21.1761556949865;
        Mon, 27 Oct 2025 02:22:29 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm7842857a91.5.2025.10.27.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:22:28 -0700 (PDT)
From: KRIISHSHARMA <kriish.sharma2006@gmail.com>
To: nuno.sa@analog.com,
	olivier.moysan@foss.st.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
Date: Mon, 27 Oct 2025 09:21:59 +0000
Message-Id: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Fix multiple kernel-doc warnings in drivers/iio/industrialio-backend.c,
including a missing description for the @chan parameter in
iio_backend_oversampling_ratio_set() and a missing return value
description in iio_backend_get_priv().

This addresses the warnings reported by kernel-doc and the kernel test
robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---

v2:
- Fixed another kernel-doc warning.

v1: https://lore.kernel.org/all/20251025102008.253566-1-kriish.sharma2006@gmail.com

 drivers/iio/industrialio-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..73704cc1bd03 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -717,6 +717,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
  * Return:
@@ -1064,6 +1065,9 @@ EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, "IIO_BACKEND");
 /**
  * iio_backend_get_priv - Get driver private data
  * @back: Backend device
+ *
+ * RETURNS:
+ * Pointer to the driver private data associated with the backend.
  */
 void *iio_backend_get_priv(const struct iio_backend *back)
 {
-- 
2.34.1


