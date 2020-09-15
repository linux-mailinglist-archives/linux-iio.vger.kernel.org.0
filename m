Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7C26AD9E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgIOTal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgIOT1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:27:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCACC061797;
        Tue, 15 Sep 2020 12:26:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l17so4149904edq.12;
        Tue, 15 Sep 2020 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNJ33X1X2x2pheRlwyrmnoylDAJlzuXstxu32SG7U2U=;
        b=ZvYuw0j9+OxIp9RRQIeIkbL7ZwpGqcUGl8PqjkMNBe3A0c7KyELphhBEMdBFj3S4BT
         r1Tx/r9dJxRZveLzxj5S7ejzscSYZPtmAJBcMCfxmRJFjt6QK0PxPjXFJMskYIV8280O
         7Ye//unKIMgMRpRr9zbbDTA0FGPHuVT8ogFTgd/pvKnbv/TTmw3gn6WAD5+s/rtbGhhS
         yMhur9waNMKMb+0NVeE2tZIL6BDyL6fEuh/Cd1AfVaUV5Q8kHhkCmgK0ouUcSl2i72Nl
         VH9YOWzUZFlBO5Ai+gAveqKk9L2L8iHKBJPupObNGmqoXkhOz4t01NrRAxRd9kW+26JP
         sQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNJ33X1X2x2pheRlwyrmnoylDAJlzuXstxu32SG7U2U=;
        b=BD3MVK8ndotUhVNWeukZyoEuZnyh5hg0+eoMnARGPoKHq7wjZ63r16C7/Q7WGKf5/8
         VJ5eNTYxJk5EbQjCe0BhydWBXuViAn6A/+KaJ23qCzRNRXDEnQQk9G2cP5WehzkSGzka
         Le+TiGwfZ/2X75yLpjEkE2ZIx9jmFeTBs/cJtvz+RglU/4Kgnoly1sfmTv6t3l0skbdz
         acvBmC2BCxjOjGjbratKdY98sYQYo3gWboThn0RX+3yRcBBMcBm/dcXHia5F48lADEDJ
         NPp6EbnhlgOqcElte2nnAwnw0vk5rNbP1foWPsuWTKrtLZtYm/0mFj34WXNf7pFLsAv2
         UHFA==
X-Gm-Message-State: AOAM533ClxwJYDg8P/7+v4l8zm9z3EnEB9buSL9osKX71QzFyx3D6gZF
        CUhn6RETdz39l4j1TZvBqX8=
X-Google-Smtp-Source: ABdhPJyLyVl+bnfqF/iHpAZ2TTiUTK6ronbqqCJXBb5eGl6BjXnA0APDpW9Nf10CI8cwXaOvHV6xzA==
X-Received: by 2002:a50:ec12:: with SMTP id g18mr14656537edr.309.1600198010859;
        Tue, 15 Sep 2020 12:26:50 -0700 (PDT)
Received: from localhost.localdomain (p200300f13701d4040000000000000fcc.dip0.t-ipconnect.de. [2003:f1:3701:d404::fcc])
        by smtp.googlemail.com with ESMTPSA id re19sm10836312ejb.86.2020.09.15.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:26:50 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jic23@kernel.org, linux-amlogic@lists.infradead.org,
        linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] iio: adc: meson-saradc: Make the of_device_id array style consistent
Date:   Tue, 15 Sep 2020 21:26:21 +0200
Message-Id: <20200915192621.13202-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use only one line for the closing bracket of the last entry and the
opening bracket for the next one to keep the style across the whole
array consistent. Also add a "sentinel" comment to the last entry and
remove the comma to ensure that there won't be any entry after it.
No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 95bd187de1cb..e03988698755 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1150,16 +1150,13 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	{
 		.compatible = "amlogic,meson8-saradc",
 		.data = &meson_sar_adc_meson8_data,
-	},
-	{
+	}, {
 		.compatible = "amlogic,meson8b-saradc",
 		.data = &meson_sar_adc_meson8b_data,
-	},
-	{
+	}, {
 		.compatible = "amlogic,meson8m2-saradc",
 		.data = &meson_sar_adc_meson8m2_data,
-	},
-	{
+	}, {
 		.compatible = "amlogic,meson-gxbb-saradc",
 		.data = &meson_sar_adc_gxbb_data,
 	}, {
@@ -1175,7 +1172,7 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 		.compatible = "amlogic,meson-g12a-saradc",
 		.data = &meson_sar_adc_g12a_data,
 	},
-	{},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
 
-- 
2.28.0

