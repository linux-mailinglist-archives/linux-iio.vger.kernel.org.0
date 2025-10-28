Return-Path: <linux-iio+bounces-25563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BFC13DC7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85E9541E78
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0542FFDDE;
	Tue, 28 Oct 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky9zI9Rf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACB29ACD1
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644031; cv=none; b=B0cn160QSsoBxVyCaAl/7nPDju3Nfw4Wfr1a8b2xvHOmGdhEi9yyMLnOMRzIsyQZaADTWBZo1Zd42fkEf2PZ+7JElb+ZIc9yD84RmDZxuNJL7Ris3E8ZU9KqsGfo7AV6lSR3j/xgrKexl2JBVN85H4QNJgt6EB8w2vX6lbvDCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644031; c=relaxed/simple;
	bh=1tBI1fKtiAUVvLhBl+QlinXByKOL31usMx/Gb+Ms4ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=saAffoWIPUUDwvv+TXsEX9xHpT8G1uRYMppSnAENGjbZlOV3NyB2TVHNACuTi6GpjUhcy1NudfD7q1cUx+SsiyeFi92zOnCcd9NJdGiBILRV3j/kI3XhhIC2Gtq782clVESBYI8Tjh5E1+44nM+9jiFzpVU/HFojtnybOlMPFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky9zI9Rf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so71033105ad.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644030; x=1762248830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XbbD0XUPOCx5w6Va6PKcmpMHJKzovEwVaWUKYe40hU=;
        b=Ky9zI9RfQmP4NMnYPnvFtloEQ/nlVl3jFxFIBahG8iBYOJrkJA5loiRr9MhrmfO73E
         D+IsFJKOqk08mb20DgytzosXwNDIkxEHfvFTj6J2O7mi3Z0NpG1rcAbD+/FrxAEcB6Qm
         YEtsnweVd1oU8fHY736O0llKM7mr4VXPPh+36rE9W2igfpRVPMpie0YpM9qWu69DC6wA
         ZoN/AoXg3qb67IuN+guSCO98cJXpUfa6rLuNPPzE56avxdl8ukEYuXW+yrH6yqoVuTnj
         U2VFu6Vvn41H/x4uu7iDNQbGu8MLx6yFzWiAGhvMx2azNPN+o1roca4LiFTNaVrNyvxG
         ubSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644030; x=1762248830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XbbD0XUPOCx5w6Va6PKcmpMHJKzovEwVaWUKYe40hU=;
        b=Qkpwu+3iLFzSvx7HpaGc5zgPMKbRPolzS/BYy5L7mIqey3rBD4DXDlSOzSDMj9qARu
         wvR/7caAexBifbDiXrXynoQyn1xBcj+HLqyxtrNR1GS/keNnDGUK3Uv7UC2s4CjG0SgD
         9YatqHhgDlF2dPjiwKt7J++FvdrgCDlitqbqjG6+uqBZ1+8O6F+9qrZ52TxFfa+TgYZi
         EOjM+ErDdcWy/lZ691q9GlW49r+EjcsBOrfTzpllOIK114NpO/bU0U9WerhFQTb5lRIT
         b/9k9ZyWgnXhLa2LX5zS39OiwPzS//QTnwbOiA9cIOZ+8XNZbLmDYy/ujYdNL8wxZSp5
         wN9A==
X-Gm-Message-State: AOJu0YxUQ/b71pYXXn9WUap/SJaVlc43TZHIos0y+61VeByQ/wfm1lwc
	fpQRIw+j0EntaSp1eCvCRa+HE/cN/HVgHE3Zz6gE6VkM7v2uuiqMvLRs
X-Gm-Gg: ASbGncuel6Cbd1EDegFaUgI9N12Gl/SKqym6/g9cSHw5AqzOMCi/kTkQbCHxsP5sCc5
	m475D7gAviSCPaZGv4fxkcqlyyDtStazfySpUZgw0KOBYzS7oBqMc3PZG+snSbWnuXGGbjGkLec
	QuRtGbwFgNCQjJq7x/AMkidcuEGzrE8+rtrDMyhQHUuKxElpkqLsFR6auH4YpqBmlRtHTKwbfFj
	/Plha7quvidXu8C2N/k9FZtHdJank2ksmWPJy7L+fHxYpl+xv4zu2x2ORsoC4dKU3XC1esP4qpz
	ylAP4n2VHgEU3wYfykKr+CIIzrlyZWSMLVNQSTLen5vJ66oWCAi9t1ShVErClbLa+EKn/JGF7Qu
	5EW1ba8LXcf8B0Tn1DOEucvbW/fGhuTtcjV1O5e7uPgO6+OJWdDG711K1W2KQfvnrwBIBFou/W2
	uWhFF0u1waQrqm2Ejn
X-Google-Smtp-Source: AGHT+IGNqDKOcuei+TEE14MiEdWZNPbqqDIwZ5o9/TpCj1YrL3udLywKrVrz2O94Cfm+4TL2T6UXig==
X-Received: by 2002:a17:902:e545:b0:290:b14c:4f37 with SMTP id d9443c01a7336-294cb524eafmr36342495ad.30.1761644029561;
        Tue, 28 Oct 2025 02:33:49 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm109367625ad.107.2025.10.28.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:33:49 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: nuno.sa@analog.com,
	olivier.moysan@foss.st.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] iio: backend: fix kernel-doc to avoid warnings and ensure consistency
Date: Tue, 28 Oct 2025 09:33:26 +0000
Message-Id: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix multiple kernel-doc warnings and make the documentation style
consistent in drivers/iio/industrialio-backend.c.

Changes include:
 - Add missing @chan parameter description in
   iio_backend_oversampling_ratio_set().
 - Add missing RETURNS section in iio_backend_get_priv().
 - Replace Return: with “RETURNS:” across the file for consistency.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
Suggested-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
v3:
 - Changed Return: to RETURNS: for consistency across the file as
   suggested by David

v2: https://lore.kernel.org/all/20251027092159.918445-1-kriish.sharma2006@gmail.com

v1: https://lore.kernel.org/all/20251025102008.253566-1-kriish.sharma2006@gmail.com

 drivers/iio/industrialio-backend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..447b694d6d5f 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -702,7 +702,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
  * interface/data bus. Hence, the backend device needs to be aware of it so
  * data can be correctly transferred.
  *
- * Return:
+ * RETURNS:
  * 0 on success, negative error number on failure.
  */
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
@@ -717,9 +717,10 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
- * Return:
+ * RETURNS:
  * 0 on success, negative error number on failure.
  */
 int iio_backend_oversampling_ratio_set(struct iio_backend *back,
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


