Return-Path: <linux-iio+bounces-16491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D18A557FD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EC3AA7E0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A84720766B;
	Thu,  6 Mar 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CnV0iXeD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BF1A2388;
	Thu,  6 Mar 2025 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294876; cv=none; b=DFbPwj3YQ6GfSKNwjbrxyBO5Wbw4m4yHku6qefPa4dErIl1EGVPXJSVpfQWm+scfk2LsXUYWC0vvAXaDVqpMk3huGAjF63b8n0miIPuqUpQGfmEEn5XxdKAQnTQ6VPngqyUsMD6s44Jkicdiv0a2Td3C6Ek4qoEJtYQlbQuXAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294876; c=relaxed/simple;
	bh=wdMRO8mYUtXMF/TOhOQ9Xh+uvjXMvlLYZCiitqxkjcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7Zo/0RIh8pT4mIErwk3GMUyPeyonysM+e/DfsLkbEfGPYFb0FmBlOQAYvVHBbe8sEUT/8E0pk0jJdxIJJ2sY+Vi+zFvFheVCB2izCBvOie5Uo99BQUtKL7zMh0RDuy/BP+V2lsV0GxWVD6z8ioMzKTlw/uDBRo78d87Og5sMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CnV0iXeD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526HfeUP032558;
	Thu, 6 Mar 2025 16:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GsY8n
	NQjVDrRoU0iHMLXPzlMLJPGWnENSan8fes06TY=; b=CnV0iXeDA2pGwk7afMwLC
	shZNrJ1OfCVeTX2XJiiSdWjeD2Rc7ufoaCQ6P33dtUD6s1XFd3l3e0GACV4CK+1O
	fXd89B22wslzW25XdoNqn76re+GbN9FORU0RacWRhjIiXGeKWDqkVsvyUgR6pc71
	5D3Xf6Zbr34YyZQoP0uaWX2zuwsxbuU5ouSM+/kFeWpixhdx7kh/1Qzf4nF9boEf
	PcRWUh/jsP7LWvPQj/Mg9T3JonBJB0QwL7PIENLX/l1jy9H5jrub98gVVI5GZFHw
	h5F+LnDyVe3fjE3CWkx/G2KV3au4bNUHnGW5o78hwZY8+xuvhoebvILpWpA4j0Zm
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 457d6x1srg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 16:00:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526L0mwU034694
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 16:00:48 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:00:48 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 16:00:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 16:00:48 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526L0TJv011436;
	Thu, 6 Mar 2025 16:00:32 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v4 01/17] iio: adc: ad7768-1: Fix conversion result sign
Date: Thu, 6 Mar 2025 18:00:29 -0300
Message-ID: <505994d3b71c2aa38ba714d909a68e021f12124c.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Epq7wq7ge6dpkhm_iXVUBwiq_nnsKn6E
X-Proofpoint-ORIG-GUID: Epq7wq7ge6dpkhm_iXVUBwiq_nnsKn6E
X-Authority-Analysis: v=2.4 cv=E4w3pbdl c=1 sm=1 tr=0 ts=67ca0d02 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=yJendyViJHfIK-yCp0oA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_07,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060160

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The ad7768-1 ADC output code is two's complement, meaning that the voltage
conversion result is a signed value.. Since the value is a 24 bit one,
stored in a 32 bit variable, the sign should be extended in order to get
the correct representation.

Also the channel description has been updated to signed representation,
to match the ADC specifications.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* none.

v3 Changes:
* Added missing SoB.

v2 Changes:
* Patch moved to the start of the patch series.
---
 drivers/iio/adc/ad7768-1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 113703fb7245..c3cf04311c40 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad7768_scan_direct(indio_dev);
 		if (ret >= 0)
-			*val = ret;
+			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
-- 
2.34.1


