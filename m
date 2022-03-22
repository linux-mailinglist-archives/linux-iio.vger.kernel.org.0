Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9C4E3D56
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 12:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiCVLSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiCVLSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 07:18:02 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A87DAA6
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 04:16:34 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5CF538141D;
        Tue, 22 Mar 2022 12:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647947792;
        bh=qi+/Id1O9WcCHafUwUqZWmjbiOukQxT+uoj5WPdiHTM=;
        h=From:To:Cc:Subject:Date:From;
        b=KfQ4xsPRUO0/AXwqFuHnBXik48/H2Spu9gAnrdpx2IXd6sG8/PHR63sNC5k1wGNfx
         4lSxpjfNqNGVLwKhClTtw4y5ie5VbSqbcyLC/eZuTvRIuFNx8PdCvsWSaHmbzoHLVH
         Mj1Vt92ht1hyiX6Q/4t9pne8gSco17kYXZlpCbXGkiV5CqaYNb8hd499Ej7JiqyYpq
         7unmmoBbH+0fyTxfm5k7/48RoLeeebAMRRjEFm6mXAdW958ht/CSd+jEGU0uKEsFzO
         mRoGYhbyzbfCI4VBavjwDqL3nppWxOl4uY2sR2JhivPigRzSL/NgR6OnMyMxRBzsTx
         DnmtprUuqwtpA==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] iio: core: Print error in case sample bits do not fit storage bits
Date:   Tue, 22 Mar 2022 12:16:19 +0100
Message-Id: <20220322111619.54808-1-marex@denx.de>
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
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V2: Use dev_err() instead as WARN_ON() may panic() the kernel on existing machines
---
 drivers/iio/industrialio-buffer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9de..b5670398b06d7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1629,6 +1629,18 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 			if (channels[i].scan_index < 0)
 				continue;
 
+			/* Verify that sample bits fit into storage */
+			if (channels[i].scan_type.storagebits <
+			    channels[i].scan_type.realbits +
+			    channels[i].scan_type.shift) {
+				dev_err(&indio_dev->dev,
+					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
+					i, channels[i].scan_type.storagebits,
+					channels[i].scan_type.realbits,
+					channels[i].scan_type.shift);
+				continue;
+			}
+
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
 							 &channels[i]);
 			if (ret < 0)
-- 
2.35.1

