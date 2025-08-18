Return-Path: <linux-iio+bounces-22918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD63B2A464
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BBB3B5DEF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B723203A9;
	Mon, 18 Aug 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uN4HcgJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AB31E103;
	Mon, 18 Aug 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522823; cv=none; b=IW/TLK4KZESDvDo12Cpi+sw8BrDvOhq199W4d8nnmj6d1qTC8Aqf3YmnbJaB7jd4Ns5dElBxeviVMtN25DX3iGs308fxIVakgmIijYtzNa8+o8x7jd+o7lhqTY6XipNnTuv/LaHmhS11ro8fMN92fIxRNxHMDbBlQZBzpu0Mywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522823; c=relaxed/simple;
	bh=o1BseyaOeay3bQTmRz21iCAEL1o96ZnplZvKWnfBxSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLg0A1dumthTjzG8UMwtHDnw6zt8I4Zq67hklryHrBVBfAVAVWnFL7gEPn7tDPlglilF4P4YolIxZHIJz5mUdzBfGDSNg3lQlm+GPJq/ZkeYi+6DMnFIdCW12jVaJKmmvpd6/sQfMoE5FS60ibbAoOTqaT1kgcqyVaPqg6SPhd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uN4HcgJ4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBn7hH023182;
	Mon, 18 Aug 2025 09:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YeJzR
	5CoQPHfPZ5eNZEZhg5dyIg+pGrGT16IUOIEFhA=; b=uN4HcgJ4AgrawMH4utrBI
	OxTSDRmrfcmxKJSxpKZ7cPzDZh2NNEzEh2HGE3SdxzolQlSwsS0F+Rg9cGL8iHgy
	vYo5qJmi+0xSrABOoVujvNQNC5U6ghyta7iQ56SJnxl7934zg0p6qJwG13mztfa4
	w5CKCMvjnYOAYMfDDbvVq50RU9wy3MvGy8jO4OtVG/hx6xVyzHpnw6WuCDNFxl8t
	d62ve9FwMIhAiWT3BXgaRlt5rF9wkZK9Pv+BOvZqplCCJD3lt17+jcl0nDJgtXZc
	YharH/VwWcgeG63iwsvYYlgqHQzFjMn16a8lI0JeAP9E40VFwMPsoa2AhmO3REvG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48k8afe7jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 09:13:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57IDDQ4p044080
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 09:13:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 09:13:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 09:13:25 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IDD8Om008451;
	Mon, 18 Aug 2025 09:13:21 -0400
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
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v3 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Date: Mon, 18 Aug 2025 16:12:47 +0300
Message-ID: <20250818131253.8854-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDA0NiBTYWx0ZWRfX1ssp/r2U0ukk
 vK+nKjHRvhdbKvzEn5N2EqX1ORYltYbZaMIk2DS/t0b0lFETFoEe5+tyMDl7CZkBnMuDJqFQ+FJ
 ruBKRa0odSb6vwSmujFc3LYtXy2NXKn37wF1wQm4CAGZdHhixBGD6smKLtvvKVX7Z4ZyF6YEmOE
 IBedoIb74N85Rq5aGwwTw0S0Z/w1Hj6t0gLPmr4rSNskoLfOwy7VeZGiBfPLJ+9QZbtEZ7+Utq9
 t8aWTV9YXEccmp58sVnhWtStj24h1CzBnUAO54bzf2JigTOUvmxcfAe3rGyFVsCxU8E2I9p+yWy
 yBRX7deVVHCH4ItUdMTWT/yo9HsbCZ4sFy5BmGh0vkhI0J4H6/NXlxZP9swOJSo6jL4oNU+/M8N
 jydlzsyp
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=68a326f7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=WSTu20uV4lPDdy4zL6MA:9
X-Proofpoint-GUID: WEy1nq_wD2f0xcyoo-5VF1fi0RjdmMNw
X-Proofpoint-ORIG-GUID: WEy1nq_wD2f0xcyoo-5VF1fi0RjdmMNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508170046

Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
setting number of lanes used by AXI ADC.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
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


