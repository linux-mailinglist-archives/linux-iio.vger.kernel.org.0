Return-Path: <linux-iio+bounces-7689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1237934E58
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B24A1F23B75
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871A13F43A;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyfS79tC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9213DDDF
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=PPIcqROhmqfTR3kfGK+jfyfB1qAtvqtgPy0h4srIP/RVfqP605R2OHw7Tb4HRcBLuOrI+yywQlNZNpQryQOvzlYWBr7P4zvtpRMtfGEt41iYXudu6bJMbTe2ypuMzPmIqVaV2i8B4UQjggiUYBbXg0NKkDsBe9G0sJcW0nih55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=I5AfYMQAlEpQyOmlRKg+FWIU6S55d3uDdSFskbUiEWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBRzh4ETLf/KfKZZ4B2/DAtt4cGI6Crl3bi5jannPjVQ4JeDb5KdgcT/qBA6ejrVYH43UGppudjBHmDfzTF8EC7XDnfaQ2TEdvwIruuQd8zNFzsM6IyBC/VA1olxohhmr/WE1gTb3ngiXh6ERaynD4NHAvuLnJ2ckJg5ZoNL37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyfS79tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA7C9C4AF48;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=I5AfYMQAlEpQyOmlRKg+FWIU6S55d3uDdSFskbUiEWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eyfS79tCsq5y/5wMKSDH0Ie5lROvJA1xn+OasOjbiDfb5+x6b3DfF2uhI71TfiAPO
	 U8Tjb2W0kTQb0DFvv0OECTouF/FHRyrJHt0x9o10j0LOgP1finNu6n95AK2wLy2JKM
	 sn/SSGIkzptuf6yIWqp4Veb0fDQlPdirjaWTXJgU7iRuHwim7my5ACMXkx2r+azzBq
	 1X5+B5xDWXvJdNnwP/vayZlo/b9rxoUTgUcKd2dZNTIlaABbdB0f31RkMeQkqMgLSk
	 H1vkeilSvvdG8rT/MvRSR0Gcwa4qEyy/b6rxNy4mmdTG6HtySpIBomPtjfRsbHUb5K
	 M0HIBM+I+SU/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E24C3DA49;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:56 +0200
Subject: [PATCH 10/22] iio: imu: bno055: make use of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-10-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=875;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1/XFhtVL5DGGEIfobJIiiBmxQTyc/mcom9KHRuSBMrA=;
 b=m3bFh284R2Gbd8u35dz8a4JhrMysfAJFI0MrGa2s8veAnk2+7opnBOFka/X4WIVTrSjmj78QH
 MTlzRQEAIK5CfZrWJN8lmaoeXtcFckO/r9rfCuXoEznZBHV5OC0eu7P
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
 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 52744dd98e65b..ea6519b22b2f3 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -1458,7 +1458,7 @@ static irqreturn_t bno055_trigger_handler(int irq, void *p)
 	 * then we split the transfer, skipping the gap.
 	 */
 	for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
-			      iio_dev->masklength) {
+			      iio_get_masklength(iio_dev)) {
 		/*
 		 * First transfer will start from the beginning of the first
 		 * ones-field in the bitmap

-- 
2.45.2



