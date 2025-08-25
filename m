Return-Path: <linux-iio+bounces-23292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE94B35784
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD27E1B637F4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A392FCBFF;
	Tue, 26 Aug 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Q4SigNy/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE32212548;
	Tue, 26 Aug 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197954; cv=none; b=QVxCsaD327ruz7Ztembkv9qFDUAUYKP4VpTBG1n4YH+5V7dg03XBJJzulf+GQzeCFE5giy1u0KnZjnjqUnHQ5yGbawxH08Eg8hR/UUsznm0RYL+uwMZe9cK7d5TKUfVDqkcrSn4BdTsguh8sJFuzo6/BNLly1yYhYr8bPdRl96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197954; c=relaxed/simple;
	bh=TD89X0XSjg7k0QGKQPoq2VsThxIIYv0XOLJfdqFpjZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o72PLOT37bKf/Mzt3K8vevMsLrTaRDaTRK1+s1r5oQrTIMMOK0fYFNAYwZjfRl6XMlt2j3Qk3lzw0uPz1//L+1ekNNBp8zncafulDaQ5A+sWaB+qHgXJ+5vSC9GC9L8EBN5gdALgdH8c9v8okoNgGjZK1X/aElsZBH0Lb0DHIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Q4SigNy/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q7l9TJ004529;
	Tue, 26 Aug 2025 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MzUvG
	LYTmRg2z2Io5tx/gBqSJ/SjgAZb0Xw0DR1uJ+Q=; b=Q4SigNy/0T7LolsUFOvtZ
	laUbgsx6M6shJZuye30ww1DMD51InnBTJbBBAcrUz7jOAz6Pvwka+vbmBulIjNgu
	58P/kajL910NrWStNeWI6l7QRkZ0+0Xz+u5BTHKZoWkfGgWVEFUe+mUNMGidCO4p
	sY0Rm1mh1114NkgF1fn1FaQw3MyNXUD4+ZvMGqbfKwOb4SeUtESrYPGephbp7wj6
	rFE4MmzrXzjj36QpvCG8c50szQJ7WjS/HRj653/niV5Uq0w7JYoM8dS2h8A+WAv4
	piCCMzjRcbJjGG+hSu34pqCdiztLkNQUj9XZ71D7nkvKLd7VZjPpM8rjsAlkHphZ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rvqyuerr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 04:45:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57Q8jaGr018635
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Aug 2025 04:45:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 Aug
 2025 04:45:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 04:45:36 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57Q8jHnv015527;
	Tue, 26 Aug 2025 04:45:27 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v6 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Date: Tue, 26 Aug 2025 01:13:49 +0300
Message-ID: <20250825221355.6214-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE2MiBTYWx0ZWRfXyavcIeZqHy4B
 PSp3U81MRn11SOB1gDZVwJELzOzFxgtfdahGgbrF5lZhu8dk/DjeqcXZ5uwNAk9/m55GYmydvZk
 GvF+Lppgs+gEf5F2WZ4E7YapNm9v48EbHwdSYI0pU0nxZCbm0Vh85q7/IIuL2//N2iGjimkj168
 6fIKXHAKUgAEF0B/obQZgp51gqjX/LElz0CRBsy4Oo10oMfhrhH6ws977mOD+tCY2nj+DRJtOLH
 5XJMNLNh9gPx/GycqGDk0xF3Tw7lmf1sCG+eTEIq3l+F8HZ1DAdUE+F6DlIDsa3fR+4RnoHhT5n
 uHxD1jFhD8vqKcDNe9JCHXl6LLqZ6Js2xhuHDJIBxFFgehJIpThGg8ePRHUbYN/FKTmxGW9ZmIJ
 bW7fU+hg
X-Proofpoint-GUID: rzfwdsEs0UduwYzM7ThpQ93sDcagpVOi
X-Authority-Analysis: v=2.4 cv=K70iHzWI c=1 sm=1 tr=0 ts=68ad7431 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=xxAboOJnZG-Uw5iDWu0A:9
X-Proofpoint-ORIG-GUID: rzfwdsEs0UduwYzM7ThpQ93sDcagpVOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250162

Assign num_lanes_set in the adi_axi_adc_ops to axi_adc_num_lanes_set()
to support setting number of lanes used by AXI ADC. This operation is
included in the generic structure because the number of lanes is a
configurable parameter of the generic AXI ADC IP core, not specific to
a device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
no changes in v6.
 drivers/iio/adc/adi-axi-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2d86bb0e08a7..20bb59c24acf 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -617,6 +617,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.47.2


