Return-Path: <linux-iio+bounces-16490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C75A5565E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C163B3583
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899D270052;
	Thu,  6 Mar 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="QV60so3i"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33D2110E;
	Thu,  6 Mar 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288502; cv=none; b=dZG25MSIL0U8wAcx4r9Fls1OGFUpInZ/2YFaFWAibPEUBvWpXyNldnjYStDfgPU/0ZEGZRqgISPgr5sVvyJGGKlO1YTzX7rJkX73MMKJmTl7oPAZv2vk8LXvebVIIbcrtriIRjHsTg0qEX+g7bGgQjY1kghyqCOPMts6Ev3rM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288502; c=relaxed/simple;
	bh=+Ik/gdyh+zfeJEolmcvNxqa0jLVuR+8H4QG2zWcmDDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDzX5YxPMMS941+h7Du4G7Ugw+ZUNrW4PsIvhf7UFcZhp/4qKAHQHCdvsj7n2NdxYwydQEoNmzrsEsExdqKH3e7Nb41mL5zcEcONz9mNk1XZL9BzDcK1zLWE4VEPcH/eI0KS/6FQ2HAMal3X9iq5M7XMLBYAgdbhfp8IR3XBdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=QV60so3i; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z7zQq2zwDz3xSr;
	Thu, 06 Mar 2025 19:05:55 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z7zQq1Zf7z2Sd0Q;
	Thu,  6 Mar 2025 14:05:55 -0500 (EST)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4Z7zQq07Z3z3hhVH;
	Thu,  6 Mar 2025 14:05:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741287955;
	bh=+Ik/gdyh+zfeJEolmcvNxqa0jLVuR+8H4QG2zWcmDDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QV60so3iPg5fj6T3WvRDLiDrQVeb8QnbZ8hMzDjyWbAML4UkZHZ0orhOjnKHXa6P1
	 Gq66mq7rFg8F1L4E4/d/YVwRNRjEO95k7PimMXz7vmGPfvQ1oLVtF8gcPhifgVgtj9
	 oyztUOaY8YnEe1+xYPDD3lC1Gmi1f61Qs/jh3lupKwDwZFmEZip86k6acKAh/4JUPL
	 rfM17rR8M6NRYfIDwW1n8aUrkF9C+Lc3G/GYW67TS2zPg+5c3fSPjJGoC2Kjn02vKN
	 Vu8rGLVZYTBwJLhPVvDnTNirrFqy4/kkgLVJB1/jT8lYdUcjAeKECoW29Uh7yeC+us
	 FCElsU+Lp+wkw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Thu,  6 Mar 2025 14:05:41 -0500 (EST)
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
	bpellegrino@arka.org
Subject: [PATCH 5/6] driver core: Add support for writing 64 bit attrs
Date: Thu,  6 Mar 2025 14:05:27 -0500
Message-ID: <20250306190528.152133-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Prior to this patch it was only possible to read 64 bit integers.

Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
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


