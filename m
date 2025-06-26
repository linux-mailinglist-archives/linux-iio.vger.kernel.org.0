Return-Path: <linux-iio+bounces-20971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDAAE9BD9
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 12:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7098F3BAF2E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAC270ED2;
	Thu, 26 Jun 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b2Vw1DZB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6B25B2E8;
	Thu, 26 Jun 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934993; cv=none; b=e0ETD26JmPAmfSyaZmiENiLRU1FsvEs81T4XckDZV0D3qlrChWTypBGQjPyqbrynNRPXCQ10yLppKz1G5t0XtEvtBmCvx17gm6QPOVHJsysYbY2PkV/MA9fdGt/Yg3TlIliqgXAguqzF9rT8zWgqJDaiJ++BzWDW9BcN7CdVPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934993; c=relaxed/simple;
	bh=kYqY3ltFAk7XmlICA8MnZqcWspwPD7e9MENExTqOgIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQUBjvorUmOjlGfcHWbDqswdyVsZ6KW/XLWkVdmSI6LhuelX6MS37DqjZJshCsYDspwdmxxRkjseNVDXou/g8bWSQZ3yRnWR2xyKuj8MJuKdhkmjTTv8VhgJjKECCZM5OBTNURHQ8wq2WcF9/LHq1JIFahKS4f6mmU4gCgmTD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b2Vw1DZB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8h3C3016775;
	Thu, 26 Jun 2025 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+Aq7skARuQhh51B4mkRgzuSzgEb
	qBtwQONWz935ZXnQ=; b=b2Vw1DZBFN01GknLr3OGeqMmlzit8ZMJaITR2T0Me+W
	V1u8lmVKPVEk5Oa7CXqB6i+Wz7Sisq0RVEWSGYFCq+jtlyeFFGtouGpp0VUH2U1P
	1jKudDGO1jOWfUP2vHF12yOr6qPLA2B/12Scir4SAxir0EQCvHJm7e0RdA1dndYr
	wk7phLCf7yXeTdA1haBHPUCDVlTUikPIQ7FkvGL3uG5npwoMi7V7zIIyZXF8ZboZ
	0/fK84hlg79FVhKkWTfepz8Y5LatEydag7rtxLgTpelrgKRG0cej/fqxkLvfcrO2
	4eVcZim/bDKNYFSzZWuvs77BN2h0m3vR9U7pXCgjdug==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47h2xcgkfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:49:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55QAnmUd047054
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Jun 2025 06:49:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Jun
 2025 06:49:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Jun 2025 06:49:48 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.167])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55QAnclu000419;
	Thu, 26 Jun 2025 06:49:40 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad4851: add spi-3wire
Date: Thu, 26 Jun 2025 13:40:23 +0300
Message-ID: <20250626104024.8645-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OZP6VjL2_jMNtBGTpMHVnvJBNWLmgZYL
X-Proofpoint-GUID: OZP6VjL2_jMNtBGTpMHVnvJBNWLmgZYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5MCBTYWx0ZWRfX49Iz5Ngss7G3
 omQ+KF7O/JVkEHAhm6IOj8mdev+8rz9D+2KnZIF7e+Q/tsiaUnQ+il3ZUepDVIYph5EVMUWvTnO
 8PTcy7v0oaQQRm5XgT50mnBTtCNamqA9tWiTlzJ7FA+yk1BP+icMAJWWnzPzy/HyF9DGCQV4P7o
 hUaVgL/TBeOqqTID3h2D8S8p7X7P0hmJO0KfSLZ4LyCm0r4+PBIzmrWOAZCzjtkbE78lcXKXvBI
 0/KFEGDM7ms6GAuLQ3wcPZicV6SUN4jSL14OeaGA3YhWs7fbeHyiReUnCQsL955GH18MA0sfxMa
 5eLaMFc1AkBuAxq4hrALDZAdHEbTLjzyK5eRuX/8IPbE+3I39FpgjFSLRz2aUctre4nD6VEvVIX
 igqwjDtjqCoLSeXqhR7ElzYwUrsqEKkMCvL8ah4Zry8tShnE6fUrrrIaMXBsoW8GRXn5WDF8
X-Authority-Analysis: v=2.4 cv=OoRPyz/t c=1 sm=1 tr=0 ts=685d25cd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=S76Hmel1X9esiIvpTsQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=987 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260090

Add devicetree support for spi 3-wire configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
index c6676d91b4e6..b107322e0ea3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
@@ -69,6 +69,8 @@ properties:
   spi-max-frequency:
     maximum: 25000000
 
+  spi-3wire: true
+
   '#address-cells':
     const: 1
 
-- 
2.49.0


