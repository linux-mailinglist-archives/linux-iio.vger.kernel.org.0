Return-Path: <linux-iio+bounces-8576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BF955FE2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A31D1F216FF
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1C15665D;
	Sun, 18 Aug 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jFbvYXkl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E414F9F9;
	Sun, 18 Aug 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020191; cv=none; b=Gd0t0PuBi3uHL6XM+NuT5Ovbb8oGWqZDL8RX7ZYsI6ZleOLygUczKgaDSxpn7bilvZag2e4ZhPT1/uIIJl59j5XJ145c6z+tRBrx4Fds9bFQFxYlXqZI0UCEfzapTR8ct2vvp9cZushbM/0nZmpXhoxAwdJLAqLYSrVNaA9Q+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020191; c=relaxed/simple;
	bh=+xohnx5TmIP27oKe8XtCfrTw4bTmoeBaflK6wzuMskg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4qDFuH9/8cmUqPyea8YbqxX1WxBgyaydt1epRkzgJiX0LKvmUuefYMnW/upK8pUu2pT0kBKsQKUFZjJHopoJXVE14OtpOXA61OVLiwcy+NUHGvL7/wZS/vR5gHfj3jrka47s24bQPKSlPOC7oyuENF83a7XXhHPrNNGOGb5SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jFbvYXkl; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC24970D.unconfigured.pool.telekom.hu [188.36.151.13])
	by mail.mainlining.org (Postfix) with ESMTPSA id 75E89E44F5;
	Sun, 18 Aug 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1724020181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usmmQHNNkBosnBzXZaDVWlwFXBMH9LYvqqKkoklOTvY=;
	b=jFbvYXklYANlLd/Z5JSFuF+Wg0z7e5YyluBPfL/5w3UEjpOKEN9jZSHVZDL62XJRSe+qE9
	UcEGNoUXWS2lRrNKhyn2SyT4A92vL9UOOQmo9G1tcflnfVJN1UykFnearY8EjPqOtHp/34
	rGIpzyx/axnuRh+cNPx8eAQa6b1ioxirPs5jQgii7u1ZHqxwkZUjmn7giDvN8QOCvQ+gZ2
	rdC3ckb4ecM/eazRq6uCdZEI6U/Kgiq7Nmu4iosCfoK1eum+uQaFaEwni+UYu2bFo264Ed
	5b0sGP/rHQ0rqhb+2CmVjutPXqnOVZYX3jvYcDmwEA6V3XVErXrMbw2c9vbdcQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 19 Aug 2024 00:29:39 +0200
Subject: [PATCH v4 1/4] iio: magnetometer: ak8975: Relax failure on unknown
 id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240819-ak09918-v4-1-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
In-Reply-To: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Gwendal Grignou <gwendal@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724020180; l=933;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+xohnx5TmIP27oKe8XtCfrTw4bTmoeBaflK6wzuMskg=;
 b=HIeEqRCEt9RNbp8sn2w00U4vR6hTjA7B0f0iOtNnuaNG5QXPyGVzioGkIl3kWs28BE70W55qm
 x/m4xfWk6fXAc7E6PTf5N59bZC/W3ViMsu1H+SttMsIAtNOgFTcgz0a
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Relax failure when driver gets an unknown device id for
allow probe for register compatible devices.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/ak8975.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ccbebe5b66cd..8eef4d5dd9e2 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -484,10 +484,13 @@ static int ak8975_who_i_am(struct i2c_client *client,
 		if (wia_val[1] == AK09916_DEVICE_ID)
 			return 0;
 		break;
-	default:
-		dev_err(&client->dev, "Type %d unknown\n", type);
 	}
-	return -ENODEV;
+
+	dev_info(&client->dev, "Device ID %x is unknown.\n", wia_val[1]);
+	/* Let driver to probe on unknown id for support more register
+	 * compatible variants.
+	 */
+	return 0;
 }
 
 /*

-- 
2.46.0


