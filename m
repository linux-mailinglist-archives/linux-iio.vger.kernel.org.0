Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3484248148A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Dec 2021 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhL2Po5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 10:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbhL2Po4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 10:44:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D710C06173F
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 07:44:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qJ-8c; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-007KGk-OG; Wed, 29 Dec 2021 16:44:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8C-00011t-EV; Wed, 29 Dec 2021 16:44:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v3 02/23] counter: ftm-quaddec: Drop unused platform_set_drvdata()
Date:   Wed, 29 Dec 2021 16:44:20 +0100
Message-Id: <20211229154441.38045-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; h=from:subject; bh=/yCYOFOf35wKxs8wO4zen2WYVkqvjzWqLvrPX8un9iM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIUyKXjcXkcfU1V9GBs9o3gWt2oo6Gori/QX5tI N898cNmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCFAAKCRDB/BR4rcrsCQ1kCA CArJG2MQRSte6giZnJdGCXopxwdzAN1HF1hAFA8HMD8kQbMb7L4Z8ipOEiA6aw24lsOWns8YLCIXXw ADV9/Wbsc3beEmv9gHXR+MAnycpHGnRlwh2vRYTHw7I4BTgJQy7CTsTCCaOAwFnoT+siKMwjM3iGzU NITTdEdSSjMyO1Y1v3Qdl7cu1n3r2jiG1SqwyCKYKZNg2LmoImqBUEgzs1DtiXizIFs2Oy34gKeqPc JWywS230K9rD6eL3SvoKqEs1WXDsCGa+UfbCcSYC/P9lvC+tYXKwjyYvHxVRy1zmVcQlJ0DVRxtly+ zkitvtNuT5PrQm8X1Lonf+kznApRkG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver doesn't ever use platform_get_drvdata, so drop this unused
call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 5ef0478709cd..9272f7b58beb 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -269,8 +269,6 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	if (!ftm)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, ftm);
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
-- 
2.34.1

