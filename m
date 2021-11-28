Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06D3460808
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346629AbhK1R1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358656AbhK1RZN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:25:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B20C06175B
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 09:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2324660F5D
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFA0C53FC7;
        Sun, 28 Nov 2021 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120014;
        bh=evYm1iKAaGb58pnaoCcX6AjBdF5XxIXimhJCJ+hLYCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRpR27jlHAFiDeNK2XbmZd2Ffwjbxe5dGPNailmoKh2mzjf+nfaPgAporPoDv4+X8
         XGGixPSpJe1ErvvbAZyL24gCC254rwr4yAYWEINnGrwusuZF0sFUY9vH4yFpVulKK5
         5uL+Lywq0e1kZaW88aaSVzQ34yR5QPragb+a0C2Qc0bZq/scFujaUFEIg15+SELJVs
         B13kflIQZb35zZQo3WkvMi6uBjzsxhfrg8FdnrHkmC7LrLWnw4cH6ko9RrgQj9Bh7x
         ppLC+slyrHR70sTbOkZAMptp5f/BM1tn4+2GEDPgjjhNo3JPHVdsbsgMjFTRo1LKFJ
         bg3fNNDQ2f6xQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/12] iio:dummy: Drop set but unused variable len.
Date:   Sun, 28 Nov 2021 17:24:43 +0000
Message-Id: <20211128172445.2616166-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not sure what the thinking was here, as lost to history, but the
variable is clearly not used so get rid of it.

Warning seen with clang W=1 tests (may be present with other compilers
and build options).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 59aa60d4ca37..d81c2b2dad82 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -45,7 +45,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	int len = 0;
 	u16 *data;
 
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
@@ -79,7 +78,6 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 					  indio_dev->masklength, j);
 			/* random access read from the 'device' */
 			data[i] = fakedata[j];
-			len += 2;
 		}
 	}
 
-- 
2.34.1

