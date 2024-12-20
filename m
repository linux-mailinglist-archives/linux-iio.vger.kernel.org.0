Return-Path: <linux-iio+bounces-13708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FAC9F8FB4
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B354816AFEE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E2A1C5CD7;
	Fri, 20 Dec 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Q+sHuRRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6411C5CC2;
	Fri, 20 Dec 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688964; cv=none; b=p+C5+pt8AX/Ql8uImBflj968i0NDM1KLUD9Y4OwVjBnqoin1AHpPnYY99zor8lu6wlk5H102k60ZQ/yKVFh8c6LJFROWnf206r2rvS0Clb6F8Q/4Zqgr7vB/NM8K75fnHaj8fchiqgLZVQ4cTEfatQGbh+lud6JQoT1P2NoFnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688964; c=relaxed/simple;
	bh=i5781SrdTzv0z1hkaCd04HLCgm/icH0mX8fAl8lXIjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoIrpH33uSbkJJ1k2YPsDMeSHJMHbTWHjVjt4wUCTLNcjRFJj9ZUJPuS9OR0+7mpr96iev28cL1ir/7tPE21qbHhtGFuHxADv6jnkqtn2oLF6qJ56LY9MJBHJ5S/SHMfcJXWqaAC04JGsrkPcWY8n72TmQx9OROvdtrEyLZoTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Q+sHuRRL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK89Gt9001238;
	Fri, 20 Dec 2024 11:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+82biZaVNxLrPwnRt+Mf4mhE6BomVWsuu3IFQ+UAqLo=; b=Q+sHuRRLd0gBCbuU
	n1eOSTmEA2KcttSk2jsnijNf4f1iHOUhHXACCupsq0A/2z9EbUG3EQYTRzILmb8j
	NTiW+1b/lsnf5HjpWLzx9I47Lckq5IBQeUXquvtMf4azvdDk28Op3+sd9P13m3DW
	Ui82BQ0ywUSY9ueiadZaa3gDHiaC95fT1556lA9PzNJ2lM+EWZli9O5RWpxfQGpI
	YSzI21Na5ueEIx1hy9uQOeBUeiA7KSTxtGvN7YKPfCXDXOIWA8J88fVw6AmsyYSx
	Mav/QD04nD5CpI844Kh9iYI9QqaXo/wzdLrhtKq4MWTlzoFucZ9/XjNI4hZQR2Nu
	+zOAgg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43n4d88pkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 11:02:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 02E9A40064;
	Fri, 20 Dec 2024 11:01:18 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E98EA257ABA;
	Fri, 20 Dec 2024 11:00:12 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:12 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 20 Dec
 2024 11:00:12 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alexandre.torgue@foss.st.com>,
        <wbg@kernel.org>, <jic23@kernel.org>, <ukleinek@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>
Subject: [PATCH v2 8/9] arm64: dts: st: add timer pins for stm32mp257f-ev1
Date: Fri, 20 Dec 2024 10:59:26 +0100
Message-ID: <20241220095927.1122782-9-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
References: <20241220095927.1122782-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add timer pins available on stm32mp257f-ev1, configured for PWM:
- timer3 CH2 is available on mikroBUS connector
- timer8 CH1, timer8 CH4, timer10 CH1 and timer12 CH2 are available
  on EXPANSION connector
Arbitrary define all these pins to be used as PWM (output) channels,
except for timer10 CH1, to be used as counter input.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 8fdd5f020425..bb9dc82d3dd5 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -82,6 +82,53 @@ pins {
 		};
 	};
 
+	pwm3_pins_a: pwm3-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 15, AF7)>; /* TIM3_CH2 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm3_sleep_pins_a: pwm3-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 15, ANALOG)>; /* TIM3_CH2 */
+		};
+	};
+
+	pwm8_pins_a: pwm8-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 5, AF8)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('J', 4, AF8)>; /* TIM8_CH4 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm8_sleep_pins_a: pwm8-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 5, ANALOG)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('J', 4, ANALOG)>; /* TIM8_CH4 */
+		};
+	};
+
+	pwm12_pins_a: pwm12-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 11, AF9)>; /* TIM12_CH2 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm12_sleep_pins_a: pwm12-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 11, ANALOG)>; /* TIM12_CH2 */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
@@ -158,6 +205,20 @@ pins1 {
 		};
 	};
 
+	tim10_counter_pins_a: tim10-counter-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, AF9)>; /* TIM10_CH1 */
+			bias-disable;
+		};
+	};
+
+	tim10_counter_sleep_pins_a: tim10-counter-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 9, ANALOG)>; /* TIM10_CH1 */
+			bias-disable;
+		};
+	};
+
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('A', 4, AF6)>; /* USART2_TX */
-- 
2.25.1


