Return-Path: <linux-iio+bounces-26221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8037C5D1D0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EABB735D7E1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43A22F772;
	Fri, 14 Nov 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bzQtLuJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2917A305;
	Fri, 14 Nov 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122917; cv=none; b=j06SsTXh9DGGtBYy9zfjv9Fd09HjhjnGxDbif+7vjHYjjS5NQKUBH22HozaqCj9B+YG3aScRhL0vVTPem6YjeWT3P5emZam0raFSVJ3xbcquhOdfx1Cu9WmhhDqFFCXs+Zp71NHOKS+FGZT9uJGIczNk4IJOwJw69AS/goe25bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122917; c=relaxed/simple;
	bh=ZJfTysD1AInk3W4VMRR9yEsCe8X31yY3XoTCWXVARTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ch4BAKLW3fyTJFH1/dOirUnK+9ZQAvNcWR0V2+BRghZPC54ybtkmCsUk/TaR81Yue0sO+Q030GBAkwe0Du8tUnZoTkNSAt8/OtuoXJvaEYFiXYN94zyRcvQOQNKvw44+6wUZ1CEhH5K/Kd4RBgX8+jIAlAyXFCyggBaYmM3ubQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bzQtLuJ0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8penB3654753;
	Fri, 14 Nov 2025 07:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=LuU2sVKUX/c5ku4iRMv1s5eComd
	YLCvDIbwKUDl/gYk=; b=bzQtLuJ0fFK1HOiw2ov5lb9zhoNIYPaIkqarLlE88zX
	3/C+iEZ9KW8KQPkvFzOyj3syBOOZ4swuiMB4IPUitSfe86l2RYdwNGlCOrBS+H6m
	BqDzt6zgfTrZbi4IhG8i5xHjyIzHkm/0LRBwVOjl2NMHPqmlobqxNqPTmAviIC02
	hjaTUvIEgR37bf+rOFsoB17JgYzWwRhoshSDn7Cd0uaB2X/AHz4Hh4w6v4XzBEtY
	2gnxWm11EEHdfXhT3iwJI/RsXQXBQfKnCTGkRnFf8oDeYncsJTBkwKIDYkNWGS0n
	YAUgzZ3WUZIADgNSqBclsipGFn6ZmdwziPObYpzPH4A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4adwaw1y7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 07:21:52 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AECLpmG018470
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 07:21:51 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 07:21:51 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 07:21:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 07:21:51 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AECLgLo019987;
	Fri, 14 Nov 2025 07:21:45 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: frequency: adf4377: add clock provider support
Date: Fri, 14 Nov 2025 11:59:21 +0000
Message-ID: <20251114115923.6043-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5OCBTYWx0ZWRfX7FPwAq8XdWJ+
 Ktqt2KwGREY+iHbpOYXKuJCn+Dd/rBhCzJBkTa2ivPIyBmGQpStFrBuvHfy5wErdNnsJOtKZ+um
 gK09u1l3MZgPfdPoWDV9qtrCxsOg5v77/K3zHhRYhssJBS21J4R0wVvMermNQtI/nyYOpLNXpYA
 mMA3HSLEnKbje0RiVwU2BKGdMSGJ8+9RNaGM8UxHWLumW/7N9fDIgYZ4WBChAMLnE8eMgIAy6LY
 bA7BfkpLeoDrCFdl9Paf/SZUbVaOyhgjAQKgAkx5OZ+kWe/SJ1x+JJAHhLg0PsmxcTizRmxVuaZ
 adlE8T078cf/bOuS6+Hpb609/MxRwImUA3bf/S25ccGG1SwC8TLQYuV/Ko/MPjOXFmy8KCvKPdy
 s+YA8zvo6oPsBU5+1aUgG4BwiLa9yA==
X-Proofpoint-ORIG-GUID: C7Yefb3yBVlLwO0XDUv9ywbKAoGCy3tM
X-Authority-Analysis: v=2.4 cv=M91A6iws c=1 sm=1 tr=0 ts=69171ee0 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xhyw43Vw4g2VkAmxKawA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: C7Yefb3yBVlLwO0XDUv9ywbKAoGCy3tM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140098

This series adds clock provider functionality to the ADF4377 frequency
synthesizer driver to address user requests for controlling output
frequencies from userspace.

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

Antoniu Miclaus (2):
  dt-bindings: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |  20 +++
 drivers/iio/frequency/adf4377.c               | 131 +++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

-- 
2.43.0


