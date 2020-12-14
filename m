Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17512D98DE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393689AbgLNNdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 08:33:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9173 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbgLNNcp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 08:32:45 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cvj2m1nnzz15f6d;
        Mon, 14 Dec 2020 21:31:12 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:31:41 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jikos@kernel.org>, <jic23@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>,
        <benjamin.tissoires@redhat.com>
CC:     <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] hid/hid-sensor-custom: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:32:12 +0800
Message-ID: <20201214133212.3569-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 4d25577a8573..6c47a2e7623d 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -728,7 +728,7 @@ static int hid_sensor_custom_dev_if_add(struct hid_sensor_custom *sensor_inst)
 
 	sensor_inst->custom_dev.minor = MISC_DYNAMIC_MINOR;
 	sensor_inst->custom_dev.name = dev_name(&sensor_inst->pdev->dev);
-	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops,
+	sensor_inst->custom_dev.fops = &hid_sensor_custom_fops;
 	ret = misc_register(&sensor_inst->custom_dev);
 	if (ret) {
 		kfifo_free(&sensor_inst->data_fifo);
-- 
2.22.0

