Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D488B327908
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 09:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhCAIRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 03:17:23 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:30190 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232764AbhCAIRX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Mar 2021 03:17:23 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app3 (Coremail) with SMTP id cC_KCgBnbyfWojxg8PvgAQ--.63815S4;
        Mon, 01 Mar 2021 16:16:25 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Fix error handling in vadc_do_conversion
Date:   Mon,  1 Mar 2021 16:16:22 +0800
Message-Id: <20210301081622.15696-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnbyfWojxg8PvgAQ--.63815S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy5ArWDJFWrWw4rWw4UJwb_yoWfGFgEkw
        n2qw18GasayrWDAF1UGr4xXr90kF90qrn3WF1v9FyfGa43CFykCF1qvr4UAF17Ca18XF13
        urs8G34rtF93CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcLBlZdtSjMQAADsR
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is one vadc_poll_wait_eoc() call in vadc_do_conversion
that we have caught its return value but lack further handling.
Check and jump to err_disable label just like the other
vadc_poll_wait_eoc() in this function.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 05ff948372b3..fe36b0ba8273 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -324,6 +324,8 @@ static int vadc_do_conversion(struct vadc_priv *vadc,
 
 	if (vadc->poll_eoc) {
 		ret = vadc_poll_wait_eoc(vadc, timeout);
+		if (ret)
+			goto err_disable;
 	} else {
 		ret = wait_for_completion_timeout(&vadc->complete, timeout);
 		if (!ret) {
-- 
2.17.1

