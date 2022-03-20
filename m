Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35724E1D63
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbiCTSRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbiCTSRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 14:17:19 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9365B527EC
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 11:15:56 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0AF2083960;
        Sun, 20 Mar 2022 19:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647800155;
        bh=kVdlgcIVmnYpCw9T36voIN7Cjph/7S3dZW+KCQgrHrY=;
        h=From:To:Cc:Subject:Date:From;
        b=WXmHunU+IXaKIcHrANPX7tzs6M9hAQuLeLUxwRQk+Qp4SCY5iNobMFg4RdIU2H1Fz
         0qAx4YAFoBXuoZ0CCNsLKKE3HbpB4jFxddn+Z93GmuM4cXOoxX5JEF1vlXB2v4mSNy
         V5X5qq0UNs/4Y4Dmh+EAXkqTwkWagaJN5Oe7Ue1N75ry5Beua6vTCjwso1Ar+y6yKV
         N0MJVQ9gCdI2n4ldHuJtx0qNlfPh0IMkFn9O1QEvVJmRw0sRV6Pr4SIiizu4HE4Gap
         UTWFlJgpKqvTQnkNb2+yQlO7U+oV1K6XFFh9BdExqfnvRsvR8abiNnO0RdiGN24PhF
         QVxJpt8AAe07A==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: core: WARN in case sample bits do not fit storage bits
Date:   Sun, 20 Mar 2022 19:15:42 +0100
Message-Id: <20220320181542.168147-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add runtime check to verify whether storagebits are at least as big
as shifted realbits. This should help spot broken drivers which may
set realbits + shift above storagebits.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9de..bac1e994e7bef 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1629,6 +1629,11 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 			if (channels[i].scan_index < 0)
 				continue;
 
+			/* Verify that sample bits fit into storage */
+			WARN_ON(channels[i].scan_type.storagebits <
+				channels[i].scan_type.realbits +
+				channels[i].scan_type.shift);
+
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
 							 &channels[i]);
 			if (ret < 0)
-- 
2.35.1

