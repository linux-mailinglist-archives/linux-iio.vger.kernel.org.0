Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639A235B9D8
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhDLFcr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 01:32:47 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:34686 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhDLFcq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 01:32:46 -0400
Received: from localhost.localdomain (unknown [10.192.139.175])
        by mail-app4 (Coremail) with SMTP id cS_KCgB3KURV23Ngj++1AA--.9781S4;
        Mon, 12 Apr 2021 13:32:10 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] iio: proximity: pulsedlight: Fix rumtime PM imbalance on error
Date:   Mon, 12 Apr 2021 13:32:02 +0800
Message-Id: <20210412053204.4889-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgB3KURV23Ngj++1AA--.9781S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWDuF4rZFWDtr1fAry7Jrb_yoWDXwc_Cr
        nrtry0qr17C3y2kwsrA3WFqrWFkr90qF98Xr1ktF13Cryayr9a9ryktrZ8Aw45Xr48GryY
        gF4xK3Z7Ar4IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUKBlZdtTUxDAAQst
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When lidar_write_control() fails, a pairing PM usage counter
decrement is needed to keep the counter balanced.

Fixes: 4ac4e086fd8c5 ("iio: pulsedlight-lidar-lite: add runtime PM")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Add the fix tag.
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index c685f10b5ae4..cc206bfa09c7 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -160,6 +160,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
 	if (ret < 0) {
 		dev_err(&client->dev, "cannot send start measurement command");
+		pm_runtime_put_noidle(&client->dev);
 		return ret;
 	}
 
-- 
2.17.1

