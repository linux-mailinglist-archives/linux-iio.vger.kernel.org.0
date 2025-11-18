Return-Path: <linux-iio+bounces-26299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BFC6B00B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E313334607E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0533C1BA;
	Tue, 18 Nov 2025 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qZefdy1E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42E36C0C4;
	Tue, 18 Nov 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487155; cv=none; b=scYGEYAW9Vdyslt+YK5c6X85IvSti34iU6v63qZYvaeHTGb+ujD0T/07Cv03iF1FkYfYM0OXJ8pb39a9maSQKr0n+Uzr89JngBE4HcG6383UaKQX/hq4Az+PG3kA6TaowO301WHNZEqfKZ/qa0G4QGoMIzWw00jY1if1DVXrNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487155; c=relaxed/simple;
	bh=4TxtwzQOpkqACawstYdzSubBjvfF6qcW4l4G2p0+I7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QahhSjUwdRTykjHvNEAp3eciGjXwxOURkPjkfbO9HuZZweJkA1Mme8IUBhI29nZCkM+pcpLV7S3rrAiQN1uGDBeOg+6d4ajhi89vouX+3JQiV4NFhBtrm4hfEGm0MEjYBg6UhfBbYmebwvSON7k6+rMMFKKLOdkjwu9ZtZpiNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qZefdy1E; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIGbtSj2367615;
	Tue, 18 Nov 2025 12:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=OeHT4N0KiOLfqTgVxVFjv6sMMOJ
	twNhZwUc032ZRPuY=; b=qZefdy1EIizKCo0VdHbIDQaA2jfHWT2fA28O+xtX832
	dUbCePjtjaz7zE/P9aAagUA6rG7InvTz3QMX+0d6glqKwizrCBlvhf/IWTAkguAt
	jJXg1m/jjO9dbUFxlr6325wFA5GspSnBRc6i9WeqkVgypiYgj1tIiXoKb0e5MTEC
	n+/Gc+EGOO2czWDBGxUNxzUGOns22VBP7XeKP2twtfsSZeelYiL2SPvXwHfbQv7n
	J3ByhnVFBDr7BIGHzhmyU9LLP+cyYtptbBF3vxzfUYc9rsMzQw8H2RaKfdAYn0pL
	aBYNFSFGV2y/rMVuhg0sTC2X4afITuGSpFkKpX700Ag==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aggt2kph3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 12:32:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AIHWE1v043197
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Nov 2025 12:32:14 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Nov 2025 12:32:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Nov 2025 12:32:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 18 Nov 2025 12:32:13 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AIHW0k1007663;
	Tue, 18 Nov 2025 12:32:02 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/3] iio: adc: Add AD4134 minimum I/O support
Date: Tue, 18 Nov 2025 14:31:57 -0300
Message-ID: <cover.1763478299.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pe5A4-Dqq-btlEvDcXkLT9clBpKH5aOO
X-Proofpoint-ORIG-GUID: pe5A4-Dqq-btlEvDcXkLT9clBpKH5aOO
X-Authority-Analysis: v=2.4 cv=FsIIPmrq c=1 sm=1 tr=0 ts=691cad9f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=QijszBioZyQ-ZxoCLsEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0MSBTYWx0ZWRfX/PddDrOYiQmQ
 z/zeBKBWUasXHawZ4wbCWtQB7pd/Ne+uCk6tVSD3YYN+a3HrHyRKZgCaWh2GZ84JtnlatQR0iNE
 uVXw/FcESTx+7D1QXXCEALpB43a6QdgVWvDK6Ay0jqcQlbJCmm/gEFzl51aCgE+7ayQa3wCI6kC
 JeskU7D0zrlxT7t5cOALAvuUzfvgYfIpDHWIuO3hjmYiTvy1Ip8+dzBLDB1igmsBlEdWFdR1jT5
 Gyn9iQUejCpoNu54Wgd3iqmpM25Nu0o9eghfgpn/IZWHf2y/WyyJBMT9KFvTeV5GBmAnq5xgrFU
 j5ZN2ggq3WmlA0SHaYh6wgzcqunOrYFaNkNJ1eQaHlLinSzPr5XNE54JPNTC3LUoQdMOe+ApEKX
 s84wyNOo5n4AztiWUv63brxCe54pzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180141

This patch series adds basic support for ad4134. AD4134 is a very flexible
device that can be configured in many different ways. This series aims to
support the simplest way of interfacing with AD4134 which is called minimum I/O
mode in data sheet. This is essentially usual SPI with the addition of an ODR
(Output Data Rate) GPIO which functions as conversion start signal in minimum
I/O mode.

This set provides just one feature:
- Single-shot ADC sample read.

[PATCH 1] Device tree documentation for AD4134.
[PATCH 2] IIO Linux driver for AD4134.
[PATCH 3] Initial IIO documentation.

Change log v1 -> v2:
[Device tree]
- Dropped adi,control-mode property (can be inferred from the parent bus).
[IIO]
- Squashed the driver into a single file. Dropped unneeded code and simplified.
- Used IWYU to review includes (added missing ones, removed the unneeded).
- Reworked external clock setup.
- Dropped channel dynamic scan_types.
- Factored out register read specific code to into own function to make code more clear.
- Added comments to clarify non-intuitive code snippets.
- Added trailing commas where suggested.
- Made use of USEC_PER_SEC and HZ_PER_MHZ.
- Updated according to other suggestions (mostly code style).
[IIO Docs]
- Now using "~~~~~~~~" to mark fourth level topics.

Link to v1: https://lore.kernel.org/linux-iio/cover.1762777931.git.marcelo.schmitt@analog.com/

With best regards,
Marcelo


Marcelo Schmitt (3):
  dt-bindings: iio: adc: Add AD4134
  iio: adc: Initial support for AD4134
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 198 +++++++
 Documentation/iio/ad4134.rst                  |  58 +++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4134.c                      | 493 ++++++++++++++++++
 7 files changed, 771 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
 create mode 100644 Documentation/iio/ad4134.rst
 create mode 100644 drivers/iio/adc/ad4134.c


base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
-- 
2.51.0


