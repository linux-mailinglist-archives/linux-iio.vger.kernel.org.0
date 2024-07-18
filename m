Return-Path: <linux-iio+bounces-7701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A8B934E65
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371771C228FB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F501422BC;
	Thu, 18 Jul 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH/fVjtk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9413FD86
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=VIgn3eFgNPcp+Dih/0zat/+yISK5PIeiB6jre+BQ/bBZ96lkt53EoN4GY86I7PPiE5leGfUwUhckY+LX62WqvlwJb+Sjfvv+ObWVgl13ywZGU1CV1fRTXAGDskjehNxUR0V69NFSuT5cr1pmfI0RstUN5bfHVcJfaYMRxuuFiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=rv1eY9EO2BNh+lSmQQIl2m9zN5xt/7jDSp8YwaLtmO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9D6vKNLJmVfl/OMs/nQVGw4ovpSOB37gpgqRf0ldInCIpKpC+htBbJ5cs9/HUwedjEhm+5My29cMQFf0zdYlM/5z6rONgHkPM8aDAVmWdClOWVcaE7K3PIy0SwD5C+lvjBT0BJ1rfOpkSQUVoJZbE8HbL518H3OvOSeF7A7Exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH/fVjtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4BA1C4AF0F;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=rv1eY9EO2BNh+lSmQQIl2m9zN5xt/7jDSp8YwaLtmO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LH/fVjtkF8MyO9rawSIT0SlzfvoQfN9kf/9xoiwZfwOe709jRVkwFDsqacaJuPSGq
	 grO4psZjKTP/ml885UTIlkk1iXLRAmF4GNk4F/5nIvsi6UiUMybLFwSWQGYxjXji6j
	 YTDrIqIPFoHgMS3dsD3+jx0lHzc2gQSAyh1qzp9bn7jgXwGLXR9DhC5XWd92kvzWmr
	 +YX5/DLww4pp3xOwjwjGOqVHJrO/K0Uq8UZL3whs8XtCXBjwCxdIL1ywcxGeWDhFfR
	 7F+mJsOhti2wa2OOsl8VkUzQpoSRf/JuMqA+3MB55D9hpCRbKtkDijHoqIDbFDms59
	 dmkqtJle6ZVbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D776C3DA63;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:08 +0200
Subject: [PATCH 22/22] iio: proximity: sx_common: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-22-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=1313;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NYWZa2/XbLLl1ArjhpZ1nSWe6IAZWkml4RKT6VvzD7U=;
 b=u8mmgUBYXjarv3tjrit26WZcPRYGU2UZ90hedz8bkTFDWCWbVuWtwSe6OL5UGBmHoaNWXOZlu
 ndxSYU+hs/dBWluJWGbam9H65JvN7Esn9VWxSJr25rSI1IBqyfYN4u9
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
 drivers/iio/proximity/sx_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index a95e9814aaf2..71aa6dced7d3 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -369,8 +369,7 @@ static irqreturn_t sx_common_trigger_handler(int irq, void *private)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = data->chip_info->ops.read_prox_data(data,
 						     &indio_dev->channels[bit],
 						     &val);
@@ -398,8 +397,7 @@ static int sx_common_buffer_preenable(struct iio_dev *indio_dev)
 	int bit, ret;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength)
+	iio_for_each_active_channel(indio_dev, bit)
 		__set_bit(indio_dev->channels[bit].channel, &channels);
 
 	ret = sx_common_update_chan_en(data, channels, data->chan_event);

-- 
2.45.2



