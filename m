Return-Path: <linux-iio+bounces-6261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19DB9085C8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 10:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD28B25679
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18501862A2;
	Fri, 14 Jun 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pZVAdZdR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA1185082
	for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352648; cv=none; b=jLOSPdj0+aDtB26YdYsKbNDWYr4EEOGuqzwyDFjcVf2dpkrFFDdBfrRKbl8zdv+b8h0LmjrfncQ4Uq1EC7Ke0SlAn7WbY3+wpMRLIRquRx/gi9+8UmYKywQmBErF5EcwQT8iH0/nKYPV5ZYz+IgijIoGRIJN1K8FyqVqLt22YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352648; c=relaxed/simple;
	bh=I3iLNPbAvcDPk6Nw1QUlh23HxzYQPmXbPfOcTvZTTEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHPRoz7Xr37NtedANkEvpZzoV+OKf8c+3yeaITjS+ywtXFOcnv/cQj8flfz2puHb8bhLGNGf0gUt0dGfbg0Fs90Cm3QU0DNR4Eh0tF4JunGDcCTG0t4s5V7h7pxXHVyLuDAH6f9NoOIp4ejdVjEkmHrCOwUiVmzC8pfQG//id9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pZVAdZdR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so417429a12.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718352645; x=1718957445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy65aQubSD4tbmjRxefZecoIq4GXZIdFH64RPRpuevk=;
        b=pZVAdZdRrEHDsbcc+Za54v7A87w0kBVRcyZVPtf3Iky2880lgTA3ViSQ6pYMdi7/nZ
         tCt8ALQ4H8nWQd+q3io+Dy/L9eFukPtpNNrU+PjyJ8RiVVceB8TM/1fgKltG0s2AVlaI
         msMxNQx+I4qGIEDWgtvnRjNcWQYhX3t6ToKVbL9B9ZmuviF1JrBS94TMKXo+UsNnX1Qm
         sswaH+UsiZjD4f9iUAJBRpGaIewO4d3nh4eAlTCtyqOb8y6Gab4+LcjzNeNGPuNO1+6z
         FK79TgVqlnUcIcqtA4+z4DCvJZKqPFAZgiO0hpSp7KI3o+njXCoRnOax+ws2cOH+15lQ
         83OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352645; x=1718957445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy65aQubSD4tbmjRxefZecoIq4GXZIdFH64RPRpuevk=;
        b=O4Hb7W+4wJrNPHpJ0wOPyOd8+3gSeRYjGPC0TpmEvko6EEyw8RorA4XaymRX6wjn5n
         5EdgYtE/fMImwcwhnpoVH7QKK+EKWYEWXRuSrVejTdNrGrrimNkJrHDcDklSds3HHXwS
         6TMa4ILuqAA5rwcyPGqHE5sLp643ePtuJzGrUJVhtSlO/WCGonQ2om3oH8M6LnKoFmac
         WnDNRude3SzYvdbM6N/VZp8Vh8Cp3oZmjZLpOXD237QPi5ACjm90TFba7tgjM9VAT78a
         CErfuQT7J/5jCrBG2gbvs1F0b7Yfz/U3Ch3FuLa5cCsmXsXnsVPxxor2pLPUl8Mlcxuq
         oRDg==
X-Gm-Message-State: AOJu0Yws/NWVW0L9g0A0NCU/G/OmGy6K3XNaobb2yx09as4HBA7iGXhZ
	6kuloZgwRbbKACk/2huhcQSJSvU52pnj2e9G/0EWD0u76ww0axxMYHPFnK+0wj4=
X-Google-Smtp-Source: AGHT+IG8vyu+lChvA75pP+yobBANu/WNvOVceOlafrcqMeCCCsOH0P5Be43wvfozwTxwaqjrFdJqbw==
X-Received: by 2002:a50:ab1d:0:b0:57c:a7dc:b0e4 with SMTP id 4fb4d7f45d1cf-57cbd674334mr1467162a12.3.1718352644618;
        Fri, 14 Jun 2024 01:10:44 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce07esm1910194a12.12.2024.06.14.01.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:10:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pwm-stm32: Make use of parametrised register definitions
Date: Fri, 14 Jun 2024 10:10:14 +0200
Message-ID:  <765681be4da184d8886e9837fcbe35321a5827f1.1718352022.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=I3iLNPbAvcDPk6Nw1QUlh23HxzYQPmXbPfOcTvZTTEE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma/rxUqR8k2kQlHINVk2JFXnkxxfFoFaxndNGF 3aiztX7/haJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmv68QAKCRCPgPtYfRL+ ThklB/97HZsttyevmt4/WDxNzPTV1K7YemJMyPrX/qSaW/Izjg3FteFk8dQREwIT+SZb0yE/Rvk QFDdO9eqv/fHBkEvlk9ZD6VVISOXUlHdFI1ZzoOeraUg0epyeMQA6CmLWM0rwSst512yjG3Iin2 4Xn3CDsGAlXu1pWyFrsiuHUaUmhW99UsAMgfwGGwadOC9XBOgzAC3/7FdeZ4wJEUMBFCPBG6NPG ETc6E4OqBCJvi2GVXFG9WDCkN+jGMrTOCmp015RmPJaRktmKEIiDy3h/GofbKF3wYPrBnzHjQsg ore9yeaohvi1xHsMJ71ed9vH9kUvxlliZen1Fl+zFw1+m1C8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is no semantic change, but it is a nicer on the eyes of a reader,
because

	TIM_CCR1 + 4 * ch

encodes internal register knowledge, while

	TIM_CCRx(ch + 1)

keeps that information completely in the header defining the registers.

While I expected this to not result in any changes in the binary, gcc 13
(as provided by Debian in the gcc-13-arm-linux-gnueabihf 13.2.0-12cross1
package) compiles the new version with an allmodconfig to more compact
code:

	$ source/scripts/bloat-o-meter drivers/pwm/pwm-stm32.o-pre drivers/pwm/pwm-stm32.o
	add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-488 (-488)
	Function                                     old     new   delta
	stm32_pwm_get_state                          968     936     -32
	stm32_pwm_apply_locked                      1920    1464    -456

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a2f231d13a9f..49a76514b83e 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -360,7 +360,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	dty = mul_u64_u64_div_u64(duty_ns, clk_get_rate(priv->clk),
 				  (u64)NSEC_PER_SEC * (prescaler + 1));
 
-	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
+	regmap_write(priv->regmap, TIM_CCRx(ch + 1), dty);
 
 	/* Configure output mode */
 	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
@@ -382,9 +382,9 @@ static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
 {
 	u32 mask;
 
-	mask = TIM_CCER_CC1P << (ch * 4);
+	mask = TIM_CCER_CCxP(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NP << (ch * 4);
+		mask |= TIM_CCER_CCxNP(ch + 1);
 
 	regmap_update_bits(priv->regmap, TIM_CCER, mask,
 			   polarity == PWM_POLARITY_NORMAL ? 0 : mask);
@@ -402,9 +402,9 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
 		return ret;
 
 	/* Enable channel */
-	mask = TIM_CCER_CC1E << (ch * 4);
+	mask = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NE << (ch * 4);
+		mask |= TIM_CCER_CCxNE(ch);
 
 	regmap_set_bits(priv->regmap, TIM_CCER, mask);
 
@@ -422,9 +422,9 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
 	u32 mask;
 
 	/* Disable channel */
-	mask = TIM_CCER_CC1E << (ch * 4);
+	mask = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NE << (ch * 4);
+		mask |= TIM_CCER_CCxNE(ch + 1);
 
 	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
 
@@ -493,8 +493,8 @@ static int stm32_pwm_get_state(struct pwm_chip *chip,
 	if (ret)
 		goto out;
 
-	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
-	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
+	state->enabled = ccer & TIM_CCER_CCxE(ch + 1);
+	state->polarity = (ccer & TIM_CCER_CCxP(ch + 1)) ?
 			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
 	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
 	if (ret)
@@ -502,7 +502,7 @@ static int stm32_pwm_get_state(struct pwm_chip *chip,
 	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
 	if (ret)
 		goto out;
-	ret = regmap_read(priv->regmap, TIM_CCR1 + 4 * ch, &ccr);
+	ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &ccr);
 	if (ret)
 		goto out;
 
@@ -702,7 +702,7 @@ static int stm32_pwm_suspend(struct device *dev)
 	ccer = active_channels(priv);
 
 	for (i = 0; i < chip->npwm; i++) {
-		mask = TIM_CCER_CC1E << (i * 4);
+		mask = TIM_CCER_CCxE(i + 1);
 		if (ccer & mask) {
 			dev_err(dev, "PWM %u still in use by consumer %s\n",
 				i, chip->pwms[i].label);
-- 
2.43.0


