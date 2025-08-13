Return-Path: <linux-iio+bounces-22638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F2DB23E70
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 04:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F301B62F5D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D726E6F3;
	Wed, 13 Aug 2025 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bxa7omOw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24826CE32;
	Wed, 13 Aug 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053348; cv=none; b=IdIkFlYkMQNwkVlU4zW8C2aYTQqyE7bOtaYfgFvBM/+MS7UaFBFLSepJLvSY8V5N4JcJQU63crUkJBzL2ZHFYGH9pJwkLpxumpd/6758fNGvnycPj5p/7/gZxiP3VKPuShet5GigfyyeYOKAoiROk8mt0rUURoOXBm+EWKhEj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053348; c=relaxed/simple;
	bh=lb1vEA+USRsXEgIUQoGg9hKn7jRrdpSuivQNxULl10I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuNu7gJioJRvCr/sDMncVbPMaVPJnw8TALZyFbY4bIyVBW6YCajgzfpc1CquIgWg1B7cJgbUXJr+KLhCLyAMZlfXc+4K0xMt4+BKkJUOswpa17MdCihKbo8nDiaR58KhyW7rMfAfvjwMJmfYFtU8mZj2wy5C67w5gyQkC38lwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bxa7omOw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D2OM5w027876;
	Tue, 12 Aug 2025 22:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=AiTqgxU56QzKfoEWBkv5QCGUm77
	RFOAFnKf9pwL9ZGQ=; b=bxa7omOwfeyac4iYOLXc3ty0+x7mY5isgO5BD6J6sXN
	J+lD3BGkcNjBzp06qFZwWko/n8Er0xYqKwI8wUDBXwQ+sYPQK+K/c0LFsc0mbJ8h
	YxdCnnI7Nl0/sogixa+uXxVi4e/3T+Cf7y6gSj645mq0zcOS3xwJnIqzPmV2PgaT
	YwcetKDUfg3fGFWUNVXPTQnI4FbhgJGg13jZAKnfpmTwfKK3Vk0AJQSNRh9ZguLN
	2JsjtRmH2N10yuOAx29gqSfrX/hdkcR+8A247kJw3rJiNSaEqBWT7I9fVM1YwCeX
	NPMUunUgCJlYKoqUmdiDrcYX6dFh8Eon1D4sgAJWGpg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48g9q9t9qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 22:48:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57D2mnXJ050803
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Aug 2025 22:48:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:48:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 22:48:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 22:48:48 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57D2mZ7d032749;
	Tue, 12 Aug 2025 22:48:37 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH 0/4] Add support for ADAQ776x-1 ADC Family
Date: Tue, 12 Aug 2025 23:48:32 -0300
Message-ID: <cover.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EOsG00ZC c=1 sm=1 tr=0 ts=689bfd12 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=UDRy0rmbmT11ON5WklsA:9
X-Proofpoint-GUID: wXqBrq2PaIGjsqJO78QIoy9OUIAwilht
X-Proofpoint-ORIG-GUID: wXqBrq2PaIGjsqJO78QIoy9OUIAwilht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX9bdZFwvA6naB
 VuqN7QCi8F6EwFHRIiwmKkq8U7aYkOjG9DkZh5OhvmTDZ0fR/8J6tlAP8oRcdC1VlVSnHJAhm6j
 j81VhAE9dGkodNaOJK57L124WSH6NAxsGdMG14q4GnWwCFirJNQrM1ju0BnklqLh84T+A+FnRjJ
 CRIao2BAKjYHLXd5YW5mmC9WIgu99JpYmonzn5hlKYw2w6YpbvIatbVHaEfy4yIkUnC8l5Z3gkI
 hTknSoh0CJRaJ8rwMizbYM3omjaQPD4B2XQcVMnEu48QrXIxMdZa56pxkSk/R+uHxA55GsxZM9L
 mL97eqcF5f6quYG/5cuzaE7H5L45MH5gPfDNxSMDOdx/yvzGI4W5qcS+iQYEFcgYHCjt4Qsgb28
 ugRqLMad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 

The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.

Jonathan Santos (4):
  dt-bindings: iio: adc: ad7768-1: add new supported parts
  iio: adc: ad7768-1: introduce chip info for future multidevice support
  iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage
  iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  48 ++-
 drivers/iio/adc/ad7768-1.c                    | 389 +++++++++++++++---
 2 files changed, 382 insertions(+), 55 deletions(-)


base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
-- 
2.34.1


