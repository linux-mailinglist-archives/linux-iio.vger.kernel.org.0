Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFADD459C02
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 06:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhKWGAb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 01:00:31 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:11893 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhKWGAa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 01:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637647042; x=1669183042;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3Tbc2nYFxGjvLfzVjRmoZY3g/Bwty5x5o3lfCID1MC8=;
  b=V4b/bA3cTxmQ86wxYRAX9ePvaXRjv885TZR+ZkxvQv50e2KS6VVqh5oq
   QJ9NjWoapCzPTbG2JKjqcIcuWHxoDFnE6Ot9cJT0/beaIfnMgUT/4KpBV
   i4ybQaTgJK0iT9sd7JrvKy+yZZTXyrQmxZ0qvrZ4l1tBSICfQpq50cnm7
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Nov 2021 21:57:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 21:57:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 21:57:21 -0800
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 21:57:14 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>, <amitk@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V3 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Tue, 23 Nov 2021 11:27:00 +0530
Message-ID: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Made following changes in this post:
Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
code to support multiple device generations and the second to add
actual Gen2 ADC_TM changes.

Jishnu Prakash (4):
  dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
  iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
  thermal: qcom: Add support for multiple generations of devices
  thermal: qcom: add support for PMIC5 Gen2 ADCTM

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
 drivers/iio/adc/qcom-vadc-common.c                 |  11 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 451 +++++++++++++++++++--
 include/linux/iio/adc/qcom-vadc-common.h           |   2 +
 4 files changed, 541 insertions(+), 33 deletions(-)

-- 
2.7.4

