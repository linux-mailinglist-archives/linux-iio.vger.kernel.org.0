Return-Path: <linux-iio+bounces-7692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32100934E5C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2407284DC9
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB9140378;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3MU0G4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98213E8B9
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=o6P+OxsnphrBGMBn4KLGOGd37Hu9U2iHcNYzEqhhZ2Dvl0s7i/BmP0ASp9Q6O15yKCibwOuUB62afz4cOJDDo9m+yCIyfeVBRAdGoY+RgVMYTOPr0hF5pF6Sok8X3ITpNG/gFsZdBfIme2Dm7FN5bFpHOurx51Ej10ulRPkQjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=45TS8RkS199cSqf+bQSzXlP601ec3UlzuKJdaG/BQ34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSNkbFxb/PZ+Xbc0mlMISfVCmdRm/SF6iRkfKbfovHKDZxgPUAfXKb81Q80ekkDVvb8ClOZkzWcPkazKrstes3cqO2k8aQ8nDXCo9lbCoHbduv1qfVvx3ZLNYe4R93YGlfUJOB/9nDR3ae+f1ebJXUmMmygNApDCKGcV9OTXyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3MU0G4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CF30C4AF60;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=45TS8RkS199cSqf+bQSzXlP601ec3UlzuKJdaG/BQ34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i3MU0G4o/d2pvTurpYTVBUcNRHKojCyACYzI+ZiB3/PWztz2MAyn6+aO/kvJ1ZawT
	 5dx72eJL5ddUej77qc9HzPRiVSz2lW8KFoYrutBKo1O5anlGYcKg+BQQgdWSl1YHrq
	 X1SJbx9NjddiFgK+jfX0JnTOHLrBRPGW7/aTafT5VqVEbyqilnAgXIWzjk3FXpeUo0
	 cWV9xRok/25o5V/GApkOoE50jcbvZzO8fiG3QWrNbIikdPImO9vyROZIm/qxdg08R8
	 PjqyWrsr+5cgOnRS/y+kr7NvqhCNgBLlV7w02pM86EmBmPu86uPCnG4PxKedvc7D0g
	 htv8Fgca1czNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D3C3DA63;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:00 +0200
Subject: [PATCH 14/22] iio: light: isl29125: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-14-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=899;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=44r1OBRTeVEJ/5KHZVThUvH1dW1shD4ej8y1KV3icWw=;
 b=3uR4X54aZ70UqR04TwiESV4WFPo/WoLMFnVDSgzhLJzHMYCMs1gQqO4QjKe1HvVgXICyXouTy
 WSm0Oas/rkKDEn6ViCoLXlQq/2lo27TK9TkcL4QAmCmHtlI2U/KOnN5
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
 drivers/iio/light/isl29125.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 59329546df58..b176bf4c884b 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -181,8 +181,7 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
 	struct isl29125_data *data = iio_priv(indio_dev);
 	int i, j = 0;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		int ret = i2c_smbus_read_word_data(data->client,
 			isl29125_regs[i].data);
 		if (ret < 0)

-- 
2.45.2



