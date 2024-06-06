Return-Path: <linux-iio+bounces-5884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552318FDF70
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C57288273
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C913CA93;
	Thu,  6 Jun 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yLsVVva4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2913C69E;
	Thu,  6 Jun 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658403; cv=none; b=B9c4L4WcjpG2YllTNT0JvesLK0ynsYJn9wf/r4IXhnqVDwicYb21T+Knt7gedx0piwlBoiOGOfoXJE6oKGmwYErk2fA2+iCe/6P53Gb0poGGr+p6oJbwr8FAvrqtECmF+T6fvfZaXNJVOSnwmCERhCAOlkjlcL0fAOrRBtU0M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658403; c=relaxed/simple;
	bh=YXnPEPH8ieRcmPyM7mS3/B2YUJTTpMxdJgXtPcLuUks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZvO3Ka8asPH3jFHD76J+4vdZQS+WKi5iX+IqcN4jUu95V5Ekp+SlIDTk1QPqk8OZhRNp6+3dbraLUbZ1nf4HFIpMbS7lN7gaChMq80d7iSqQrJ+OSttdubCXuoHYQLzFcXKaz7baLlZqQ320FrfiQl0CcQK5ZNsF+eusE+dJABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yLsVVva4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565FnWE018314;
	Thu, 6 Jun 2024 03:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WVleC
	QOVAlljpbV37rYWncfuwAgWZ0Mp5j58RmXiLnQ=; b=yLsVVva4z17zJ5EGI9RSd
	mCsHRtTf/SOi3x0Axg9QMH5w3u8Tazmht7lQa4iey1bcBGf7gD+1G2aUYc8N44mr
	aEiCEyF+9oBO3OUM/3Jbu9n9STKp+btc8EzJFk14D34mmuqvmq/gODk7GASWKTp6
	idCsVHEYIfha/j1d8cO/bKUxTRGVso32MW5+UZNMXVJLWQqCTbnoJiqr0HQ9jfEF
	kRuDaDoG0uwS/J4cQ9NtgSmWF51ZstE84V6dXvKs4vjfx4T2xfDHtbOrwExUDt0U
	MreKD7XIsK5EEtVPf3VyXU/+9e1RsL5LUf7GWEhhMJ1tIvh5lAwIcD4bfJ/IwvT8
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yjuesjmhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:19:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4567JKWi030136
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:19:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Jun 2024
 03:19:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Jun 2024 03:19:19 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4567ItBf025782;
	Thu, 6 Jun 2024 03:19:16 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 6 Jun 2024 09:22:40 +0200
Subject: [PATCH v3 4/4] iio: common: scmi_iio: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-dev-add_dev_errp_probe-v3-4-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717658563; l=3377;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YXnPEPH8ieRcmPyM7mS3/B2YUJTTpMxdJgXtPcLuUks=;
 b=stco9/XLXZE9WC7wCzxzxKe6E85oXjPNZpEg8noNUXbbYAIPVkmRY3ssLnD31C9BLFwynPtyn
 tlsRNdQ+64CD0kqzkuE/i2grg6jPbgLfplrgiB46o5B7n4izDoFX734
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CNxQgtAmEsAbPKCMbSgLDr3rUAyOnwzK
X-Proofpoint-GUID: CNxQgtAmEsAbPKCMbSgLDr3rUAyOnwzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060052

Make use of dev_err_probe() and dev_err_ptr_probe() to simplify error paths
during probe.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 0c2caf3570db..7190eaede7fb 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -626,12 +626,10 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
 				&sensor->sensor_info->id,
 				&sensor->sensor_update_nb);
-	if (ret) {
-		dev_err(&iiodev->dev,
-			"Error in registering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, ret);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_err_ptr_probe(&iiodev->dev, ret,
+					 "Error in registering sensor update notifier for sensor %s\n",
+					 sensor->sensor_info->name);
 
 	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
 	iiodev->channels = iio_channels;
@@ -653,10 +651,9 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		return -ENODEV;
 
 	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
-	if (IS_ERR(sensor_ops)) {
-		dev_err(dev, "SCMI device has no sensor interface\n");
-		return PTR_ERR(sensor_ops);
-	}
+	if (IS_ERR(sensor_ops))
+		return dev_err_probe(dev, PTR_ERR(sensor_ops),
+				     "SCMI device has no sensor interface\n");
 
 	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors) {
@@ -667,8 +664,8 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 	for (i = 0; i < nr_sensors; i++) {
 		sensor_info = sensor_ops->info_get(ph, i);
 		if (!sensor_info) {
-			dev_err(dev, "SCMI sensor %d has missing info\n", i);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "SCMI sensor %d has missing info\n", i);
 		}
 
 		/* This driver only supports 3-axis accel and gyro, skipping other sensors */
@@ -683,29 +680,25 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		scmi_iio_dev = scmi_alloc_iiodev(sdev, sensor_ops, ph,
 						 sensor_info);
 		if (IS_ERR(scmi_iio_dev)) {
-			dev_err(dev,
-				"failed to allocate IIO device for sensor %s: %ld\n",
-				sensor_info->name, PTR_ERR(scmi_iio_dev));
-			return PTR_ERR(scmi_iio_dev);
+			return dev_err_probe(dev, PTR_ERR(scmi_iio_dev),
+					     "failed to allocate IIO device for sensor %s\n",
+					     sensor_info->name);
 		}
 
 		err = devm_iio_kfifo_buffer_setup(&scmi_iio_dev->dev,
 						  scmi_iio_dev,
 						  &scmi_iio_buffer_ops);
 		if (err < 0) {
-			dev_err(dev,
-				"IIO buffer setup error at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
+			return dev_err_probe(dev, err,
+					     "IIO buffer setup error at sensor %s\n",
+					     sensor_info->name);
 		}
 
 		err = devm_iio_device_register(dev, scmi_iio_dev);
-		if (err) {
-			dev_err(dev,
-				"IIO device registration failed at sensor %s: %d\n",
-				sensor_info->name, err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "IIO device registration failed at sensor %s\n",
+					     sensor_info->name);
 	}
 	return err;
 }

-- 
2.45.2


