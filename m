Return-Path: <linux-iio+bounces-5881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FE8FDF6A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF6B1F26F69
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05213C3D7;
	Thu,  6 Jun 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fMxCHhGx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8933F7;
	Thu,  6 Jun 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658401; cv=none; b=m8YcKpHBWzGsxpvfhlDZR2ij0DdBxrNejVD75arRj9B1Phcq/hTvlonIwobZPoRGd6CVFe23YNsCFY4d91ey6fQm4KNJtiAa+2yKeVbqdktoBB1t44MnbeDwJEt19JFVdtWGkKIlV6mFSvJ0XqRHOGeBwzsl+yHDn84lQ7sUlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658401; c=relaxed/simple;
	bh=SYrjY4Gp1M1NLQKedqeAA9+ZY9LrnReRiJyhW9OGRa0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=B3Ho9kb+PPH00eBTgjNhJx2J51BZcgk2fkA2Si9n1M/7c0mslyrBx7UaiRznf+fvcG5eKgu5+yz1hdOmyF+bSnnBtgC8JJUOXyTw6NKcLn/+Tbh8YmjbqHG72i528it1+qeH01p14k4OtPla//SZKrIiKne+o2B4rEY2PYW3ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fMxCHhGx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4566Gbnh015061;
	Thu, 6 Jun 2024 03:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2lCZFL6Cth30wP2B5LlKy738IQh
	CEfTtOXwwIgO7iNA=; b=fMxCHhGxftHkun7ZWSgpJcW48VW1b1HzPf9ng2grRCv
	exldI6/C8uZrkh0IK7IHUh9Eb66Fgf6tkZ03fvpv1w/U1q7fla0L0LkVcHyZV6Cz
	jXhZodN8pVgtEQsLC+gYRzHTZlobwV+y7sb8cDOMJkPCyvIDfNHegnsHlCpV+8cx
	awK8GXRqXVc+Bw88uFavRKkOkp4/zOf6y4Dc2RE7W1d5kim1Zke5zCV1KesokAi5
	YCYTqpvbmKZdRvKScWL6FauAsOuyHvATYSqGW5ze4QUeGHLpMQDRotf1JMjKTDjs
	yRt1llXoCO9bdoJhjXvNgp5TtLidaMNIcgzOB8ka4VA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yj0hvgrfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:19:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4567JEo5046146
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:19:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Jun 2024 03:19:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Jun 2024 03:19:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Jun 2024 03:19:13 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4567ItBb025782;
	Thu, 6 Jun 2024 03:18:57 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 0/4] dev_printk: add dev_errp_probe() helper
Date: Thu, 6 Jun 2024 09:22:36 +0200
Message-ID: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALxjYWYC/4WNQQrCMBREr1L+2kiaVFtdeQ8pIU1+24Am4UeCU
 nJ3Yy8gsxjewMxskJAcJrg2GxBml1zwFeShAbNqvyBztjIILjpexSxmpq1V1RUSRRUpTMjOF+x
 PojNi4BJqORLO7r0P38fKq0uvQJ/9J7e/9O9kbhlnth1Q4tSjkfNNe/0Iy9GEJ4yllC/AkIkZv
 QAAAA==
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717658563; l=1389;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SYrjY4Gp1M1NLQKedqeAA9+ZY9LrnReRiJyhW9OGRa0=;
 b=FSAMnMH2L6+ARtptEg1KMkHGE6YENDXoY08t+huSBG6YoLdSzTiY7kSZY8cgVdH9/oXWJML1S
 GXkSvumjeugAp0oC5crkAML0QkEyzxQaYL+5mLCvJxRUvIodcgkwwYJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VuwNacJqQTpU5oyX6cqwzddlsOGvMx3O
X-Proofpoint-ORIG-GUID: VuwNacJqQTpU5oyX6cqwzddlsOGvMx3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=839
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060052

Main changes in v3 are Andy feedback on v2. Still note that I'm not
adding a new variant for dev_err_* that takes an error pointer and return
an int. I prefer to defer that if we really want such a variant.
Anyways, here it goes v3 log:

v1:
 * https://lore.kernel.org/all/20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com/

v2:
 * https://lore.kernel.org/all/20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com/ 

v3:
 * Patch 1:
   - Removed parenthesis around macros;

 * Patch 2:
   - Removed local struct device *dev helper;
   - Added missing \n to printk().

 * Patch 4:
   - Make sure to not double error code printing;
   - Added missing new line.

---
Nuno Sa (4):
      dev_printk: add new dev_err_probe() helpers
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: backend: make use of dev_err_cast_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

 drivers/iio/common/scmi_sensors/scmi_iio.c |  45 +++--
 drivers/iio/industrialio-backend.c         |   8 +-
 drivers/iio/temperature/ltc2983.c          | 260 +++++++++++++----------------
 include/linux/dev_printk.h                 |   8 +
 4 files changed, 143 insertions(+), 178 deletions(-)
---
base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
change-id: 20240404-dev-add_dev_errp_probe-69e7524c2803
--

Thanks!
- Nuno Sá


