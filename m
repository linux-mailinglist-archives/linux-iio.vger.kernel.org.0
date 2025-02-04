Return-Path: <linux-iio+bounces-14978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEEFA2757B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495CB7A4E5E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CA2147F1;
	Tue,  4 Feb 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QKel9wgf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D827213E68;
	Tue,  4 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681309; cv=none; b=mr5+xy4IHDsZdj6/I8LmKJSstDUagwxEGPP/7nMwQehyYbSa9EwMBe2rXPypiKgtran69z3iYvu+/se6+fW6E5v/dG/ax6XPiCjyX6pksXP+2xi+Wv2xhIfpKaB9uftBYTczzwgEOK5E52Fn3LzHcYxZnjSHz8VS8yvEHBWsDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681309; c=relaxed/simple;
	bh=x3yEUC+RmVWJLbZOlLBYK0kokB4Yzn+rQ34l8kZ3Xys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLZZo022wHiGAxrfeS2p+R5Sf4F9Lq+hbgWWrtdvtUctHoxeAMsxMIg+exRqxBzI5xtx0SC5+Qgy5reOqjm5iRA3Pe6Jojg/TBkdAQHqp0Kghjah8byy+PjLiDSKiOahUvLs1Vi4IiZfyqHJVauAuEy0N9O/fw2+n1jgEO+FS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QKel9wgf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DnmAv015368;
	Tue, 4 Feb 2025 10:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/WOhz
	vvjdQo/qdHgPT0VOoUryjJVcFSqB7tg2jGp1JA=; b=QKel9wgfhJI2hDtaV1cds
	60dts1omATG5y8BMn3L3HJQ09GE08hSeGiDLKPlLVGq2yXvOB/DeMP2+QRU6I0YE
	S1DCXgBcTaAw+dr/EmfuHBy97E+sEHeMgBWYREydarUfiUPc38WRQHsZVzqrPnou
	Lp6NlgDzeeciv9z4DonF6aZX1TKQ0SSwdaJgK9+2ozBoWh1kLzJI/Th3ILJTYwp0
	ZF5irNf2GL/ZeysVGkwI8rh7sNH2FQs4SRxs7+oW6b9RByk3iPg1WrQVUutrnepH
	SxKRjUur1TvHDZk/YS+MGjUingYSd3TrNWk1zOOXgHwKLx6x8n80DrirNDaqHLAA
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44km4e8ac0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 10:01:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 514F1Vsi044436
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 10:01:31 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 10:01:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Feb 2025 10:01:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Feb 2025 10:01:31 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 514F1GXc005482;
	Tue, 4 Feb 2025 10:01:18 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 3/3] iio: adc: ad4130: Add filter_type attributes
Date: Tue, 4 Feb 2025 12:01:14 -0300
Message-ID: <61a87b288552cad9e925a9af4eb33022d14a4617.1738680728.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1738680728.git.marcelo.schmitt@analog.com>
References: <cover.1738680728.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: abtoN37_1Jljfze8CgxfB0Yx7fvQu2R9
X-Authority-Analysis: v=2.4 cv=O4XDvA9W c=1 sm=1 tr=0 ts=67a22bcc cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Byu_INIfeIXNPjAbFHIA:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: abtoN37_1Jljfze8CgxfB0Yx7fvQu2R9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=907 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040117

Make filter control also available through filter_type attributes which are
now standardized in main IIO ABI documentation.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..acc241cc0a7a 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -939,9 +939,16 @@ static const struct iio_enum ad4130_filter_mode_enum = {
 };
 
 static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
+	/*
+	 * Intentional duplication of attributes to keep backwards compatibility
+	 * while standardizing over the main IIO ABI for digital filtering.
+	 */
 	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
 	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
 			   &ad4130_filter_mode_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad4130_filter_mode_enum),
 	{ }
 };
 
-- 
2.47.2


