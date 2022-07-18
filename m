Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE05578B20
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiGRTnN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiGRTnN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:43:13 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859B313A5
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description; bh=87WYTvokChWA0TkWM01Hlms4BQL3Uf8tiOA7mq4jtb0=; b=CbKU
        /PpXI4034l2V6vDkukqg7b6kF3O8qTIuQ3rjcgmpfc+SEB166yQQRe157rhUHia3pSy0jfDbnkH2q
        WOhgY0apMONCT0S6+ySMetZVBeCGPAU92Y6Hghpi1KB04MNPeN6jqZT4N9CLP8RkYJyxJtu4gi4y8
        FI3RIhqM5nRQQj2VtZlwd6eS5nMKe/jbcc9I+2QItol6wv7IcW1r3j5mrtTXqxbS7m168P3/D4d/B
        zJVCpj68N4j9mqQy/83O81O9/CoP1qQ7eBxA6G1k/G9ouDKKVujwhi1KbxV7wgQUo7hGZ6YSNSAeo
        Nm1S/2FG4LowNbWCtbbOoqRiBiceJQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWe2-0000pK-HW; Mon, 18 Jul 2022 19:43:06 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH v2 3/3] iio: humidity: dht11: Use dev_err_probe consistently
Date:   Mon, 18 Jul 2022 21:42:58 +0200
Message-Id: <20220718194258.181738-3-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718194258.181738-1-ukleinek@debian.org>
References: <20220718194258.181738-1-ukleinek@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; h=from:subject; bh=DTHe2HsNrArGM3o70Z/ShAF/gaKKYa9hT6OQgAqPNLI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1be9F6LnDlALp9whUe14WHuh4ylWfLZC0ZAbY9wF tGZvct+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW3vQAKCRDB/BR4rcrsCX+KB/ wLZIZkcrD8woXUs2q/UAhYyLSXoeFF8pzN+L0IDeAkTjGWv3YiybTGKWM44sNJabED2+yMR9Pz0cMj T5aCnnHRUdlo5zbM58iAoA7kxqdynmssnAUtgfZu70EwiHyl6GGH6koWo0qIPMbuJB+HCc8cS0NtoR 6NF8l7ECkEFWxgTvul/CqnlwmIZaNsPDqbYxodCfhriOBUDZFkE8BqWyt2i3jzxNoDu1HZYvt/zF2c Pz2VLoKXTxwrxJoQD6ht021kyLB05b7qXluDiMaDQ8z2h9D+OL0tOf83gR42rSt3lMNL4jz9AVd596 q/BHPdEVdH70xJvYT8eQM6bbF+6IEx
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
No changes since (implicit) v1

 drivers/iio/humidity/dht11.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 0db4f7471319..d8b2cb3ef81e 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -307,10 +307,9 @@ static int dht11_probe(struct platform_device *pdev)
 				     "Failed to acquire GPIO\n");
 
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

