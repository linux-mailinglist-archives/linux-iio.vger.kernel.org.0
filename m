Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789F34B88C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfFSMbu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 08:31:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58172 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731973AbfFSMb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 08:31:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCQsls023576;
        Wed, 19 Jun 2019 14:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1IKlN0lkX6OamQA0QpTf6frKqVaPaxAimtqxa01cDP0=;
 b=eQ7K9WfnRExhJ7fuAwpPxKZeF30fuldkU4Prr3V1ve4TRf7RBIg6zroXnUu6BioHtxlg
 xN306/i9RPorLmthNLQgVi6YVqDO+PVvaP9mcfM3T7dkfi82lXCKOKWefGd4j+K6iU6j
 vCtZfMrtaOAS24zevMbnrmUkXy/R2sxY8yQE4d0+LVkPS5wJfRZ5V/MHKQyP1wnkyAKB
 Ttb9qb3GH4yQzhxUcRrJ68duS/X5CzdOgxS4X+cLmAlE3l0uaettcf80vJyJv3uu783K
 KRJSZ2QdIroZfyI8cWLmkmH6aJA6iUzhnRcYc2vE7CyQO+DDGTT+nN1PhAjORuyXRZaN 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t7812uxwv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 14:30:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D08231;
        Wed, 19 Jun 2019 12:30:54 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4732727A5;
        Wed, 19 Jun 2019 12:30:54 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 14:30:53
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
Subject: [PATCH 4/5] ARM: dts: stm32: add missing vdda-supply to adc on stm32429i-eval
Date:   Wed, 19 Jun 2019 14:29:57 +0200
Message-ID: <1560947398-11592-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing vdda-supply required by STM32 ADC.

Fixes: 7465d81191a1 ("ARM: dts: stm32: enable ADC on stm32f429i-eval
board")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index d79f58f..ba08624 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -81,6 +81,12 @@
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
 
+	vdda: regulator-vdda {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	vref: regulator-vref {
 		compatible = "regulator-fixed";
@@ -151,6 +157,7 @@
 &adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&adc3_in8_pin>;
+	vdda-supply = <&vdda>;
 	vref-supply = <&vref>;
 	status = "okay";
 	adc3: adc@200 {
-- 
2.7.4

