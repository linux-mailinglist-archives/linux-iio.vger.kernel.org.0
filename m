Return-Path: <linux-iio+bounces-4917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5E8C1E3E
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014231F215F1
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EA5E099;
	Fri, 10 May 2024 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uW1RJp4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B81A2C0E;
	Fri, 10 May 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323317; cv=none; b=hydDow8OwDKbHZGkPipZto20a9q+hsSM/8pRB9oOjjRCIOqbtAoafqgozKhUSnc1r19Xe8kez0v6psUlsZ50r4t0fqWxhC6vgVEGynu6C6jfFQyRs9fkJ9SOpSBSKrWQTJh4PLvv2f6V0Jp7m1aMl0Pw2SxmuG6DhBs/yjBIiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323317; c=relaxed/simple;
	bh=zHw5rmsy7qKm+z8qwjnC5Xt6TIYGmbIqlRzkdS4jp2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGhxAEu1CuiARzDMx8w3K3APHOCoOJgJ8D2S0G0gqsulowYaAXIs9zLS9ZCUHWLd9Jy1Px7syovhXoS6933bw5gYFRGt3W8lzzzp4XYHt3y3vydeysS80Zp6W68TwnNWUgKvXPDRjPy6kCWYvgIzDW11gA0EQZkMJ/NE/GT2ZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uW1RJp4o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A4dBKK006983;
	Fri, 10 May 2024 02:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=DKIM; bh=kVni+v16C442TfQ6e1EmMu0Ew
	QbjLzJZQSp6aTqUDI8=; b=uW1RJp4osExmx4dk9fVw96mCbfLxzMikFa1E8Z6/V
	Xva1MkJJ7+AgVKQUl2p79P1yxK6Wxypu1MjrFo8WR9bpZE8hD5zENjCrKnkFXbVS
	JS+0luQi8LMw1RHQp35hgvAH7gh6KcXYArYdZqvZ2R8fs8RFxJC751jfJ9Aq3b57
	npoP+A9tZCBj3UWpoP9XhivOydXUkpH2X2TW/YXDTRrq5N8wjxoxqM8YvZhbqqXN
	bKa2RPHaZKUXZ4Nzqp5MJhkoMn1iDWKoviKIwWvKKeWdnCZWGI+/Cbh81juc5bLr
	Te5G16FnOSUglyl73CwCvAC2j+aXaxs7eljfU/7hY7Ufg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y16xt1c5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:41:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44A6fHsv051476
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 May 2024 02:41:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 May
 2024 02:41:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 May 2024 02:41:16 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44A6ewwb001379;
	Fri, 10 May 2024 02:41:00 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/2] add AD8460 DAC driver
Date: Fri, 10 May 2024 14:40:51 +0800
Message-ID: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lT5dUnIKRTt949X5kgeiLUUb5vZVrppF
X-Proofpoint-ORIG-GUID: lT5dUnIKRTt949X5kgeiLUUb5vZVrppF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100046

The AD8460 is a 14-bit, high power +-40V 1A, high-speed DAC,
with dual digital input modes, programmable supply current and
fault monitoring and protection settings for output current,
output voltage and junction temperature.

The fault monitoring and shutdown protection features were
supported in the earlier versions of the IIO driver but was
scrapped due to uncertainties if the functionalities belong to
the IIO driver. However, it would be best to implement it for
the device's quality of life. I'd like to know if it's better
suited as a stand-alone HWMON driver.

The following are the configurable and readable parameters
through SPI that could be implemented on the HWMON driver:
  * An enable bit to arm/protect the device on overcurrent,
overvoltage or overtemperature events. The device is shut down
upon detection.
  * A configurable range/threshold for voltage, current and
temperature that raises alarm when exceeded while the device is
armed.
  * Flags that can be polled to raise alarm upon detection of
overcurrent, overvoltage or overtemperature events, and apply
additional protective measures.
  * Programmable quiescent current (optional)
  * Thermal monitoring is done by measuring voltage on TMP pin
(unlikely to be included)

Mariel Tinaco (2):
  dt-bindings: iio: dac: add docs for ad8460
  iio: dac: support the ad8460 Waveform DAC

 .../bindings/iio/dac/adi,ad8460.yaml          |  67 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  13 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad8460.c                      | 652 ++++++++++++++++++
 5 files changed, 741 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
 create mode 100644 drivers/iio/dac/ad8460.c


base-commit: 9900e7a54764998ba3a22f06ec629f7b5fe0b422
-- 
2.34.1


