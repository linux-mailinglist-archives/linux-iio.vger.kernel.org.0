Return-Path: <linux-iio+bounces-26362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EFC786D2
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2527D321AF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9702FBDEE;
	Fri, 21 Nov 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dM408fRa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8681E7660;
	Fri, 21 Nov 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719208; cv=none; b=kaWacYmDpyfh0eytQJzX9KcwJyM8x7RfpfpaBKLlbVPkOCoc1zrCRq0bu802P5RK2lhJ+aieLkl/jO5CebZiLjZQ2hJx6CG+s3glGAZ3emrCSkW/uDCRxCX/47jCwKcP8/MEcORjgBKe/kTPwbKlFM/heRyI4Tqy1MWglXbRN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719208; c=relaxed/simple;
	bh=6KOe791Pr7u5RjMaY4a+gNAFfIO7m/bpz/Pv+qr+iqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFuHZP7TFW/feJhfxCRScvjFCh8jMoRNCTCEGrwuVXeTzDbaJInQHMX4OHEFQd7DfPD88V0S4z+acUumjYCTFFEfXm8QcdcPXsOJ7xH9ohj6eV4oJXmPYZSqWI6Z80xF/AzowvSiCyPxnasBia09Bacbdb+2Y42Ydww92bcKDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dM408fRa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6KKKT2556779;
	Fri, 21 Nov 2025 05:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mO/c6
	l5pWlyvoLTdTf4hMg476+YS0Jlvvfr0SQtK1U8=; b=dM408fRaX38o2W3Ict9sw
	gARg07IDzQh9/tGtCt1R23etR6ef5uEhyR9KaRUGcpYWOIwM8MYh5nttrAW8F27w
	p/mCC9PU0HDqVmUWuzh+qvp7lnA3O0c9ZJ5V42f00dSobGKkziMis/QhAXWWNfQj
	fjcmdYGCQpNv+R+olr77NWRkqMNrDMXPnQxW8onmSgSQe+dIv/B20Tbs4RbYy7t1
	/9AGM1vopBm8vMdWQSPgVSSIRukWXVTiiPvfee9s+V781/t5RKm30Lx/uvLPUN5P
	lNWbdFHhhIkhmpNYuNEzgAgQec6aAEdMRWmNOnHm62J0efWBWP10XIxYqm/kkSWR
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ajjqjrwdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:00:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5ALA02jR015313
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 05:00:02 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 05:00:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 05:00:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 05:00:01 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9xo95027151;
	Fri, 21 Nov 2025 04:59:56 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [RESEND PATCH v2 1/2] dt-bindings: iio: frequency: adf4377: add clk provider
Date: Fri, 21 Nov 2025 09:59:32 +0000
Message-ID: <20251121095933.19032-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121095933.19032-1-antoniu.miclaus@analog.com>
References: <20251121095933.19032-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: InhV_e7LMIFaXYYROY7K3VSJq2nTbK0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX0pguFbaWetKS
 BjYV7kWOWmdt6YmseuxtRnQBDO+ACuZQ5tvTeZTATdY85AbJeM6Yf7O6S8RBLy72xHjH+NnZU9q
 xohN+6guFLw07aQrq/RjwV3qWjoyWefb9pRoGQEJ99888vhycV/vKLckXihwLdfrcwWoJVpHBqM
 2tOtZCtcVqsX2wAZF5eFCKmwEuNoIG3h/Dypi5Z4a8gYqIMyQFTCumQgkBtIxfNHe0VSxYsMzhJ
 XGEVPiV9OvUjvD0GZDW1r5UWIg8BfVgVPomjmKy/9Z+9NCw1EyHyOGyZ+MInJtjeHpXpwNoLDHg
 8eFqOwGzWM/FL9drqmBtBRJSTlQ9gRAwwDYoO++/E86EFA4ZZjkgyvSVP16MWoLLZ+AZVJGhgu9
 yGtFZEZX52B+tTgQpToWvmd6H9tE+Q==
X-Proofpoint-ORIG-GUID: InhV_e7LMIFaXYYROY7K3VSJq2nTbK0u
X-Authority-Analysis: v=2.4 cv=ffygCkQF c=1 sm=1 tr=0 ts=69203823 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=WZGvS3g7MfmD9D08EBQA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076

Add support for clock provider.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - fix commit title
 - drop _clk suffix for clock names
 - drop additional example and update the existing one
 .../devicetree/bindings/iio/frequency/adi,adf4377.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index 5f950ee9aec7..be69b9c68e74 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -40,6 +40,12 @@ properties:
     items:
       - const: ref_in
 
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   chip-enable-gpios:
     description:
       GPIO that controls the Chip Enable Pin.
@@ -97,6 +103,8 @@ examples:
             spi-max-frequency = <10000000>;
             clocks = <&adf4377_ref_in>;
             clock-names = "ref_in";
+            #clock-cells = <0>;
+            clock-output-names = "adf4377";
         };
     };
 ...
-- 
2.43.0


