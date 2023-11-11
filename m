Return-Path: <linux-iio+bounces-36-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F827E8D01
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C971F20FB6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5C1DFCC;
	Sat, 11 Nov 2023 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="plZEO0nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C21DDE4;
	Sat, 11 Nov 2023 22:08:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E830CF;
	Sat, 11 Nov 2023 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0FnQWakSPg4nYy3Teh/drN7a+ELrDLt7yDP/ieSx0xk=; b=plZEO0nuv8guOgGV0ZDzoSczpD
	5KsOw7NoQWSL8OS8bcfSq/TdSS901r3pUh/o4pO/YUMEb5CTjL3w9WtcA1x56ZWtzM8VxOMh8I1wB
	dpSmqJlgaM8XTxFmRQReDlCEViWoH927/fy4A5q3KnSmq77r/xCmly0cUjmTNJPOmhapJmuoqfNko
	I8PH1xEsDnSwjEuyf9DcS7tAWZnuw7J2gALhxhm20P6u9d/5n3rhvLqMVyHPp0PbMJwiJBQ+VyHAJ
	ulDnSopJTvUrbBGGJ8N/19vVDRyWK0peFtW9LPqLVmxacCDXCzc3E6hBQGu4sEWxORRlvmYa6d/7b
	fkQ2W93Q==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w8x-0029Vw-Fu; Sat, 11 Nov 2023 23:07:55 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:39 +0100
Subject: [PATCH v4 1/6] dt-bindings: iio: adc: qcom: Add Qualcomm smb139x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-1-3a638b02eea5@igalia.com>
References: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
In-Reply-To: <20231111-nia-sm8350-for-upstream-v4-0-3a638b02eea5@igalia.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Vinod Koul <vkoul@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org, Rob <Me@orbit.sh>, 
 Clayton Craft <clayton@igalia.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=nespera@igalia.com;
 h=from:subject:message-id; bh=nMbq87CC7U3RIvZk08BBsAHFxYSfy0wnGy13+obJXzk=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s4/HElzVppL8OUeyoZWnIDoEnJQ6uTMSlzR
 eorOUqPLJmJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OAAKCRDyJM7CN1bi
 rbv0DACHQeCWkK6M5BGY3yc5GS9aVseGX0EqgqNPyK2Zf8dbZvRJXguCZizNC71vrEosNP2crJs
 jZZequ4I9iyFz1zXvL9QQUH8P8OatViBHigGy19rKEG7N75ISBVA4BxBUOOSGh0tM0yof5EuJnS
 I29G5OJz01aYXVsraJxkEJRGbFPVuQ4x9qQYt1LPvzfHV8cKwjynpwdxrvG8QAHNJESfYFqy0PO
 182rT/qswtQO3iFR+5ptYtkg+ZgIjZQvrmN5EDNyL2r5PK99D/EnGwIEJzrA0bcYIHwJ2grb+PA
 +NEhQ5zb7M/hy2+z1NoKCrAHwb75ftPM/wfjCSmeuTQOhmBs/qCYutCCAksYT5uAT25ppbRfbrl
 K7P3mqJwf95oCIVTzn6rNdg2A+iL0RSR9fo0w6siTRGMFThBMuzjox8bC3SxF9livTtErIVr9Z4
 pAG9m6/mNJ4xPRU1/mc0aqyP+fRF9Kyp51neUJSeFvMDGkQ3Y9xQobg4wGaPcDfA79tNQ=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

Bindings for a charger controller chip found on sm8350

Signed-off-by: Nia Espera <nespera@igalia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


