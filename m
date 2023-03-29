Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57F6CCE85
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjC2AIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC2AIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC71720
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x17so18010678lfu.5
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb2W4/4EVDefi48oTiv8C33/IEUZH8vy8TmHypAWaU0=;
        b=D71zo6wc4l+f3y+gZFLoh2BHM3UeR5RrRclnzPDfjITLARSO2qDFzcNKecrvd5WziC
         iXlQ75kL0eB7p19rmmV5xdPoaQtFuS7omVImgOINtJZA1akomM7qrBvnqvz1uRFZc/sy
         UzA6gzpC7RfQnGoR3yTKWhNrQjc4NQi0rJBoXSHgg481S6FH/1t2PgcKDS80gmp2bz7j
         Qcx8gtyK87KBdsc64Tu2/V8tGsNgymwLp4KApJd8PSxOPXXMdTsq1nxeSkE/phFhxp6v
         sMyz+m1vufjwiasaF5XdxMA2FzzFvuEP4Y2inps2o/3en3TO8tz/OIl2hYDDTrv/nWAE
         iJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yb2W4/4EVDefi48oTiv8C33/IEUZH8vy8TmHypAWaU0=;
        b=VrZxyvQQqaEyinvZYLLA2ifx5vzIlYIOwlLgn+CJzYMJSM2JOSYi55qKBx/C9SSsVa
         cquQ+ognl6/gKd+udDBLEFyZaP+ruOyTcm5QVCRv/LUTByyEYY383gZhNW0BkoU8tA3p
         uk9KA57vuSn68MOMedcTjQ06HKP9lodS/AJCaZa8km9bSOrLmRmk4eKRsl55qBua3npB
         fpDbJqlvV6cOGdHXrtbdB2CGekcogbD6Pi4EA2g+USMMkPtdAnB01cxQtl1nXhODVwlZ
         m3Nw58prxmEwQcgmfncl39Id06+LT7jG/wHCvTqtwqObwsJYaE3miCuudHUT5Yqkhpiu
         xtCA==
X-Gm-Message-State: AAQBX9ctVwsimgdizd0HZoTQ+GVZMqQu/pMTeE7myzRke12hoQRjKihq
        8ER9ZwLJhpI0bB5wZYaVYsSPQQ==
X-Google-Smtp-Source: AKy350aIBr3rqQlvliAiN1jzYp9HDRfFkHjmDGfP3F28pzFbbMrEgI/1JAySKwo5byJNqLNGQ9Q0lQ==
X-Received: by 2002:a05:6512:143:b0:4e9:9f10:b31d with SMTP id m3-20020a056512014300b004e99f10b31dmr5449561lfo.2.1680048517481;
        Tue, 28 Mar 2023 17:08:37 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: qcom: pmk8350: rename pon label
Date:   Wed, 29 Mar 2023 03:08:29 +0300
Message-Id: <20230329000833.2507594-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To reduce a possibility of the conflicts, rename pmk8350's pon_pwrkey
and pon_resin to contain the PMIC name too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi                   | 4 ++--
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts                 | 8 ++++----
 arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi | 8 ++++----
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index f26fb7d32faf..455ffffb5f5c 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -25,14 +25,14 @@ pmk8350_pon: pon@1300 {
 			reg = <0x1300>, <0x800>;
 			reg-names = "hlos", "pbs";
 
-			pon_pwrkey: pwrkey {
+			pmk8350_pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
 				interrupts = <PMK8350_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
-			pon_resin: resin {
+			pmk8350_pon_resin: resin {
 				compatible = "qcom,pmk8350-resin";
 				interrupts = <PMK8350_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
index d21d2aacf201..152601832cbc 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
@@ -285,17 +285,17 @@ &mpss {
 	firmware-name = "qcom/sm8350/modem.mbn";
 };
 
-&pmk8350_rtc {
+&pmk8350_pon_pwrkey {
 	status = "okay";
 };
 
-&pon_pwrkey {
+&pmk8350_pon_resin {
 	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
 };
 
-&pon_resin {
+&pmk8350_rtc {
 	status = "okay";
-	linux,code = <KEY_VOLUMEDOWN>;
 };
 
 &qupv3_id_0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 89382ad73133..e28f49e31b9f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -618,17 +618,17 @@ vol_down_n: vol-down-n-state {
 	};
 };
 
-&pmk8350_rtc {
+&pmk8350_pon_pwrkey {
 	status = "okay";
 };
 
-&pon_pwrkey {
+&pmk8350_pon_resin {
 	status = "okay";
+	linux,code = <KEY_VOLUMEUP>;
 };
 
-&pon_resin {
+&pmk8350_rtc {
 	status = "okay";
-	linux,code = <KEY_VOLUMEUP>;
 };
 
 &qupv3_id_0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 67538b5a557e..99e9b776b93d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -684,11 +684,11 @@ &pmk8350_gpios {
 			  "PMK8350_OPTION";
 };
 
-&pon_pwrkey {
+&pmk8350_pon_pwrkey {
 	status = "okay";
 };
 
-&pon_resin {
+&pmk8350_pon_resin {
 	linux,code = <KEY_VOLUMEUP>;
 	status = "okay";
 };
-- 
2.30.2

