Return-Path: <linux-iio+bounces-23410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172EB3C67F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39A11C87F5A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6E1C7005;
	Sat, 30 Aug 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HQibXgzE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C926281;
	Sat, 30 Aug 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514544; cv=none; b=hAnOt0QLcAW3sEabexzNbmC3KQosPiGTTGjpQ1J75MoKqjFVRY+SssQMKXw36eoB0pxcLh6lcfsRKoWK+7cnAAvi9zPm4HvjY4uYZ9YIk4aOu8Sf0fQdElPwWbAGern/7tTbAQ8ifVdJfRdRC5vDpuf6OKGdiMRvFbXkWPqPE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514544; c=relaxed/simple;
	bh=jONGGLK4c+2/D+4wyE/WZ5Ltwa6081fW0iLPgr9bqd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Do7l+BZD5LoEes0xEuYIiOopIIYTVhIQYBNiy+JZc0yuuA61gSHjhrJ7FTqkNj4PtTddHF7As8o9EnH/N5w/XZWka1tssyi9+ex6bQrkioTnLplJMEUgsETQBBYFbVTke95J0NkFcOcVrEkW9lbeDY3JkVM1BiTLVCZjAcXvahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HQibXgzE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR8Vg021598;
	Fri, 29 Aug 2025 20:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7tDkR
	PZLBl4pzFgIRv9gz/XjbbPg1M8u7gMqebfbmtk=; b=HQibXgzEZvzNUZhxIkU09
	vTHZY4ZrYGgUJqN8eOBcZ+sOcpdcrs8GwUySlnDzV5L/AmURXFTBSS+Fhz55iJHp
	ay4orBNZvniSCLGgR2SPV1vXZh+Gf48ZggsYr3b+d5Q1/8j6WWyBzP/PLITSZHaW
	tSFoEVO+zuud0a4nMC4Z+XMnfoVhNjRDSZtOdjANMYC1adhUWF3RittXoEZYIleY
	JnocK9tQ72vJioXeozbwnDek4+J28oQ3X2hK8unmAQ8rD6AysO3ka6qS0p/VmYg0
	QsGcG0cLq8yHZgf3CN/B24p381L49fcG2kT7iHuACytAG5kw8dIeeTtl5QE1uIEJ
	w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:42:18 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0dHn4031062;
	Fri, 29 Aug 2025 20:42:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:42:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0gHNu018809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:42:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:42:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:42:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:42:17 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0g0LQ004963;
	Fri, 29 Aug 2025 20:42:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: Axel Haslam <ahaslam@baylibre.com>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 05/15] spi: offload: types: add offset parameter
Date: Fri, 29 Aug 2025 21:42:00 -0300
Message-ID: <28920aaf9de9438b0c8897b990914fa7724c2e1a.1756511030.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX9MUAnEeUH8kN
 Q9kWS0wUSvAwvsOJjHJMPLjciTtzfrvEGy1asUKTXcY1B6fMNm5FllAhVZ2j0JDMGh0tGT5sRDF
 8y3/uUTMsRyJah//41rUvTWl1lXVFYkEyUm3c1dNnw+twYMXohqQ/QOM+6NM47591Ef3e7GNaGr
 WeUQOpOcH6MG2VV1S9NDRbN6IeBFvIUGJX8Ba4rsWI1rp5X90sBuBmcNukLb6RiEwADFfPKgndm
 GTwuuWJYRQJ+oKi0RLJoRmq6GzMMzJoOcTjRHW+kcL7Dj4560n1NOjqMkSKDg2ok1MxEGV0WbbU
 OzyDbMZgmYLPwTO4OTsNI13XXeXdUj2t7r/HyBq24kskXRD02VwMwRksRJtMUeXY7czYWxlJkQX
 SihEwovh
X-Proofpoint-ORIG-GUID: SRnhgGAvPp99K2NWkicPbjItXpqxh8Mv
X-Proofpoint-GUID: 5Wul6UKEx10otBJBD5KuIDDV_7cONpIV
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b248ea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=9ldudtiKjGZ9N8G2jv0A:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

From: Axel Haslam <ahaslam@baylibre.com>

Add an offset parameter that can be passed in the periodic trigger.
This is useful for example when adc drivers implement a separate periodic
signal to trigger conversion and need offload to read the result with
some delay.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 include/linux/spi/offload/types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index 6f7892347871..0170fd1f42e5 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -59,6 +59,7 @@ enum spi_offload_trigger_type {
 
 struct spi_offload_trigger_periodic {
 	u64 frequency_hz;
+	u64 offset_ns;
 };
 
 struct spi_offload_trigger_config {
-- 
2.39.2


