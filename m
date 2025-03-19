Return-Path: <linux-iio+bounces-17124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61351A69A75
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14773483FFC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53047219E9E;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACi2HBr5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BB21577D;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417986; cv=none; b=PpxqA+4SP9iMqX4x9S/WKW0XDVltkkVIWD777V/7DZtXpAmiIHbhUK2XVciukUZluFxFf+9NtZ77PJRNu/JIphwdsgECD5O43vtzEF06rDHbJuLze0YxxGBsOP85H+apdlFbkXw/0fj6hHkz4C7ytLtaQ2VcyzpNk4dPIPK8BwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417986; c=relaxed/simple;
	bh=xsuhm4qHLly8ULEOehp66neM7rdUKva1w2y08MB6ShI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhwZfPFx+2dZQ+gCtSYOtuICNW7yumgf5/1QjEYloB7yMciJq7SNCVZFy9+qIJrdQp0OO64dgXQx1h1osUbg9u4nu1P4hZZTBQDSQwXRHnvSpWLYKacq8XiKX4MN8ye0sHaNl7dev+qx8oy48sXrG99dG73OMZuk/cekyLrCn5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACi2HBr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BEC7C4CEF1;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=xsuhm4qHLly8ULEOehp66neM7rdUKva1w2y08MB6ShI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ACi2HBr5CWjTlbclWaKUhhPSHZB0Hsr33aWYMbDgvN/ZUrLeUEE1Fi1SlvZXE4jFA
	 GYMJEw+pER6AjFIwDaa+EmF/TrZc1/88g0yRfu9gy1MQMURaCJM2Pcib9Rc1zuqJhD
	 yom4VvzlBmtyKUOBWpHh92Sm62BWYaWCQxjuNxKpmwD13flfVdRJVzQ1hzKCOVll6L
	 ywxqqDHTLKCgWz7BnZaXiTcV3zefPOUVGoykzBqk1U8CHvXSku+Bhm5icoQRjeVCZ9
	 B7PKVYQCfYp5+58Dl0oib7Ihl4wpDEEZk1zDyqYu1jJKo3D12uO0V0q6hsc+xqmTEN
	 7diGvcRlPiULA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D46C35FFA;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:44 +0100
Subject: [PATCH v2 05/13] iio: light: al3010: Abstract device reference in
 the probe function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-5-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=X7k3nG8St4YffEhl0mBYetKomz7otdLVmRWRQD0F640=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9XOyrnm7ZpJDYqVGomOPKxao6IZma8EtDZ
 LIuHwfzhOKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 cjCCD/9OmxKSxOpC69ZSJCmuOzJpi11TytIbokCL99Grr8+Nxdc8ZzZBOL9aXg5zNHa01dabyPh
 rC7qX7buuUyjEFxtm3gyIlPKU6qUNL6hsaIaWC02/fVX5rUtxgUhIauJ+4yYjHqaL/xJxSw1o2W
 aTXsFAW36ACb2K3A01KnFwWDYx2FEDMGxK/qdmMBfodcbx3SiAo0JT7LLlVvbaVaDSJgQNeRY3S
 OjLD0Q7og92GtxVKZk4u7/cZp5MJQzIXYFYRZl9q0jgz8rw4KePXGhbQzpZ2Lqw6xXTe3l+cJwU
 sYw2CYJmJdak3poNhl6Epme6VMhL+trkJPl+5UC8Yel2USEvZ7/a9+dfSpB63E5Nf6OVUWBJanF
 Qk9En5mPoNAYuuyMawqEyIKBwfeV0HDAuYY6zNI3SPp5ew4Ay4/zztTVdDToloP3ohZ33dEgDxa
 NjiwU72sBhHGi0QYNxSkNk60Z30RRSEJVM+0hlbSv1VBhJSIbvjGl8WzVmKofi+f2wvsggPQHUY
 aJIzZ0H3K9i6LH/J96HxRZbXl3uao1P006Ux9o3Yr+Nb8Lxhocis++NMUkACwMP5Z1FXAIMTTsG
 Xrq2MUWQ2sBCsgnJK19PlBV0jsUyxp9uwypMdkaY9SfKJw2bQoVFkx6ved3KadkKJQMqDJ9HRPq
 87wvMjZ8JBMh41Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Introduce a local variable reducing redundancy and improving readability.

No functional changes.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 7fe91049b55e57558aef69d088d168437a6819ec..c8f528f3636a2eb0f0c9586da64a6560d4b42e29 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -170,10 +170,11 @@ static const struct iio_info al3010_info = {
 static int al3010_probe(struct i2c_client *client)
 {
 	struct al3010_data *data;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -189,11 +190,11 @@ static int al3010_probe(struct i2c_client *client)
 
 	ret = al3010_init(data);
 	if (ret < 0) {
-		dev_err(&client->dev, "al3010 chip init failed\n");
+		dev_err(dev, "al3010 chip init failed\n");
 		return ret;
 	}
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int al3010_suspend(struct device *dev)

-- 
2.49.0



