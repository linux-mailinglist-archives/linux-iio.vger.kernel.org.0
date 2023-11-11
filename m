Return-Path: <linux-iio+bounces-38-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A097E8D07
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D807F1C20843
	for <lists+linux-iio@lfdr.de>; Sat, 11 Nov 2023 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54B200CD;
	Sat, 11 Nov 2023 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TzN/v24/"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AB1FA7;
	Sat, 11 Nov 2023 22:08:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055C385D;
	Sat, 11 Nov 2023 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x9kwEypjevmEYUNyC18YSYgp8/2398DuMmARwC0CIlA=; b=TzN/v24/0wa4DzKz8Hw8NNJReH
	3J3Unk2VZchcoRfgvOfJfLUzxuSnjCnT/WYDInDxxtWsr0AN0AvJayCgUmmoeThJYQPi0DhK684Q+
	WrUIjHLhNTCrs7MNmp/RS9w33brHlDUNQCGGV5k/zt63vIofDIjTQE5BrvgZIDR6FQcOUUKts8cnT
	tiErZKRM2Lt0LNObuFxFuvuod/Fzsj5rz/zQOJnXRmCkLKyTtUN5UB0m+RO8eWO8bNz+YiqZxYAIN
	fOgo4jqjY8nZS1W0oREKOvNMJuktFETrpsd2OfP97q7s2UiKmD6RJMetWOmLqE/Ar9ZK1TU3XlFhM
	+TXA6ttg==;
Received: from i73190.upc-i.chello.nl ([62.195.73.190] helo=[192.168.68.111])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r1w92-0029Vw-Fu; Sat, 11 Nov 2023 23:08:00 +0100
From: Nia Espera <nespera@igalia.com>
Date: Sat, 11 Nov 2023 23:07:43 +0100
Subject: [PATCH v4 5/6] dt-bindings: arm: qcom: Add oneplus-lemonade(p)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-nia-sm8350-for-upstream-v4-5-3a638b02eea5@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=nespera@igalia.com;
 h=from:subject:message-id; bh=8wzrr7zo2MAk5Q7UKt4HaR1sAhHvxZFVuBV6clgzOEw=;
 b=owEB7QES/pANAwAIAfIkzsI3VuKtAcsmYgBlT/s5L9kGBgtqZJ7BARUe0SCyYSEyCs/f5Wir9
 IWN7if8ELWJAbMEAAEIAB0WIQSBPDomug3slDJEnubyJM7CN1birQUCZU/7OQAKCRDyJM7CN1bi
 rRJJDACWyyop1OjfiNn3L4lAkXCWgOL/rMIfZJ6HvKa3dNnYoD3OdlUYpvc+T+hQmNuYUI0ltJJ
 vx7wU0uGNIxK38eXDrjKT1s3zAKbtmhtKb1/Qwya9OObg0RzBQ0KS3ZWdAUOJ82Am+YAR20xDt6
 mH2QBKJRy+CZQfiXVpnB7dC9VgBibOsX26434lXOz7ZlSksIeN/QJh0UL6pQ/l62/Ww3+yYFu5s
 XcUWOts/S8wrvgwH7FcJ/fxyOsOpzAZ1VFUSRWBXtbcVolOFjQcu9TcfhRRn0nc2oOUxQaSCO35
 OVCM+JMbVbA8mVbajQz45bYSo9msVcfiq12g+jfukVj7EO6r4LCldpbw5OGaIdTYn6+wq6pYrkM
 9cUz3tNaab84uRnTh5o7IU6YFmbS1cGGKT2X0liZk44IrVUdfno5NynYY+/gm0Y8oTha3BWoWNk
 6GeBiGSxRpCoX4cXaRb4KIkud7vZ4JKI5/nGT3LIQEJThMmaYWOtr4mvhoBO1EH19VZMQ=
X-Developer-Key: i=nespera@igalia.com; a=openpgp;
 fpr=813C3A26BA0DEC9432449EE6F224CEC23756E2AD

Document the devicetree bindings for oneplus-lemonade and oneplus-lemonadep.

Signed-off-by: Nia Espera <nespera@igalia.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..90820f54f59a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -970,6 +970,8 @@ properties:
       - items:
           - enum:
               - microsoft,surface-duo2
+              - oneplus,lemonade
+              - oneplus,lemonadep
               - qcom,sm8350-hdk
               - qcom,sm8350-mtp
               - sony,pdx214-generic

-- 
2.42.1


