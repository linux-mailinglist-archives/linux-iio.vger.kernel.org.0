Return-Path: <linux-iio+bounces-18958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084DBAA6AA8
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE9D9A7E6F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECD1E0E13;
	Fri,  2 May 2025 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Pmt7L0uh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE071EB187;
	Fri,  2 May 2025 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166528; cv=none; b=WCGvKcedbjs7g4UHmminKLhBO3too2mte0kb6nzLpyjXZneQ42thpx7dMvqepMb1+7Pdilyw0IEc28UmHmggtQYYgOnk48GcHk6rZBuf+YPwl2MS0eGmNCmWbxgSEE4I7J/+o0STNdxJEJdxbCfZR3kyhDM7Cfxf3L+S/+rhR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166528; c=relaxed/simple;
	bh=9RqD1rtDZ3nx/5xl4S8rNG4umy0IwWzfFpWHE+myW3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZpQacDF8TtI8pZM2NGjTUVHkpxSY1gPUw/KhLKySK+MhXG+UajAqC1RSMZ9TeeJYuCU8TIzxAWrfQNKUmHNvnKDfSWuPrWP5uHjTROQWLsTZ3kIyZbOM2skFBkEuN8ERxD9tXq8LdBg4hTmc/xDAfmKPCa5d+UmdbGXURGAKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Pmt7L0uh; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746166517; x=1746425717;
	bh=avL9fBB6weC8oCLy3XgV5GE6YeyH90JKq36fRo/ChEo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Pmt7L0uh10dXvyxFAI/Haz410R6/M2PTAG2jrlPvB5tHIP3Y0oVg4P7NU6/3ZXk2E
	 0Qq4xSyLmWmnc6fB2W528bU2u8zJ4nSTTBkUzkTNw5i2+8eyQF7XI4ERgWPwoc5TBZ
	 MFochqFYA3UOvDLqE0NnlnFCjt7BKSYlflHvEIgVDESfuuwXR1vuWifzLxQtgVwQ80
	 oyVIagjc81Pi0RNbTBqIiPuJt+JAZLAwOdufgf8R6gNReX2ZRSr4t2Jci4m2MdkCwL
	 CTrCvgDO9zbfEHXoMOQ6bBpnRXvGi0WU4SQCtaVky6gT8c48ngQVtTx+6nU/61Ku5l
	 pdoq8h6ocMqXw==
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 02 May 2025 08:15:07 +0200
Subject: [PATCH v2 2/2] iio: accel: fxls8962af: Fix sign temperature scan
 element
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-fxls-v2-2-e1af65f1aa6c@geanix.com>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
In-Reply-To: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

TEMP_OUT register contains the 8-bit, 2's complement temperature value.
Let's mark the temperature scan element signed.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index f515222e008493687921879a0b0ef44fd4ae5d10..e1b752e202b877db606a55a978d63ef52894c60d 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -750,6 +750,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
+		.sign = 's', \
 		.realbits = 8, \
 		.storagebits = 8, \
 	}, \

-- 
2.47.1


