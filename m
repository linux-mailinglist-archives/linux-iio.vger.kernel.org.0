Return-Path: <linux-iio+bounces-22352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E1B1CC83
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 21:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118CF722155
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA92BD019;
	Wed,  6 Aug 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tJxP3kCl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259B29B229;
	Wed,  6 Aug 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508484; cv=none; b=ahgWIWWedE8DgvGo6Sgnui3e86Wk2R1srUO4PG1oP30ddrX9+wqblug9ukLx1siOwMycg2k9qZ4LhqbAtCDpvDKu8Za2ZmLUOsyKvLCZ84Dz12p7b2X5zF6nWR5Ojt8KcXFac7m2X/EzPuz9FoPg905SCQSJg+sFmrAk4Y7AHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508484; c=relaxed/simple;
	bh=o1BseyaOeay3bQTmRz21iCAEL1o96ZnplZvKWnfBxSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J79MxCv6HU1Ta2GUcyVycXHx0rDiVZUTNcPaTJrDzkX3Sf2XN+0C6KLGFb0nqfPJx1LC85ZFaVICdnJGbForJ/kyKwfxdGuDdDHiwqiX7yrb3RfPOTKfVEThxJTHqTvhnLtBLwBrsR7VVpTLz8qfkh9sllPROivZWDqiUumZceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tJxP3kCl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576IoGld001237;
	Wed, 6 Aug 2025 15:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YeJzR
	5CoQPHfPZ5eNZEZhg5dyIg+pGrGT16IUOIEFhA=; b=tJxP3kClstUgLni+ITfDx
	8KtpWDm/A4KPhFiMLoJqXc9GccxiV4AM2ScBmQPAzk+DPOjvfG9Gf9yZ+uKZ5OR4
	+XE8lcgftXp435VEQ6lw3eWwqxxOERD3kocLyTYyav8rvSfP9ADTCSRxRbhl57rI
	sGknJjWWYZZ9eYecOjB8HQbz1G/CRRr+3YOIdYTpMwnrX97YqrseTLrcynF2D+Lh
	5sufGN8eefrPVOuPq2ECI+yzX5c9jzzr9/i1C8UK6X2n4n57c6QIVH5h1TSGFUZ+
	85SwFQM/PfuPVBjR9x/1h+kr7ZuyLVTuWAwQjiKd9m9N/zp1n3eSCzpu3E4pbsSR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48bpw2pcf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:27:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 576JRkxr053724
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Aug 2025 15:27:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:27:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 15:27:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 6 Aug 2025 15:27:45 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.132.255.77])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 576JQAa3004911;
	Wed, 6 Aug 2025 15:27:38 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH v2 1/3] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Date: Wed, 6 Aug 2025 22:24:58 +0300
Message-ID: <20250806192502.10120-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZOrXmW7b c=1 sm=1 tr=0 ts=6893acb3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=WSTu20uV4lPDdy4zL6MA:9
X-Proofpoint-GUID: 5sXkWaYKtn7Mw-VA1N1BjCcp7zwwD-i-
X-Proofpoint-ORIG-GUID: 5sXkWaYKtn7Mw-VA1N1BjCcp7zwwD-i-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE2MyBTYWx0ZWRfX5p1jHN/GETfA
 SBwvzf3scb81DuiTrCfvtWzHDqQg7+/22cYDU8qm3APTgwEv7yzWyx3ThRZc35r3VtIWi/chuJn
 Q8w8Ieljc4V1lzybsSPrdtUzrFJmZOIe5YJ11XRaTlRKA406dqRJe2UtJayTcZh3Sl6LPMXYR65
 1y4cdpd0Zw5gw3QHfmqXzDta6uAkqLkIa0yUAZgpji0iA5RtHVKqmJ+g987D5E3ySWM0dvRvuNd
 UGFERb+7CKABYIieBKTYFt6PBG5BOdsjatK7D5IQwjKfIVTEgirnH/2m+g6oDfU38L7NIFjtHYG
 /1Hrgg0kgAp3k9aLDPJKyA4NjFZ+Nxu29K8rfTPlaNxMQzyX//KWQ2YegJDZ9TX0EMqrgBrCRh3
 eszdwxa/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508050163

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


