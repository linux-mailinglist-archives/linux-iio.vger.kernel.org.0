Return-Path: <linux-iio+bounces-7698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0B934E61
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25E31F23615
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B91420D0;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUYvxYnC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B018140395
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=ExSqtCp1Sizzn7isM0HUqqSYrjUe1ZwD3XzHhHJU4WkTH4/XQlpyQ0NLTCZeUrmvLqP4sU5prLFg1qKbiQ9G67p0nRCg1Wzc2dSoW37HSMHkP2fhU2033VyUbhWO/QACoYRFF3nLX0GuLR4hT0vAb4olqLYNFDIT58lGiJht+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=gknwNzQXz9IFiOrZZQSoM0t2YVp9ok1IqjrvHpGNUk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYzzzoEo/T2MpONRPXfMkmegBo4qePThKAXNAHp7+lEbL0IgiZgMsxvdb1pIS4oJyexaRYf/32vWGYCOIWLIjDbGRAPgCmwH3BxO7XkJiHfEb0xar+W7kewuVSI9pUgebyENJm/FjkwmCVYbRWGtsPWQ2CRvWCueLRM7blvsshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUYvxYnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E4C8C4DDE3;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=gknwNzQXz9IFiOrZZQSoM0t2YVp9ok1IqjrvHpGNUk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AUYvxYnCCzLBe7P5KLv66HyGoMV2czxTmwrGcOJ79dzk4lUSSu+Aunm6Alfytkk45
	 5WNTztSEEeLGrDSCJU/5/3dn5qq2laEZt8ccbF24rjJn0FZT1i4KsQgjgFyPt8wfJW
	 zBxbSRBf5kSdgJX1gsy+zhYKjUWPCUltN6Bw9nYH2ysv3VVwD7CuoMKjt8qZ0XWIB9
	 +86TWA5bVq8UGSIOuls/ctn0P/pcAVqvlTeLNU2bY3oq97NJbW5ovL+WdkECiMwEKd
	 mW9Vt/g/V2aj03MzqjTGPMjZXqzkcpp6tFTXlfkbx8FnFlY+RbnVmIB8K+Ln2uHZ/M
	 Jo63A4rGe7sUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2BC3DA70;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:05 +0200
Subject: [PATCH 19/22] iio: pressure: dlhl60d: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-19-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=875;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=uM2AzC1e0Tzt3pXETKVnH8wiQS6mvYBZvcnbeHKWkWI=;
 b=QHS62E8u6tC4ep8dGDfyuERVHUluovVF8UqRFV5C8RO8drGDug+4p4VkqasFbBFyViwWjmClR
 FSd5imZ87ObC6PPeoxOwJqQp+JIcoNHTHGMhIiCp3m1XIKvlVGjvYhq
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
 drivers/iio/pressure/dlhl60d.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 0bba4c5a8d405..c1cea9d40424e 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -256,8 +256,7 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
 	if (ret)
 		goto out;
 
-	for_each_set_bit(chn, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, chn) {
 		memcpy(&tmp_buf[i++],
 			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
 			DLH_NUM_DATA_BYTES);

-- 
2.45.2



