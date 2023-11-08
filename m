Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC24B7E5CAA
	for <lists+linux-iio@lfdr.de>; Wed,  8 Nov 2023 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjKHRuk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Nov 2023 12:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHRui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Nov 2023 12:50:38 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFE51FFC;
        Wed,  8 Nov 2023 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gxLhFOfaf1pBt6EdevdiTRtiTB0fk8enVXm+fNYd8XY=; b=pFqoV2q/qAeNzl3DENifMTZMOR
        Rxg2m7xChyMn1ARE4cociyUxlYuYciPlItI2QH53PHMwLXMV+Dvr9k2bHA5VLNsqqwNl5C9dDVxUp
        HhzUfToTw109omrwRjUV9HkAQf7Rk6iH3u7KPONZgu+ukEar9qhHJsNKMTDoYuPhZ3F153o/9D65K
        sA3G4ua7fJAi7e9lnEftJiVBCFoS/PcYqKl+c81FvF45bQ39LSmAhYH8qaPMrFLlENAheH4okzldZ
        a+zPNqzkn7AjSO4nb5sv6A/y7048p6XZL93IlBSkfNdEQ+ai3L6JA//eFQh40LsxH1MQocP7AGXhr
        WXdIyo/Q==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1r0mhC-000vX4-Or; Wed, 08 Nov 2023 18:50:30 +0100
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 08 Nov 2023 18:50:25 +0100
Subject: [PATCH v3 1/6] dt-bindings: iio: adc: add smb139x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-nia-sm8350-for-upstream-v3-1-18a024b5c74c@igalia.com>
References: <20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com>
In-Reply-To: <20231108-nia-sm8350-for-upstream-v3-0-18a024b5c74c@igalia.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=nespera@igalia.com;
 h=from:subject:message-id; bh=Un/OwvHNh/M32hgzpr9ovGZiU8KNqRoeKJIliCD2flE=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlS8pk6cbPCmRUyR1JW9CmswvDwQTXLUq/j8Vlo
 Yt8x4r5pjiJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZUvKZAAKCRDyJM7CN1bi
 rbbwC/0Q+bU1A8fLUjD9Rr7foTm6LKHC0EijfuyB/swRuplTAbweHHSgHDJ4xtB1jenwGSACzsR
 bOYoyWSirWlzItnuemKixi8Zdxh9kJJwVtBXDF3U+bWsyMccAdHcLErnihPM5E5FsgTk7KI9I6A
 AmA6NTYdoj9Za07Akltv2f/Fn87kdL7BUD6xBQ7gUhWE5sBtcZD73Kb/0dVE8P5CUCro54O/1YF
 i+2j6kG9h9eMKWQiQAR1N75kCgjB5pdkldTYXP1tiy+WO5O+QK6Zgwv7Smb5tN+SdpQF7pA+PI6
 A1UOJAv6MaWcBnm853UVJolxoPbMgO1O1AFiCr74wN/P2mX253seswz0LTYSCbSQewr9O4gd8tK
 4qKdMYeI175oCeb3vr+ytXR9hJf1w+tmDZ6XfjpITUbqOek5mEsZScd4S6jQYG3NEdC7lX1oKsK
 g6n3s3pqEc1khxggcu7TDr42rcJonf+xBa2rC5TK1cTCEvtavxqfXVYFRUM2CEtehRBoQ=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bindings for a charger controller chip found on sm8350

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h | 19 +++++++++++++++++++
 include/dt-bindings/iio/qcom,spmi-vadc.h         |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
new file mode 100644
index 000000000000..c0680d1285cf
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+
+#define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
+#define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
+#define SMB139x_1_ADC7_IIN_SMB			(SMB139x_1_SID << 8 | ADC7_IIN_SMB)
+
+#define SMB139x_2_ADC7_SMB_TEMP			(SMB139x_2_SID << 8 | ADC7_SMB_TEMP)
+#define SMB139x_2_ADC7_ICHG_SMB			(SMB139x_2_SID << 8 | ADC7_ICHG_SMB)
+#define SMB139x_2_ADC7_IIN_SMB			(SMB139x_2_SID << 8 | ADC7_IIN_SMB)
+
+#endif
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 08adfe25964c..ef07ecd4d585 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -239,12 +239,15 @@
 #define ADC7_GPIO3				0x0c
 #define ADC7_GPIO4				0x0d
 
+#define ADC7_SMB_TEMP				0x06
 #define ADC7_CHG_TEMP				0x10
 #define ADC7_USB_IN_V_16			0x11
 #define ADC7_VDC_16				0x12
 #define ADC7_CC1_ID				0x13
 #define ADC7_VREF_BAT_THERM			0x15
 #define ADC7_IIN_FB				0x17
+#define ADC7_ICHG_SMB				0x18
+#define ADC7_IIN_SMB				0x19
 
 /* 30k pull-up1 */
 #define ADC7_AMUX_THM1_30K_PU			0x24

-- 
2.42.1

