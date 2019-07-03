Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161615E1AD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGCKJA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 06:09:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39001 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfGCKJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 06:09:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63A7AcQ000447;
        Wed, 3 Jul 2019 12:08:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=1NiytyZtbe2w78owFmWQReZMxpYCSle8r9BwAyo8NUs=;
 b=yI6XGwYP6EcjJQPOVI9Y2TYUS/I7xAO6k6feP5QxjNyQJQvYnIHg/f4hgXrQ2AUY8fhi
 OeL26YPVyd0IWTzH7wknXKqa1S20gk5gGo43u6GRsUSVqsgt8lRaFEEYzJS1Xw8+QW4H
 wiaeb9BhP6xLI7rsB7U/KRBnhbNXCGX0WJ9IcHhX1xZ4hE9bY2DdrL4KMi/7zD62/jCA
 rz8J56hsmT/32Ld3eoRID/GifvUJaTsOXhn3qPfY8qZXcnr/3mVTIcawmgibT75Cyros
 bpVwLwG4XgQB6xriJo+afTXo/Su2HaQ5xviTeG/dFw2og/11lSY3xk3ggtcYWSjZtgFC 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwrv2j5s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Jul 2019 12:08:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25EBB38;
        Wed,  3 Jul 2019 10:08:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07A3A267F;
        Wed,  3 Jul 2019 10:08:27 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 12:08:26 +0200
Received: from localhost (10.48.0.167) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019 12:08:26 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] ARM: dts: stm32: add syscfg to ADC on stm32mp157c
Date:   Wed, 3 Jul 2019 12:08:16 +0200
Message-ID: <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.167]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On stm32mp157c, the ADC inputs are multiplexed with analog switches which
have reduced performances when their supply is below 2.7V (vdda by
default).
Add syscfg registers that can be used on stm32mp157c, to get full ADC
analog performances.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2dd5162..b9a5b58 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -862,6 +862,7 @@
 			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
 			clock-names = "bus", "adc";
 			interrupt-controller;
+			st,syscfg = <&syscfg>;
 			#interrupt-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4

