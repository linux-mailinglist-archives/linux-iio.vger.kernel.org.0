Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67076578AFE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiGRTfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiGRTfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:35:46 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020E2AE2A
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=zmjiiwp77EjOxJJTiAnpabvPiLF7EFe4D+cXiCK0FMM=; b=G0
        1B7y669jScL6xX0w/UYUgpDn2SuzstOreU9ArTm/VdWgGHCTnaeQ8qEdqNuJ/ZoXlx3Xzn1HkN+xm
        0Qt+JplnBP60vWF5OVRDNO48884iG9onJ+Cosm4vTDLRdY2N/Pu6VIvPh+f8iPnE+gEJ/jaJ1zjT0
        zxewUd20QzCyzaiSSZuyAnegtEUi4Zfa/fm/1CP9EJQ2V3oaQzWdM+5k2srOCyb/lxz3setKG9DYj
        dKSQv+aOWR5tIkgT2BOcLEZPVdTd3+wNR3tjDlfNFB8Iu5UDcreOjdoT0I7/pYGlOss+e+2BHyS+N
        dnGZ8ZJKxb1yeR8pe9Cyuu05GshWp5HA==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWWh-0000MB-TT; Mon, 18 Jul 2022 19:35:31 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH 1/3] iio: humidity: dht11: Don't warn on memory allocation failure
Date:   Mon, 18 Jul 2022 21:35:18 +0200
Message-Id: <20220718193520.177648-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; h=from:subject; bh=PgKOtVW9OSAs7yt0TmACBSMHRS7gc90s1dz7cKYwN1M=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1bXtce0asY7TqRzBxlR1FFtlR8nBBq3auet1M20S gr/GqhGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW17QAKCRDB/BR4rcrsCVTLCA CQNmOm2fneswMKtccOb3JRldvjWvmB/GWZVQar6CdhxC5+oVxKvJesjsCM9WPut9UVDvWU9L7cxyRY p+WMsM6ypvpnXQaB8ORCyYv7aLlyXLlpvC1EyXKzyCjctmGlbgZ6dLkzPJAouTiYAjhHrcQtzvInbu Ei0koXNHtfqEUEmkx/27g0Euw8a8tT5N4whEmcSuyXhit85X7V0D8GtATb0DPvtxQMzbH3RMrEneGb NzulP2RjQjiOy54jjFxqe73cXtHMdiFvXkKmR5CrSoPTXHhfve1nxIZjztTrI7NVGCvNWbsVRKlfd1 ze5T78hiOApGYxYO1yMwGrcxiLdFJl
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

The kernel is already quite noisy if a memory allocation fails. So it's
the usual policy to not add another message on the driver level.

Drop the error message accordingly.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/iio/humidity/dht11.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c97e25448772..891b6bf0b4ca 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -295,10 +295,8 @@ static int dht11_probe(struct platform_device *pdev)
 	struct iio_dev *iio;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
-	if (!iio) {
-		dev_err(dev, "Failed to allocate IIO device\n");
+	if (!iio)
 		return -ENOMEM;
-	}
 
 	dht11 = iio_priv(iio);
 	dht11->dev = dev;

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

