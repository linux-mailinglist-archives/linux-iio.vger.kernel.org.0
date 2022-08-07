Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E342B58BB7F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiHGPCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHGPCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:02:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB046261
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79CBCB80B88
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 15:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B96C433D6;
        Sun,  7 Aug 2022 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659884528;
        bh=jczaYgwshWH1gPBR59OPG7NoLtPIIA1Ja3a29qnXd7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tbgl6x4h1AuJLkphGzKa7riabPJPI5FOUNKkfEsAe2n7hMaStjSg7uuubg2X204nr
         1TVwvryJzkYoqJn4nc8hLv9uZT5xQ0mL/Uqvo05PEQF+OHi177y8ORVTLdEWN9m6Kl
         A6d5dxVc4b0PwKQPOMeOQ78eOhIyNzZdFSKCApnfiQbZ2cm3QXt7T40NyfSRbhBp3E
         /nvfdjKldEhVhPjzqESV/X4rg1/habWJiPvPqUt1KiiRW0rdfGoR81mOZp+X5W+ImR
         GFHh1ku7z1VgOL5yEVOKVhLWja/08GFpOjxLjqvH96T00Q+2deSc4pb9bcJ4lnQ93p
         p8ZmbRovslL5w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/4] staging: iio: frequency: ad9834: Fix alignment for DMA safety
Date:   Sun,  7 Aug 2022 16:12:16 +0100
Message-Id: <20220807151218.656881-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807151218.656881-1-jic23@kernel.org>
References: <20220807151218.656881-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

____cacheline_aligned is an insufficient guarantee for non-coherent DMA
on platforms with 128 byte cachelines above L1.  Switch to the updated
IIO_DMA_MINALIGN definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 94b131ef8a22..2b4267a87e65 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -83,7 +83,7 @@ struct ad9834_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	__be16				data ____cacheline_aligned;
+	__be16				data __aligned(IIO_DMA_MINALIGN);
 	__be16				freq_data[2];
 };
 
-- 
2.37.1

