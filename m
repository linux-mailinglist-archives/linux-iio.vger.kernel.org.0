Return-Path: <linux-iio+bounces-23880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BE0B48581
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C927A16E4E2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031D2EBB86;
	Mon,  8 Sep 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FiLu2V0P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6F2EB5C8;
	Mon,  8 Sep 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316981; cv=none; b=FbD5K5MfEatZEA64fow2DJllVlyZEYH4w78kmKOWEvkFqEsT+AnhB1dHbjs3Kk10J/jKoXUvGITxd/bOLZRSLO7Qa0+biD//VWKhuSsKcbaaTE3YxSDZO9HwQ/mU/acUTbyAf0kA2IGdLXuA72oMUPJ6ZUcXHb31E+Ct1fEMrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316981; c=relaxed/simple;
	bh=60BogBr1K0rEb0p6emeArENNpPrsVNzSbPc40m0yfS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBv+fd1bO3Y1Pp9J8ctA/O5Ls3r6N/bla/MUQraoGCJOD5so4qxpa3Mv5D8nCgsj+4SavqQb6WsrO9edroabkqizhS51ztR3MEZOQbYGsGXoV7OreuCUJhUtHQEGNZj+X6ZWeNh/r8MN6NEfOr2XBjYtbtTcvBACP8bnSZ+E/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FiLu2V0P; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58862hlF019388;
	Mon, 8 Sep 2025 03:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=M3uxZ
	LznLdOXjQc+lA6eO8kNZUCXyqC+Y/82cvOBmUw=; b=FiLu2V0P+ZnpHiaHEDxWU
	XM5OHXDNUbzdUJSsliiFG7wMLQNnsM6uKdj2f4eSEhGtlNJQAwP+xUjsSK6BXqd7
	XZ7ikiWc9A3PFKim/y7ps+pUzlAKH8bQpgOF1PPHPimTybq5azEQjtn2J9jlDRpj
	sXyWjWbGGt9Fhkj7Erfavdxeo0K+xt3ujYKDwyzmyvLTYEr2GgZQXnuYIFdOrA7X
	FAyauKMXIk3I1xkcL3tZt7MlW0ok6iQPsnWDvAuhefDP/a+uP66UWlvQcy74A5tS
	HP4+ztcAEoiFY5wxuIFv9lBWfIoz240V0O2km/qE8UqwqhDyr5b1vYqpcydlULNV
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 491h0m29y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887aF4W036483
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 03:36:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:36:14 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEi004718;
	Mon, 8 Sep 2025 03:36:06 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 6/6] Documentation: ABI: iio: add sinc4+lp
Date: Mon, 8 Sep 2025 07:35:26 +0000
Message-ID: <20250908073531.3639-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JHJ7KBWy_IuMbruUIjaqpUnQ90v3TGrQ
X-Proofpoint-GUID: JHJ7KBWy_IuMbruUIjaqpUnQ90v3TGrQ
X-Authority-Analysis: v=2.4 cv=MKFgmNZl c=1 sm=1 tr=0 ts=68be8770 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=vk65wfBuYYdHxbUI-70A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDIxMiBTYWx0ZWRfX1rS/as3+CSIj
 SQ/BUyKtE2PrwO3V/ipcfRFz31LWxNkwPxkRKd7BOYpSRLWR7X+dQW/NHwCWUjGAmZs5gYFKjvi
 FxqFfw3dhunx72qeZ825cn3TOECrrD5EVFaWXBNa6lWZm6ilQ7TAEjpfBobSvGh3J8sXcxWWROO
 x58b1XHy5yCMLsX4+s5L1bb2g1L4rHhuEk189qHQGjSzztleNqTPSxiGa+UxnMzRYlkgZRqMSFC
 GP9+2o2tNBlWNt6q2V4GzgZmxQzFu4JgGHKfDrTgpjdFbXbLPPM0y+W1NyNaAycKrlGBixpApH5
 YTs5k57z6Hn3BhitOguGs+2Oby/zOMWhOCJJ5pmjIayKgmHhW/C+226TJRRaW9gZELfS5G7e8Vb
 sdWHjdbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509070212

Add new filter type to the sysfs-bus-iio ABI documentation:
- "sinc4+lp" for Sinc4 + Low Pass Filter

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v7.
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 78da68826307..cb300135b4c4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2319,6 +2319,7 @@ Description:
 		  time.
 		* "sinc4" - Sinc 4. Excellent noise performance. Long
 		  1st conversion time.
+		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
-- 
2.43.0


