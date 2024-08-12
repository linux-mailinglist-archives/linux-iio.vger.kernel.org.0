Return-Path: <linux-iio+bounces-8415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C22E94E84E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F8F283801
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312416A94F;
	Mon, 12 Aug 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzfKDYaF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA2166F2D;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450397; cv=none; b=crsBP01z9P5iXe3kPsz7fwjtvtq/5PaDl+lwMg1dwYfeaVMVqB7r4AkugxZtIYAvvoe+lALHw4fxAHLh0NxZAzHTCtD7oNKl8CCV9DLpoa59tcz3MCjArKp6p8Qd57GC8UcNlKSBa++XD3zhiAFutbye10iLc8hoxn3JrvhAx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450397; c=relaxed/simple;
	bh=0gcXg4EfHyC+Rs8bX3KNCUbU2dYucTIn+0jstdGEUFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDD8e/NQ1l3Nmwp+/AKHmQ3AKHA1uNXt3mVR6HVjWxwJtAEsIm/5dqVv7D80FmzcMIjqp8wfV7ji72zIdAzpf2ICa41mhGJqTxmy+tZemqgp5tnI/3/d1rzky1lMasu5Bbd4xhaX/sKPUJ4RIP2mceSJJDZkAj0UdNn4G6kp06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzfKDYaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B806C4AF0E;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723450396;
	bh=0gcXg4EfHyC+Rs8bX3KNCUbU2dYucTIn+0jstdGEUFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tzfKDYaFgvoI7/LrjpKy3/Qauq569C3xqCRoBc2fK+lGC2tsFbGBuaY28Rg/msFg3
	 NKU/6RmuuWjt7Dm1YtH2/0QATAR4S4ezsa0dp8hdOZLg4Ol+0yQL75l+FO7bCsyCYo
	 hkMYBUlE+6ZQklYXFuz9KOogJZtaSq0GdSLM8w4TP9z+0JlRxTxEtxnegHfJ6huCU4
	 JslqJPRX2gQ4OOSaeDmcV5wz10u/jwRlO42lu6Nm0HNs91ArTJRkGrE4upfNf8pqqS
	 a3f/N+hsUTYNmJZz0UUXmkth94/wRVbF7g9/ektzE9utEccxE5kpXObwgKfjvtJ3it
	 ZXfx0uyDavIAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E840C531DC;
	Mon, 12 Aug 2024 08:13:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 12 Aug 2024 11:13:15 +0300
Subject: [PATCH v3 2/3] iio: adc: ad7173: order chipID by value
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-ad4113-v3-2-046e785dd253@analog.com>
References: <20240812-ad4113-v3-0-046e785dd253@analog.com>
In-Reply-To: <20240812-ad4113-v3-0-046e785dd253@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723450395; l=698;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=k1tXhRvf85CI0lNgZZec7J3hSBj8X2rculRMdGUY4Mg=;
 b=ZaUjIQ1ZmMMYE8/2KaC+AqeSgH02Zl2dXe4SLTvI5NDQXg11U2LNB5RIR99bONIRf+36TAhhA
 N31IKgTLRsTD826unsuR1Fvlr9UY4G+9ll1OE92n6WBtbx/QDRClAX2
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

The chipIDs defines were supposed to be ordered by value, one was out of
order. Fix the order.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a854f2d30174..a2bfc28932a5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -76,8 +76,8 @@
 					(x) == AD7173_AIN_REF_NEG)
 
 #define AD7172_2_ID			0x00d0
-#define AD7175_ID			0x0cd0
 #define AD7176_ID			0x0c90
+#define AD7175_ID			0x0cd0
 #define AD7175_2_ID			0x0cd0
 #define AD7172_4_ID			0x2050
 #define AD7173_ID			0x30d0

-- 
2.43.0



