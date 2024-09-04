Return-Path: <linux-iio+bounces-9111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED296AE97
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15DC1C23CC1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437538DD1;
	Wed,  4 Sep 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VhoP9wit"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB7CA6F;
	Wed,  4 Sep 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417084; cv=none; b=TFbXzkGSPDolWe4Th0fgUxSEdO53NN+/FobF7MCcQ3vVCdOPRW3p2JB+dmREu6uGRjm9DZsENTGZDY4lW3tJ3fTIAqO6efJaeUjk30oitxh+HU86I74vDdQBgPe4L2S575mF0CzK54SiW4myG9FzGgFfgiRfnxRk/sZJvRXZDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417084; c=relaxed/simple;
	bh=Fnr7pQfn98ey0o3IKxo4X4ToVB48gfBWfZKcSQqR3Ak=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rELKsyIh+pcGxK5OrOGf8Wka8zoiCTnFJnOdYY6vgvjQsRrPO0Btuuhb/FCX6oUXYjG6MVnIlA7zY09E4Vdyjk4+mdCuM5lo1wBzouV3U18S6OWX0hNtU4KOuBjUONW/GZ2T2G1uoorP7UP3EswO5ypTLL3sOZqcsVCSD+9HtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VhoP9wit; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483JmxH7011481;
	Tue, 3 Sep 2024 22:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=XblLSBqZhlYBcCyJvCH5qEcXMqj
	shkxYhWV0V9vXQrA=; b=VhoP9witv39r16PGTGnauSnpoF5Xo7hNZQOm9OKEOE5
	sViaHZ6obm9F6eB6E9TJ7G50XqvI54N0YLWRTXoNpmZWtjhqJgQO+X5bmSqs8mWF
	BaGI47pLbBNVml+uB6uYT1/+ihLWxwCIl+Auox56NosFbEbAriDTaGohgD+MuBU7
	n2AEv+aN+5RoyGgenaaJ1lMJG46olnhx+ZnVvGBQXmQ+zW02PbMfa+CXHpeuwNED
	ErDgwFtO0omFuMC0YQcQ/QNdpqvKHHUdAuBIyp5YHgdGsgTzKZsui1By0k69jL07
	rPs8FTDZWaNycx9r0N+jGPl+u76euOtR1HR+PjSpckw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41c0325t4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 22:31:06 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4842V4Q0037366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 22:31:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 3 Sep 2024
 22:31:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 3 Sep 2024 22:31:03 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.121])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4842Ujtq000342;
	Tue, 3 Sep 2024 22:30:48 -0400
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
Subject: [PATCH v3 0/2] Add support to AD8460 Waveform Generator DAC
Date: Wed, 4 Sep 2024 10:30:38 +0800
Message-ID: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
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
X-Proofpoint-ORIG-GUID: vyLneMN1VqojX8QbxX8ZrxpahABuzDPM
X-Proofpoint-GUID: vyLneMN1VqojX8QbxX8ZrxpahABuzDPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040016

Apply comments for adding support to AD8460 Waveform Generator DAC

ad8460:
  * Fixed errors detected by test bot
  * Applied proper masking of fixed values
  * Applied proper wrapping to get close to 80 chars
  * Applied proper comment formatting
  * Applied proper placement of breaks in switch cases
  * Removed channel properties unused by IIO buffer interface
  * Simplified property getting on probe function
  * Fixed error handlings on probe function
  * Fixed setting of overvoltage, overcurrent and overtemperature ranges;
    If value provided is invalid, default state of the register will not
    be rewritten

Bindings:
  * Dropped unnecessary descriptions
  * Updated property descriptions to describe functionality properly
  * Added multiple selection of values for adi,range-microvolt property
  * Fixed formatting errors to follow DTS coding style
  * Lifted GPIO naming from gpio-consumer-common yaml

Patch:
  * Wrapped patches to 75 chars

Mariel Tinaco (2):
  dt-bindings: iio: dac: add docs for ad8460
  iio: dac: support the ad8460 Waveform DAC

 .../bindings/iio/dac/adi,ad8460.yaml          | 154 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/dac/Kconfig                       |  13 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad8460.c                      | 932 ++++++++++++++++++
 5 files changed, 1108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
 create mode 100644 drivers/iio/dac/ad8460.c


base-commit: c4b43d8336e52dce6d124e428aa3b71703e62647
-- 
2.34.1


