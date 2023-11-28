Return-Path: <linux-iio+bounces-464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D674E7FBE13
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69217B20DE8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1E5E0A8;
	Tue, 28 Nov 2023 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68110E4;
	Tue, 28 Nov 2023 07:23:59 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ASAYFA3006004;
	Tue, 28 Nov 2023 10:23:40 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3unejp8yww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 10:23:39 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3ASFNbX0049267
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Nov 2023 10:23:37 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 28 Nov 2023 10:23:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 28 Nov 2023 10:23:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 28 Nov 2023 10:23:36 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ASFNMDb003945;
	Tue, 28 Nov 2023 10:23:30 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 28 Nov 2023 16:26:08 +0100
Subject: [PATCH v2 1/2] dt-bindings: adi,ad5791: Add support for
 controlling RBUF
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231128-ad5791-michael-stuff-v2-1-541bb1c9dc43@analog.com>
References: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
In-Reply-To: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701185184; l=982;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zD6+twSOON3C1B9Q1jD94rOKIZYQOEtpLb3956omfXU=;
 b=/pirBo/F7G68Jt9umd5IHXv8J+BuvJ/YVQw3MNxmBnKdnkXm5++cegqDVmdSmNe1C8AsWvha/
 0Kfc0WGxg8xBbJeRQd2/tPboFfgY1cdMT+MbEdF3+pGfmXEALfpzNSI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 0FrSIJ5Y_4ZVU1r0MQh88gQUWrAlkQYW
X-Proofpoint-GUID: 0FrSIJ5Y_4ZVU1r0MQh88gQUWrAlkQYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=824 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311280122

From: Michael Hennerich <michael.hennerich@analog.com>

This change adds support for an external amplifier to be connected in a
gain of two configuration.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 3a84739736f6..c81285d84db7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -26,6 +26,11 @@ properties:
   vdd-supply: true
   vss-supply: true
 
+  adi,rbuf-gain2-en:
+    description: Specify to allow an external amplifier to be connected in a
+      gain of two configuration.
+    type: boolean
+
 required:
   - compatible
   - reg

-- 
2.43.0


