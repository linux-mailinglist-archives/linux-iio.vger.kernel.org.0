Return-Path: <linux-iio+bounces-9461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C79768EA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B69B219C6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67E1A0BEE;
	Thu, 12 Sep 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vvd4ZVYX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825613D503;
	Thu, 12 Sep 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143450; cv=none; b=IuiuN9XWNn21WgNjbM7L/YUnMXWwzgpZxC3lrROQWs2ryxUZvD/9138r8jY7yKQGE4b96+o2y510qcTd8nJMxpMyXMmBQDruqSXce0piMqlQ4EEDu98kbJVCaciVV/vRAUgr8R+tJUsvcQWryi0DC6I55naj/hbUZJ3pAm/CCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143450; c=relaxed/simple;
	bh=QU0/XcAuMjbFqPEK5OmsdkwX9rgEdkv9d7CT9Tfz5oM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2mh190AI6qCxbvBWVBXwusIiBp3wINZv7RWRAq36XdwufwY6kW/5AlxY/SSz2zMTjsPn9cwbNjQeF8EWgeTuxSewrpQUMS5XA+FwjiJnh5m0QAH7e1vnKxkfubbrWBNikhD1Bc50zYYYcPYR5rMgf/Ky88DLt21t2sF0ImDFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vvd4ZVYX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CABUoR022577;
	Thu, 12 Sep 2024 08:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=P3PjALF9zww95ekjbJDrq1uAb0g
	vhpPGrRKBEYLoXJo=; b=vvd4ZVYXqASZDxQsu7CVenDuOknGTTafSKqfvYmnzsA
	/5pWrVgXQ8WxyYK//Z7Exykxn6uc3s1R9MOpPFzKel4r5VWEWVahsDxDCCKJg5Nd
	1nffmJgzWeJgdu2mmwad8P61HKsO1+5P44oX5TM9+X2browxdLWTGbZJueEaZRvq
	GAxq1vG+TJzszLk78o6M0uclBzsm5vA4Y3HM1tclggTI49Fp2MMPMKVnhKrcFJtD
	UnfAo5v9JprzrszQHiGzasYPPq/keqc4wInhU7UDIL4kD9w8cHwA95ALSFkRIKN/
	K8JH284qG3cIPuzaEMMHydSRNlJSO1img3Z30REZ6og==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41gybduy8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:17:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48CCH1F9012014
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Sep 2024 08:17:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 08:17:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 08:17:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Sep 2024 08:17:01 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com ([10.32.223.254])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48CCGg14009956;
	Thu, 12 Sep 2024 08:16:44 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nuno Sa
	<nuno.sa@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Olivier
 Moysan" <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/3] add support for ad777x family
Date: Thu, 12 Sep 2024 15:15:44 +0300
Message-ID: <20240912121609.13438-1-ramona.nechita@analog.com>
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
X-Proofpoint-GUID: 0KhUchy6sZcPz-T-mgM5woI0gJf7nacH
X-Proofpoint-ORIG-GUID: 0KhUchy6sZcPz-T-mgM5woI0gJf7nacH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120088

v4:
  * https://lore.kernel.org/all/20240724155517.12470-1-ramona.nechita@analog.com/
v5:
  * Patch1:
    - removed yaml unnecessary nodes
    - removed vref_supply from yaml altogether, as it is not used by the driver
    - documented interrupt line in yaml file
    - updated commit message with short description
  * Patch2:
    - version downgrade in sysfs-bus-iio file due to combinig the two drivers'
    attributes together (one was available in 6.1 and the other in 6.2 and it
    seemed right to leave it as 6.1)
  * Patch3:
    - removed comments with old code
    - fix commit messages
    - removed power_mode from driver private structure
    - used spi_write for ad7779_spi_write function
    - fixed various indents and line wraps, typos etc
    - used goto in trig_handler to get rid of duplicate code
    - switched to iio_for_each_active_channel
    - removed unnecessary trig setting (done by devm already)
    - removed __maybe_unused from driver suspend/resume functions

Ramona Alexandra Nechita (3):
  dt-bindings: iio: adc: add a7779 doc
  Documentation: ABI: added filter mode doc in sysfs-bus-iio
  drivers: iio: adc: add support for ad777x family

 Documentation/ABI/testing/sysfs-bus-iio       |  22 +
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |  46 -
 .../bindings/iio/adc/adi,ad7779.yaml          |  84 ++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7779.c                      | 917 ++++++++++++++++++
 6 files changed, 1035 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 drivers/iio/adc/ad7779.c

-- 
2.43.0


