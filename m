Return-Path: <linux-iio+bounces-7700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C8934E64
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9801C22856
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF81422AD;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLqYeiuN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01501411EE
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=RiDohNNR+M7cHXNUn+repBRFwc8sJuFP8KyxUMq2tBx5wuSw8CjfrYhyroI9Ow1DX9L84XUDVuYrfefDAkQ91GDyHOOreaGeQUghUrSz93bfW74rxmZInNjFLFJWFhdH0iBVXelQf5QWsFQszvyLVnNVyoSD9dWupU7eVXxq/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=yZIam3yx92XZW+YQhILDtJcsiTNT5eUuTFoZVW0jIpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HeIyDtyCAvzqePo/G3B1Vw4WehHQyD1Ka4jOQ8RPvmDkV7/zdO4Dd3BR5vaniq8XwJRm6wcJ4WCwyJTtRJbaj/qLl4wEW4/7KymYZ7m3Dm2veI+5Ui462Xi2WWr57NLC3uafut1uOeXSlv9AaOTlxWZoU1mIz+0uLbvWAgN7V7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLqYeiuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 940CEC4AF1B;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=yZIam3yx92XZW+YQhILDtJcsiTNT5eUuTFoZVW0jIpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MLqYeiuNHZIchs/4UbD1JTFAw1dLaBvvwwZKIf925E+WTJh159DnXHa9Al6Nna1LE
	 NTgi7WdQ1SiWqPLJ+dZgXFX/Iu/jjcPaxrobVBSUOaueutsT2cECrFTwl0qT490rO+
	 tmNbTo5zpo3QxEfnUYr2Daox0unpu0LMefNdDYtxhBIZuXNKlvxM/md9vhnyZ/XRxq
	 ZVl/Bzha/2FA/3URILp9V5dBId4aCz8zs5bbrynbINJxA8Y6joOKOt7/QEvfQdKvF4
	 lOm/Qx4RnYhx9GVfXtJGVCEgRFI9O8lTJ7y+K/xihfEjWn+r8Zi6g1Y8Bu2dYtsWbt
	 s3ldESATFoBVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA79C3DA6F;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:07 +0200
Subject: [PATCH 21/22] iio: proximity: sx9500: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-21-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=882;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ow/lbjAF7xbc1nHR62ZbO63cFYfGv+YoVHj29IIfWfw=;
 b=uOkhJEJu+o+1RnNZGbnQMQ23zi/TQX9k7PVWN3vAGC3MRgX2lRd3VaqrlxcuydrtyW4TbXhik
 m5HmY1HyyMTCozeP8a7ODeW6TpUENNfo5c1teG1w/gcJwfP3v32Km/j
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
 drivers/iio/proximity/sx9500.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 92630812ece2..3f4eace05cfc 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -654,8 +654,7 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sx9500_read_prox_data(data, &indio_dev->channels[bit],
 					    &val);
 		if (ret < 0)

-- 
2.45.2



