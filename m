Return-Path: <linux-iio+bounces-15458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17466A32E44
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F3B7A1AC5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459720E02A;
	Wed, 12 Feb 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nMY7wAuu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064E1DC075;
	Wed, 12 Feb 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384197; cv=none; b=E0C+d1HZdtfKUpmMUfY3feGlkAeVEpDgfUDxlAiGzg6Ng0YvWzWZ/TbqwVOJ1Zx6LW0uKEaVzFy+GrmkRDlIAdsyJ1CeWXikVfMGGlyunbIA7KBJ2ARVMqteiH9bir8Q+LiCNNli8ckx/IyhAplnHMN+w21NfeF9Lk28y8CR15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384197; c=relaxed/simple;
	bh=RD7t+esc1UuqwtQXAai4PYFuLXIkjkpxadqVhtJ/quE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0hbdDj4PAcKWvQ86hqUTxJyA59scLlChmKvY65iw+CVUT+pmJJGGTpRzoBatuIfIRfkBc6dlrqV57JlJo3D8AxGibkruw+l/+80G3gtH5HvH5/6tKvUYrXfjTxhpdPkhCJjdiX0dBf2Q/AOabowbg8MeBnjFiDZC6++RZgQNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nMY7wAuu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CE4L8M013257;
	Wed, 12 Feb 2025 13:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BYtQL
	xzqD1bHUcawr2wXeUkHovqbPkUgqI2GXRXh6uA=; b=nMY7wAuuanHsM6kMOWTEU
	Iv9YeGTG6oCVrWRVP41hWdMbdYWrgaSCOpaXO/2+HXS35n2UGkL+GGK9a2tyrhrq
	ob2Rf5DkGymDnSH14xoOURPCWf9dTDBfa6G3cZ+Dm46eCkDi1ksrv4fWtD4eE+V+
	G83IyD4mjHXMkDuK4a71vCYp/NqkDjZpaol6rt6EwQlFcioiYFp1tKamv6UO4zYy
	zij8XFqfg2lWkGw89Pl7Lds6h4z6KaSla0mVTr/Arp3D3UMIoQ/Zi8hjEPiMHig6
	YbE67YRlSWRiZfdVOS3hsdE3qmPDXhDBC0Vl3PrJvcGbO0Y0rBEeJydnashaz4BN
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44p52a3n30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:16:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51CIGHPF041105
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:16:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:16:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:16:17 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIFvXM017304;
	Wed, 12 Feb 2025 13:16:00 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH RESEND v3 01/17] iio: adc: ad7768-1: Fix conversion result sign
Date: Wed, 12 Feb 2025 15:15:57 -0300
Message-ID: <505994d3b71c2aa38ba714d909a68e021f12124c.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IYu1ArnY8QggKNttLE92IaEEgY20OsCE
X-Authority-Analysis: v=2.4 cv=FabNxI+6 c=1 sm=1 tr=0 ts=67ace574 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=yJendyViJHfIK-yCp0oA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: IYu1ArnY8QggKNttLE92IaEEgY20OsCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The ad7768-1 ADC output code is two's complement, meaning that the voltage
conversion result is a signed value. Since the value is a 24 bit one,
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


