Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E258BB80
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiHGPCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHGPCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:02:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C96261
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CAABB80CC7
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 15:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8EDC433D7;
        Sun,  7 Aug 2022 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659884530;
        bh=PFoyiJf5SuRaVq5+C1txhCA7YyWswLSlz/r+vGYOoTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSy8gJ1dwwwov6lpg3jojEl5Y+MO6Da+nvyydpSxhAatU/qeSf5aoxIWMKlpzK6Ld
         /yOskJ9jgAeI7/k0Hl8dEG+XrYXQDzvv6vdWXurX+HBCe0rlum+M8JT70ekdG6JjGa
         5rYYfqflUoXNaRWalWLk0YoB81cT/HD6cTtZGT7Fan2/IGvXIzYbMIjolDLoCsLgIF
         Se3Onw93iMu2Zifn5HCCbyeBBKE3ZMpKLCV5zs+2KwlPZJAcUK188TZGKHQa158zeH
         bGyfo0ArxviASGte3CDoh5wPkZkgDqPupu1E0wBO9f1W+eHYfYB7XdhwkXqDBb+Ipg
         WcEcA0+H56XSA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: [PATCH 3/4] staging: iio: meter: ade7854: Fix alignment for DMA safety
Date:   Sun,  7 Aug 2022 16:12:17 +0100
Message-Id: <20220807151218.656881-4-jic23@kernel.org>
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
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a51e6e3183d3..7a49f8f1016f 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -162,7 +162,7 @@ struct ade7854_state {
 			 int bits);
 	int irq;
 	struct mutex buf_lock;
-	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8 tx[ADE7854_MAX_TX] __aligned(IIO_DMA_MINALIGN);
 	u8 rx[ADE7854_MAX_RX];
 
 };
-- 
2.37.1

