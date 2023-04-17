Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94C6E3DA4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Apr 2023 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDQCwn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Apr 2023 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDQCw0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Apr 2023 22:52:26 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525963580;
        Sun, 16 Apr 2023 19:52:22 -0700 (PDT)
Received: from ubuntu.localdomain ([10.12.172.250])
        (user=jkluo@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33H2ncBq006394-33H2ncBr006394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 17 Apr 2023 10:49:43 +0800
From:   Jiakai Luo <jkluo@hust.edu.cn>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Jiakai Luo <jkluo@hust.edu.cn>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: mxs-lradc: fix the order of two cleanup operations
Date:   Sun, 16 Apr 2023 19:47:45 -0700
Message-Id: <20230417024745.59614-1-jkluo@hust.edu.cn>
X-Mailer: git-send-email 2.17.1
X-FEAS-AUTH-USER: jkluo@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Smatch reports:
drivers/iio/adc/mxs-lradc-adc.c:766 mxs_lradc_adc_probe() warn:
missing unwind goto?

the order of three init operation:
1.mxs_lradc_adc_trigger_init
2.iio_triggered_buffer_setup
3.mxs_lradc_adc_hw_init

thus, the order of three cleanup operation should be:
1.mxs_lradc_adc_hw_stop
2.iio_triggered_buffer_cleanup
3.mxs_lradc_adc_trigger_remove

we exchange the order of two cleanup operations,
introducing the following differences:
1.if mxs_lradc_adc_trigger_init fails, returns directly;
2.if trigger_init succeeds but iio_triggered_buffer_setup fails,
goto err_trig and remove the trigger.

In addition, we also reorder the unwind that goes on in the
remove() callback to match the new ordering.

Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
Signed-off-by: Jiakai Luo <jkluo@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis and remains untested.
---
 drivers/iio/adc/mxs-lradc-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index bca79a93cbe4..85882509b7d9 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -757,13 +757,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_adc_trigger_init(iio);
 	if (ret)
-		goto err_trig;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
 					 &mxs_lradc_adc_trigger_handler,
 					 &mxs_lradc_adc_buffer_ops);
 	if (ret)
-		return ret;
+		goto err_trig;
 
 	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
 
@@ -801,9 +801,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 err_dev:
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
-err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_trig:
+	mxs_lradc_adc_trigger_remove(iio);
 	return ret;
 }
 
@@ -814,8 +814,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(iio);
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
 	iio_triggered_buffer_cleanup(iio);
+	mxs_lradc_adc_trigger_remove(iio);

 	return 0;
 }
-- 
2.17.1

