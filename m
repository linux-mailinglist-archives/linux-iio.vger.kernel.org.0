Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934384EA0D0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbiC1Tzj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbiC1Tzd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:55:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F56577
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 12:53:24 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 789A983F6B;
        Mon, 28 Mar 2022 21:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648497202;
        bh=4j7H9ZurGatxwQ0nWhJkDOfGZq5s0wM0qNocGPG4lSg=;
        h=From:To:Cc:Subject:Date:From;
        b=m4MYmbGKipQ3ap5/nqV+e9uixtpaGG108EMGUZ2DP82wFEuCQreKFH5j6vxjkgbs1
         Hf5k++Tsg9eRTZ6EJU+Y6kwuD3iz6ssCHv3OUTQ1NKJcAMoPR7wKM1PWt9NjwFcP8F
         eWU6SA95xbT/9nn2IuO3gnYsCqp6KNtlCiyAeKDGkouCefKIp2w3NGtUNAv5Kahzeq
         RrC5UCeHcsYtF9tdASEPoAaJlrUJVHqxChB5Jh6Al1FZJ2FvhQCKx1763zhEHs44i1
         nbUVWKmaV9HMtL53Vei2DKfGaaYXCmCZITF1kl6eQPbWgmF++AizdY3qIUUVKTSHmt
         R7QaqsfH1EFgQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] iio: core: Print error in case sample bits do not fit storage bits
Date:   Mon, 28 Mar 2022 21:53:07 +0200
Message-Id: <20220328195307.154422-1-marex@denx.de>
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
V3: Abort probe and return -EINVAL in case this condition is triggered
---
 drivers/iio/industrialio-buffer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b078eb2f3c9de..75a1c57b49102 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1629,6 +1629,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
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
+				ret = -EINVAL;
+				goto error_cleanup_dynamic;
+			}
+
 			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
 							 &channels[i]);
 			if (ret < 0)
-- 
2.35.1

