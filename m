Return-Path: <linux-iio+bounces-17557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F743A795EB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2443169379
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B71EDA22;
	Wed,  2 Apr 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUepaOhy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F718E03A;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622412; cv=none; b=Ld3lKS2WXBpMgkpqH+e3fXbqOqiMA4pYxX6Eqc/ThkJ/7Ves2nZ1s4gO3ET7E9x3n7NOjKGXKKcujlep5S6v4dmjYm2y9h4XgJqA7DHYwV8KLtI6gi9TxQKF7bnutf9NEs3xehuLXk9QZn70qUmpkd6n2vTP2RLdbYziyKl0VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622412; c=relaxed/simple;
	bh=VsE3WyyxL4Exi7V542Px7+JjGuyH9uxuRIQpC16XC04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwRXZcb2jMqHECfbCaMMcc+pJVB6Pg3wVcTqV8sqJ/XDHdza5GM04a3npk4JtOQ6jt5oZO0nuS1I1DsGqwvLOq2AI/GjUKUWEmU/TgzEcv08ARTgaNOYp4TvTmqBAvODx9Tmt+Su9v2tHzy8Kl/kg01TH8V+3b4w2fltzEkUW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUepaOhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32585C4CEE8;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622412;
	bh=VsE3WyyxL4Exi7V542Px7+JjGuyH9uxuRIQpC16XC04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YUepaOhyDFJgQj+GN1fqP0qmAPyQi9SrgQUA0KNq/DzSVGsp7kZ0y1z0mZ+g1dNkH
	 hxsWWjEiKqABu3nrZs6/LEsULX8IDav+ObeG81vHk0JVFolZ49hmyiJmJACNV8W4o0
	 MFmw6+OKw6ELcnuJ1eDSVK2fO4raI9tZCnK/GrismVb7oa0u2GBayEAsGi+Pn1aWjB
	 qvmTxCA+lalOYlAlzVaZ0ZGEB5GSJBwbLQHuIBLoCADq66dzQZLjJ3UC7CnKHXt4AU
	 +avQ36qIgcr/K+5sUAQX3tV+LIZr9krT4ma9ZX996uIAnqx1eXbjDfwS8l8q8IS4yK
	 5a8wepwhT9vPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932BC3601B;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:33:24 +0200
Subject: [PATCH v4 1/5] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v4-1-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=N9LbC8OZWRVf5APMfHXIqkJb2k+lvKlkciNMNe3ltSs=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7ZEJh1yMmYwBfvrQLmelKSsmcsjaMNsSDa+5P
 0kf0VvqhTSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2RCQAKCRBgAj/E00kg
 chxtD/0WlctxGyXcnUrf4p7CHbPuMELKfAxvnBa37etxVgIiupkvBozuv2OZFLb0k54yoHqicRK
 lXg/ymE0+bYEQLAuPXRY1rcsqp6UTB06K7+UCFGAvaCztqNq+IvX+UPvMipKao4Zi7mpFKEAac+
 RE53tvVjVL0hx6PjNb0iQR3hO+J5VRto5QPiH7TonoDY+XR36lHNKDXG6ni8SFCbliEDAAs7xAY
 eN28gGAhzj62mJi+guuQDGiJyHSQo+cmp99q9MUJhVtnayZHsxBcGbezIb6Kf0uKVeEZFay56PU
 lk916DZyPgvLzr6CdJglPDV1ZLga4G3XLSQpnalKmBafK+mumdiXcUR8RN9guWDx56n8eZrdERY
 pgmVkLUgofnWbzEv+eZ/7TS7DkBw4Gepo49H1UdAHSk4+UzrLAHneJZ6+4RWRHaIrjs7jQ6vQTz
 h8xxitKwxNK4Vt+qeOMsb9N2DS1dlKMx4SDxLcpW8ug1J8KQmsdeIlYrQ2Gb4WILEGSsAeZo6mD
 92QKBRtTMd+oLkW5NW1wRIYWXarIj9HWCivO9tikhs4ouqpxjEY0YBOS31qtZNQl1DkVcYFuYNx
 AEkDOY1e2c2v/Jyi6TTWy2f2iPta82pn8NDVJ+qX+DECsOLJQ5Jwuwvx6MThroE9pNyBUT0k996
 r81JE+n9uMZY6Jw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Minor code simplifications and improved error reporting.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..34a29a51c5f9e8aa143d3ba195b79a19793e4f88 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -92,8 +92,8 @@ static int al3010_init(struct al3010_data *data)
 	ret = devm_add_action_or_reset(&data->client->dev,
 				       al3010_set_pwr_off,
 				       data);
-	if (ret < 0)
-		return ret;
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
 
 	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
 					FIELD_PREP(AL3010_GAIN_MASK,
@@ -190,10 +190,8 @@ static int al3010_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3010_init(data);
-	if (ret < 0) {
-		dev_err(dev, "al3010 chip init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.49.0



