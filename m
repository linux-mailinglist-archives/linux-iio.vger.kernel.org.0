Return-Path: <linux-iio+bounces-11756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB629B8E31
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 10:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3DA1F2214B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8115990E;
	Fri,  1 Nov 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oMbMQnuh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9842C0B;
	Fri,  1 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454772; cv=none; b=CqJeyY4MYH/yCRwvNvmf40aLpl6OSZL1mE9Dqtu7D4IlntbP+qG5uK3FkOQ+kxUuwtpfxU61bsN42dtyuSgDm/L5BwfzMKOa5itJTvavsAPKNg/SIVIQUzG5Ze+Q3W+aVPBFlWbIWzoGkyR+69npHmTq4WpsTS/G+UKQA0a1lyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454772; c=relaxed/simple;
	bh=tJ/fGoA1skodvpCiPIjWJ9O2i9YYHjMXa6li6wcUc6w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NN1Kp9xzbygpnBXc/cx2TRCL4ZpESPaSiwcnUdLuQoVoBIbPq9i4/s+AWt1wXijl6ZtYqSXN5dEvnseK+tnJsiRsCbOSaI8GfNb0UuRUaw1h5q8zZoHiby2sOWLJypzvzKyKjwZjinkjWupx+x6mWAw13i4nW2YXmWPcs0y7Iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oMbMQnuh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A15jHCq026680;
	Fri, 1 Nov 2024 05:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Fa6jU1MdHl7FUJcaJ91oK3EAi56
	FdnhF8cp9byp/Ojs=; b=oMbMQnuhqKuvs/jVvB19p0RZfBbpW/VNl5j8KRDilHM
	MRbD0roI/TYbLV78JuMcPRLeNtBFxCFhXcawGnJnt4mto6O5ayo6RJZl0J7z4+sV
	duHTKgJXQH5nlmyA9LiPGKlpyDwq8GFEqJlnV9qSaJdv24vn78FcVmq8MLyT0w6c
	EQroVorBDyLRGUV4dw2s6h22J1JxWwB7VAOChXHabaampji3ZA27B+WvOf4IFLJ3
	aOpVoOSyl+rmMlx6yTUqEBJPaHv2OFbtPoxYfJdJp9WdpWqo2gEd/9qIsrWOwFvf
	a5YX6V7SV0QWUzZ2vijCR/8dxW0pRLWKoiym7GguoWg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42m2gmps96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 05:52:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A19qTNo030992
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 05:52:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 1 Nov 2024
 05:52:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 05:52:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.114])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A19qDY6011849;
	Fri, 1 Nov 2024 05:52:15 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: accel: adxl380: fix raw sample read
Date: Fri, 1 Nov 2024 11:52:01 +0200
Message-ID: <20241101095202.20121-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ieRXWa07U8RK7zF_5F7INSsP718VLQKv
X-Proofpoint-ORIG-GUID: ieRXWa07U8RK7zF_5F7INSsP718VLQKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010070

The adxl380_read_chn function returns either a negative value in case an
error occurs or the actual sample.

Check only for negative values after a channel is read.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index f80527d899be..b19ee37df7f1 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1181,7 +1181,7 @@ static int adxl380_read_raw(struct iio_dev *indio_dev,
 
 		ret = adxl380_read_chn(st, chan->address);
 		iio_device_release_direct_mode(indio_dev);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		*val = sign_extend32(ret >> chan->scan_type.shift,
-- 
2.47.0


