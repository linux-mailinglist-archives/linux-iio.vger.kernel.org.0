Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3FE35621A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 05:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348438AbhDGDty (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 23:49:54 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:22768 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348435AbhDGDtx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 23:49:53 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app2 (Coremail) with SMTP id by_KCgD3vmzHK21gGWbRAA--.21899S4;
        Wed, 07 Apr 2021 11:49:31 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
Date:   Wed,  7 Apr 2021 11:49:27 +0800
Message-Id: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgD3vmzHK21gGWbRAA--.21899S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWxGw45XF4UZF45Zw45Awb_yoWkJFX_Cr
        1j93ZrJr45AFnaga47tw15ZryY9Fy2qa18Wr1rtFnxG34Uu393CrZ8XrZxAay5Wr4aqF1D
        X3yqgFn29w4fGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoGBlZdtTQGhAAJsJ
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When devm_request_threaded_irq() fails, we should decrease the
runtime PM counter to keep the counter balanced. But when
iio_device_register() fails, we need not to decrease it because
we have already decreased it before.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/iio/light/gp2ap002.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 7ba7aa59437c..040d8429a6e0 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -583,7 +583,7 @@ static int gp2ap002_probe(struct i2c_client *client,
 					"gp2ap002", indio_dev);
 	if (ret) {
 		dev_err(dev, "unable to request IRQ\n");
-		goto out_disable_vio;
+		goto out_put_pm;
 	}
 	gp2ap002->irq = client->irq;
 
@@ -613,8 +613,9 @@ static int gp2ap002_probe(struct i2c_client *client,
 
 	return 0;
 
-out_disable_pm:
+out_put_pm:
 	pm_runtime_put_noidle(dev);
+out_disable_pm:
 	pm_runtime_disable(dev);
 out_disable_vio:
 	regulator_disable(gp2ap002->vio);
-- 
2.17.1

