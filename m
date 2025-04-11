Return-Path: <linux-iio+bounces-17933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3EA85D4A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE64A1BA7838
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDED2BEC3A;
	Fri, 11 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0gQW1pgU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7629C347;
	Fri, 11 Apr 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375011; cv=none; b=F9tfKha/LuVehkHGwtkteqzs547oBVZmxjJHKI8lKZzm0HZCH0+z17A4SnfRA7YBCuBn5Z3CPadGoNSBnv8juB/MYyTSdmZFnuLL1dJ4obKUnJKrCvI/DH0eS6jNsf1UG7oLrvjwF8FeHkdZ8M6XkaUXbIMWt02Rio9MnjTDhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375011; c=relaxed/simple;
	bh=EVH4UH5xxCld4CxlBWedFGnId3S38+y4izXmfgHyAUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+u8ZpPOa7Yql63czFK9Q686gGZ7T2VGsOrpiI3qQw6CebVzUOGMVrzC9cg4JZ2OOOObrfKTluXtD0Z7YemaQMkmrQHGOqRhvUxgU8r9Uv6Ex+rW8nAPzty+qvu0I/3yA72dfnOhoP5aI4HZsYTjcjxcUTy5l4aK89/KWtLAsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0gQW1pgU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BADvZw001758;
	Fri, 11 Apr 2025 08:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZJhRw
	D1QHXCoqmunuK5TfV+kaHist6m/90nePE2hRt4=; b=0gQW1pgUrrIAuENXuwvuM
	kJWj45ilqWo9S5PM60YXrR3JrZagz2GAlAHTIQWgD4jn6p03jyY95fJA02G7mrGw
	Fy0qB8Whw6auWilCaOdKrYK4t1mzeKsM7EUTYhnurn5n0BrWi7PV6oBo7xffdz8d
	ylxL8bTeOGlmqhP3izissRUBayttO9O3g7XQmWJTDwjv1lgC6V7RDyrRlZWCyxHm
	AjTJvRoeILltR25SepoAr4stu52PKeO1ZRYBmpiTz/slKOWN80P4SU3UXrw89ImJ
	yq93L6FGiMyuUi1x2MuMvLe1oW8UoLgYsIFdr5sQLIqkqRxBeVepJRwpDJ8vtga5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp0brm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCak3A005164
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:46 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:46 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPQ006015;
	Fri, 11 Apr 2025 08:36:40 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 06/13] dt-bindings: iio: adc: add ad408x axi variant
Date: Fri, 11 Apr 2025 15:36:20 +0300
Message-ID: <20250411123627.6114-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: advAuETKdH40IzrEWP26OGTX3dIqthT0
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f90cdf cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=q2Ulk47HLb923_f0sX4A:9 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: advAuETKdH40IzrEWP26OGTX3dIqthT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add a new compatible and related bindings for the fpga-based
AD408x AXI IP core, a variant of the generic AXI ADC IP.

The AXI AD408x IP is a very similar HDL (fpga) variant of the
generic AXI ADC IP, intended to control ad408x familiy.

Although there are some particularities added for extended
control of the ad408x devices such as the filter configuration,
data capture synchronization procedure and number of lanes enabled.

Wildcard naming is used to match the naming of the published
firmware.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - improve commit description.
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index cf74f84d6103..e91e421a3d6b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -27,6 +27,7 @@ description: |
       the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
   https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
   http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
@@ -34,6 +35,7 @@ properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad408x
       - adi,axi-ad7606x
       - adi,axi-ad485x
 
-- 
2.49.0


