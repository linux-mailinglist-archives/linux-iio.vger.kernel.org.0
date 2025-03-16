Return-Path: <linux-iio+bounces-16910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E098EA635F3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 15:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8993B0F9E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663441B392B;
	Sun, 16 Mar 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="W6mUAXpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7471AAA2F;
	Sun, 16 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133603; cv=none; b=W+pRwGy6pa4DhbPXqRSJE/Ob/8fcl1Y0Pg1+nQlwHPGeM+Bl6zxSLQZz8KJDC5CFg03uGY9sWULh6PAWS/EjsGb6M+r4k/hs+uX5g7DGa/oMHwr4kvar5mdpopLLPqveF/I422czo+p8iLP+HmZUyJLc/Q0XGMgahK07BiZAUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133603; c=relaxed/simple;
	bh=ljc3oesl2r1E8aZ9fXFZUkkJvxGlE5eoRSoQ7GRd9BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIccF/1e5W1iG7je1/tBAmB6h/bBe5IRbQn3u8aOn3dp7CTNMi4H4JGrKzNhZM07j7NIPNxeVCmWTq72SSoqc6XOhXcP6uWZe4xVab1C0Dt5fmMoEDb6yQqHmAHv0DiLbCrhyxJUObNAuJtVBwWMc9wqawBrHzTMqfanWp7/DzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=W6mUAXpG; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZFzzr6ZFZz9sSS;
	Sun, 16 Mar 2025 13:51:52 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZFzzr5jLlz2Sd0Q;
	Sun, 16 Mar 2025 09:51:52 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZFzzr4Mv1z3hhS4;
	Sun, 16 Mar 2025 09:51:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133112;
	bh=ljc3oesl2r1E8aZ9fXFZUkkJvxGlE5eoRSoQ7GRd9BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6mUAXpGW8eKDsk3RQqQf1r5sfZB1CoTtBbxRLZD63/fIA8qfKnmaH56gbUup/McR
	 TsshCVehpJ4BjwfGTIrocewkeLKZR5PhYYaBY+a/w2vYkr4u1CpPY4m7oZyOE41djE
	 kPqnJY/yq1jRZJUI6/UVyEepEUZXRb57PWxDZumxb+WrqFaR43qsOi5AUdBJF9ntnm
	 pz7lqrkUFtTxceofxLH4Jo7m5l/FrDFkzTSjhv89C8XaIlzyW9BNlkDxN+G0DiPp/x
	 KX0YW634bPJOL3VYaPnMGYf3v9D+PzfCEJp9Tz2YXXDfR4D0tHr0sMSK3dEJC+XKLp
	 FYIuBHY/QyBlg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:51:36 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v7 5/6] iio: core: Add support for writing 64 bit attrs
Date: Sun, 16 Mar 2025 09:50:07 -0400
Message-ID: <20250316135008.155304-5-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Prior to this patch it was only possible to read 64 bit integers.

Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/industrialio-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2117ad1337d..b2436b8f3eea 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -965,8 +965,10 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, fract_mult = 100000;
 	int integer, fract = 0;
+	long long integer64;
 	bool is_char = false;
 	bool scale_db = false;
+	bool is_64bit = false;
 
 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
@@ -990,6 +992,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_CHAR:
 			is_char = true;
 			break;
+		case IIO_VAL_INT_64:
+			is_64bit = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1000,6 +1005,13 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		if (sscanf(buf, "%c", &ch) != 1)
 			return -EINVAL;
 		integer = ch;
+	} else if (is_64bit) {
+		ret = kstrtoll(buf, 0, &integer64);
+		if (ret)
+			return ret;
+
+		fract = (int)(integer64 >> 32);
+		integer = (int)(integer64 & 0xFFFFFFFF);
 	} else {
 		ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
 					    scale_db);
-- 
2.48.1


