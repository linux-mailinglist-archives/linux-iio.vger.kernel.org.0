Return-Path: <linux-iio+bounces-5343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176C8D05F6
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A5E1C22457
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F973441;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK2K3EMr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2C61FEC;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=kjv1K0Kywt2StB6Kb7ir9DDNarsOq9npCrCloVA8OFjiuSmT0UmazWrVDm+fCTIEZMSUYtwUhiEhnykoQmy8GNBdpipmX3Kxtqj8lpbCPCcDCmNutUbuuei8x/+AmwzYjpF7YIip8Af55gHouG/8pdeK8+KPrYA3CZ0C2fzxax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJRw1W/2M2sMXOSMiStT+zd3lZWF7Vg+IuaAzo/MnjdcUQLfzgYUhTmlHPTjcsrb/9PFzVG818X+j2P5bqBzCbRUzKwCr6iiM0C443Wi04kcf0ffI6Vv2MLu8yTXMxrNOSctGJ2js69cL4+D5yXVVUofv8dv3i+v3Ep5ll4Ud9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK2K3EMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ED53C2BBFC;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VK2K3EMrrl+8hpWnw4uKT46HNiMQ1ySQVE2IHpTFWofQm8RyoAGZeBvri7yCQvjrY
	 xFvwbjFCd6qjHvYJ0P6/DIZew/oqwwvXaIZX5gpvuB6+sZjIW5h6AUsB9pg5FrnkQ4
	 9/T/3WSN4DmcvZKYNJMypAVVMqpdEItmRMofBM3kpWyAjuNSmZBgqhJSnOEH1MFSD4
	 Cf8Xfwx29TxX9i9qNaYqfEQyXwLZmRIN1JY2Mjx9OXNJ4iz8v+6ia8IxtaAwwQMVX9
	 xPSMG2kn8wrqsRKC73JYkHWIr0K0mrC9mNw6c59+EnZASI/4JBN7AGnBDXM3ZuDKNI
	 GkhaJ9XPGX3+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC1C25B7E;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 18:19:51 +0300
Subject: [PATCH v2 3/5] iio: adc: ad7173: Remove index from temp channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad7173-fixes-v2-3-8501b66adb1f@analog.com>
References: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
In-Reply-To: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=851;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=qHzAb3Lr8QOhPoRlBg0Itkn9NRPMWDsCz2unbRqp8RE=;
 b=m3a5lXaIuY0O7Uj3Tmt/3OKUjtu4tmQPul5KaV3j+ZXB5YLLGDyRzOt0+Hz39iI2piR38CwkH
 56VwciTgcX7CemA0yuFV8O/swPwe8NrwzwFH0E5Hlq2nImv2OiCWoYD
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Temperature channel is unique per device, index is not needed.
This is breaking userspace: Include fixes tag to be released within the
same rc cycle.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 58620be41ef5..eb512878c30e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -815,7 +815,6 @@ static const struct iio_chan_spec ad7173_channel_template = {
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 	.type = IIO_TEMP,
-	.indexed = 1,
 	.channel = AD7173_AIN_TEMP_POS,
 	.channel2 = AD7173_AIN_TEMP_NEG,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

-- 
2.43.0



