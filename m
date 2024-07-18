Return-Path: <linux-iio+bounces-7686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F16934E56
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DD21C22727
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E013F426;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUrI2vbS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151913DDCD
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=FtboznfGCETZLDDQKKRWKSEaGBvmf5ued7ipgaOcKXcbeRMoI6x6FNp3jSt6iAYoJQ5GwpvLKzINd9ffomgYG/J4tZe2lkpeFtC6/Z2FQxho5TefZnS+wKDgM0m8+4VibXf16s/MHGYpCw9KF3ePiZc9C52cX6mSgw2D4qYLXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=QDfskd2Rn5sHaRakewp2koWwwbec4LNG3BpRSildkBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFKOWIYgY7jTFFD4kL/YOVybGZyjGe1Ij6qUQJaY8m/EqhUYS8pShwZybfXCeem1mYiMXc2R1onNBD0f0eKURYVeCCS/3Gz05qzZl1Z5gIoalEb8k1+KgUui+qrRvFV3/Pb78J/qV2yfFP4q8cf0hnINC73Zdh6A+2mTkCzReX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUrI2vbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84E54C4AF16;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=QDfskd2Rn5sHaRakewp2koWwwbec4LNG3BpRSildkBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GUrI2vbS57rikAUupMDAUSUD2vcv7IhJCIjTwtQiwpXRNVpm+iep+KDD9s2Rekskk
	 qJ7NTy3/nqd1f2vToa//YXUAcwdWlWuv+8m5JfsnV1EtunI3zPWaBcLMNEin6DFkRY
	 cF/YwtERdbNqBkH009aSwmz8sGRn2/04bDwBKmcj+t1odFgjtmHah5psD2v5feaqT+
	 mBxeMEFYndHyXE6sdOVFwmTupcvAJjnrFccE8QdzLsAeQxeVz/u4K16NvLjG3bclj9
	 Tbp9+24z8IIeW/x0oq+yT4/Jxkr+0KERIbMUad0wrR2sKbMkn34QEwX4qYi2zulvwp
	 O+9sXM0mQNs+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C276C3DA6A;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:52 +0200
Subject: [PATCH 06/22] iio: health: max30102: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-6-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=863;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5H69UJpKUwhjYrie33oP+IHHh9ZtV6RkXSkhlBGw/AI=;
 b=LJwYzuHnG/NrWF7XM+KhWCZVueUkEEQ3LNJ2lO7iP/9SoPXyXwIZtaGzQtgRrFuLn/MtuBaW3
 o8AR5sFGOstCjFKOxJtlFNQz096VzVTFA8XKJXSday3GOklaQUqKW58
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 07a343e35a81..1d074eb6a8c5 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -293,7 +293,7 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
 	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  indio_dev->masklength);
+						  iio_get_masklength(indio_dev));
 	int ret, cnt = 0;
 
 	mutex_lock(&data->lock);

-- 
2.45.2



