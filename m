Return-Path: <linux-iio+bounces-26128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A6C46AD5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3394EA7D8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1C30C630;
	Mon, 10 Nov 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sQljEy8t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E91EB5F8;
	Mon, 10 Nov 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778728; cv=none; b=nt05WUbipPqH9j5oLd508gxwv/7V3E9AbLUXikJDK819WWMG17wmPRjrvWNvfNKgBhD3EENmVO9O7woyJevDz0apSURFIAqoe2AwcVQQr+C5pAMh044m0KOAd5OPA3ZkK+Tpk6l9o2jXMPyZriMjBHUsgr6sfHBvE7g5j/SIHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778728; c=relaxed/simple;
	bh=Be8eWH7kAmZCDiqclX7Z89eBm6Xv0vwz5QlxnZyn4Y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcWWmilPJg+K6bBjTe802Nnaa9/vpVGPO9gKpBxG39dD/Ebn9WqjJiRWUFA/AuJZh+ZE6zzsUvFPMIl/+3YCPjfU5Tu76HuFMW5fJDIWeAfE2thLgmF2GLysAXz3AHbXd4g19ll8lCs8jhsOklKa3l+l3rbA0X/q7ckKUOAVUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sQljEy8t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACULPB541718;
	Mon, 10 Nov 2025 07:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DUXv/seOfvBqmkgBJgm5XPEFE7h
	Erp2O8t6Lie9T/1U=; b=sQljEy8tEkd5OIL8MuhEq1AnnMcmrHtXA9Y6R0zd3ID
	762sBrLB/jZES2fdBSMr3crPTeWtHItZlJ0n8x8EALK7GQUVuIMiAwmWt/CPY6Ss
	kCPmUoS/dj0JvDJz2ERcualiCkUoTg9Uam5bDitjFvcmfNli0pQjay8UbtwdV25P
	iIiJWoL1N9/tkXkC6RkgCbUS8ZGTJ6TNqroTDmp7woPNOTpWhZwRaiLixVwny6tL
	cx5efFp+hQkwAiE4/WsAqhdbgl3fa5WgK2NPgrVyiAn1z+GR9B9B1u2TymRawDf1
	j/Ek9kca8uJ4FqbC7HZc/d6Be9OJsloMozekrLdumLw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4abcqf10b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 07:45:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AACjEqp063908
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Nov 2025 07:45:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 10 Nov
 2025 07:45:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 10 Nov 2025 07:45:14 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AACiwql000554;
	Mon, 10 Nov 2025 07:45:01 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 0/3] iio: adc: Add AD4134 minimum I/O support
Date: Mon, 10 Nov 2025 09:44:56 -0300
Message-ID: <cover.1762777931.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=GYsaXAXL c=1 sm=1 tr=0 ts=6911de5c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=G6nQ_-BVpwckD8A4HGQA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX5c8Ii97m3wKA
 LIYelOn4dbIxr6XfQr2hliJNfy7UI7hSUzA8V7wnVLXsr16TdA1h8u6ZcKKpZwRzXGJBAZ7jrMW
 bKxmW4IIR0ig37xl302mNHtC6MAKc+gEJdKkiirma/G1iqAnCEcTCQajCydXPReOupTWPFZ1r+u
 xaPBn/g3UjQ12Fj+AaEKk8LBJCeQYYTFm0VfSMIz/xCVmDfRiIwerNoikG00X7V3F2+ciRuLZ97
 sNbjGrlhp6HOmUp43atRRt68yfa0nBsWSkNsPLIl0/v5HocmRMlqDEIlJnNLtudGhl7aiIfSBhk
 IOFN53fD0naiGlVdrxJKsxP347PB2xHIpZ4tnTFlFOumebLz83xfM0iU4jrXhvy9et+KAbEPqAU
 oWk/BshORTR6WHofNziJy4bwtJwYdA==
X-Proofpoint-ORIG-GUID: 0QVOH0jE9Q9y-utp9wEB3jQnjIwO-YOQ
X-Proofpoint-GUID: 0QVOH0jE9Q9y-utp9wEB3jQnjIwO-YOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100111

This patch series adds basic support for ad4134. AD4134 is a very flexible
device that can be configured in many different ways. This series aims to
support the simplest way of interfacing with AD4134 which is called minimum I/O
mode in data sheet. This is essentially usual SPI with the addition of an ODR
(Output Data Rate) GPIO which functions as conversion start signal in minimum
I/O mode. The CS pin may be connected to a host controller CS pin or grounded.

This set provides just one feature:
- Single-shot ADC sample read.

[PATCH 1] Device tree documentation for AD4134.
[PATCH 2] IIO Linux driver for AD4134.
[PATCH 3] Initial IIO documentation.

There is a driver by Cosmin on ADI Linux tree that supports AD4134 in wiring
configurations suited for high speed data transfers. Even though the minimum I/O
support was initialy based on that high speed transfer driver, the result ended
up becoming entirely different. Also, because the different wiring
configurations are likely going to use different resources and software
interfaces, the code for AD4134 support was split into ad4134-spi.c,
ad4134-common.h, and ad4134-common.c.

With best regards,
Marcelo

Marcelo Schmitt (3):
  dt-bindings: iio: adc: Add AD4134
  iio: adc: Initial support for AD4134
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 209 +++++++++++++
 Documentation/iio/ad4134.rst                  |  58 ++++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  15 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ad4134-common.c               | 200 ++++++++++++
 drivers/iio/adc/ad4134-common.h               | 132 ++++++++
 drivers/iio/adc/ad4134-spi.c                  | 287 ++++++++++++++++++
 9 files changed, 913 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
 create mode 100644 Documentation/iio/ad4134.rst
 create mode 100644 drivers/iio/adc/ad4134-common.c
 create mode 100644 drivers/iio/adc/ad4134-common.h
 create mode 100644 drivers/iio/adc/ad4134-spi.c


base-commit: c5411c8b9ed1caf53604bb1a5be3f487988efc98
-- 
2.51.0


