Return-Path: <linux-iio+bounces-17176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCFA6BD95
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 15:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3C117D07E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE51D6DDC;
	Fri, 21 Mar 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iKLYPtHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A361A256B;
	Fri, 21 Mar 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568644; cv=none; b=meR94geuJ/B9Sq0xXUgL8ebWW4UvH12KAefSZtEuVMKrtsYTCF4ZfKHMIiXJNclHo8xm38JvgS4oJfXR7Z6MhFBgkA9M1H0JUjlnRK5wDsQfQp9k46P2/2rklcXYzdrxisEPJJJ0SkuiDG9ZL3AmOjHD1Qz8YqvWxnnaFBfhKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568644; c=relaxed/simple;
	bh=v2fEPprUmlLi5ZXK91jOH1UEXEoOcSoV1sH4ey9jHPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G4QlFHybZ0lTht5/WWVuMo75bVoMUc/x0IQmreKjfTStZsRCyZT95QWLGAYkzji41yfYsfzsh/wkPGTfwzVShCUsb5rDSyAIHP5M31/w2oy2DEvE5v4RR4G+4I8XOFbBEzt7qzBfvRIEsZZHstG+yJd7BWXzeFylqDmHF3mPgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iKLYPtHC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LBNWLm009064;
	Fri, 21 Mar 2025 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1OaGQ
	tIHv9lWsDgibfphTJHgPDnF5OptSPsYbBYyLTs=; b=iKLYPtHCnNMAc4tTKieDD
	1QH4Sqq9yqHAIRSNTFE9tWx+QPE12BVV9tBW7qaV3TqUAe9q6xImUKFzUHOyH7xA
	HE5jvhLpxzW7PSav3biVzHJlTEEp3E1Z9n+ygebwf0UPhWaJfXSx7py3lotV8ESw
	/XQYYH5C8xKUktfg+LaQTxh5wAs11NlMtspFv2XuKrrPUz0TD6s0uilC+k03lBBR
	NsKGDMXuq8TqEHjEEI5Xt/IKVZ2UdOCaaxMkNKE08ghhVEY79JKypBJSQKxbnHQL
	KDgCG8icxO3cvU5b9X37RiQEGmwJ+zTWccXovSRZvETo1eqPAvoyUmaCoprFMKNj
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45h76sgvva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:50:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52LEoENA051976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Mar 2025 10:50:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 21 Mar
 2025 10:50:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:50:13 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.52] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52LEo1cb011710;
	Fri, 21 Mar 2025 10:50:08 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Fri, 21 Mar 2025 15:50:01 +0100
Subject: [PATCH 1/2] Documentation: ABI: add events sampling frequency in
 sysfs-bus-iio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-abi-oversampling-events-frequency-v1-1-794c1ab2f079@analog.com>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
In-Reply-To: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <dlechner@baylibre.com>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742568601; l=1153;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=v2fEPprUmlLi5ZXK91jOH1UEXEoOcSoV1sH4ey9jHPM=;
 b=QmIwPX4TgWCFCXy/impgJVHISGv1fbfw7KzVeCnqE+1f9EVj5qFN1H3Z5m+M4tFd+fJ+caEku
 uCcZaHI5tFRAPlpLkvB+Tkb7sxUcke9bs+zExrj8jUvsGn6ggqmxbaK
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 6J_iFgxtverHX4VSNXO2o7tdda7WY0n9
X-Authority-Analysis: v=2.4 cv=BpidwZX5 c=1 sm=1 tr=0 ts=67dd7ca7 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=AXpCqiKjodP-triP0f0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6J_iFgxtverHX4VSNXO2o7tdda7WY0n9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210108

Some devices have an internal clock used by the events to space the
conversions.
The max1363 introduced the option in
commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
and ad799x in
commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
hysteresis")

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 722aa989baac43f694076074b307d134867b4533..33c09c4ac60a4feec82308461643134f5ba84b66 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -94,6 +94,7 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/events/sampling_frequency
 What:		/sys/bus/iio/devices/triggerX/sampling_frequency
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org

-- 
2.48.1


