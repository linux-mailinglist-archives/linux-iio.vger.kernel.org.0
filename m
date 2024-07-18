Return-Path: <linux-iio+bounces-7684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C6934E55
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1353F1F2368A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA313EFF3;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBkZTNsV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2313DB99
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=gYpbVvyQFRN8hsnIrnoYcajS5vWRhXLZJIKiSWVqFlv/FoJS2vjdvuCtYSK7o7LIL28lgoUz18alpXm05lVMFmRcrqIsuueYUF2yMPEaF57TUmKdh66bo11yQ1mcy2Inkm30hdrqBf81K5XglbR1+GPHbRKSq+t37r8q5KeQiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=ZIj87dEsNvr5PhxdEedZ7HdumCOccZVU/KKk+G3Pv00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOrWR0Oz98tqc05oL/EmjX5HOC+eUGpxj12ECJxDQFjhAqz377vQ8/CSCkhYtYwzjacd9adj6A1MUxmPVQJCltDm9ZnJpyQUx22dk9ncFuhXYptv8Cw1eS5OnPpDkICGd9YPyBgnM4tU5goqmQgJZRy/MOIV7VO3enf8oxRQt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBkZTNsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 945B8C4AF19;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=ZIj87dEsNvr5PhxdEedZ7HdumCOccZVU/KKk+G3Pv00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WBkZTNsVMvEx81gu8aS22OPRJsZRaCNXE5QJaq4a23C/H/IsK+fwQ0pxQMcLhIB+J
	 Axs2xpl6DECvK/7xeyVXz9/oRe1noxZVLgD5ZxkWZv1u3U2XSaMl0sEYmDEgfargMz
	 /P0niJx0MORg/0AlSBwhXgneKj1Zsg8OwMqwIrFfGJZLBNE2Zn3tqmFv8um/+vE6QE
	 qrqXef5csFJk3iq0fzx9kNmIs0E0Zs04XpdK++JOnO2B61O1n+ltVWQYciMB7m+Amv
	 9AvkwNe+DMsNPaBFBcr0SU4ZHxvNTmfgt5kV16BBvQr1DdcAO4czoCUdvzEfmcMFfU
	 Jrz/fNCYJFy6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0BEC3DA49;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:53 +0200
Subject: [PATCH 07/22] iio: health: afe4404: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-7-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=921;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=T8qh+PucTketG3iHEIzNlvaeE66dT5WhEuTq3tBVE18=;
 b=87ThQexREmQD9OsoxEDEcew3xLfOuwEiZ/+vDMFUHIcctR38EC2SAIhjO7h4nvlXa6+C0G2f2
 Bh2KsGXQzDPAm+ihbhwBddTlt+siBg3PVwgjfbSMD0yhrB4QH4fmNtr
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
 drivers/iio/health/afe4404.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 7f69baa1ed53..d49e1572a439 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -333,8 +333,7 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
 				  &afe->buffer[i++]);
 		if (ret)

-- 
2.45.2



