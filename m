Return-Path: <linux-iio+bounces-24261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE1B863F8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7477616DDAB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BE3164CB;
	Thu, 18 Sep 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QkETKkY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168A2F7ADC;
	Thu, 18 Sep 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217081; cv=none; b=jxog81O/BfJCqnbCfOXc+Ad/0aqth2aCQ837YFjrJiLuBB19Cu8fxu0uRknLf4mEmeDN1YevZzVR644HkU3m1r6Zdc6TRmZwr/DWYEGfdzarK0PvHaYsb2nKxBz3g7JIYWz4oigjg/iqAV9M7trCKkxBltrwzU4sFItPC35Du/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217081; c=relaxed/simple;
	bh=icdfIRrP7/GCzzzgXPDrWxAvfh9SF0HG/HbpRFb1yEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIoLYHmGg/DPS1AaFmYNVI+Mqq5SwM1BE5xqr8ChlG0pq6d6VjW0Q29AQjNyu+bgQB2NWLgltcJzlBJunDegF7IZbAUGhxjVS25+x4QHErg7WukHy72i1jAiufvRv6p69D1NatbzGzlbwj+8hLZxy5pHGs941Ktsb/N/n/vB6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QkETKkY4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGNcW8008734;
	Thu, 18 Sep 2025 13:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gwebs
	I0gp1zJEXCdUMC6sDtI67oVQChtIaXGybwGlzw=; b=QkETKkY4lJOS8XvHCVZqJ
	IUqa99/jZCtv62aMHxeJTMh/ndN5vW0q5idKoncITT304fXa60glUY+DtDiB80HU
	ntrvKdFOx1mZdxXGWbZOBHxud4dQcqnjMwQ/8rCKl1AIOsGxlQDNwtmd4rbIvAHG
	dNSV3BcuHPOJZ99hGh/seRY264XirGSgMfpFKk8GjWLN/us7SgaSatIiupzpIBi6
	W9wc38/UfmhZZ1BmCJSq4Nw+J3BTXlH1LR0IMahDttp28nI/s4FTz5ykLiFnjTu0
	jKpQ1Eo6I8Dm8BPCNihuG5YV1KvRtAb3Q4lWIYRTLLH1qffgeel8Kpo1U35AnGzB
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fxumebu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:37:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHbiCE013623
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:37:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:37:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:37:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHbSdM022194;
	Thu, 18 Sep 2025 13:37:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/8] iio: adc: ad4030: Fix _scale value for common-mode channels
Date: Thu, 18 Sep 2025 14:37:27 -0300
Message-ID: <b05f763506fdecf0d21a53dde82355418d6fb915.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cLfgskeN c=1 sm=1 tr=0 ts=68cc4369 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=vQGBvtuwdtq06SML6qkA:9
X-Proofpoint-ORIG-GUID: 6Su4GhiB0OyCtg6OkYOdIpLS2LNnFvly
X-Proofpoint-GUID: 6Su4GhiB0OyCtg6OkYOdIpLS2LNnFvly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwOuG1pP71vly
 kuobaijOsgIUgISLFyew/C18gYmxPNw97CXr7++XbuVjal/4zhlIMjjn+xgghTItUCYL3HoAlhx
 fxDdGH5qvA7aGHctkh2FY57R+pQB1rviTrEN+MDWcufUiVmZW9L79ghEJWzdKXKuNuvfX11nKsB
 krLpDJD3Bhyzo39YN99/ZcdN8C7MFf6jyc189RcCbr0KR7u2sS/1lTMHfWhGJ3w/WlySQEcJk5Q
 Gu3Fs4/dIYOlHqi2qjET6iThQ5SVduO8evU7waN4aw1/aLa5S2QL4rDLAU8pIynl6ImQRoZsBgq
 pCNQg1CBhHQQLfUL89ZRoglmeH9B2Shf16M3CQxCYdu1Lcq3KzyKTv1KWNmzsbfxt+Sr23Kmvie
 1sKOMmKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Previously, the driver always used the amount of precision bits of
differential input channels to provide the scale to mV. Though,
differential and common-mode voltage channels have different amount of
precision bits and the correct number of precision bits must be considered
to get to a proper mV scale factor for each one. Use channel specific
number of precision bits to provide the correct scale value for each
channel.

Fixes: de67f28abe58 ("iio: adc: ad4030: check scan_type for error")
Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a22470..d8bee6a4215a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -385,7 +385,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 
-	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
-- 
2.50.1


