Return-Path: <linux-iio+bounces-16533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009EA56B1F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3F33B4003
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5521CC43;
	Fri,  7 Mar 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="HQkw6iHI"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B621C187;
	Fri,  7 Mar 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359827; cv=none; b=PAcL2MLj/6zXWL3yYQCS3kK+tGQe2W9ZuNScLx+9CmhOB6WYM2rF/zHVTN6xr+zQX4BiRHWAMBHWzL5WuNZrDMMBmASjxmdJh4pDWAqXq3PNsXicFe3mXgSKJYOkoueN460gcaghElekkKEOINxGPjU3q01mVx5QC3RfM2VEtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359827; c=relaxed/simple;
	bh=+Ik/gdyh+zfeJEolmcvNxqa0jLVuR+8H4QG2zWcmDDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lluy1MzFCPc7rncaMSL729mTmuHcgE/3IdbBS8kcy8hRGUyAXkGsN6055Ap/RAcbH4YbN7tUIM1keIXpgjWE9JDS5lc/cIkJrOFDggWTobwjZnckzzr4r/1hZVRAjNSv5Ii5WDX9o3XbF+XGm8VXHOkK71Z5yoo7h8GEPo4d9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=HQkw6iHI; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8V0v1x5Cz9ty0;
	Fri, 07 Mar 2025 15:03:43 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8V0v1Tl4z2Sd0T;
	Fri,  7 Mar 2025 10:03:43 -0500 (EST)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4Z8V0v07DRz3hhSY;
	Fri,  7 Mar 2025 10:03:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741359823;
	bh=+Ik/gdyh+zfeJEolmcvNxqa0jLVuR+8H4QG2zWcmDDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQkw6iHI0OP/DebnCP7zNiPEK+47tV0TMXx/kkHqMTFQ9/rXOzXf/Mo3b54eT1lPy
	 izMOvKpu5bYr8LssGgBG7ykPa/yCPX8YFbHpOF1Rp901XzRS8kShhUKR0Q3CHgXIpV
	 7JYIq7Kc+KbQvipKSIx6QLUfvL8RvnQQWhMRmFpkCKwSes9Vcm36JyxRlxiEVzLv83
	 TYdeiC/SP+rPfRcOGsznBmDrvY++cWoNDZJaA4cS+67atXW3YkiSrzLonKNUkyM5if
	 D+S9l8G/FaovrIL506m5ORx+IOXlIY2rapAEJQ9twx/vHuV8ll7TFI58Pg7ZI+YNDP
	 4YgnujllFL3Jg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 10:03:28 -0500 (EST)
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
Subject: [PATCH v6 5/6] driver core: Add support for writing 64 bit attrs
Date: Fri,  7 Mar 2025 10:02:15 -0500
Message-ID: <20250307150216.374643-5-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
References: <20250307150216.374643-1-sam.winchenbach@framepointer.org>
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


