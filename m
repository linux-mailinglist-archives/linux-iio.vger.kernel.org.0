Return-Path: <linux-iio+bounces-20372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC157AD43C3
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A6417CF8E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB4926560C;
	Tue, 10 Jun 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zkObtTk5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97517BD3;
	Tue, 10 Jun 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587487; cv=none; b=DCrMiliUQtT4cM7pxN/8EmDJLHBN93v/c1guDEh4iF0LW35kTAMw8Bj2jjreA4ozdQX6gue/QFjXg1cIdwQMxupGX1FbHeV1yjtEU6CVkJx7eDeArNzVNhW18xh16NjMmCuWr7Y4VEjCakswjOABA84O1j46pRkq5Vwq2lqZhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587487; c=relaxed/simple;
	bh=ZAEXPdMeYO8J6cW6q3eX2ifwtQb6905rr4b9a10ownI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj7s+qC8bE2rGVVvC1sTckXzS1M7wq9wneY+OXi0Csmlj1P75ApMvOiQ8OU0mm02lG0JEyj8L2aAPH8PWtzHzf89FFRtoykqIBlVKFEkGH8u2mc1a/1g68nqfBi811xalH90OYgcNoMl1OxWAuqCuT965yaOBeRiZtMLnLXFTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zkObtTk5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIC1ii012727;
	Tue, 10 Jun 2025 16:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iXi2KKLWPCYYSFHVwRvK/lhvXM9
	YyMHB1a/b653UoK8=; b=zkObtTk5+XKR9Sl54uEYFfLEr/dsonxgdUOQnMKx1g8
	F7ZKc0O7oL4ljph7K8MibZm+pYVqtn8YQupdtoKHpr1WvarIBRLS+SOYa1RI6RTH
	VWHPu0QhuScWO2rdiF9Am8cCQcwIHlr0P5Ya+awMRB3qZt6yaYRaq+2LFzyAgd1X
	Awc7vU/zJ8subZbjwP8k9X8yvSdcRo5UWxBCCfxIbnjU9xe1o8Bn0dVDEu/EyEza
	Lbuo/k5tbX/7ASg6nKOVWgxddKVC17vb2RzaC6vwGKuIW368DaBziUVZeS8/VK+D
	26zPeNm8SsxrO1flIZlBn+XbHax7wMZz2ii5w8NnvCg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbk5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:31:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKV4OO037587
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:31:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:31:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:31:04 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKUgsQ019861;
	Tue, 10 Jun 2025 16:30:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 00/11] iio: adc: Add support for AD4170 series of ADCs
Date: Tue, 10 Jun 2025 17:30:40 -0300
Message-ID: <cover.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: nBlzYEd8X1TX35dMOFjD1VoDxsn5k3_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX25nmBeTwGmWS
 CXmSHfH6fdgkP6BbxARAW/1OyCJ9AT46QrV8AIgE5Ub3mikUInbKq8uKUDHLH3gRVf+oQDSgHSV
 DgVUKXhjw42jTJJXd40ihZE3MO29TCSMhZzxTwZuOjGlsbjabmMmF3nNvWzJ7PmFtxUJYpfgJpm
 0dkZMjvanoL0MHPdt4nIcSA5Pkz+Gw4v8a6YQCDUg6JacjZeVCAS3jNqGOoW4y90kJaCdye/V0Y
 EXzgQnVFWml47Jmhukj8nIcQNcDns2329gWnuF5cLF3E+FP0qzhuGPsyG95mOMnJVvQZjMBeb1k
 5+/GcopxyDfsPSDp3fhSOD+O3FmH6Tz+RwPjX1mM3PU4VU45bDrgq8Aa8aHbPGp1hhlwM/WZvhP
 JptoE0tH23k2iUnY3kT2pmmadNhXb7fC/CF5qm9l2xfW5nZtNz07SP625dbwth08fJNWCgio
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=68489609 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=y9xVB-MOXfL2-Q0W-_0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nBlzYEd8X1TX35dMOFjD1VoDxsn5k3_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

Hello,

This is version 5 of AD4170 support patch set.
Not many changes from v4 to v5 and not waiting as long between the previous and
this new version so, keeping both change logs below.

Thank you to all reviewers.

This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for calibration scale.
Patch 4 adds support for calibration bias.
Patch 5 adds support for sample frequency along with filter type configuration.
Patch 6 adds support for buffered ADC reading.
Patch 7 adds clock provider support
Patch 8 adds GPIO controller support.
Patch 9 adds internal temperature sensor support.
Patch 10 adds support for external RTD and bridge circuit sensors.
Patch 11 adds timestamp channel


Change log v4 -> v5

[device tree changes]
- Dropped interrupt maxItems constraint.
- Spelled out RC acronym in reference-buffer description.
- Require to specify interrupt-names when using interrupts.
- Added interrupt-names to the examples.
- Made adi,excitation-pin properties identical to adi,ad4130.
- Removed interrupt-parent props from the examples.

[Basic driver patch]
- Dropped 'ret' variable set but not used, warned by 0-day test bot.
- Rephrased comment about static_assert to clarify the reason for it's usage.
- Added missing includes.
- Did a few minor code readability improvements, complying with review suggestions.

[Calibration scale/gain patch]
- Squeezed info_mask_separate additions to reduce change diff.

[External sensor patch]
- Tweaked commits/patches to reduce diff.
- Dropped unneeded local variable.

Change log v3 -> v4

[device tree changes]
- Dropped sensor-node and most of defs.
- Updated external sensor props to have similar name and type of adi,ad4130 ones.
- Added constraints for properties for related to external bridge sensor excitation.

[General IIO driver changes]
- Locked device mutex to ensure attribute read correctness on all archs
- Fixed typo unasigned -> unassigned

[Basic driver patch]
- Added previously missing #include <linux/cleanup.h>.
- Moved struct completion declaration to reduce commit diff.

[Calibration scale/gain patch]
[Calibration bias/offset patch]
- No longer restoring calib gain or calib offset on reg write fail.

[Digital filter and sample frequency config patch]
- Use scoped_guard to ensure correct lock release order in ad4170_set_filter_type().

[Buffer support patch]
- Fixed a bug in the filling of the IIO device buffer.

[CLOCK provider patch]
- Explicitly stated that clock divider (CLKDIV) control support is not provided.
- Skipped clock provider register if "#clock-cells" is not present.

[GPIO controller patch]
- Made AD4170 depend on GPIOLIB.

[External sensor patch]
- Update to string adi,sensor-type dt property.
- Adapted external sensor dt prop parsing to work with the updated version of those props.

[New patch - Add timestamp channel]


Link to v4: https://lore.kernel.org/linux-iio/cover.1748829860.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/


Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (10):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170: Add support for calibration gain
  iio: adc: ad4170: Add support for calibration bias
  iio: adc: ad4170: Add digital filter and sample frequency config
    support
  iio: adc: ad4170: Add support for buffered data capture
  iio: adc: ad4170: Add clock provider support
  iio: adc: ad4170: Add GPIO controller support
  iio: adc: ad4170: Add support for internal temperature sensor
  iio: adc: ad4170: Add support for weigh scale and RTD sensors
  iio: adc: ad4170: Add timestamp channel

 .../bindings/iio/adc/adi,ad4170.yaml          |  564 ++++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2975 +++++++++++++++++
 5 files changed, 3564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
-- 
2.47.2


