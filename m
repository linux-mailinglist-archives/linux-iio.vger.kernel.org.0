Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF36D3491
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDAWIV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjDAWIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3394827813
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so6591084ljr.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo7hNFgWkmnMOkJb7IUde00I0wylcKYMGhkL0Te7EUM=;
        b=SH+EbcUlX4yL03lNwa4vuXBYV37S+JaguNgM4CWXCzaodw49NgcKRERthNX8HgTzE9
         WJVIDOAG2U3NgYVm4gA0WAmQvpPcM9HZ3fcwBSuOU1ogH9/4DPcdxTUHVd8bncop2rft
         WpN88qD9XPZz7ocoQQGYE7wxTuuhSxS3UD3d4fwliaiikxL9U+0BOJbaBblHY4eQaWUi
         MbrZ/ZJ0NB97C4RMlJWWiISDRckPLqowcHD7/DiS4/vMoHhglfo6+tLUk+hOWmXederL
         LuK+OAh31toQhdA3qPRTwDx8bP143+EIoWOsKk3kPLNvyTlW5Q3rhywwhZlPmzNBEKf4
         hcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo7hNFgWkmnMOkJb7IUde00I0wylcKYMGhkL0Te7EUM=;
        b=DeB7C5eEWF9fLn4TKqYVvM+PpKigxNOsX3xcxSg1Am1Hqp6VqN3qDWFkUAOZWITO0X
         Y59deY10fYZb+Es+ve05dbWfzxtkbSyk8ViS2J5MYyXW8pnIVejljStP8mhiJ2Ri1iBE
         nLy0bKRRBdFROhz81MP5vP1etlb/F1YelUpS7l0PkEbLs+cmBUOy1Qfa0Jj+/ziJDyyz
         XZ9usNyDYQmPHUpMZIAi/9J7SaZuwGhEKY69K8BdMpQsMMxwFo4vOl5W7pQMTarxijbH
         JQpRDvjhewz/SXSttem6cV/og+qdXFco3uqIt+C2wqMNRIsV1vDkNz5zP3Jamhgt3mMa
         0tDg==
X-Gm-Message-State: AAQBX9eBwzBiqY+ihkZOhwNHeq0nk54AU2TLW3xTzdu7DY20itGlb5lD
        cv0zPB4+6CPF2YByQMi+ozX8SA==
X-Google-Smtp-Source: AKy350ZsWyAGhQPrVhlRvpsC6hpOup3F5JMBatVQQTkgFICDuU3e6rzjpfCJlvPcsMxpArvm7ghfLQ==
X-Received: by 2002:a2e:b0d3:0:b0:2a2:e84c:bff9 with SMTP id g19-20020a2eb0d3000000b002a2e84cbff9mr9128136ljl.29.1680386895307;
        Sat, 01 Apr 2023 15:08:15 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 06/22] arm64: dts: qcom: pmk8350: rename pon label
Date:   Sun,  2 Apr 2023 01:07:54 +0300
Message-Id: <20230401220810.3563708-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

