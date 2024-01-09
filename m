Return-Path: <linux-iio+bounces-1511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862C82893C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91F4287FAF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB739FF5;
	Tue,  9 Jan 2024 15:47:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8B3A1AA
	for <linux-iio@vger.kernel.org>; Tue,  9 Jan 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409CVHX6024827;
	Tue, 9 Jan 2024 09:00:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vfmjshs9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:00:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 409E0HY2013519
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 09:00:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jan 2024
 09:00:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jan 2024 09:00:16 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 409E09lG018844;
	Tue, 9 Jan 2024 09:00:12 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jan 2024 15:03:16 +0100
Subject: [PATCH] iio: buffer-dmaengine: make use of the 'struct device *'
 argument
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240109-dmaengine_use_device-v1-1-1cbdb7fe9f29@analog.com>
X-B4-Tracking: v=1; b=H4sIACNSnWUC/x3MSwqAIBRG4a3EHSdo79pKhIT+1h1koRRBtPek4
 Rl856GIwIg0ZA8FXBx59ylUnpFZZ79AsE1NhSwqqWQv7DbDL+yhzwhtEzEQXV061Tcwbeco0SP
 A8f1vx+l9PzD7XvhmAAAA
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704809001; l=1185;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=PibrZKOCAB7SkXP4dStaSKhGzGRQovyrwT7RdDOYVoE=;
 b=18qr5xUg1ptP3lhVnEORUDtD/DYPZ7YU9bSlmJ9R44ZWQ2PCaooaiU/YQbVzqE7b10v8Ac3Z7
 XJZHLlZi0RnDA5hzoGngPT50etH9xPpZuZNHqbEj/yuP5fh7DZ2DvFV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: LZzGag1FigIc9CvlApbIwzgUxSk0nTGA
X-Proofpoint-GUID: LZzGag1FigIc9CvlApbIwzgUxSk0nTGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=846 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090115

Respect the @dev argument in devm_iio_dmaengine_buffer_setup() and bind the
IIO DMA buffer lifetime to that device.

For the only user of this function, the IIO parent device is the
struct device being passed to the API so no real fix in here (just
consistency with other IIO APIs).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 5f85ba38e6f6..45fe7d0d42ee 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -279,8 +279,7 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
 {
 	struct iio_buffer *buffer;
 
-	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
-						 channel);
+	buffer = devm_iio_dmaengine_buffer_alloc(dev, channel);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 

---
base-commit: 3f4525f924e21d4f532517b17a20ffa5df7c0db7
change-id: 20240109-dmaengine_use_device-853f196ec78f
--

Thanks!
- Nuno Sá


