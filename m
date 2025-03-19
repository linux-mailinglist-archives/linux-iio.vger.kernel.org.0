Return-Path: <linux-iio+bounces-17123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AADCA69A72
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859E34801BA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D8219A81;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlPFTgNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB51215078;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=DowmQCTxZwlL9cyt0VSd+ApN5c3ig3qE4fQUhEZe9Tjf9zmKWOJEQ3cSAiYO62IwFcPV9tu/pU/K49kc0D/LOQZ0uqIErAsACqxc6BkOy1uHeAAfkr77LRsbU7QAHbS6dh0vpG1aVJfWtlu/hs6f/4uBGxJGpbb5DtEO39Vjb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=cQ8+Op3kRLvwmiWD71YC8C5zKQ3WJ+UymbQfnjWKQ+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpuqVge+fWwTE38kw3WuKvgLS+RULePr/UV68alPJ0J+raES4kjul/qwotBLGw+lbc+zPighWHAPZiOdrdUaEcyEdMV4yObTD6YEon8oqZ23lS61JEYuzckSa7dvF8qJ8xctY06UmjKa/szLH8IZN2vpSJgWITXBvAJZS3JPttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlPFTgNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66868C4CEF5;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=cQ8+Op3kRLvwmiWD71YC8C5zKQ3WJ+UymbQfnjWKQ+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IlPFTgNxKkNiS/SLjpvObGhiv+jntc1NU1m6/v4CA3QOwuxbCj3IMP/DgyJx3z0uM
	 hQmdNMIFD01um1kDTaaoXTbLmR44T7ottO63+7DHpvq3/FLiZKzaR5Np7u8bymL57I
	 Ba2UwrqvgZFaS4kun97yPdw/H4G1KXooKoCIN+e4Dl90w0EhySYXK2bWJGnpcyfTTb
	 8X2JoyNuywIX1MA5WUp8Legk18W4UL/J+NupmeUlanCk7JJdok3r+LCXIcDMWfUtw+
	 TlGdOalHvwGvtZhycZ382p2z9K0V7qgIyHjS4ea55fVAjvOnDMCxJ3mLyCSWWuY7VH
	 MPynZYAdj6zbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBFFC36002;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:46 +0100
Subject: [PATCH v2 07/13] iio: light: al3010: Split set_pwr function into
 set_pwr_on and _off
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-7-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=vOib51/xpneU1DtWyRjsNY1gpYkAaqRHzYSkX1BUJo4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+WhBZQES0+91AU6m/fyiF7GLrpJGg7rPU1
 6XKQBu1L5WJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cmZXEAC7DBAsyzOMQiY4z3k4WVrDST/JuGR/9IbmZR5bsN+EolCvK/H5ebgdwn+vv9f9wRtriwZ
 OSFAwwe3dA1ukqDpX/LHSnMKJkglDtJA74Fz+nY+Ekj50U0YNw2D0BFY/dvpvgMlmyjSTNufdVJ
 +riBrfQW5odlIrMSR9WpzItSc5Zc771yUSOwYwa1l11JXTCyLS+SMo9o2SskhqLwnfbYi0v20kl
 aQaw+weS54MsuX4JKI6zEaiqKWwlE39JIQWVlxYakPiG9y4LvR0v7A88ssfBb+zoYiGYT4CD6Nh
 sRYJeVnylBfWWJ42ttQMPlju9FDQtpt4CBIUyWTlPaedtSEahIIRHH+OWCHmrVJi/nbhqiRvN4M
 kmkeMLboSRbE6bDovJF6fQAcNh4ZFHDTEupZSl/bmV5RmfyjwHzRT3m84R8J/Q0HBtXfXuydYbN
 v/WQhzYWmchBJurPLyWvTDVi02OzBj3q36wvhtvujqDMXGY3ua85KuOjX85rqG6Cz+9k76tgs6D
 5Mm7Dkf2QRDBqUbS0WYKJMeODbYtMv9Kr0NVBHeRLH/RBYgPVDrg84RWAVvyYESTvCJj7Dd3FNd
 VyLm4No5LRQBv6ukxvpLzK5O/c8Uf2CNnG5yIUSjnwOZu5Ye4KsonP64qrKWnVvaQuWMlWtlIT8
 jW4K0/0RXq0cP3g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Simplifies later conversion to the regmap framework.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index c8f528f3636a2eb0f0c9586da64a6560d4b42e29..8c004a9239aef246a8c6f6c3f4acd6b760ee8249 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -67,24 +67,25 @@ static const struct attribute_group al3010_attribute_group = {
 	.attrs = al3010_attributes,
 };
 
-static int al3010_set_pwr(struct i2c_client *client, bool pwr)
+static int al3010_set_pwr_on(struct i2c_client *client)
 {
-	u8 val = pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
-	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
+	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM,
+					 AL3010_CONFIG_ENABLE);
 }
 
 static void al3010_set_pwr_off(void *_data)
 {
 	struct al3010_data *data = _data;
 
-	al3010_set_pwr(data->client, false);
+	i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM,
+				  AL3010_CONFIG_DISABLE);
 }
 
 static int al3010_init(struct al3010_data *data)
 {
 	int ret;
 
-	ret = al3010_set_pwr(data->client, true);
+	ret = al3010_set_pwr_on(data->client);
 	if (ret < 0)
 		return ret;
 
@@ -199,12 +200,15 @@ static int al3010_probe(struct i2c_client *client)
 
 static int al3010_suspend(struct device *dev)
 {
-	return al3010_set_pwr(to_i2c_client(dev), false);
+	struct al3010_data *data = iio_priv(dev_get_drvdata(dev));
+
+	al3010_set_pwr_off(data);
+	return 0;
 }
 
 static int al3010_resume(struct device *dev)
 {
-	return al3010_set_pwr(to_i2c_client(dev), true);
+	return al3010_set_pwr_on(to_i2c_client(dev));
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);

-- 
2.49.0



