Return-Path: <linux-iio+bounces-25324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B9BF5E7A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3181983141
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4732D0F9;
	Tue, 21 Oct 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nEuqFpnr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFB320391;
	Tue, 21 Oct 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044057; cv=none; b=i7G4ahENNwUTfG7YSM4Pes6tMPN2Dz17W7YF1B/4hVP/lHVsnbEZ63pGF86NtVaf6q+O6J60NWNmlZi7L0R740eDuE6XITH8Rlyq+DoRPcruAQF5ZHmrA1OlI10VJvXs/SIpuKz05UOuLJQElTt/PFPN2F1YQ6pT+FDn8ysX2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044057; c=relaxed/simple;
	bh=8e0cAypFaTKQyVCfViVuvA2uPf9ZIQuTJwWPf7TsL70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gf2LxUOCFjAzNQkhLbIAIP+x0qxh+Wrbxv3ZV/o556PdLg02vNRNmDl0J1mSepwFRjDt9FqxEUvZyHa7DzRvpGqIHvo263qzhyJej38ftS/vQh+7EdMUV1uL9Ys0LYWoToJUbRvxEmaNE19yYhryNezwKwYMiYWvOGJXnv2nFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nEuqFpnr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7sfAK007370;
	Tue, 21 Oct 2025 06:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EI6U2
	zhrPTBi2mSgafLO+J/8eqFi+MwFwf1YRGsV8LU=; b=nEuqFpnrpfi3pq3HXHJs9
	UPaeneE67lxA9WNjkEoyGGS74RKjhNGu0puXIzjQyA3UP4hIGwBtTBDPjln38Zna
	zo8nUP4fT7X16GlDBG/SDwXBmtKxa6ZcIrU5kwqT0VFphL0eXZW2TOd8mcQvGgea
	U9UvxBXJXeDmz9EnafqXCyVWokrz/avVuDbOPq2kE9rkTQdOmewOiAsU4EykpnKe
	r6ZAFSGI3UjLjAqg4m8yyUleZtPZBnPFIe769YcMFKhFFe1SDZEeVCdpLIkeY7aB
	GBBKaoDjkWSfcbTZ6Y5eFbqO5VIHAbOrKRIQiTezdjuy7gzKAIQmdi1nTEN9ldWe
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49wt9vc7ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsCsu061041
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:12 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Kl002507;
	Tue, 21 Oct 2025 06:54:09 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4086
Date: Tue, 21 Oct 2025 10:53:45 +0000
Message-ID: <20251021105349.21145-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=H5vWAuYi c=1 sm=1 tr=0 ts=68f76655 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=ARsjiwgLgWojctR7zB0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: M3TLM0OJw-K0T2X5_bLLxQZ3yFdCqPGi
X-Proofpoint-ORIG-GUID: M3TLM0OJw-K0T2X5_bLLxQZ3yFdCqPGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MSBTYWx0ZWRfX5Rv8ggEMxfNw
 B5O1rtfRItOOuNZ0ZjR0ghYLNU3V8TijyXdisQCdTM46X+2AeOV5/uH3qrlXrsd1Ht9I2W4DfKh
 Ipv4Iqnr9gqWoqSUyOYVx0/UfrpX4LVlYYhoo7zD+w+XiKk3tJyMTn3eIWVBYQDlk5GQ6bmYwRV
 QfmBE9TIyRRT2X3438pL7+W30ToBpj4kc4LEjqFeehAueoBShHk7VuY2KMiIgmOoLkcwx2yDOjj
 EA13JyAY+aeld+4jgZvyKtyv/Vs8xhFnQfy3c6rVYK8a2JqIBTAqkqSSwOYQKiteTENlHyUS5jY
 brw7K3SAl0CAAVj+GeIbUUaNi9dYnlAlEyn4HKrhcOBc//dgFwuP2UsnQdi+XfP1FuTkn+BDg5g
 OFgcjtD1CADVVFNEzjI5B1RlU0mglA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200151

Add device tree binding support for the AD4086 14-bit SAR ADC.
Add adi,ad4086 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4086 has different resolution (14-bit vs 20-bit) and LVDS CNV clock
count maximum (4 vs 7), requiring different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 9d2b4b8edf42..db136bff45b7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -29,6 +29,7 @@ properties:
       - adi,ad4081
       - adi,ad4083
       - adi,ad4084
+      - adi,ad4086
 
   reg:
     maxItems: 1
-- 
2.43.0


