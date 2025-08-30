Return-Path: <linux-iio+bounces-23405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5657AB3C659
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F175E7514
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917C1AA1F4;
	Sat, 30 Aug 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hN0o17U2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AF16DC28;
	Sat, 30 Aug 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514403; cv=none; b=uV4bMoUuTi6NL/5mIt0uABV2UVX5m4lE/4jOYYE81dg9D7b/7GAUDsj9R27wFHV33c30MH4dQkiO2kfoTx6FDkVCisJMO8/4NSAsVDu2ZQCh/xhOMapV+5KyOA9IYlkmEKIs7YFMxVzNDcMtpgqsOFuM2Gy9nQJqWuvv9wB1GCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514403; c=relaxed/simple;
	bh=Xu4md5W2KAitNczbTbZNIQ5xByjHoGQUNmfu+IxPf/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mWfF8gTZIYVQ8qwqGZpasLI7G2ajxMp9o+3nT2uc7hjWJyKzYCK3ic1gIxX733d8qFA0LlqAY97lHJGjlsXYpv5sB7/PGZNpayJY1Vcgs+l03gMAB69TTCJCBa3qF+czhqpTS7OgS+aLvz5faOws3QVZrbkRs4QqLrKk39f9yPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hN0o17U2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0UIKo021614;
	Fri, 29 Aug 2025 20:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/+THuAkQ461LskLsz1dD9sUbRFB
	8JwICV5e2YPYn1bc=; b=hN0o17U2yk1N/B2l9Vle+eGET9nOZ0LAUUDTAcNe7it
	C8ZnRrhn0gVIWrI/Nga12cIX0ZjsQh34RZ3r6tqrW8B7LooYgGh133lkX1Wo4tGL
	IXLg74LO99gR7h+NtbGei3QgoDPkY4R7r/4SoEQE+Bt+yvfpwdyJJJqno3YmXYC3
	H41iKuPzKyqK72ODjnodDA+e2vdz5WZrElKd3PsZN3aEGF8AoATaOheEbVDVPyN2
	tvuisz5tbLBQw4UIPN4nMTHo7Zwjy+Fu3TaS8ENiUaxjMI+ZOEyPVzn3fUMUV3Sl
	CbEkOpsjS1hnzV76ej2LYbVbi0dd6CD9D4qjCMXwx5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:39:54 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0drEb031345;
	Fri, 29 Aug 2025 20:39:53 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:39:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57U0dqTY040824
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:39:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:39:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:39:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0dTGl004731;
	Fri, 29 Aug 2025 20:39:31 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 00/15] Add SPI offload support to AD4030
Date: Fri, 29 Aug 2025 21:39:27 -0300
Message-ID: <cover.1756511030.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX9GCNyaT/kwpr
 jswSV5HZNyg9B3vOOhwxn5kC0hUTt151BVP8QGAXlqf5308DBB7/indfWRfmXj2sL0W8a7eEN/f
 ++5boUMAcnQXYZqZT/I8yTsAi/wMjb7+wXVJyCqaXICL2dy+0FJ0v5h+u6g4XJpy6GVUpfWhbvW
 blu2DtsGJ0j0fQrjCf4rcxbFrzomEqdtp6lHea8N1BzYv6LIK2HOMPX5jT8WQGZvQwFgT9HlpXY
 3W7G5dfciRACr+1dIB7n9KD1uQBiDaHJ9Rl3zLNxGT2PYHG61s9PJmtNALnr5cxURJU1UoNrNnt
 ERfHXy+/DzGr44WOzrHgYaUp/SQjvnEgiBH3YAJW8p6go26WsOCIbuHXVBqTNgw1P6PrF0KZ8r3
 pM6BPXr+
X-Proofpoint-ORIG-GUID: vnhgSk-0bhPY8_9PERRUhgXyUuHi1bA_
X-Proofpoint-GUID: agHDen-nj-zmZc1wNguW8NxUIoEVFZoS
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b2485a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=5tJJNpAVUjWtunKr7TIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Hello,

This patch series add support for high sample rate data acquisition with AD4030
and similar devices. The last couple patches in the series add support for
ADAQ4216 and ADAQ4224 which are similar to AD4030, but have a PGA in front of
the ADC input.

Most of the code is for SPI offload support is based on work from Sergiu
Cuciurean, Nuno Sa, Axel Haslam, and Trevor Gamblin. Thus, the SPI offload and
related patches come with many co-developed-by tags. I also draw inspiration
from other drivers supporting SPI offload, many of them written by David Lechner.

The patches to the SPI subsystem are from Axel Haslam and I only signed them to
indicate I'm moving them forward.

The patches with updates to device tree are introduced before the patches that
use each specific change.

ADAQ PGA device tree doc and driver handling was inspired on AD7191 dt-binding
and driver.

The code was tested on a remote setup with ADAQ4216 connected to a ZedBoard
running Linux kernel 6.17.0-rc1 built from IIO tree testing branch.


Axel Haslam (2):
  spi: offload: types: add offset parameter
  spi: spi-offload-trigger-pwm: Use duty offset

Marcelo Schmitt (13):
  iio: adc: ad4030: Fix _scale for when oversampling is enabled
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Documentation: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add 4-lane per channel bus width
    option
  iio: adc: ad4030: Support multiple data lanes per channel
  dt-bindings: iio: adc: adi,ad4030: Add adi,clock-mode
  iio: adc: ad4030: Add clock mode option parse and setup
  dt-bindings: iio: adc: adi,ad4030: Add adi,dual-data-rate
  iio: adc: ad4030: Enable dual data rate
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

 .../bindings/iio/adc/adi,ad4030.yaml          |  86 ++-
 Documentation/iio/ad4030.rst                  |  29 +
 drivers/iio/adc/Kconfig                       |   2 +
 drivers/iio/adc/ad4030.c                      | 704 +++++++++++++++++-
 drivers/spi/spi-offload-trigger-pwm.c         |   5 +-
 include/linux/spi/offload/types.h             |   1 +
 6 files changed, 792 insertions(+), 35 deletions(-)


base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
-- 
2.39.2


