Return-Path: <linux-iio+bounces-25441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209ADC09426
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1A8421C72
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503030506B;
	Sat, 25 Oct 2025 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Art3gyvD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56430504A;
	Sat, 25 Oct 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408820; cv=none; b=Xt8K2gIhwWUbMlsHnLLJJulfDAIwprvZL8ID5KZGJKPnSjlLiBojqeXLY++8bVinDxV97SrgSTGeNAeWSFbWTUPvyE2lpmTJDzi4uCRBA0UZ4JvKNSKE1N+OfHdwj+kBIGNbdJOIxopxSrunq/m+pjkjM3U/B1jET+vAdzfRP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408820; c=relaxed/simple;
	bh=ykKpstcD/nFFD4tx9FG9wgDXP6IoofyoYUuh6BLPYos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/MyZwbr9MTZNgHdGJ8uYEwnFQ9nn3gQQP3YJrYnkG6lMJOhOjLkal0avWILhxhvIKkBt09HLsY1UyKqg1z7tjcwXt/fQVaN50GWsvk6pVq7CW1taqQViaYMCYzevr0T1MjVGYmayDusTupBUP/9eVIw0IX76q8c5iSd5exkXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Art3gyvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DDC116B1;
	Sat, 25 Oct 2025 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408817;
	bh=ykKpstcD/nFFD4tx9FG9wgDXP6IoofyoYUuh6BLPYos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Art3gyvDW7YsLgQ5MxH+GlcxwIzMPREX21vtGRhHmDvVZQ726tFnJwKu9xbWSffg0
	 n9k2ivCgkAoXufNNPf667R/D2HEGklyhCxdXzaTf34cVaMwRC9gGtwbA51NPEyfGmF
	 tQOL7dfb4svQH8NOI4FfEbvVxSYE3QtitM7jFCAV6B55twSUHxJ/ixZ7jCyeaIhFKd
	 T7OVkS1Q7hV7kQAhAeMs7OLBnJFuYEWLmQtzrjWRVvBx51I13GW/XOMwWE6UxQd4QY
	 BWGsjhVG80hC4JPz6H8WbbsN23jSqTU+skGN4y+YTdkARwUNvcADNCSwxYCIrN46/F
	 IKLBa5XHnSv/A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-6.6] iio: adc: imx93_adc: load calibrated values even calibration failed
Date: Sat, 25 Oct 2025 11:55:13 -0400
Message-ID: <20251025160905.3857885-82-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 12c9b09e981ab14ebec8e4eefa946cbd26dd306b ]

ADC calibration might fail because of the noise on reference voltage.
To avoid calibration fail, need to meet the following requirement:
    ADC reference voltage Noise < 1.8V * 1/2^ENOB

For the case which the ADC reference voltage on board do not meet
the requirement, still load the calibrated values, so ADC can also
work but maybe not that accurate.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Primoz Fiser <primoz.fiser@norik.com>
Link: https://patch.msgid.link/20250812-adc-v2-2-0260833f13b8@nxp.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation
- Problem addressed: On some boards the i.MX93 ADC calibration fails due
  to reference voltage noise (commit message). In the current code, a
  calibration failure aborts driver probe, leaving the ADC unusable for
  users.
- Current failure path: `imx93_adc_calibration()` returns `-EAGAIN` on
  calibration failure, explicitly powering down the ADC and aborting
  probe:
  - Failure check/return: drivers/iio/adc/imx93_adc.c:181 (checks
    `IMX93_ADC_MSR_CALFAIL_MASK`) and drivers/iio/adc/imx93_adc.c:185
    (returns `-EAGAIN`).
  - Probe abort on error: drivers/iio/adc/imx93_adc.c:367 (calibration
    call) and drivers/iio/adc/imx93_adc.c:368–396 (error unwinding).
- What the patch changes:
  - Adds `IMX93_ADC_CALCFG0` (0x3A0) and `IMX93_ADC_CALCFG0_LDFAIL_MASK`
    (BIT(4)) so the driver can instruct hardware to load calibrated
    values even if calibration “fails”.
  - In `imx93_adc_calibration()` (drivers/iio/adc/imx93_adc.c:146),
    before starting calibration, it writes
    `IMX93_ADC_CALCFG0_LDFAIL_MASK` to `IMX93_ADC_CALCFG0` to enable
    “load-on-fail”.
  - It changes the failure handling on `CALFAIL`: instead of returning
    `-EAGAIN`, it logs a warning and continues, allowing the driver to
    register and the ADC to function, albeit with potentially reduced
    accuracy.
  - The timeout path remains unchanged and still returns an error if
    calibration never completes (drivers/iio/adc/imx93_adc.c:171–178),
    preserving safety for a hard failure.
- User impact: This is a practical fix for real boards where Vref noise
  is above the stated threshold; without it, the ADC never comes up.
  With it, the ADC works (possibly with lower accuracy), which is
  typically preferable to complete unavailability.
- Scope and risk:
  - Small, contained change in a single driver
    (`drivers/iio/adc/imx93_adc.c`) with no ABI or framework changes.
  - No architectural refactoring; only adds a register define and a
    single bit write plus relaxed error handling.
  - Timeout/hard-error behavior is unchanged; only soft failure
    (CALFAIL) behavior is relaxed.
  - The driver matches only `nxp,imx93-adc`
    (drivers/iio/adc/imx93_adc.c:465–469), so the change is isolated to
    this hardware.
- Stable criteria:
  - Fixes a user-visible bug (driver failing to probe on noisy Vref
    boards).
  - Minimal and low risk; confined to probe/calibration logic.
  - No new features; behavior change is a robustness fix with guarded
    warning.
  - No broader side effects beyond this ADC device.

Given these points, this is a solid candidate for backporting to any
stable trees that contain the i.MX93 ADC driver and its current fail-
hard calibration path.

 drivers/iio/adc/imx93_adc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f2..9f1546c3d39d5 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -38,6 +38,7 @@
 #define IMX93_ADC_PCDR6		0x118
 #define IMX93_ADC_PCDR7		0x11c
 #define IMX93_ADC_CALSTAT	0x39C
+#define IMX93_ADC_CALCFG0	0x3A0
 
 /* ADC bit shift */
 #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
@@ -58,6 +59,8 @@
 #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
 #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
 
+#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
+
 /* ADC status */
 #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
 #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
@@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
 
 static int imx93_adc_calibration(struct imx93_adc *adc)
 {
-	u32 mcr, msr;
+	u32 mcr, msr, calcfg;
 	int ret;
 
 	/* make sure ADC in power down mode */
@@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 
 	imx93_adc_power_up(adc);
 
+	/* Enable loading of calibrated values even in fail condition */
+	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
+	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
+	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
+
 	/*
 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
 	 * can add the setting of these bit if need in future.
@@ -180,9 +188,13 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 	/* check whether calbration is success or not */
 	msr = readl(adc->regs + IMX93_ADC_MSR);
 	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
+		/*
+		 * Only give warning here, this means the noise of the
+		 * reference voltage do not meet the requirement:
+		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
+		 * And the resault of ADC is not that accurate.
+		 */
 		dev_warn(adc->dev, "ADC calibration failed!\n");
-		imx93_adc_power_down(adc);
-		return -EAGAIN;
 	}
 
 	return 0;
-- 
2.51.0


