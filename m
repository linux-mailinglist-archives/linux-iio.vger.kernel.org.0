Return-Path: <linux-iio+bounces-19220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FBAAD593
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CE83B886A
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FB1C84BF;
	Wed,  7 May 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alf+rWYA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED781F4629;
	Wed,  7 May 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746597493; cv=none; b=jc1anOIIi055mu0GKTywCf1MOYfA6lWAXh09uBqf4G5FVvjXy72jhdlJnt41mziM9bpbnD0zDJ98/h5t5qr8IrtwISi59GX+8tdenNmSAiZlO4Nr6w2aWiyYmknOYepdQVk1rOYgXalmRM2NUyPJAA9s1T5VVlrUdWv/RxIywaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746597493; c=relaxed/simple;
	bh=noM0OddCe3nMPsrUfDxNQxDN+cqV178/y6VH8nlyRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzhHzt0kVP1uahI9zVtABokHYIM4myGwYcShuxbmpDlrKb6MUHCIHz+MIV1OkpDBe/yf1MHaZx5+oVkZ+NWB4zJd5PTxbo0yjjVwlziDN2TwE70KRmF8JNmmaPsL775wwdjWPYZKUPFiSb35c29ejpkq3f/JhQZ/z+ITX2W2Zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alf+rWYA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54b651310so1013433185a.0;
        Tue, 06 May 2025 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746597490; x=1747202290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62xNdgK3PUfEz8Xz7n17PoKO70VX0ZqDvch6tNNuGFk=;
        b=Alf+rWYA8F0MIy7/vQOt5N4UMZXvHS2PNOScTJ0aRyIpM2MqUNaxMlZ+q91jzwSi/L
         0VmIs8L+2JTnL3k5gQaDZZBszqSX098BDOwzqMqr/NBcCHgoF5xsa75NwM0RhT9v63A9
         oO9cvR5p/8Fm18y0IR4ViYbhLHRuvXTrD7LAW/mM03eizFwc7Ca5k3unYWexwpwn9k4D
         3wKA/29a/qCqgEf1D/u0IN+ThtmAeyrX8UVDD4BJzRHum9sg7Ld2s2uAH2sLrzLyGMqv
         SWNIW0rdXkvOLGmEoW5lqRrRBQ1lT646Goo9rfZahNPN/H4APhjlW3oKJEdQnqH4IhIJ
         WH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746597490; x=1747202290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62xNdgK3PUfEz8Xz7n17PoKO70VX0ZqDvch6tNNuGFk=;
        b=QlktX2beIGjAwZJf+pydUuN3lJNh74v44ET0Z9K2rT3teyxVUwshGIyqxRVtXf9TZK
         prcErEr46FCh84JzgHgYCZd1hc6WNu6EnZKkf0rdRQPji7GYXjVgIzICK5mlZl0omYCD
         T9MlbmpWnHrhpMFT3attywEZJWgr0m3i+MHbsfUIz70ol/C3dNiI2VyWXngTbtftxqaP
         6IA9mUAsPkehhP/Y4d+9uP/ncEtNZbTzoffnkEKmkCZiV5R4as7ndn1NimI1wy5Gvgkm
         +5Dsc5qPtT0g848QaDhD4bdNcvlNU407PEn28tBjZwr6+8iGG6EIrcrWUHvLgKxIT0IQ
         +KUg==
X-Forwarded-Encrypted: i=1; AJvYcCXsvgW3g/Y+NzufTt+pnOck8SBB2bMf47NmvIQ1MD7v6e7eR/dntGAE4yJFsSGrooLoRNjXn9ZxuX3J1n6v@vger.kernel.org, AJvYcCXzLqB0pZqh6RlO1VLOSw1EvQbv2GIJH/nkVH2MRLv7U0SpoJCx3QNH9sUxd1imB/JZVINuVXdQab0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1JHpuOuwHh+TRxK2JrGJn91F4rEpBCG6R5aYYdik/KF6pmfo
	9oDHxdYrz0FfuAgPv2vVStDCVwVStDdjJfOK5ufWQfxiKjfbvI5OpJykzaucXR4=
X-Gm-Gg: ASbGncsa+VuEwZa1Om+GbuiCtOmCl7NOu6wdjduv3zXhaZJICaUFJz7ng4nDIddH7iC
	QYkKztOcW842MuMccuXIQ/pcpzmdDwDX4PC2h2SRal0B01/KCD662MRkROSnYwXEH2uc3D1bcjb
	U1JmBBDJoHvZfUI0kpXW7CnyGRMVRmaXEHKkD1ZKYrlNFd4cAZbupK9Wg/RQsKmBrwHzqe1Rkd0
	ym1vXnxmMHB8YqKFTsrL3MHNn72ShjSrSL9Id0aLXuLmBexPG/HkWEYyNTVXioMZyjM2g67nLa0
	/bnNd2dXNn+xFFbQKDBhSffeNBD6cLy5r7FYbKuRV6/D7tadtAoJwyVmQMEJPg==
X-Google-Smtp-Source: AGHT+IE+Zs0zPxJ7NZCpPs3fbxcykASWphbwWyDcObU10VQPB9Wk3EyEc/S3iCZ3HP+raP3xoSY8qw==
X-Received: by 2002:a05:622a:1356:b0:48c:4c6c:bd8d with SMTP id d75a77b69052e-49225560462mr30989061cf.2.1746597479722;
        Tue, 06 May 2025 22:57:59 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49223457b48sm9365871cf.68.2025.05.06.22.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 22:57:58 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation
Date: Tue,  6 May 2025 22:57:45 -0700
Message-ID: <20250507055745.4069933-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Includes the following corrections -
 - Changed Measurment -> Measurement
 - Changed clode -> close
 - Gyro -> gyro

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v2 -
 - Changed  X-AXIS -> X-axis

 include/linux/hid-sensor-hub.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 0f9f7df865db..e71056553108 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -17,7 +17,7 @@
  * @attrib_id:		Attribute id for this attribute.
  * @report_id:		Report id in which this information resides.
  * @index:		Field index in the report.
- * @units:		Measurment unit for this attribute.
+ * @units:		Measurement unit for this attribute.
  * @unit_expo:		Exponent used in the data.
  * @size:		Size in bytes for data size.
  * @logical_minimum:	Logical minimum value for this attribute.
@@ -39,8 +39,8 @@ struct hid_sensor_hub_attribute_info {
  * struct sensor_hub_pending - Synchronous read pending information
  * @status:		Pending status true/false.
  * @ready:		Completion synchronization data.
- * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
- * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
+ * @usage_id:		Usage id for physical device, e.g. gyro usage id.
+ * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
  * @raw_size:		Response size for a read request.
  * @raw_data:		Place holder for received response.
  */
@@ -104,10 +104,10 @@ struct hid_sensor_hub_callbacks {
 int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev);
 
 /**
-* sensor_hub_device_clode() - Close hub device
+* sensor_hub_device_close() - Close hub device
 * @hsdev:	Hub device instance.
 *
-* Used to clode hid device for sensor hub.
+* Used to close hid device for sensor hub.
 */
 void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev);
 
-- 
2.43.5


