Return-Path: <linux-iio+bounces-21812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3644BB0C2D0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6944F17EC35
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778329B229;
	Mon, 21 Jul 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xY/NXQ8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66158298CD1;
	Mon, 21 Jul 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097121; cv=none; b=eKNm1fDTwXLDSIonb0eYsUNQePUthuoA6tBqoyvzFD1Lg4LjWUogNmsou09tcvV070e5yBwktmiGhSU7kiNNnbseX3B53IDR4Q09AlGVsSPYmw3WkMyMkxRQlbJVOf/E6WAzXh6i3ICmtPgZmd3lFn/jEIpABtXUSoNi5HtbPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097121; c=relaxed/simple;
	bh=rE7KaXeQsoa91tgee/8RSoVcvOVVZa0/uFS4IQjHUGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfrCjYG4AZ+Nf8whlKfp3dgsWQo7UyqgGBEQtD6zuUDzr6ZGy+BOJd5sIlE5Q449Q81hACgESRhMklcSV3njHOm3uDgQfswJhTX680DCsiwxdYaMlJfrapNpbqV9+w+OhkQIwWhsdcqS3bNEnHnr+u8a/Iu9+tdAoe3JonB+Xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xY/NXQ8B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L7pSpZ029805;
	Mon, 21 Jul 2025 07:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/Nvgd
	Io4a88rYIC7m8RBtmVKRCOGXVhA8EpINqkGv+k=; b=xY/NXQ8Bxe2LO8d2+C+sf
	vAmAyoZWluJAGNQ78h+FC7uYSNCowQQn0jeYY4ooiZlGovvbSzbHCfnBXx0108DB
	oCgihEK6m6DwL5aotY/7rnPtCf7silXIe6V6i9Ntk8PSpe/UWq9a+QzBKUcgpq4m
	KzbvsV57gwEzPRDgVuuXdQqaNyCR19vXJCmKNtUI/AvV+ysF6KGcuhPUpifSwRWV
	3zJXp03hElvufh7s/4s5H4bnhJ+XMO1Eh3BOQgPHas8i2oiNkt/r0+XtfLwsYjXH
	Ry5DdhQb+IfCJcMK29tpnfPcsoR8zmg/G7/jNQPtx4RGMNeYtlNeENqqGKX8Y0LZ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 481e8a1vtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:25:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56LBPABv033306
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Jul 2025 07:25:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 21 Jul
 2025 07:25:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 21 Jul 2025 07:25:10 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.210])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56LBOxBl007027;
	Mon, 21 Jul 2025 07:25:07 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 4/5] Documentation: ABI: iio: add sinc4+iir and dsp types
Date: Mon, 21 Jul 2025 14:24:44 +0300
Message-ID: <20250721112455.23948-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250721112455.23948-1-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uIUwXrR-5XVpKcDazNCEPghajCMWRXga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMSBTYWx0ZWRfX4JLK7jypDWjX
 Z4Sxidh2c0JAu87eg4hBsWlZR21YQtLMEmMQlbnm0enK+Svkt42itDQ7YJurzierR8oVtOutstY
 uTTTQ9g93K8JVtmI7X86dzDUgj3CvGWgz8QDCsNJkn9QnRzJ7S7ciKGFhxZDuNxd6Szas/yGHDz
 8Dc8QNJOxke13daRleHNMP0J7nya+D/SpCaPy1cU7DuNLr+hVTogYeCNPdVNiT4Oc+kxsajs7uL
 AprKpyeFhJ/7BqGY1gLpi1BudnJTA1zKnGbAUhmbwQze+w90CQWxAqWL5bar2E4OTVCyYuWK+Ac
 iVbr83uzXqtGRff+Oudks36BOX735DuD1zuapurVs0U9g3XMtHtCteLolrR4A8Niz3oCV76HmRp
 5kL0F6w2TswY74uWGVZ3ezPDkxVB8XYdgYu/ayJFIoZqTWlM1fb9FGMGcs2uAjhxTeAh9to6
X-Authority-Analysis: v=2.4 cv=OdGYDgTY c=1 sm=1 tr=0 ts=687e2397 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=i-JxiN5MGkLG-e7FBO8A:9
X-Proofpoint-ORIG-GUID: uIUwXrR-5XVpKcDazNCEPghajCMWRXga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=809 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210101

Add two new filter types to the sysfs-bus-iio ABI documentation:
- "sinc4+iir" for Sinc4 + IIR Low Pass Filter
- "dsp" for Digital Signal Processor filtering

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 new in v2.
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0948611227a8..9f51aff4c3e8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2337,6 +2337,8 @@ Description:
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
+		* "sinc4+iir" - Sinc4 + IIR Low Pass Filter.
+		* "dsp" - Digital Signal Processor filtering.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
-- 
2.49.0


