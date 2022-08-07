Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645C58BB7E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiHGPCK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiHGPCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 11:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0846263
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 08:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D9460F67
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 15:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915DC433C1;
        Sun,  7 Aug 2022 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659884526;
        bh=mtfiBmCMLT5hsnF7pu5nJeA4tweQ5srfRQmvOfHKkJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooB/MCY4EaLcq9DrOjxFpaSwPGniLjhPTGk6lHAXwQnGJXzcr77x8TXCjSnsTZKUd
         jtSaIJ2HwgsCOWPHQPF9nhAAKxrfj6Xjpwt07qU1rrUzdkKmQ6CB5TcKBwmD1o3VBo
         OIMiWBh3e83+4ge7ixEEeZtOiC/Olxv9Og+VzkFnJn6nV41sIbrUj6RzifmxFw6J3D
         KGIfAzADR5z3+mvd1I14FYMsfoJihC9cCKtaaPpmZXHkGFss1YIxYUGctqU0kUXEr5
         nsdX/WTmX4iC4b0syHBfwdu8chCg96FJI8l2ABxfaLdCn93AHuGCzJMG3130cRorX/
         zTsyCFrD6pBDQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/4] staging: iio: frequency: ad9832: Fix alignment for DMA safety
Date:   Sun,  7 Aug 2022 16:12:15 +0100
Message-Id: <20220807151218.656881-2-jic23@kernel.org>
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
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index f43464db618a..ce9fcba6bc5c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -112,7 +112,7 @@ struct ad9832_state {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
-		__be16			freq_data[4]____cacheline_aligned;
+		__be16			freq_data[4] __aligned(IIO_DMA_MINALIGN);
 		__be16			phase_data[2];
 		__be16			data;
 	};
-- 
2.37.1

