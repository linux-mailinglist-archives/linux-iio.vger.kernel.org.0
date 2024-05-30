Return-Path: <linux-iio+bounces-5486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF28D4876
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6184DB227C1
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FC6F30C;
	Thu, 30 May 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ck6Yt9J7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A596183962;
	Thu, 30 May 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061348; cv=none; b=jjUncfO6OGRvXAlnXghQS/UbUK7nXO/+hj0ZWfwWqzeXFWbN/HDeLd1GDhi5V8B3/NXJYat92muWMTG6pyZMLRf8ffHM8Ka0KXUar+zliVzWjGw+KeAPY8HqHAaWvwAvH+kkY4EmkF1Zy3SKuH6U26p/HdHW47YqOXRSPHdi3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061348; c=relaxed/simple;
	bh=wKVeJ7fnKd8NgFHLtf7JG/ayXhsMMo5mAdUL+9cYU7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zk7U7L97WMFy0OBM3xhXa1dkqEL1PiZax6bPW2v3dQswanFc4ywT0eMkvrTYEZACH1kqb/DdruNdDr6pgEc+L44FGPS+HM/HNjfvuTgGqWL+yTvqYG5NRziNOuXVY8KXnRZP+lJZiL9994NP0kW4U7f+/gkZkS33S9z9siDK0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ck6Yt9J7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U4Twj5005420;
	Thu, 30 May 2024 05:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=S92jPjeTNLSbmePD/QfgtR6nvo1
	nMlMgTlN0fWIXkno=; b=ck6Yt9J7l57Tezypk1LTLvHkdjtRdYpR5/9f0A2y1O1
	DjrbM5grjnk4RDafuxRze2y/6D4B303NvGQZQlpwYKxDq4SPNIJvLhqUHmEkyAb4
	mFP2gPDcN2/wGP1LbfotCqmzcat3l5aSRsK1BzBar/V3L4byVbCVc3VqADtsZf+j
	67v92Tgu62xj16ZzCAjO1luVpxy4d0soNS50iF4PuFlFNJm/OeJVQHO7N++5W1K7
	m9IobQvFyonSoVzvKvy2dOYHDQ2fLxHxzk2ndFs1+oghnReI42V2U6SyLbr5k+Tm
	Tb9emJYALej+u1bGSSvhr/JALTeSaEI5RIgwWsTndCA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yeddx200q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 05:28:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44U9SpVG054265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 05:28:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 05:28:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 05:28:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 30 May 2024 05:28:50 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44U9SdKb007810;
	Thu, 30 May 2024 05:28:42 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: frequency: adrf6780: rm clk provider include
Date: Thu, 30 May 2024 12:28:34 +0300
Message-ID: <20240530092835.36892-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 11PDa0Vonh-z80a56N4JX0SRcgys9VmT
X-Proofpoint-ORIG-GUID: 11PDa0Vonh-z80a56N4JX0SRcgys9VmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=898 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405300070

The driver has no clock provider implementation, therefore remove the
include.

Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index b4defb82f37e..3f46032c9275 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -9,7 +9,6 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/iio.h>
-- 
2.45.1


