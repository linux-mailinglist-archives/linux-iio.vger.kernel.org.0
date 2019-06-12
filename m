Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0141D9B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfFLHZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 03:25:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41822 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731444AbfFLHZl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 03:25:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5C7LWAv032477;
        Wed, 12 Jun 2019 09:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=KbcSWP4wfCKyU5i1RBXyvNUgYhKI0uEtgTlQINAU0ac=;
 b=c3t1+sjSdVDhM/5oMjux9wwOHa5QHWdJTmK3WbucMzyaeLIy4YsF0R8OPjCMbV1+wROT
 ED2kx0rGVEqJgJLXjG3SpVdKPCfJUR4W6cr5PEEHwTAD3EbwOfCpYhpyXRjd4bQI1pE6
 PbzYknl5CilxKqX3E/0HATK5laDphch0zu3RZ0GsfSHc0R2N6qJRCEypWQSgeVXNrh2y
 8Usbg+x7UvB439EAgftWyVuTTVljh1nH7Q5Ik+0S+PEs7jOcYFjMp4+ZhThq2Dybx7a+
 liSFnnlGLDMeSVlkwXT9P6UhiIhF3RYHbLOJHAPE+gIUZqUI7q4iX7TaGrEKNtRv1HOL Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t2f8bukd2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 09:25:00 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0489A38;
        Wed, 12 Jun 2019 07:24:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C09D3164B;
        Wed, 12 Jun 2019 07:24:58 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun 2019 09:24:58
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] STM32 ADC analog switches supply control
Date:   Wed, 12 Jun 2019 09:24:33 +0200
Message-ID: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_04:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for SYSCFG bits that control ADC analog switches
supply on STM32MP1 and STM32H7.

The ADC inputs are multiplexed with analog switches which have reduced
performances when their supply is below 2.7V. Analog switches supply
can be controlled using SYSCFG bits, to reach full ADC performance.

Fabrice Gasnier (3):
  dt-bindings: iio: adc: stm32: add analog switches supply control
  iio: adc: stm32-adc: add analog switches supply control
  ARM: dts: stm32: add ADC analog switches syscfg on stm32mp157c

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   6 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
 drivers/iio/adc/stm32-adc-core.c                   | 232 ++++++++++++++++++++-
 3 files changed, 237 insertions(+), 2 deletions(-)

-- 
2.7.4

