Return-Path: <linux-iio+bounces-25028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B75BD1F43
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04AE4ED935
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1B2ECD34;
	Mon, 13 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMTWTn+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281CF2EC08E;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343148; cv=none; b=AYT8BT2RXUlJNq8TMwAG7+m9J6VohnJQEjD91RtVqY20qBuRI7jywsidY2tOPhdUaWiWFl2UMoP0ofbFCG9HjnwT/ttt5RFPNZ/4UPeDD/60IaF7WorvpMtLxTsxMs6ApRLNUwIE3k7FYTaQvi579+hMB2b/IsccXpxcAr3AHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343148; c=relaxed/simple;
	bh=Q9TzgMoAejlDFlmZ5G079fvuQS5MtL4UbyrPJYcppzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IG5SYRUBitk1+DpirNNW8Fc8vuht1RGnKjKVv3Tve9Qy5YEga1TVRbcjLQga475aNNdDz7lhbFoMjBKJE2VrpzcW+5H8a2Ryqg0UGPUjPJCkonFrf9mx8ZuxUYNn2X4hSyH4AV6DmkM+nFXmq+vEhJ4leoDjUtKPACCJtlKYKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMTWTn+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97350C116C6;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343147;
	bh=Q9TzgMoAejlDFlmZ5G079fvuQS5MtL4UbyrPJYcppzc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qMTWTn+INpSqUpsw66qn2dU0ejKMAZfMB5tJ26WYXQcwGejutrBH1Declxq+DQu7I
	 lJbmAf8sn+PhAKB71AijRWV/i4Z+OZ1spuN9ed6I55MhRz76Qr+VgaWJcnYWFzZJiW
	 WwKPRQI9LUmpSRPkCEcR39SRXx0cEOGRL1Pk3FgKiVoRCYAMKHIiPqXiO5hvwF6J4L
	 4fAtbjVpHOWydK0Qgh9Ow2uERWqKLqSEdRIQsPLrZihviEHYv5w6w0ws5LwIhXwgcb
	 2P/3pKZuU/B/lmrp1dXRIkPVq+peMTooDMME3G75r+FlFJZUt6KoJdf273qQriGI7q
	 gWPKZELpjx9IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F53CCD183;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v3 0/2] iio: humditiy: hdc3020: fix units
Date: Mon, 13 Oct 2025 10:12:24 +0200
Message-Id: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGi07GgC/23OwQrCMAwG4FcZPVtJW+o2T76HeFjbaAO6STuLM
 vbuZgMRxFP4f8iXTCJjIsxiX00iYaFMQ8/BbCrhY9dfUFLgLDRoC40GGYM3wPPR05jlmZ6yVRi
 ca7wPUAveuyfkejWPJ86R8jik13qiqKX9aOqPVpQEuescOG+s8RYPV0IXMaWtH25iAYv+Ii38R
 TQjy7um6ZRtVf2DzPP8BqlA69j6AAAA
X-Change-ID: 20250820-hdc3020-units-fix-91edbb8ccd07
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760343146; l=1432;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Q9TzgMoAejlDFlmZ5G079fvuQS5MtL4UbyrPJYcppzc=;
 b=juZNio1LzXN5fafKQhIIT7T4eSqo3PTXRc+NPXmYQahkQ7XX4Qg3Lf/fyiiv57XPAT8FmTdHA
 ti5K4zIBS/JAjiAW7Iy9UP31YkRbhIZd6p17scYlJj4XNiQlU9N1D0l
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Fix units to milli degree celsius and milli percent for temperature
respectively relative humidity measurements and thresholds.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Fix verbose comment for define HDC3020_THRESH_FRACTION (Javier)
- Embed prescale into define HDC3020_THRESH_FRACTION to make the division
  by 5 calculation in threshold calculations explicit. (Andy)
- Add resulting units into comments again in hdc3020_thresh_get_temp and
  hdc3020_thresh_get_hum (Andy)
- Link to v2: https://lore.kernel.org/r/20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com

Changes in v2:
- Added explanation what is wrong at the moment into commit msg
- Added define HDC3020_THRESH_FRACTION and comment at the beginning of the
  code.
- Use MILLI for instead of hardcoded 1000.
- Link to v1: https://lore.kernel.org/r/20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com

---
Dimitri Fedrau (2):
      iio: humditiy: hdc3020: fix units for temperature and humidity measurement
      iio: humditiy: hdc3020: fix units for thresholds and hysteresis

 drivers/iio/humidity/hdc3020.c | 71 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 30 deletions(-)
---
base-commit: 875e7d357a7f2e77a7f3fc4759d0aa0872c33027
change-id: 20250820-hdc3020-units-fix-91edbb8ccd07

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



