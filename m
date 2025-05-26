Return-Path: <linux-iio+bounces-19919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D1AC3B95
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9632316DDAB
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F01DED4C;
	Mon, 26 May 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CfDgTiqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A831DDA34;
	Mon, 26 May 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247778; cv=none; b=VTmnUHJwoqUm8X5maHwS/tgaYUnosBR2VWoRlGTlbezLfTFSzgAExDz/AGw1oc1y3/pK59wKjAfswb+Iqa0CsWGwhjBMIFZpGpKSBj4RsObPwAB30LY/+Ou/zkSTqGIbkEKsYhQUNf9lpOhMk9gGmF3PctHiYA4CoypkQiJGVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247778; c=relaxed/simple;
	bh=OV4iA5Tsz75wseP0OMc150c3LmeLNxwlc5BR6jf9QXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hkv1oYMRaj9inyW7wFiQuTENjucRDg9Qt9wcEXE7DwGZfYS7WsxMXj7Y3Xy1xToFVFlbyZ5w74Wca/EbuxMblzSCUMKQ8iX78iuOXN+h98BNvXoaoE2/3bnUsH3k1CKuh7OCoqlopF0CX3dFkxmMTL1rlH3pkakV1WxBDuBDFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CfDgTiqo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q6Fhir021644;
	Mon, 26 May 2025 04:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=hWYYAdPJxWmcW9eifcpBR5SaiRH
	nAgz4BuGzFoVo4fg=; b=CfDgTiqocqiVqJurczcBz1XKifpMrploXLl7mlGxLK3
	Nh0zA02Ku1X9XlO9lPgWrXdySonT9kbzh1HTjfCWdibV+PirZ3oDyvRE1qK3pC/h
	z9StQ3+Wy6qYkF/jmdU8QEJo9e/0rrhYdUw2aD0sOahpybRLizjq8NfTNziFyISM
	m7x7W8jRTvs1f2WBY2wKs9D0/hogx2Z2Vdpe32aroJ0N9RF/kXiIWuPfkVwmlZWE
	xCTEOxMjmqcj35/gbk3YcbGZESwwqC5EzBLLezS97zhYDbbg9D06OrwUoXi01xN5
	1QlwJzRwC75dsAzGi+CVZPCNPcaptfO1COjGCg491dQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ub16f9bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 04:22:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54Q8MlfU026827
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 May 2025 04:22:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 26 May
 2025 04:22:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 26 May 2025 04:22:47 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54Q8MdJA015981;
	Mon, 26 May 2025 04:22:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v2 1/2] iio: adc: ad4080: use lowercase device name
Date: Mon, 26 May 2025 11:22:27 +0300
Message-ID: <20250526082228.4961-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: KR-0ZUhVJsswada7HJpUSEcd_JWbRRTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA3MCBTYWx0ZWRfX1LUNfRwzBbxS
 3jAn3R5hmubXpYQqKjtEX1eMzEFOirS/y2MqvkRpuSglOfO/DjbWPLeT8M1WtK+5//BBNR86mkU
 56d+XGK7NPpXN6CUf5osdngeguEAW5DmYuQc7/xxECpeZIJUpPCLjq4f0qm2S/+xiRgiNJ0vvWp
 cI9d4oVhFD7JlMnJaMDEbE+j+Nd+la96pjWefIrC/6Q6oCWcI4wH2OBbmGUgQ6e9cT5kIQVX3sq
 nnWzQwepKjMmgUMB2n+YurM5hyvjcO6HxIxHpyob0j66FNUmFMP03xii3G1UHAuGh5pyeQgWwNe
 0DGoHiPqU/WgS3X8IJ2qwmsTUM0kZcTHFUBuAOLa56W9F3anSsUzALRoMon9lY/m7dHrZDkAOr6
 4xAbR7+rexRPAcoV/NkE0MvA1gWvR2ujC/I+0KVv29NL2D3BhX1arNBCKMq8P1wsneB2oc7H
X-Authority-Analysis: v=2.4 cv=XemJzJ55 c=1 sm=1 tr=0 ts=683424d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=cweWXZ_D9D-fF1LecnIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KR-0ZUhVJsswada7HJpUSEcd_JWbRRTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=995 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260070

Update the .name field in the ad4080_chip_info struct
from "AD4080" to "ad4080" to follow the common convention
in IIO drivers of using lowercase names for device identifiers.

Fixes: 1ff3f56f846b ("iio: adc: ad4080: add driver support")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - drop "no functional changes" from commit body
 - add fixes tag
 drivers/iio/adc/ad4080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index e8b2e5e7a68a..c36eb41d738a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -433,7 +433,7 @@ static const struct iio_chan_spec ad4080_channel = {
 };
 
 static const struct ad4080_chip_info ad4080_chip_info = {
-	.name = "AD4080",
+	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
 	.scale_table = ad4080_scale_table,
 	.num_scales = ARRAY_SIZE(ad4080_scale_table),
-- 
2.49.0


