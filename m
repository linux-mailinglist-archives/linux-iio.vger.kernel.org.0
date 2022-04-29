Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2A5157BE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381131AbiD2WFU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380252AbiD2WFO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AE1C90F1
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c23so8308519plo.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nl6FydOlN2pYUTl+MvQ4KSG1F7oU2ZiZQ3YsqnGUnWM=;
        b=IJ0KZ56BQJxyq1cFpWmA/lEKHni9tGykH/e58idITXUHIlJnB4H/0iWLcPcfaItCy1
         Uz3aTKNIaoL9f4f3u8jgBuvQk0d62JCS4y9s0O6Vw0qS14Ar+UrzjpADxleApjQVNW2N
         yJImuoY+o6VEukXjwGcp2g31hNQUrluthlInk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nl6FydOlN2pYUTl+MvQ4KSG1F7oU2ZiZQ3YsqnGUnWM=;
        b=34UrFkPW+fs65BgGdK8GfjvksEDwKAHa3R/vs8mXg+hn3mnn2V4Y7dbpMnTC7HdNX0
         iMQUSuNc/TEEV/AKCJOjvU//h2so3HxIduLnh+EDYBn3TRMo5HXHGxNO11IfsJRTMtNA
         UYh8cVdEeUQ3p008fyMoKrfUFoHls/4mYHDbY+1EpdbwhXKIHRLwk/wQcJdoENH6zBHy
         pdnUBqoZ9Idx2232n8UZ+ZYqgb9CrT5TGJ/ER1qEKpt2nw5ExRKr71u5Zp+20KSRJBuN
         FSPwNDlwj0wl0zDuYDM6o1nwKhg8TyGjifKpdM4NpJs10z4KWWVFNNSHAyV5+e9ldkiR
         02XA==
X-Gm-Message-State: AOAM533t1ysGN1VCvIHUQzgaRWL746F2xt0VMYnlEoviQrsDo4x6CJcT
        KmiprX61W64KHAyz6+MJ1krCWQ==
X-Google-Smtp-Source: ABdhPJyG3ulfA5L9QHN9ajJjAgnor8GeebU0A2CJ7qY3c19G9gPA9afwRslYa+LBPgBpBJKoWe6eig==
X-Received: by 2002:a17:902:9a8c:b0:15a:a21:b52a with SMTP id w12-20020a1709029a8c00b0015a0a21b52amr1155021plp.86.1651269714075;
        Fri, 29 Apr 2022 15:01:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id bj1-20020a170902850100b0015e8d4eb2a2sm81088plb.236.2022.04.29.15.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:53 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 03/10] dt-bindings: iio: sx9324: Add precharge resistor setting
Date:   Fri, 29 Apr 2022 15:01:37 -0700
Message-Id: <20220429220144.1476049-4-gwendal@chromium.org>
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

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v4:
- Add multipleOf propery
- Move description at the end, to match convension.

Changes since v3:
- Added Review tags.

Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.

 .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b8a6ee16854ff..d689b2bab71b4 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-ohms:
+    default: 4000
+    multipleOf: 2000
+    minimum: 0
+    maximum: 30000
+    description:
+      Pre-charge input resistance in Ohm.
+
 required:
   - compatible
   - reg
@@ -157,5 +165,6 @@ examples:
         semtech,ph01-proxraw-strength = <2>;
         semtech,ph23-proxraw-strength = <2>;
         semtech,avg-pos-strength = <64>;
+        semtech,input-precharge-resistor-ohms = <2000>;
       };
     };
-- 
2.36.0.464.gb9c8b46e94-goog

