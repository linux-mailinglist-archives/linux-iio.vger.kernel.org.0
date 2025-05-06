Return-Path: <linux-iio+bounces-19203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CDAACB21
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336223A04A7
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9892857C2;
	Tue,  6 May 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTwRICpZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B4284B49;
	Tue,  6 May 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549341; cv=none; b=IeIYgYtFRIsjD/SytTVxHU//GTtPd42cyWM4F11BqXaWAiQZ84mX/7SPkm2ObmKcpi4O5AVTc/1hX7J7jy3WBONrj8hcSKPzPOtD5NaKWIFouaM5/SHymZ3KAbGC08bXsY/lEqCf72hT90lYbtk4B4B4TT7eWlJf7ljg5YRLT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549341; c=relaxed/simple;
	bh=hx2GmfBEs3YVwCNE28DAdxss5g0w8K0I8FdV8jDQkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJCTSByWSHlB97ZEJImCIDv7odnX6RHHPkCQvRMeId7fgugli1/W50V6eGVSwn5okLmwDsNiUE/Ax4CFGMpoHfRLiTU9BqtGnqGKBVkAElhjh+S72OobH2XUjnPUJ1G80YAu/Vo3bwoztbKRhQoqZu+C8WaQRGa7dCxQZ2omXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTwRICpZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso8879946d6.3;
        Tue, 06 May 2025 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549338; x=1747154138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvT+lXwAZdK17G8fy8dtsIjqoMmINzyyTp6bNm9ENFU=;
        b=CTwRICpZE5UQr33dXWSVQm3PIoYtkz48J7J+6WQjY4Pw10gSLNazR/PQj03amu0yxS
         eEF5o3rC4Z5j1ibVxLMVDD7sSOZ/ZwyG2sRJrQT1DtHlDNHj5JjMnC6peoM1m+0p/ROy
         BhSgF2SiBRN/sjkp1thHfElOdG19PO0yzFntvUdkjpibLwpe/hy9sNlZN30xjdAVCang
         WY487wJQq+dYgIjGLxsCRyzX+q8dniNi42Zfb/smIjNT7VmLHZBUPa2N2KqnH9GrqKe4
         PpG5ziIP2EjQ2+Ceirozmt67f1MvkWLaXPIHPAMt4lu/EeAdnayn2zgQs7TDvBtaedEm
         m7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549338; x=1747154138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvT+lXwAZdK17G8fy8dtsIjqoMmINzyyTp6bNm9ENFU=;
        b=rYaXTEl6u+uMbkIgay+k/vJkxcXEV+ZDQh7GL21pNaJFxwqPs/qGnOHldL2v8V7ddZ
         crjd6XsnvlyrkNs8GeZbKDwch8ZY25jbHvkqfBHHrhFuuxtn7mPhjd9+OiSUd+i6GJO1
         /+LElDexcUF/DJetu1hYQcALqDRUMJZxx7qj045/9xCzMjM5m7ehm0z0EH5hbKlNgJ3c
         yMRcUnCKyWSnIWMVOGjxlx7Kh2wkCwH5IwztpJBhYAExWdPqMb9RoSowWbPdD4lrOCxK
         9HY3eyke/Puv0M5iYC3PswAUlbSPLOZh331ljZJAOB/GmDHwuQTmRGTy6zJ04p53CM/Y
         DQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdqQgUO3uzsc3yx/ebJtBMzzhh7R+5VDo0OHffzbTKNFEGb9p1/X2lSCyagArCVRZbDdg49YZCgBI=@vger.kernel.org, AJvYcCVkQalhRM27OpUf5Hvv4IzN6KQW1au2IZ5YjKP2+zRqQtSRsNHcIP7Qd6b9ONAcD8AsoTnzMhfNolWPyDxx@vger.kernel.org
X-Gm-Message-State: AOJu0YzffpKFbyvwVcB7K6CMMPizVASXu/JWXFMgMPLLwq1ST5yzkWhJ
	NqWotjr49kVrh/dPR/vgdQf6GceKpB7cX2xCIx6cmmvsijL9RFmb
X-Gm-Gg: ASbGncsqHjtb75xDZFS5e05wgW97ms34eSAOaqQ8e1aFFXzpO+LYT2yMcu4loxigS9T
	dsU7XChHElTearMMBu36cHMOxMcm1XBcIiOYRh/1MUoN3azVwVGRLeKRCpziCcNVmRPg09UoUhL
	1asbCwU3S7KM8Z7BZ5esNqBbuJ1cd+eyBrohYEBQRtyqaPKC4XIT+hDvB8sQLhBIIPHQ2oH7asb
	/qIdNaitF12bmWyCF+Al0bP+1LHtSXY6/MNpImYpaZByhx2hKVd7PXeagWf16sC1MW0GOKe2PcX
	ZgGmQVpnCKbUXV+hul2qnDk2qpTlsBPgJU9FhSS68L7Aj+4mG8rEjLN3NEhXQg==
X-Google-Smtp-Source: AGHT+IE8E1nnlrLB/Gb2SXRckPO/voZepjzp7qWkwi6b3Lmh+d9W75XhkFp+uX9L+AEakgV84zNREw==
X-Received: by 2002:a05:6214:496:b0:6e8:f4e2:26ef with SMTP id 6a1803df08f44-6f5354174ecmr64482786d6.31.1746549338554;
        Tue, 06 May 2025 09:35:38 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b030fsm72331396d6.13.2025.05.06.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:35:38 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] HID: sensor-hub: Fix typo and improve documentation
Date: Tue,  6 May 2025 09:35:23 -0700
Message-ID: <20250506163523.3262037-1-chelsyratnawat2001@gmail.com>
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
 include/linux/hid-sensor-hub.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 0f9f7df865db..3621d35a00d6 100644
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
+ * @attr_usage_id:	Usage Id of a field, e.g. X-AXIS for a gyro.
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


