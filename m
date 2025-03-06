Return-Path: <linux-iio+bounces-16471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D577CA54CE4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22FB3AF5CE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C49154439;
	Thu,  6 Mar 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SCw4nxYX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4C44C94;
	Thu,  6 Mar 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269895; cv=none; b=SfRX/wnSrH0pZM/SQ5K58ifO628X29+7IUy5Rvk4FUgSIgIdqtv/5SBXhT74xyuwVnX8BDQPqitGNYDdV63q+uf+tCg/wIj1skeFqStEUIsShWuI2b3cBrZOO28qthWe9T6opdheeL2fYGjCZHMp/2bVoe+pi/fV/wNp3lN5QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269895; c=relaxed/simple;
	bh=ZmXCsps3szqR5PYQD+MhFlQaRORylZnCZhgPt759QdU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=W+u3bgetYyttuvukTvDkx742OLPWU55mLYqs4MxqMVj0cKHi4x2jE4Qdi8CM6sQCCvpNktvRl1Ui+4k/5PNr7spIXSO2gMQ80NMhPwwNx4dV4OU/IP96HFFOYGPeZbabhMSjwi/CuAqLVNSwpjF9e8QKRY5nKqc/g1jRBRs92QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SCw4nxYX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526C7l91004799;
	Thu, 6 Mar 2025 09:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pbsue6LnaHcYvymVhz6Vwle18m7
	47UokkJq3/J8Ariw=; b=SCw4nxYXIhgmjCZPWv9BdkwT/SVg2eww113XdjQ/DA6
	lqOZbcjDN++UqSZ60hF8Mc8M27m9MUB5xXquFeEIxczrwpz5QO+Xv5t2EnZSAZ11
	JA+ghJ3AQqMkILPL2YpP2h4w2esUT0htT3aoZMG6HYc5qA7uoy1JyHb5vB8jYofb
	4D4WPf/g0NylcBbWNRGXjsZchR4Pk2wxGh2ScuozytTKnp5Jg0w39KgG9TrGrFpy
	CtIvbZatS4hyLAlXSpZWlAR5Zlt8M7IWzx4ATAHPYrkt9t6JvkgMnSLfwYWdYXq/
	XetjfkoEme+vh9Po4KMuYPFnkdNaoTYJaiiA3dDbz6w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4577p69mmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:04:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 526E4OJR016887
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 09:04:24 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 09:04:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 09:04:24 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526E4CqR024033;
	Thu, 6 Mar 2025 09:04:14 -0500
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH 0/4] Add support for AD4052 device family
Date: Thu, 6 Mar 2025 15:03:13 +0100
Message-ID: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKryWcC/x3MOQqAMBBA0avI1A5k08KriEWWUacxMoEgSO5us
 HzF/y8UEqYCy/CCUOXC+erQ4wDx9NdByKkbjDKTsmpG5oxJuJKgT05NBr3zMdoQtA4WencL7fz
 8z3Vr7QPlkZGRYwAAAA==
X-Change-ID: 20250306-iio-driver-ad4052-a4acc3bb11b3
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741269851; l=3553;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=ZmXCsps3szqR5PYQD+MhFlQaRORylZnCZhgPt759QdU=;
 b=AxY3yI6EkpUsgGX04TsPN11q/0bEbJGdPiXVEO8sUOUKgCCi7RJNBW12ItMi2ricp5hHbIcHA
 Nx/tp98cw+bDrWq49ZPE9ZoomrNxwWDw7J2kg2FRYGPog+Kz12AxFPD
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EmJCe86d5XodzueoS6YSnQsKtC2UxKrE
X-Proofpoint-ORIG-GUID: EmJCe86d5XodzueoS6YSnQsKtC2UxKrE
X-Authority-Analysis: v=2.4 cv=GNDyEvNK c=1 sm=1 tr=0 ts=67c9ab69 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8 a=giVPYnx8gUsv7YmhhMYA:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060107

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
successive approximation register (SAR) analog-to-digital converter (ADC).

The series starts with marking iio_dev as const in iio_buffer_enabled,
to not discard the qualifier when calling from get_current_can_type.
This is required since the size of storage bytes varies if the offload
buffer is used or not.

The scan_type also depends if the oversampling feature is enabled, since
the 16-bit device increases the SPI word size from 16-bit to 24-bit.
Also due to this, the spi message optimization is balanced on the buffer ops,
instead of once per probe.
SPI messages related to exiting the ADC mode, and reading raw values are
never optimized.

The device has autonomous monitoring capabilities, that are exposed as IIO
events. Since register access requires leaving the monitoring
state and returning, device access is blocked until the IIO event is disabled.
An auxiliary method ad4052_iio_device_claim_direct manages the IIO claim
direct as well as the required wait_event boolean.
The device has an internal sampling rate for the autonomous modes,
exposed as the sample_rate attribute.

The device contains two required outputs:

* gp0: Threshold event interrupt on the rising edge.
* gp1: ADC conversion ready signal on the falling edge.
       The user should either invert the signal or set the IRQ as falling edge.

And one optional input:

* cnv: Triggers a conversion, can be replaced by shortening the CNV and
  SPI CS trace.

The devices utilizes PM to enter the low power mode.

The driver can be used with SPI controllers with and without offload support.

A FPGA design is available:
https://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/

The devices datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050-ad4056.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052-ad4058.pdf

The unique monitoring capabilities and multiple GPIOs where the decision factor
to have a standalone driver for this device family.

Non-implemented features:

* Status word: First byte of the SPI transfer aligned to the register
  address.
* Averaging mode: Similar to burst averaging mode used in the
  oversampling, but requiring a sequence of CNV triggers for each
  conversion.
* Monitor mode: Similar to trigger mode used in the monitoring mode, but
  doesn't exit to configuration mode on event, being awkward to expose
  to user space. 

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Jorge Marques (4):
      iio: code: mark iio_dev as const in iio_buffer_enabled
      dt-bindings: iio: adc: Add adi,ad4052
      docs: iio: new docs for ad4052 driver
      iio: adc: add support for ad4052

 .../devicetree/bindings/iio/adc/adi,ad4052.yaml    |   80 ++
 Documentation/iio/ad4052.rst                       |   93 ++
 MAINTAINERS                                        |    8 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4052.c                           | 1289 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |    2 +-
 include/linux/iio/iio.h                            |    2 +-
 8 files changed, 1487 insertions(+), 2 deletions(-)
---
base-commit: aac287ec80d71a7ab7e44c936a434625417c3e30
change-id: 20250306-iio-driver-ad4052-a4acc3bb11b3

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


