Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604F7CA862
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjJPMrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjJPMrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 08:47:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB77F1;
        Mon, 16 Oct 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aSw/SitkCdghTwzNFGWOAeZtBD5jT+hGocMeTU5ypa8=; b=HIM79nsm3NMawH9LAl7a/gxsf7
        m5DkG5QU2h2Br9Md060uHeeQK7Mo/gzmoJUkEVv7ZudtbxeqVFHbUZNzN59fYaCwXpCL8/nF3kvf6
        5yIhx2zX0JttueZeGYcAKVMTVkTrqujpvgvHF6NbaoUUmbvVcgK2/kteZUHZsUnsAY0YiaPac3J4Q
        qZllcbIzyWONuJPKXt3DWXPvGXL35Mj++CpMzjr+SY4W0ZtheDcyEBzAR6x+HmFJQKcUFUvaVPziS
        +5ZI5JzLHeTDTzAhjIR8ZXrOd/E5ZeyG1GqzL6WOzyN7My6/EeTEAPXwE8zq9xDUlSPn/+q5X7Crt
        KX1DaqJg==;
Received: from re-byods-146-50-198-227.wireless.uva.nl ([146.50.198.227])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qsN03-0013kp-Tt; Mon, 16 Oct 2023 14:47:11 +0200
From:   Nia Espera <nespera@igalia.com>
Date:   Mon, 16 Oct 2023 14:47:03 +0200
Subject: [PATCH 3/5] arm64: dts: qcom: pm8350k: remove hanging whitespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-nia-sm8350-for-upstream-v1-3-bb557a0af2e9@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=627; i=nespera@igalia.com;
 h=from:subject:message-id; bh=eL/xbH1y2VfLlWI0VS2+3fBxKQWeWtx0gu6ZMciNzu0=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlLTDM9Qvo5Dz5VAgsxXtZNrsqRkuHh6vIY96MZ
 CpUy7M5k/KJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZS0wzAAKCRDyJM7CN1bi
 rZKNC/4yPqov6mprRsUKbWrS48z3NkIhHI3+y7O5xRFbI3urq9MesZYff6vi5f5JRAvRLuKCdwd
 8HWnO+BMrnBAqxMLmPUH6IbWI3p+oK5kJUzVafcdY7Ze8iV/v/+F83ufSGfCHwaJdws+JRWzT85
 zZ8IzvXAY536A5E+lllr2DGFVvZl1o1+yW4UevFG0VACUdnzB3RMR2ZRcR5F2AeGy9hvlP7ojLX
 67FBuLRTsBjqwjYte/R8jKes6Tgk/48ZMgUnAS4uyPB+Ildv204axmcqco5vM0mzCCzRIlD/7Xb
 Ih3Z4tll7WHjm/iV9YNcjC57xwjGaoSHwzUmH00rNhpMw6t9+cShqiTJ+IuPZ+fkVGnQ/64/Zbk
 rAHwscBJoJHMttmdGhd8JOVAnOOInv3SCEX2B6PHncwm+x1HaVW443+tPjLyPB+cxQFeZNpsNYX
 uSy+ZXIFYXvi+LFGxXcZY1WM4KARbbmnJYT1TLgGbEhEs98c1b/m+wDA1jQkpsXDZJlA4=
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

pmk8350 has a random tab character inserted, so remove it.

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 1eb74017062d..f0ed15458dd7 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -22,7 +22,7 @@ reboot-mode {
 		mode-bootloader = <0x02>;
 	};
 };
-	
+
 &spmi_bus {
 	pmk8350: pmic@PMK8350_SID {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";

-- 
2.42.0

