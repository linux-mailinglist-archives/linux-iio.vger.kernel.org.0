Return-Path: <linux-iio+bounces-3222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C986CC5C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642421F21693
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6A1384AC;
	Thu, 29 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0p5sL3Uh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7B1353EF
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219261; cv=none; b=JMH3N/ispTIbT9qtopF6u69M9TQNeEPuqkgEaVh2zK+6UxBTdWdyOujhupvAexhAalmpG/SQF2MvYriccEfdm9i5J/r9EItOYLlaJAYqPkqNs8afS/J8brTwG9RfgA+2BDqOCl91krtnqV9ufaxj/ps5GwNGJ/vu5ix4c7RQ9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219261; c=relaxed/simple;
	bh=edxtdysQlwyEg8QjGKDFMQMTJcp5GxiXQZRrezckhS0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bL8hgEl6G/sEYmVX/L0WaoXo3nNexjud0toY6s/H+uhC8NRGV37XvBYFazydVgJX9ln8m2wjZPKoNb7HhkA3RVvxba4x/wqkkvWGk+x2mf7N2gRoTlqp5/5pORbf7hClfzITxq4dLCcMQ0vdR0cWWrv4jHcFqKPzUEm3+sWuWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0p5sL3Uh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TE4aQm006825;
	Thu, 29 Feb 2024 10:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=CNiByRZaOLU4qEXj2eH
	t1Byx/1oI+A12l/YfEbir3Dk=; b=0p5sL3Uh6NawEiIuXa3KNt3gFr0Lra1Lnw5
	krvFwuNxMno2OChXwKiPlKSDygm4SSONWlDN2ETasCoYpbEiG/OcIVy0VxyQr92/
	UZhLgaDa7bb2YJW03gok2+EjcgHhk6raKb6Vi+o9gf4PD+uO64KQH4ZUURIvZtSn
	RLkOE29rlAqKJKsl2LyPzOgYjkF/Q5HrDKN5cfSPv5tEBWaQt7mgxPbrb3CJAlzv
	LGysoYsZHFKj8luVUgLuqdHpaYpYZJDxFox37bpuYgn30KaW0GwLfhKdh/24Dx7M
	+3WWvfphqDuqcDPPuvYJEU7UjXhp6AjK7immzDf6AosANf64eEA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wjp9qhdan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:07:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TF7BPw023025
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 10:07:11 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 10:07:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 10:07:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 10:07:10 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TF73ti015938;
	Thu, 29 Feb 2024 10:07:06 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 0/4] iio: move IIO to the cleanup.h magic
Date: Thu, 29 Feb 2024 16:10:24 +0100
Message-ID: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGCe4GUC/4WNQQ6CMBBFr0Jm7ZjaNoquuIdhUcoUJoGWtEI0p
 He3cgGX7yX//R0SRaYEj2qHSBsnDr6AOlVgR+MHQu4LgxRSCykVMgdcE6GdyPh1wdkMbPFOjlQ
 njLipHsp2ieT4fXSfbeGR0yvEz3GzyZ/9V9wkCnTXTte6thendGO8mcJwtmGGNuf8BbQ+K8+7A
 AAA
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709219428; l=2117;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=edxtdysQlwyEg8QjGKDFMQMTJcp5GxiXQZRrezckhS0=;
 b=+8fnaLQzjal+Me4V1U65J0U+dmdNzvXvReyPXRk7FMSqieoFSIsJuISLnLHSdYAjgpefqb8Yp
 426dOd0PZYPCcU2re4ZZ2v/r8UgAfUdwYufOYm3Hm1BoGpCg9qCopFI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: spyOYXVJHyx0iSP0VUwV6xY0Rv1pKQEQ
X-Proofpoint-ORIG-GUID: spyOYXVJHyx0iSP0VUwV6xY0Rv1pKQEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=965 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290115

Hi,

In v3, I decided to drop the scope_guard_cond() usage (which meant
dropping the event patch). Given the discussion on the cond_guard()
patches, I think it's better to hold those conversions a bit
since Linus came with a suggestion that will potentially change
scope_guard_cond() - and for the better IMO.

Another significant change is the __free(kfree) in all allocations in
inkern.c. I have to admit that I'm not a fan of the in place declaration
(too much time looking at kernel code I guess) but it makes the style
more consistent (as we are doing the automatic cleanup in the locks).  

v1:
 * https://lore.kernel.org/all/20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com/

v2:
 * https://lore.kernel.org/r/20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com

v3:
 - Patch 1:
  * Do not use scope_guard_cond();
  * Directly return -ENODEV and don't initialize ret.
 - Patch 2:
  * Removed bonus space;
  * Used the normal error check flow in iio_trigger_get_irq().
 - Patch 3:
  * Refactored the state and ret conditions in iio_scan_mask_query();
  * Removed ternary operator check in enable_store().
 - Patch 4:
  * Still use goto at the error patch in iio_map_array_unregister_locked();
  * Used __free(kfree) + return_ptr() in places where allocations are
    done;
  * Keep the else branch in iio_read_channel_processed_scale();
  * Removed the comment in iio_channel_read_min().
  

---
Nuno Sa (4):
      iio: core: move to cleanup.h magic
      iio: trigger: move to the cleanup.h magic
      iio: buffer: iio: core: move to the cleanup.h magic
      iio: inkern: move to the cleanup.h magic

 drivers/iio/industrialio-buffer.c  | 122 +++++++-----------
 drivers/iio/industrialio-core.c    |  34 ++---
 drivers/iio/industrialio-trigger.c |  71 +++++------
 drivers/iio/inkern.c               | 255 +++++++++++++------------------------
 4 files changed, 176 insertions(+), 306 deletions(-)
---
base-commit: 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1
change-id: 20240223-iio-use-cleanup-magic-9efe3b0a073d
--

Thanks!
- Nuno Sá


