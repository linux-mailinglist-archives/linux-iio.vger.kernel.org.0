Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B04B876
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfFSMbU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 08:31:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14444 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731848AbfFSMbT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 08:31:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCQNaU013623;
        Wed, 19 Jun 2019 14:30:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VBdmw2B8JzIwHBf2DCzNhNhp/wewpseJ6FglA41KzDA=;
 b=HBwMhu88MDRfMzdTNuZfO7msKon03r30NvVEq2joa3SpqyF6u1Ahr7V9dClcMxhDJM+B
 A7qZQcbSgM6+aTpoCbJYmW3jWzqRmVRQjhk0pb8H/tcGYHulHlQtUarS0QZ/PO7F+CkC
 2E0oJwOUFujNxMUDTHXAKZD5O9758tLWN/GM4QhvojMXNyJp8qdBN1cECDIU/Lc2/hwq
 pFUSHe1weWajs/n7EHdyK18bIggS0X7ZXyoBTNQ8wqMKJDtDkT37Yo4IYo8ITP3T/LIy
 6RrDh29JksY8qR0EbBK1lvR6Jr1igmQSkGjGq/2lQGCnNbZ/CEjtkKi662oRKpshO82i ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t781uux8d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 14:30:52 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C468938;
        Wed, 19 Jun 2019 12:30:51 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91CE227A7;
        Wed, 19 Jun 2019 12:30:51 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 14:30:51
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
Subject: [PATCH 0/5] Add missing vdda-supply to STM32 ADC
Date:   Wed, 19 Jun 2019 14:29:53 +0200
Message-ID: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing vdda-supply, analog power supply, to STM32 ADC. When vdda is
an independent supply, it needs to be properly turned on or off to supply
the ADC.
This series proposes fixes for the dt-bindings, IIO driver and relevant
device tree files.

Fabrice Gasnier (5):
  dt-bindings: iio: adc: stm32: add missing vdda supply
  iio: adc: stm32-adc: add missing vdda-supply
  ARM: dts: stm32: remove fixed regulator unit address on stm32429i-eval
  ARM: dts: stm32: add missing vdda-supply to adc on stm32429i-eval
  ARM: dts: stm32: add missing vdda-supply to adc on stm32h743i-eval

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  1 +
 arch/arm/boot/dts/stm32429i-eval.dts               | 25 +++++++++++-----------
 arch/arm/boot/dts/stm32h743i-eval.dts              |  1 +
 drivers/iio/adc/stm32-adc-core.c                   | 21 +++++++++++++++++-
 4 files changed, 35 insertions(+), 13 deletions(-)

-- 
2.7.4

