Return-Path: <linux-iio+bounces-26545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F1C928C0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7E344673
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8771128850C;
	Fri, 28 Nov 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0xBDVhh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684D22F389;
	Fri, 28 Nov 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346456; cv=none; b=p8slj16AGDhnxIfg7tpaxLWonk0kwyR4OY8wSjni39gHmWfuwBS4TT+HVEgqsDJDMy1/yLUSAl1Pv8p+2V4c0pXfJ93qshnos/3QgJ68Ptw9ab5yKOKvRZWOJ65FtmlS1auBWiRzxIIsz9xe8XTYCVDJo8IOC+b1UTr4FdxUEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346456; c=relaxed/simple;
	bh=MJx2PDinxZPaHAZ5lMDKBEQt7v+A7NDh7oo3tQbbopY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XaVpZpgs1WxQcP1fqE5DqvbQXzx02C5NVbEV1M69zmVh9t/Y/QQ+9B+K0YBd9fQoKqh8VCOeHwO0cPsgKC42s+PMjUetOGt/epKO1qZju+78cLT6/pUvXGZi17bCOB5iQ3207UPk6/ld9bUB24YUxkTXdxVmpRMAG0szkAmNguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0xBDVhh8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS9qM513943452;
	Fri, 28 Nov 2025 09:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TstNbKo0wPt/azh1rRCSzQaWvWz
	KaAHP2U6FHYa1Q+k=; b=0xBDVhh8CHOejETncbwSmmSEHS9cyIYJNOb2LbAxiv4
	I1/vb4yV3be5MZsG46VLyPInepp+TWgE1mp286Oa25OevNMU5oNAnbJjYEQbwrg5
	m8p0UFNW8yKA7C7aGlAYgMhqQwJRYSLgO3q9W4Kk1boH5g67MnjwsDfvgRzlPmAs
	ZMlMgr0BIDq9rwnBnVsEHdWoUhqBcXxY/ckvfcDn3LElPPZzlISyWVHmHm9En60K
	VEmYfmSkm1gKo/wWk+lsIpRSGKB1nWZQKBWyfGdokGUuuEQji7HYUWu/cGIzp9//
	v9l4dNF3eNmWCcHrkuiNybBn0RX2+HxnbZHepzjGpLA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aph60prhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:45:00 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5ASEixjD026686
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Nov 2025 09:44:59 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Nov 2025 09:44:59 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Nov 2025 09:44:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Nov 2025 09:44:58 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5ASEilHo011408;
	Fri, 28 Nov 2025 09:44:49 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
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
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 0/2] iio: amplifiers: add support for ADL8113 Low Noise Amplifier
Date: Fri, 28 Nov 2025 16:44:09 +0200
Message-ID: <20251128144428.24450-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wAvr1Iv5YINOL_sLg9hYIfbU2cc608r2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDEwOCBTYWx0ZWRfX9ZrzlnWZ0Vbr
 c5p9KCFfhR7/Sd1X6METHDoGe3dkVf2Xeoj28R4lsWOsA6TbOkBdjwtSchbR2WSOZLnZtrt4ILC
 F+mt/5KGhSlBNWTIVSG1VLjIK+IGZtHT95sid2mL3x3z77BuV4x5WyHsyFyZ3aykxxn+tFuRsMY
 3COB6EBnzSbWbqH3WH0m9ihfr1lDFR9sqV9Y+EnVjwg0F/G2dPbD9smRz8W6Z9Z5SYZh/6B2vBD
 XnqK469WpsET0H0dfAEYzROTaaaZ2kNI3aiypeFjyJT5S94WOe5WCY/fQ3tMsgIeIIFYs3L8Sge
 fp3EHS6gjaDQUCuVcfMfxajw7FIeJv4H51PlHHtMjoBd1Rh9jDIo/KHXM1eMlfbn/ppggSoWxiO
 ZvinPpHQu1WtcU0jceKC0LXU20IZjA==
X-Authority-Analysis: v=2.4 cv=BN2+bVQG c=1 sm=1 tr=0 ts=6929b56c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nGdWsVW0n162tS-kH1oA:9
X-Proofpoint-ORIG-GUID: wAvr1Iv5YINOL_sLg9hYIfbU2cc608r2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280108

This patch series adds support for the Analog Devices ADL8113, a 10MHz to 12GHz
Low Noise Amplifier with integrated bypass switches.

The ADL8113 provides four operation modes controlled by two GPIO pins:
- Internal Amplifier (14dB gain)
- Internal Bypass (0dB gain)
- External Bypass A (0dB gain) - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
- External Bypass B (0dB gain) - Signal routes from RFIN to OUT_B and from IN_B to RFOUT

Antoniu Miclaus (2):
  dt-bindings: iio: amplifiers: add adl8113
  iio: amplifiers: adl8113: add driver support

 .../bindings/iio/amplifiers/adi,adl8113.yaml  |  89 ++++++
 drivers/iio/amplifiers/Kconfig                |  12 +
 drivers/iio/amplifiers/Makefile               |   1 +
 drivers/iio/amplifiers/adl8113.c              | 290 ++++++++++++++++++
 4 files changed, 392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
 create mode 100644 drivers/iio/amplifiers/adl8113.c

-- 
2.43.0


