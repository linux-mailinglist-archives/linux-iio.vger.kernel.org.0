Return-Path: <linux-iio+bounces-42-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9CF7E8D13
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D98F1C20757
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D66208DA;
	Sat, 11 Nov 2023 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bQn+8Tnr"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743B1DDE9;
	Sat, 11 Nov 2023 22:08:07 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5B385E;
	Sat, 11 Nov 2023 14:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wz3HwyUqfd1mxuHcvv13a4UKSRw3jBaVV9eZOvoT2io=; b=bQn+8TnrM3nmHFu7rjvyKe7uHr
	Fr3KpvZOpQZXT4FS5GqOi5AeLtFTJajR0em61yhlL1HBgatJQO/3ZSR8o6gvvEfngU2u35+PzGbic
	g7yuJl7Z3Xzx4hdqtHjbJcs+2z3sbkGVjppOoBn34Df8lPnA6ZAi0JNyPwyIecCpmYxo2CPgk3pPT
	ScB2F8RpdWTlWoeymAz3/4kTtMINZVj+yJvjDvtGLsbvw9xEX/0FAATEPcZQSgf9XRU34FlRklH+9
	ekYS99P6IdyuUeuoCKBc1+PQ3OFQOZfVyt4enaaowsC+XzqbVs8a5gbz8fspxsEsw9owWyWFvth6O
	N8A7dhLQ==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w93-0029Vw-OF; Sat, 11 Nov 2023 23:08:01 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:44 +0100
Subject: [PATCH v4 6/6] arm64: dts: qcom: sm8350-lemonade(p): New devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-6-3a638b02eea5@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=29763; i=nespera@igalia.com;
 h=from:subject:message-id; bh=ZsHnK6CMGPiV/02xPhu1rhdAGSnOtG5mpUOtnRaaw5g=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s5IvCawnvDc4sm3hmPQqD9D8c5v5qwKQ/v0
 xtYekL7VIqJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OQAKCRDyJM7CN1bi
 rThUC/9uOgzPHAvVoQNUpon75S7HEJTvp5dODj+amWUDB+SA18boD+aerEJtdORrDFnxxYS/j53
 vTj9RL97tyqr0HHvh5mwfE9fUuXhplVwxA+VEdICIgeZpnaDcD62vxZi9U6U3GwxXKREWb9EQ56
 vYMJCRkSepkpRmgBAwohKvUajOp1hCgtvvCi4ee9Cy4zJN+HlYqDZ7wXznfycRfqyqf1A2FP9L4
 H1JRvJ6KmL5CPaGLs3+Xs+DTTgAYUOvcX0SgvufZd9ICqQ5Po7suM/sn5Lc+bxGPaN/HpFulEgV
 fr434Aq4pu3DWFxtEnBuj3/76rZFJxazADzgmYHmgzxVZr7vGsYWb6q0EAnJNN+sQq0Hnq7Liw8
 3iVNaeNfn8TySsH4nEVn8mBdmf9YR2hE+uX7Q73vSGlHZzugeGhRwlg7fJLcMdWeFSq9Z7NWFm9
 tHDBsYzyZpCfGovPm9DLFZmX8OIKJ50Zy5UxryhfyvaN9n2Y5SWHETUL4lh8GETFB9Rgw=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

Device tree files for OnePlus 9 and 9 Pro. Details of supported features
mentioned in the cover letter for this patch series, but for
accessibility also repeated here:

- USB OTG
- UFS
- Framebuffer display
- Touchscreen (for lemonade)
- Power & volume down keys
- Battery reading
- Modem, IPA, and remoteproc bringup

Steps to get booting:

- Wipe dtbo partition
- Flash vbmeta with disabled verity bit
- Flash kernel and initfs to boot partition with CLI args pd_ignore_unused
and clk_ignore_unused as v1 bootimg
- Flash rootfs to some other partition (probably super or userdata)

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Nia Espera <nespera@igalia.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1086 ++++++++++++++++++++
 .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   85 ++
 .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   20 +
 4 files changed, 1193 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2cca20563a1d..369ad4721b29 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonade.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonadep.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
new file mode 100644
index 000000000000..942b58a142fd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
@@ -0,0 +1,1086 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Igalia S.L.
+ * Authors:
+ *	Nia Espera <nespera@igalia.com>
+ */
+
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
+#define SMB139x_1_SID 0x0b
+#define SMB139x_2_SID 0x0c
+#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8350.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350b.dtsi"
+#include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
+#include "pmr735a.dtsi"
+#include "pmr735b.dtsi"
+
+/ {
+	chassis-type = "handset";
+	interrupt-parent = <&intc>;
+
+	bat: battery {
+		compatible = "simple-battery";
+		device-chemistry = "lithium-ion";
+		voltage-min-design-microvolt = <3200000>;
+		energy-full-design-microwatt-hours = <15840000>;
+		charge-full-design-microamp-hours = <2225000>;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@e4d00000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0xe4d00000 0 0x2400000>;
+			width = <1080>;
+			height = <2412>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's
+			 * necessary due to unused clk cleanup & no panel
+			 * driver yet.
+			 */
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_down_n>;
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pmk8350_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				/* USB3 not working, so no port@1 */
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	display_panel_avdd: regulator-display {
+		compatible = "regulator-fixed";
+		regulator-name = "display_panel_avdd";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-enable-ramp-delay = <233>;
+
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&adsp {
+	firmware-name = "qcom/sm8350/OnePlus/lemonade/adsp.mbn";
+	status = "okay";
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+
+		vdd-l1-l4-supply = <&pm8350_s11>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_bob>;
+		vdd-l6-l9-l10-supply = <&pm8350_s11>;
+		vdd-l8-supply = <&pmr735a_s2>;
+
+		/*
+		 * ARC regulators:
+		 * S5 - mx.lvl
+		 * S6 - gfx.lvl
+		 * S9 - mxc.lvl
+		 */
+
+		pm8350_s10: smps10 {
+			regulator-name = "pm8350_s10";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_s11: smps11 {
+			regulator-name = "pm8350_s11";
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <1012000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_s12: smps12 {
+			regulator-name = "pm8350_s12";
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1360000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l1: ldo1 {
+			regulator-name = "pm8350_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l2: ldo2 {
+			regulator-name = "pm8350_l2";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l3: ldo3 {
+			regulator-name = "pm8350_l3";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* L4 - lmx.lvl (ARC) */
+
+		pm8350_l5: ldo5 {
+			regulator-name = "pm8350_l5";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l6: ldo6 {
+			regulator-name = "pm8350_l6";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350_l7: ldo7 {
+			regulator-name = "pm8350_l7";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* L8 - lcx.lvl (ARC) */
+
+		pm8350_l9: ldo9 {
+			regulator-name = "pm8350_l9";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l12-supply = <&pm8350c_s1>;
+		vdd-l2-l8-supply = <&pm8350c_s1>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&pm8350_s12>;
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		pm8350c_s1: smps1 {
+			regulator-name = "pm8350c_s1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1952000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* S2 - ebi.lvl (ARC) */
+
+		pm8350c_s3: smps3 {
+			regulator-name = "pm8350c_s3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/*
+		 * ARC regulators:
+		 * S4 - mss.lvl
+		 * S6 - cx.lvl
+		 * S8 - mmcx.lvl
+		 */
+
+		pm8350c_s10: smps10 {
+			regulator-name = "pm8350c_s10";
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l1: ldo1 {
+			regulator-name = "pm8350c_l1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l2: ldo2 {
+			regulator-name = "pm8350c_l2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l3: ldo3 {
+			regulator-name = "pm8350c_l3";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l4: ldo4 {
+			regulator-name = "pm8350c_l4";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l5: ldo5 {
+			regulator-name = "pm8350c_l5";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l6: ldo6 {
+			regulator-name = "pm8350c_l6";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l7: ldo7 {
+			regulator-name = "pm8350c_l7";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l8: ldo8 {
+			regulator-name = "pm8350c_l8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l9: ldo9 {
+			regulator-name = "pm8350c_l9";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l10: ldo10 {
+			regulator-name = "pm8350c_l10";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l11: ldo11 {
+			regulator-name = "pm8350c_l11";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l12: ldo12 {
+			regulator-name = "pm8350c_l12";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8350c_l13: ldo13 {
+			regulator-name = "pm8350c_l13";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3400000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+	};
+
+	/* pm8350b has one regulator here; unused for now */
+
+	regulators-2 {
+		compatible = "qcom,pmr735a-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+
+		vdd-l1-l2-supply = <&pmr735a_s2>;
+		vdd-l3-supply = <&pmr735a_s1>;
+		vdd-l4-supply = <&pm8350c_s1>;
+		vdd-l5-l6-supply = <&pm8350c_s1>;
+		vdd-l7-bob-supply = <&vreg_bob>;
+
+		pmr735a_s1: smps1 {
+			regulator-name = "pmr735a_s1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		pmr735a_s2: smps2 {
+			regulator-name = "pmr735a_s2";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		pmr735a_s3: smps3 {
+			regulator-name = "pmr735a_s3";
+			regulator-min-microvolt = <2208000>;
+			regulator-max-microvolt = <2352000>;
+		};
+
+		pmr735a_l1: ldo1 {
+			regulator-name = "pmr735a_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+		};
+
+		pmr735a_l2: ldo2 {
+			regulator-name = "pmr735a_l2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l3: ldo3 {
+			regulator-name = "pmr735a_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: ldo4 {
+			regulator-name = "pmr735a_l4";
+			regulator-min-microvolt = <1776000>;
+			regulator-max-microvolt = <1872000>;
+		};
+
+		pmr735a_l5: ldo5 {
+			regulator-name = "pmr735a_l5";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		pmr735a_l6: ldo6 {
+			regulator-name = "pmr735a_l6";
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <904000>;
+		};
+
+		pmr735a_l7: ldo7 {
+			regulator-name = "pmr735a_l7";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+	};
+};
+
+&cdsp {
+	firmware-name = "qcom/sm8350/OnePlus/lemonade/cdsp.mbn";
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	bq27541: fuel-gauge@55 {
+		compatible = "ti,bq27541";
+		reg = <0x55>;
+		monitored-battery = <&bat>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Touchscreens: Syna TCM oncell or Samsung s6sy761 */
+};
+
+&i2c13 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc-supply = <&vreg_bob>;
+		mode-switch;
+		orientation-switch;
+
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
+			};
+		};
+	};
+
+	/* Qualcomm PM8008i/PM8008j @ 8, 9, c, d */
+};
+
+&i2c15 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* sn-nci NFC controller @ 28 */
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&pil_ipa_fw_mem>;
+	firmware-name = "qcom/sm8350/OnePlus/lemonade/ipa_fws.mbn";
+	status = "okay";
+};
+
+&mpss {
+	firmware-name = "qcom/sm8350/OnePlus/lemonade/modem.mbn";
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&pm8350_l5>;
+	vdda-pll-supply = <&pm8350_l6>;
+
+	status = "okay";
+};
+
+&pm8350_gpios {
+	gpio1_adc_default: gpio1-adc-default-state {
+		pins = "gpio1";
+		function = "normal";
+		bias-high-impedance;
+		bias-disable;
+	};
+
+	gpio3_adc_default: gpio3-adc-default-state {
+		pins = "gpio3";
+		function = "normal";
+		bias-high-impedance;
+		bias-disable;
+	};
+
+	vol_down_n: vol-down-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pmk8350_adc_tm {
+	status = "okay";
+
+	pm8350-msm-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-cam-flash-therm@1 {
+		reg = <1>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-hot-pocket-therm@2 {
+		reg = <2>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-wide-rfc-therm@3 {
+		reg = <3>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-rear-tof-therm@4 {
+		reg = <4>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350b-usb-conn-therm@5 {
+		reg = <5>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_AMUX_THM4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350b-wl-chg-therm@6 {
+		reg = <6>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_GPIO2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pmk8350_rtc {
+	status = "okay";
+};
+
+&pmk8350_vadc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio1_adc_default>, <&gpio3_adc_default>;
+
+	/* pmk8350-ref-gnd */
+	channel@0 {
+		reg = <0x00>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmk8350_ref_gnd";
+	};
+
+	/* pmk8350-vref-1p25 */
+	channel@1 {
+		reg = <0x01>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmk8350_vref_1p25";
+	};
+
+	/* pmk8350-die-temp */
+	channel@3 {
+		reg = <0x03>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmk8350_die_temp";
+	};
+
+	/* pm8350-ref-gnd */
+	channel@100 {
+		reg = <0x100>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_ref_gnd";
+	};
+
+	/*pm8350-vref-1p25*/
+	channel@101 {
+		reg = <0x101>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_vref_1p25";
+	};
+
+	/* pm8350-die-temp */
+	channel@103 {
+		reg = <0x103>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_die_temp";
+	};
+
+	/* gpio1-v */
+	channel@128 {
+		reg = <0x128>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <700>;
+		qcom,pre-scaling = <1 1>;
+		label = "gpio1_v";
+	};
+
+	/* gpio3-v */
+	channel@12b {
+		reg = <0x12b>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <700>;
+		qcom,pre-scaling = <1 1>;
+		label = "gpio3_v";
+	};
+
+	/* pm8350-msm-therm */
+	channel@144 {
+		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_msm_therm";
+	};
+
+	/* pm8350-cam-flash-therm */
+	channel@145 {
+		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_cam_flash_therm";
+	};
+
+	/* pm8350-hot-pocket-therm */
+	channel@146 {
+		reg = <PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_hot_pocket_therm";
+	};
+
+	/* pm8350-wide-rfc-therm */
+	channel@147 {
+		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_wide_rfc_therm";
+	};
+
+	/* pm8350-rear-tof-therm */
+	channel@148 {
+		reg = <PM8350_ADC7_AMUX_THM5_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_rear_tof_therm";
+	};
+
+	/* pm8350-vph-pwr */
+	channel@18e {
+		reg = <0x18e>;
+		qcom,pre-scaling = <1 3>;
+		label = "pm8350_vph_pwr";
+	};
+
+	/* pm8350b-ref-gnd */
+	channel@300 {
+		reg = <0x300>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_ref_gnd";
+	};
+
+	/* pm8350b-vref-1p25 */
+	channel@301 {
+		reg = <0x301>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_vref_1p25";
+	};
+
+	/* pm8350b-die-temp */
+	channel@303 {
+		reg = <0x303>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_die_temp";
+	};
+
+	/* pm8350b-chg-temp */
+	channel@310 {
+		reg = <PM8350B_ADC7_CHG_TEMP>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_chg_temp";
+	};
+
+	/* pm8350b-usb-conn-therm */
+	channel@347 {
+		reg = <PM8350B_ADC7_AMUX_THM4_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_usb_conn_therm";
+	};
+
+	/* pm8350b-wl-chg-therm */
+	channel@34b {
+		reg = <PM8350B_ADC7_GPIO2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_wl_chg_therm";
+	};
+
+	/* pm8350b-vph-pwr */
+	channel@38e {
+		reg = <0x38e>;
+		qcom,pre-scaling = <1 3>;
+		label = "pm8350b_vph_pwr";
+	};
+
+	/* pm8350b-vbat-sns */
+	channel@38f {
+		reg = <0x38f>;
+		qcom,pre-scaling = <1 3>;
+		label = "pm8350b_vbat_sns";
+	};
+
+	/* pmr735a-ref-gnd */
+	channel@400 {
+		reg = <0x400>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735a_ref_gnd";
+	};
+
+	/* pmr735a-vref-1p25 */
+	channel@401 {
+		reg = <0x401>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735a_vref_1p25";
+	};
+
+	/* pmr735a-die-temp */
+	channel@403 {
+		reg = <0x403>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735a_die_temp";
+	};
+
+	/* pmr735b-ref-gnd */
+	channel@500 {
+		reg = <0x500>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735b_ref_gnd";
+	};
+
+	/* pmr735b-vref-1p25 */
+	channel@501 {
+		reg = <0x501>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735b_vref_1p25";
+	};
+
+	/* pmr735b-die-temp */
+	channel@503 {
+		reg = <0x503>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735b_die_temp";
+	};
+
+	/* smb139x-1-smb-temp */
+	channel@b06 {
+		reg = <SMB139x_1_ADC7_SMB_TEMP>;
+		qcom,pre-scaling = <1 1>;
+		label = "smb139x_1_smb_temp";
+	};
+
+	/* smb139x-2-smb-temp */
+	channel@c06 {
+		reg = <SMB139x_2_ADC7_SMB_TEMP>;
+		qcom,pre-scaling = <1 1>;
+		label = "smb139x_2_smb_temp";
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&reserved_memory {
+	bootloader-log@9fff7000 {
+		reg = <0 0x9fff7000 0 0x8000>;
+	};
+
+	framebuffer@e1000000 {
+		reg = <0 0xe4d00000 0 0x2400000>;
+		no-map;
+	};
+
+	ramoops: ramoops@E9700000 {
+		compatible = "ramoops";
+		reg = <0 0xe9700000 0 0x5b8000>;
+		record-size = <0x40000>;
+		console-size = <0x40000>;
+		ftrace-size = <0x200000>;
+		pmsg-size = <0x200000>;
+		ecc-size = <0>;
+	};
+
+	reserved@ea700000 {
+		reg = <0 0xea700000 0 0x800000>;
+	};
+};
+
+&removed_mem {
+	reg = <0 0xd8800000 0 0x8e00000>;
+};
+
+&slpi {
+	firmware-name = "qcom/sm8350/OnePlus/lemonade/slpi.mbn";
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <52 8>;
+
+	pcie0_default_state: pcie0-default-state {
+		perst-pins {
+			pins = "gpio94";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio95";
+			function = "pcie0_clkreqn";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio96";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		sleep-pins {
+			pins = "gpio95";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_default_state: pcie1-default-state {
+		perst-pins {
+			pins = "gpio97";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio98";
+			function = "pcie1_clkreqn";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio99";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+			/* wil6210_refclk_en_pin lives here also */
+		};
+	};
+
+	/* Modem-related pin common on both devices */
+	rf_cable_ant0_active: rf-cable-ant0-active-state {
+		pins = "gpio165";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	tp_rst_active: tp-rst-active-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	/* tp_rst_suspend pinctrl is different per device, don't specify here */
+
+	tp_irq_active: tp-irq-active-state {
+		pins = "gpio23";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	tp_irq_suspend: tp-irq-suspend-state {
+		pins = "gpio23";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 203 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&pm8350_l7>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&pm8350_l9>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&pm8350_l5>;
+	vdda-pll-supply = <&pm8350_l6>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	/*
+	 * Bug in interconnect driver breaks USB; RPMh is unable to power on
+	 * USB regulators without this.
+	 */
+	/delete-property/ interconnects;
+	/delete-property/ interconnect-names;
+
+	/* USB3 seems broken (though it's enabled downstream?) */
+	qcom,select-utmi-as-pipe-clk;
+
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&pm8350_l5>;
+	vdda18-supply = <&pm8350c_l1>;
+	vdda33-supply = <&pm8350_l2>;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
new file mode 100644
index 000000000000..473f10d4fcf0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonade.dts
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Igalia S.L.
+ * Authors:
+ *	Nia Espera <nespera@igalia.com>
+ */
+
+/dts-v1/;
+
+#include "sm8350-oneplus-common.dtsi"
+
+/ {
+	compatible = "oneplus,lemonade", "qcom,sm8350";
+	model = "OnePlus 9";
+};
+
+&i2c4 {
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupts-extended = <&tlmm 23 IRQ_TYPE_LEVEL_LOW>;
+
+		avdd-supply = <&pm8350c_l13>;
+		vdd-supply = <&pm8350c_l8>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&tp_rst_active>, <&tp_irq_active>, <&tp_enable_2v8>;
+		pinctrl-1 = <&tp_rst_suspend>, <&tp_irq_suspend>;
+	};
+};
+
+&mpss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rf_cable_ant0_active>,
+		    <&rf_cable_ant1_active>,
+		    <&rf_cable_ant2_active>,
+		    <&rf_cable_ant3_active>,
+		    <&rf_cable_ant7_active>;
+};
+
+&tlmm {
+	/* Modem antenna pins exclusive to lemonade */
+	rf_cable_ant1_active: rf-cable-ant1-active-state {
+		pins = "gpio27";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	rf_cable_ant2_active: rf-cable-ant2-active-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	rf_cable_ant3_active: rf-cable-ant3-active-state {
+		pins = "gpio44";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	rf_cable_ant7_active: rf-cable-ant7-active-state {
+		pins = "gpio155";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	tp_rst_suspend: tp-rst-suspend-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	tp_enable_2v8: tp-enable-2v8-state {
+		pins = "gpio74";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+		output-high;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
new file mode 100644
index 000000000000..bc7e5654bd3d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-lemonadep.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Igalia S.L.
+ * Authors:
+ *	Nia Espera <nespera@igalia.com>
+ */
+
+/dts-v1/;
+
+#include "sm8350-oneplus-common.dtsi"
+
+/ {
+	compatible = "oneplus,lemonadep", "qcom,sm8350";
+	model = "OnePlus 9 Pro";
+};
+
+&mpss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rf_cable_ant0_active>;
+};

-- 
2.42.1


