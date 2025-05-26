Return-Path: <linux-iio+bounces-19920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155FAAC3B97
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A191895B16
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFA1E5B72;
	Mon, 26 May 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zfi/Nceo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900841E32DB;
	Mon, 26 May 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247781; cv=none; b=SfwOnP6KUpPjo5/3MVtGkEcswmnqn7VhbUbUk/c6rSriFWDWKT2HKA2TPg14fLk8R9po4cvvJL9IWsFwCS6AHUlbka5twADSdIdjlcKOHD5N94wvUZ5V1UcUbb0telj4U0iawZ08b5Gl7qVE53Zm4xjmLqf+18PyPEXaLxy/iA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247781; c=relaxed/simple;
	bh=2KWGZqpL6ham/Q0N5PUCqGJYyzBKQe9H13tYc978hyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKzAWcMLNlucvutxrCWPitD0nuzX1g5S3BX2iGyUPnhhlDGPnL5M6jLdNORHzkP3VEwxWC8UBn+qbEAo5tQ/NUSNJuFRhOMx+gFHLZSL75FAzPcjCuUcBrAtyHBKJQj1j34Sl29uEPCer40TcMKTAxT5bLkAnOQnA/VCgpQwwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zfi/Nceo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q6Fhis021644;
	Mon, 26 May 2025 04:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ej5T3
	MjH+ZxmpbsNfOcLqm7MXXx2F089tYefr5/DKVQ=; b=Zfi/NceoNjBSH5vv5N6qo
	R9sTI2OHtO9mJxhgMqJrJV2eAMXSgI8+/k/bulp5/OrUxQAfb35GBsBL68NgFsEY
	E2IQMPK92XZBYk5Tr0x+hAcTtPgTUarlgxX2XIC1f1iI7ae6GZTdB0qdPpGgahkf
	HlM7z2FtcFwJ0GmV9JnUQU+5FLwWuFGrhSidhd92vVqx/wlUBrYtD6eIzRikJJnr
	ZMgYgNwpjU1f8HEbzdRD5Pam/Oz1Qg5SW0Q0vxqb66Bgsp1BbgUcUi3GBgHhMsCU
	BmHffsCYNNJp5qMdhDn1z/BQNjgSHXFjgcZwFQb0l8bPNHAbpRhZ9pLOoRbLoxty
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ub16f9c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 04:22:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54Q8MoNd026835
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 May 2025 04:22:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 26 May
 2025 04:22:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 26 May 2025 04:22:50 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54Q8MdJB015981;
	Mon, 26 May 2025 04:22:44 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v2 2/2] iio: adc: ad4080: extend check for data lanes num
Date: Mon, 26 May 2025 11:22:28 +0300
Message-ID: <20250526082228.4961-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526082228.4961-1-antoniu.miclaus@analog.com>
References: <20250526082228.4961-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: o-3eo_LfeivqUsmU0lF_ukr4VJgK9x39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA3MCBTYWx0ZWRfXyv43VdLBuR5a
 J2xShgxvdzkapG+KlIjXdGWzZ14ZE9O0bHMPwnmliUJ3ShSrR0DJYOWmbm6fGkHhvDZbktllYDQ
 rAPNaCrxWR6xEIkEamQ2UyhyyhtMAryVpFC7yqizY3IL9nwUR9AL25g8MPJOG+YEEtfKV+3f4l1
 9ZxeLJlI/xxHrcrbg3xp+OTEUtEARgy2vCxrtfHr7tAYAfZy5EaMHiUQh9VcAQTMUo/5ZHGSSqX
 ehbQ9fR/AI9JkuIySY2sIEWn3YxerQrC6ZmHRvvzGbU9+ryk0QvfSTUC6GxQ5p1VWXbhOTMwNZq
 yN1ogq2j0cUkjr8T8/3FTZq2/7igJGS1hghuQT98jaWDL2C8Xdsdbnv5izjFzUVVOF8BB28uIW6
 HCgssVXbmW7mgki6HiXNKIzMLvN9gwEKThJnYAdCtUbSwGONRfo6pzMuFWsAtZaHvcVW/qpk
X-Authority-Analysis: v=2.4 cv=XemJzJ55 c=1 sm=1 tr=0 ts=683424db cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=GGKVI5b-SMvUNDNwoSIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o-3eo_LfeivqUsmU0lF_ukr4VJgK9x39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260070

Extend the check for st->num_lanes to ensure it is not greater
than 2, preventing invalid configurations.

The AD4080 only supports up to 2 data lanes.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/ad4080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index c36eb41d738a..6e61787ed321 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -516,7 +516,7 @@ static int ad4080_properties_parse(struct ad4080_state *st)
 
 	st->num_lanes = 1;
 	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
-	if (!st->num_lanes)
+	if (!st->num_lanes || st->num_lanes > 2)
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid 'adi,num-lanes' value: %u",
 				     st->num_lanes);
-- 
2.49.0


