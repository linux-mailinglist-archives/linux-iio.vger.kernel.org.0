Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9224D5E1B0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGCKJB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 06:09:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43442 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfGCKJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 06:09:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63A73hP017468;
        Wed, 3 Jul 2019 12:08:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=p8aelPu0ml7yIy5BgbpgQ7yP/tD7IVrIHl6DxHuKiZ4=;
 b=tlFQE1OF+dfIEYXfZ8AHDmZT0ZWLF9GojP0qwXzAKpq07NOzrXRSDQ/+eS+Oo61fBGf8
 EBTYg2KaLjv+kJK/EPKoIBsnVTb+Eekdlt70/zCJqzh0FrY4Rsuch92bpRTa5Qi5a58P
 5Rrp+ur3ujiTgHaRd74VsuhsQv4U3oIHVyHQmPRbefWYRTKP0bvQz+f7XLOgB5mDK8zl
 B/1PDeype/7U7AEvSu2PZ+wMQgR9L6kq+hmVFDtcioNcJxsoRA8tlsVNibzZoi1A+T/F
 PF1FScSjNdq7yXgBeMK2upMQnX+JvjiSgr7PgtEiBVLNalCiWEHIBg8fMpvt51HnQGmO Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwf12pxx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Jul 2019 12:08:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDD1A34;
        Wed,  3 Jul 2019 10:08:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0314267F;
        Wed,  3 Jul 2019 10:08:24 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 12:08:24 +0200
Received: from localhost (10.48.0.167) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019 12:08:24 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: stm32: add analog switches supply control
Date:   Wed, 3 Jul 2019 12:08:14 +0200
Message-ID: <1562148496-26789-2-git-send-email-fabrice.gasnier@st.com>
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

On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
switches which have reduced performances when their supply is below 2.7V
(vdda by default). Booster or vdd can be used, to get full ADC
performances.

Add documentation for:
- optional booster-supply that can be used on stm32h7 and stm32mp1.
- optional vdd-supply that can be used on stm32mp1 to supply analog
  circuitry, selected by syscfg.
Mark these as optional, since this is a trade-off between analog
performance and power consumption.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Rework since: "Add missing vdda-supply to STM32 ADC" series.
- Add booster-supply regulator description
- typo: input switches
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 93a0bd2..4c0da8c 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -47,6 +47,12 @@ Required properties:
 Optional properties:
 - A pinctrl state named "default" for each ADC channel may be defined to set
   inX ADC pins in mode of operation for analog input on external pin.
+- booster-supply: Phandle to the embedded booster regulator that can be used
+  to supply ADC analog input switches on stm32h7 and stm32mp1.
+- vdd-supply: Phandle to the vdd input voltage. It can be used to supply ADC
+  analog input switches on stm32mp1.
+- st,syscfg: Phandle to system configuration controller. It can be used to
+  control the analog circuitry on stm32mp1.
 
 Contents of a stm32 adc child node:
 -----------------------------------
-- 
2.7.4

