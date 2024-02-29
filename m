Return-Path: <linux-iio+bounces-3231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FF86CEBC
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 17:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B591F21727
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9B14BD48;
	Thu, 29 Feb 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AHvaALBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7516064F;
	Thu, 29 Feb 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222929; cv=none; b=n9e9NDTkxC8yQy7MMM5GpbQcslKLDwQ3/CJs+e7k0vo0sCaCNvY1D1Vi7ADw7nrRTOExi3bhDUP+dQ+mRUZhCmecEdbJkqaHm8Hwf37/o02oCPrLkt1Cw8Do7auL9QLjmVcdq3bL4gtfmpJ+U5ikCruIcQcNbL1P9vUEl4Jk4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222929; c=relaxed/simple;
	bh=oaktaKMbj10udadErg2CCSUoOJnIEdKQagngqtobDLE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=i7xBKyLTBt3tVMGHu8V1AyX0gMWiMtZCFns5rLcJrEQiDIBNiSDY2JF9WyfEJTrUCQNRfp8YXht3tuZ2VRVfuo0UtarU70hnM9FKH651r8MSxvdjGcwkqlVttBggWomGbzrD1lEiM/qn0DdNpLJU9923fofiEbsGqOHbcoRAnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AHvaALBu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TDrYhH007944;
	Thu, 29 Feb 2024 11:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=f3r9mNAR6m5ZaeOeSLF
	4aV/9wUVWMr/fe5XhV9/nvps=; b=AHvaALBuSXJFlmDpHwmIokEkRf9xG8McGqL
	HDb+acf9kWIkG+pHcs8+pybGPEfxHHfG2jLVC8sNk1BirkAwEi18pmb5NM1S8A31
	VqBtfNOhVWXnaDUv88grrtwP8+l8SYYmNburYvCgCMuSMSVlaTThorxwA+ZI2PaK
	qM9hhwAFUvZUu5wYwWIOmFH/IWIBTg9JzK8jVxbrqqgW3fTNYJKI+3CPLu5gek/6
	RSEHdKe14XnBkxWxKt4D6MeSM5TP9b/GDlXogMDKSJNUftmMQ0suGiUIkCX9Vu/+
	FonqpfV0R0pW/VpKCeKnaTAbhBCPPHMlRG7HkYULxHPNXJEdHHA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wjcr2utnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:08:30 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41TG8TWa034081
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:08:29 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:08:28 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TG8J9E018856;
	Thu, 29 Feb 2024 11:08:21 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 0/3] iio: temperature: ltc2983: small improvements
Date: Thu, 29 Feb 2024 17:11:40 +0100
Message-ID: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALys4GUC/32NQQqDMBBFryKz7hQdLdGuvEdxEcZRB9RIIqFFv
 HtTD9Dle/DfPyCIVwnwzA7wEjWoWxPQLQOe7DoKap8YKKcqJyKcd6amLnHRwKjL5l3Ego01tbA
 05QBpuXkZ9H1VX13iScPu/Oc6icXP/u/FAnPkwfRV9TDS1Nza1c5uvLNboDvP8wuqPDHhtwAAA
 A==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223103; l=1175;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oaktaKMbj10udadErg2CCSUoOJnIEdKQagngqtobDLE=;
 b=f0dvGL5T5tvHRKsxofekbrSdVK+HjnPmvQqN/Q6W6jOgbWNkua4zzLlSrZkUN/kKUjJeRbiDL
 DFbOdieB5yCC8/7/dNUDHl3E5eJF87i3XAT7wA+oO0RfaTA2ET55VQE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VjfxjmJGzl18CsHV4Rqrg8uJs8oui4BL
X-Proofpoint-ORIG-GUID: VjfxjmJGzl18CsHV4Rqrg8uJs8oui4BL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=720 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290124

This series adds small improvements to the driver. There's no functional
change intended for it.

For now, I'm using a macro (only for this driver) for handling error
pointers. I can propose something generic if that's preferred.

---
Changes in v2:
- Patch 1
  * Rebased on top of [1];
  * Added helper macro for returning error pointers with dev_err_probe();
  * Fixed some unnecessary line breaks.
- Patch 2
  * Make vdd-supply required.
- Link to v1: https://lore.kernel.org/r/20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com

[1]: https://lore.kernel.org/all/20240226193007.670a6406@jic23-huawei/

---
Nuno Sa (3):
      iio: temperature: ltc2983: convert to dev_err_probe()
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator

 .../bindings/iio/temperature/adi,ltc2983.yaml      |   3 +
 drivers/iio/temperature/ltc2983.c                  | 267 ++++++++++-----------
 2 files changed, 130 insertions(+), 140 deletions(-)
---
base-commit: 74744b27ba8cb8c265263aa0ff0693350a8cbc19
change-id: 20240222-ltc2983-misc-improv-1c7a78ece93f
--

Thanks!
- Nuno Sá


