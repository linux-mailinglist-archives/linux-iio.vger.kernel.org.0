Return-Path: <linux-iio+bounces-11983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B29C078C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47321F21706
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B951212F0F;
	Thu,  7 Nov 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ni6taHqX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6ED212F03;
	Thu,  7 Nov 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986306; cv=none; b=TkbmvdIJxfZ5t+EH4zf1tbWSPnYHP930c+1sj8C2448MPB0uDy+cagqWmBPQTVZ1FWGFcGwNTPiBAGCsl2B4/TXxmun7syePylff9T2flljrasitkDYnkMxKWtBTNnscrr3EZOvEtoEWitAK/3ZC+0SZueTfMj5RDlLslmBZtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986306; c=relaxed/simple;
	bh=O4Ly+TUbcNgizUM1IEqHG6sZzsVmPfKjoOUUN/qY6OU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/8CQouaBs2ah26gvH+Fec5EWpfqIw7IIJM9s92mFCwRQdo55k3ilusUEaJUvtNYEdHNhxWd0U71gC6DyDVZCPiMgJuJTxzAnocuP9P9t89jpfntYMgpcK6273YIJHRRM2/Mg6QE50A9b3IWG/06KN6UleVw+TD3v9b9HGfL3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ni6taHqX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DH96r005049;
	Thu, 7 Nov 2024 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dQpYsJYMGMBaCtPWFQEdS4VtUyv
	uxNAP5yuT99fgGKs=; b=ni6taHqX7Bw0dtal2mrYy6giiWs6ZaacLzdUoS1d6Xk
	i/e5Tg89fGBcSS4Ei/I4FsJc+qtWxYVlJ5kQvnWg4TZrQ+0TBBsFDyS9VK7nmLEP
	6s3N1y0NdrAitBR8qDjycbpBNI2GxEbn96xZWogh9ysFWD87+AZajRr0c4Bz2Fdd
	8B9an8NeTFDwUCL281uqYX6bg7HF8YU6KJwR5JQ1piWSzUEqgAcmK6QWUQHVKDrX
	k/y+FZQLXKBmHgvTFpDve2jj0ZMTpZalrWSIrzQTPFscaP3QfusjM7lcMNeGW9vi
	PDytharrL02fBQPdMOFFpnTStrwroWxJ7mhKnPUBEXw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42rsdks7u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:31:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A7DVe36034819
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 08:31:40 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Nov 2024 08:31:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Nov 2024 08:31:40 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A7DVUGq019172;
	Thu, 7 Nov 2024 08:31:32 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <darius.berghe@analog.com>
Subject: [PATCH v2 0/3] iio: imu: add devices to adis16480 driver
Date: Thu, 7 Nov 2024 15:45:14 +0200
Message-ID: <20241107134517.3089112-1-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9U0tJdebFaLj8DpJ0aeVvT0QEAxdarBj
X-Proofpoint-ORIG-GUID: 9U0tJdebFaLj8DpJ0aeVvT0QEAxdarBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070105

Thanks for the review and input Jonathan, I've addressed the 2 points
you raised in V1, here's the breakdown.

Changes in v2:
 - document in the commit description the main differences between 
   the newly added and the already supported devices
 - make adis16487 fallback compatible with adis16485 since they are
   functionally equivalent

Darius Berghe (3):
  iio: imu: adis16480: add devices to adis16480 driver
  iio: imu: adis16480: add devices to adis16480 - docs
  dt-bindings: iio: adis16480: add devices to adis16480

 .../bindings/iio/imu/adi,adis16480.yaml       |  5 ++
 Documentation/iio/adis16480.rst               |  3 +
 drivers/iio/imu/adis16480.c                   | 75 +++++++++++++++++++
 3 files changed, 83 insertions(+)

-- 
2.46.1


