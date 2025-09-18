Return-Path: <linux-iio+bounces-24260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A8B863E6
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78689171913
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D993161AE;
	Thu, 18 Sep 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QELPVlqT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFD271457;
	Thu, 18 Sep 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217048; cv=none; b=e8VfdYefaztgubw1xrGaZenw/feecg1zNcdYTMhCgHhyV/JpgVNb2io3kWDVFw21nOdOHHy11yR7fhtj+yDLv01x+ztce9aZ18ORFSwl6acfMs7uzpqaBULgSPGBatcqvHeXN2hn/LXtl/HxlQ5xFGMuLgUoa6fLb3DQdvB3OME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217048; c=relaxed/simple;
	bh=74xYvbVdNZnYs2uOcKGXIk26Xx+WdZP9tMRzf5GAYqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lF8Ef7/Ry7i+eeexB4BV56SXx9micPjMgPVZAbHC62WpQFpOjT2aRhnpUV7w7F0R3i261+Vaa0pNRzuvGetuVRX+91LPPqWMvVMBemo+x9J1HzROW+wOt+2yEXxIu6cdKckl7B3NOcAzA4x9sO9moQRcWlPJS3V5QF2/MH7d73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QELPVlqT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGeDKD020534;
	Thu, 18 Sep 2025 13:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=3BQea5sh0vUiAAipy3CJhuJNsS1
	BTOz63ymEMKPwxjY=; b=QELPVlqTptr8cRD+AYWWltbb3qpwIMuJMgZV7OzFkVD
	DiH3sFa92avnuRezN9jlYtkltmfmCrvgkA6wUBH0AZywy4cBwsPf6Pcgrfc+5bdY
	wu9qElYMwejbAWZtyNCPfhOi8ds9QcWauBU0xCtTyStxYTnw/aOZ/xxC3iwFACvT
	nYUtWwPCaxsQ+JUHDLkHfRuU93i70wa96KVcXRzZqozDCTXkZZC8KVecs5FrYP3v
	e5g2STtfedBMLYeZ/of6zIKyOoLdhSEiY8qC6XT9e5/1l8aUsSIEqBFrIR8UYs+b
	hwevvORNbHORoonV+90YOnWEcKc6AZquWAOzjg+0p1Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fy1mfnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:37:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHbKFG013566
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:37:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:37:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:37:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:37:20 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHb3VE022188;
	Thu, 18 Sep 2025 13:37:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/8] Add SPI offload support to AD4030
Date: Thu, 18 Sep 2025 14:37:03 -0300
Message-ID: <cover.1758214628.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: UpN35AlREd1eF5V2LebpJw-_JwjXOxjR
X-Proofpoint-GUID: UpN35AlREd1eF5V2LebpJw-_JwjXOxjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwxbfaZDTvKvw
 t8R2RAxTmYqjbKhwTfZwtSBP9FuZeJbxjqGAq5V8w40M8WnucVnGPiGT/A0CaUuPc3uFjTpWMsI
 DWbidwXu0thgd+wl4DgNGSYVUJQGz6HieLUTKzcrwoysX2GddrM+82Xcssxwg2hsVqY8MOHkHnX
 FvG2EKebNyPU8bb1UhJ+T/fhqudUISEy/LvOd4Oy1gTX1OmO2220qIx685Dmhf4EooB37tFQLH/
 Z0zwEErtgTqxawgxCa/aLjnnycAlcdi4ti0WGfrUXngX7IQ2iz5tqgLCwl3TfyTDQm+IvcFGw9f
 K5pTVrQ9T+ekTSn+smwGfgKg1S1HR8axgytZKnAnDHtlzGT/S9SYcLBqShR9ZDLLHur9Bks1bOl
 GcSASHwi
X-Authority-Analysis: v=2.4 cv=acVhnQot c=1 sm=1 tr=0 ts=68cc4352 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=FYq2zzjkr1LdAy_r4_8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Hi,

This patch series add support for high sample rate data acquisition with AD4030
and similar devices. The last couple patches in the series add support for
ADAQ4216 and ADAQ4224 which are similar to AD4030, but have a PGA in front of
the ADC input.

The patches to the SPI subsystem were submitted in a separate patch series
titled 'Add SPI offload trigger offset'.

Except for a couple of comments on the SPI offload patch, I believe I have
applied all suggestions to v1.

Change log v1 -> v2
[IIO Docs]
- Swapped PWM numbering.
- Expanded double PWM description and capture zone description.
[device tree]
- Dropped pwm-names since only one PWM signal is directly requested by the ADC.
- Use pattern to specify devices that require gain related properties.
- Disallow gain related properties for devices that don't come with embedded PGA.
- Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
- Updated PGA gain constants.
[IIO]
- Dropped all clock-modes and DDR related stuff for now as those will require
  further changes to the SPI subsystem or to SPI controller drivers.
- Update the modes register with proper output data mode bits when sample
  averaging (oversampling_ratio) is set.
- Lock on device state mutex before updating oversampling and sampling frequency.
- Made sampling_frequency shared by all channels.
- Better checking the requested sampling frequency is valid.
- Adjusted to SPI offload data capture preparation and stop procedures.
- Error out if try to get/set sampling frequency without offload trigger.
- Depend on PWM so build always succeed.
- Drop unmatched/unbalanced call to iio_device_release_direct().
- No longer shadowing error codes.
- Using BIT macro to make list of averaging options more readable.
- Updated PGA gain constants.
- De-duplicate 'ret == -EINVAL' check in PGA setup.
- Dropped redundant call to ad4030_set_pga_gain() on PGA GPIO setup.
- Better state struct field placement to avoid holes in data.
- Many minor readability and code style improvements.

The code was tested on a remote setup with ADAQ4216 connected to a ZedBoard
running Linux kernel 6.17.0-rc1 built from IIO tree testing branch.

Link to v1: https://lore.kernel.org/linux-iio/cover.1756511030.git.marcelo.schmitt@analog.com/

Best regards,
Marcelo

Marcelo Schmitt (8):
  iio: adc: ad4030: Fix _scale value for common-mode channels
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Documentation: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

 .../bindings/iio/adc/adi,ad4030.yaml          |  71 +-
 Documentation/iio/ad4030.rst                  |  35 +
 drivers/iio/adc/Kconfig                       |   3 +
 drivers/iio/adc/ad4030.c                      | 718 ++++++++++++++++--
 4 files changed, 774 insertions(+), 53 deletions(-)


base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
-- 
2.50.1


