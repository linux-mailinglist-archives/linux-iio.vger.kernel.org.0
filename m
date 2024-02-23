Return-Path: <linux-iio+bounces-2933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC08611B5
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A1B27141
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D37D40B;
	Fri, 23 Feb 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e55N5y7p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D126289
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692049; cv=none; b=G/ko/kCsdvSppXOAJV3PznhXSjPh6Jar5z78YeWBgBrJvax0KxT1H2n4dN8mu2aaf24nA5tZAXCiJv35ITVKTPrIgbn2qbuSeUVb04pL7z4G0Ein+5JroXIETCx59T7rOHl1s5HnAXf2YctEqw7voGeE1g9P0cENalM/uRXJJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692049; c=relaxed/simple;
	bh=hyK2Zop4chvP4PgnVgwN353iBnG43FpWNt8NviXhLYQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qgniw4ooeDVFvsOV5rYYOJKTGZKtTpbBOTraoirlAiMqGgQWFcYFoZ0UxkqBeO+4DopaV5KFfhg2YszVJNEiNQM2otqL/OA0xFcLN4Akl8FBZfMSXn7PZEGqVi9pbu5I4GHrfbl0wepGtMRG8EynuG6OJJi6pygd/xA1RjUc7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e55N5y7p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NCHeCS001091;
	Fri, 23 Feb 2024 07:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=hKywRBu0HeCDOlKvfMc
	XjmB4aYi807DZBJH7Kb+kmxw=; b=e55N5y7pCxTRoLwegFGc5o0g/2LGFUqVRnJ
	ynA4/UO1b8CznvAZoFORjg/VMawDpvI/zNq6pA19Y+es0s9yGCrjNb2B6dPshVSD
	Yb/EOZxpc9wz87yISFcArzh0zfqYbpXXeFlzrYadIl2NypnaTHVDI5BYGnBJf/v9
	KXR2dhlTG5D+aAjLBP8SnIlD/iMWDhffXQiFxYtgZzzPjwNShpThmQYX/ex37I8J
	M3i1pusbCl8MjgmNvFKeSsbs0j2pq104LITsb7OAJEIIVDnTzxg19+nmymHLDCDa
	TT33/LG48pSf5/7bjkskQhek+W/avwWmm4IC0DtQPpu0aoAfQCQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wep5mh725-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 07:40:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41NCeXVR035278
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 07:40:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:40:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 07:40:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 07:40:32 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NCeNLn000839;
	Fri, 23 Feb 2024 07:40:26 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 0/5] iio: move IIO to the cleanup.h magic
Date: Fri, 23 Feb 2024 13:43:43 +0100
Message-ID: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP+S2GUC/x3MwQpAQBRG4VfRXbs13VHiVWQxxo9bDM1ESt7dZ
 PktznkoISoStcVDEZcm3UOGlAX5xYUZrGM2iZHKiFhW3flMYL/ChfPgzc3qucEEOxhnajtSbo+
 ISe//2/Xv+wG2NlD9ZwAAAA==
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708692225; l=1025;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hyK2Zop4chvP4PgnVgwN353iBnG43FpWNt8NviXhLYQ=;
 b=FKBIamOPfY1blGZiPUGr5NWMLaFCB8h/UEazZmR3Xl1SUc9pDpcHP9LruVGT9Xn4OzWoCTUuw
 UNxXMfrOe6PDAtyZ64D58H4VHOBZEfNOf2LozWGgJQiZduADNqu/4ed
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TxR3kyTx7CWSRpYQxOzn7_b_dn_MREF8
X-Proofpoint-GUID: TxR3kyTx7CWSRpYQxOzn7_b_dn_MREF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=459 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230091

Hi,

Here is my second version of the series... For more info, look at v1
cover.

v1:
 * https://lore.kernel.org/all/20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com/

v2:
 - Patch 1:
  * Respect ret value from call to ioctl() handler.

---
Nuno Sa (5):
      iio: core: move to cleanup.h magic
      iio: events: move to the cleanup.h magic
      iio: trigger: move to the cleanup.h magic
      iio: buffer: iio: core: move to the cleanup.h magic
      iio: inkern: move to the cleanup.h magic

 drivers/iio/industrialio-buffer.c  | 105 +++++++----------
 drivers/iio/industrialio-core.c    |  48 +++-----
 drivers/iio/industrialio-event.c   |  42 +++----
 drivers/iio/industrialio-trigger.c |  64 +++++------
 drivers/iio/inkern.c               | 224 ++++++++++++-------------------------
 5 files changed, 171 insertions(+), 312 deletions(-)
---
base-commit: 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1
change-id: 20240223-iio-use-cleanup-magic-9efe3b0a073d
--

Thanks!
- Nuno Sá


