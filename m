Return-Path: <linux-iio+bounces-9788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A89874DC
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 15:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C9A1C24D85
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BED85956;
	Thu, 26 Sep 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b+gHcNSr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11961FCE;
	Thu, 26 Sep 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358929; cv=none; b=DwYMOJvAzkAzpgPRJjRqW5kfPZY5ibPgUrbHQwkq9Ew8rkavktSFbxOOTZSz9Q9Y6WhldKR2IIgEh0M3+qG8VTjHCBdRYOfybII7MjF+Fr9MWQ0WbHIYRZBjT0fw7IY3FHeCSKbgpeZN2JTdew/b7KFfvy0TFpuJarYuPe0aKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358929; c=relaxed/simple;
	bh=MT5RgNg5ejoyABv2DnAC5R8iei9s75Gq6ll3CAlDrx4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TueNU6d59JdEwpEyRm3jS4ZEZtz+olLvL1zRtT+01e10MfBRvixEaKmhoPsMz/N2jsbWteOsA2qYxcTcYyhdQ2+byqXsgdADKtAT0Lpqc9voJc5bp7rhedUS43lgSXbY5Pm9vxoC0dY8qTId+LKurjT32ZYWU/CF+5Zyb0omGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b+gHcNSr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QANYQE003176;
	Thu, 26 Sep 2024 09:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5LtC3+KBU6PxL4QWHgOSrZHurH1
	ezQUKgxpuRbophHw=; b=b+gHcNSrFiUASldf8cN/SYb6yvxotNFhxQiD8/TmtS3
	FI5fywHScbMj5HR6w5XKvnsBZ7uPdVafoUUzpFJS0C+BOnhehoo2RWoy+JTDBrHc
	EVViXTqZb1c3RgMRwdMFdWt9Os5XAN8ANUTitYDcWBCnhynIu+e+iS3ZjSPnpyJv
	4Jp5ckRgJQZWuqKYI/pu4NzXXj7FRMQVQad2XZdKcCDWpb2PNqW1I9lJS4KP+dIy
	HG/zwgpolxMVLEF3T9tz6MOaTD9U7NIxGsSN+xUsc5Ek2xzdqTJI4j4vDD344EE3
	P3DDRVml0DwShpgs8Hsns4q/ex5Ode2AyOlTgOkMWDw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41u3fs9k9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:55:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48QDsnUu045770
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 09:54:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:54:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 Sep 2024 09:54:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 Sep 2024 09:54:48 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48QDsUFg028460;
	Thu, 26 Sep 2024 09:54:32 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Matteo Martelli
	<matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 0/3] add support for ad777x family
Date: Thu, 26 Sep 2024 16:53:54 +0300
Message-ID: <20240926135418.8342-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8c7KvlwIVj5OiWHpsTLxOVNkgc8Jzc_l
X-Proofpoint-GUID: 8c7KvlwIVj5OiWHpsTLxOVNkgc8Jzc_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260096

v5:
  * https://lore.kernel.org/all/20240912121609.13438-1-ramona.nechita@analog.com/
v6:
  * Patch1:
    - documented power supplies
    - added interrupt names and description for ALERT & DRDY
  * Patch2:
    - removed the referenced file from MAINTAINERS
    - updated the commit msg mentioning the version changed
  * Patch3:
    - added comments to explain formulas
    - fixed typo in commit msg
    - crc is no longer calculated when not used
    - regval calculated in one line
    - updated variable name kfreq -> freq_khz
    - inserted blank lines for more readability
    - created a structure for buffer data in the private structure and used
      aligned _s64 for the timestamp
    - presence of irq is checked first thing in the probe function to avoid
      allocating resources for nothing
    - initialized ret with -EINVAL in probe
    - wrapped closer to 80 chars where it was possible
    - removed check for buffer enabled due to redundancy
    - restructured reset function to share the same fsleep whether or not gpio
      is present, and to avoid redundant memset

Ramona Alexandra Nechita (3):
  dt-bindings: iio: adc: add a7779 doc
  Documentation: ABI: added filter mode doc in sysfs-bus-iio
  drivers: iio: adc: add support for ad777x family

 Documentation/ABI/testing/sysfs-bus-iio       |  22 +
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |  46 -
 .../bindings/iio/adc/adi,ad7779.yaml          | 108 +++
 MAINTAINERS                                   |   1 -
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7779.c                      | 911 ++++++++++++++++++
 7 files changed, 1053 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 drivers/iio/adc/ad7779.c

-- 
2.43.0


