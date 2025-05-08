Return-Path: <linux-iio+bounces-19318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A923AB00DA
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54D33BEC04
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E428312E;
	Thu,  8 May 2025 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EbNx2WUd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0897221294;
	Thu,  8 May 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723805; cv=none; b=NSC4GcKmdcxUr7QonWq9Ge6BQbm/w6tkh7fLwkultZEmE5piNaGXhDqqMdEd9wkQe+j2FeBo40bN9N0UwsGfMiNCx27suwOzqAPYTW9RWPMXAxtTwkNVTenXcNb2fok/KskdsDCoIe8dhtHlDkoB/+kGLWLJP8sFU7Eydqe6BOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723805; c=relaxed/simple;
	bh=gZCDkiJ4Rg95tBrcRO8NL7Eap/QE9Mn0zTYRwRZ5lAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=USiXZRHykBMIVfayg9eA7IEIIfbNe4s4XEeak9CFu6g/uu5wLTcoZjVrfO0R8r0W4tfPY6VR3OOQv7752YUaxTqQi2R5JAhEo4J8cyo/CgrofjWLoHBcvtFGhEjjGJPI/8NHIWbqCr01j5Pshm3UqcgfKASZzSjfSB6tkQeO7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EbNx2WUd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548FSX9V000696;
	Thu, 8 May 2025 13:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=YeJkxcgCvWKrgpLFRX7pF+F2eqK
	1Bsb7YEXmv/cAX0E=; b=EbNx2WUdleF+aoqLuR2i3YtjceMs/4q7k7O09PHRUfn
	hJ8+6wdYhsykYKeHT+NEAPgQWEkFFarPx2cX2CCxZsPF16jsvOkOhg3RhQsB0vYb
	845L/557vc7eQKIJTibeZSn2QRKutzZF4EBhoWJgeWp4TON9Aa1RyOP6EE5YMJNk
	ixjZgZiHB1kUKucTA6opBfH4J7pQsI5dC2O93x3SLZ1Xf/GOzZS4vo5oMipkuPAm
	17EiWc1WX2qfxQVZYRBrZQpX0N9aj673O57Vo1utljJYyv9EDf1Zvo9q7incd2oc
	8PFfYKOCSR3p045YxyHRX02KK67uQ0m5TyURj0gRjfA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46gy9q8cye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:03:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548H39t9052577
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:03:09 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:03:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:03:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:03:09 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H2qSF015857;
	Thu, 8 May 2025 13:02:55 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH v7 00/12] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Thu, 8 May 2025 14:02:50 -0300
Message-ID: <cover.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ulU4eOWoH9C5wOf0IJWx49L8JfibmLvd
X-Authority-Analysis: v=2.4 cv=f/ZIBPyM c=1 sm=1 tr=0 ts=681ce3ce cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=wUxFP8jSl_fENa0tmKEA:9
X-Proofpoint-ORIG-GUID: ulU4eOWoH9C5wOf0IJWx49L8JfibmLvd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXyag8l0tyIo+p
 yEOjBkQII7fqsZC0FcPMDqd7qUZjYSfDpiMDXvqYe5TWTM7eiVlfEaFLmBRuBtPLWvw4yVi/zkr
 QIAfWMZXUD2D3RZxkoKmDnUx1+wxfgi+MlJ1dtuHJGD1hyuCh1YmSLI4KqvgsAT5mJuG4Yk8+V7
 okeVZofxSdBo4Kk6X7SDS44Hmpo62mDmmitq4WYPdkeAAbTFmcNMcjUcT93al2DGypBmJP2Qeg1
 8bOlwrQjwxOOZ+ufWjV0M1RxIcd3ouRUCTmed0rvfjX+RzdOMwi3O9Cxg4MRKT2N81UzgnFSowx
 u+jp4dkqfsNY4dkKpzp69uk59Ko0/1GByQgTM8XJ/WzGUd8m0/pEWv63KY+z4avdwi96rlKbkKu
 B0JIEQamovwEXCEwbcBue4De/MKl1/+uvmWKjktExy/m1zfjqCjXGnux/b1it2O+Z2xLBuz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080149

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage output
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

---
Changes in v7:
* Added a new patch to reorganize driver headers.
* Added the new files to MAINTAINERS.
* Added dependencies to constrain the use of trigger-sources and
  adi,sync-in-gpios properties at the same time.
* Self triggering is enabled only when the trigger-sources property is
  not defined. Added TODO to support other trigger sources when the subsystem
  is available.
* Refactor code to avoid forward declarations.
* Mentioned that sampling frequency changes is not allowed in
  buffered mode.
* Addressed review comments, see individual pacthes.
* Link to v6: https://lore.kernel.org/linux-iio/cover.1745605382.git.Jonathan.Santos@analog.com/T/#t

Changes in v6:
* Changed description and addressed other nits in the gpio-trigger patch.
* Rewrote the #trigger-sources-cells description and removed mentions 
  to offload engine.
* Added adi,ad7768-1.h header with macros for the trigger source cells.
* removed of_match_ptr() from regulator_desc.
* Replaced deprecated .set callback with .set_rv in the gpio controller
  patch.
* Use `trigger-sources` as an alternative to `adi,sync-in-gpios`
  (now optional), instead of replacing it.
* Check trigger source by the compatible string (and the dev node for the
  self triggering).
* Addressed review comments, see individual pacthes.
* Link to v5: https://lore.kernel.org/linux-iio/cover.1744325346.git.Jonathan.Santos@analog.com/T/#t

Changes in v5:
* Added gpio-trigger binding patch.
* Include START pin and DRDY in the trigger-sources description.
* increased trigger-source-cells to 1: this cell will define the trigger
  source type.
* Fixed the holes in the regmap ranges.
* replace old iio_device_claim_direct_mode() for the new 
  iio_device_claim/release_direct() functions.
* Changed some commit messages.
* Link to v4: https://lore.kernel.org/linux-iio/cover.1741268122.git.Jonathan.Santos@analog.com/T/#t

Changes in v4:
* Added missing `select REGMAP_SPI` and `select REGULATOR` to the device's Kconfig.
* VCM output regulator property renamed.
* Added direct mode conditional locks to regulator controller callbacks.
* Renamed regulator controller.
* Created helper function to precalculate the sampling frequency table and avoid
  race conditions.
* Link to v3: https://lore.kernel.org/linux-iio/cover.1739368121.git.Jonathan.Santos@analog.com/T/#t

Changes in v3:
* Fixed irregular or missing SoBs.
* Moved MOSI idle state patch to the start of the patch, as the other fix.
* fixed dt-binding errors.
* Trigger-sources is handled in a different way, as an alternative to sync-in-gpio.
  (this way we avoid breaking old applications).
* VCM output is controlled by the regulator framework.
* Added a second regmap for 24-bit register values.
* Add new preparatory patch replacing the manual attribute declarations for
  the read_avail from struct iio_info.
* included sinc3+rej60 filter type.
* Addressed review comments, see individual pacthes.
* Link to v2: https://lore.kernel.org/linux-iio/cover.1737985435.git.Jonathan.Santos@analog.com/T/#u

Changes in v2:
* Removed synchronization over SPI property and replaced it for trigger-sources.
* Added GPIO controller documentation.
* VCM output control changed from an IIO attribute to a devicetree property (static value).
* Converted driver to use regmap and dropped spi_read_reg and spi_write_reg pacthes.
* replaced decimation_rate attribute for oversampling_ratio and dropped device specific documentation patch.
* Added low pass -3dB cutoff attribute.
* Addressed review comments, see individual pacthes.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1736201898.git.Jonathan.Santos@analog.com/T/#t

Jonathan Santos (11):
  iio: adc: ad7768-1: reorganize driver headers
  dt-bindings: trigger-source: add generic GPIO trigger source
  dt-bindings: iio: adc: ad7768-1: add trigger-sources property
  dt-bindings: iio: adc: ad7768-1: Document GPIO controller
  dt-bindings: iio: adc: ad7768-1: document regulator provider property
  iio: adc: ad7768-1: add regulator to control VCM output
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: replace manual attribute declaration
  iio: adc: ad7768-1: add filter type and oversampling ratio attributes
  iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Sergiu Cuciurean (1):
  iio: adc: ad7768-1: Add GPIO controller support

 .../bindings/iio/adc/adi,ad7768-1.yaml        |  68 +-
 .../bindings/trigger-source/gpio-trigger.yaml |  40 +
 MAINTAINERS                                   |   4 +-
 drivers/iio/adc/Kconfig                       |   1 +
 drivers/iio/adc/ad7768-1.c                    | 905 +++++++++++++++---
 include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
 6 files changed, 918 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h


base-commit: 9415c8b5b9b7ba927d98f80022a2890e8639e9e4
prerequisite-patch-id: fbb33747cd0293bacd5b6d801d6cfc087449a28e
-- 
2.34.1


