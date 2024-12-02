Return-Path: <linux-iio+bounces-12945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FC9E0672
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84007B648DE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E372036F9;
	Mon,  2 Dec 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O37WTV8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D40200120;
	Mon,  2 Dec 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148425; cv=none; b=m1y8/ieALSXZtCxH6iJ3WEvsycRNIxr+z33/kZDEXzVfFAmLlVPzMKxdLhNLHdNuKMAHdFVGoV4WYtFCx09JJmk65wyMkIZZdxnkF0eloyPlFwqZ0aV7qd0a50teRYzU98DSS0ZmkD+r0RczqrLuLp89EwkTOTPsFvgki9J8nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148425; c=relaxed/simple;
	bh=s68fhXtv4SDe3s9WJ30vyDnx8709f0wsijzyrUzUAiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VXlg9fA5Irr1VRsjDMtQ/4J60BmphXWxOGnFlmru3F9prvM0pdYGj8gws7yt4IW36JPfYnMrKiR9VDcz2YcMBS6nqBVfRWwLph869JLLfwzV9x0EgSk8Thw7KFA6H74LmxCo5dAluGEqSIrw9IVmwebD2Xe5KflBRj9Mr4PCRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O37WTV8J; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29ZdpK026837;
	Mon, 2 Dec 2024 09:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dLJMfRPTkUeuH9HnRZTFwgP3FIo
	YPAnFEFpO4kHk7LM=; b=O37WTV8JYkhZTtQxCJMyXPLA4rsUCMhUOMBnF3uIcs5
	UJCew5hUReGfYQ1TWQPSwqw/3rt6eyrEBbUmKxaaYpFkSiE/K2MiVD2APu1sUfQ/
	Ry5s3bSPPlRfnCVY5et7bxwFzYHOnU/h1ZCAy3euduVnBn1YYVPXBA1wvvVxKBxK
	RqPg5XNsEAs4V1U4zuay/dyvWMbuQ3mvHkFuI6LSvvhtGWiUqJttRUdIu8Aji8eK
	QWNvN85bBKThzkgdJaHINuXvEjTPwjnSmjiX4x9mJG28pO3kP8kwPoze4rITut8Z
	alCD0oGS9yqRcktlEqGuDPR5R/jhZAEkd2Jkk/BJClQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4380g6g31d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:06:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B2E6f8r006580
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 09:06:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:06:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:06:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Dec 2024 09:06:40 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B2E6SRn027750;
	Mon, 2 Dec 2024 09:06:31 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 0/4] Timestamp and PulSAR support for ad4000
Date: Mon, 2 Dec 2024 11:06:27 -0300
Message-ID: <cover.1733147443.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: ki0jd1Fkw_D__ImU3YgqOQ-AMPtQwSLD
X-Proofpoint-ORIG-GUID: ki0jd1Fkw_D__ImU3YgqOQ-AMPtQwSLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020122

Complement the ad4000 driver with a timestamp channel, a minor adjust in
transfer timing, and support for single-channel PulSAR devices.

Change log v5 -> v6
[IIO]
- Added commas at the end of channel lists in macros.
[Device tree]
- Made compatible property doc similar to other ADC dt-bindings.

Change log v4 -> v5
[IIO]
- No changes.
[Device tree]
- Added const items for fallback compatibles.

Change log v3 -> v4
[IIO]
- No changes.
[Device tree]
- Sorted compatible strings in alphabetical order.
- Left only fallback compatibles in allOf check list for adi,sdi-pin property.
- Improved patch description with explanation about how the AD4000 and PulSAR
  devices are different.

Change log v2 -> v3
[IIO]
- Reverted to direct assignment of ad4000_time_spec structs.
[Device tree]
- Moved ADAQ compatible strings to last compatible enum.

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

Link to v5: https://lore.kernel.org/linux-iio/cover.1732885470.git.marcelo.schmitt@analog.com/
Link to v4: https://lore.kernel.org/linux-iio/cover.1732660478.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1732020224.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1731953012.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1731626099.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (4):
  dt-bindings: iio: adc: adi,ad4000: Add PulSAR
  iio: adc: ad4000: Add timestamp channel
  iio: adc: ad4000: Use device specific timing for SPI transfers
  iio: adc: ad4000: Add support for PulSAR devices

 .../bindings/iio/adc/adi,ad4000.yaml          |  75 ++++-
 drivers/iio/adc/ad4000.c                      | 311 +++++++++++++++---
 2 files changed, 322 insertions(+), 64 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.45.2


