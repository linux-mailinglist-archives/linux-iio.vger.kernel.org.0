Return-Path: <linux-iio+bounces-8115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941D94361D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 21:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9281F23AA6
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516315252D;
	Wed, 31 Jul 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YawNJ9oZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384015FCE6;
	Wed, 31 Jul 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453222; cv=none; b=XvZu3AePPfIXbCKCCKYAStD5WM1AQsInBTBIWVFoFMPqtCgxSXpYb/+tuTBkx87PBq2j0O3PxiyLjP9dMAmHcKZglYBm0JJgXDjJABV33s1QrBHET849Y1OOVtbeVFCVWhaqPD3ye5KqWi+IOi21HxWF/ZpJOLZa+Nc/mXlxEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453222; c=relaxed/simple;
	bh=+jskVYz4RvJQMTJu5G7MN+BNF0iQeceivR3RGFlI1R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0/fj66Tvf+Ea6D2of4OwT1XfHiPl93oDi0hwOK7Skue4CbILOO/LB6HU1jF/57Jkx6PpzuuIwu/OahW+ney6ddaJBRTfLShIMTdV2JD2QtJhP1Jugq8mtWLR7nvtTV2QZUFs9o34vHZCGIcVEuYyTGaFg7wCWYAjuabyxyUrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YawNJ9oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4607CC116B1;
	Wed, 31 Jul 2024 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453221;
	bh=+jskVYz4RvJQMTJu5G7MN+BNF0iQeceivR3RGFlI1R0=;
	h=From:To:Cc:Subject:Date:From;
	b=YawNJ9oZXyselFYCRQcg5njQBjTr/DIvwQQFn2kOLnx3s80hhJet2mN0KQIoF12ep
	 6MXH0TZW6nvxrReZkr4GgWCCr5j3H9iobNbkb9Nr4R2nNM2sgcCsnYBFrwX7otk0W2
	 q68/UocCL4Iow0UNYAbYogw0y+LE1SvKJynxC4RDU5+TGlFM/s1ho0WqJpjrK0rrVm
	 ufPxoQhVWvCm/3WNAiLdAvBGIpF2K7/+Ci7k135pNPoRWswnjqblRr4bG4DZRjpL8K
	 uLj5reFf78C6VSO/7ONAdRfwYFOvB5kqSVevkxO1pR41cVWuyA8mxunbdC+xN4ZlHH
	 ErKQv1YdVxPag==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: aspeed: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:43 -0600
Message-ID: <20240731191312.1710417-5-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/iio/adc/aspeed_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 090416c0d622..064cddaf6399 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -555,8 +555,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
-			     NULL)) {
+	if (of_property_present(data->dev->of_node, "aspeed,battery-sensing")) {
 		if (data->model_data->bat_sense_sup) {
 			data->battery_sensing = 1;
 			if (readl(data->base + ASPEED_REG_ENGINE_CONTROL) &
-- 
2.43.0


