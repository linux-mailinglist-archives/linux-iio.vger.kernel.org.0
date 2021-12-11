Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D324710D0
	for <lists+linux-iio@lfdr.de>; Sat, 11 Dec 2021 03:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbhLKC0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 21:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243747AbhLKC0L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 21:26:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E60C0617A1
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so35725047eds.10
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 18:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BN1rqnmoBfuCzzscvm3YOnK3Hq7APTJunkR2e6AyI44=;
        b=OlOB76TD4cnwKGMSNsqhD27bIGeNBDINaYaPIW606KZgbr4YcpmhVQpRZ5i7HoU25f
         /gI0gVIIVCFayaXW5CeZBZo5k+GtXYQ2D/y3h5WAD9MrExseetqHU1+3zGzcOlQoLR0P
         zanBl3z97aC2zyy9oQ3rUdTV9mxpR9uZ4NGcGgkGRM9vDAvtYb+f4gHC4adV+Bdo8ZF1
         m9LAsszA/U6mjYJH2ySLjicW6cGh+3w8wLo/IiHWpKvQL1zmu7tabwkuHSt4zKfCorhr
         Fq9JUc3griRTifpQN93SZEkgnsObl1CFUXqoeWhXQ0nB868+o4DL30s3RXlVGjVz6xKS
         vh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BN1rqnmoBfuCzzscvm3YOnK3Hq7APTJunkR2e6AyI44=;
        b=nz1Lsltx7/7gfmlk1VXF/ffhqk39AyQn38Kh4Kx1kywLGs8+ilNNh8vdqT8xB/WHs4
         YcbK1CSpEtrWankvrUOwJ5r4LJptgFl0AG4ZYom58f/+KQ6ZEIEZHcF0V3VLHPw+WyLq
         kQewL9dmRIqhgbsN3HGVOtiIBjXc84xGy+677YeRCy1bVzUqPSGAJ2TCDxudRiEtfC/d
         G78dC1Owl1+T/psoswkYVlh+RHL8QrvPjrdTKAWlvrJKyQHyEFm5F+71OZBlQPGA3cdW
         oGnbRA+IV6BY70gUMMfFBDHkhTAQhKRQhFQ+9XJ8cKVF4l5Upi/52Qv7Rtq4H7+m9y59
         pqPw==
X-Gm-Message-State: AOAM530MBC1AemNZeM32a95PU2kZOzCQfVqX14iYbAQNX4yATQBr6uD3
        Ul4cYY+dpppOmyleP2ZV/qyREQ==
X-Google-Smtp-Source: ABdhPJyIY1FSnIyvZJddEk0bFdLO16sKK4IFXhAd18ZGe1ELTgmf+D8v0J1Iu5Q7EEzNY4Q7QN5HPQ==
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr27304054ejc.121.1639189353667;
        Fri, 10 Dec 2021 18:22:33 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:33 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 0/7] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Sat, 11 Dec 2021 02:22:17 +0000
Message-Id: <20211211022224.3488860-1-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The RRADC is responsible for reading data about the current and
voltage from the USB or DC in jacks, it can also read the battery
ID (resistence) and some temperatures. It is found on the PMI8998 and
PM660 Qualcomm PMICs.

The RRADC has to calibrate some ADC values based on which chip fab
the PMIC was produced in, to facilitate this the patch
("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
exposes the PMIC revision information as a struct and registers it
as driver data in the Qualcomm SPMI PMIC driver so that it can be 
read by the RRADC.

Caleb Connolly (7):
  mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
  dt-bindings: iio: adc: document qcom-spmi-rradc
  iio: adc: qcom-spmi-rradc: introduce round robin adc
  arm64: dts: qcom: pmi8998: add rradc node
  arm64: dts: qcom: sdm845-oneplus: enable rradc
  arm64: dts: qcom: sdm845-db845c: enable rradc
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable RRADC

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   54 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1020 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  103 +-
 include/soc/qcom/qcom-pmic.h                  |   58 +
 10 files changed, 1216 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-pmic.h

-- 
2.34.1

