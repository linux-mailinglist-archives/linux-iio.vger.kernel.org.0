Return-Path: <linux-iio+bounces-24560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D49BA9BC4
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B3C3B7A2C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF230BB9D;
	Mon, 29 Sep 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aLH44r/j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F730276D;
	Mon, 29 Sep 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157976; cv=none; b=tlc1c73QAnsv3KXuGjtkrSyDGyQEB1dgw00jPBLBbvjNpBXxf8SCaZFVPOcLKBzY2dRCb/sYyKY6NryxRLxMSJM/RLfDEuA6kRFHqi1y2U0+HSi/uC1GUYOhEeNzXfd0vtrgXWpCTaRVbVxFotF9ci97Zn8kYK8WLmzjg7I4KCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157976; c=relaxed/simple;
	bh=7BQUkoFty/EjbXxw2alyJ3tjFSPMlKipKlfk1Ru1loE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2N7fERj5gnT6TsLBEVVuL/W32VsnSsQowZZHNq2eybjlnYw4WQPihnEhRpqMRJQ3waSdYHia4J5hQeGSI234sYmnm7waZVGXXJ9bg48xbt9LWRVKGo3ptAmgYz4fbUhbz1TizBxvWEJSG9gTRR0zte7qk0JdUX3peyIqFShCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aLH44r/j; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TE4nX3005920;
	Mon, 29 Sep 2025 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=50IcP
	tFsdc2ZcTF9NxjKAlISFsNQmJxPZw1uVHbeM4A=; b=aLH44r/jwssNpm4DWKSF5
	Ncj9uqa6dBGPzfMD72Dlk887JcSW77Xjuprbfk0kOKQQCPZ6vqRbvnqFdjEaVcsX
	LZblId65Nsd19WoZwSuXegDVAA23PEODu55Bie3i1yTgwMuBSQ3a3Mo4YTJCpkvF
	azOqqVVVp0WW/8+x6mBs0A4dawXIHfsrWatEIDh5/I6fVIc9iDFhkZ4Cy90orr3w
	w5aK5hEbHNreRrOFikGsBMPKMyRjb0/gZ788Ykr0y105PXqq4dmKrdcSypeSqr4j
	tVjlFCfNxkzjxQwNz9h6fcfKMMEKRny3Z2UksHiU9RJ2/lxvBBAcfCim8ZqoawCW
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49ex8bxust-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 10:59:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58TExP39013583
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Sep 2025 10:59:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Sep 2025 10:59:25 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58TExDG8023559;
	Mon, 29 Sep 2025 10:59:19 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/5] dt-bindings: iio: adc: adi,ad4080: add support for AD4084
Date: Mon, 29 Sep 2025 14:59:06 +0000
Message-ID: <20250929145909.111243-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929145909.111243-1-antoniu.miclaus@analog.com>
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fF2px-c0v23uJpZzjPGGQlXkpdFINctP
X-Authority-Analysis: v=2.4 cv=YKmSCBGx c=1 sm=1 tr=0 ts=68da9ece cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=-OOHvr9byHFeJT6_1coA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: fF2px-c0v23uJpZzjPGGQlXkpdFINctP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDA0MyBTYWx0ZWRfX31ntv5I5etMj
 QyMm5tyiQck67JwAtr/h2oL7BTNqrb1j1hXUWYGVQttsdAcXscYPcsS1iN7WAmAhmfgUpgHMimr
 P1fYnzG+cUvJ1BYeJKSSOVWvWHQeeyVVuEiqJFgJPr9acnl698oAhUZc9JRQKWtr5QAnLDPxque
 uapn0SsTWcGoLZeDA8kjp5v6T1Vd328TzOXixyftRaPaz0XoUAs48brfV9fbzLbmlEe/rHvHUI7
 bPWgqpP+pNCZn/1Rr+3NvXR5ZBCWFeHLsZ+blWRm/sy0eLzSDcoRnf0ndrqQHPP12mkiq10cs2l
 FZFw7/OKEbYcBp2XFKieeKCOwWnD0iOQIf3673VQ7DEgAKxI/oJGp64YPE98QpPlntOH3u4qECF
 tO0CNPtj5E5vG2cwcX5PujgsjEqZdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509280043

Add device tree binding support for the AD4084 16-bit SAR ADC.
Add adi,ad4084 to the compatible enum.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ed849ba1b77b..c4c5d208f502 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     enum:
       - adi,ad4080
+      - adi,ad4084
 
   reg:
     maxItems: 1
-- 
2.43.0


