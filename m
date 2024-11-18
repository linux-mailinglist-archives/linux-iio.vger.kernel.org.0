Return-Path: <linux-iio+bounces-12384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275879D1870
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64871F234F0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219011E0E01;
	Mon, 18 Nov 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k2p/+hdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BF13B2B6;
	Mon, 18 Nov 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955978; cv=none; b=fkZ3+Nd7UlAjAghPOqYuV3exLgbDNSHHTVU0qn3i0rdrUyK9D3FBnP5wRoahxlPLsQ2Qncd4pd1owA2LjymDbbCXAOb8jNY+ZiNINF6kSJVIUdGZbndOkIjfckMeVM2NmyFKyGsFeox2ZxRV18IrWvDonGKGAcJMH0f/YHx67qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955978; c=relaxed/simple;
	bh=duQEEAotLV70IcoaFr6dprg84mehbNkygqcuBqEuhbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Et408yMW4elrtmqHs2YugecuDvqMKrI6PsgMqiVIGXHyi0D3ReA0lMFhIMFUfdPCTWoZj8FiDeGqC53C+q+2ly9TMgc2V5RB0BzGg5SQQ3cbMr1Uk6+rjDxc372xPUNTgitHmzYo1+qBq6igLdTfk1wBS0/t18rx4qjCEgcRS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k2p/+hdl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIEnmB2032633;
	Mon, 18 Nov 2024 13:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xZI9NoipKXj9iBM6ba0DgdRdeoz
	7eS6G6DeJM34c7PY=; b=k2p/+hdl0ZE6RmdEAddXQzN6DFN41H0KgVQMVw/DhOe
	VPUVzQkKEzR+N+8Dk5EMm2OZF1F3HGuA0ng60eTuvEEhqqEvApfzZsfU5boHAkXh
	Tj80v96yb9LpwD5QLg2Sz0RY2spPAqUzOwZ+7HbHTMLFE4bIWHV+ra3dhe3taJEv
	dCuE5P133qIjMBX4bVNOjAuFkpbg9C26BN305riG3IDrr+uClABo+MaY8znpizfP
	myGdW48OJ7GGp8bJz6bVdWzVODdTUaRrHphnQLpEWfY+51VBKPnhS5xYoCi8PjD/
	59F65GWnjXmnSYYaZ3M4DK1fRAwL7GI0X1CEL1WjYpA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42xs65gea4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 13:52:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AIIqSuK063928
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 13:52:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 18 Nov
 2024 13:52:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 18 Nov 2024 13:52:28 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AIIqF3v010365;
	Mon, 18 Nov 2024 13:52:17 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Timestamp and PulSAR support for ad4000
Date: Mon, 18 Nov 2024 15:52:11 -0300
Message-ID: <cover.1731953012.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: 548YzUTbNVQ3f_Ka9LSBLwWrGjwjs7-J
X-Proofpoint-ORIG-GUID: 548YzUTbNVQ3f_Ka9LSBLwWrGjwjs7-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411180155

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

This series was tested with ADAQ4003, AD7687, and AD7691 on CoraZ7 board.

Link to v1: https://lore.kernel.org/linux-iio/cover.1731626099.git.marcelo.schmitt@analog.com/

Change log v1 -> v2
- Added Suggested-by and Reviewed-by tags.
[IIO]
- Commented the removal of unused AD4000_TQUIET1_NS define in commit body.
- Made a common macro to assign ad4000_time_spec.
- Explicitly initialized PulSAR t_quiet2_ns with 0 as those don't need any quiet time.
- Improved PulSAR support commit description with more context.
- Dropped support for AD7694.
[Device tree]
- Made "cs" the default adi,sdi-pin value for PulSAR devices.

Additional comments in patch number 1.

Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          |  71 +++++
 drivers/iio/adc/ad4000.c                      | 290 +++++++++++++++---
 2 files changed, 310 insertions(+), 51 deletions(-)


base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
-- 
2.45.2


