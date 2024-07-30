Return-Path: <linux-iio+bounces-8038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C2940599
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD17282F6E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA41448F2;
	Tue, 30 Jul 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zYRa+bNI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257D33E8;
	Tue, 30 Jul 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308754; cv=none; b=PstY44WcMDjgnmFqnuscrDBnlAEacDLBwTaxQ8RdEgyhLbBees+1KZ7Gf9v4/DxK6lMEwOgcWELoskeiEASCbRSszYCgcp5D+swpk5fQ43apTUIcrc1dUR6CZyq4CGurbXLWfs7b3C6XzQ4k+zBd8yM0tdeh1AM+Np7aChfHkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308754; c=relaxed/simple;
	bh=fJtYSrbyH1dAnyqRrSXst5jMS/WOlvXufcWcez53Apo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tz1rce5l10Si0ib9RyTnFKX8QyhSflcOeQpyVy7NSzqp8LGjx/Ewq5qhrHEozfwr1++lGFyE9S9CmziuJx/+vjdi8J9Svay7l+rxHQmsEED9TlqEIHCdvr/nY6ih6Wih4VpSWQ4MddBYHi4f6Wf+ujeA4a5ZpPBCR7xmxb8aNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zYRa+bNI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TL3jXc023245;
	Mon, 29 Jul 2024 23:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=7hTnzFi1T4HIoHzxjrwqHcVDVUN
	zn4sUFizSEga3JL8=; b=zYRa+bNI5K78aInL+AF6Rt4VJMH6o4P0SXhsehMU5dK
	ogynw7jRZ37IAcNBFXjVJIk5Ulch26j34j27ul35JWY+ldtzIoF0ItkgP6PWnIOt
	3wiCulpDjwMjawFke+LqQft7UhrfQ4GKTmS2kirZidhtmUqCrn060jNNHzKFPiLn
	zQadb5O/+2xzhGSP5b50Q8GdvBDunggJhnBsk6KNI+tXy22NCqyhAZ+IPNU6bi6R
	D6XQqAaGMDCvMgZQmi2eL+T0hFd9t2AlcKGivPJDkxRAcZ4KkabO3zmoatG5oTMA
	cJMF7sSRhjNvLot3DvIRwMejNbzFbrBA134H+yF3NFg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40ndy4ps4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:05:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46U35YSA029548
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 23:05:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Jul
 2024 23:05:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Jul 2024 23:05:33 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.75])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46U35GSX017771;
	Mon, 29 Jul 2024 23:05:19 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>
Subject: [PATCH v2 0/2] add AD8460 DAC driver
Date: Tue, 30 Jul 2024 11:05:07 +0800
Message-ID: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
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
X-Proofpoint-ORIG-GUID: XioP8xUXB20vOzT25Soqb6WXKO76yTrG
X-Proofpoint-GUID: XioP8xUXB20vOzT25Soqb6WXKO76yTrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_03,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300021

Add support to AD8460 Waveform Generator DAC

changes in v2

ad8460:
  * Mapped the fault monitoring settings for overcurrent, overvoltage
    and overtemperature limits to IIO Event threshold controls.
  * Added optional raw temperature attribute that gets data from an
    IIO provider if it is present. e.g. an ADC channel that reads data
    from TMP pin
  * Added setter/getter for raw current
  * Used devm_iio_dmaengine_buffer_setup_ext to setup DMA engine buffer
    (No IIO Backend)
  * Used byte-swapping and bulk-transfer for HVDAC data words
  * Refactored regulator section to make us of
    devm_regulator_get_enable_read_voltage
  * Fixed error handling for rset_ohms property
  * Reverted IIO_ALTVOLTAGE channel type to IIO_VOLTAGE. Setting it aside
    for when IIO backend would be implemented
  * Added attributes for toggle_en, symbol and 16 raw values following
    the generalized sysfs ABI for DAC devices.
    toggle_en: (0) to enable Arbitrary Waveform Generator (AWG) mode,
                   generate DAC output from parallel interface
               (1) to enable Arbitrary Pattern Generator (APG) mode,
                   generate DAC output from HVDAC data words
    symbol: for APG mode, declare the number of raw HVDAC data words
            from 0 to cycle through in the DAC output, a.k.a Pattern Depth
    rawN: HVDAC Data words available, from 0 to 15

Bindings:
  * Matched property name of REFIO_1P2V regulator to its pin name.
  * Added GPIO bindings for sdn-reset, reset, and sdn-io although only
    reset is supported by the driver.
  * Added Regulator bindings for hvcc, hvee, vcc-5v, vref-5v,
    dvdd-3p3v and avdd-3p3v
  * Added DMA-channel bindings.
  * Hard-coded limits for voltage, current and temperature

Mariel Tinaco (2):
  dt-bindings: iio: dac: add docs for ad8460
  iio: dac: support the ad8460 Waveform DAC

 .../bindings/iio/dac/adi,ad8460.yaml          | 154 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  13 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad8460.c                      | 976 ++++++++++++++++++
 5 files changed, 1152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
 create mode 100644 drivers/iio/dac/ad8460.c


base-commit: 9900e7a54764998ba3a22f06ec629f7b5fe0b422
-- 
2.34.1


