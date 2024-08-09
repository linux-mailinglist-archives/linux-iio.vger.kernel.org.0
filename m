Return-Path: <linux-iio+bounces-8347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AC94CEB3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105831C2194C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156351922D9;
	Fri,  9 Aug 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smr4Ih9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4542176237;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199608; cv=none; b=VU/+jyRjw+B9G+tCQXai/XdBwjUebKEwq3w+MqZDKE1hxdhCu09qqdLK0TCUv7Vu8sCkPrR67/1442im5wFGCuT7D7tlelgw557Jg5C1Q7R1xH4TZATkS/Wh86JQdtewR7S72lhm66CaOkSW8Cz1bHg7KowM1VnXaRkCRdB8yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199608; c=relaxed/simple;
	bh=XLUn36JDfGVD+kFvEnQoA8EoeGkaGqnjyaOJ/Fu01Dw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KtAHEMKg9FjVuQg+uJBzQJW+x8LEELT+g7p8wqQ+L/Xq7rqlfoSO85amujiqOropX/iJ4i0xS29p/61mnv7MKC75Miwokpvt4FCB5c1eTOE8gTQAXUtYPSl7BdBpyRXNzmKM0Vk+eUGfpm0bQq1tE+BPm1sWOIFYLcFU6XS0CmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smr4Ih9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B78C32782;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199608;
	bh=XLUn36JDfGVD+kFvEnQoA8EoeGkaGqnjyaOJ/Fu01Dw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Smr4Ih9UI+zr05/xwxaEJxc01zmTjrK9qXfqWuYucB0jOa529zUzvfa0TYLjyT0dm
	 KEkxxmUiHtz5rWSGahCa/VLmPwTgP3BaOJxwP2uRZ7BD1joQjiRXqDy5DNUWX1aq4Q
	 /HSViIK+dxnQ3vQ163DxJQOzcgeAzbkqx9Cvy7dBfdHww0v9INd1yijtdNODotvBrW
	 8bcKLZfupGPVlRIDJoP0lZjinLzwNRwhFwVEi/pzRFEmAsq+5jQMONA4lnWbKh84fH
	 W42xAnyeH6VDjyxyb5HURhJ+sseCBZdwGgZF0V+5UgNe9hhJMXup9qOIdeKefsP60y
	 Ywk6y8IAPvTPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF32C52D7C;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for AD4113
Date: Fri, 09 Aug 2024 13:33:23 +0300
Message-Id: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHPwtWYC/zXMSw7CIBSF4a00dywGLlRaR+7DdEB5tCQKBgzRN
 OxdrHH4n5x8G2SbvM1w7jZItvjsY2iBhw70qsJiiTetASkKKrEnygjGOJmVOnHnxhFFD+38SNb
 51w5dp9arz8+Y3rtb2Hf9EQOVf6IwQgkazgcnKWo5X1RQt7gcdbzDVGv9AHw25YydAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723199607; l=1716;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=XLUn36JDfGVD+kFvEnQoA8EoeGkaGqnjyaOJ/Fu01Dw=;
 b=6Ck5QjXw9XixE3oQ2YRd1xmaxGStGwvGlpPHwvsTwGD68lDgJBUOZhrt074exXpG1iLp6QA8b
 FBpYdB2otawCaYbrdu+l8l4jZaW2xXDUbvtbTukEz+pnYlcg3ycMXZQ
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds support for the AD4113 ADC within the existing
AD7173 driver.

The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

The part is not released yet and the documentation is not public.
Register map is identical to AD4114 besides the lower width data
register and the GPIO register.

Particularities of this model:
- 16 bit data register
- no temperature sensor
- no current inputs
- input buffers
- internal reference
- external reference REF-/REF+
- no second external reference REF2-/REF2+
- no AVDD2 supply
- 2 GPIO pins with config bits starting at a higher position in register
- 8 VINx inputs with voltage divider
- 16 channel registers and 8 setup registers

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Changes in v2:
- correctly set realbits and storagebits to 16 in iio_chan_spec
- describe bindings restrictions in commit message due to lack of
  sufficient diff context
- describe model differences better in cover letter
- Link to v1: https://lore.kernel.org/r/20240807-ad4113-v1-0-2d338f702c7b@analog.com

---
Dumitru Ceclan (2):
      dt-bindings: adc: ad7173: add support for ad4113
      iio: adc: ad7173: add support for ad4113

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  3 ++
 drivers/iio/adc/ad7173.c                           | 36 +++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)
---
base-commit: 1c61e13d7dc9003662bd7fd6064dfea67e64b014
change-id: 20240725-ad4113-baa63ff99245

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



