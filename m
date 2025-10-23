Return-Path: <linux-iio+bounces-25368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47BC009C3
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0EBA4E5281
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C7309F1D;
	Thu, 23 Oct 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="frfIaidS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A418A6B0;
	Thu, 23 Oct 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217326; cv=none; b=aAbZCUK88xsjKSR2XRZEGKZ6DroxrnY7yYKtetHAnbHe4Rtxl55A8UZ2ojsJ21b98Ylfbk/4iL4nnPpVgyH2bJNPWS7DdJauIFdWAfwtGcB6o0DKvO4eM6q0qnmJvqh5zivy3WtbWp/rI1KMQMI3XkupDqnmB0j5Yh/FnENw24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217326; c=relaxed/simple;
	bh=OLuMhxzb9SqQ1d4nY1XOuZOobzE7xmEyx31Na4w1lCg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=A9R14+UZYeOpXmyR0KuilG+AbtOJDnmgmaWPbE7z8xOv2Ae1wDGS4mcF3EqXAKQCjIbQ4rfkBm14hjLfLlcEpU5BhDBH2qNihKj2CzsEQ6I0Kf+yQPyj7wUkUwrpRjlgKUrrsW8L1vUU52oO3qgvC837/dzH8nsEKmQO7xiWEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=frfIaidS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9CXvX029338;
	Thu, 23 Oct 2025 07:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DrR0nN/pRU1rPzZBIDdVX36/BYu
	nSMozjVsDvc+O9F0=; b=frfIaidSrF43QFEC63gobHnMxbjucaNtGpg5F2UdCPK
	gpNt74UG2HRu7ZBn3lr6ibCMfPu5CKLt5DN1JpjCaCUqd/jxG1bc42JJ3yUl4eXQ
	StvN4YSciTcSeiqxtUZv6SJ7uC6MJReWl1wZiaL6aDwgLUpb92l2Gvr32CLBO4uh
	3aECkK8qa8sUrQaHI+/CnQlQxljI+Fe48L9cwD39kKNAzTPjBhy6p236UNcEJALJ
	ACFvL4b5bfcqt0Z9RfLiQ9jNWerT8SJENwJvWXfyiUMb2NXrd8inEhIyKRtgkujF
	OIjvm4eafbWe2cNY0ViBo6qYfjaPKTW/YXZpjvuAvYg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r55pw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 07:01:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59NB1wCs015098
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 07:01:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Oct 2025 07:01:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Oct 2025 07:01:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Oct 2025 07:01:58 -0400
Received: from NSA-L02.ad.analog.com (NSA-L02.ad.analog.com [10.48.65.124])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59NB1eqt027813;
	Thu, 23 Oct 2025 07:01:43 -0400
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 0/3] iio: dac: ad5446: Add AD5542 to the spi id table
Date: Thu, 23 Oct 2025 14:01:36 +0300
Message-ID: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABAL+mgC/x3MQQqAIBBA0avErBN00IiuEi0sZ2w2FgoRiHdPW
 r7F/xUKZaECy1Ah0yNFrtSB4wDH6VMkJaEbUKMzGo3ywVk7qV1SkBSL4pmZDe3eIUKv7kws739
 ct9Y+ueIBUGEAAAA=
X-Change-ID: 20251021-ad5446-bindings-f8fff1eba522
To: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>
X-Mailer: b4 0.15-dev-52d38
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gdYYlrRMsIIISpV4dP64ON4kvAluigZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX0HGVsq6IwJYf
 8aPyrr0qCiBn3DKkIZna3QBH8Fb14y/FJv2ARzJcHoEImik93NEhpG+QAeyome+G2OfIieJiNf3
 gI3gz/tDsictCP6j/K2+TCEwGKio+adbn9EGlM74Q98TwPgEt6pnDTuQdfzSO4MUXwyAXoHuD0h
 TF+rX+yKfE4Mcg8jbpwznZFGIZXU0j0sVBgK5smttl7j8GmOI7n3DTOmRB47uE9amphaUts11Td
 7dn8koJq3s5wMEMtsGWiF5+C/B0BE4eEhfhM8F2cOPi/w5F4PeqHirhj4EZ4/RCQD6XBGO9f+NO
 jDOCDhauD6QS7KtFn41SFDtRzl8nLjSOmF61viRGgbRAgeSnULThEXNkjmEV7F+nXn3cRYdh01M
 MEKHhOZY4PXJsau+VDkR/5XADierLg==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68fa0b28 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=4Npf1NH9n1IPuyPjWQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gdYYlrRMsIIISpV4dP64ON4kvAluigZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

Hi Jonathan,

As discussed here it is version 2 with the missing bindings for that old
DAC. I realized that one of the compatibles is already defined in here:

https://elixir.bootlin.com/linux/v6.17.1/source/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml

So I did not included it in the new bindings. But I wonder if I should
remove it? Or (just remembered) put the TI related parts in that file?

v1:
 * https://lore.kernel.org/linux-iio/20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com/

v2:
 * Patch 1
   - new patch
 * Patch 2
   - new patch 

---
Michael Hennerich (1):
      iio: dac: ad5446: Add AD5542 to the spi id table

Nuno Sá (2):
      dt-bindings: iio: dac: Document AD5446 and similar devices
      iio: dac: ad5456: Add missing DT compatibles

 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 drivers/iio/dac/ad5446.c                           |  43 +++++++
 3 files changed, 190 insertions(+)
---
base-commit: 89cba586b8b4cde09c44b1896624720ea29f0205
change-id: 20251021-ad5446-bindings-f8fff1eba522

Best regards,
--  
Nuno Sá <nuno.sa@analog.com>


