Return-Path: <linux-iio+bounces-15463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16EA32E59
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BC3163A29
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB233262808;
	Wed, 12 Feb 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z16tVBkC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565C260A47;
	Wed, 12 Feb 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384237; cv=none; b=STPG8EBTSEgw+AQnpVl6UO/aRpOEDagPyZebpuaL0aj7Eqdc0CJxknTUW/y0CFJyk0wugZzau9F+QA0BeBuhFxCGeepOI/6EVHZOZOAOJWZeWeg5tpz/EGzCnma1DKfh4mGa27PNYJmxg09TCgXE5QJKtZyDe3Y1TXHBCnOx8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384237; c=relaxed/simple;
	bh=a/5fkw/9B9O10VHmyzZD1LRyjCU4vglXrIMpHZxGZRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUPVm2hl531PTvKxZGQDOVqZPFHfpzqAeZwLEHLuWhn8j6HED16NO7kW6ubJPsjncexHjhfQ5WE/YXD0ioluZgcBB+IGxgHBHf1RJHDY+HdZHM4NmYSOZT+oJ14HfdDZm1qsY98km80jS3xNGNXotBY2cK5G0ykaLOy+BIsoI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z16tVBkC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CGx0WI014280;
	Wed, 12 Feb 2025 13:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tkFxc
	xTE4GZyrj7JwrgQNbVIJRif/t1yLTIf6Z1MtMU=; b=z16tVBkCxDCJkNRLCBV1V
	SWghEkSOEUf03rPXNva6aFvW1aPMUu/iEgEU/SyJwbbZONrQ/o7Aq7nlHyfdIBry
	evBVO0NLyu74wAJ0xTbMONVR5L92jHShBZoDACLZwLlWOqdFG6/x6N29/zz0tsDj
	uvx/NJGeBXkbLLhY8GZCLDvd2FkAcRYa/knW99lGDYFbkKCFaOKIoMxqkvSNyhwt
	X1R1YO36E5aSBJCvTQP1c3V1ymFphALQzgcGhqW0qU13ZhfxxXGde+XgTCThYFoh
	hoVcQpA+BFojQcyaatseqBDx+w8uT8uNilKEPWyBSJDuy5xj794ELkHIKC/NoLVs
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p52a3n7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:17:00 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIGxlq046449
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:59 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:16:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Feb 2025 13:16:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:58 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIGj6F017466;
	Wed, 12 Feb 2025 13:16:47 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 06/17] Documentation: ABI: add wideband filter type to  sysfs-bus-iio
Date: Wed, 12 Feb 2025 15:16:45 -0300
Message-ID: <aea512746712f8f6d07d29ec6977609c127fabe0.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: P_B5qDDXa8H8fZYVR0whn-Ca7N0avieG
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67ace59c cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=3Hb1o_MSCnf1oSB8FUQA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: P_B5qDDXa8H8fZYVR0whn-Ca7N0avieG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

The Wideband Low Ripple filter is used for AD7768-1 Driver.
Document wideband filter option into filter_type_available
attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* None, since we still did not agree on a better name for this filter type.

v2 Changes:
* Removed FIR mentions.
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..9b879e7732cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2291,6 +2291,8 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "wideband" - filter with wideband low ripple passband
+		  and sharp transition band.
 
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
-- 
2.34.1


