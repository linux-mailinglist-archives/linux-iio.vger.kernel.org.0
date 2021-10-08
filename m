Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3335C4264BD
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJHGkD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 02:40:03 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:49866 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229693AbhJHGkC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 02:40:02 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 02:40:02 EDT
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowAD32O1P5V9hnsjUAg--.39531S2;
        Fri, 08 Oct 2021 14:29:35 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     jbhayana@google.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] iio/scmi: check if dev is null pointer
Date:   Fri,  8 Oct 2021 06:29:33 +0000
Message-Id: <1633674573-81211-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowAD32O1P5V9hnsjUAg--.39531S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy5try5Ary3uF1DCFykZrb_yoWftFc_Aw
        12qFn3Gr18CFs5ZrnrGrWfXrnxKa4vvFW8Wr1rK3yS9343XFsFqF4DJrW8Ar4xXryUAry3
        Wws3tr1vya13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8xR6UUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The parameter 'dev' of scmi_iio_dev_probe() isn't been
checked before used, including when scmi_iio_dev_probe() is called.
Therefore, it might be better to check, just in case.

Fixes: 25cbdd4 ("iio/scmi: Port driver to the new scmi_sensor_proto_ops interface")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 141e8aa..d3ff985 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -592,6 +592,9 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 
 	if (!handle)
 		return -ENODEV;
+
+	if (!dev)
+		return -ENODEV;
 
 	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
 	if (IS_ERR(sensor_ops)) {
-- 
2.7.4

