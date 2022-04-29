Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B215157BC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiD2WFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356779AbiD2WFO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1415C8A9E
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv2so8178925pjb.4
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8xO7eiEK+03qYs1ZTGR45jDSALpn+OmeFkWLWDpYpw=;
        b=RsHwYNDRnFKYf+7PxCTfv/qKr2eyBDPKyscuZ6UJ9+KJf5UwMX2xb6m8hEKuL4xSPp
         yE+jkLEkzZtveE8z+NaNUQkTZVaPfNkwRYNJGupUeuVb+oizTtvi5QUil4gdkZvus5us
         TVEIV3zB9WCCaiL4S0SYwTLw/AM4A6SuDgYJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8xO7eiEK+03qYs1ZTGR45jDSALpn+OmeFkWLWDpYpw=;
        b=qAhqH0bFQgfTuujB0QFPsCBo32L3tQ0gNSuOdRXJfFnZTQqukUfHMC4Jj5mfxuT3dJ
         kdZ3wUAsLOFl6o7yzJ0eLx0IG6SC4GQJ/84cJWTv91Z9LNvU2T2Ae8aKFUQcRhYj6qcI
         38+jYCwJTpgc3CZtGmuzsS/kYaKoB1rGjkrbfX9PZUV+payxkni3Qvwfr8Osu1uKZcop
         bzR5XrGU0ZBdHjVzo0zoL2ZYglSW9LV5RI8NWQvOaTue57P57wXUV+ED1aZ6EIa9u5f0
         1WnqNm5Cy7ufX7JHzBsXy9CvZjb9h+FYprbz54DWJlKsPKGaEN+kWxbCJopkYZJzTk+X
         L90A==
X-Gm-Message-State: AOAM532NMLOiiCk0bbLs6rwApX9M0qPuJK6uWVgkderMFHYueArz7dsD
        i3KBIPdcsiOA95dUmG6hfiovCQ==
X-Google-Smtp-Source: ABdhPJz9vIoMPcZeZs6sQ6+KTQS8s+hlDMhJq7qvjxqIqy9e8KvzbdmsvepkZrLOQ0jkSV9x2Zb70Q==
X-Received: by 2002:a17:902:82c9:b0:15d:2e43:a0e5 with SMTP id u9-20020a17090282c900b0015d2e43a0e5mr1166147plz.64.1651269712457;
        Fri, 29 Apr 2022 15:01:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id 5-20020a630305000000b003c14af505ffsm6673879pgd.23.2022.04.29.15.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:52 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 02/10] iio: sx9324: Fix register field spelling
Date:   Fri, 29 Apr 2022 15:01:36 -0700
Message-Id: <20220429220144.1476049-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220429220144.1476049-1-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Field for PROX_CTRL4 should contain PROX_CTRL4.

Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No Changes in v5.
Changes since v3:
- Added Review tags.

Changes since v2:
- no changes

Changes since v1:
- Add Fixes keyword in commit message.

 drivers/iio/proximity/sx9324.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 378c2a17bae6e..a7d9a53692a6d 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -90,7 +90,7 @@
 #define SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK	GENMASK(5, 3)
 #define SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 0x08
 #define SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK	GENMASK(2, 0)
-#define SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 0x04
+#define SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 0x04
 #define SX9324_REG_PROX_CTRL5		0x35
 #define SX9324_REG_PROX_CTRL5_HYST_MASK			GENMASK(5, 4)
 #define SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
@@ -794,7 +794,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
 	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
 		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
 	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
-		SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 },
+		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
 	{ SX9324_REG_PROX_CTRL5, 0x00 },
 	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
 	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
-- 
2.36.0.464.gb9c8b46e94-goog

