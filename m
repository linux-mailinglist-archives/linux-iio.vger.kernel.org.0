Return-Path: <linux-iio+bounces-7696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E193D934E63
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D237B21ADD
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30001419A1;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5swMhwz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0D13DDC7
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=cTxVtMGaXBqI9Xppip9WxPgpVz9P2lxLSeUDU4Ul4msxO7V2u1Ul32g4sRD4YAPU6i/NQiP68HBrxnM5G1EGpf1kEQt8cKubPNQQrtk+XQUyZUER/bQDgj2tM2ztW/c9caw15wfEg1idcWYptaoZW0iocPB9l6z+SQapunP2Lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=hMRXI4Sv2LfJ5Fb6SHSsAO2Q3C00WA2SOcEUFsjlT7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EWzMen86l8slETT8geytAfNO8UOd8YxR5H2EpUegEKE+XUwXj/aMX2+ar1uK5yHzNM/sUOkWiEiN5yMNhIfTxpPsppiyZUZ2e9wYor1OPGA/oMBVI/1Lg3XgaXkIxvg7IpbWdle4pX5bxvup20PeGx5poGPgCAOFCIhHT04bR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5swMhwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F82FC4AF14;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=hMRXI4Sv2LfJ5Fb6SHSsAO2Q3C00WA2SOcEUFsjlT7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y5swMhwzEz535svPQx+xu7wFoY0ydFamrTpwIIn0beldKSSNKI4v7ln8wFi826PAA
	 o3rMdysaCRyOFxKtZKxyl/VDTJL8C5jRyvVNQMBXel4gkdezc1Z4u5L+c0isr5cRnE
	 CWrKk8zaYxRoA3a9N0F9gIs0VPFv2g77om6D2djxHRl+JOd22+IkmPawZ81MYNWdL5
	 83WXcoD1TtDnPuYUR5zaNCwJyNgIe1NVjH0+DtB+wayOys4s7LkE0H9Eqt8nWiU8Jq
	 FI3hNf+u0v6QfVe4wcTOdillUllwelD6zntW8TmN+Q4UgwXThu1VImuZo1w0WJCOLR
	 wtIZs9YyxyYTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB7C3DA49;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:03 +0200
Subject: [PATCH 17/22] iio: light: tcs3472: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-17-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=848;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=IBjfNo1AV7gv+op6SVY6NxHjmyuB/chdo1N1zk6XKlA=;
 b=qjuMCDKJWXx9En8/g3lMf9uVczVE+z+w4k8wrugTSpL8hBd3GuU4316lKJMBqDNz5nfCKGjC7
 AtQTXgCza69D19og5UIt9mNcIZokc76dRaa+NFqwU9bod50fMjocKIj
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
 drivers/iio/light/tcs3472.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 89384dba83dd..04452b4664f3 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -383,8 +383,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		ret = i2c_smbus_read_word_data(data->client,
 			TCS3472_CDATA + 2*i);
 		if (ret < 0)

-- 
2.45.2



