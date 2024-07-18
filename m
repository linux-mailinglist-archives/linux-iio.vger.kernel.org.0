Return-Path: <linux-iio+bounces-7695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06693934E5E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3806C1C22955
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAC140E37;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD+V32Ri"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D1140363
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=NVdIQDIN2s0tQ651Gh6HkS7iiPhrOxGVI6OiQHg21wvejZXJ/n/LKX76JzMy4pq1Alzg9UotmkkzbXu/Q9tT/8yUonsfZq9xUp45+mLXNG2Xw03Kjovy5xUIJl6zcY0i0zJqQEjEMyjPFx1c64eLbPPxGxqOIbDKvXsiSybiHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=HcHYJCuITFenps2794VjTZxgqRMuEK7mV7GELGDD4R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZTXJAg9er/Obm17U5MsY/yjlufZnH87HOYS0h6GmDywu8+99sG+AjuDoTSAhb2ayWj7NvGNEjQpu+RXFUmtSE7+Y3MyXRQry8Qu6M1pT/SIYuiBjI4FDT3Y0GxhxzMdzi8Mtit1UkNhrSHwetnaYoNwdDClEBjYsN59uJd1mK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD+V32Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF48C4AF13;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=HcHYJCuITFenps2794VjTZxgqRMuEK7mV7GELGDD4R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jD+V32RiPPIOlWXPhHUlwW3ZCzPxYjKqKS6+FT0tEen1+6JSL9KFhj+Wxy+0nDjPf
	 UlTLrmIxCfbvE0bu7ZKLc+Fj71h10ISi/AlhXKH3hiKFKuV57mYUlDD0Q6Q4Dlp3ZF
	 rTYcW0gE3rK9RbGtTMIwvAMilrTgj6hsFN4tisocucuMQHsoVTdsDgsD2K7RugpQa8
	 H+dVtlU5ZXybzbLcN3gcGz6ctPMNoknfYCfLB3v95j9jzAHlWKtqIjHcaH2I7uPeKP
	 z7tLPYDunaQzgPJkGWDMlTZhIE5mUuH+c8V6HhtJKKJWlW0xTZgsnwvZPB5/k61eGa
	 50Xyt6ui2ZOcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34256C3DA6F;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:02 +0200
Subject: [PATCH 16/22] iio: light: tcs3414: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-16-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=895;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=FQPoPlxTckobGJ/E9BiUhJ3AOag6kmtMKp8GvAK96A8=;
 b=XGy1BTl3TvcwxZ924yiZ5ewtZ7TLHwoYgL6uYjfGMrZcrWxANdgK5Ym5e3BmjLr8bVWS9DWf0
 0jzfDRIuyT9CXSWCmTE9CkUUVQGnpjh9p+U6xjFEh2KwPnzWni6ujAg
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
 drivers/iio/light/tcs3414.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index c9566615b964..4fecdf10aeb1 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -206,8 +206,7 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
 	struct tcs3414_data *data = iio_priv(indio_dev);
 	int i, j = 0;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		int ret = i2c_smbus_read_word_data(data->client,
 			TCS3414_DATA_GREEN + 2*i);
 		if (ret < 0)

-- 
2.45.2



