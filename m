Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B7279B48
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgIZRSp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZRSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 13:18:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A6C0613CE;
        Sat, 26 Sep 2020 10:18:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so7297670wrs.5;
        Sat, 26 Sep 2020 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8nPtqvHXCkUTvUezerS3EWetfGCD8LGrLlldVmFG+I=;
        b=dVhPJD/W+PLgXlmj9+7F9WqTsSSMJb48hu4R+kdlQujgkQ6XzU432IFkDwFdVVxuxJ
         gDV8OM6mwf8Mf4qnJTbX4HMwNATlkfCDCanHsuKsor20zHsG9hZ4PuSWHr2v09IKnO2i
         vbZ+ERCrqxrcghCLeECSx/ul9OoXmTmbQaiZaDIL2b+SjTr4AsdZpQvlxcZSov/sS3nj
         g+mvWf+W49DRmFqSerZEYmTIL+zH0PjQk1Lj7i1sB/DboD9xwhABBVeN0X6rnbA/asIb
         /IJ3Q7nZBhYlfH3dNiMW6qd2wLg0bXfn8Likzz/ilQiiriehEN4DyybKA3MFFU11tT9u
         C28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8nPtqvHXCkUTvUezerS3EWetfGCD8LGrLlldVmFG+I=;
        b=QU1EH3BmX86/9jDUsRQOpsa7WuOFON0KNsIv0JN0GiheDlpfcCEnyrfjUIhOTv66p/
         WE9sqIbruwusngmKEbAfiqOiESNxar3H/sGZtRY4M1BkTr8I65gGk/7lgMribCtCmtgf
         PwtZGpEdhYol9yMCGFenGXGhlJQHHxgRZYI7/1AYtm51Xw82DHi52FVT5oM6djHOhE2t
         uTEjbJEB4hQgA1dxcJ5NG1A3/gU96W23vpv1q0XOJLzWEQcdCeVe1Z7OpHuYVswak/tZ
         g9sUhFAZD+TYplTIZ1G5nFwhbu3Cg7zyncJYOH0P3Six8RTvI2ltaqq0C+eQQ2sL+/s2
         Z/zw==
X-Gm-Message-State: AOAM531buLG0DaBg+pKg8hh1Yu+Via3fi3mmn5XJYR5SOC4IQlzb2eI1
        XQB9UdQT69+ABQUCGeSgtYA=
X-Google-Smtp-Source: ABdhPJwQP2F6G4uixs1tEIh0Q5eW4AEu9eRwSzqVBJLGnMX+M/dFuiQjw/chmrOvkkurE4Two1VoSw==
X-Received: by 2002:adf:83c3:: with SMTP id 61mr9987667wre.287.1601140722463;
        Sat, 26 Sep 2020 10:18:42 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id l4sm7427125wrc.14.2020.09.26.10.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:18:42 -0700 (PDT)
From:   kholk11@gmail.com
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, jic23@kernel.org, robh+dt@kernel.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: qcom-spmi-vadc: Document qcom,spmi-vadc-8998 compatible
Date:   Sat, 26 Sep 2020 19:18:35 +0200
Message-Id: <20200926171835.27154-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171835.27154-1-kholk11@gmail.com>
References: <20200926171835.27154-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This compatible is used in the qcom-spmi-vadc driver to select a
variation in the ratiometric range, valid for MSM8998-style VADCs,
like MSM8998 itself, SDM630, SDM636, SDM660, SDM845 and others.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 0ca992465a21..e9f0ebba5e2a 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,spmi-vadc
+              - qcom,spmi-vadc-8998
               - qcom,spmi-adc5
               - qcom,spmi-adc-rev2
               - qcom,spmi-adc7
-- 
2.28.0

