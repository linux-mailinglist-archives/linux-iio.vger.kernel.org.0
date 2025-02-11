Return-Path: <linux-iio+bounces-15374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B65A319AD
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D351612CF
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DC26A0A3;
	Tue, 11 Feb 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v2oU4++m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9099272935;
	Tue, 11 Feb 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317603; cv=none; b=EEBUBuJWUB47J0kVyl/ray9AXrhRYOU+RpMrj3Cv328Gzs4qtJhlhbMe4P5xBDafnhJ0Z1gxkHPzj/mIKJeDANk78uvRJX/x4SjNS5WagIrsokdGEvzxYTfDvLrNTH0WX0l1aePTILc15LGrqsnwuwAGHpY2wAO8cy+lAMDv3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317603; c=relaxed/simple;
	bh=2L1VG3f3/yfeQnF7C87Nj0tNYvw2/uGw161yDG2RQlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ssP2m1vC+UiioCWOt8pII65QRiTo+WxYdWOFXdlH4TVpkIf2uY6r5tzCY1Vl2LFfulgDGFSdWdvfubLiX8u/AoUUjAv/S7tX21dPVTem1B8TqDA/CTymd27+8zwi7ZKwUIM3zsCJkqWF1701hQ5CxUT94jB3UjcVqnNrgbLnl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v2oU4++m; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BIkZNL002761;
	Tue, 11 Feb 2025 18:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZpEPm7Dn+k7PDa9/OCfdREi70ru
	1OlRRpBCS4VhQgMk=; b=v2oU4++mJoU8+BA5ZVS+Dx1KeM9KHg0h1CR4fgUsRQt
	SGN9Dwo+crlHt6Nkn9u7SuE7ZnpkHw7ViUZaWILE+aez6HFR6YqfM2j2mtmsaMqs
	dg1MqlfhfZRLplV8QgG7NSzD58muz9GQBkodGB4zytoIC4ZVFzlWu+G1sAY+jOmX
	eDW2C8mKGmKFkR1agjgQobqsWQ66b1fTOiVlacULbQGgAyLJMk1VDs0pwLQPTxeO
	U8HBSCb+kbc94Y6+a9bRsmFnK2cMEaYhYBKrusfBrLyuaZ1RRE4ag5IlccYe1JyL
	Gk/Rx9pp901YQF4kZRYu3Pq+jw2PyCDQyZT7Hge22lw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857j5pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 18:46:26 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BNkP6s016941
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 18:46:25 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:46:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 18:46:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 18:46:24 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BNkB5N009859;
	Tue, 11 Feb 2025 18:46:14 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, David Lechner <dlechner@baylibre.com>,
        Jonathan Santos
	<Jonathan.Santos@analog.com>
Subject: [PATCH v3 01/17] iio: adc: ad7768-1: Fix conversion result sign
Date: Tue, 11 Feb 2025 20:46:11 -0300
Message-ID: <20250211234611.1007865-1-Jonathan.Santos@analog.com>
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
X-Proofpoint-GUID: ywiHzsbsFks9Q5324K0WfNOmEie6wCC1
X-Proofpoint-ORIG-GUID: ywiHzsbsFks9Q5324K0WfNOmEie6wCC1
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67abe152 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=yJendyViJHfIK-yCp0oA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110158

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


