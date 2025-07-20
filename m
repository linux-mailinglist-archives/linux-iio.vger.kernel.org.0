Return-Path: <linux-iio+bounces-21786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB07DB0B6BE
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70F1179AAB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545DC21B9F5;
	Sun, 20 Jul 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eZYmP70M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858111F3BAE;
	Sun, 20 Jul 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753025884; cv=none; b=GhLJugkPOVDqXyFZyndmrrr5hl9qlTREhwijDC9lOZZ7es90gmTZNklU8BhyL1XlKYBLpHswQtsBuNNga2SuSjtRQq5Qlbq5ZwIYkzG3Z+AFll95h00IGkk1xm+Sir8P5g1YrcDNsgbCt8IaEEqLGqJSPRvFTxc1R2fmrHWEN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753025884; c=relaxed/simple;
	bh=Y+ybZhTPy2cGYGBkJcewYJqBYG7882MUTXSK9eYIfg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HLaD818rtXYGDMTXHFBUTW4R+sinCz+a1jfUVJnyfC7bN3bnUcsx1Z+hRN5XnnF1wdV0TQttC9mu61DzppUN7m45iITfIf+ijvc8C9bJ4Q32nn1kE41HLhYievU4LU6PacKCMr9+zgbOW6l+Bl9EQ35V3nRvfeT4+4TTi11gM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eZYmP70M; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KCZH6G015354;
	Sun, 20 Jul 2025 11:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=p6GR5zCULkj5K4DA14tSJXpaddD
	bn5bcYsYARha5jZ4=; b=eZYmP70MH+uG+95gUO35OlISG8m3jH7jdqHp0ca/dOh
	6lCxnFqaWBagviTw9nGokedx056DHRzdki8Bbob//vj7Squud+pkE++DsrxQv+0J
	YtTdIrwo6vnf1ZX2CnzkcLGorCzvDT158t2x3ab9+crlGTEUh+X0eV1lXqCVElAo
	q7kvrYlq7rdg71F7/jD4dg6Sd97J7ynqgLaiOy7ga7ai6NKaWZOpieUiwZZTDOpC
	pQ27rCun6PhOh6m6KXVCnECKsDo37Pv9eMnYY2jz7kz6ozqpkYPRcspqs47OraCA
	6KVFBlZUiterPIOAiCBmh+jHg4g+PrA9lHWbEc3ebbQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 480spghp7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:37:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56KFbhMM053798
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 20 Jul 2025 11:37:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 20 Jul 2025 11:37:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 20 Jul 2025 11:37:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 20 Jul 2025 11:37:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56KFbR0M002699;
	Sun, 20 Jul 2025 11:37:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <dan.carpenter@linaro.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <Markus.Elfring@web.de>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/1] iio: adc: ad4170-4: Correctly update filter_fs after filter type change
Date: Sun, 20 Jul 2025 12:37:24 -0300
Message-ID: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: haQR7i3j_jHWVdfdv2z5y9C-GLHBUp5a
X-Authority-Analysis: v=2.4 cv=eLoTjGp1 c=1 sm=1 tr=0 ts=687d0d48 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=RfnqR2mHcw6JEVV_u50A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE1MCBTYWx0ZWRfX1bJiv6VS6efK
 Kc3qG7P0qa/ETY8VvVu3LNedHMT9Q856jWjk0GO3SSGXQzLF/YSTGvCSBWlJh4cr85/SRFvY0JM
 EFNw+Cy4mPQrW01Uv9fW37A5xjZsVQ+WcBe6sGTDWJ/UkBvtzEVckvlQv5xDPGzt4Oh1wHve1Ik
 fClYdzNfr7FS3gNRZY2dUFQKTJBMu7FRu92HaFPulbnlRwIik7vTkvwGnCdgpUB8RO+FreUdKRn
 fuV8WhBiBwjXP98KHL+teoYH8wxaoTIl644SjUQKSXtQDW8fi1HCx0Y0KNoiWyo1A5FkGr+IFWN
 luXhlz4NFRnGIZRWYakpI/sgOgZIMGX5mhxCQ5J3Tqc35M38rLFxPNUHaWWCcZcBGQozENrP4To
 2GHrJhsoDItz9xt5xn5zwbtJ+R6LYqFObp0QdO6B6rs83SOFEM9Ci+h2a5rg48Sy6cRQG6kY
X-Proofpoint-GUID: haQR7i3j_jHWVdfdv2z5y9C-GLHBUp5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200150

Previously, the driver was directly using the filter type value to update
the filter frequency (filter_fs) configuration. That caused the driver to
switch to the lowest filter_fs configuration (highest sampling frequency)
on every update to the filter type. Correct the filter_fs collateral update
by clamping it to the range of supported values instead of mistakenly
using the filter type to update the filter_fs.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-iio/c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain/
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 8ab7434734cd ("iio: adc: ad4170-4: Add digital filter and sample frequency config support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Hi, this is the same fix as the fix provided in implied v1 patch but with the
difference of doing it the way Markus suggested in reply to v1.
I have a slight preference for v1 since that one keeps code contained within
80 columns. Though, totally fine with whatever version of the fix gets picked up.

Change log v1 (implied) -> v2
- Replaces if by use of ternary operator as suggested by Markus in reply to v1.
- Fixed commit log typo: colateral -> collateral
- Fixed commit log typo: clampling -> clamping

Thanks,
Marcelo

 drivers/iio/adc/ad4170-4.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 6cd84d6fb08b..2e61f9a9a1ef 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -879,12 +879,11 @@ static int ad4170_set_filter_type(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
-			setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
-						 AD4170_SINC3_MAX_FS);
-		else
-			setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
-						 AD4170_SINC5_MAX_FS);
+		setup->filter_fs = (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
+				    ? clamp(setup->filter_fs,
+					    AD4170_SINC3_MIN_FS, AD4170_SINC3_MAX_FS)
+				    : clamp(setup->filter_fs,
+					    AD4170_SINC5_MIN_FS, AD4170_SINC5_MAX_FS);
 
 		setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
 		setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,

base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
-- 
2.47.2


