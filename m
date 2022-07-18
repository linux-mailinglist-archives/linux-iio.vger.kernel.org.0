Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19CE578AFF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGRTfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiGRTfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:35:47 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19532B618
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description; bh=SIdmNXSfa6gB1XOb6gIhIL7va5y5vCKiNOUlJzW7zdw=; b=f1uh
        lzbLDJ5jefEBCcwuMxDUAFssJaDIUoT+Q0Hk85uCxg7w4pCi7hpH3sSvdZjZkoj2NxDYo4VM9CLuR
        PzmjzNdp1zGtR2NJGYQ8UujQpbHTzOYzRF6sAm4IrC8gnJKpAQNaB1U/twxOfAhCaqk5HfLx9yLXw
        04DAv2k/E0mVZEn29RFw9G79g9Nz6cWcZIGuIWfRolQh0w3gIl5L7B1gk1cDiHa3bhlPJqemvSr+Z
        ppucje5cra6LRP05psfK2kXskwM7cbdPnviR6q24BKh8Sv52ECA2UWHuVGox8ABann+85+j+34yzo
        e7g9VTDwsI5hP/CE21SHfKeHoSWWYA==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWWl-0000Mv-Ci; Mon, 18 Jul 2022 19:35:35 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH 3/3] iio: humidity: dht11: Use dev_err_probe consistently
Date:   Mon, 18 Jul 2022 21:35:20 +0200
Message-Id: <20220718193520.177648-3-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718193520.177648-1-ukleinek@debian.org>
References: <20220718193520.177648-1-ukleinek@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; h=from:subject; bh=8MEuuuYyCvXkoLOgdvdLyh2YrA5uX+fNsTrKnKSRfQ8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1bX1LKtCdzeNG0jbekRNfLbZNmePYf0n058tZaS0 h+Vl0vyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW19QAKCRDB/BR4rcrsCTTeCA CGl/aGW6txY+q7/GleY6NliWzQF3NOe9NApiLI52tyqNEmqLK1CHoUmX+YmFFx/iyIpTT8VLAmqCbK SwIWXl+81Rd4Xy5mzgvPWPTxAiYhvagVOqquPtOCE1hHRl68vJzX+1RKTdbFPr6SVnDq3X4KLTeHv2 BqpbfvpvLi3UfDRSStndmrPK/BD6rjhzPsWVAIge+pID0iBklCp8r0nwg3a/bzpKKShN0EIyD50fuH Q3I5bLLBiVMgB7FFkP6i+FmHTte19jiOJ/ojaKZZ/LIjUYhhSFB1I79m1i8C2QdPhkWT8nAIbSEEFA bn1XXEj8KkcLhHZ/OyP/6SMsUDXr/J
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All but one error path use dev_err_probe() to emit a message. Use the same
incarnation for the remaining exit point for consistency.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/iio/humidity/dht11.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 6182f4d2e9fc..50d2431c938b 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -306,10 +306,9 @@ static int dht11_probe(struct platform_device *pdev)
 				     "Failed to aquire GPIO\n");
 
 	dht11->irq = gpiod_to_irq(dht11->gpiod);
-	if (dht11->irq < 0) {
-		dev_err(dev, "GPIO %d has no interrupt\n", desc_to_gpio(dht11->gpiod));
-		return -EINVAL;
-	}
+	if (dht11->irq < 0)
+		return dev_err_probe(dev, -EINVAL, "GPIO %d has no interrupt\n",
+				     desc_to_gpio(dht11->gpiod));
 
 	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
-- 
2.36.1

