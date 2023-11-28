Return-Path: <linux-iio+bounces-462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340287FBE11
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 16:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BA1B215DC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2D5D4AB;
	Tue, 28 Nov 2023 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F480D64;
	Tue, 28 Nov 2023 07:23:57 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ASAX3FJ014074;
	Tue, 28 Nov 2023 10:23:37 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ukeq73ue3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 10:23:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3ASFNZ0E049261
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Nov 2023 10:23:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 28 Nov
 2023 10:23:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 28 Nov 2023 10:23:34 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ASFNMDa003945;
	Tue, 28 Nov 2023 10:23:25 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 0/2] iio: dac: ad5791: Add support for controlling RBUF
 via devicetree
Date: Tue, 28 Nov 2023 16:26:07 +0100
Message-ID: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI8GZmUC/x2MSQqAMAwAvyI5G7DRtuhXxIPYVANutCqC+HeLx
 2GYeSByEI7QZA8EviTKtiagPINh6teRUVxioIJKpchi77StFS6SNM8Yj9N71Ma4QRsqK2chpXt
 gL/e/bbv3/QD1P2IBZgAAAA==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701185184; l=590;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WWqmeH8LuG5AGqaMDpjoNlNr8UExQhh5w1wnJ8553cU=;
 b=SOcx3a2dDjH8GVYJ4oDkg5tTM69oUOPtb+C6Uu66AL2a4QoBVIA1jYHNFUvNbqYT2vfs1VDPo
 eeAvzY6oEDUBSjpEBCKWSgViNrREnS2c/mz4+QHbZeDlaioDEhg4XkZ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Knh4wgad3j6LfD25yLSDNq29BD-m9bd0
X-Proofpoint-GUID: Knh4wgad3j6LfD25yLSDNq29BD-m9bd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=343 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311280122

Simple series to add support for an external amplifier to be connected
in again of two configuration.

v2:
 * removed .yaml suffix from commit title;
 * Don't use commit/patch in commit message.

---
Michael Hennerich (2):
      dt-bindings: adi,ad5791: Add support for controlling RBUF
      iio: dac: ad5791: Add support for controlling RBUF via devicetree

 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 drivers/iio/dac/ad5791.c                                  | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

Thanks!
- Nuno Sá


