Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA243B661
	for <lists+linux-iio@lfdr.de>; Tue, 26 Oct 2021 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhJZQHa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Oct 2021 12:07:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29827 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhJZQHa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Oct 2021 12:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635264307; x=1666800307;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BrPAUzeqsMbKVEPMM2Ed71p3tWtEfCcyNYTlruWjEDI=;
  b=pOeQJWbsozEkwtTPGp07i4u24aQpPVRtlpJ7/FTGNB41fJoAcY3R/tQQ
   X8WeRZ09SeMd1fQfrhW3x8pHUxk6Rifu5Qi9glIxC2+efil28S6tXJrFh
   10kYHvTWItuz56+Jf/0I6ucW95qs4NJURZBgq1RzcY2Qd1GRuOX7OSeSN
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 09:05:06 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 09:05:05 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 09:04:57 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <amitk@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V2 0/3] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Tue, 26 Oct 2021 21:34:32 +0530
Message-ID: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Made following changes in this post:
Split IIO file changes into separate patch.
Addressed comments given by Dmitry for qcom-spmi-adc-tm5.c.

Jishnu Prakash (3):
  dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
  iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
  thermal: qcom: add support for PMIC5 Gen2 ADCTM

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  83 +++-
 drivers/iio/adc/qcom-vadc-common.c                 |  11 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 418 ++++++++++++++++++++-
 include/linux/iio/adc/qcom-vadc-common.h           |   2 +
 4 files changed, 493 insertions(+), 21 deletions(-)

-- 
2.7.4

