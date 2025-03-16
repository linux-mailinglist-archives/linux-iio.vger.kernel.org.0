Return-Path: <linux-iio+bounces-16905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF6A635D8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471473B04A2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE071A7AE3;
	Sun, 16 Mar 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="cE7YNbtf"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB825771;
	Sun, 16 Mar 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133069; cv=none; b=ZvQJFxZhD5cai49gCl21eYCOvqp8p5bADFIYQC59wnbgxYaKoUAaIWg066M8c+ghc6oOo/arjJZ+jCtrFEglc1iCPHgLNwoSzFDXJY02BFdUl1vHGXV0IjZgL5mHTI0vSgJw+DH31A2l7qWKdXiU7ku2FqoiEJPlHRkbyeN/AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133069; c=relaxed/simple;
	bh=rPlob9E1zdI1JHOhKrKRb7F75yfM4CIfwUErUMLk0/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjMHwaAKDCTXCAnO9+qgA1zJHpsutHUPzYhJVucOVXF2Xuz5FL3/IU+vbGx50JsjDjal7PMvitYpwqwdjLUaHYvuAG6UTbMlDFzreb6OmYpy4rxaSvASTxf2kVWgObKk0bEkSl6oxJlAhY62xiAdrsr/kGk5T04khLpYC3KTeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=cE7YNbtf; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZFzyw3HkPz9sNZ;
	Sun, 16 Mar 2025 13:51:04 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZFzyw2RH8z2Sd0Q;
	Sun, 16 Mar 2025 09:51:04 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4ZFzyw13hWz3hhS4;
	Sun, 16 Mar 2025 09:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742133064;
	bh=rPlob9E1zdI1JHOhKrKRb7F75yfM4CIfwUErUMLk0/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cE7YNbtf7CXeSuAU9ViVYj/Z02d4KIbvtp5Kf9RlwfZVZEAwUyHQD4E2HdNTsKC2W
	 4rFFXlZ+0oosKtnnzPEGCUiisxuVcX14HCX2lLKGuaEVQf5yIMdbWviVeVyOX6IWqi
	 Q83TvHZUZyShdR/4UiXrJ1rMAS/6ff/ukM7w1cOZnxrkIk6j3PaTto1hy0pjpw8IBK
	 vqPtD3uurGLsQZ5mDKsIZ7gYvvjPFyHlFAx06479hcoSJVpC7Q69YLwy7VQ6MNPaJ5
	 MoSydEY7aYrPMQo5AAQp/laKbQzlzyPNsXYP3hVhEbGkGhr4jlb4SNYWRQ8e7qrsup
	 PZ6eRfD31DZjA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sun, 16 Mar 2025 09:50:48 -0400 (EDT)
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
Subject: [PATCH v7 2/6] iio: filter: admv8818: fix band 4, state 15
Date: Sun, 16 Mar 2025 09:50:04 -0400
Message-ID: <20250316135008.155304-2-sam.winchenbach@framepointer.org>
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

Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
the ADMV8818 datasheet

Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/iio/filter/admv8818.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index d85b7d3de866..3d8740caa145 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -103,7 +103,7 @@ static const unsigned long long freq_range_lpf[4][2] = {
 	{2050000000ULL, 3850000000ULL},
 	{3350000000ULL, 7250000000ULL},
 	{7000000000, 13000000000},
-	{12550000000, 18500000000}
+	{12550000000, 18850000000}
 };
 
 static const struct regmap_config admv8818_regmap_config = {
-- 
2.48.1


