Return-Path: <linux-iio+bounces-8254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013194837A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 22:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3C11F233C8
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005B16B72E;
	Mon,  5 Aug 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OwpboKYH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B51428E4;
	Mon,  5 Aug 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889920; cv=none; b=ZisBmz4PmuR7aWIFmUNwbQv4m+EZiBUalDaF14K9gcFkLHg5NkllDjh5I6a6F2EqNxZjhLXTe1gqpy2pYT6UnTeRQXYvf9p6wC53IyHI6CVREVY36163euDDf/pKyHXt16oP/PSSWUon+INra7ybV92ytGl/HMJdk7p+fTav49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889920; c=relaxed/simple;
	bh=4rYFsMje+NZGfL9e7OyJNriJnWdptgF7A8GUj7+GTnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLYbijEHsY+ADYH01IUQ3oSU+sz9RtwLuJdtuaiRrW8AkKZEcmD0gHtNoAeDDloWxPt3yQQJTdxLqVLvxVcQsc0lkGKwBVupuJHBsQnfxaax7JIW55lFWWFY+CW6mivG6xH96K6guk8v6ntgHaYgAuD+N4yk1mkHbfa44JdCDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OwpboKYH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id 368E0E450E;
	Mon,  5 Aug 2024 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722889910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwbnq+5yNmFaQ5aTCbNjKdWw69NnDfl+wFQPeG16EVo=;
	b=OwpboKYHu++N0PHkffWv3Lg5HXqT7JXs9p4FYmEpRC3T237zJre+msJ63EqZcYttiwx7vS
	4MHHMOomZiPXTM1AvJAn9toi9VwlzPMZMfeXeC7CarqwRciv/OtKu9x+vJVea2lg3gnHxv
	VG2yRZVVBSqm7Pl922LQjRQVBKz6bd/V5suXkJprzt66zC2b0cIueZiyNqNfzq5HNl2G3b
	g2a2jvWBpouy4+CdjFtktQEt5Nyci8SfCMQJ7nL9BgXxfo1rV5Xpoah+/LzLhsQjUhLffu
	QOd8McWIdD4rrAM0MeLeL3MWudkt7m2sTZl2DD91wkSEg5mm1vC4hjOq+zSVFw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 05 Aug 2024 22:31:42 +0200
Subject: [PATCH 1/3] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-ak09918-v1-1-70837eebd7d8@mainlining.org>
References: <20240805-ak09918-v1-0-70837eebd7d8@mainlining.org>
In-Reply-To: <20240805-ak09918-v1-0-70837eebd7d8@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722889909; l=1899;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=4rYFsMje+NZGfL9e7OyJNriJnWdptgF7A8GUj7+GTnY=;
 b=PtRYzzv6kAT2F/SR+1UUL/hc9cVnzyv/9yOnuHPadlHo8jr8W92wFt/5VSqp9hN50Dj+K0PRT
 1CF3AcT0mNlARIWOvzrOoMaHvo7HGbLrxim+gE7lTH8DSgZ+6KUrprO
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

ST2 register read should be placed after read measurment data,
because it will get correct values after it.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/ak8975.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dd466c5fa621..925d76062b3e 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -692,22 +692,7 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	if (ret < 0)
 		return ret;
 
-	/* This will be executed only for non-interrupt based waiting case */
-	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST2]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST2\n");
-			return ret;
-		}
-		if (ret & (data->def->ctrl_masks[ST2_DERR] |
-			   data->def->ctrl_masks[ST2_HOFL])) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
+	return !(ret & data->def->ctrl_masks[ST1_DRDY]);
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -731,6 +716,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(
 			client, def->data_regs[index],
 			sizeof(rval), (u8*)&rval);
+	ret = i2c_smbus_read_byte_data(client,
+				       data->def->ctrl_regs[ST2]);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in reading ST2\n");
+		goto exit;
+	}
+
+	if (ret & (data->def->ctrl_masks[ST2_DERR] |
+		   data->def->ctrl_masks[ST2_HOFL])) {
+		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	if (ret < 0)
 		goto exit;
 

-- 
2.46.0


