Return-Path: <linux-iio+bounces-18968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62CAA6D58
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387F346487E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3223A995;
	Fri,  2 May 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VNkm+lt0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26222FF4C;
	Fri,  2 May 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176385; cv=none; b=qUDHzmKf84w9Tr7f8euoq2jgTFCthmKpWrAb99QLc8rT3bmr7h27ElID2jwtoSKtPxT9v1ZBxDyAHuau1Y3yDhCO23UcZCu3S+i3IVjAuevEJeRoSrlBKF5oA/PChg4KcWa6HYmeSlRga3djBW88QSfhK3CLKAg334kipetGdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176385; c=relaxed/simple;
	bh=J/wcDT6qZyY5vPNBfpk3pjfrmURCBKSmkchRCipnz2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBHn8YCzAPafpNfD7zZkXeBzJhiyKnQJOdLO/8NGSiYBtRjm5ifFvD2/l6gywLP2M18TovJ1u85rm2wNJa4lwfjVKVTzUQDfvFG1w9yOtVWe3+2ONW9vgOaRVEAJfG06xWvDwZoorEJxjZo+3BF10Yn6nISz27waJEOshLlz4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VNkm+lt0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5426ZsNq030668;
	Fri, 2 May 2025 04:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RSI4p
	duHjkvPzIQQUDZW5Kd3nXOFACdk0nUJaWx4USU=; b=VNkm+lt0kfAEp6i4/nfk4
	65LZgZALUNm32DclUnHasTNKLRR0lDxsB8aaTXQmVwwQwR1P6ZHqxjdf7YvULSVu
	vwK5uTykJe6GRwksTyY2SjrLVjE+cc7R5SNtSxZ2fvDDm3IBd9PVUkG4lMIfDo2G
	qtnnBQYBU5ulYnPx2mKaz7vkm8pb2WRtHsQNEYTrqUl5Q5TeXPuk2bMY42pj2x9U
	J+Zjn7w2fMDM/4Ib8ubPhuPuyB0mbKpCNDVpazpenWMIxLu78LKpSwMcONVtlmU6
	8l9hxe340iQZQB1v2e4FOvFNBEUKU+ppedj7PTBYBwmVTMa6FOlzUE8SenM22ruh
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6tr3xqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5428xeLv058985
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:40 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7T015723;
	Fri, 2 May 2025 04:59:37 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 10/10] Documetation: ABI: add sinc1 and sinc5+pf1 filter
Date: Fri, 2 May 2025 11:59:05 +0300
Message-ID: <20250502085905.24926-11-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: H9BvGm4BH8ZpqtPKsUtA_lG3LuGRFl9k
X-Authority-Analysis: v=2.4 cv=TpTmhCXh c=1 sm=1 tr=0 ts=6814897e cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Jj58fO0nKZ7HuPVzIAUA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-ORIG-GUID: H9BvGm4BH8ZpqtPKsUtA_lG3LuGRFl9k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX4pnh5kI+U0+r 86i3i4hO5eXzIbZmrd75SqDUuaWJRw6geSIdjrul8tOG9qsPJ9wMupU6PgpDJtjux8Htl6VoIDm JAgj9i5WyNR/XOKWUEfntMCDLcNwyRBQn+QZR2OYjgTW1YijIkqMCn2Smwj78L/H2tjd01Q8sL3
 Vq6cxSjfnnNfj+A7mCg7UCw1ZOnCOYtVR9rcskiSEAvwQT4SA6C542iWEvn4pt1bON6w4mtNN8d PyoeVy6v/CNqKZMxzajDWKoXo9rggsDtTHL43YINgBWqlX/BJ3GsCoo2PZQfDdKFP/46BYT0Glg XyWDbomg10dAjvwhL+twhyXrruI4PuLIDbqQ0o13yWzoCmCWri2G99SzlZn5wnyrK9zmSI49ER4
 jIjsMBuTS7dokzZaNRILxPKtlPyPGk+U2ckGuY8mfOUZzRrO5VC2fIMxaq+pcx21eXSPByCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=945 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add sinc1 and sinc5+pf1 filter types used for ad4080 device.

Add these two options into the filter_type available attribute.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b8838cb92d38..2dfb74b5a990 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2275,6 +2275,8 @@ Description:
 		Reading returns a list with the possible filter modes. Options
 		for the attribute:
 
+		* "sinc1" - The digital sinc1 filter. Fast 1st
+		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st
 		  conversion time. Good noise performance.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
@@ -2290,6 +2292,7 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
-- 
2.49.0


