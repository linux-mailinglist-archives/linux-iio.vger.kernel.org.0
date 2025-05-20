Return-Path: <linux-iio+bounces-19731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD6ABD5BA
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CCF3A5B9A
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F51EB5DA;
	Tue, 20 May 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yyp7Qf7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9E26E14C;
	Tue, 20 May 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738884; cv=none; b=JDUVGj4FlI0bwhACy8K6DRMEMAK6I8HDcJ5f9gH6ypdEndEs/92rWp1TvT1eLkb2MvY79oe3jMybxmSMNrs9Rdh1JQ2v/Ka3/4YuX52cdT9EH8I4IdTIhLnfdFPQssfH6b83+/lbLLIzzzjTvNemWKdYnGgV3En/uC5n7Hr8fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738884; c=relaxed/simple;
	bh=kCbKrG8Eeh1owZzo3b3PcNEdiSssrgABzVn44fnRm+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMQnGFCyE8HasL2abw9bYIngOiCcdXDw8TkT1/hwiNl1s1tQDllLVss4Ds6J4WSRRrxWh09m2mPXwRj9jbBoyF52UE8LPIYp1O0QCeamEN5HzHfYutcn5TWbIyL+vRPfnQ3IEOffQa38cvhYssvicDkIITopQHl+2951Cr6h+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yyp7Qf7J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA41rC004076;
	Tue, 20 May 2025 07:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RQ7IZ
	YyBqBFp4gNhQeWbhxaj7ZBB1as5IUN6XDjsh4Y=; b=yyp7Qf7JsHmZbU1tcMAoT
	4agleDCdfZEB5aieI1KjTDH7hFMIN0dVTQjgi0dcYy1uZtQnB0hvvMw8JzDO1sKQ
	+JxhiueOr/1eoIG4+rxR8rRXaT25JkkjCcIvnWT+f3ZyzZ0/fi3l4LbTFfw0Y1/l
	4vVY4ol3c2450vAWcrH3+PvKGdQVh/cHZJeCt8ct03jh6zDiGZiteUzu4Xom5vsu
	ynFE3h7SA4tWhkiCJAyMaOOauynZMuHd0wLXfo7m8/ikVxISjkb2jQv9KeWQKX0x
	QTcMTSX21v+QpdF2FVG/zX2c/SxvndWfZLg2u0SaMzxjdXENAf3Jiy8nfbrNQfPs
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46rkya98ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 07:01:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54KB1IfX050327
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 May 2025 07:01:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 07:01:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 07:01:18 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54KB1716022189;
	Tue, 20 May 2025 07:01:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: adc: ad4080: extend check for data lanes num
Date: Tue, 20 May 2025 14:01:01 +0300
Message-ID: <20250520110101.29478-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110101.29478-1-antoniu.miclaus@analog.com>
References: <20250520110101.29478-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Er3SrTcA c=1 sm=1 tr=0 ts=682c60ff cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=GGKVI5b-SMvUNDNwoSIA:9
X-Proofpoint-ORIG-GUID: zH9JuYmr5ftKqTC9VFWa5m24azQ4HO0Z
X-Proofpoint-GUID: zH9JuYmr5ftKqTC9VFWa5m24azQ4HO0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5MSBTYWx0ZWRfXwjnE6W/cXHqa
 LstQDlRr0gJRnBUl65TkrzO6kCLdSejd3/CTSNlt7Qu632K69VD6ne6zbdESlrNcuGiGPXYnXhI
 EyAhaBz9BMpeDpECZokjXq29Mjlbv5YabpEEv82O8vie0iymwX/ZroqNnzghCKp9E6l6HH8lww8
 W/h7W4dmyeMcjZ7uciggS4jyN8sEFQUfdYzFXxQr9oZrsSAq6uKhneA9DRE8j/r/sz8FCa1cein
 Mrk/otmzvOW1iEyEf/n/xDslw+v5ojMCIVkDJGb1ebIttpbNmk4D5wL3h7Tdg70asYQfs1Ixv8G
 njVarSXA/aNTdTQlxS35mK13D+NDL4hFrxxJ/GQAlkcEMeYMeNmGCrUQglYsndTClSP8QuhpRXI
 K8dTTH0aswqkU0bK/YxM+i9oAdlYbdm6ZcEsFB1IcQbOlKDgrqa4LKy7VlVV+BeEG6Wpfd4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200091

Extend the check for st->num_lanes to ensure it is not greater
than 2, preventing invalid configurations.

The AD4080 only supports up to 2 data lanes.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index c36eb41d738a..6e61787ed321 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -516,7 +516,7 @@ static int ad4080_properties_parse(struct ad4080_state *st)
 
 	st->num_lanes = 1;
 	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
-	if (!st->num_lanes)
+	if (!st->num_lanes || st->num_lanes > 2)
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid 'adi,num-lanes' value: %u",
 				     st->num_lanes);
-- 
2.49.0


