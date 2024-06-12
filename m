Return-Path: <linux-iio+bounces-6211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3969054EB
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862981F23A75
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FE17E917;
	Wed, 12 Jun 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ipaHLEME"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505917E911
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201853; cv=none; b=Ln0D/vZ3TgEZ/w9x7T7iFaEuIODhzhsXA6wqsBteDkPQm2daEn97Q41+G3DoJfhh3OcrBfhP1BfdR6FqIU/V3hjn0VpiOjlSSiwV5h7LSnvN6PC1Yklu5L2InYVNd6xjaIgPO0RFqMrlJFKl30TXmYNy0AxCf3BqThLeBqM/8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201853; c=relaxed/simple;
	bh=rJ9CSAjJLlNTkYw0JG9XucENY69uBWTVqCdZBi4Dozc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=E41wFkNX9MpLiAR2IugG6er0o69tLfFWg/TzZNO02D2v2831iqrX3Jk7jkmxIzKizkBqXOvZBagelsml5c9FOznmChEG0NJlYkcU2SzxcjxhQMpZp6zct7gwYfmWNINzPFMLCD3K0h05+/xbKr4zrmYYRp/lp5fxAmFGyJrt4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ipaHLEME; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CBAJqR001970;
	Wed, 12 Jun 2024 10:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TGVCyyd7c1K/eIGtCxFazNL/Ang
	BMnXbfLZWyLHJA2g=; b=ipaHLEMEozBYgPkKBNE4Mv4BwjKJb1B7zfZbIELaNXr
	Eu7x0RCkve0JTayVEjF1GRTluEXFVwCXKCPvvc8U2gsDRnEpDFMButYlJ/eJjDHx
	8brTdhAyGDdROjgLkBEE7mdUMmKOUeKO2T4mK5WbZJuq91FtXOoYHpqpmuPPc+c2
	agm681utae9V84MEJ6WSR7JMgqyzm5Q9ZBpZc351UrvRvJNdCFlcRQSIQv1n3K7C
	WlaxlCRZHcXwOu0kXE8hYLtj+vIGaXToJaZ9wjuZRPX19W5XFlPotYrC8mYqXJE5
	5NyTPvMOf716Uq27HSzNOfsLz56VvUXTnr+9o9b1s7A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ymm727k42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:17:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45CEHHAd053077
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:17:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 10:17:16 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CEH4Au027005;
	Wed, 12 Jun 2024 10:17:06 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH RFC 0/3] iio: add helpers and accessors for active channels
 and masklength
Date: Wed, 12 Jun 2024 16:20:47 +0200
Message-ID: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL+uaWYC/x3MsQqAIBCA4VeJmztQCZHWoAdojQbRs24x0ZAge
 vek8Rv+/4FCmanA2D2QqXLhMzbIvgN32LgTsm8GJdQgtFToqSLzicXZiClztReh0WGwInhlTIC
 WpkyB73+7wjJPsL3vB8IGdwdrAAAA
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718202053; l=1496;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rJ9CSAjJLlNTkYw0JG9XucENY69uBWTVqCdZBi4Dozc=;
 b=7LrSiV4IzplZA3Cj70BRbEkH0y6jZKKUSxAcTTv6lWPxr0dUjl0NgI0FGrSdwPhS7PxnQ2CfQ
 /ZeFCoROqofDMXpXxU5oOAudRVSPQvQmGqu6HpocdSqv0Z8jATA+UXR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Nz_8Z8FQugx-j8WbiOKdGBLOoz0zz_ix
X-Proofpoint-GUID: Nz_8Z8FQugx-j8WbiOKdGBLOoz0zz_ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=712
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120101

Hi Jonathan,

In [1], you suggested for an iterator for the active channels (so driver
don't directly access masklength). This RFC showcases that iterator and
goes one step further by giving an accessors for masklength so that
drivers can read that variable (we have drivers doing that). The
accessors uses ACCESS_PRIVATE() so it will warn us if some driver
directly access the variable making it more difficult to mess with it
(like changing it's value) without being noticed during review (or the
auto builders).

Anyways, before jumping in changing all the drivers using this, I guess
the questions are:

1) Is the iterator useful enough to add one (kind of like it and save a
line of code :))?
2) Do we care about going with the work of marking masklength private? 

If we go ahead the plan would be:

1) Add the helpers macros;
2) Convert all drivers that directly access 'masklength';
3) Annotate it as private.

[1]: https://lore.kernel.org/linux-iio/20240428142343.5067c898@jic23-huawei/

---
Nuno Sa (3):
      iio: core: add new helper to iterate active channels
      iio: imu: adis16475: make use of iio_for_each_active_channel()
      iio: core annotate masklength as private

 drivers/iio/imu/adis16475.c | 3 +--
 include/linux/iio/iio.h     | 8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: cc1ce839526a65620778617da0b022bd88e8a139
change-id: 20240612-dev-iio-scan-private-86f4a0fd288f
--

Thanks!
- Nuno Sá


