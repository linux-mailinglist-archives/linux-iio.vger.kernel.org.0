Return-Path: <linux-iio+bounces-19359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98AAB1064
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1D2A0758E
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797628EA48;
	Fri,  9 May 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ircLDYKA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597D22D9ED;
	Fri,  9 May 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785843; cv=none; b=K3YSjIAbVKtfirgmHH2UiG0l7bxKGnyD3DxahDgTJ6cGyA8H2urksBs+R1mfKRIcD4TQiv2YN0fPKft3Sv2u8SHgmYnDTJzmwMCv+Yzjl9emavNl6F3t4PWkvidYkXQF4DR8w2MUTDeW8u5zQNrSDS1UEvq5NSaWObFv6lvUqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785843; c=relaxed/simple;
	bh=vOyuH7zGSKu73KVsMFVFZEZDxKYFIXGQZa3XtLStxUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DPc4cW9xu/Ybdp4qKScfSFASN9e7rr2u+farcskBQN1Xnj92KOuXX7k7+H9LSMPjmEjiwjuTgUStk561w3BrCEhOiArYgbOXgh3s20p+Z2q9NIOdi4cNhelxlgSYKKGz7Xv5QAo4pta1+IMXaWW6jjmn1UHwkqzlrWP5cknaGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ircLDYKA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499xDeP007329;
	Fri, 9 May 2025 06:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5Y9R/rN31vvB3epgSv1ADArx1oY
	BpWR5iYQ/ehgjtXk=; b=ircLDYKA3mVjtk5YXqw0yAjqXhgcdIK2+DfNee91Ez5
	sJa2NLtSezCVJSnxcaO8WyOtunZcBwszwB9Llf84gC9u58eDEJ503PG/+k2ZAd0g
	7L6fwJT0D9362Hhv06csf7F5X9262jpN49pDqpHIKrYI68JW7DUTJe34qN1pIhyC
	hGQqZqKfy9gex+BqMnnmQZRt6H5Ni16CJOH+/hV2IG+aAo6CNicTZWB6sxvhOMDC
	BgaOKRML5cZtB2WL4Uu6IDzky56TaZm/CTM9v4W/nRsZXyOLrK/6Jdzc8FHOyirp
	D7800Dqxmkg9GxlWI/Ont7d6E683f+/Ctb11sIkoXMg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hc2yh518-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:17:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 549AHE5P031848
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:17:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:17:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 9 May 2025 06:17:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:17:13 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AH6sn013060;
	Fri, 9 May 2025 06:17:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: adc: ad4851: fix ad4858 chan pointer handling
Date: Fri, 9 May 2025 13:16:57 +0300
Message-ID: <20250509101657.6742-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5OSBTYWx0ZWRfXwr1j4uzGF13z
 gZdSeWKjXhR2on4fVNBxBatailWMYyVn8asrGchwfuCN7SidLLhPN1CKxkF6jhawdN3ExLaPsKY
 P7XK93gglifChMvn53vmPyzN1TJdFHp0Xijjg4eGiUbCSJqKhaOxyRlKqyj9UaeRVJhhN+7Pq/D
 DYByumkLH3M3eSAY2Y5BUz5w42yZk+bEeNB22sxe1KgSSHxGKY7nfPqRdur4R5khfrjv//5Z9vM
 3u08V1GOYHLnOgIAphuCxZwAi2DARZw91hTMp5T7myoOrjtgOeSi0hobAeAd9vB413mZDjjiGN2
 35c2JNOw+QLu6+z6IzY4CJg5grFtG6QkPq+D/ttQDnHAoqF6jyYjfdYjOuOCnLiRjs3IKlY1KRu
 9NbhQI2lorENrHqNfk9B32EA5EpnzyhOFwgrZkg+FqOjfPVLLdlWk8zP4HBlWsC6KFQbAqD1
X-Proofpoint-ORIG-GUID: MSIXbSbBBYAr1zwLUPJpjOZ47xBR_dzR
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=681dd62b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=EFlIJase3jX5Scr6_QkA:9
X-Proofpoint-GUID: MSIXbSbBBYAr1zwLUPJpjOZ47xBR_dzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090099

The pointer returned from ad4851_parse_channels_common() is incremented
internally as each channel is populated. In ad4858_parse_channels(),
the same pointer was further incremented while setting ext_scan_type
fields for each channel. This resulted in indio_dev->channels being set
to a pointer past the end of the allocated array, potentially causing
memory corruption or undefined behavior.

Fix this by iterating over the channels using an explicit index instead
of incrementing the pointer. This preserves the original base pointer
and ensures all channel metadata is set correctly.

Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4851.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 98ebc853db79..f1d2e2896f2a 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -1034,7 +1034,7 @@ static int ad4858_parse_channels(struct iio_dev *indio_dev)
 	struct device *dev = &st->spi->dev;
 	struct iio_chan_spec *ad4851_channels;
 	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL;
-	int ret;
+	int ret, i = 0;
 
 	ret = ad4851_parse_channels_common(indio_dev, &ad4851_channels,
 					   ad4851_chan);
@@ -1042,15 +1042,15 @@ static int ad4858_parse_channels(struct iio_dev *indio_dev)
 		return ret;
 
 	device_for_each_child_node_scoped(dev, child) {
-		ad4851_channels->has_ext_scan_type = 1;
+		ad4851_channels[i].has_ext_scan_type = 1;
 		if (fwnode_property_read_bool(child, "bipolar")) {
-			ad4851_channels->ext_scan_type = ad4851_scan_type_20_b;
-			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
+			ad4851_channels[i].ext_scan_type = ad4851_scan_type_20_b;
+			ad4851_channels[i].num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
 		} else {
-			ad4851_channels->ext_scan_type = ad4851_scan_type_20_u;
-			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
+			ad4851_channels[i].ext_scan_type = ad4851_scan_type_20_u;
+			ad4851_channels[i].num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
 		}
-		ad4851_channels++;
+		i++;
 	}
 
 	indio_dev->channels = ad4851_channels;
-- 
2.49.0


