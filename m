Return-Path: <linux-iio+bounces-7683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA16934E52
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C533B1F22E9F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07A13E028;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxLCGtsk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779413D61D
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=jv6ucugVvZkSqG2N4p3QRqfStjx9VZgucmRli87EUNMoGXa4gxPrIre4PjvMQr7MxS1+w/AsrJjw7DYlQPhqmMDFqpyT06eQfvI8VQmp5nnBS72yQj0N8wqVAlZIM2yKEGDYioB24azpyrMue/iwodYEkyCOZXMZ7JOhV+2np9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=rmd/tNcJ5Ty6WFn1GIPxuMT/8ivYAxSQAZwmr8zM9fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5bi7yJhbxda/OWHXjkaZL4vPDInW3jUsBzjxzIXtkMFn8k94Qzd1pbn6uB3QrT9Q+bGDEFlIEZOtQiEQw1gUyUuDJ6dkoagM/Hg+DkFOIV0NUKC3yDRunItt0/spD6FI01w4gk3sZ1Fw9m+OR7BunuGBo10lJTLCNzRcCKYkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxLCGtsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E5CC4AF11;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=rmd/tNcJ5Ty6WFn1GIPxuMT/8ivYAxSQAZwmr8zM9fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nxLCGtsk/WJfJ3GLi2Ij+SOYhXybfVaq5MtM7tMCIECEXWwX6B9dY36VJaXYQog0P
	 9tjDicMm2d0nohaXMsZrTw1ubY54hFxwe/7xR0QgzwWd5N5qYKu6m9l8YpVYezMG4n
	 DoMKWo2iZJiLr/1uHhiUpP30VW6Cgu7x5L6jYcoug6snJHMDP5AmWlCqXyN0udXSIt
	 os1rNGSi89BzylerSk8x8m/jzu7QsANN/l9/CLPtJSet0pCnnLn5X0mQ6BcpLAaf73
	 Xmn5RPvdpZDJgNPdsFzJXpGxe7u+teY2cNerz7Q35ouXYFCYc3o4v1CTbHmddscXep
	 8GEo8X49DbLLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC2CC3DA70;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:50 +0200
Subject: [PATCH 04/22] iio: dummy: iio_simple_dummy_buffer: use
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-4-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=993;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/UO8BlopWO9kmVPYMQiw2xtRzt9uK+mubBziqer1//A=;
 b=oXw9qCYMnxtytq6HBGd4NwY68O+4p10py3M6nZ+33FC5VQJ7Qf/FVIO67fEdsWoqP7BP3WmA7
 OEu7Uv6GvZEDkUcbXFULAQNYxW6CwAiev5zNjWbFAQGYj8lJRLGBXRZ
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
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 9b2f99449a829..4ca3f1aaff999 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -68,7 +68,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	 * Here let's pretend we have random access. And the values are in the
 	 * constant table fakedata.
 	 */
-	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
+	iio_for_each_active_channel(indio_dev, j)
 		data[i++] = fakedata[j];
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data,

-- 
2.45.2



