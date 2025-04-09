Return-Path: <linux-iio+bounces-17879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FBA82A64
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A009C1C4A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2425EF85;
	Wed,  9 Apr 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bHmY4oja"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B141482F5;
	Wed,  9 Apr 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211465; cv=none; b=to2dshDOgROYSz62f+h4hNO4yoOOzOR9RbiGWEDDbTWpC2TFPwsX3jW4mrqJzatbSt9ELIOu0nZkeAIfSMLKMpwBBCe2l4uxa2nSjBFahvml25Q0wF1l0RLUc5h2RfgGyzXeyvACNXBm6w7NZbuTWmY6HyuVyOvoBvHfZ06X3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211465; c=relaxed/simple;
	bh=TG1LlNv3LjfaexLcZPWLJHwERX1O6QwezQqaTLTKUZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDHSltdBRs+0cJgKMxUYZPoKVgcP5pE7dKuArnQ4xvx87jaL9tJjkiLRwOPq/fWEm63QI3COK3U70PtE9Z30bGeQbi7RxL5YaBl69BaWAjXTVaVVflspfrfqj8r4aDAlRxw6AmbSfrSZ4XD9jwHa/yaMol/Q1En2PUkpUxz4hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bHmY4oja; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398iQla002699;
	Wed, 9 Apr 2025 08:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=rICUF5sAyQ2j6QCV40vr2zeqUur
	mbGVzpoDh7KePLiI=; b=bHmY4ojaOA1mfhwFrZYwamIT1RGZL+TJD0teNm5zDUK
	l/6DnPKsSarbKI49AQqB9YvwJZph1i2I83UCapatKdYdS9DqqvOjsIpXkCEJ7KMA
	92bnXmrUpe7Uf4jPab/Yj+BwfQ+M8TBoC+SbWlVskSJ1eKLWqrW+DanxbZV9h8B9
	dUUNrblCE2XnCc6iTF5ahuVcEDaKT/D37nET0Z8HMp9cpz21DLz37i/jTft1BwUL
	qJIboD7bU+lSFkUFl0CFDCzynCsHN8EvLDjAEllAPJXgxoHUlvH6XFiehH3+s8yJ
	MDRdfpreGDYQMPShw3s8Ww3Ox54iqA7iZknDqw9m9xA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6dqnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:24:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 539COFRL052173
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:24:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 9 Apr 2025 08:24:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 9 Apr 2025 08:24:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:24:15 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539CNunk016887;
	Wed, 9 Apr 2025 08:23:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 0/7] iio: adc: Add support for AD4170 series of ADCs
Date: Wed, 9 Apr 2025 09:23:50 -0300
Message-ID: <cover.1744200264.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: 71u7Qt8axE4aFoAbKAY2Oo0wE-pcfTcn
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f666f1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=LZWaY_n9-dVI2q1oZpsA:9
X-Proofpoint-GUID: 71u7Qt8axE4aFoAbKAY2Oo0wE-pcfTcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090073

This patch set adds support for Analog Devices AD4170 and similar sigma-delta ADCs.

I've arranged the patches so that the first ones comprise changes more typical
of IIO device drivers while the last one has the most uncommon changes.
I believe to have applied all suggestions to the RFC version.

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for buffered ADC reading.
Patch 4 adds clock provider support
Patch 5 adds GPIO controller support.
Patch 6 adds internal temperature sensor support.
Patch 7 adds support for external RTD and bridge circuit sensors.

For context, an initial version of the ad4170 driver was developed by
Ana-Maria Cusco. I then picked that up, created dt docs, and did several
improvements to the driver.

This first version has so many changes compared to the RFC version that it's not
worth listing them all. The most significant one, though, are listed below.

Change log RFC -> v1

[IIO driver changes]
- Split off extra features into smaller additional patches.
- No longer pushing timestamp data to buffers.
- Used iio_for_each_active_channel() to iterate over channels in trigger handler.
- Correctly implemented incomplete/broken usage of SPI optimized messages.
- No longer setting interrupt direction in driver.
- Register names, register field names, and names of constants for register
  fields now follow an established pattern.
- Data ready interrupt config now set according to interrupt-names dt property.
- Added scan_mask to validate chan 0 is enabled when multiple chans are enabled.
- Added a comment explaining the reason to disable all channel at buffer_predisable().
- Complemented comment about channel 0 being required to be enabled when more
  than one channel is enabled.
- New GPIO controller support patch.
- New internal temperature sensor support patch.

There are some places where I used find_closest() to match/verify values from
dt. On the last patch, I added ad4170_find_table_index() to avoid find_closest()
but may use something else if there are any generic helper for such thing.

[device tree changes]
- Dropped adi,ad4170.h. All dt documentation is now in adi,ad4170.yaml.
- Described external bridge circuits and RTD sensors as specialized channels
  with specific properties for excitation control.
- Bridge circuit excitation properties are now sensor-node only.
- Added compatibles for 2 more similar chips.
- Added ldac-gpios.
- Dropped adi,dig-aux1, DIG_AUX1 now set according to Data Ready interrupt choice.
- Dropped adi,dig-aux2, DIG_AUX2 now set according to LDAC GPIO presence.
- Dropped adi,sync-option, SYNC_CTRL will only of be set for multi-device sync.
- Dropped adi,burnout-current-nanoamp since open wire detection should be a runtime config.
- Complemented adi,buffered-pos/neg description with possible reason to not enable them.
- adi,gpion-power-down-switch renamed to adi,power-down-switch-pin is now a
  sensor-node only prop.

About the bridge power-down-switch pins, it was mentioned that maybe they could
be described as regulators that the bridge circuit would consume. One
complication of that approach is that the AD4170 powerdown switches close to
AVSS/GND and that doesn't help determining regulator maximum voltage. It may
also be desired to control the power switches at runtime to save power by
closing the power down switches when the bridge would not be in use. Because of
that, I have removed pw-down switch props from the dt-binding.

Not sure what to do about the various possible multiplexed inputs to the ADC.
Even though the IIO driver doesn't handle all of them, I'm keeping those since
dt-bindings are intended to be OS agnostic and we are expected to make bindings
complete.

Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170

Marcelo Schmitt (6):
  dt-bindings: iio: adc: Add AD4170
  iio: adc: ad4170: Add support for buffered data capture
  iio: adc: ad4170: Add clock provider support
  iio: adc: ad4170: Add GPIO controller support
  iio: adc: ad4170: Add support for internal temperature sensor
  iio: adc: ad4170: Add support for weigh scale and RTD sensors

 .../bindings/iio/adc/adi,ad4170.yaml          |  527 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2817 +++++++++++++++++
 5 files changed, 3369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 drivers/iio/adc/ad4170.c


base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
-- 
2.47.2


