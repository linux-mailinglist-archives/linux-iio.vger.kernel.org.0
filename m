Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15261744C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Nov 2022 03:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKCCfS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Nov 2022 22:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKCCfR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2022 22:35:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912812A95;
        Wed,  2 Nov 2022 19:35:16 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2nsp6xqBz15MD8;
        Thu,  3 Nov 2022 10:35:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 10:35:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 10:35:14 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <Jonathan.Cameron@huawei.com>,
        <corbet@lwn.net>, <yangyingliang@huawei.com>
Subject: [PATCH RESEND] Documentation: devres: add missing IIO helpers
Date:   Thu, 3 Nov 2022 10:34:02 +0800
Message-ID: <20221103023402.1024437-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some missing device-managed helpers of iio to devres.rst.

devm_iio_kfifo_buffer_setup_ext() is introduced by commit 0a21526bc1d4 ("iio:
kfifo: add devm_iio_triggered_buffer_setup_ext variant").

devm_iio_triggered_buffer_setup_ext() is introduced by commit 5164c7889857 ("iio:
triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants").

devm_iio_hw_consumer_alloc() is introduced by b688c18d3006 ("IIO: hw_consumer:
add devm_iio_hw_consumer_alloc").

devm_fwnode_iio_channel_get_by_name() is introduced by commit 1e64b9c5f9a0 ("iio:
inkern: move to fwnode properties").

Fixes: 0a21526bc1d4 ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
Fixes: 5164c7889857 ("iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants")
Fixes: b688c18d3006 ("IIO: hw_consumer: add devm_iio_hw_consumer_alloc")
Fixes: 1e64b9c5f9a0 ("iio: inkern: move to fwnode properties")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
The previous patch link:
https://patchwork.kernel.org/project/linux-iio/patch/20220927074043.942836-1-yangyingliang@huawei.com/
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0cb7df0f782..4249eb4239e0 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -287,12 +287,16 @@ IIO
   devm_iio_device_register()
   devm_iio_dmaengine_buffer_setup()
   devm_iio_kfifo_buffer_setup()
+  devm_iio_kfifo_buffer_setup_ext()
   devm_iio_map_array_register()
   devm_iio_triggered_buffer_setup()
+  devm_iio_triggered_buffer_setup_ext()
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
   devm_iio_channel_get()
   devm_iio_channel_get_all()
+  devm_iio_hw_consumer_alloc()
+  devm_fwnode_iio_channel_get_by_name()
 
 INPUT
   devm_input_allocate_device()
-- 
2.25.1

