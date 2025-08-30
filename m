Return-Path: <linux-iio+bounces-23407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E01B3C668
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F6A7B863C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C51C860F;
	Sat, 30 Aug 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="spXEzPbk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0D1AA1F4;
	Sat, 30 Aug 2025 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514478; cv=none; b=UgBEczGSWUVmT9QtCrIvCeZD5tCvW59MvSVDoC8f5JY2GEI1Bt4BxaSNmZJxeY5Uj1RT9iAdZhpxHeUi91HwpxtdEkdxrw2DdM7ZIt63T4D9lopryUNWxODflKsc/HOD2no8uwt4vmiBkjsuTutip8wh5xePp4730XbvHO/068Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514478; c=relaxed/simple;
	bh=Pe55wo2gFr489CdQnRkh4RhWQTf6VFz4ClEehQwr5e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCjl8inoUE7DTjLwPEDMWpQ70+CJ9mRsbu9VWtB67r+jRvLrM1ZPI0X1sc/EWARDvNTi0rU37mmfj8pkfVRAMbhVMUi+CIScNShXRw9xlUrwdoiIzxo3der3TANUXPJpKwOby2TyaDcnqM4uKeERRhc7BLRiHtAH11A6c1fOpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=spXEzPbk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR58S013287;
	Fri, 29 Aug 2025 20:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mevRU
	FrTvmP2aQhlcYi5zEr7c4VKUq6862T7mEC+19A=; b=spXEzPbkDAGREpYph/Bk/
	Xv4Od/CnT2aqlbMRZpKU+pgP6Et2SaIaeneTgHURUkcLMxtLN2N/p94WtOIue7yb
	jcrqo06ZbeDKcJJSocfGsqWPgxAsWgzSrkSFDFVrqBZOl2t2QYL824NMITyPTB7b
	nGHBL7sYxdg35gqvVs5SI3ciXSSqocgv3jbnzLcwsaOwwkNt1YOzUpCfOKZzWJ2l
	KEFkvYf8mGKRA2GcHhLsSu13kmgTF6mk9pq2JjYhUl1IEsq9F1B4KQxGYaBldklk
	FHwi9qRmm9p/TeWn6aeR7kaJ3J9/ffS1sUCy3F1tuxTpcxkLYtuFC5oVcnYAqq/M
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:11 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0fBJs026547;
	Fri, 29 Aug 2025 20:41:11 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0f9eR018701
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:41:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:41:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:41:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:41:09 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0eqJC004937;
	Fri, 29 Aug 2025 20:40:55 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 02/15] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Fri, 29 Aug 2025 21:40:52 -0300
Message-ID: <e3ed48933d2b2fd0d8e5f3b126bfd6248e3bfdc6.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ttkmjPW7qcttfgyXYED3Zuc_-nEExwnW
X-Proofpoint-ORIG-GUID: hrLtIgTqPLjk2a4uw4cKGg1OGxTr3z2a
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b248a7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=IgjcDGkmi_FApCPpklgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfX7LEgkhvDVG/I
 +PGu0xAUaeSnEG9pVfvAt+RQf+jaY2+R6MRzfFfQTGehzjZ/wpMxFTC97YJ+3Gw1apJjL/fQ+lG
 cGkoKE1z7eHqDd6iNiirLj+cX5zCnxAw2WJn/I/Or7L0JbCJtntCtVThDWsnitFUWv5zuReIe7b
 Bxqed3JS5kPduSsr6/yeS+/HoJVsEC9bYiuNUy58LnmPKGzC8lsSqXmsJoytKVmmkoZyN5etsUk
 IComX+/FDzH1JF+EC7CTXd6pZgWtympbHLMZnGT42/gF9Xsfq3WiqOogohlJtbNzKoT/3BSU8Xg
 yoE1YpxX3hcRSWr06paOA4sq6k0vV5X8rz8oPUTK8a2y6TeUoAkiTBXW4NzJc6vt+8PqMhF7pGI
 sVtX/wVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Not sure if it is worth applying this patch since it doesn't seem to cause any
practical effect to the binding. Though, sending it in case it might be worth it.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..a8fee4062d0e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.39.2


