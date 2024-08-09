Return-Path: <linux-iio+bounces-8385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3094D80E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 22:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56688B22B09
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D11684AD;
	Fri,  9 Aug 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ALaH1FwE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089E160860;
	Fri,  9 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235185; cv=none; b=cc+U0Q5INchz0iN3DPGuNTu+P86+vuIHTUtmiBJ5rpgHvKH+zzKyiH/5fM3/0fQgdTox8/ob63Rbzt+v3s676Jfj7Vo3K9UbhefaBQFldXfdfIWrIN2anFK3VuanVV9RvlqFBcocsZqdUYC8WWV0p126UoeLrvPMPAKDSZQAzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235185; c=relaxed/simple;
	bh=7b37UckFqRm8UadFSIfAJBpuIkG5A7uUZthuTB7roQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJ7bD+tNhSaE3PSNmC/7Di2ACiUKvn+MXMId75WhrvKU2b6Fy2EbcYbzhRZTanuIezAmSafOOU2rI5pbyr5iv6WWdvYy+NcdAc+M8oc3Iw9lC1mC4bVuJgrfGHkRIqu3sBjA1gUMJQwb0qenOF/j5LLhuq1hkqKvBWPoLYQEKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ALaH1FwE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2494A8.dsl.pool.telekom.hu [188.36.148.168])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8533FE4521;
	Fri,  9 Aug 2024 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723235175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aljqpjHTTwIR7lUQl6OebykCwDdp0HzgtnkpFvXr5+4=;
	b=ALaH1FwEWuHQJip/m/jCIUp4LGWCusDhxcmETSFPvyMX0cj5pZPaaBWjOMvl6IciP+PWaR
	AEKnaq8J8I6x1OI9eFQLvbMQOc0ozGTG1vhNvsc+9UIP55GU0UfQjV7VV5kazOKePHfdpf
	7Tniqt3a8/8s8ZZkCOroKAhVbkxOJK9dg5taF3Ulalr8FNSX9LIc6j8QGhX+HnhMri48mN
	ke04Y+jA7gigPxOdDXuZVhOIA6x6JZjedsbaGpn6D007rnzZcNie1b6SHkDwYALP4+64TF
	3NE1nYpgLCTYhEU+gBN3KBaDvYBadcDaTD1VrHuXtFrbcNHESHf+ai9ayL1/nA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 09 Aug 2024 22:25:40 +0200
Subject: [PATCH v3 2/4] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ak09918-v3-2-6b036db4d5ec@mainlining.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
In-Reply-To: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723235174; l=2365;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=7b37UckFqRm8UadFSIfAJBpuIkG5A7uUZthuTB7roQ4=;
 b=WPvb9Zekj8DRSeggiW4j0YX3/kj7+wyT+H/pFXxnGfcSNuAskfBIqtVLvaoDh6kOqzm26dAJ+
 Gdfx1uRtS2JA89jhzMCMixGFRc0aHOz2QMPEczbCq+fWIvwdYUME9tg
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Move ST2 reading with overflow handling after measurement data
reading.
ST2 register read have to be read after read measurment data,
because it means end of the reading and realease the lock on the data.
Remove ST2 read skip on interrupt based waiting because ST2 required to
be read out at and of the axis read.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/ak8975.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 6357666edd34..f8355170f529 100644
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
+	return !data->def->ctrl_regs[ST1_DRDY];
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -734,6 +719,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
+	/* Read out ST2 for release lock */
+	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
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
 	mutex_unlock(&data->lock);
 
 	pm_runtime_mark_last_busy(&data->client->dev);
@@ -746,7 +745,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
-	dev_err(&client->dev, "Error in reading axis\n");
+	dev_err(&client->dev, "Error in reading axis %d\n", ret);
 	return ret;
 }
 

-- 
2.46.0


