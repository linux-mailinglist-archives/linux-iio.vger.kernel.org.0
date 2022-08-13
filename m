Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA88591BC4
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbiHMPzm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiHMPzg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:55:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB936258
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FC6EB80688
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5955C433C1;
        Sat, 13 Aug 2022 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406133;
        bh=sp0/VOxQRc3vRBy712TSgQNXiq5obz5F/8PSICdwGvY=;
        h=From:To:Cc:Subject:Date:From;
        b=DR99dxtthGDdHA3uuMv8eLdA8NPFmgwidcO7WsqJCmTGnZNou9YGJn/EaJQey7TX/
         fqivzYWe99eET+myzBIWbGL3QjD55ywb67YoZ5ON3TIi8W2XtzxztosbRPdD0zzUW4
         3eK/oYRD3HfzaExkmwL33nxcdcjU4HVqa+DR1vmp6l2TRg3rw/8d6XbAe4y9KJ0dqz
         77ejNZDSKo/JN2m9CGGsAK2NPw+xh9mnCh2+tAyGjr2rr3nE9DnRCpGSY9yT2i1VQL
         +EG9AG/NRsXNK6WmVAI2Ew8aAjrXYUPgC9twb3C1URVBoIhWFC+azfcQ0S/U3MewNr
         IcKW+XE+MTHAw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] staging: iio: frequency: ad9832: Fix alignment for DMA safety
Date:   Sat, 13 Aug 2022 17:06:00 +0100
Message-Id: <20220813160600.1157169-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
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
IIO_DMA_MINALIGN definition.  Whilst here, move the marking to cover
the whole union. That has not functional affect, but makes it slightly
easier to see what is going on.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Move the alignment marking to the union rather than an element in the
    union. (Andy Shevchenko)
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index f43464db618a..6f9eebd6c7ee 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -112,10 +112,10 @@ struct ad9832_state {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
-		__be16			freq_data[4]____cacheline_aligned;
+		__be16			freq_data[4];
 		__be16			phase_data[2];
 		__be16			data;
-	};
+	} __aligned(IIO_DMA_MINALIGN);
 };
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
-- 
2.37.1

