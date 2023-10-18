Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAD7CDFA9
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjJRO12 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 10:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjJRO1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 10:27:18 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30945FCD;
        Wed, 18 Oct 2023 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ph2HNOFu6ShT/rsQc1S8mJc4ao2RB+pOWhhItYG94CA=; b=izcoy8tUBmg/QK99GwKWwCm4Qm
        YcHFLacurcJOQiVaUysS4yAfdrJaMMP1WUauMnerkKvA8PRrkFUuA2ItZ/wRqzk6DPYP2BpjjIM7x
        X5csqa05XfHgZCQNZ2QS+iIrKVEXM6DvlCuwhMD0Ukab1az3VMwihx3A/T6L5USSeSHUrZLwbVGku
        djpMhmc7P1/E6L7svpcQtocpwk936IC+wQJBpGZzD8O5DzIluuaHTfUo+2VhAzzj82rHfrHTWTI59
        cMStre1l8HIvmtgyBRAiojWek/tBdJGi8Kez6ZhfcRmW9RWeOB/HqMLP1O1Lx+N4cyIqyMrH4YKuN
        0AYmsBJQ==;
Received: from [145.18.212.154]
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qt7Ug-001paE-5j; Wed, 18 Oct 2023 16:25:54 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Wed, 18 Oct 2023 16:25:12 +0200
Subject: [PATCH v2 1/6] iio: adc: add smb139x bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-nia-sm8350-for-upstream-v2-1-7b243126cb77@igalia.com>
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
In-Reply-To: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=nespera@igalia.com;
 h=from:subject:message-id; bh=qG/+w4/iwYleK9lDCuoPvHI0i6EeZNXt2CWHfVYC5c0=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlL+rqJuSbDKfiY/R6SZflVGRIoe+Z+PqwbXbzQ
 WyCJiTPJTCJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS/q6gAKCRDyJM7CN1bi
 rQ9HDACRU1jabHMEKiuLMV8c4+bWhzgmD/X2smF3BFmviw4oDoyIJrjvKkXxQvMXYXdTIgSdQ/B
 E4PSh0yimlWIH4ZBRQEAVUfwROiWmxxmtPrx6sVxax/g8dedaNR2aJaIVccA/BuZK30pY7Olh0n
 9BHC9oSPSASM0xxhBprci+FszxXVHXgb/qrWws2aAOIxPrZESoKBBdDc7jDEOo1lnAwm+nqmYOE
 i8s0grSc40NJ7kOdNgj/ajX0Y8eqEGEALXjm7/CbtUwoxPND+UA/8UHLNKBXQSpWXyQ0EzxzSlV
 JPG9SC0XXdacfOodwgj3NCMjCi5qcPl7Zl1eIKxRziTtemRYz6Pb2P7rt1Pp/z54ytdnvCW9+gI
 hGWYFeTK17nzqr27/dce/28IAOzI/PaBNUfgBblnjSGfEHZmQOY8jSU8OgA6n/HZQmKj1TyoYSz
 6hJQacdvY0pzWKQBYrpK3eVVRjrqP9A/GZ8jxq6o7AlDVIuw0fvB8crxVBoZrC75v2g+Q=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.42.0

