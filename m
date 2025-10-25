Return-Path: <linux-iio+bounces-25438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0587C08EFD
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E54E241B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F72ED871;
	Sat, 25 Oct 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDDX/tTv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FC2EB5B9
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387631; cv=none; b=LJhu5UK4G+PJzpwtNAK22gZEigcauCKm2mz7WdDDcqv4f7sqGBd7iF4EdOKen9vFhma7osGtWTifxwze2DFnCcLh8atME8cjDuKtlI3hd+HW3f7bkkglDCi4nG3xoZn7tFDJgZGtu+i7VMOmIrO3XR+8fzLjt1xTk5O+iSHw+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387631; c=relaxed/simple;
	bh=n/WmFuxnjU+b5BqffW9C/hwrzM3poLDwCzQEeW+4gA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pm9mB7++gCPMf4JUucm8gUFoM3XKtcW3B08Q8N+nU2UsM5cS0d60kowYInOJdw0alqoZjYjpK254Z4pDMVpGj2WijDouFFAy1FCljvzN/6pOkyq0QZwaNRsZB+vOHLn1pGE3HYx4aH99hXXZB/LUtQBjNFlCZXEGr0WV5/tjh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDDX/tTv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2316699b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761387629; x=1761992429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vevNR+/jFaSQTBPwXQ9KXYtO+RS1f1boQpLGvPWQCE=;
        b=nDDX/tTvnsQXbSh+qGDh2osU4k/TR24I7/ORg2IrTSTIYxbEzPXI4NHvvneETOVnzI
         WSIreuJgWqWv2IIChZ5jYSTegKVCQqbUTH0uLxvLniP+AqAWM+ndTCrbKNvfBPpSqNDS
         pukt3b8FVzzMadmWaV95RjROlXfLoguV9GtIwo+GZGIjI7rsgHOX75YFwUcp7wwR5c5B
         g4pkoze+u5qhQZC5Cy1Mr3jmBmWUIn0HoP/TcVi1WZczIbQ2LfrunzPHDvow6wAgcicc
         dLRGW/S8SgHp5bVTfAf1neZlkMHj5/d7gGI+fJkNlhABmF+FnglBBbb10ZtT5ZzH6rES
         Y8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387629; x=1761992429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vevNR+/jFaSQTBPwXQ9KXYtO+RS1f1boQpLGvPWQCE=;
        b=oTxWNvwhPt9X8hqWbDdrbT+gN8HVivHJFncLH6jP8LaeipvfPODup/m5jBJN4zKV8Y
         Tr6hbmyZQAj3a1cioBziALDnd0lqYbVyIW54XHAkCGwvx7AQbovwNFTdgfuXjYYDVMGm
         0zbrQaDcaNuENLhiA8D9NRyV4JyIgndli5BF60hgwEjZAGE5Fk0Qq7lU5xkGh+Mf6ShT
         jJdKet/b9bckEaRfwgEzgbMgiRfEvcvJk+P8cbGAqSZaYy3SrTYE2eQipbY0w5JQpyo1
         ezDXkfEPXvd/Pzt/WVb6UW0cIBssrLcnwg/ZuDjr5xCn7Q2qcMi+YWVqjq2uWlmclsBU
         4ZPg==
X-Gm-Message-State: AOJu0YzMEbdqRpmjl76R9ofMoMRnRksW3s0b0Ug/3R326HMA4K63J8Vw
	x+KOJKOXczI/dxZFaA820W5KHHjivuvIWarJ+y0jLHHCeSF55e0xDcl2
X-Gm-Gg: ASbGncsaAtNS6PDPdJr9l5HnWJZkQNwr+hs0xLPZmTi+ousgJ2JWHolopLk6nPDATxj
	rFxblqllx9q7Hx7UkcpVmHZq4XJcoA9zc85uAgwvUM1Hl25OE18ymHT1llHCUVVIub4a1qEPNpG
	CDgsmeoZWVI6bLJD0nKwB7SQLR1pi8Pj5LlKtGV9NqeJeSGxu4a8zLrfy5M7D7wO3u3K9pivmzL
	gYsc8zfWK2e7Xop3g7fA0NbpgD1RYXtyTBu662ybEHFAI8dv8PZuRTQ3iTUtgYNUIAyv2FRF2eT
	mSjJK/enUl+NquVS3KsMVO9GrStTj8QMz3V42UzEbHMam4omUMYxkbduoUz9pq9StIjUHIhJ2iS
	WED7AhbBzTcVvZpC2K9Ac5o97Kf31N2XHw1S0JuX2TIZu1vT+aIilf/8LocYFFf73QmeParXGs3
	op7fIztbJD7wu1bWu7
X-Google-Smtp-Source: AGHT+IHSSS9RbZgpApd9MbHtHjSs8JwOUFPxSOsL85Q0eyw90TSB4I+atkWIog5jAkoofR97NPCzIA==
X-Received: by 2002:a05:6a00:2e1b:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a2715777f0mr12532137b3a.14.1761387628859;
        Sat, 25 Oct 2025 03:20:28 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm177639b3a.3.2025.10.25.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 03:20:28 -0700 (PDT)
From: kriish.sharma2006@gmail.com
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
Date: Sat, 25 Oct 2025 10:20:08 +0000
Message-Id: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kriish Sharma <kriish.sharma2006@gmail.com>

Add missing kernel-doc entry for the @chan parameter in
iio_backend_oversampling_ratio_set(), which removes the warning reported by
the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/iio/industrialio-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..937f4ef38e1e 100644
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
-- 
2.34.1


