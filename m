Return-Path: <linux-iio+bounces-5036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490E8C4CD8
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50714282680
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181C3610A;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1YPvxU3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842628DC1;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=aBJ6yN9qB3xM6qUAhZWtuRkWQGm7n/84ZBUlzqsvZVkG/QwWzaF+JEg9KrPVdYnTyVIOrx5C4eXNCphfCmMLDXvPCTUjGV+gaWL+cuVMM15sXfnnP/USUNGCoogkhG4oiJ67KhZH4kRoCpijred+Wth+PYFKiOsjN3gxLtmtXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=CH6KEJHDJ5SKHbuQjpX1KVB6R0zspN6qqhSuvnA4z9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9c5Y3zora1duIYrn/K64Vfqxj+pnPHSl8HFQ2TvypgO46jR7LHMJyzKXPYb8N+kYjVWED1xg0y6XvpUn1nAroKTTbeB6PmRxFrcLOJniNVihQQjEwngss9eiw2cHAc5v5FS6LpiLtjIBln3b7mLXuIeY0HyqhTiQBNprM3iNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1YPvxU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90A08C4AF0B;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=CH6KEJHDJ5SKHbuQjpX1KVB6R0zspN6qqhSuvnA4z9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G1YPvxU3XQYBf+KAqC5WT/AqUrM1nHwcuwQnrKPeV2JwzWhUWOKaaB+F/mbf0A3eE
	 WIHmKYsii6XrlVsiUodq7epa6nAD0UJEt5rdzpfaSEwYETHTLC/HXqO1i/DVcc2paW
	 Fc20WD0nPVlXtZOJEBtYceKqlTnsD3ebUt/QHd2ih5o5qT87f8oYKKlc1MFroPvwt9
	 J55/OgnvoKYijhSnxPevFR6gsceKer46nA/bQhjiMfLlWTSUPSSe4yZagVnAFbFXfD
	 tLicyOcXggvG1tbfW6BSAWKRa9UEYVdag2NoWXgt5Gh4gNKaxwP09IfH5BZlPgzJVt
	 +HHLBJ779QDVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815FEC25B7D;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:52 +0300
Subject: [PATCH v2 7/9] iio: adc: ad7173: Remove index from temp channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-ad4111-v2-7-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=818;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=PHSKNobPRYt9MaauQ24UkVzLnDgB+hq+gyvloguiHrg=;
 b=HMYGVrDTQhYns7yYxeY3C2C+OvnbjG9Ge3+00rD6BtPfU6yLR+xjZJdaBoVGHTQmFqNA0LhOP
 p3dddLpMVYZD+Ltf7gQ1xEtHRSSSPbvQ9p8nLhWvPEFjzv0X1riJPrA
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Temperature channel is unique per device, index is not needed.

This is breaking userspace: as main driver has not reached mainline yet
it won't affect users as there are none.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index d965b66d4d5a..d66b47e1a186 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -828,7 +828,6 @@ static const struct iio_chan_spec ad7173_channel_template = {
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 	.type = IIO_TEMP,
-	.indexed = 1,
 	.channel = AD7173_AIN_TEMP_POS,
 	.channel2 = AD7173_AIN_TEMP_NEG,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

-- 
2.43.0



