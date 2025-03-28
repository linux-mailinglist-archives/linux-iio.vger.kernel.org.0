Return-Path: <linux-iio+bounces-17318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C632A74FBA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217501897449
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00A81DDA34;
	Fri, 28 Mar 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="TULhu90M"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BD1D54D6;
	Fri, 28 Mar 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184218; cv=none; b=Qe7NfLgYGHps4XxVPNlbVIx8Xwrq3jzG6WVH0sb0YGY6UGB+XFnhzh47UVyh4eki+QrFpbKNESeIYg/K26q1WdqUCt8vOpwT/7VmG7yjtvCjMpmH7DCfKC7+OUn/zzZmY0C8sUy9Q9jRis7k7AO4bmVuJNwlkcpYYTKPFc0HINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184218; c=relaxed/simple;
	bh=zC56drG89Xe9CG1AlLuqDbjlf7mKaAUiWGiyNWQnf7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI0rujmThpn1vFFjEXK930rKZOoxRcN30KAcvmqOgXkj9jq93SFmTtedNDgUO5OTgOvUn7mmUpO11kErIv9uEBYKFpvBPHWqDhKa/MnzKXF9H9Zfy4fyzLRVNo9bimjxJlbSGpgMVdeQ/s3CpSJWEthIqyVO8MtpI2pgMIfXokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=TULhu90M; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPSjM5qpWz3xFM;
	Fri, 28 Mar 2025 17:50:15 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPSjM5BTgz2Sd0V;
	Fri, 28 Mar 2025 13:50:15 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPSjM3l2Jz3hhTl;
	Fri, 28 Mar 2025 13:50:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184215;
	bh=zC56drG89Xe9CG1AlLuqDbjlf7mKaAUiWGiyNWQnf7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TULhu90MoUHdgh8qocsDcUwQPUd2uJc7AVBtAda7qdKYzJhzjSko/sqmgKnG2YqoQ
	 zHUbEa85Bxf4P2/lXfFfib86nMLSDqxo0dt2Ko2R1HPYFkWHnp0TeWs6IjFg4lS2tM
	 Cg/+UAPA/DX9OdKKj+SbXLLuM8BpzYFKzmNX4K96DGUIOjvBMkgChFBekLG29PG1GY
	 MFb0pKNLyYiORK7p1zajOOEprA2n4F3JjwOkwj0wN+lAMRSBmDReSGRCLXnOXMTAnL
	 G61WMmwYDjmG71oKg9b0SDq/gwDAhUU4IHNpWG6pIDbj4nHNee7o27wH3lwCh97Vrg
	 UsEKLpAFJFUsA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:49:59 -0400 (EDT)
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
Subject: [PATCH v8 5/6] iio: core: Add support for writing 64 bit attrs
Date: Fri, 28 Mar 2025 13:48:30 -0400
Message-ID: <20250328174831.227202-6-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
References: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
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
index a2117ad1337d5..b2436b8f3eeae 100644
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
2.49.0


