Return-Path: <linux-iio+bounces-25322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD87BF5E6B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211AF18A213D
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE032B9BC;
	Tue, 21 Oct 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y6Ggoros"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD32EE263;
	Tue, 21 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044056; cv=none; b=PNnF8FKum2VwY+n+zpnrBz692F2+MJLeoBaFsZGGxsgh7cC/Zr0d7XBtE5qH+Wd7uauWFI9LLGUvSkm6T/bed7YgkwOTMSW4lJ67FfpXpvbJZOPe6AwAqZ/uQCHEDXFmosdYgwe6U8wSgi146M5I7EJ0THEdRheP8WAGkGk9kX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044056; c=relaxed/simple;
	bh=QA7zZbPrHE/N16ZUwYubJEEwrzdcbm5YqCVo0vzb2oI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+DJHkkbvzvBzy+elKLuxYyv/ZNDJVRe9GubbfJX/zwo2WRQwCH+oZfOmXQI2dAwv2AlRvpkQIvNiiDjqM0IMKD2/OCTFcgnnFL5ZPtwVqOUdZbaJJF6Co17MjFn1+YSOr1qA++q+M5Mt/+9hOYeDTwtnGzY5il8mMJI8fp9tP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y6Ggoros; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L9qf5B026565;
	Tue, 21 Oct 2025 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PlkVErwF/spnR+hzWlLrq+IBcGA
	oaLKdUbIfvjdLTLs=; b=y6Ggorosz5sEI9BImiqTDP+iP+pxaNXknaSK2k5O/fU
	0rnTIf3fdfpoebv5ftiuzybg3eqAEz5GoxK77DVSFvGvWiWHQLUXxX7UGrAcu5zo
	21zbTL5oSj1FGfHtIV2VJsivf4uzlX1fmbUXfF9/zdJOItqBgFoajQ825Peqc2+D
	YRNd6iAnUEJPbLzjG8ts/u7lDSn6X2tyEPDTq3Cf37Y816riD/kvGUyMO57Ozhtr
	tKtWUDkv+LAqwUhhKZYYa2tM4vNbxQGYvuhbg3Ef9Vo+fLCuvrjJgUqpvuF5DJzO
	A4hruaOXiESvflodYxOTChqicGwIOyPhfwd63Zn5pFQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v7t3f453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsBGS051714
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Oct
 2025 06:54:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:11 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Ki002507;
	Tue, 21 Oct 2025 06:54:03 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/6] iio: adc: ad4080: add support for AD4083, AD4086, and AD4087
Date: Tue, 21 Oct 2025 10:53:42 +0000
Message-ID: <20251021105349.21145-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDA2MiBTYWx0ZWRfX0UXogsbquNey
 JvDpYLv/vDK4Url1qRolViHhxML+0y48AIvk/gFeRSlJIgZkTWLNGB0jYUAopxiDgpQEJ9ccy4J
 E6nBAIeT4TpvjLcNbHm5Xqd/T8j/19iW+BPKJPCnDymRBh+Ri8j3w8QuAxhZ2/YMrdev9VgvrQs
 8rvHsn2Pksg4Qxo94F9ShafoJXitJH7SC2o/e4dxAiJ8WcNsoSCASB5GawInAb2VIWxw2tL9jFG
 lFI76N1ym4BHTojpmNckIr6fArDTPxvs0XqSYHQfzbYyLanR51WzWRO9rNpj7u+c6rEad26Uo+4
 R1+bVYAFzfvZ2oHnrivrvPfXFSCdGk9SNvPAVxaPz7YAYJao9UKExhFD09tcE2GxTz+2u0j/bs4
 vJvPg8z2cwXV7RGIefAHcF+BIw4a4g==
X-Authority-Analysis: v=2.4 cv=UPPQ3Sfy c=1 sm=1 tr=0 ts=68f76654 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JeAymjvy0TpzZO54nA0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HDqIAVHEKQ_fhqWZUSU61G8FhEGsiYuY
X-Proofpoint-GUID: HDqIAVHEKQ_fhqWZUSU61G8FhEGsiYuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180062

This patch series extends the AD4080 driver to support three additional
variants in the AD408x family of high-speed SAR ADCs: AD4083, AD4086,
and AD4087.

Each variant has different specifications that require separate driver
configurations:

- AD4083: 16-bit resolution, LVDS CNV clock count max = 5
- AD4086: 14-bit resolution, LVDS CNV clock count max = 4
- AD4087: 14-bit resolution, LVDS CNV clock count max = 1

The series follows a consistent pattern for each new device:
1. Add device tree binding support with appropriate compatible string
2. Implement driver support with chip-specific configuration

All new devices reuse the existing driver infrastructure established for
the AD4080/AD4081/AD4084 family, requiring only chip-specific channel
definitions and chip info structures.

The devices cannot use fallback compatible strings to the base AD4080
as they have significantly different resolutions and timing requirements
that necessitate distinct driver configurations.

Antoniu Miclaus (6):
  dt-bindings: iio: adc: adi,ad4080: add support for AD4083
  iio: adc: ad4080: add support for AD4083
  dt-bindings: iio: adc: adi,ad4080: add support for AD4086
  iio: adc: ad4080: add support for AD4086
  dt-bindings: iio: adc: adi,ad4080: add support for AD4087
  iio: adc: ad4080: add support for AD4087

 .../bindings/iio/adc/adi,ad4080.yaml          |  3 ++
 drivers/iio/adc/ad4080.c                      | 45 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.43.0


