Return-Path: <linux-iio+bounces-27816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F7D2323E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C4293022D0B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0A334C30;
	Thu, 15 Jan 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzOfft6N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACC334694;
	Thu, 15 Jan 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465695; cv=none; b=HYaNHbOVTJkfy1go86RyJ0Rc9bPpSODuPe7s8jRiagKGn4csQ+xIgVJxB38C34qGAhNsYUmYNtgKAXEYU45dzDcSh63m1yGMi02F1PGypG6m+s/MnEN9pvy5j90ihq2SGI6l10v4ETGTWiOvx35azSuEUkp00ts6LDzuJuQwC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465695; c=relaxed/simple;
	bh=8KqJ2pAVkZmMUBGEofrU94g2ybwyVL8+Pr16hfWd92M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lnsae3fxLvswLzNZxYhtbvjeYajcy+n0T/7iKRQSmX2hYGM5FqYsBZwzM3cjz2ihpbzTxNHPpLV6QLxXlc3OiJhIaRHPccz3OTMqIVI6dYz0A5TXQQQCsUBQJ8NmRBKeEsxZQr2pg5VZ5VArBchU5ahS3mlXrTPxMSZ78lXJ/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzOfft6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BB5C2BCAF;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465694;
	bh=8KqJ2pAVkZmMUBGEofrU94g2ybwyVL8+Pr16hfWd92M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MzOfft6NG+dAlVVeFvdsEQNCt5mOIGIcDSX9D+u9N/WgEabo3WMXfGR29nx2zvI9V
	 OdAq61sDB0npM1SYIfs9xWr13TJObGZl+dDs9O5cmwWzw9VXMMsS4Gd4HWim3AdopV
	 0WpI43jAK/OtnJXErDTHzADSRsrPs6IJTF/35ltdCLwHDHltMX6LTxIhgLhLDuK4Kz
	 kR8FVnBDtnqQwNtV0TC0gslAcn6+F8CmfU/3/HJJygmAHxCShrUgHQ/ycoDHYC29AE
	 0//8V1dD0sFw+CSvpHT4SBI8ayqYsIP3ce10dAtgj7adoNMQYRI+1l3RG+b4XhiSQZ
	 HneMAKJDWXAWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF418D33A02;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 15 Jan 2026 13:57:40 +0530
Subject: [PATCH v5 4/5] iio: proximity: rfd77402: Use devm-managed mutex
 initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-rfd77402_v5-v5-4-594eb57683e4@gmail.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
In-Reply-To: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465693; l=818;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=k49VHFrDJjFFj/mgpbeRdvQKWZLsslBIKwH8rf7C0xA=;
 b=MXcNHdrkfwXyMt0tXfP3jClJ8j7XUeEIoX8XU60MwpRiDF+eQGxH3/WpDGOi4iVrDowaM4yv5
 S89IXle5RaJC6xq67Kwwt1K2+f/7WYeSCJ8s40M6y1izmK+a/SHIOlP
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
simplify resource lifetime management.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index dd79c9ee838b..43ace2beef7e 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -359,7 +359,10 @@ static int rfd77402_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
 	init_completion(&data->completion);
 	i2c_set_clientdata(client, indio_dev);
 

-- 
2.43.0



