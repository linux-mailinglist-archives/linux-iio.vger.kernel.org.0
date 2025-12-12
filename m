Return-Path: <linux-iio+bounces-27048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE4CB8FF8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4760D305E374
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628927EFF7;
	Fri, 12 Dec 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ASi6eSnu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EF1F91D6;
	Fri, 12 Dec 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550912; cv=none; b=ihoGxrBiDcB4kO72Ejj9wrZ/Zl6hcUN2rRZb3uQ7auHFqjHt5ZsScfD+FOVzQXq3D+QvuH3ozPMYhwv3/fMtFaxOmkL1UagXXg3NQ9c0qn7tufsJRXoH5pyZ8vOxdtqDxyZ/XQaKimdHmB4dE/DfK4WhBu6WNPztQ06P2i9RYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550912; c=relaxed/simple;
	bh=B9MsjF8jDbGFyM9YMCtkkYYWkOnYlxcr5J176JrFwhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f/0XsM/N7a/VBQXhFVlwXMvAsG6vMbiEmRx3xQAY3hhLz+om6Vs2ZwTVCW2nIonhhi+cLRg3oKgYSEADVd7+emMFZHSFy6mhBJWHTA8CgILiYSO2yNIeTKWB6gxk38E+ykTU5afgQ8Lm0wNDpNRGyZhxfAQSJ+414B7ZIxB4rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ASi6eSnu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCDN6Id3816891;
	Fri, 12 Dec 2025 09:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=7Z18IyLgZkofM0H7dWS/RI1l9Wt
	hkykBm2cnJKLfQxE=; b=ASi6eSnuliSdIFaTgPjSNy0UO5FRS7sKkFlnP7RsAvQ
	AO8CJqIzqATG8blsngaDcTYSCQdPnlgR0keFjaWgDDhRqeQEyXtHieVzb+MHILGL
	naaXmZYC7v44sGUgVMVHhYoP232u+fR4Ov8oc5nucIWpu4U49L5EuWroAU2xqDN5
	0E5zIXpIw8rH7Lu6+I/VuzftYe2S4JRzHrnuGT5rWSi4YxPa5+1yzYDvQ4KgaWBX
	4NjZ2xXOD9lUQJs/pgQ00lTFhpx3YUH1R8UcldTCfftQ1gGIZW/FkU1OgzErG7eS
	C4la3bXyQgAmrP0d5YUfUlmIt4na7NkDB9jyPDEQrEA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b07r23gma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 09:48:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BCEm83e042214
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Dec 2025 09:48:08 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 09:48:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 09:48:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 12 Dec 2025 09:48:08 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BCElreZ017338;
	Fri, 12 Dec 2025 09:47:56 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Subject: [PATCH v5 0/2] iio: frequency: adf4377: add clock provider support
Date: Fri, 12 Dec 2025 16:47:30 +0200
Message-ID: <20251212144733.127890-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: MVepxCaDv148Aruy5VWUilJHH0Nn1X3J
X-Authority-Analysis: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=693c2b29 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=xhyw43Vw4g2VkAmxKawA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDExNyBTYWx0ZWRfX4KWoMkDgYd9M
 QCMGk3Tt8bDCGkazX/35zS+DWjpX8cMcghai/u1qG2MEb6f8rqHMkae/B+hPKQTE7uxvPTvM7XW
 jMFyme/YB4Ot6AL/f8y8VKAfUOcgXypqBuzR9/a9FND50stWpIuNlPX4RXbZkYItSNMefqd/b53
 rfOa+ICJa4Y+LgNhuvXIJQZIS3392a7S6mEchKZrSKGzYEsEuaZz05WRA1CcaeQ4ZHSRjpQnXPJ
 jysoCbOCQpDimdZ2dpN9Dmjx/XVRBI8dZ0/9XQncYAZO3iB2wdUq4VlC++ZuaVlRV5Zs+zVXrVC
 C/d1/isUG4xv7ULqYzymVotxzsE0DHKVvOIaJa2A72VGcQb08MCi8fkI2G0x8FQQQ/wRtRkLLxw
 6SVC9VwhIbzjEJLbOtWa9uGp2OvOyw==
X-Proofpoint-GUID: MVepxCaDv148Aruy5VWUilJHH0Nn1X3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120117

This series adds clock provider functionality to the ADF4377 frequency
synthesizer driver to address user requests for controlling output
frequencies from userspace.

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

Antoniu Miclaus (2):
  dt-bindings: iio: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
 drivers/iio/frequency/adf4377.c               | 122 +++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

-- 
2.43.0


