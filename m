Return-Path: <linux-iio+bounces-7699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE4934E62
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E791C228D1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEAB1420DF;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvxk4Nvj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3B140E4D
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=OwAurgNbbSqCwVcOo0oCIioqSgJoa+xRTxFav45gaK8S8lF47H2Cqr0yvR+SysDPW5Ws3uUanqfMBDZZQ/VJK32McwYdmB9mERgZODQ2VLeWUXs8qV+VzfTxm8MD8Jk2g6YHDmDSlFc7gWv4kDFjKbCz1iyO2eVG0cAA0sV3W24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=EZ9UZrCe/4YjLZnoVzNv/ARJNb+jViAGn8zxqAPbsuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hotbMLzLOCtprIMZ7MfYMXyCkD3XlgxiFZELf6m/cZqi/9oUn4y7yB6xYMPGjjSrWgbSv7+nHvPLNeYIqiSQ2+L/qyI8FISh51VqCt+tjTNRj1/z4TXWSHdbbCBfJLj/ALMtl28Mj+lXnHbWIMtuWHs05ynzEO3JjONWvCShH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvxk4Nvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80D28C4DDE7;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=EZ9UZrCe/4YjLZnoVzNv/ARJNb+jViAGn8zxqAPbsuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jvxk4NvjT69Nmuf1XFOanVrYxwjUmgLyNKCwNSITx/Hlha9s0M4cfKEgf7YUzPeI4
	 V1DW/+utwslhCHRPdd+fzzQ+toiXxtBz8oYmHt+oA+2sxqToQ0OOXnlEnHyYjcPqUD
	 arvtIKVK36m0vCcvWnZfogGSwZczZRDXQYsZXnybDFqjx3X24yLp0+1ZJo+R/U2TP3
	 GLkpd6sc6RQ/WzPaJ414WkfPDyHDlTMHoloykuc09XPNAoa+lBqi6W93F8RwXlE/0M
	 w+Th35VWz+eFAcNjdKoVMrLMXiKEpOMvxAYlpNyzJH3J28MN/lW4FEI5vHni6hBpbe
	 Gx+/yXxwcUD8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773FEC3DA49;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:06 +0200
Subject: [PATCH 20/22] iio: proximity: hx9023s: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-20-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=1284;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5J4ljVqvZC41+4k0k0jyV5NtbaiSrOltZERqD/amCmU=;
 b=z9I/xVnWw4qFt7RCBPr3WfSWATEcbv+auOnEzZcGbCIRTxpe155iqa46TsHlFgR+7T6QgZOKx
 X5Wj80h+geGCIpOzDaibaIzmQXzQyr3OKHvSoG2Jk25w3ZZ5h3u2crE
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
 drivers/iio/proximity/hx9023s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 63e3b56d4f4ce..fe14a62a13428 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -936,7 +936,7 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 		goto out;
 	}
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		index = indio_dev->channels[bit].channel;
 		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
 	}
@@ -957,7 +957,7 @@ static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
 	unsigned int bit;
 
 	guard(mutex)(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+	iio_for_each_active_channel(indio_dev, bit)
 		__set_bit(indio_dev->channels[bit].channel, &channels);
 
 	hx9023s_update_chan_en(data, channels, data->chan_event);

-- 
2.45.2



