Return-Path: <linux-iio+bounces-2342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1CD84F912
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74C9B2657B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA287603A;
	Fri,  9 Feb 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RryP75p7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852976043;
	Fri,  9 Feb 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494516; cv=none; b=VqzAwP3AG2UIfyCrlPW8iWlpB1cytlFE+TbFdx8Faq/9d0Ntj+ea44lJgwRONAg5riaQy6UfEKM0NXEQ1RZSEHugc0n1ty7gGgDZ1LKcQfwPXxt2VzV8pf+HCySdFN5p3Zt+ed4w/4PC8OX2rBqncDbwPTrKYxM/0Qd7OSYMZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494516; c=relaxed/simple;
	bh=fzrUzq+1TIcZ2ftYpaROIQU2CbA6YRB2Sr1GbqXsbI0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=r48RCHUnh0P/j4vSXI9XUwIBB3Jj9SqOlcMGac+vqqeVDlrZho7QtVLvQ1zDzuAW0vfN6VDnCDcx6JkhWjDPfgke9JBrW23ZzcDev2Yq7va7+PlnDE11z+uSkX4AD9bkA/3hHFOO/WkFW1E4ktha1wvxgpfovoLWXbPOOQYNN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RryP75p7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419E0am7013498;
	Fri, 9 Feb 2024 10:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=qYBDdrorHAEm2Gs7L8f
	DFHGkP8ufePj6T/OW+5O96G4=; b=RryP75p7cMuRCerGs4NWX414GqXwDcPtZqX
	1VMDB8lhAZKDDeciHtUW95K41ERt8ACXFwKEKHkOgNC1Vbj85X2TbSfxgjCqEIkc
	wN8L8ZKZW5eDJmDgZx2CHlc2dEumLfPuICCbBnRQVtoFKFMguWDSbC/AYA3H43PX
	3LBcnqwUdUNkhxyxJaBmKblclzEdzS6/86Fhis6gfFHAPnPYei5SeQkny8NtyNhP
	c03Ot4mu/6qkaUqC78QDFb4LCrUkTMPa6juPUeWq9AjFAwqvUZcHfDBlb57Oabx6
	HJBozFz2RSA8vhuY9qNduFVAoEnMxQUkXnwOjx9rhs8KD3LoZaw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423p91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:25:50 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPnOA047825
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:49 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:48 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ0013228;
	Fri, 9 Feb 2024 10:25:36 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v10 0/7] iio: add new backend framework
Date: Fri, 9 Feb 2024 16:28:50 +0100
Message-ID: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALNExmUC/6XPzUrEMBDA8VcpOW9kJh/TxJPvIR7yuRvUVlopy
 tJ3N10UGwpePM7A7z/Mlc1pKmlm992VTWkpcxmHOiCcOhYubjgnXmJdMAFCokDLSxm5d+E5DZE
 7GQM6cr3ThlXxNqVcPm65x6c6X8r8Pk6ft/qitu13R0DTWRQHbq1JFpXxZMWDG9zLeL4L4yvbQ
 ov+D6YfrABRtFhX7GMKLoJC59UB93vcvr9QxWislhSkdqAP2OywkC3uN+xzFpK8ISsP2P5iAdR
 iW3HMRBG1DQBwwAh73bcaofIcMBn09WfV8FP3lzJeiQwha8jUHF3X9QvezC9zTgIAAA==
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>, Rob Herring
	<robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=3698;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fzrUzq+1TIcZ2ftYpaROIQU2CbA6YRB2Sr1GbqXsbI0=;
 b=+kDmLPvUFDo5v39tmSjlxHV0QJtF+cbrtuqFCT72Jbiq3SR0M39nWbHdQ1gIgDcuZckhbdK6N
 nYJdB+XgQnBCWmV/E8ZjZHryIWXGyL63c7MZ2OyZb4JaPNXOxb24SvN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gaEdgAEfwkv1xsaLvy6VhLfVF1CZWBvD
X-Proofpoint-ORIG-GUID: gaEdgAEfwkv1xsaLvy6VhLfVF1CZWBvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=986 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090113

v1:
 https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff

v2:
 https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.com

v3:
 https://lore.kernel.org/linux-iio/20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com/

v4:
 https://lore.kernel.org/r/20231220-iio-backend-v4-0-998e9148b692@analog.com

v5:
 https://lore.kernel.org/r/20240112-iio-backend-v5-0-bdecad041ab4@analog.com

v6:
 https://lore.kernel.org/r/20240119-iio-backend-v6-0-189536c35a05@analog.com

v7
 https://lore.kernel.org/r/20240123-iio-backend-v7-0-1bff236b8693@analog.com

v8:
 https://lore.kernel.org/r/20240202-iio-backend-v8-0-f65ee8c8203d@analog.com

v9:
 https://lore.kernel.org/r/20240206-iio-backend-v9-0-df66d159c000@analog.com

Changes in v10:
 - Patch 5
   * Removed meaningless @ in function names;
   * Added ascii diagram for the typicaly HW setup (Andy request);
   * Add missing period;
   * Use of dev_err_probe() in APIs meant to be called during probe(). 
 - Patch 6
   * Removed unneeded blank line;
   * Fixed some English in the commit message.

Jonathan, the series is based on next-20240207 since it already includes
the io-channels fix Rob applied in his tree. I guess it should land in rc3 so
after you rebase, all patches should apply cleanly (if applying them of course
:)). Let me know if anything fails...

Keeping the block diagram  so we don't have to follow links
to check one of the typical setups.

                                           -------------------------------------------------------
 ------------------                        | -----------         ------------      -------  FPGA |
 |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
 | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
 |                |------------------------| -----------         ------------      -------       |
 ------------------                        -------------------------------------------------------

---
Nuno Sa (6):
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: update bindings for backend framework
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   8 +-
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   9 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad9467.c                           | 267 ++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 379 +++++--------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 418 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  72 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 14 files changed, 798 insertions(+), 453 deletions(-)
---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


