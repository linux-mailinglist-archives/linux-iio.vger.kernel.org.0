Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F47CA860
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJPMrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJPMrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 08:47:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE15F5;
        Mon, 16 Oct 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PJALcNBz9ImCFUk6lytLPYTwt4DBsHnDsm7gSz1x8lo=; b=ff3G7CT6bnQycp0nllKxCQQDhD
        zeSvojJucET6lcblBDwzfvLHu3iWKjSLvwEQYdTY3IWhOcYXe6JkIlmgz50IJ/QoAghxE2FRD8g2u
        W8osi/fZoZwcV3GSP12kypy6EfNmCda56Im0EAFNfYMawfpSXazqeSeoZoN5i2H1wcjb1xXoQX4W+
        xp3mWJndP8nIFjLcNHKXQRQcmlMTb2+nuz6shzg+/bWm0trpuUSob0pyUXvGG9OzNnpOh4e41F0v7
        enNWAejnwCwmhUN2qRg4fHB5t97+T6K+119V1JM1v40DDTJK2tozppe6pzU+zh2JU7w+TsmcT0cr0
        U+EeXRYw==;
Received: from re-byods-146-50-198-227.wireless.uva.nl ([146.50.198.227])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsN02-0013kp-Ah; Mon, 16 Oct 2023 14:47:10 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Mon, 16 Oct 2023 14:47:01 +0200
Subject: [PATCH 1/5] iio: adc: add smb139x bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-nia-sm8350-for-upstream-v1-1-bb557a0af2e9@igalia.com>
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nia Espera <nespera@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=nespera@igalia.com;
 h=from:subject:message-id; bh=JHRfmZAZO9Oy7nubEEb+3rg3Tspx6ftNhCKm1jVHvjY=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlLTDMffV0GpejRx7QmlbEg2PlwXRVuPTe6tPP8
 xqD1HE7EEmJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS0wzAAKCRDyJM7CN1bi
 rTsWC/0XeieJo2IcVNzUcx9Jsfe9cTj9Up0k1WgcjRrpMwX3+DYKzDOLW1vEeoz/tAasmpNODWT
 9EGUTEsIzLwb7BNuR8VyNfR7ynOcXKb+2uB5FRzHTAirulWrTebIcIv27mQy5LDxtLdBK6U5PNv
 cONwZgTu/w+I++iBvdsq0wVxsKSiP2umK05khO6WWVrc09sVrhvv+yhL9R5VcNP2aHaMzKVFIFv
 7gcxaT5Hb3CJkEgCE0rEa2VsD/0ROVB8F0EOjrhXgZ13jMWH9SEPB3Y6mSRsqz+iGMOxu+hDAcz
 03+yxQruoE0eLyxxts26bAthoZ1PcA5UjWzPGFLw3p9e46KOxtCVo1wGcFoxiS0fIApZwjg+UdA
 oARxtd6LgeliRR1E0JxgHEv95LrAWt9yQDkZY6XePf3M/PZGsG0jkh6b6GhnwRplMW9jOQ+bvGM
 nKMhn1HTb0imE0G/upd7QG0K5XMkQBbd4+760su63q955yRqObKsuQYxwiTvCPdqoLBeM=
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
 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
new file mode 100644
index 000000000000..fe163cd8bbdd
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
+
+#define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | 0x06)
+#define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | 0x18)
+#define SMB139x_1_ADC7_IIN_SMB			(SMB139x_1_SID << 8 | 0x19)
+
+#define SMB139x_2_ADC7_SMB_TEMP			(SMB139x_2_SID << 8 | 0x06)
+#define SMB139x_2_ADC7_ICHG_SMB			(SMB139x_2_SID << 8 | 0x18)
+#define SMB139x_2_ADC7_IIN_SMB			(SMB139x_2_SID << 8 | 0x19)
+
+#endif

-- 
2.42.0

