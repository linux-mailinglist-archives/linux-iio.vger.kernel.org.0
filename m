Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF558BB81
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiHGPCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiHGPCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256F6263
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AF960F6C
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 15:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF26CC433C1;
        Sun,  7 Aug 2022 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659884532;
        bh=FP/be31CKfNeC0fXGZqpIrfbAK+dYnAz9pdbY8yUWn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSjliznFdUcN71hp1cABc8XkUHaGuW/MA+GdE6v4LaWmsXa77GAzWKGrrzfILnplg
         1lJ92W3keznuk5rSZDue2QIKYq4oqGOCUl5yjddpi0WmJ0yAqly3DjaxEPOZl7r6of
         Z6EypzL6OYWO6aO/BtMSl5i5/WG8+gftHeSGAxMT/LJh7D82lcQ8SPD/AbvlmcjkUW
         S4kLnUaUPPgoKMZENmyxZ/UJE8WQP3ChGq2p6w4Vdq6YBxoVqezQ+YsciihgMVPyZo
         VMdZGNP9BV52JmJmBn5oR2rPZDMsZi77F47eiRDx39YsW214SG5+6uZBDVh07dA/og
         6aGLZmoGnRErw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4] staging: iio: resolver: ad2s1210: Fix alignment for DMA safety
Date:   Sun,  7 Aug 2022 16:12:18 +0100
Message-Id: <20220807151218.656881-5-jic23@kernel.org>
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
IIO_DMA_MINALIGN definition.  As the tx[] an rx[] buffers are only used
in the same SPI exchanges, we should be safe with them on the same cacheline.
Hence only mark the first one __aligned(IIO_DMA_MINALIGN).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c0b2716d0511..e4cf42438487 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -94,8 +94,8 @@ struct ad2s1210_state {
 	bool hysteresis;
 	u8 resolution;
 	enum ad2s1210_mode mode;
-	u8 rx[2] ____cacheline_aligned;
-	u8 tx[2] ____cacheline_aligned;
+	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
+	u8 tx[2];
 };
 
 static const int ad2s1210_mode_vals[4][2] = {
-- 
2.37.1

