Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F691633237
	for <lists+linux-iio@lfdr.de>; Tue, 22 Nov 2022 02:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKVBfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Nov 2022 20:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiKVBfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2022 20:35:42 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D5B7384
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 17:35:41 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGRfL72jYz8QrkZ
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2022 09:35:38 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NGRfJ2lNbz4y0ty;
        Tue, 22 Nov 2022 09:35:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AM1ZW5d024536;
        Tue, 22 Nov 2022 09:35:32 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 22 Nov 2022 09:35:33 +0800 (CST)
Date:   Tue, 22 Nov 2022 09:35:33 +0800 (CST)
X-Zmail-TransId: 2afa637c27656d5f05f4
X-Mailer: Zmail v1.0
Message-ID: <202211220935338446115@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lars@metafoo.de>
Cc:     <michael.hennerich@analog.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AM1ZW5d024536
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 637C276A.000 by FangMail milter!
X-FangMail-Envelope: 1669080938/4NGRfL72jYz8QrkZ/637C276A.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C276A.000/4NGRfL72jYz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iio/adc/ad7606_par.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index b912b4df9b56..d8408052262e 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -57,8 +57,7 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(&pdev->dev, res);
+	addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);

-- 
2.25.1
