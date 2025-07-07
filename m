Return-Path: <linux-iio+bounces-21419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB954AFB52A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620DC167C32
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AE1C4A0A;
	Mon,  7 Jul 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pJaIQ5ew"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A5194A73;
	Mon,  7 Jul 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896252; cv=none; b=Kngd4Ii3LCFoo1pokOjXv6lJ7SFaou1/ULKEW9pQZAdwIqjdH+JzdxFZOf1EuSJtqTA6WGwLHrvw92DKS4YeCQ7Tl63mBpy42fzyrlSbfC+agbNM0VGVWwYqL/CeSxrdVypwnRy2rF2miOYLnFktfEj6fUhV+wTIsEG8HdHjl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896252; c=relaxed/simple;
	bh=hSv+oI+RF0ez/63FrrphVj/k+AL+mIcvA7BZbrlUNN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNAHvEYI1YLMJ0sPwtRCfIUVw7PvoFjLZryuOfd0xR6bT0IUFmEurzzEDsLzHESgOr9C+poiav7wHbFInOdb2i7RMXtpGdj9z48aUVvWPrAHEdl4UQzALGVdK24iKh+IUTbpkRr1FSmvYiQ7GzXwoQ325GoroU8FUWr29VPlszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pJaIQ5ew; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567D1HmN026990;
	Mon, 7 Jul 2025 09:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TE28+rWHWv1guN3wNh5GDHZufsL
	o4KSJ3yYH4b3pZas=; b=pJaIQ5ewXJ8J/KxjHEKWQ+0PAY2p0/cnKazye/qLveb
	F0NjF/aaFBwopyHVt7ejsbsZuylt/F1jSKsC1ZwAclTd/86S81NKZ8sWcffvLedR
	D8A7YXbRFUzl5OGnPgRSAGOKvTUVfhcD2QASFVMivhKQZWc5kINxXLKgmIi+y3z9
	BfiYcpPTk1K2LIsj+2NY1zCWczJcYIkzATMdKB76zUDMwW5S/fjRLHxaehLjR4Rq
	gEnZXRyJ1WanCROkQYavvLmQ/T7zTt3gVkhj6IQGIVP/Jf7+OVL3iYUeYRZIVxp/
	8fwdCw3dXH/EeoRlq5qQTRrIF3QArKaNZWObvCGFCzQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh6dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:50:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 567DoFPU013303
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:50:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:50:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:50:14 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567Dnpvu016068;
	Mon, 7 Jul 2025 09:49:54 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 00/12] iio: adc: Add support for AD4170 series of ADCs
Date: Mon, 7 Jul 2025 10:49:46 -0300
Message-ID: <cover.1751895245.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd099 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=jSzwRb7mbQI_SljNwmoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MCBTYWx0ZWRfX6XRzwetZqQCs
 nOEed4HPMEhf18KiXT9U3BN5h0hprX0ITcUc6KBQdWtwGb4UgHiM+6DBYDnuhgGT79imGUetb8Z
 jLEDu6Pu9x/sDW90FYxmai7qdw83vxan6DEQpbqlSAwI+zzjaujMxHhYmE2BkJrIlBoXEJq+DQY
 YlVlvHFMRgmYaqUT/pKNDLECntBozbOAZsYotGrEOEKNzj45JHs9fs+aJ7QT8hBPBYIo0cKPgE4
 XZHIGQqn6Rta0/APT4aP+f+giWzd5F4oHfBkaivcWtTunykrHR06FAusxpdqqf0tyGVYP6iRFn9
 3d7DtZxPIDZ7o9DsUz+445cY+SUSUX2751Av5V9bZCXzWaZ5o+R0BbtpT+ZX/3/kzuil3rNZdm9
 OuWMGW+goLuAPgLEY5lH7o0x6xHfmNBhlvhhkyvDdW4fMObN0UeMvVkKkJAWjRDNyqXXSKnS
X-Proofpoint-ORIG-GUID: BIMeXA3Mrhr5qwgPUszeEIR7QAcH_PB9
X-Proofpoint-GUID: BIMeXA3Mrhr5qwgPUszeEIR7QAcH_PB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070080

Hi,

AD4170-4 v8 most significant differences from v7 is the timestamp patch comes
earlier in the series and struct ad4170_state fields have been rearranged
to better align to cache line boundaries.

Jonathan, I see you have applied v7 to testing. Thank you. Though, if still
possible to pick v8 instead, that will provide patches with fewer line removals.
Totally fine if you prefer to keep v7, though.

Thank you to all reviewers of previous versions.

v8 has:

Patch 1 adds device tree documentation for the parts.
Patch 2 adds basic device support.
Patch 3 adds support for calibration scale.
Patch 4 adds support for calibration bias.
Patch 5 adds sinc5+avg to filter_type_available IIO ABI documentation.
Patch 6 adds support for sample frequency along with filter type configuration.
Patch 7 adds support for buffered ADC reading.
Patch 8 (was patch 12 on v7) adds timestamp channel
Patch 9 adds clock provider support
Patch 10 adds GPIO controller support.
Patch 11 adds internal temperature sensor support.
Patch 12 adds support for external RTD and bridge circuit sensors.

Despite the updates, no functional change has been made in v8.
This patch series was generated using the "histogram diff" algorithm
(git format-patch --histogram option).

Change log v7 -> v8

[Generic changes]
- Update patches to make struct ad4170_state fields align well with both 32
  and 64-bit size cache lines after all patches are applied.

[Device tree changes]
- Updated device name in patch description (AD4170 -> AD4170-4).
- Removed extra blank line at the end of the doc.

[Basic driver patch]
- Early declare and use sensor type local variable to reduce diff in ext sensor patch.
- Make early check of IIO chan type to reduce diff in temperature support patch.
- Dropped 'int_pin_sel' field from struct ad4170_state. int_pin_sel is now local.
- Renamed AD4170_MAX_CHANNELS -> AD4170_MAX_ADC_CHANNELS for better readability.

[Timestamp channel patch]
- Moved from end of the series to right after buffer support patch.
- Reworked timestamp patch so it doesn't add 'num_adc_chans' field to struct ad4170_state.

[Internal temperature sensor patch]
- Reduced number of line removals in code diff.

[External sensor patch]
- Reworded external sensor support patch description.
- Reduced number of line removals in code diff.
- Updated ad4170_parse_external_sensor() param: u8 s_type -> unsigned int s_type.


Link to v7: https://lore.kernel.org/linux-iio/cover.1751289747.git.marcelo.schmitt@analog.com/
Link to v6: https://lore.kernel.org/linux-iio/cover.1750258776.git.marcelo.schmitt@analog.com/
Link to v5: https://lore.kernel.org/linux-iio/cover.1749582679.git.marcelo.schmitt@analog.com/ 
Link to v4: https://lore.kernel.org/linux-iio/cover.1748829860.git.marcelo.schmitt@analog.com/
Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/


Ana-Maria Cusco (1):
  iio: adc: Add basic support for AD4170-4

Marcelo Schmitt (11):
  dt-bindings: iio: adc: Add AD4170-4
  iio: adc: ad4170-4: Add support for calibration gain
  iio: adc: ad4170-4: Add support for calibration bias
  Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available
    list
  iio: adc: ad4170-4: Add digital filter and sample frequency config
    support
  iio: adc: ad4170-4: Add support for buffered data capture
  iio: adc: ad4170-4: Add timestamp channel
  iio: adc: ad4170-4: Add clock provider support
  iio: adc: ad4170-4: Add GPIO controller support
  iio: adc: ad4170-4: Add support for internal temperature sensor
  iio: adc: ad4170-4: Add support for weigh scale, thermocouple, and RTD
    sens

 Documentation/ABI/testing/sysfs-bus-iio       |    1 +
 .../bindings/iio/adc/adi,ad4170-4.yaml        |  554 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170-4.c                    | 3027 +++++++++++++++++
 6 files changed, 3607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 create mode 100644 drivers/iio/adc/ad4170-4.c


base-commit: 66ffb9f5accc6769d1ea7b9d7ac4c5ec477f9575
-- 
2.47.2


