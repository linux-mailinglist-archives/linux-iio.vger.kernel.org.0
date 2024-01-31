Return-Path: <linux-iio+bounces-2067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A5843AD3
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 10:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961B328361D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5F6772F;
	Wed, 31 Jan 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YZPnYZix"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFF55C2D
	for <linux-iio@vger.kernel.org>; Wed, 31 Jan 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692452; cv=none; b=XAAAuuzT/eT5vN9j+9tRmBLmWDfESW/xAhc/avabTh5xs0QqoufJvt/s19dMReFR4Bc6Jl6ATgIrVUKyuHPP3uow0yNhDKu9qG4ouA+cyPgyT/Sv5o3zfUMrFkHg6CyCptXUr+bYmlpuh/6sIsTyk4mlOptkVqqsw0wZteuCk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692452; c=relaxed/simple;
	bh=lpH+MkV1lSzK9l3O9sfUUCt9N/pdoKxSrN4yYakWhi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OcVA5eLteTMOvwlLtBUFI8uBLYPHYj0TDHWXGrdfH16OIZ1Y+4umDYLSFWSj2kFnlfQW/jP5DkmAegODPAwZEQ3qw6Qrbx22dmWHraOKo376zjsgmSZ3JCnYORgjci3vhl+nRICX50BC3ZYkqZ2ROsxfUH6sxSR0OyMpY/PpW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YZPnYZix; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V8PA0O007363;
	Wed, 31 Jan 2024 04:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=DKIM; bh=2x5MdreN
	helYY5uubHAog1mMBQJyHnOFyQbw7SbcBoA=; b=YZPnYZixSaNNn7yY+zx75r0v
	WVXfINMDlIOIR6NlZwSjoj54+7Y2X2DJhpfBGEzmhBC/GjokHEtEU3QMVX1OojcA
	ZOApIc7A8Fw4fibzKlc+5FCGRym2mGMMEmzyy6iA5X9gU+amnOEsvM9dJ8GET6Sj
	hJwZ7vH4YAp1DhtnUIBlV3foEPrIgP0eZRz8C2ue0rxybc1i2BiVwx6OdFvaU+C1
	zXApybdIjCv7I8Ft24RzCQBiIx1ODHrfhMIObLD1T1VvkjVa79C1pkfyJVG67rdf
	3aFQlv8e9Q8Q6nz4hI63BoD0lly63Tizol+6pl22k57x6djVFRQc02OHVt2nvA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vydja14ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 04:13:40 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40V9Ddrt050775
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 04:13:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 31 Jan
 2024 04:13:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 31 Jan 2024 04:13:38 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40V9DTqO018521;
	Wed, 31 Jan 2024 04:13:31 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 31 Jan 2024 10:16:47 +0100
Subject: [PATCH v2] iio: commom: st_sensors: ensure proper DMA alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240131-dev_dma_safety_stm-v2-1-580c07fae51b@analog.com>
X-B4-Tracking: v=1; b=H4sIAP4PumUC/x3MTQqAIBBA4avErBPMAq2rRIg0Y82iH5yIIrp70
 vJbvPeAUGIS6IoHEp0svK0ZpixgnMM6kWLMBqNNo6u6UkinxyV4CZGO28uxKDvq1jqDzhJCDvd
 Eka9/2g/v+wGw8lIHZAAAAA==
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706692607; l=1489;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lpH+MkV1lSzK9l3O9sfUUCt9N/pdoKxSrN4yYakWhi0=;
 b=WafAL3wqJ33Ix20MxVTTPLx/JzXTr+Ii6zAYozpX2U3YeFri9OuPB8RZoza7/EsrFMwGEV+sX
 28LP9YbhIoaDkhh/2WLFlibjLojfrusas7fvGo/ex3hDLC+8U/Cu9+W
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Myd0u_AtP_bk581uexsH6utaGeaLWAgm
X-Proofpoint-GUID: Myd0u_AtP_bk581uexsH6utaGeaLWAgm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=515 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310069

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for st_sensors common buffer.

While at it, moved the odr_lock before buffer_data as we definitely
don't want any other data to share a cacheline with the buffer.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each buffer enable")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
Changes in v2:
 * moved struct odr_lock before buffer_data.
---
 include/linux/iio/common/st_sensors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 607c3a89a647..f9ae5cdd884f 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -258,9 +258,9 @@ struct st_sensor_data {
 	bool hw_irq_trigger;
 	s64 hw_timestamp;
 
-	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
-
 	struct mutex odr_lock;
+
+	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 #ifdef CONFIG_IIO_BUFFER

---
base-commit: 1380d453434e276355458e712c743dd071ca1fa7
change-id: 20240131-dev_dma_safety_stm-7c09782d87ed
--

Thanks!
- Nuno Sá


