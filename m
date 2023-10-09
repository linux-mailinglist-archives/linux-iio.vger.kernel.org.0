Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BA7BD84D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjJIKO1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJIKO0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 06:14:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60D9C
        for <linux-iio@vger.kernel.org>; Mon,  9 Oct 2023 03:14:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231009101422euoutp01a31a4bfe8038983b052657ba60a7ac80~MaN4oc5W72729727297euoutp01f
        for <linux-iio@vger.kernel.org>; Mon,  9 Oct 2023 10:14:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231009101422euoutp01a31a4bfe8038983b052657ba60a7ac80~MaN4oc5W72729727297euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696846463;
        bh=MYvcvzpld+Wo0XfGrFPZVB0l2+BpWnNYmiZFT6DHJ8I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U/jscs1mse57r44DuZPOcRSf28gL1XSZw5aB8Xx5OrELqIWp5Sixu1XTVT8yxPqF1
         F1bt3DLF9TaplpgzqdCY9oovwoseOreeASIIC3yGqtklg41M4/koOheHGvoEFUneNB
         OGVTYChgrhQlO024hvCVBvvMnZ9WKnq9cFbwGpiU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231009101422eucas1p144a8d96dda9dbae73052b1453d1cf2bd~MaN4O4IZS1524215242eucas1p1n;
        Mon,  9 Oct 2023 10:14:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C6.50.11320.E72D3256; Mon,  9
        Oct 2023 11:14:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd~MaN33jaj_1019510195eucas1p2Z;
        Mon,  9 Oct 2023 10:14:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231009101422eusmtrp2abc60570fb878c75774e7db24005cb4e~MaN33Agew0333703337eusmtrp20;
        Mon,  9 Oct 2023 10:14:22 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-f4-6523d27e7b4a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.4C.10549.E72D3256; Mon,  9
        Oct 2023 11:14:22 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231009101421eusmtip24e8a1f17d2d0881aa14d6125916a60c1~MaN2416A-1812118121eusmtip2R;
        Mon,  9 Oct 2023 10:14:21 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iio: exynos-adc: request second interupt only when
 touchscreen mode is used
Date:   Mon,  9 Oct 2023 12:14:12 +0200
Message-Id: <20231009101412.916922-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87p1l5RTDZquS1s8mLeNzeLvpGPs
        Fg+aVjFZ7H29ld1iyeT5rBabHl9jtZh35B2LxYzz+5gs1h65y+7A6fH71yRGj02rOtk87lzb
        w+axeUm9x5I3h1g9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PS9+0sBY95K17s387SwNjA
        3cXIySEhYCLRv6iXtYuRi0NIYAWjxImTS1ggnC+MEgufX2OCcD4zShw8cYcJpmX9uW1QVcsZ
        JT5O+ccM1/Jz20RmkCo2AUOJrrddbCC2iECGxI6uU+wgNrPAH0aJ2dd8QWxhgTiJjp4pYHEW
        AVWJfzs2gdm8AnYS53efZYfYJi+x/+BZZoi4oMTJmU9YIObISzRvnQ22WELgAIfE410NQF9w
        ADkuEhu3lkD0Cku8Or4Fao6MxP+d85kg6tsZJRb8vg/lTGCUaHh+ixGiylrizrlfbCCDmAU0
        Jdbv0ocIO0osPfOQCWI+n8SNt4IQN/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYoawPSQW
        z74JDhIhgViJa6cbGCcwKsxC8tksJJ/NQrhhASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k
        /NxNjMCUdPrf8S87GJe/+qh3iJGJg/EQowQHs5IIr26pQqoQb0piZVVqUX58UWlOavEhRmkO
        FiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk3W7bfAb+a9BXTmv/l+6++bK42ztC0VrW+b1
        70jvDWlgWLdjRzCvxXqPRXWu1t0tv2XU3h7hCNzRlJ5S79U39YBZxNYFAhYlVdMSdqut+Htt
        qZJDyLze7fY6+z+/aM6c/74+K+LihHNPK3+x8M83fZ22b/bXbTczJxzxv7v17uPmab89ju1a
        qGjmuPoWw6LO4ulr3kWcYVrYqOl9MDL9xV4frYtl+a66vyb0u8669H/jsQMLFBmNW4+/UZhp
        PummkkrSitjFTy5vXDb5Lv9txoUd39j/HlVTZTv+MaDR4m2r1IG3fJ9P/TqrYh4cIK7jr678
        6EGNzSmGw8tOnHidbeBV+fS13tNewfSQORK7y/YrsRRnJBpqMRcVJwIAYTbZurgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7p1l5RTDeadZbF4MG8bm8XfScfY
        LR40rWKy2Pt6K7vFksnzWS02Pb7GajHvyDsWixnn9zFZrD1yl92B0+P3r0mMHptWdbJ53Lm2
        h81j85J6jyVvDrF69G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsak79tZCh7zVrzYv52lgbGBu4uRk0NCwERi/bltLF2MXBxC
        AksZJY6+mcUMkZCRODmtgRXCFpb4c62LDcQWEvjEKHF9bzaIzSZgKNH1FiTOwSEikCXx93Qk
        yBxmgQYmiefzV7CCxIUFYiSW7pUFKWcRUJX4t2MTO4jNK2AncX73WXaI8fIS+w+eZYaIC0qc
        nPmEBcRmBoo3b53NPIGRbxaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC42Db
        sZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7dUoVUId6UxMqq1KL8+KLSnNTiQ4ymQPdNZJYSTc4H
        RmJeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT0bVvUU8eignP
        YLj7zFFXbek69iUTDdjsVz43vbRl3yYpn121R/bnyzLpTGSPXOx4cZECg+9dhik79Q/EyygZ
        iF/uitw4V+znxWtbvqSVTXqYl1EZHTEheo9oxbXDu/71rT//knFF3juLCXP4HeyXfHQ6w8P7
        w+L619yeHqNluoFxXZJX868EbZ5ZvWrzu3ieGUETTUVnlbaXuajcm6Vef/zfHy7PNdzyhtya
        5XJyDGVXvDyvFN/as3qOxneOB69+bLvx8/XGd2cWT5vWE/4o9Kv1vcClLus1L4i19rgzL+2W
        X8B5aXPSL06BQ3Ov5HVXmT6MUvl11CpPbtr7J7XO6+zerg3/0lxtKKVXmOyxVYmlOCPRUIu5
        qDgRAMosim4MAwAA
X-CMS-MailID: 20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd
References: <CGME20231009101422eucas1p2c004097457990bbaf9b3cc5df9e246fd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Second interrupt is needed only when touchscreen mode is used, so don't
request it unconditionally. This removes the following annoying warning
during boot:

exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index eb7a2dd59517..614de9644800 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -826,16 +826,26 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -900,12 +910,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
-- 
2.34.1

