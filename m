Return-Path: <linux-iio+bounces-25019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CBBD1C8B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0FC53470C6
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A52E8B74;
	Mon, 13 Oct 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1mixQxW4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E8145B3E;
	Mon, 13 Oct 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340557; cv=none; b=O2PVMJ42C3KrAaCAUg08h7iOZgJA0SrkWO5mst1IOHImywlbKghJ0jQn9HUmsCHlWfSLAHY/cGU3Qp/wcQHNjornukEdoEOIa7P+NXC2L1SUyrz4f0X+IMi5/irP6uUWeSz3t2c5C5p46e6LQNEYGLTQok6IRAej0uxYan03TfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340557; c=relaxed/simple;
	bh=DYvr1GO7kzzjHoP8UxkcrdhLn2W23fzGr/OOMr2zIdg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qA34ZjPF48yQxWvJvQg/Lran3oMgCxO5+8oGV05Fehv+zGDduOw4LhFD686l5tFJnSZlX+XWMvFE6YDHaiwtGX/9SZ71aGZxey+J0tNITErX3jL66BrGiW0dbXTGcE7JiaAwdrf023Ud7N8tVU9+jNJkdL2NdvI5DmQLMX06CmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1mixQxW4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4wFop015805;
	Mon, 13 Oct 2025 03:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2Xa4RiJYrycTiMRTgY0RUpOcf5M
	KAB4bvBc2Bg1nACM=; b=1mixQxW4QGHbJp8C6qcYumMEiUzavm3169XWB8dn7iq
	ui7renZrBgDzEnbN+EKfEbCmKt56+L4Er8V0QWs2SOuTh95ai0smQPtHrKL1sP5R
	dJIYjoFgPUpK39AYuOyFLZx/U9BMfdmJFoZKgyk6yKO21BxP08mUkapz+o/H1V0A
	NbQUWDRJPH4e/Xz/ZEpl6OfNVDPdDJpxjJXcXVxyFgGo0bFTrnFMPPF8LWxHAcJ0
	j6t93lbZ2szMSfoDzsX/UzndS0k8XSSx/HVGKkhisXEOlNzdgS/S74UboraDbwFC
	zzCCzDbaKEBQZD/1IzHai02JZA6TaUykN7nfKK3ytAA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qh30gwyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:28:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59D7SwmK022859
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:28:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Oct
 2025 03:28:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:28:57 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZ6013800;
	Mon, 13 Oct 2025 03:28:45 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH 0/7] Add support for AD4062 device family
Date: Mon, 13 Oct 2025 09:27:58 +0200
Message-ID: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6p7GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3eKSxPTMvHTdxBQTAzMjXSODFAtL8xRj48QkMyWgpoKi1LTMCrC
 B0bG1tQDRuxDVYAAAAA==
X-Change-ID: 20251011-staging-ad4062-20d897d33ab6
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=3774;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=DYvr1GO7kzzjHoP8UxkcrdhLn2W23fzGr/OOMr2zIdg=;
 b=Vo1qL3rIqN6hdDTAaiPil39pd+1FzgxCFsdwks+FDuR3rPfxR8sI5VmukGnnUz1B8GRD7jJ6W
 9mbKQHZKVQsAptJWk3sFND/EthFfVV50OqD2tyU4BFpHjqFa0kM+Qux
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: G0xCSULcSaDWIUiEIDZC60ernmquK-dq
X-Proofpoint-GUID: G0xCSULcSaDWIUiEIDZC60ernmquK-dq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyOSBTYWx0ZWRfXzqvos8zxSJvF
 NbUi/v11jE/L+pbHqCFFKTrHmBZU3L9XllqJxAMJuZQL5+GqpjvVPJu6ZXo7AglFEAtIsDrypfc
 B4BcZtqazJOwBSsKnoSl2CoTStlTPmdKrGjfghY2ceb4+t1tDZiagrG/aN5E0V7aDeV9g+WmAF8
 wEUp3TUilUAXmSOuGK81r9PsJi4XF2bQFVhD+OFPMEE3ctZWWyPrQjfRjXbhiX4aDA2VWAVnt0A
 V0WcCkkPqW1O85inB7xykX3mzr3qO/iW0P20yWDC129Wu2AFhCEKlOMSxY417juzwMRMwbkHEb0
 bxQ1+4mAZtFbAMnGjdoQ/bosYRMx1q3I0XrEw46nXWrcnRCAuHU7me404r8SiCdtqKkRxWPeEE4
 xUF4EE0aJ3CCzakoEa8IsQUrZRInjg==
X-Authority-Analysis: v=2.4 cv=YscChoYX c=1 sm=1 tr=0 ts=68ecaa3b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=zGwB7JeYfGoqnz3m99MA:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22 a=d3PnA9EDa4IxuAV0gXij:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110029

The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
register (SAR) analog-to-digital converter (ADC).

The device uses a 2-wire I3C interface. The device simplifies acquisition
by providing 4-bytes in the register map, signal-extending the sample
reading accordingly.

The device has autonomous monitoring capabilities, that are exposed as
IIO events. Since register access requires leaving the monitoring state
and returning, any device access exits monitoring mode, disabling the
IIO event.

The device contains two optional outputs:

- gp0: ADC conversion ready signal on the falling edge.
       The user should either invert the signal or set the IRQ as falling edge.
- gp1: Threshold either event interrupt on the rising edge.

The devices utilizes PM to enter the low power mode.

The devices datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4060.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4062.pdf

The monitoring capabilities, I3C protocol, and multiple GPIOs were the
decision factor to have a standalone driver for this device family. The
device is expected to work with any I3C Bus. I tested the device with
with off-the-shelf I3C controllers STM32H7 (baremetal only) and the
open-source ADI I3C Controller (with Linux driver):
https://analogdevicesinc.github.io/hdl/library/i3c_controller/index.html
ADI I3C Controller lore:
https://lore.kernel.org/linux-i3c/175788312841.382502.16653824321627644225.b4-ty@bootlin.com/

The series is divided in 3 blocks, adding:
- The base driver.
- An software IIO trigger: captures samples continuously.
- IIO events support: exposes the device's threshold monitoring
  capability.

The device internal clock register is exposed twice, as
sampling_frequency and events/sampling_frequency, storing in distinct 
state variables, since the usage (burst averaging mode and monitor mode)
cannot be executed at the same time.

Non-implemented features:

- Averaging mode: Similar to burst averaging mode used in the
  oversampling, but requiring a sequence of CNV triggers for each
  conversion.
- Trigger mode: Similar to monitor mode used in the monitoring mode, but
  exits to configuration mode on event.

This device is almost identical to AD4052 family, but I decided to
submit the AD4062 before re-submitting AD4052 to better contextualize
the focus of the device family (high latency, medium-speed protocol,
low-power autonomous monitoring rather than high-throughput
acquisition).

Depending on the resolution of this driver, the AD4052 family may be
added to it, by splitting into ad4062_i3c.c, ad4062_spi.c,
ad4062_core.c, or as a standalone driver ad4052.c.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Jorge Marques (7):
      dt-bindings: iio: adc: Add adi,ad4062
      docs: iio: New docs for ad4062 driver
      iio: adc: Add support for ad4062
      docs: iio: ad4062: Add IIO Trigger support
      iio: adc: ad4062: Add IIO Trigger support
      docs: iio: ad4062: Add IIO Events support
      iio: adc: ad4062: Add IIO Events support

 .../devicetree/bindings/iio/adc/adi,ad4062.yaml    |   83 ++
 Documentation/iio/ad4062.rst                       |  138 ++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4062.c                           | 1375 ++++++++++++++++++++
 6 files changed, 1618 insertions(+)
---
base-commit: b469ad0b561478045c72d74cdf857171f1cf1c40
change-id: 20251011-staging-ad4062-20d897d33ab6

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


