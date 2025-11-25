Return-Path: <linux-iio+bounces-26454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF3C85D4B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6766D4E4A56
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED11DF748;
	Tue, 25 Nov 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D1ftxBU7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9819EEC2;
	Tue, 25 Nov 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085732; cv=none; b=sfdUXsoYDuIFQGdtOmdtNVy2Q/1yLJWoZEH2+WwRenWxUh5BbZ7v6TppwSwvQ4oe2NLTBqYAdbrQMBy2Y2P3kHpIi9IB0jhQqEKirgA/FMbeaLUkt4CfpBK5xYigiGwZI3gLoGxC5z7uPnB20/nUKu9+gsK0dogLKXJ/Rjg0OUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085732; c=relaxed/simple;
	bh=2teMj3cExIXsm9hsdukC9nhaUQVP2+3nDr8+6xIGeaY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMAC30B5nFhNdNXjnQOqVa2n2bdTCj199zSiqqbVXtlADiXCi5g9Jwv6IwDF6QF3DZTIffXZofIrU4gpO031V1XJeQ0lx4+vOeuUawwZu1Ktnb6kFj7re0uIP1coqKdl9GPoAzDY2hbZf9YW/QtlH5XCER2hJmysQsCf6Q3wy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D1ftxBU7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APCRTPO044275;
	Tue, 25 Nov 2025 10:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+5scGOfH4VdfvjtRMp+VExSIh9M
	yBhIa21tCApXEYD0=; b=D1ftxBU7bTI6fvy1EeRR5ZxfK2/aFrWxrDC+FSOPIP4
	fR/mYGz2bAhuR2fEn8AL2IKQbkvTg0UrDOIhs4d+eOM/70OAkBW9jpsFtn7Bbb14
	MVPQMN0bW4OPO1DJNClTITzIgZudpT+yGIA6BNnAPc8qDYkfJsnuH0L4qbR5z9+w
	UaGUNt/08i8h7qQRYB4YaKZlGiRhSUt2h7spCOQwue5sQndsaIM8eA5CM5h0np5I
	7g1Vt2YY1gc/smv1Hrm5nt7TTcJRK6ax2pSZOAvk99/0VHKj+hrIerIuVphpCRLo
	FMjTvAmUYWK0l51GAguABj4I1WyiP7rarV4AVQiD8nQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4amv1gnj1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 10:48:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5APFmLau016014
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Nov 2025 10:48:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 25 Nov 2025 10:48:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 25 Nov 2025 10:48:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 25 Nov 2025 10:48:21 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.177])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5APFmAEF021473;
	Tue, 25 Nov 2025 10:48:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v3 0/2] This series adds clock provider functionality to the ADF4377 frequency
Date: Tue, 25 Nov 2025 17:47:34 +0200
Message-ID: <20251125154738.55869-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEzMSBTYWx0ZWRfX5rDsDe/VRGJZ
 qNiY379MULWD9iQh39Y6feAc2meeI8DFUkx2M7Bb/FqNKAQU/5FXh990HkA4dWr230Y0wkq0xJZ
 ilN4Jz/01N/JTDx8odZk3LQ32vOPFMqPCXzLJtcV29fWu14Br8wQXaGXwOxyDXsQF00NKZH2rOX
 WAzAMfC2S9ZEnMFhqirnb/ldKsV55sNrobJezmDSronPhoTbMFh6HPrISfvKmj2p1eSudCwDxJW
 oP8SovKmqDIjB7qAM0YzRii0wMCcxFase3PXTCfmbkYYZ+P263OwZsJSb2tbTcmURGFehac5m1w
 7IR/9tdyO1chDCmjJc2lnVmmB5NnmHcOt17jV+7uKtn/QU41IEJt0FiiMe9GCwhZ/aNCqoMUjab
 v2kV/H5yoOOjMAA6rn7eDXoQS86epA==
X-Authority-Analysis: v=2.4 cv=D9hK6/Rj c=1 sm=1 tr=0 ts=6925cfc6 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=TbiDcMNEsNnl46sf-WwA:9
X-Proofpoint-ORIG-GUID: 9UZe-ybXCoaxH7Xulbt7-PSujpSUBrM7
X-Proofpoint-GUID: 9UZe-ybXCoaxH7Xulbt7-PSujpSUBrM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250131

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

The current approach follows the recently accepted version of adding
clock provider for adf4350 device:
https://github.com/torvalds/linux/commit/a1a09713b40dfc1c0b7d1f9233a7698c93a9af05

Antoniu Miclaus (2):
  dt-bindings: iio: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
 drivers/iio/frequency/adf4377.c               | 119 +++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

-- 
2.43.0


