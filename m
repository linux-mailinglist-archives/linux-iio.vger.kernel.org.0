Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D29578B1E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiGRTnJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGRTnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:43:08 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97E3139D
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=xHvbIb7mzME8SgtOJbJqCoWGE1ItiA59/O2Ethkswsg=; b=PF
        qOJwLtqr9LXC2kuF2c+08I6akljtHBvy2ON4OmeZ2aypqhlP/SeJvglrPih4tqi+HhXxqWRvWC0tz
        NAI0JUv7Ou0KQh9BWaUKd0DeXylj4v3J0pkbHca6+pHz5+7i/IxsKGuq3wN+nxVKiUbSwlhGXNEZL
        rqU8mDivfFkgdgzBB20Kq0Qta77mjfeAgqjyFK+0+fqzmKr1CqIPSY9T9ld7SjgvFttj7qFRPZBAW
        7ah1jNm1LmBH9oOcMAZDQt+DAjS8T/60z0Fgd+pAudhNPuntSrBs0A1Yw8R//CSDZHl4IgeKiuAop
        6RYAg5m2le0cFy6AAGZ4nfyuoAsiLi2w==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWdy-0000os-PC; Mon, 18 Jul 2022 19:43:02 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH v2 1/3] iio: humidity: dht11: Don't warn on memory allocation failure
Date:   Mon, 18 Jul 2022 21:42:56 +0200
Message-Id: <20220718194258.181738-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; h=from:subject; bh=8TVjomHREqqyvKRzyE40hre1M7hrdAwuPFvVp8l3SEU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1be2GgHBgw/Wd5r5qlaswSabD9fgJavgRlee0Efg YLK40sqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW3tgAKCRDB/BR4rcrsCXLUB/ 0fGlg2dL8OgJqdUFcpI4vsmfJOTDFPQZ2fF2y2i1jT/JEZfFfDhdmAPB7VOYdpYlTt1/OKL2CzXf3O Yzru45t0d65P/MKgdTGKAQU9fm7NGYyTjgtsxo0DSOVvO8vN6OQfglATxn11CzScKGiuOE+oqYaH05 HokTGjOPfbRYNl6XNq6DsowHrxB1VGf0+obkbzzL1VvoSilBtusLHRH0GjPeSBtlAltdCLb6yY70JZ KaMQASzF4zBEFDa7clZbyRWeLvwTjUoslAYeGD99QwiwppSd3oaY6pJ+yOiN2gZAJqBHXuj9MssbSx sCj3M74mowMRWKaSHPtzuTUBP4BKiW
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
Unchanged since (implicit) v1

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

