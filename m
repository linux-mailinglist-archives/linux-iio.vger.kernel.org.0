Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F295157A4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Apr 2022 00:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347604AbiD2WFN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Apr 2022 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380252AbiD2WFL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2022 18:05:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A6C6F12
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso3026510pjb.5
        for <linux-iio@vger.kernel.org>; Fri, 29 Apr 2022 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wsf7PpH6YuEAThui9ph6/dEFWrNGkCrcVUMv4d0y+RE=;
        b=UBj0mbaUrykWmC+G7hZw1KMATmK+ZXir+FsVxiqP3ccz3kJVpRuTAIe2y3BVCLcBMj
         z3zpojZaG2HO66wmE+TkoZnKHIEEP1016h6DCZXAFqW9u0WCk+8nXN9xT9xmO2NaS+9o
         3IUvCRm1rEVZLDnKw3QecbITAYbCENnJ3ItOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wsf7PpH6YuEAThui9ph6/dEFWrNGkCrcVUMv4d0y+RE=;
        b=36g0wdpV/3T5AKEnli9IFemn+BwzHtDX4vDgC4rpvtbJg5M+rxyFSg5AfGLU4ToAvT
         Gq+3BgmYBZuxEvp4hrSFm7oKrBDmoPZgMHa0/WCnI6g+1yBXLByLqMndxMUsgG5ZpJ07
         hOLYVJmmx+Dg9kDMUPCKnIsV6pefCCgCuDUzihM6GujIKKgzoGoXG8zX0QwEdZXN4zdK
         pqLBJaTYoOut+08NeMDPEjL4deklaaTkUP82Oir97Bqrvel1LJHYuH63hi34HBRxe+hz
         IYouPvKL2iDlnQeVrk8LZ7t7soJjMUBmv/r9KA9aoodrnnES4KJND29TyzTPasLjfghx
         5ZUA==
X-Gm-Message-State: AOAM533LWOt8AVFnYEHOJll+jrmpVO/GxHIJtNOI+wbWaBDBtLYOxw7d
        Ik+bnN8gIYMtQI2rv9TqL6E2tA==
X-Google-Smtp-Source: ABdhPJxQIefzP56gNj6qPyOaAHOEhu+gvftK1CSnPylGJl8ioSUKpqJDXfyY1jEfvW2JpYoDS4n1cg==
X-Received: by 2002:a17:90a:cc6:b0:1d2:9a04:d29e with SMTP id 6-20020a17090a0cc600b001d29a04d29emr1203878pjt.136.1651269709696;
        Fri, 29 Apr 2022 15:01:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6161:73ca:10a5:5383])
        by smtp.gmail.com with UTF8SMTPSA id nm5-20020a17090b19c500b001cb978f906esm11203402pjb.0.2022.04.29.15.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:01:49 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 00/10] iio: sx9324/9360: Add settings for precharge, gain and internal resistor
Date:   Fri, 29 Apr 2022 15:01:34 -0700
Message-Id: <20220429220144.1476049-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
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

For Semtech sensors SX9324 and SX9360, allow confugration of the
pre-charge resistor (9324/9360) and internal resistor (9324).

Fix register name spelling mistakes first and set default value properly
for sx9324 internal resistor register.

The 9360 changes are independent from the 9324 changes, but they are
very similar.

Changes since v4:
- Add analog gain setting
- Add missing test when property is not found
- Fix dt-schema errors.

Changes since v3:
- Rename reserved field as _RESERVED_
- Fix invalid string matching with match_string()
- Fix cut and paste error in device tree bindings.

Changes since v2:
- use -ohms instead of -kohms, as ohms is a defined unit in
  dt-schema.git dtschema/schemas/property-units.yaml

Changes sinve v1:
- Add kOhm Unit, add a new patch to fix invalid register setting.

Gwendal Grignou (10):
  iio: sx9324: Fix default precharge internal resistance register
  iio: sx9324: Fix register field spelling
  dt-bindings: iio: sx9324: Add precharge resistor setting
  iio: sx9324: Add precharge internal resistance setting
  dt-bindings: iio: sx9324: Add internal compensation resistor setting
  iio: sx9324: Add Setting for internal compensation resistor
  dt-bindings: iio: sx9324: Add input analog gain
  iio: sx9324: Add Setting for internal analog gain
  dt-bindings: iio: sx9360: Add precharge resistor setting
  iio: sx9360: Add pre-charge resistor setting

 .../iio/proximity/semtech,sx9324.yaml         | 30 +++++++++
 .../iio/proximity/semtech,sx9360.yaml         |  9 +++
 drivers/iio/proximity/sx9324.c                | 66 +++++++++++++++++--
 drivers/iio/proximity/sx9360.c                | 15 ++++-
 4 files changed, 114 insertions(+), 6 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

