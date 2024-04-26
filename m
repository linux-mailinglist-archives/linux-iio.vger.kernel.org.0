Return-Path: <linux-iio+bounces-4545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B58B3BE6
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D2B1F21974
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9DF156C6A;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfWHQNiQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB7149C64;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146150; cv=none; b=ZtKaya4Wpa+BVGxltgBLXDDJkZYfi3YkLjiTYqM5Lc61/cWVDJsvM+vbgpOqB6h2Lm19I1nxrq54rnhELnUMnykTaJiN6M44l/Gt5WQfuHTei3NGbdYhLkk6A7L0ocpoOpZ4QYNszLjzt6SIb5HFNyFVcFzDREkkjfcawvMOPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146150; c=relaxed/simple;
	bh=/JWoxez/qXAby0DAwjlA0EFETZk3KYQlxkx4cPrQ1b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOOICB7b/d9lD/BD7W7G2wvldZzYQeyo07s9CSF+lKMmtrTRGMmmz1fusT9XnX5KLKszF20fbxopuxzQ4oih3ELsbSfz7BUVcwYK7CQZQbwNaaXfyoq4xHEC6CVRfIdFFB6RCX8x0zjMY3eCT70vh+uHRxsLDbmMpGiXDvbknU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfWHQNiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE5EEC4AF12;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=/JWoxez/qXAby0DAwjlA0EFETZk3KYQlxkx4cPrQ1b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CfWHQNiQl5p7lzmyTWT4O/9PttymFjSmzvvfFmMa3c4z+im2jaSQc+BW8gf5oeJP6
	 j8sKk20RCvaxqCfYVyHqu+F3h3vPj2/KZ0oc6NA55++hO3wezZuU1pWB3KG+FjD+Ju
	 LYSfEtumKCBoyBRnf9heFGFtTELZvJrsnGky6PPbR2dXbIhc8DOYH/aEYyqWkmhL+T
	 rd6zRKSoi1P7NRWOvFZOeYIWE6w106uCztROmEUzQJSBKGjfrvrC6GI6Eqc/3ZyPEg
	 XNApG7qkFzTvg672ihXplBSqzRYO4tB2qfknTJ1X7Q+vwRL95k+QNTVp6/JfDJv0x2
	 evVTYyyM+2bJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A4C25B4F;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:14 +0200
Subject: [PATCH v2 5/7] iio: adc: adi-axi-adc: remove regmap max register
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-5-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=813;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xe0te39dghx3xVo9c0/ZGbv9/Txz1Y4hTt1+Fm8A5ns=;
 b=o5c0uXvGTGdhYwqp3weFdoAh7f9XAy9ZmUqGbq55yd79pfk2fzAhzvHRPkGwXUMDE3D9be53L
 CBRg8gZkR2TDGM3i+nD1zs5TfaTe9YN874soCidkODy6JyGtff3ONNt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

In one of the following patches, we'll have some new functionality that
requires reads/writes on registers bigger than 0x8000. Hence, as this is
an highly flexible core, don't bother in setting 'max_register' and
remove it from regmap_config.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index e3b215882941..b312369b7366 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -156,7 +156,6 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
 	.reg_stride = 4,
-	.max_register = 0x0800,
 };
 
 static const struct iio_backend_ops adi_axi_adc_generic = {

-- 
2.44.0



