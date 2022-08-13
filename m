Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A4591A0B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiHMLu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHMLu2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 07:50:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E9C20BFF
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 04:50:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h1so1671933wmd.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rySRLwiiIOrtSpvOJyTmWSaKJJa5oryDquhv9YZj+6o=;
        b=YY2Jve7dPmBhnAAPknKHb75GYBe6TgB4NpBMCo7lsOxsvFBCkxz8lDcxWStY5d47Jv
         JP031NuvuBuaA95125eUkzukVIhphwd9IBcuuJlWoUxaJdI7zgqkMFR7yBfAZnCZfKg7
         X8ckr7JGKp0pvL9HU6UkL2rQSEaO6nxktBfeR/9r17vlYD8ntimnDfxZsHETZz7/cLbo
         l275B+eBqhsYsTRxCKqd1YgWQzUJqQF/X87a3p4gbZHSJ3UCYK/192171gan4M5iUwkm
         /fC8Asy0SerA+PA/uZsRVAk4/m2sSJaY7iF5AAKNh/Ap9mIhBDJUudbKN0hwI6v+Jwic
         suUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rySRLwiiIOrtSpvOJyTmWSaKJJa5oryDquhv9YZj+6o=;
        b=WHWsGcVIGP88LHzfHH8gY5v2KmSGsEp0eng1uBFvOMGUo6Ot20FY58alLDYid0px8L
         3AFqxIZrUY8OVtOeaY3OvjbWYtMuWcz+jZ4Fu/5vrCOwRF54iJ+kz3FjxL8mK+RM+0+i
         gnrhO/jmZtuUreG89o/fNqdOxmaSe/8FRDBnlQQ8GT/zu9h8nYNNEm48vAS1kb2QfCsT
         UC1m3bIrqAC0Q/oly7+sFp9nWr2eW88d73vSk85rzhaNNY/yN0iMlZK3Gx/o1FkTqC/8
         iA3JmyosoJHLCKLkdqWhJhPKtUrFaa0YCT+Ow0SW9QzyJTv6BVbJzH8UkRpA0kr01b//
         Jpow==
X-Gm-Message-State: ACgBeo35lYTXyvPVO1KrIMOSWkYYTdzrjIxLvwq/pxzY8IWhGlpspCzv
        m8A7lC+U+kZvqIcFHZxVXlx5Jw==
X-Google-Smtp-Source: AA6agR74gWIK4vbRB/zahVpfeJTmJjAaYd5j3yvMfKvXYOe/Z/7mJsBMh41qu6MV1qncnZnLUJsIKQ==
X-Received: by 2002:a7b:ce05:0:b0:3a5:c069:25b3 with SMTP id m5-20020a7bce05000000b003a5c06925b3mr5293928wmc.87.1660391422858;
        Sat, 13 Aug 2022 04:50:22 -0700 (PDT)
Received: from otso.. (mobiledyn-62-240-134-27.mrsn.at. [62.240.134.27])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003a325bd8517sm3656092wmq.5.2022.08.13.04.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 04:50:22 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Lee Jones <lee.jones@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: qcom-spmi-pmic: Add more PMIC SUBTYPE IDs
Date:   Sat, 13 Aug 2022 13:48:06 +0200
Message-Id: <20220813114806.102466-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add more IDs that are found in the downstream msm-4.19 kernel under the
path include/linux/qpnp/qpnp-revid.h.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
I've noticed that some hex numbers in this list have uppercase letters,
some have lower case ones.
If wanted I can add a patch converting all to either upper- or lower
case. Anyone have a preference here?

 include/soc/qcom/qcom-spmi-pmic.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 72398ff44719..bcb8e95d5dab 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -26,18 +26,32 @@
 #define PM8901_SUBTYPE		0x0f
 #define PM8950_SUBTYPE		0x10
 #define PMI8950_SUBTYPE		0x11
+#define PMK8001_SUBTYPE		0x12
+#define PMI8996_SUBTYPE		0x13
 #define PM8998_SUBTYPE		0x14
 #define PMI8998_SUBTYPE		0x15
+#define SMB1381_SUBTYPE		0x17
 #define PM8005_SUBTYPE		0x18
 #define PM660L_SUBTYPE		0x1A
 #define PM660_SUBTYPE		0x1B
+#define SMB1355_SUBTYPE		0x1C
 #define PM8150_SUBTYPE		0x1E
 #define PM8150L_SUBTYPE		0x1f
 #define PM8150B_SUBTYPE		0x20
 #define PMK8002_SUBTYPE		0x21
+#define SMB1390_SUBTYPE		0x23
 #define PM8009_SUBTYPE		0x24
+#define PMI632_SUBTYPE		0x25
 #define PM8150C_SUBTYPE		0x26
+#define PM6150_SUBTYPE		0x28
 #define SMB2351_SUBTYPE		0x29
+#define PM8008_SUBTYPE		0x2C
+#define PM6125_SUBTYPE		0x2D
+#define PM7250B_SUBTYPE		0x2E
+#define PMK8350_SUBTYPE		0x2F
+#define PMR735B_SUBTYPE		0x34
+#define PM6350_SUBTYPE		0x36
+#define PM2250_SUBTYPE		0x37
 
 #define PMI8998_FAB_ID_SMIC	0x11
 #define PMI8998_FAB_ID_GF	0x30
-- 
2.37.1

