Return-Path: <linux-iio+bounces-5923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB758FF1A6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7A288E8E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167D198E81;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcmM51XP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539F19883B;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690062; cv=none; b=gZubbcr7vaq6Z8lyvRr2LsQSPZer1U/OiRCdnzpmZSo1iHs8+8Qan8XLQQQEF/EdqjTaIHTBkNZ0R21hriJTZl+Wfb9PjMiUSG8suKzT7nCYxzBH31siEpEGskqSc4Sr/35zslMX0hH9Fx+0hfKCOV/FBqag45pfum5SKSxF/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690062; c=relaxed/simple;
	bh=afsv2fV0gtzsJaTkVEd62/Yxe4pe2uQVIKmzH2c38Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEGwidWiHvSeNPJBOShyPc+n+DvqJ5xdK3yrQxN+sH85yVGfJ6lOfLnJP7hDnCJRscaY1yLf9YRgQt/Qvh7Rkww1ZOcvNx8SJlgr1BhBXKKyOxfV45CtrIba8u+UEa2/E/rjqx33XFkArru5htj/y+xlTrKYgJ5oDevppovu5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcmM51XP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C386C4AF1D;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690062;
	bh=afsv2fV0gtzsJaTkVEd62/Yxe4pe2uQVIKmzH2c38Kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gcmM51XPsZSAc5SqZIU0hg23qK7Z6i/xP1iNFqM9NWNNkmP7R7z6vUVU3eaLobSvT
	 sjnTFNDg95WAYld+m7/rEOSUYDIoiUF4Kcx/ElKrwN40Jhfphc/xVUUr99GgZXJmfM
	 164qO+BsOBZ5q4rVsyEldc7vgrK8YIynlx2cHMwORgllgu4L9jFxNZHFopGseDUalz
	 5vliQLpLF+5fXILS8Xmrh03DlPXItSk0SHHqCLlJA5+7X6KYNFDzv41uApy9hpJm59
	 e1bxV88Ezi10OzxGSZa5PO6ga0CuP8+FYJW7mNoNzlDdx40md4s+mwlhxHz7Hq9WaF
	 VSRdjwc16t+8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286CC27C65;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 06 Jun 2024 19:07:47 +0300
Subject: [PATCH v6 8/9] iio: adc: ad7173: document sampling frequency
 behaviour
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-ad4111-v6-8-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
In-Reply-To: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717690059; l=1618;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=5A7meMN974lnd3IZ+v3+YKzX36bmXGBNKl55VG1TWLo=;
 b=vhbwHZSMdCRyNA8RxOKXUcNeTNqYZaTz02kVQ4ip3JBIQveKFzYY1sJ+/GiVnaj/IOe/cUelS
 CDjv3IwJYyVACNS8MObykH3YVHBttwhyEbIsblfE87VnjnWr4Q+Z8rJ
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

The ADCs supported by this driver feature a sequencer that read in a
loop all the enabled chanels. When setting the individual sampling
frequency for each channel and enabling multiple channels, the effective
of each channel will be lower than the actual set value. Document this
behaviour in a comment.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 8d008186cd6e..58da5717fd36 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -740,6 +740,21 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (info) {
+	/*
+	 * This attribute sets the sampling frequency for each channel individually.
+	 * There are no issues for raw or buffered reads of an individual channel.
+	 *
+	 * When multiple channels are enabled in buffered mode, the effective
+	 * sampling rate of a channel is lowered in correlation to the number
+	 * of channels enabled and the sampling rate of the other channels.
+	 *
+	 * Example: 3 channels enabled with rates CH1:6211sps CH2,CH3:10sps
+	 * While the reading of CH1 takes only 0.16ms, the reading of CH2 and CH3
+	 * will take 100ms each.
+	 *
+	 * This will cause the reading of CH1 to be actually done once every
+	 * 200.16ms, an effective rate of 4.99sps.
+	 */
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
 		for (i = st->info->odr_start_value; i < st->info->num_sinc5_data_rates - 1; i++)

-- 
2.43.0



