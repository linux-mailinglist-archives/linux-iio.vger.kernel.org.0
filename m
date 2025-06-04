Return-Path: <linux-iio+bounces-20204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D64ACDF3C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAD41898F29
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838DD28FFEE;
	Wed,  4 Jun 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="o6K88jz4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477E28FFCF;
	Wed,  4 Jun 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044126; cv=none; b=eozT2KAK3SbZ3B3qQm3ch7N5wg0osErmd+5ENKOEX2GrdO2oBQG+o+8qe5sJ3HKQpFTGPTKU60ko/w2WXOYPZlZUJqUjrx4y6o8bAuOVaZL/oGYm3L/NGodJDdbTPf0TE+mQm4SPVeZnt2R7+aO9aRKiDSB1bGPb9Nd4SzsonI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044126; c=relaxed/simple;
	bh=14MHCMGXqZ8hnz03i1k+6ru6zfgFHOhykC24DOBJxe0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qUZ1dk1bjaupRsCD3IlBRD9f9StOVAKz4keF0Y7KSSJVg3qAgcsbGVUWPAe43CtpIK8029smjJI/DUQ0ikw0mH0IfOTcC6jTgtXq1C/tefdoMDCbtfs0HX8QXJ9dmvGw4eUHq8uHK0NUkSIIqVfwzYFg4POCO3lCCvbv5caIPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=o6K88jz4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554CLYGr030463;
	Wed, 4 Jun 2025 09:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=7tdEpcJIeWUDnxggD3CiG4OsmtH
	omjx/fKgwxqifSJI=; b=o6K88jz4ki7z5zz3mVT0meBcDi4U31ISVhWfRTPq+Ib
	wQ9uDdWD1ALbLKy8+9wxj95EBf4zobn+YELzJTx3Y0zh0C7oZ4jUS3MIsfK4j7of
	2qYx21oEzcAzf0wMs/ptdjIkTz6RCqS2M6J5gJ92ssT6buD8Haf5Xp0zzHTX57mX
	Efhcb6Sftv3B/1lZKvel/Deo0xHbP/7kqmT3V0AGPqf5qKYouHFaTl7YK67r7PvW
	jsneHXkRo2QX6m/cmG54mN6fPz9Bz+yQ+IJ8CKEwHGZyegX7NAeru6D4kQYSiLMf
	7QJnIWZQowJbxYZice3PsKKry0gNvPZGHzIG24GgmLw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vgche-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:34:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554DYrkF030245
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 09:34:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:34:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:34:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 09:34:53 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554DYVPW029277;
	Wed, 4 Jun 2025 09:34:33 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Ioan
 Daniel" <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/5] Add support for AD7405/ADUM770x
Date: Wed, 4 Jun 2025 16:34:02 +0300
Message-ID: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfXxUPZCZYYCbU1
 Wy4Ok/VTIOTaCvdLp/R1KfkVV3HdbAiv3P91cbSdj20bHr77EYRmLmtjgGlyCm9TQqW+t5eQGOX
 wFS1cvTQr1Xdj2bQH9ynee0b/sv1oYQeIBO68VXDgto3wfbjqYdrpzRDn4pMPMbT62qoYyQb2GM
 E1MWrcPP7KUdKMs0cYzIBe7i2ckR2lZIgqPb4NSlAmbUCZJb3S7JCnhePBlJf7etRrXrC6F8ufv
 kTLhNNPKb94YWCaOWuwd+cPbRQcO2FZ5w3R5gaCza/X0jA2LsZ9jrrxDm2wdRHMf68f16IhcytL
 AgCsYqABEijDeCA0ChWDPLIXTt0vm59W/988/ec4RcA76VWs6KswF/wCRuyWGP3u3rbTBE16Id0
 0aYsDVKxM140wK6du3sdyapDcZJNazhtrAr0JuDoV7CHNa53QAWSDpDw6yBgegrvVNwKmR5i
X-Proofpoint-GUID: mtYDiuuKQia1eeZWB03BrqHcstCNYyhC
X-Proofpoint-ORIG-GUID: mtYDiuuKQia1eeZWB03BrqHcstCNYyhC
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=68404b7f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gkbNl49xHU_gtnum-JMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=862
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040103

The AD7405 is a high performance, second-order, Σ-Δ modulator
that converts an analog input signal into a high speed, single-bit
LVDS data stream, with on-chip digital isolation based on Analog
Devices, Inc., iCoupler technology. The AD7405 operates from a
4.5 V to 5.5 V (VDD1) power supply and accepts a differential input
signal of ±250 mV (±320 mV full-scale). The differential input is ideally
suited to shunt voltage monitoring in high voltage applications
where galvanic isolation is required.

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pop Ioan Daniel (5):
  iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
  iio: backend: update iio_backend_oversampling_ratio_set
  iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
  dt-bindings: iio: adc: add ad7405
  iio: adc: ad7405: add ad7405 driver

 .../bindings/iio/adc/adi,ad7405.yaml          |  60 ++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4851.c                      |   6 +-
 drivers/iio/adc/ad7405.c                      | 262 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  20 +-
 drivers/iio/industrialio-backend.c            |   3 +-
 include/linux/iio/backend.h                   |   3 +-
 8 files changed, 359 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 drivers/iio/adc/ad7405.c

-- 
2.34.1


