Return-Path: <linux-iio+bounces-27797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6301D205F6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D38EF304D48E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8463A6419;
	Wed, 14 Jan 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="BNdPciit"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61793A7849;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409796; cv=none; b=U26aiSXFbumqukha6bn/QDY05j+SwKSLR80K9sGWZVyztceeJIuL09OGcz3/dWSlW+89EUJDYra09c8xwf2/bge0yy/OykoMognqi8AdpFKCSB4LmTIj27RvrdW75/RwEC5PwFNwhRVhcXAadc+CeuZceJPKBcrMRLzFMX8SnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409796; c=relaxed/simple;
	bh=cpJhtBwL+xn1DlsTv3tngbYU96Jk39CyIobnR8nIqAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iffz7WK+1Y9DOmiT1MU6MWD2yiashYlBQzyTFc6VQTiqy9sfM997qlfTSxoKzdoPy6rzer7c5JH8BQNtc82Fty4FYAZdUnE9o7y2IUP/DJP7JwXX41mULbMY8bsMywRHXoQ/InUB56cDZqHh6s3xOn32PdjFOzP3LDiwXJfWN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=BNdPciit; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id EB943160211;
	Wed, 14 Jan 2026 18:56:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DF6sI6f8gUB2bTjj7JLKXhGkwDlZvoZkEzFkqVwjd4Q=;
	b=BNdPciitGh5jioDPkb2+H06IwksYokJbfRdGgPFyhhoMzHOLjy/+8rPcqmbP9C05sDF9xU
	oTUkg5135TjzcgdgKvxokdeYB9s/IktysQKdWkU1EpqnH+jMrxmjZ/WhG/Sq4JAoE5AF7p
	mCF4h/83vrFS5grA3+jwkXzDJtEs3OwbusdhSRIXW+XWSBGVV7k4BtM5LwSs3+zLl8yz+G
	olgFbcnZseZorJQssbuDCN0y3KUzCANp1ADAp2wx/wJPzL5DMC1Oc4BReKxoIQvjeuw+m+
	TMp31vdPoFHtE73Br0oW8Sz/ju/jP07qmNpa+pcDhA4DDkETXD62mi0RxuPgRA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:36 +0200
Subject: [PATCH v3 07/13] iio: pressure: mprls0025pa: remove redundant
 declarations
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-7-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=cpJhtBwL+xn1DlsTv3tngbYU96Jk39CyIobnR8nIqAc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXFSczgrQXBHNU1lZFZyT1l6SXJvOXR3CnhFWmtDelJLdzRiNXhPSWw5
 Z0hYSzRrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cWt
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWS92OQ
 pELzRuTVg3SWEwZVBvYzRRWDY5Rk5WaGRsbHF2MjEzRXk4R0dnNVE0a0lLUzB4aXdidHNTdnpWT
 DdsWkRNdVV6CllFYTZteTBZU1RyTHgxV3U5Q3djcmpLQTU0ekhsR1REK0VkSkg3cUJnYVE4RzZP
 aE8yTlJvc0VTNmN0UnZEd0gKeDJoSk5hRS9mdWlhZXd2aXVJY0VwQ0hSOXp2cFZiekJud2Rqak1
 kaGUvNmtVYTd6TXpFUEV5N1JiQTM2S3B4NQowQS9GeUhCMUh5TFFrSlRpVVlHWmNXQkRla0kySF
 BXSktJK0RrWCtYYnF4c01JSXM5Q2VoTXl6bWZPK2ZOeU9ECllrVnNHbTBMVHNYMzE0ejFIcitkM
 FB5TXdkeXQ2QzY5Uk51U2tLN1JSYlM2bVk5SGdWNU83bC9VeTJQQW1VUjcKeEJwYVVsTzRDdldR
 c2psVzlqUENGVWhQZndtME5oUW9WNXNVTVA0SWtILzFFNytmYkt1VjlGblJUdWtFd05TSApxMGk
 zN1E3U1lJZjBFRGFJWFI1dTFMa1ZuM2kreVRML3ZpcVhuWVdRd25NWXZERVFtUi9Cd1pLNHlVaG
 xmL0JoCkNUcy8xTkp4aVBLWU5XQkR3NFY1bkRlOUZiOTVqZzNvUzE2MC9aSFM0T0JwWE9YbC8yL
 2ZKZGwxdGJYeGc1T3gKWklPeEN4bDRBU3JmOGdMdGNhamxpd1h2b21OcmNrdTlLY1ZkV0lHVi9z
 U0lmT1J3NmloN3JQTGQ4ZXpnUG16MApEV21MS0d5YWlyYUdYRVVTZmJTcURMVVZyRzR1WHpVTzR
 XemlwMnBnV1kyRm4yMXZsV2RxeFd2ckZ5b2VGZStpCmNBVmhhU1ZmdUIyWUZCS3RYYis1RC9qdU
 NZdGVWdm5aK1pjVDVuYVpFQ0ordG4wbUxjOD0KPXB0c1EKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove the iio_chan_spec and iio_dev structs which are already defined in
the included iio.h header.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 split based on Marcelo's request
v2 -> v3 no changes
---
 drivers/iio/pressure/mprls0025pa.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index eab877da3451..e34253af8e23 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -25,9 +25,6 @@
 
 struct device;
 
-struct iio_chan_spec;
-struct iio_dev;
-
 struct mpr_data;
 struct mpr_ops;
 

-- 
2.52.0


