Return-Path: <linux-iio+bounces-14064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55249A07FC1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 19:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868BB3A4A45
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F1199385;
	Thu,  9 Jan 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8kj6GN5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D540747F;
	Thu,  9 Jan 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447138; cv=none; b=gHnByv4pmHuIa97fbLd4zkCiFvdTNYP/kmoTitB9iujR7/oleeFkY/mFDiF/qq7CrDmDx3GXXPm7H8ggiCYoCMj4bnsZ0UJVavOx7IkukFnvtxAl+wmoRznIO8T9qUyRaq3WzWXqE1JnMiaPmDSHkYDWZQ2E4CTzDz2KUDKPMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447138; c=relaxed/simple;
	bh=jJYLqX1Wvzo50KTj3seMVu0AOOohiMA4zPktn26hf9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sb3pZTIixcc4jaKCZYqTGprszKBlWzFAdl1FI860GIfdDgmQgh0kOPYqd1EQbMJJgEkVJr5LBrxy9xhlw8jPoBlV9rRbqtw2S0+9c4GxxC9j2slI13M+QciHhxaDnI7pfOl6wyJGI0/2ragwypx5EjC+HYSgZcVR33DHgpwLvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8kj6GN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C514C4CED2;
	Thu,  9 Jan 2025 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736447137;
	bh=jJYLqX1Wvzo50KTj3seMVu0AOOohiMA4zPktn26hf9k=;
	h=From:To:Cc:Subject:Date:From;
	b=a8kj6GN5ah6Hv3gjYu1tvtcReuujhZfGlMSBObitDYHC8gfHsvGi/yQkBJ9MXohgE
	 p/+5qpU5zP/dIfd3cyq9CUr5gFlAJIxdglh7t2VJrJh6RaKT+HXyE9oxr52xnU3TCc
	 QWqQNPznHsPTFHiQiB9isVnxuRVQcjNCXFjA2Oyh2XumqP1B5VK1A7HKLIsLUznGvZ
	 YONUf5mG2zwf2i6oDh6RFE9DjfiKR/iuCkqB3yfiH1m/BYuFr9b9PRIYHvCnBYDRXl
	 yBn+29hzva82f9CFRA/CtSk/RSeGyeL9bfGO9Sh5nl5hoZwXLiXccaW+FTXnXjrsi4
	 Yo1jPThexw+yA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32: Drop unnecessary DT property presence check
Date: Thu,  9 Jan 2025 12:23:25 -0600
Message-ID: <20250109182325.3973684-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to check for regulator supply property presence before
calling devm_regulator_get_optional() as that will return -ENODEV if
the supply is not present.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
The diff context doesn't show it, but the next line returns on error 
other than -ENODEV.

 drivers/iio/adc/stm32-adc-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 2201ee9987ae..0914148d1a22 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -615,8 +615,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 	}
 
 	/* Booster can be used to supply analog switches (optional) */
-	if (priv->cfg->has_syscfg & HAS_VBOOSTER &&
-	    of_property_read_bool(np, "booster-supply")) {
+	if (priv->cfg->has_syscfg & HAS_VBOOSTER) {
 		priv->booster = devm_regulator_get_optional(dev, "booster");
 		if (IS_ERR(priv->booster)) {
 			ret = PTR_ERR(priv->booster);
@@ -628,8 +627,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
 	}
 
 	/* Vdd can be used to supply analog switches (optional) */
-	if (priv->cfg->has_syscfg & HAS_ANASWVDD &&
-	    of_property_read_bool(np, "vdd-supply")) {
+	if (priv->cfg->has_syscfg & HAS_ANASWVDD) {
 		priv->vdd = devm_regulator_get_optional(dev, "vdd");
 		if (IS_ERR(priv->vdd)) {
 			ret = PTR_ERR(priv->vdd);
-- 
2.45.2


