Return-Path: <linux-iio+bounces-26792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF9CA80DD
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E869030C4002
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E732826E;
	Fri,  5 Dec 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DF+VEZxe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00522126C;
	Fri,  5 Dec 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945591; cv=none; b=PiLPwf3vA4xx8Z/fQ2h9c+3xIOVVSikR31iKQaeMjnbaA8V7hsHC4Gr2DkJJe9GX2G1/ge9ZUxff0gSMbJPWewQDGwJMr/bdXDeGaPupr3cr/7Katg4X/Jv2RrOOs2vB1kF2mEKMIEVI0GdMSrFH1P9nSLBdqhUnJpsJfINqokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945591; c=relaxed/simple;
	bh=ZrBJ0wPo7+z3OsOMDGgUzxfulqqDb3C3BpE7Fiwm1W8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dia9Heup0kdUy8yq2VZ+g22TReuzfuNI9QpTksc/JwDuOgnN+R0MaLHTL+R+rWAGieHi0B3yp5c/RPwfCll/n8sLZo+8pEY5Q6ZZ1kYtOZyPhtnVhFWShwTemybaV3FaYKGgg5f6hMhdc5PfKbVzPE5XJVLkDPuGTrQoFwMPZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DF+VEZxe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Ds6cd172680;
	Fri, 5 Dec 2025 09:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wfDxH
	7uteaLVWtt8KyOxpcWetzHH4L+rDNLwZsVR7mE=; b=DF+VEZxezt0WXJNPsxWfs
	vPg9osl3E7kyKGdenSkYlC22pc/Cxl2z+swSnFJp1v7QdzkKr202KgBC7AkqyCJ1
	4hTQWtnLEYWrIT0xblDR3W0yqLLQZN4O84fF1dd8z3JCln/AbZPkom8fb8YJwfuG
	EVUmA/xqRbVIOTvUG2gDPy9ER73I4MZCj7eahX6poVVmBe/onGxu6ZZonhiwgbKe
	Uq3l1fkcS9GUhE4v0fqfDxiVp9zITx/cFXs+/zQK5kGlp2NW2tkRs/MInCXapoUm
	dHSIBYq5KkhxQ+dQ2j3ogkb/dcHDsDD4j/I5rqAvroKqmw+wcbRHfyK2gQd3XOKS
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscg1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:39:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5EdKOR029278
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:39:20 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:39:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 5 Dec 2025 09:39:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:39:20 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5Ed1ps027828;
	Fri, 5 Dec 2025 09:39:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: frequency: adf4377: add clk provider
Date: Fri, 5 Dec 2025 16:38:45 +0200
Message-ID: <20251205143848.989-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143848.989-1-antoniu.miclaus@analog.com>
References: <20251205143848.989-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932ee99 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=A8WMtek4AFwDiOTggn8A:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: 9wF_-_wrcnZBrdY75n-HGDbdrhsZfsOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNSBTYWx0ZWRfXx5j8DmWRdz5A
 83N0IPYPFN7EnLnK8MvyR0nrkOe/iXPOqBCtUJO9V7mXkJtZuYr9cO8dJh7DZM4Ihonnub5mPRC
 zhuGlHaIHquUfRSSU3jByMdv/bcQeO2PnLJin3ICl/KGX+huLsDHunL3zZfm4n9Fz/CCM3xo5bb
 CPB0RP9bRzlumCZewju5G4fzQhRlXhlssiOLSt2ofuGHAHOg7q/z4JtExi2Xp4f9FsonWzKNZvq
 LTb7JIAU0YvCRSkxb6c4tn5Ufl6TicwSE9UB/zjjot8yX1L/SstpVQpS94xKsxBtEVAgLD3tJJR
 gxGwY2QL+zmk1DIa64G0mM0L4KQTeQEK+3mHVKLP2JJTwC2KcO9E9hdGqBN3MwjhgolDkl2AtJS
 BdluDAQk9rNdcyZMgRq30O1h/qaQUA==
X-Proofpoint-ORIG-GUID: 9wF_-_wrcnZBrdY75n-HGDbdrhsZfsOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050105

Add support for clock provider.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
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


