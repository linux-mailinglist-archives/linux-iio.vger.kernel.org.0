Return-Path: <linux-iio+bounces-23409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4645B3C672
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7269FA02352
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8701CAA92;
	Sat, 30 Aug 2025 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FqcEbIs1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6E16DC28;
	Sat, 30 Aug 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514520; cv=none; b=jFjcubjF0aYLg1oIIT65eQlWWuKqJ2qAqm93xVzBAaznhxUP2pTpluKSbwacyQLU+iRU0C+exS1Y0mBuTSAVyf1dCoRpf8c49dLARz2udukSGoTkkoJo1Bt35Pp3qBAXCI+n7qYz8meSpELJj0M5PFgvJ/Soa75UtyBomqLhK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514520; c=relaxed/simple;
	bh=QGdJODPCkQCmSaEsXd5uIQEp43dw+5ue/xsF7FmmkNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnhgpX1VvnYbwkyZufCQ3aTS0qIOxTau6rA6rC3NfLXFHoKt7fMXIiKZw4pNpLpGatRnLEKvFzeMQ06Hoe/ginrC7zROzyqFxjBeE//wKczMWAAMlqAFfM6M+ANen4n/B9dPgboX8Heh9fTG26ZJ7CvA0ejK7glhQ78EGKXhhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FqcEbIs1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR58Y013287;
	Fri, 29 Aug 2025 20:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ersxf
	1zpReA4h/zyLlMZEhBz8Es77dEsheobynYULiE=; b=FqcEbIs1xW5E5ocsK0xLJ
	sbMP+fJkFZ4qoTEn5/ui+aeQbnaMitEl6MVZHOmva+FePGaLK2EeqmR+rnsBpkFD
	vH4NtjeKK+vq0U/ZyNtnrTu38IPvp/0DKACBfnPr0mEeuSIcCaDVZ9vsVWzeG0XC
	YkE+slAy1rrNb5l9h6kMTNJdmc5sWNqQAQOxcRJJU2UoLVqPLxc41rF7r0XL+DfE
	TXAi9dtoZl3G1ktkGGTNkjhgf6nU0EdI8683BUavL8XxqA0o7QmwW6mgVR4M6I6c
	VUKGv+NMaDzhYOdX/LnZtU94cZ7EIKXW7Jlqn24xHNispzBYDTcMQ5FMcNHd/64k
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:54 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0eEYk025349;
	Fri, 29 Aug 2025 20:41:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966uteg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0fqxp018780
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:41:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:41:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:41:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0fZhe004953;
	Fri, 29 Aug 2025 20:41:38 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 04/15] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Fri, 29 Aug 2025 21:41:35 -0300
Message-ID: <e54962cdc590de1cc36fa2a9abd440378f792112.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cOCMz99ntw55CSnLpnJw82LmZ70KWJPa
X-Proofpoint-ORIG-GUID: iXr2OknTuiaAltmmoKs4xnNGBgGMQFgj
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b248d2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=XCvVP4rNNzSNEyvd0iEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfXxyAcaqaJJd5m
 HoruWvVr4MUAxHNz9OAN4BKudaH6yhzm5axyUsawbT6xhTWfeYWEE4BK8DBzcq0a/PIjGV9/bed
 xY1OxYAw8oEj8l8riLlUUVn1HIyIBhZ7Wfmq+ADY40Lavcftz7sgXapUda60eRlhtE/Thye1b3O
 DS5FNjyJ8Pn6lraQIazfXJB2ZvrOFYFy+enmCf5z2M6P74S0tYIXLIXIK7C9XDlvaeEFk5xae0b
 4MNDDwVneU2OZvLxglzLb2kbLCgpqRW++9fnRxEORdK29e9id3Pnz6l3w/bkqdVdJ5YsFsFi/Zz
 QOWMO4Eg8aS2AT8yNptk1ffHlIe/HQ0lPkPVPgHVF4j61njhvMG6lgf3cqLohCrCK+ehKSmIi8m
 dhMk99dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2


