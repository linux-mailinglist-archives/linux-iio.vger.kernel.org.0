Return-Path: <linux-iio+bounces-13966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B6A0442C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D188716C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF41EF08D;
	Tue,  7 Jan 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NMcQW15o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECC1DED66;
	Tue,  7 Jan 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263471; cv=none; b=uvvzwgzkw/8YoaADwr+cEPUFM4SlKF4h3FmfylKLzU/E2+TR3NdkIH57r9I6ly8Asmisuag6hX+kDrPvkbSP9rJi6v6NqgPtkctyY7/lPhMxB3hrSaqrIs/YJWSlyX0pdvY8oWCzeYXMc+FaNs8QrGBU+lU8xtV6fSQtG6VDpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263471; c=relaxed/simple;
	bh=MkrfoG76sIWa22D7dqi2QpaHg+wzuVYKFJb3A5uUO2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M1ozFHTXVfkBagH5dCfwqoor30NIyhdtFwWMujACAJ7s2dBMM2MOulctdrW7J83Tbm0iA1LRgIyfpefizXN8vXQk51sDXRXtN3cv1qYiquhkeJIldeDxOssFYguXIfc+AWFnx5OW4q0NC3ylxhB0EnbaszApMkg0bo1SWcDcbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NMcQW15o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507FM9rg006098;
	Tue, 7 Jan 2025 10:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=NnAyAW8lXbeVoLdC5X0oRm0ay3t
	bLxBB31KmKpOCquY=; b=NMcQW15oB8caedLZKCPdWtehZ6e1dbC439FveBU6nXd
	LZsNom4Et6WXs+hpoBMcVix3my3T6VYUbSSW1a5AglofU4Mj1eicTsLOKNilPTxN
	EmsZIIVVsvxTQq8ibfXBGBbAH38TG8EExx8XEVYFWYygHvTKlDCffFPP7jDkugUA
	0TRwFBReUmdqQMxb0Jo2/bL5J0XfE8AEUeLpQ9anTlpwAmd+x+yAWt35aWRx/sC6
	eeYrCaIzIQO0UTGMQTFvsO47uLiuurT16CaPyVX6KnxX4JMdmreSBhlKNGhXkzKs
	CVxeJuXnZ3KGllc01KNKzdd1rM/t3aejqKcaBVwycNw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4416uq0070-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:24:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FOD4C033986
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:24:13 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:24:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 7 Jan 2025 10:24:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:24:12 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FNxOn030241;
	Tue, 7 Jan 2025 10:24:02 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 00/15] iio: adc: ad7768-1: Add features, improvements, and fixes
Date: Tue, 7 Jan 2025 12:23:59 -0300
Message-ID: <cover.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 2YHBWS8yvTx4JUFy-vOtKa7L1gJDZ_gE
X-Proofpoint-GUID: 2YHBWS8yvTx4JUFy-vOtKa7L1gJDZ_gE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 mlxlogscore=896 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070129

This patch series introduces some new features, improvements,
and fixes for the AD7768-1 ADC driver. 

The goal is to support all key functionalities listed in the device
datasheet, including filter mode selection, common mode voltage 
configuration and GPIO support. Additionally, this includes fixes 
for SPI communication and for IIO interface, and also code improvements
to enhance maintainability and readability.

Jonathan Santos (8):
  dt-bindings: iio: adc: ad7768-1: add synchronization over SPI property
  Documentation: ABI: add wideband filter type to  sysfs-bus-iio
  Documentation: ABI: testing: ad7768-1: Add device specific ABI
    documentation.
  iio: adc: ad7768-1: set MOSI idle state to high
  iio: adc: ad7768-1: use guard(mutex) to simplify code
  iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
  iio: adc: ad7768-1: add support for Synchronization over SPI
  iio: adc: ad7768-1: add filter type and decimation rate attributes

Sergiu Cuciurean (7):
  iio: adc: ad7768-1: Fix conversion result sign
  iio: adc: ad7768-1: Update reg_read function
  iio: adc: ad7768-1: Add reset gpio
  iio: adc: ad7768-1: Move buffer allocation to a separate function
  iio: adc: ad7768-1: Add support for variable VCM
  iio: adc: ad7768-1: Add reg_write_masked function
  iio: adc: ad7768-1: Add GPIO controller support

 Documentation/ABI/testing/sysfs-bus-iio       |   2 +
 .../ABI/testing/sysfs-bus-iio-adc-ad7768-1    |  13 +
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  24 +-
 drivers/iio/adc/ad7768-1.c                    | 830 +++++++++++++++---
 4 files changed, 747 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1


base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d
prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
prerequisite-patch-id: c8c8637cb3343097c3224a9aa315fc45dca15f45
prerequisite-patch-id: e0baac9ef84e6e8a0a272fc6191fc1cb48143e44
prerequisite-patch-id: 7e5cad70809fa7d37e917628147c197427c11594
prerequisite-patch-id: 28dcdb0ebc3ca3c02713f83c94a4eedbe81095dc
prerequisite-patch-id: 4a15293f3c2a6504db29ef3de9f09b61accff156
prerequisite-patch-id: 97d1b49e91b5130e527a2e0ac8bd402c2f4a871c
prerequisite-patch-id: 3370db9ec1e67ba97b55607f445ff37c60929668
prerequisite-patch-id: d686dd309e1d3d39d038613f514e58ff5893ae42
prerequisite-patch-id: c832285d7bcc22433f2314a144566aa9437fd5da
prerequisite-patch-id: 3f758a121e36edd43789e80379ff81beeb2d75ce
prerequisite-patch-id: 0ef36ec4d6cf23f08bdb3bc4399ced2561a2a69b
prerequisite-patch-id: c8e7f0e10a2630bd0029ee160f8dfc3f742378ba
prerequisite-patch-id: 5e85d52a87f2a833893eeeac5d1651bda46d0931
prerequisite-patch-id: cd75aba06cf77f8cd398dc7d0c33d94e1277d1f3
prerequisite-patch-id: b813c25db823f1b02d0e9005188d41c0d89eb291
prerequisite-patch-id: 024ac23a16e45e802b70afe9bc464d1caeb41fcc
prerequisite-patch-id: bc084c859bfa93c5764e656bbcbfd4d14e031299
prerequisite-patch-id: 51ebb591fbbb3535899332ce1b106a3f8d6497da
prerequisite-patch-id: 2b396d1069227fee1c5a7bcf33bc63a56681441b
prerequisite-patch-id: c00b841cea6e331e19fb1f31beae831572bce4f5
prerequisite-patch-id: 4fe5fcebfeb745a83a7054390a304a1e250d74d1
prerequisite-patch-id: 461cce4f81f88bbec71580c0743b8970a504899c
prerequisite-patch-id: 59cf79cfa5f091815f578aad884ba0e3f9ae2175
prerequisite-patch-id: d48f6e531e64ee7797890e9f36f849f881884f1a
prerequisite-patch-id: 5f48c69023ecae6b3de595c9a209d1c4d65b5ba2
prerequisite-patch-id: 73e2fc3be282880231105142342b47b00b23ab6d
prerequisite-patch-id: d71deacf6bb4e90e8059a12a94ade36866729fa0
prerequisite-patch-id: 6173a25ddf92a3d1446923d9e87b15642b761034
prerequisite-patch-id: 5b248ee02cc148eeea4f01c435e701b74bc07c60
prerequisite-patch-id: 9fa4f11d62ba0e1ef9f3ca08ef1ee5c1f0711038
prerequisite-patch-id: 6cf99f094cfa8d984a1c1cab8813d1078ee48f05
prerequisite-patch-id: b42c4bf1ce430dccca920f942c6040f641c8307e
prerequisite-patch-id: 89aa3f9cc30768f64d25d4f78c1894c7788ac0d2
prerequisite-patch-id: da2577988502200e7c41abe2097b471e1fe960cc
prerequisite-patch-id: f13b82cb6948394fd2e6b82202dea1e3550a19cc
prerequisite-patch-id: 8f43f603074e7678017e883973abdb200294108c
-- 
2.34.1


