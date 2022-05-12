Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD9525577
	for <lists+linux-iio@lfdr.de>; Thu, 12 May 2022 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357938AbiELTNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 May 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353107AbiELTNr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2022 15:13:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBA1A0AF3;
        Thu, 12 May 2022 12:13:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so10770672lfh.8;
        Thu, 12 May 2022 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyhacgbGSHcXGDEruHjCBEZQJDTnm+E2dVyccxhfr+I=;
        b=V+ZKHmrB3XgS4QXRdNl/khDE7X8CSh8yCTaxSwN1FEKAVom8pm74Z4kc4NlnwTtCsm
         qeMyOXTSrz7ckDawSm1y3pIaP5aE9U9PtPphS6ssVTQcmTAOb9mw61+aan+YSKWvR4SQ
         /jaXeZ2z7pRVH+qV7p/H+3l1qiqD//bfD97+KkD8+DpEymTAOQjgqOyAo4BBrXEdxywL
         G1rYgCY/eyLJyJh1F5K6HEoNVFYHu2wuvdl/TaK4QGhcSOq1LmsTo+sgUlcw3t3v6Qu4
         VvKLTztHU5ZVoejUPvWdqCqrzSEDkGgwUODmDsOnbafYVW/sM/wrrVeJCWpdW4ZRhBSH
         1hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyhacgbGSHcXGDEruHjCBEZQJDTnm+E2dVyccxhfr+I=;
        b=VIgwD+Bdr6826bZGSx8w9hpfxU80n/N/1JEGsRa4jSHkVJ93uZ93uLKuq5MzTJVltz
         73x1SBEey3JVupUbTIIB6fBMjf3DUhaKM5HUiBg0aSzoz9Ypo/Gn/gADgHBQ2bA3PqwD
         Xbz5jg8yXSAAvCOL92dy45CfsIPtT9Y8lvfLrcsw6WZB5V8FsdkwARgDdiYkh5bMRLRf
         lC7fDe/qJ3kwl/8A3/ZkQ7D81vpRhZ5vLlXWaL8eCx2T0INjv8OW6/Ik4RONhoHPcM50
         Se0wbsW7vtmQqaVPyive/8dAXaaijfv2kSgji1cCr19vs+j5nAMfNOImV9J1sY+QPXUv
         JgKg==
X-Gm-Message-State: AOAM5311BU14ncrpq6qfM/5obplHo3bCep1hKwsvGtjLbVIcWAAE/ivZ
        QCelDjpBYstvx/vLXCw/kYa61qNjQ6EtwQ==
X-Google-Smtp-Source: ABdhPJw4qAEJCsjFWqaF8N1y/ar8DNryN1nFdar92vrGry6T/7iN9XZNWnapcsX8xa77/KaWRSXMjA==
X-Received: by 2002:a05:6512:2009:b0:471:ffee:6ee1 with SMTP id a9-20020a056512200900b00471ffee6ee1mr893466lfb.268.1652382824597;
        Thu, 12 May 2022 12:13:44 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:44 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/5] Add support for ToF sensor on Yoshino platform
Date:   Thu, 12 May 2022 22:13:28 +0300
Message-Id: <20220512191334.61804-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the ToF proximity sensor installed on
Yoshino devices. As part of this series, support handling the reset
GPIO and VDD supply by the VL53L0X driver. Also stop hardcoding the
interrupt type, since on Yoshino devices it seems that edge triggering
doesn't work properly.

Tested on Sony Xperia XZ1 (poplar).

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

v2:
- Fix a nasty issue: turns out grouping the pinctrl makes it not apply,
which was the main cause of edge interrupts not working correctly and
having to use level interrupts, which caused a large amount of false
detections.
- handle the irq type more gracefully: if it's not provided, default
to falling edge, but if it's provided, then use the provided one.
v3:
- add irq.h header (forgot to commit)
- reword commit message (already initialized -> pre-initialized)
v4:
- reorder powering on and power off action (Jonathan)
- sort pinctrls by GPIO number (Konrad)

Markuss Broks (5):
  dt-bindings: proximity: vl53l0x: Document optional supply and GPIO
    properties
  proximity: vl53l0x: Get interrupt type from DT
  proximity: vl53l0x: Handle the VDD regulator
  proximity: vl53l0x: Handle the reset GPIO
  arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support

 .../bindings/iio/proximity/st,vl53l0x.yaml    |  5 ++
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 34 +++++++++++++
 drivers/iio/proximity/vl53l0x-i2c.c           | 50 ++++++++++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.35.1

