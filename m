Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC984E7C57
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiCYWKL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCYWKK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC2166678
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bc27so7498263pgb.4
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7X00LqhqpHZwyipr6lc2MdAmx6U5RnTCI92rZftagtM=;
        b=gXJHx4dLHRJikCj225JFWBmmSWee37txjmAmNWdkAzDDlvXeKtymxRcA00Wd+e1XVE
         qwox4q1txrq8DlN41edYX/LcHQ4JiJfWL398SbPHA2fTX4QeJbjFDM8kaYXDq2Irqto0
         /HD+VjfSw8GotSM1iEKao+3yiLw9M0ZLWS+10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7X00LqhqpHZwyipr6lc2MdAmx6U5RnTCI92rZftagtM=;
        b=DBaDTqDql8H17xX6to3flFd6ZOZ7ke8jvNT2HkwU5K3p1WKR9l6Zxc4iSnMWXsDGfZ
         i+gFWxe/zOAVUtoPuAL3X8ApLmj8aldPu3jnM80Q5lh2HuV1g20p0oAMc46GcQdV+NFH
         oOuTM3/p+ViRNEh02thQgou6B1laqba0Wtfq3oCJR50J3DAiZ4IE6d2oCyXZJckD2qyf
         wvWS9beOcMr/kQaoYbBT+i8Fsk7PgdhEQKvQhoENO6AgqP7XVzEY6K7HxbRxYpHQqSJw
         BPYGoi2+vqbfdkd2PgkivsSuLUvAkS+rhW9kh0uwigZFdCITvwq/G4dviG1Vpdil5ic5
         Okew==
X-Gm-Message-State: AOAM532hT7Tm+adK1US+LtADOfmMsHPo4RRjpN1ogOvoke9EMOjHjsoS
        re58KczswiLl6I5zasM0r0BfnQ==
X-Google-Smtp-Source: ABdhPJxPDIqqXOV9F3il3MjQ7S/3nUpNfNPxzUMM6Rf6wfFQMXHkG39ihCVSBfhWCXHzwx8n6z9Xog==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr12135342pfh.70.1648246114996;
        Fri, 25 Mar 2022 15:08:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm174253pfu.136.2022.03.25.15.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 3/8] dt-bindings: iio: sx9324: Add precharge resistor setting
Date:   Fri, 25 Mar 2022 15:08:22 -0700
Message-Id: <20220325220827.3719273-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220325220827.3719273-1-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow configure the resistance used during precharge.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Change kOhms into ohms.

Changes since v1:
- Suffix field with kOhms unit.

 .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b8a6ee16854ff..a22cad1507b6b 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -126,6 +126,14 @@ properties:
       UINT_MAX (4294967295) represents infinite. Other values
       represent 1-1/N.
 
+  semtech,input-precharge-resistor-ohms:
+    default: 4000
+    description:
+      Pre-charge input resistance in Ohm.
+      Rounded down to a 2000 Ohm multiple.
+    minimum: 0
+    maximum: 30000
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
2.35.1.1021.g381101b075-goog

