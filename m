Return-Path: <linux-iio+bounces-19319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D577AB00DE
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA69827E6
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1F283C93;
	Thu,  8 May 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eyoCpGm7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E822221294;
	Thu,  8 May 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723814; cv=none; b=pdN9rfs653gGJcC865ZzHv9K69bNxvZTxwZczEtkBTn+ZKGu9N8gtMSqk92uBI+fo0rtI02hDu0SLDooCUuL1TJyrCB6xixptPYMgBxMN1f2dOW9hGrQi+cdAR1qFqUCl91F/Hd6cYLLgzHCWOQ0FkD20fhrXWIQhrVkLTHF144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723814; c=relaxed/simple;
	bh=QEBDyAlC6IBFJ3sx3/iYLUcQz4JHeHxm6pFUeaRv22c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qisAdlORVOFT/sAK4T6m/qAUivzIVs8V+fteXQsiONEpnqJGERfvI+tN75OIqFADaXwes8D/ckXjAltmt9NNHFzUXd11B0h3j2TxXEeriOFhTAlhi6kfr8JhOWV2t+1upEySYzYoRbOVIb6ggs6IeALlNNOgUrIJlvcXzxEf14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eyoCpGm7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548DMfSq013536;
	Thu, 8 May 2025 13:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Qifrm
	1q1nVUMq8tY1XfT1vophS/+sIv9dTAlLT6FCfM=; b=eyoCpGm7xXmwMyq/QP4kl
	Jfsrn5rRlGCwMvUPvuSl6kh6MeCUXGMazjpFJiaxgm6PVBX+HZK2kp0rbSL6Gmym
	BJ1iW5Pg3B2k7kXWbbdf4c6vqgrZsCyX0b0fo8i56ZOc9cbxngoBkGfmAAjdPdMM
	X02esnwUhi+2ssviwEqviYkjgxN50sJup+B70zX+m7tgvpfVs4g5PSYratiJz82z
	/bK56V+TCdgz2dtVR14H0f67CRIflAigYPt+sd/wTXFtqg2PZq+AJ9dDfNimYsZZ
	QSOd8DvPBNGbLkbMSCT7f/F22QjqHGtCigSg8S1cTipuSnVmNZe2IIlM8iHur4fM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct32a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:03:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548H3M6j022695
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:03:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 13:03:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:03:21 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H35du015862;
	Thu, 8 May 2025 13:03:07 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v7 01/12] iio: adc: ad7768-1: reorganize driver headers
Date: Thu, 8 May 2025 14:03:04 -0300
Message-ID: <1f7677d31a0165cb30d7eb3b4d613e1337937f9a.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ce3db cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=hyw8zsYP-pVXasy_sKEA:9
X-Proofpoint-GUID: pfZypD94Ri7p9AEVVOv93fgQCUQ6_WAA
X-Proofpoint-ORIG-GUID: pfZypD94Ri7p9AEVVOv93fgQCUQ6_WAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXytbYS8ufM41p
 eyyFrEkIIT5N1vQx7UdOD6x51KQDEirk9hQfdsMQyIJW1NYHW+PWsF6PiBI++EPUxktG5KJCfyX
 v84dcwa08yRHZc5iyZK+qwQVR/yEOMTrhl7AcaTZc671SRZVV0gPBH9uxMdEm38CGib3GLd+U2m
 agwFiJf9jAL8C75qJikVwkQILCjx0mUXSuSWfayT4ozbi8jGMnNwiQuxZk5PyP6ETR5o3gEB+dI
 qDQOxGvndii9ETNjdVaszzZJGIlsT4XsxzTkImOpickIEpO+iZZfcrmLMiC5DTXpOAfYHHp3uL+
 65yPbB1PjJK45z5wI1RXnYVeDB5U0gBwGYcgRBRoOOvqk+7DWOVGEA53naPphVOf02215xbfDNX
 pe9hx2wJOlkD+3uUQdFmfCFHOw2COrQtn1QB1OOFjwffT+aECAutOqfGPECvJz7sl7a1waUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=585 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080149

Remove kernel.h since it adds a lot of unnecessary dependencies.
Add specific headers to ensure all functions and macros used in the driver
are directly declared.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v7 Changes:
* New patch.
---
 drivers/iio/adc/ad7768-1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 09e4ab76e2b6..e90bb5d50076 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -4,13 +4,15 @@
  *
  * Copyright 2017 Analog Devices Inc.
  */
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
-#include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-- 
2.34.1


