Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD95F55A3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJENiH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJENh4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 09:37:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2A7B1E3;
        Wed,  5 Oct 2022 06:37:49 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295DRWRg022274;
        Wed, 5 Oct 2022 15:37:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Tvv4XSpFVhRAUHCiQIXFXmpFW58v1bKVTxE9iPBGlaM=;
 b=pPHEEwQuO6S0yjxFQ1gOGINfAQBxJppOLxrMwQeE0drSeOs4mk9RhrSZWoUThb3QqQJ+
 shXDp+T3KZojQPq4+jBPE0YBRyM206O9QMqMlgPsnUZx5MyFXUMPDUfYmC9aR51DidQq
 1RcXeogoPYjrkZrcHzN6ijWBOI8gSPcP8x77auPE62OX0hf9ajtfEWqBPTFkB/DucM6h
 vKlH7X7E/znaoc14XMyyxDOt1RLoLfU3cw7InMzaLVVG4Tu2+7QJHO5555qu/BmCtsVW
 Fq0+FzET3EpUr6fYhGX1siRhIeeK8F+thohketkq+rdPPTyadc31JNhe9GqYNmph6iiA Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxapc7s4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 15:37:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C7B210003E;
        Wed,  5 Oct 2022 15:37:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5805A22A6C4;
        Wed,  5 Oct 2022 15:37:09 +0200 (CEST)
Received: from localhost (10.75.127.118) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 5 Oct
 2022 15:37:09 +0200
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
Subject: [PATCH v2 8/8] ARM: dts: stm32: add adc support on stm32mp135f-dk
Date:   Wed, 5 Oct 2022 15:31:20 +0200
Message-ID: <20221005133120.50483-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005133120.50483-1-olivier.moysan@foss.st.com>
References: <20221005133120.50483-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Configure ADC support on stm32mp135f-dk. ADC can be used for
USB Type-C CC1 & CC2 pins wired to in6 & in12.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index 95068231ed57..5b7630a2452e 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -76,6 +76,32 @@ vdd_adc: vdd-adc {
 	};
 };
 
+&adc_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc1_usb_cc_pins_a>;
+	vdda-supply = <&vdd_adc>;
+	vref-supply = <&vdd_adc>;
+	status = "okay";
+
+	adc1: adc@0 {
+		status = "okay";
+		/*
+		 * Type-C USB_PWR_CC1 & USB_PWR_CC2 on in6 & in12.
+		 * Use at least 5 * RC time, e.g. 5 * (Rp + Rd) * C:
+		 * 5 * (5.1 + 47kOhms) * 5pF => 1.3us.
+		 * Use arbitrary margin here (e.g. 5us).
+		 */
+		channel@6 {
+			reg = <6>;
+			st,min-sample-time-ns = <5000>;
+		};
+		channel@12 {
+			reg = <12>;
+			st,min-sample-time-ns = <5000>;
+		};
+	};
+};
+
 &iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
-- 
2.25.1

