Return-Path: <linux-iio+bounces-17121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E6A69A68
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C1C8A5AE0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412EC219A76;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgzJC+ch"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08D21506D;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=AAyqVDLwSfEMoMHogaKLwOwqM3y5ym2Y1m+f6nGHxX8o8KdwocbBx9U9k4q3PvLWiqFfHsTuczgUI+BnMj1d92CWdWbgsqHEfGlKcnE/gO8yjLo5JQLkd2XGM5IaZTncOwNkqOWdJR80oZAe9zAsoLfKWSq0FxXeLYVN1ZR6GhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=Nb40p3Xs+C8O0Jlm8TgZdUhNJU4aeXieAVS9NlYFhio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Phpvtt47WUkuGEOU8wy0SbRkr5P/L3PNC28sw5FCdERIk4q1DxuEw3/qqCfjps48YDM08owDOKjupT8tQ03OkGgO4D0a9Qk5r+BbfFJ2kXYkNEbzvMrd+c2EgwIMRebhSG1eY9RprsfmjhukMRNPGYYNfpAR5TlYxiP9O/kIsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgzJC+ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73655C4CEF8;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=Nb40p3Xs+C8O0Jlm8TgZdUhNJU4aeXieAVS9NlYFhio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GgzJC+chMe/PsMvNd2bTCrzIl9wymaVOrGaLXMqZV1R0ccCBIuZzIcsYeIlUg+ItR
	 L88pFNq+6K6EUxAuZVbLaHqfMBm5uWo2Mkt9XDWB48248KZfIIz1vQxLOv+pE/EuY8
	 uVNtGXpZKrFJITs+V2zzx/UJojkKbjpJSxZxqSI3oxuzMCKdX4pK6esxwEqreaZ/t5
	 Kd4Zywfi4GQaZ72qj5I0kVOwXUeb3CieUpuHcEzWwhnHHhtJMzPIsWkJeyTvU5RKwT
	 1jXH+HzgJyp9dF89Y4LtvpEHrxSVnKCjkH1ECcwh2/39QBG963wrg9NFMtq0YC3k9L
	 V1GNJsIJ5bvAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC14C36000;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:47 +0100
Subject: [PATCH v2 08/13] iio: light: al3320a: Split set_pwr function into
 set_pwr_on and _off
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-8-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=HtZAIFM4U29a78slhT7/fEE0u86xMj9t3tNcfonMUX0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+gZJMvBcHRhctyGlYIGPDCoOcnA+hgNZDL
 BhKUlf9MX6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cp3vD/9cGsLoHMdrpZmfC8d7vIDOY+sacH5u6txMWtgL6Q//iL6/XQEb/W/ulfGuSaSzxbm4/2O
 v5wrBclpvbT5tu/K5kIpFJoFj14BQOW0tQAokJJAU0ww9R1EyVafl5wEZv2ZyepQPjzrhSqu7X8
 F5ALt12d4UyyOsHDaAzb3anNPefcmZxz3KAfZ9cMfsg/R246MaPROwQrqF5DWQj0h3hnEkVO2cw
 lUi256s3qYzusVxviSkN+zzxVj+IqbGJ5HYz82/OvzsfML7ikdAYwWZiq5Q4UsaVEjGSykXPS3m
 O1/A61rTnTwVdmbtAUQtbw6S1lPWQHWfhscA+sNj2pysBvt1jXc+1bcwqiSO5a/3d1PCqtChrhM
 7OXRU5Pn8Dr5kI1aOMNpc0b1qKtHOo2auNeSZHR4OGfrYwStE7PU/Lqfz9cyfm+8P9PuOukPMKc
 lJ7AtXFsKZ3zEAck+OoZK783pBlgHn4s297oAabEXjTLI9EQ/7swV69IkkjcqbmPI+IHum2JPnH
 HAbT6feCT/fmvUCQssjaMh2giWdQehD1/itC4l1rBBRFoKfdHU7NYcW0IRMjOCwMYLXo8AHsNN6
 TILHB9yQK1LOqVaatPPA8uepA4gGUz8CY7CQ1dxKqH4sWC3OL/SguhaQlWsoudx4R07Nde+0HRb
 mVR04zjgWKDyNCA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Simplifies later conversion to the regmap framework.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 9817cfe8ae18a8e27c82e7362481ebd32a41f8ec..1b2b0359ed5dad5e00d2fe584f8f3495c13c997e 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -80,24 +80,23 @@ static const struct attribute_group al3320a_attribute_group = {
 	.attrs = al3320a_attributes,
 };
 
-static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
+static int al3320a_set_pwr_on(struct i2c_client *client)
 {
-	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
-	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG, val);
+	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG, AL3320A_CONFIG_ENABLE);
 }
 
 static void al3320a_set_pwr_off(void *_data)
 {
 	struct al3320a_data *data = _data;
 
-	al3320a_set_pwr(data->client, false);
+	i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, AL3320A_CONFIG_DISABLE);
 }
 
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
 
-	ret = al3320a_set_pwr(data->client, true);
+	ret = al3320a_set_pwr_on(data->client);
 
 	if (ret < 0)
 		return ret;
@@ -221,12 +220,15 @@ static int al3320a_probe(struct i2c_client *client)
 
 static int al3320a_suspend(struct device *dev)
 {
-	return al3320a_set_pwr(to_i2c_client(dev), false);
+	struct al3320a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	al3320a_set_pwr_off(data);
+	return 0;
 }
 
 static int al3320a_resume(struct device *dev)
 {
-	return al3320a_set_pwr(to_i2c_client(dev), true);
+	return al3320a_set_pwr_on(to_i2c_client(dev));
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,

-- 
2.49.0



