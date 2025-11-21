Return-Path: <linux-iio+bounces-26355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF35C783B1
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B37F624037
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE8340D9D;
	Fri, 21 Nov 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mD1T1hRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6133F8B3;
	Fri, 21 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718663; cv=none; b=rXEeWDaGSygm0YdQMeiPIwgJ/zj5z01OUnBrloQYgIJkNlsetfqBLdbM0WY31zmu1Tz+L4+RsxWPmQaCQe7J1O9KBY/g8xi14zya3e/Xui8p5PqHwqlbT5bH3XTysw+VIY2grd87vwdqNWovgdtqa9QCJrBkW9u5V7xkXE6XNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718663; c=relaxed/simple;
	bh=ycMmnh6+TMrY1PRVU7f7zqv3uDis9skYdQK1JcHmi7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gg/zttSqQv0zeU2jFwN37Wgqerl/wb/exuiVvq8Ael710uxcOoQKy9YpMcyHsxJmrVlLLNuy5tmpz4GiNt3kk8jnjbMJqO9Z3fokyqR2rQYErcwUDNAN/2ULDScIJs+pyc5tpxzQqTmZZNC2RLrjXPrsXEi3jzIAwpkJcZOlogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mD1T1hRH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6KNQ02556812;
	Fri, 21 Nov 2025 04:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xvNnk5Lk5lO660MByK3uWH7XMxV
	xiZ8Pr7KpQuTkWyM=; b=mD1T1hRHQTgNa+WxSEse8CgNHDQX0r35nwM+pm2auPE
	oGhk+81ffXCnCGKGBea3j1e6K3yJ9SG/FiBGQ9Errq3dhifo88xgq+fqziupzaiz
	3Pv3g+8OdfcSA4ZB8ygd13PaKzIAkYgjJCTXhoTgr/CgOrPaVvDb425BMTSZdDlK
	698JsjfEda0X3+ellFNtIY2ztjMCIiKHRwe1IjIFilSNDJisaj1tJqIeVMZc3tpO
	w9BkQU2cFzUKZXVzoP4WN+OAq0P3TZ0qeXJv8XXwoSMEyjn1+Kj4bfVhEf0APjow
	d6+IFkJIxkDq4825uIRS3lgpQ51waFRJL4t5Sra3sNA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ajjqjrvfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 04:50:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AL9oqAx014723
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 04:50:52 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:50:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:50:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 04:50:51 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9ogKJ026860;
	Fri, 21 Nov 2025 04:50:44 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 0/2] iio: frequency: adf4377: add clock provider support
Date: Fri, 21 Nov 2025 09:50:25 +0000
Message-ID: <20251121095027.18304-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: db0BRdeatlAeMvNSOcn8mz7SWFKcC3ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NCBTYWx0ZWRfXwypZK7GRHYfi
 GOCeQNf4yhsAnatnv4+kQt6OwE936DaZ74FiWCB3n98JFxhxX6gSnajVsz9i8RMsqFRKgUxHJ6I
 2NDHGFIaboq4BOibqoDfobO6C2WQlZ5kR4qxu7bsv28K/YcvHgtbORocT3zDopTALbM7E7S3DiN
 Yyy8c8Qc77eq1yGrtwCQe7BQc4YJLmBuVBOc8ekizjspZ8yl/GO/oWtGZNxF/PWAjEzSx/yVX/H
 ez750wM4RySl0mfo8vzIMi8sQiLEILlhENsRyYQUP7VV0AYGksIjH5CS+Ltu2SaJJhTWoYhAOLR
 3vxbp8JYAoV9Xe2MXaIwzGPBMmrYDT+gavCCThER1/quLstj21GUNvbXnqbiSC3ltME5xoiW3tH
 ich8iJFThWA71FoL8ZSVjU2nh5rSwA==
X-Proofpoint-ORIG-GUID: db0BRdeatlAeMvNSOcn8mz7SWFKcC3ob
X-Authority-Analysis: v=2.4 cv=ffygCkQF c=1 sm=1 tr=0 ts=692035fd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xhyw43Vw4g2VkAmxKawA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210074

This series adds clock provider functionality to the ADF4377 frequency
synthesizer driver to address user requests for controlling output
frequencies from userspace.

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

Antoniu Miclaus (2):
  dt-bindings: iio: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
 drivers/iio/frequency/adf4377.c               | 131 +++++++++++++++++-
 2 files changed, 137 insertions(+), 2 deletions(-)

-- 
2.43.0


