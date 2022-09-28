Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5877D5EE230
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiI1QoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Sep 2022 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiI1Qnc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2022 12:43:32 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13ECE952C;
        Wed, 28 Sep 2022 09:43:20 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SGQFUm020655;
        Wed, 28 Sep 2022 18:42:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=sfe+c3z4CBqQvUGfg0kmIxD0Kl5h3efDT5pi0QvUkhA=;
 b=otNgfxPQeWIQMEaJ7qBmPpmS3bSgAaoLJUH2jlPLWBITBq8sKj9VbAOV/ttn2Oqmnpto
 XnDrpKETjIUI/r1d5TTSABy+Fx4FjMxDzqnoczpYpBEEQI4SZaOe6ocYBbwLTi5sXSs/
 6WXNqSEmHdmONsB4G5U37LH+0NGorw+UtjvuIKvEBNqBw+/io8cCQ2aO6Km1nE3ujgr7
 JXAqZsEAhG8FiT4/O1ernkm5tK2ycYejfAlyV2eEcD/cX6yYf0Jxn5UhklmwaXpZ4K3Y
 v6Lbut2jkgPjuMwgTxiaPEYj358NtDasKmujh2Gx7dpqXLG9jPZ1cvtlTQzDcIhqrm0i tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsqamj8cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 18:42:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FF3710002A;
        Wed, 28 Sep 2022 18:42:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0ABF923C6B4;
        Wed, 28 Sep 2022 18:42:56 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 18:42:55 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 7/8] ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
Date:   Wed, 28 Sep 2022 18:41:13 +0200
Message-ID: <20220928164114.48339-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928164114.48339-1-olivier.moysan@foss.st.com>
References: <20220928164114.48339-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a dummy fixed regulator vdd-adc for STM32 ADC,
on STM32MP135F-DK board, while SCMI regulators are not available.
This patch will have to be removed when SCMI regulator support
is added to STM32MP13.

This patch intends to allow ADC enabling on STM32MP13.
With this patch the ADC can probe but it cannot return
valid conversion data, as it's regulator is not actually enabled.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index e6b8ffd332c7..95068231ed57 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -66,6 +66,14 @@ vdd_sd: vdd-sd {
 		regulator-max-microvolt = <2900000>;
 		regulator-always-on;
 	};
+
+	vdd_adc: vdd-adc {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_adc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &iwdg2 {
-- 
2.25.1

