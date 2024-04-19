Return-Path: <linux-iio+bounces-4370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B1A8AB21B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9731F211B5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8E136677;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5l3tY2I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961FD133994;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=ilOzkBAqUxuy0yUBo8HtEODBO7UbQiGNE3S28tdaBYifQO74ZaEXWb8cgSVbCW6sYnYSCT7Vfrff05XxdG4TWnFQ6N+G5vu47sbFpCkcu0Een99ns8XoTv0zwywQ5qGU6q9TKZtn0Um35jEXzLMSePlebuIpEjkijPaKJilT45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=d2ddOxG6ia3/viS09wCXHV2UWCg2yg2SY7mLAsDE4xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpcKGjkPWNrgiMWXhgYwI//41go96sl2S5kBKPDRemmrfSS/xckbawWIQzsm1845LeI3swetwQERlA5xd5OOBdR3Z4gr0ZjV8fox+/2NnaDCxQqMBfjxu3Xb/fvUeC3jGHZDNLUHiPTkEb5Ug0skDqvazMBof1+A/wAjFd5ohIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5l3tY2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC22C4AF12;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=d2ddOxG6ia3/viS09wCXHV2UWCg2yg2SY7mLAsDE4xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h5l3tY2IUgBx+pVG2P6worEIiQkMKvUIOaxEVpyOrWbXO5p++CPfBerDsj73gG0zX
	 gGrif7lPpL70TLsIrSCkDLxZbhX1bzuL7xM38kas1Pej7h8Y3hHGiUTlzn+axnH1Uf
	 b4dBNuqATHtJJ9/rahNPsSPLIbyjrRTNfDIn0T/aeN5kFNk4zlESeQQqWur+5sF3xB
	 GO6cFxqdES95V87aMXQ8bJEXLxHCsNmyAOvlJiyML47W9dPdS60dWjQTD17kIX6BQg
	 rxdJHYqNy5E3CnlcqStQ+YXudjoutiCvsYQz2+XDXwgTIyCgvE/7egcyfaf80UxWKN
	 LwVuC3x7l1tVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A6AC071DB;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:48 +0200
Subject: [PATCH 5/8] iio: adc: adi-axi-adc: remove regmap max register
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-5-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=815;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yuttbukX0NN4jOLmY+xhQCCzS7vMjNuAM9G3y7vBkBQ=;
 b=y0o0eeLrYzGr245OURF3dJWvUh47qOXbJariJnO8XLiBAsBFls5dys91Zk9aFUSrNH4bMvYft
 EDhQDnfe4qvB602a01WCf7iWDyVf4jisiLbtAXr/wkjitG91qMSe48X
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
index e3b2158829416..b312369b73661 100644
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



