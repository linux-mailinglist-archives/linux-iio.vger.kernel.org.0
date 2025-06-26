Return-Path: <linux-iio+bounces-20969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF2AE98A7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD36A3460
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553826FA57;
	Thu, 26 Jun 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ylEFn3fM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A3293C73;
	Thu, 26 Jun 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927169; cv=none; b=HzU1WFymtXBFh+39aWiBgoP+JnFbe/SQi12dkTBHYRozerFJtxrr6UktSWM4mhw2kFMnMciGn0zPuLzU1az8UJCtk3+3ErUEYPQ48oxVFsB7ruJc+rgoz0uaSPB3fNfTl5Li/f1teslt111nhV2ZuIT+oALtjRxetwGjoGHfP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927169; c=relaxed/simple;
	bh=A7+RksWCosDMfXa3WiqReDwm8+2xScSeYiyA7SzMcp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ezQzap803TdGyDN+Ui9N2CGeSvb17vKDhiP1VHS5k8pgDUAzgMrQPLYsFGBVFf1afSVsuC0ASFVxKjj1XIE98WoeKRQQ6dYl0CURwk7e8sjYeLW3FTAAexvZgC6oQwRpAc9t03ySW+EgY0UWkWFR6qGVToKiI9GRScBvSjoms3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ylEFn3fM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q7aVm5017387;
	Thu, 26 Jun 2025 04:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mHSl8lm99QbLWH5GwPP2ClA5GqL
	3D+s4iFS1autRTqg=; b=ylEFn3fMPXc9KmNGriOVnGAX/fn7oaM3v9qHoZPikzu
	ndBOv5/W/6pYFcTu5ioMGYZSV6EkNqsZdsp3e8YKD690jphk4cI7Lhjx+hEDXEjb
	rwZR4fgv3Nvm32v0HxbellJEeRMIIu/biUNSUw9YZ/AuaZXhCLtoKSmLbyuBOULH
	xGor5xflnZNHzOTaC6CInxLE2bp3Jn1vl4+jzZYCyBrB6hVe3oe5IkIBxNVKRWyK
	jKWk2pJVjJH23nNVQyzc8b/smadI55CfAkvh7yNLkbfi1WQH76Fc/fVihMp0mBuM
	JykxdOjZqwYtFtSS5xi2zgOJ40X5XKhL8FaBPU2+EtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47f43ajv2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 04:39:02 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q8YVG8020390;
	Thu, 26 Jun 2025 04:39:02 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47f43ajv2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 04:39:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55Q8d1jP051108
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Jun 2025 04:39:01 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Jun 2025 04:39:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Jun 2025 04:39:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Jun 2025 04:39:00 -0400
Received: from [10.0.2.15] (CAV-LOANB-L32.ad.analog.com [10.117.223.37])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55Q8ckwN026701;
	Thu, 26 Jun 2025 04:38:49 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 26 Jun 2025 16:38:12 +0800
Subject: [PATCH] iio: dac: ad3530r: Fix incorrect masking for channels 4-7
 in powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
X-B4-Tracking: v=1; b=H4sIAPMGXWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3aTS9Pi0zApdEwMTYzPDNKM0Q0sDJaDqgqJUoDDYpOjY2loAu36
 hYFkAAAA=
X-Change-ID: 20250626-bug_fix-404361f2f190
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750927126; l=1852;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=A7+RksWCosDMfXa3WiqReDwm8+2xScSeYiyA7SzMcp4=;
 b=RqpsHAxz9+C/m9/zFXgi887exYwjoDLcXy0RKOTGTzjvB/xWNXxnjKeId3Nqn0btoNHY+1out
 QVKDBelBgWGC+SrsMgUElmhbCiz0ILUkvAe/D9pQ9xtRIXTMEcbLXI0
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3MSBTYWx0ZWRfXzI+Wqh8Sqq5J
 KYwOHqmrfO3HrYFiflMNogLK5oeszuxhDARTtlai5hCSCrT8iHakKttI8ww9kIsamQSL8r5jUv8
 OGL29MmQxmxmOjLc/mq1sANQ5oFGcWF9AZtqKRjtHrkSxXBpVYSePku8lHs6EooBFWSXJWkT4eG
 5D4OFNnPp28xXK/opznLcxTUmJ/TCq3w3ITlOh2j1HLRnffzbeBfQJIjk+I19Jjbp7qaDniepi2
 XUuaPR83Xp4PHqbhxmnwmwR9TQqrvUIrRinaSk8MQVNhbafKZV+erglSAUQXTJR4zpnih4jbn5p
 58t08Mz9NAPgy6Zrv9i94mu2M6xnqhdRnpm/E6r84wVqvH+iq+bqdwzd0YdEVbr8AAI/pcnsRbo
 XJw+1ecXWA/NoQaUO8VRwu+/NeqpaHnFwuU3lHgkS60cBl1OYtqtuR87FUdAinloAD0XdcOh
X-Authority-Analysis: v=2.4 cv=PuGTbxM3 c=1 sm=1 tr=0 ts=685d0726 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=xb4M3_QqpVQfOyvDw98A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8T0QoJZ8m3RLRSsyeLNoBQHaiYEkIRD6
X-Proofpoint-GUID: tJrZDpLiWFvZF0WrAFKrEj_UC6642lpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260071

In the current implementation of ad3530r_set_dac_powerdown() function,
the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
the bitmask for the operating mode of a specific channel. However, this
macro does not account for channels 4-7, which map to the second
register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
a result, the bitmask is incorrectly calculated for these channels,
leading to improper configuration of the powerdown mode. Resolve this
issue by adjusting the channel index for channels 4-7 by subtracting 4
before applying the macro. This ensures that the correct bitmask is
generated for the second register.

Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index f9752a571aa53ca0d7e199ed6a78550358185bf9..6134613777b8e1d4516109b74e0b3b79edb1ae75 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -166,7 +166,9 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	      AD3530R_OUTPUT_OPERATING_MODE_0 :
 	      AD3530R_OUTPUT_OPERATING_MODE_1;
 	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
-	mask = AD3530R_OP_MODE_CHAN_MSK(chan->channel);
+	mask = chan->channel < AD3531R_MAX_CHANNELS ?
+	       AD3530R_OP_MODE_CHAN_MSK(chan->channel) :
+	       AD3530R_OP_MODE_CHAN_MSK(chan->channel - 4);
 	val = field_prep(mask, pdmode);
 
 	ret = regmap_update_bits(st->regmap, reg, mask, val);

---
base-commit: 0a2857e778599c2794dc89c40dc79ead631b34df
change-id: 20250626-bug_fix-404361f2f190

Best regards,
-- 
Kim Seer Paller <kimseer.paller@analog.com>


