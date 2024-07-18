Return-Path: <linux-iio+bounces-7694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEDE934E5F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB3B1F21324
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97279140E30;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0O50lN0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681313FD86
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=qjCJ3uA4fLEV/EyuyYaC8BqwCV/A3Id67rQhkpA21D0UjA/EMpnmpTL1Ly0j9W2oQaftdwtwEx8+AP5aAi5bYYm9FleAMTWz3DdadNBqMEkVw/nMhhqqDPk96fGY5AwbJKiqaZzCdx4QH2S03hxhvVOWxuFvK7NWh822pRGLTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=hnw4D7tYJs/lNUG7FxnAHQ2n1aujDPyAd3TKm7yRzNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGkcWs17zc0yvEPyWSsRON+ckqshcUl3O3X+dPfg1Or2jiquiUMt+G0EW9uTleuO5wEJzxMco66l+HrmgGAQFvsPV2nTCwyO6MpLyTYHXpLZHiqlhNIkKwxGTHkUByAiyST7KBm+fPZoX2+g1wd0NCGcS9x1FVCR7aG+FESGix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0O50lN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D82DBC116B1;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=hnw4D7tYJs/lNUG7FxnAHQ2n1aujDPyAd3TKm7yRzNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V0O50lN0HbvhtgV8/2qFKw+I/d3qHxWq6kk4FPZI5N5p/rf55EwOu9gsiTjPKSTHu
	 kr2PLUWY0rMfiI0M2iPoOA/mtUu+3jvgg0pzz90/tYr21il+lYqNB/OP0tiDjzVs9b
	 lTmzbfQGJBPqJ0IWVqWb4qv0netHkE/caYz9k1BtQfVtQGMy5M2JJVYN957x4a4wEi
	 NyEZsmOFW4MsOsApibfQz2Y2smwtaQJdjsn6xc2glJhdVCkN/Rf1DarkvF29jNvrlf
	 FTLNjBvuBY9uTD+TTThEagVSlsWfPSRBmaYpKuxgBbWU4oi+zsgmujn7e6CEWT9p/P
	 5rmwM7SX+/r8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158DC3DA63;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:57 +0200
Subject: [PATCH 11/22] iio: imu: kmx61: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-11-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=869;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ggyixMIF+6oukTLiM3iRmoyaIesgRCWO8VE0DMlpAmU=;
 b=29DDxZq8ouN0wfai8KNE5f2bmxSOgwxe26gNJUGhNOBvqQC7tl3Q4ycsxB0mpMCgWmLKEIgoC
 3OQtLIwVFxFDYaRTLJ4/PHBiNSzfkKW0aY+erQemUMed8sq8ejCWnni
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/kmx61.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index d37eca5ef761..c61c012e25bb 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1200,8 +1200,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 		base = KMX61_MAG_XOUT_L;
 
 	mutex_lock(&data->lock);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->lock);

-- 
2.45.2



