Return-Path: <linux-iio+bounces-7690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2ED934E5A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E8A284C60
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55A13FD8C;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0hqtEdd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AA13E3E7
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=rz6rqvH/kcBXQ8QGhNUviKbg5rCMrLUCnESTyO/XUcDJy9vVgFxnbfOWiYEd0LzPgRhGrgz9rxm/49d3v/1Vq4d/h28dr1unvhCPHn7JuXXeVXdb/qk5jUOJcdrNS8CCNWwLRdUzE2a5JkhVqt9z+NNxKAYhTXIVvOHSyjZozqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=vwHm1+s8MZtQBVXyjwCqSe5P3D4ZHVEifY6/zt59ycw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpIiPXuAzYwl0hSgfXxq/Scxcpc6jFdsHJH6oQ0Wq2O8IuQ3Hzd9dw19VTA+djWhOMmX88aZHRYVIswfEaW82PRo+8TGpgqj5WydpU7ElreIq7+qY4aq/axk6lltgS7OfBktRGbwBwjWtSNSwZZvHZC9ikyWk4dFEpFZ0NtBNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0hqtEdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E396FC4AF4D;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=vwHm1+s8MZtQBVXyjwCqSe5P3D4ZHVEifY6/zt59ycw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C0hqtEddwGKdmgSTR0bh1IFL+IE4se9/hzSvYR5ez14nnpDEQMaXh3rJa4TdtZOY2
	 DKn2rnAswYHt2NGOnkpn6UG0wv116sYY7jpFK+wON+0O8qk/w5MpZi2SmxXA1MmRQv
	 UY4+f8QG1xvDkHH1ZIFFA4Y+mAt7qZ7snYbnn/MGtP/fJ/pcSC0dwf++TB0PdN8vyp
	 ichb+8w64DNcF1hgtiS0jVJnWfOHLVlb6qyd5L1RJjO8uImpwZtDjP35Ui7/BqUfDm
	 PM6EtEMQ9ZFM/lSrtoIjyV36kC9EfTWgoni57DVFGoY+2P7DJee1NWRb65evCfC3o3
	 Yn8D/ZigVFmOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD69DC3DA6F;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:58 +0200
Subject: [PATCH 12/22] iio: light: adjd_s311: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-12-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=864;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TSHQtCAOvetS9PFuXHMtMqGj6a4Kr9MMSY7AM7lvy6E=;
 b=Ochlt3MUUEAbTKL3DZ+k2tTqiOIXNbQgvZgyAeiR73Zee8PSejrRu3z6DifLNXJhZsanab8xM
 kSIwYxFu1JzDikOBLBG4YLTmKtyXRUDeUnvltLAgo87N5B5A+nOj6p/
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
 drivers/iio/light/adjd_s311.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 5169f12c3ebaf..c1b43053fbc73 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -125,8 +125,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		ret = i2c_smbus_read_word_data(data->client,
 			ADJD_S311_DATA_REG(i));
 		if (ret < 0)

-- 
2.45.2



