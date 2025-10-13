Return-Path: <linux-iio+bounces-25023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A427BBD1CB8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8673C0073
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E92EA74C;
	Mon, 13 Oct 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CSdaALHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20622EA476;
	Mon, 13 Oct 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340563; cv=none; b=VgnsYzpqrhiCJtC8V/nbzHHFQ+Ql5p/NfBiqZFpr1+btNCe6I93YYJN0ZY1muyOr+62/gn1DjkClCSfk/ZY9yKznUUaPcBXN4yz0YHPqNXPk8YQv1o7hOlMb+i09LQNl6ogD8qMnHesdwbZfAKCBYvtoBeLT4iktkPSqJQyKMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340563; c=relaxed/simple;
	bh=Lu/G9PzkIDILtxQZMU8flwf13WzcLALptfGmNJmAcw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gysbPVbOs3ao4ghKsvhUMLyZWbqKz9YvUEUIgLq10fX4Doh3JzeIsPnOgPCvlhHUXUNFCePDYKtoiH53AwDXokgv7j+EadFk8fSvW+peuwTiZ9Dgyo0fpVkR2WLPBUoHDksWgPFUd1DM2PO9Cuekkx4t8nw8UJX+nQ1pHCnETK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CSdaALHG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6qVYg008744;
	Mon, 13 Oct 2025 03:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F1da8
	CvN/e0YaeaHYmO+uZpPdsDegNvUPiXDxmw+K4M=; b=CSdaALHGRmBF9demd4FqN
	RbQGUPSTnqatPWPrqi01ySOjUDb9j6MRdNwro6srQD98wW096kmWVnBBsxQF/iky
	/NKKjK2ARvl4cZK6Ubb85ZHrLwZaC+JbwI1HCRiAj5EOb8KBy9O1dVSq5tIxzfxv
	fuAjKqUfodAb5WZxDCJRMvbAmd+UOnq0VUrTckt2I1tl1VLIrWMJ0OMYryKUryWW
	4IgwvoVQc85q3ssV9mX7mZs8i/J6Y/dfi/1U1rLSvrg4WKr4ktADPMOSOMBNTMoT
	vvEgDs3GccL1hSVShYW0MuPuQiLnZZ6BjILIfRFRYWGGD1dXh4c1LqlzcAzkiZtb
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49r5jc52ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:29:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59D7T5Z0022888
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:29:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Oct
 2025 03:29:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:29:05 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZA013800;
	Mon, 13 Oct 2025 03:28:57 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:28:02 +0200
Subject: [PATCH 4/7] docs: iio: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-4-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=1321;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=Lu/G9PzkIDILtxQZMU8flwf13WzcLALptfGmNJmAcw0=;
 b=o0T9DIYgGR17qI/VlvZy2F6P1Ns/wwoQkZl6WlMaXvtroo53kAq7T2DYDpooD0tTdoigU+VqS
 oeDq+LR8fNmB8UVRQPvXxiO9AUuAUzKnlPV53lMfUihzTiCMbZbX/ey
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=OdqVzxTY c=1 sm=1 tr=0 ts=68ecaa42 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=pTCSo2s0eJJONGnsYSsA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3N-Hv5EpMoW5u6_UVSRIs53qweybBSFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDAyNSBTYWx0ZWRfX8/wxEpaKqUoR
 AME3hThc2+0X5TWqPbv92VO/a+ZF7EALlRnh+D3tWdV1WOUj5SxhxobsyNJOvXawSJNy6cRkOmv
 f9NoqQImHq4FiKOXdqPuX/KPtdZlGgvnZ64avrOLdPWblFLTYEvAZ+o1Ua289QBzAbmTK0AP0Ed
 iA5wLQGBLF29+Q3UOBf4W6wYC5B5Xkl1F70urtyDhajKlkviC88eI1G9fuk6WyPGv7/vwTlhtAd
 HBUyklsrPBznPptc2qVpmtWnA4DVh6m1DHPbdm9jCCYGcK8PWGKIxLOg+6RolGEFnDAUK05pTir
 tkdGE31i7wvF7I3Jt8ZnvQ38WiOOPGjLcpYMumIG5LvrI9lMkmZcvBxCP3vjg/h9JEldzzf8ZzZ
 Rlg/wzPu94RqKbtHr/q32Sq86HDC6Q==
X-Proofpoint-GUID: 3N-Hv5EpMoW5u6_UVSRIs53qweybBSFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120025

Explains the IIO Trigger support and timings involved.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index b486d7fe1916d2963c94581be3696cf58d51ca48..3770740a1a9b1419cd97882a988578e514407f59 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -81,6 +81,19 @@ The device enters low-power mode on idle to save power. Enabling an event puts
 the device out of the low-power since the ADC autonomously samples to assert
 the event condition.
 
+IIO trigger support
+===================
+
+An IIO trigger ``ad4062-devX`` is registered by the driver to be used by the
+same device, to capture samples to a software buffer. It is required to attach
+the trigger to the device by setting the ``current_trigger`` before enabling
+and reading the buffer.
+
+The acquisition is sequential and bounded by the protocol timings, software
+latency and internal timings, the sample rate is not configurable. The burst
+averaging mode does impact the effective sample rate, since it increases the
+internal timing to output a single sample.
+
 Unimplemented features
 ======================
 

-- 
2.49.0


