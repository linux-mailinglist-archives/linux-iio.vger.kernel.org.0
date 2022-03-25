Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23144E7B39
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiCYWKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiCYWKG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:10:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F27166660
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x2so9602690plm.7
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVQ2cd6RhgGyXtG8hwUr1nalR3TuoVbpI8pb2EoHGMo=;
        b=ZlVLMeIku+sL4PdX2xPEQmcRwGXJucVk+5prldiWKUXYGd4bQqGxIbl1vbGMhbftF1
         BLJPbEn6Myw495gkLwSNh+CdGmgFMOVLQM+t3fCBOxx1mfLIzK1SCPD/8AIxJznipZtB
         hDRwAJl02ETefuu8QtzSHXrQ/uXeXe9jhcC5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVQ2cd6RhgGyXtG8hwUr1nalR3TuoVbpI8pb2EoHGMo=;
        b=zR3jS586sXbkw4inFFfe5Y5daLCpHOhqhn2z5DHk9jXP/zNmrNa6V1dok065mZOAcb
         nLO8voRcRSQeFSOiaTaO4TbW3/krmX5HHQW8SWBHeTM+/Kl7hcbipC8vutSR/8QxopqE
         OCzYwLWcb88WnnqQCPuBAEusJIO6122stXMliXcQCNM2+a6pLoMcd1neMTt1MwnN0lfQ
         hY6i1t5Vz62ogNKOkPCEMBlUDfSB5474/FBiwY4F4txfCnrEIUWa/TNipy+1g2JEKsth
         9TyPR91J3KJgsB7erXS6eP/e1Vrvdoaz7X+dJZnE+DUMATQn10UOXu6xawjsc7K7XYaR
         5oRw==
X-Gm-Message-State: AOAM531ORxR9ILqp0B0BxpkHs1x+DjW7k+Bx793di2xtm+yAmlaV1qOY
        BEKXnub3KsUvDsiQc6CvmAWLg6gZcOWTqQ==
X-Google-Smtp-Source: ABdhPJz+r0L+5tKLlfgUBAfgwIAItzIR4kxuGo3+4GJQy0s4F1ckP9ctioAb4m+Hwkpp34pDddGCDw==
X-Received: by 2002:a17:90b:3e8b:b0:1c7:852d:e843 with SMTP id rj11-20020a17090b3e8b00b001c7852de843mr15145111pjb.244.1648246110870;
        Fri, 25 Mar 2022 15:08:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f21c:980b:7d64:94f9])
        by smtp.gmail.com with UTF8SMTPSA id a38-20020a056a001d2600b004f70d5e92basm7896704pfx.34.2022.03.25.15.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 15:08:30 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/8] Add settings for precharge and internal resistor
Date:   Fri, 25 Mar 2022 15:08:19 -0700
Message-Id: <20220325220827.3719273-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For Semtech sensors SX9324 and SX9360, allow confugration of the
pre-charge resistor (9324/9360) and internal resistor (9324).

Fix register name spelling mistakes first and set default value properly
for sx9324 internal resistor register.

The 9360 changes are independent from the 9324 changes, but they are
very similar.

Changes since v2:
- use -ohms instead of -kohms, as ohms is a defined unit in
  dt-schema.git dtschema/schemas/property-units.yaml

Changes sinve v1:
- Add kOhm Unit, add a new patch to fix invalid register setting.

Gwendal Grignou (8):
  iio: sx9324: Fix default precharge internal resistance register
  iio: sx9324: Fix register field spelling
  dt-bindings: iio: sx9324: Add precharge resistor setting
  iio: sx9324: Add precharge internal resistance setting
  dt-bindings: iio: sx9324: Add internal compensation resistor setting
  iio: sx9324: Add Setting for internal compensation resistor
  dt-bindings: iio: sx9360: Add precharge resistor setting
  iio: sx9360: Add pre-charge resistor setting

 .../iio/proximity/semtech,sx9324.yaml         | 19 ++++++++
 .../iio/proximity/semtech,sx9360.yaml         |  9 ++++
 drivers/iio/proximity/sx9324.c                | 44 ++++++++++++++++---
 drivers/iio/proximity/sx9360.c                | 12 ++++-
 4 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.35.1.1021.g381101b075-goog

