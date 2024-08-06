Return-Path: <linux-iio+bounces-8263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB4948931
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F12B1C22863
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6421BC9E9;
	Tue,  6 Aug 2024 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Ooc6NDsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EA1BC085;
	Tue,  6 Aug 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924626; cv=none; b=UDgZFpiQpsnwEil5ao40xc/BOhDBtpW80LkuMwxgbaSFSAPs0wxRLFXgcX+3bno4Xlc+rTWnl6ZbMgtpjSmO9GOpbFsI6GA7z6BZNRln9iNKUD0+F+/Rh/8Ap7kxxwTKQYKhcS9gqIK5nG2x4OpjAg/UTpsXAebWjeHrRPIL5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924626; c=relaxed/simple;
	bh=4rYFsMje+NZGfL9e7OyJNriJnWdptgF7A8GUj7+GTnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEwYD9bZ0/4JGmXSVheIdmMa2l+xJ8EznpuLjO0I677nDHPKCY3qs6AxRqf0Jo41m3MIILDo6G2ku5s4DQW0AMruHvX53eu00RyuYIGZaUxAOr+gR55ja3BnVSM9/fJtAYw9nfiIvv6K88kRGCCA0sCGUsFqk7rVVTdEkTUfpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Ooc6NDsO; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id 26702E450E;
	Tue,  6 Aug 2024 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722924622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwbnq+5yNmFaQ5aTCbNjKdWw69NnDfl+wFQPeG16EVo=;
	b=Ooc6NDsOuKr6/v1ohze4DKCmOGyjS8THzYfpATJUyRNMIlDFq5nNdQtZMUkeVKGJWNXi9W
	UGMSE+d8p3wOZ5+To8KPPVL95pLXMIuf+XyfuwgcsHXEsuIfh0UFUff3xvoFIJmyNEzWY/
	5iANrn74HmxeHYbi2fdw8bytO/uMZg5btS3JgRGNYSsdzf80bLnaYadxJHaCSEK8pE55xz
	XF80NI9UL0b92iBSOxb2dEdLs5BMTEECmqHq0/FONhV2mSAXDz7J60mTPp922KzEYJopOV
	y2wvPdQz7hQQyNbwC0i5pie1IuYoew8uB/bKjt4+NHMyIWOLgEqtFjHDaFzdAw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 06 Aug 2024 08:10:18 +0200
Subject: [PATCH v2 1/3] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-ak09918-v2-1-c300da66c198@mainlining.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
In-Reply-To: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722924621; l=1899;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=4rYFsMje+NZGfL9e7OyJNriJnWdptgF7A8GUj7+GTnY=;
 b=sp2pfATD7yxX5yYWArvJWdIUj65ui5i9OD9Y3AdAL0XwqvLsrFw7iZ46myuzhJAFS45rim+q5
 q6j7w349wPQC+QKB/hNdeOBCOu7Bxl3VwhpXfryDyog3h/De7GEQAIT
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


