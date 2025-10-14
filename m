Return-Path: <linux-iio+bounces-25074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE705BDB9FD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7F5424A4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC530DD28;
	Tue, 14 Oct 2025 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lMCYgR9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210830DD08;
	Tue, 14 Oct 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480521; cv=none; b=VKaBQ2/ajue/46A987Oy0QT8R4orxFk7mCiJE1Vux3V+dUNgApvf9snPWpm2UWjoZl+Z6+yZsW3YjEvKonpggfu3n7j4OVlq9HFUyfU88vg1hI0HOFjZSfMXtqHwOQ0bhE8YX8EMVOzQ0jXuDKYU1esrih4js3onnFt7wsSoqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480521; c=relaxed/simple;
	bh=mMvQO9gUvkU4ydX38HzUe1NFpnjpQb6EoaNFMHqTHoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxUtn9w9OZKrHXHJkuiyIPWpogfBdN5Nm53C3/4m8MvM/gOOcSNzkTgx/r+qGyzPoPShpvUU9iGoMffsk/vyDwkTT742F0S0N97r4yM1Tjd4sABgCPutCdGM5OItW/4O7g1ALS/MRElzfAS8YBDV7mzUxtpb5aUvLdbh4lhLMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lMCYgR9a; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EHdVTu008527;
	Tue, 14 Oct 2025 18:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Xf3P
	4FaNtw7plQ3RNniLL6fpn0T247BbYMIn6GhM7Y=; b=lMCYgR9az/UpbKE0JXhGY
	FQT2ZPZwdWUA17yrKMrL0iw+jDAD8DHH3BoRcREC7kpe0Y8J+0ppCUmf6XzSXX8G
	zl5FE8PQP9y++A7E8UzZudyvUEgj92igaQc7jAkwSbNHPJBi3G8V7EIIglQMQGLG
	hXgI/CXyiNLr8cZ1nGNBTxgtGziYZ1FWBSV2GTLz9lFdeQiTwkUuWjUgYo5+pJus
	XD4m6PF3KjEtLdwTvs46EUHncbJTyJtE67tkZzW6kYIVG9l7gcThtuS7MlM3DdV8
	3iG1lnz9SLLbmejBWEnMXAyU+8BeMEZ97YFTK+hm09TFUX9XM5GERPCw/0OPj2D6
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm50kr8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:21:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EMLs5U042786
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:21:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 14 Oct
 2025 18:21:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:21:54 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EMLfwS005505;
	Tue, 14 Oct 2025 18:21:43 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 3/7] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Tue, 14 Oct 2025 19:21:41 -0300
Message-ID: <579f64e3b6b052301390d38d38dd63a6e8997d35.1760479760.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68eecd04 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8
 a=gAnH3GRIAAAA:8 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfXx2akCeQ8kYsl
 g7FZHxDqYVqVock1yberJGnaLgXLhUob5LEBvLL8PoaNMpHnswXtT4ytme/9I5UaMa/uPMjoXrd
 A/n7cqsKRB+upw1DAoggnGRHuc7rEC2gntd6v6rmkyRNrvMsSvBPSwyBRRyrzArjJJVCMpxdC0Z
 mkqNNX9fqjNxWHgzK8Aqu6Zayybud/czFQ6aC+OKwca0il1r1NyJQbqftZmEosNMgGMZZ64/VgY
 KenTY/Yij0ntwukOz/YgpjKXHZimmZL2uOJ069EaV/9qICxDI5EDOtskhRTF0X68EuHdk1jqBi5
 OMu4wLl+07EVKwbI/j2UzHDzwoDTB+1Nf84AKZGdLbxne8rg3SWs2NAJeECCJaJ8TgOottRfrI9
 iGDhnxrw4lFw9mo2yz8iqRLp2Pp7XA==
X-Proofpoint-GUID: cKrvSClObqxxpWFfaoVQTjvh88L2QvEN
X-Proofpoint-ORIG-GUID: cKrvSClObqxxpWFfaoVQTjvh88L2QvEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2


