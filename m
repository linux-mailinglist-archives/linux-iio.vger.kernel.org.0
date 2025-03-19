Return-Path: <linux-iio+bounces-17117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26BA69A64
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F608A5D81
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6732153FE;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/ORuewH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764520C486;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=VnJER+oEx2ZQ3dcLWpLOToKfaHT1HX9sejBtUHGmA7OSY8gb0ifGT9f5rMO9Yz6YMYvu8Bf/NsYBUbSlj0ANZmg7j5pOO64ZSIQpkXEslZSQM3m9yumaCmUUKLki+S/sM8PCx3dis7kKoGrY0DLhYD0WzREiHhr9bQmIxaNX7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=w7HnRxljEAVoN34ETPZRC9dbPekRdsP4k7Kni7Ao/TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q73e4O1szdK80RS3n7PhBAEGf3JY1y0nUbSH9uaYdO52HTJCaHjebnsoO0KYzz7V+wfIhUwPOzo8WAuM6FVX5HjsshEvVMopM7RvgOLrosi0UY7KdWtmCfpYzGNqWMRmomLgdpPt/a5KE6w62YZfxsjoxHB1U+bSgmAjt5DTtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/ORuewH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F82FC4CEEF;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=w7HnRxljEAVoN34ETPZRC9dbPekRdsP4k7Kni7Ao/TA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r/ORuewHifwBOkIQsr+x8fCUbXMjayBPN02YAoCfgrPWziLMxThqvAlr/xbto1rL8
	 RgXdxAXTZWcqabUuIPFY8CTOtAG37xTlrGeD+o1wAE1ff3BOcgx3ZqIksUxw/94uwR
	 UOkyCVxqHNRPfCi+vqJrY8DOFm8k1SyRDDXZwIu3FAVziTlRPYD8+8EXcqyS+2iiJn
	 ws1oU33pSIT0aDP7M9nbdMTH8TlWvw9SW0WbNG3YYsb3Xny4GCsiBLYZHA3Y4L4L6E
	 32IM9Y+eZXnUHv/Gl4oTeyM1rPX2+1ZrlgfEB/U19LeQCYY5ZKIRjbpv4ZDg+azSoN
	 87yOw8uplRK/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B0C36002;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:43 +0100
Subject: [PATCH v2 04/13] iio: light: al3320a: Remove DRV_NAME definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-4-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=podRMdd7qcZVHdZFZlFuKdLaKGh8xBj/PEa8jmahNxc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9cxcPFjtvjXTo2zRB3fD1q7ZuoiU+RRJno
 RP4FiMUKOWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 chtoD/0UL3tEWdE/eR7ZJj3B2TYv5nY9R1jIfhmtSA6d7/vWvxDnZlTctMQFuEC+Sw7TSPboe/H
 wSRNval/DE5ZmtGULxquuCHXWl2npgbGVKqmos5/HXdbGzCx+2UXehtGn9TaQWRlVY0TbY6i3yS
 EkdTJdZ6mMYDdMjDOsokHk+0rDg9/y+0gcnFJEgxFKejXRRbitjNffGHH5c+If21LpoQX6+Q1NG
 VB4gcJtwOW3h3aqM6mYjiWhWB5CqF+bMKk/iVE8LsesT9+AWTAnSBk5x21RlN/LlV5HnG487LRZ
 OwKMuqjXq0riAJPGZrN3GZjDZZt8Esmuj+ULKe2mM/Zp1/AKaU3PCSSS3v+O6AQYLfjz88OiDW9
 ssyU8OVnWm9rPtXOdTJH75sLgxLA8WIesECZz7rPxXbX+RSRfkmiX8m5OSQMMuQz83CZGhp8BD0
 lpYCYn7K5BgTkFbuB1TCZKsYem83He3euoQ3M4AiYvXpDnrlUUrtvN9amkuwMVA9em6vMDvvZJe
 AoCzvCmGH4qJMvfFgKPANfoRVx958VFOAdrfZQcj/EZqExzAPkHnZs1HOFIM7cm0j8v7oLXGNXs
 ImFkn6ODHCrPeE4/BsFivr5XgdsoIvulsMLG9nrzgTDP2349wSx11ZmQeao9bghuF8h3XjdVfC8
 Rrve+tcAJlETOAg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The driver name should be passed directly.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index bceda71517c8180dff76db311aa3591ab9846156..93416f3bd7fbb0a75bef17949725d0d40b9b93ea 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -20,8 +20,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AL3320A_DRV_NAME "al3320a"
-
 #define AL3320A_REG_CONFIG		0x00
 #define AL3320A_REG_STATUS		0x01
 #define AL3320A_REG_INT			0x02
@@ -202,7 +200,7 @@ static int al3320a_probe(struct i2c_client *client)
 	data->client = client;
 
 	indio_dev->info = &al3320a_info;
-	indio_dev->name = AL3320A_DRV_NAME;
+	indio_dev->name = "al3320a";
 	indio_dev->channels = al3320a_channels;
 	indio_dev->num_channels = ARRAY_SIZE(al3320a_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -255,7 +253,7 @@ MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
 
 static struct i2c_driver al3320a_driver = {
 	.driver = {
-		.name = AL3320A_DRV_NAME,
+		.name = "al3320a",
 		.of_match_table = al3320a_of_match,
 		.pm = pm_sleep_ptr(&al3320a_pm_ops),
 		.acpi_match_table = al3320a_acpi_match,

-- 
2.49.0



