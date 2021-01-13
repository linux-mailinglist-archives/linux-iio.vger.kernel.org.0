Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448B72F4E57
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAMPTK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 10:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMPTJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jan 2021 10:19:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5431CC061786;
        Wed, 13 Jan 2021 07:18:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m4so2494454wrx.9;
        Wed, 13 Jan 2021 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kzRWO1g2nydF2LKWqESQR4NlJSJAXxDYrK3h7IF5Wlw=;
        b=M+BhNqQORxxPUaLNPs/8UZW5fEIH3oMnBnnC3i9nwocGgRfLEQxuwMGqZtZwDueIyZ
         Fp4J9rGnLlKOBGRohsT6EglxFdmVeaNuDf0qZVfpSFm+OP/1apUBGObwCovbVKcWrVzm
         LwdUzo3z38wehhwxw2C2yV1ElxcwqleuQZp49KsyAjbGh9afV93VmudI75ZasebQmcrP
         kmPNY8CNet+MDM6U8hqJCkoujsTlzXnBHNAgwa1UuUreNSUj72JAKRoI1M+MTGmIzXpV
         E+pTEiB2l4S7i5LI2fdSUsjb4KPUiNI2aNFHZCVk10NQ/FA8i0QtouBR2Uza+Au3aqGN
         T7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kzRWO1g2nydF2LKWqESQR4NlJSJAXxDYrK3h7IF5Wlw=;
        b=ioJzW2ka+X8yoO5TKO1ZGIlDMgxpjjkYK3UshUsuZijT+aCvN50nDcVRiUfwkHAnck
         AIgt//D0cFiCIRN5fkHru8dL9Jxxen0guuOOS/Co20PAS+I59cMZWIVsPOu24VOqv9ue
         4Sqw4JM7RXTCxxzSIoYS3vvE1yl2sOTwtR/i2g9LAb4PND07Usckapn6uUyya3jv3qxy
         rmjv7R59gw6fzKIq2DA6FtudS+bCRUgC9oIvQgtVfaub8fsB07ieNonJSFaq0rvU1zyL
         WnEhTszcEE4779a4EqB4PvKRpLcNvybkc1ESvoImo2mK95axL9JH2cQD0u5qAu2k1BQf
         31ww==
X-Gm-Message-State: AOAM532W1T1zT+jNIiBA8Vr+mFpDJZr6QnZwOA+dG29SfhUVhigPqGoc
        zJULLUllLlfUKH8TjV2CZa2unVpx9BIiFuPn
X-Google-Smtp-Source: ABdhPJxFqeQkr2aw8OrSaUA4n2GVb6LN8cFuZ4or3IaMeZVyEi2pRebu8pNBFRaBY/4jMdbvPW3bHg==
X-Received: by 2002:adf:f989:: with SMTP id f9mr3094366wrr.299.1610551107563;
        Wed, 13 Jan 2021 07:18:27 -0800 (PST)
Received: from jonathan-N53SV.station ([151.81.101.204])
        by smtp.googlemail.com with ESMTPSA id w1sm3890553wrr.84.2021.01.13.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:18:24 -0800 (PST)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/2] Allow VADC_LR_MUX2_BAT_ID channel proper reading
Date:   Wed, 13 Jan 2021 16:18:06 +0100
Message-Id: <20210113151808.4628-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Working on a battery charger and fuel gauge driver it happened to
have the need to read from VADC_LR_MUX2_BAT_ID channel. Here is
the declaration from downstream msm8916.dtsi:

	chan@31 {
		label = "batt_id";
		reg = <0x31>;
		qcom,decimation = <0>;
		qcom,pre-div-channel-scaling = <0>;
		qcom,calibration-type = "ratiometric";
		qcom,scale-function = <0>;
		qcom,hw-settle-time = <0xb>;
		qcom,fast-avg-setup = <0>;
	};

Those two patches set channel scaling accordingly and add it to
pm8916 device tree.

Jonathan Albrieux (2):
  iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel
  arm64: dts: qcom: pm8916: Add batt_id channel node

 arch/arm64/boot/dts/qcom/pm8916.dtsi | 5 +++++
 drivers/iio/adc/qcom-spmi-vadc.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.17.1

