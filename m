Return-Path: <linux-iio+bounces-7931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A79393CF95
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91FBB22D8F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72117839F;
	Fri, 26 Jul 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbRw6Amg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF917838E;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=q49eS38GJhd7oWhBvqM8noSpkiseEXuNQ0HSSfsc779esg3zL560yAXuZ67hCHRAVBXwuMj3qDUwnfuuwmlPdcb008w6S0OKqU26fIhdAkOIk81rpoCmNv+7rqH8zMc3XOlh1oU/D3gTlncDUphHwqeH3m8LhzPQthsyOoUDvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=e1JekgmyZG6de3n/s2PZl+MtdBPsp4Mjb0OhK+wmryo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncWwOTkIfyI8win30NOxsvM/dtoBP4dl0CRCPFUMq+6NKINeFEbrbVhB2fVTsO3brt4lANx8e4vPpvSQOABEpuGnKSJanaBXklymI7SfCHZp6jx3oQR2MhnT7pi0TTOQ3gPyXH5J5wZTChHVyhcAuv91Y1aCqsM8W62i7wxNiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbRw6Amg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9860BC4AF0C;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=e1JekgmyZG6de3n/s2PZl+MtdBPsp4Mjb0OhK+wmryo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bbRw6Amg2U2t72MfzD5xAXm4xycNjIOGj/I9TOGXpW4OWE2qIOClDHHVMehZWbApj
	 icOu3CYJirK6mHGCzGGhXXjicb/3VSzSIJtZo6c8aj3ZUILId6khaNhuFqe6vxqWYZ
	 5kSWXhvj/EvSnkRUG/aU+acr6mYFZpVaDagSMeKeHFIdYzZw4h6XvXs8f8iGAmBavv
	 ogoE2n6KLBBa4zaQsW4h6xE6UVUtBfs8K+StLae0ghsCdmg9YsuTMBWXaRweJ2rI3U
	 PD/wNlC0Ik0fXEY9KeeVqwU8ne1d2ReOAUFQlx97nAp48YrbjULOKA+5PJTMXE+PRq
	 o9QxYydDKw41Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81EC52CDA;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:15 +0200
Subject: [PATCH 23/23] iio: core: annotate masklength as __private
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-23-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=1709;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=j64bS8AlbPEaXDKOf/24fcP0//ABTNMV+H57fOfioL0=;
 b=SqZqmPuN3DkvmQIpd3N42mKg1nerY7jzP7iAtnBI7wcyiGwg8NfCTvLb+HIxSYWS2uqA7Xsk+
 GnOcDRGd0Y7DoHUHxvqRqJiMfulWw0FRfgtpb+Y10pKwol9SoVNnfI1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Now that all users are using the proper accessors, we can mark
masklength as __private so that no one tries to write. We also get help
from checkers in warning us in case someone does it.

To access the private field from IIO core code, we need to use the
ACCESS_PRIVATE() macro.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 include/linux/iio/iio.h           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 3d0b1d25fdd7..8104696cd475 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2269,7 +2269,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 		for (i = 0; i < indio_dev->num_channels; i++)
 			ml = max(ml, channels[i].scan_index + 1);
-		indio_dev->masklength = ml;
+		ACCESS_PRIVATE(indio_dev, masklength) = ml;
 	}
 
 	if (!iio_dev_opaque->attached_buffers_cnt)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index dd6bbc468283..f6c0499853bb 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -609,7 +609,7 @@ struct iio_dev {
 	int				scan_bytes;
 
 	const unsigned long		*available_scan_masks;
-	unsigned			masklength;
+	unsigned			__private masklength;
 	const unsigned long		*active_scan_mask;
 	bool				scan_timestamp;
 	struct iio_trigger		*trig;
@@ -861,7 +861,7 @@ static inline const struct iio_scan_type
  */
 static inline unsigned int iio_get_masklength(const struct iio_dev *indio_dev)
 {
-	return indio_dev->masklength;
+	return ACCESS_PRIVATE(indio_dev, masklength);
 }
 
 /**

-- 
2.45.2



