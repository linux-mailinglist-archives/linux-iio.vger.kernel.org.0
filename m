Return-Path: <linux-iio+bounces-10568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E799CD6F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6457E283540
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E81A76AC;
	Mon, 14 Oct 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FDSpz+Mx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8D200CB;
	Mon, 14 Oct 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916362; cv=none; b=IoDhQOS/Hb5Uku9+4V+YBBnYV5irTZQRYIb421iFDX4ZbfOLYtNzxgtQntNusodMPf+4r918nge9N5xNbUNXw87XEJK02tS8aeHQVKNe+5hwvF23FNv1evqRIgIa/ATW8z21xhiXLvd+BNq7xXqF17uAGWfT4N+osSqRxVReNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916362; c=relaxed/simple;
	bh=c0u3Pu/qy15aftAdNYCISXdLMBzECvsxP/W1mOpcBE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YmHvgQJrmoqALIC6Z6+8VyT/kSZyrtClPVwEJlRxoNRngiQaNOgY2a2uA3g5pA17lW4vEPG+iLf7oaPjL8+qm0zq1fjSeF5/1qSNNqo2agklRbBSaBHbBakLBWJU5/jBAZMAlE0aWofh/Cj8TTIve2F3dV0RCIzDAuZes17XMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FDSpz+Mx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EABjsB006039;
	Mon, 14 Oct 2024 10:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TQ7n8XPd6rg1I/RlFcUOK+2lObv
	JUAcI4gx/EAXc3kA=; b=FDSpz+MxG2B3kgTaMYCPIEgtTy1wuhGkStp8G/E3Syg
	gpVt3hu5XXfOWMv34gbtgSJ4SxXlTJkWO+kmzl3w2kybwUVzmfpJwVhbOvxPp+ju
	HTbukYStXslgrmCZWb8dKOYJ5KBjoJbZZIMvvkHVOXG1Ro+teXKvIBNfF9r7ZxSo
	zBaeoHVZV/1yWEIVc31fFbMUu6DJa3mWOI7JXn0cj7ECCemBCoLL+lMUlEfOC17r
	3jKabfJgMzpwn5rVZ7iedRqW9Nr5CeYkm7fGs4OIyooEzoVPvg0u7D9cJl+eLkD6
	Yp40SQUKa4zQrwnobCF+4b03AWs8wQ1xKADDv4Yr+cw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 427p137c4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 10:32:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49EEWK0C041582
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 10:32:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Oct
 2024 10:32:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 10:32:19 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49EEW6bA014258;
	Mon, 14 Oct 2024 10:32:08 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        Ana-Maria Cusco <ana-maria.cusco@analog.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        George Mois
	<george.mois@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 0/3] Add support for AD777x family
Date: Mon, 14 Oct 2024 17:31:57 +0300
Message-ID: <20241014143204.30195-1-ramona.nechita@analog.com>
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
X-Proofpoint-ORIG-GUID: Mu0u1vHc2uyERCcRXk1zhS-8gqjQHpLe
X-Proofpoint-GUID: Mu0u1vHc2uyERCcRXk1zhS-8gqjQHpLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140105

v6:
  * https://lore.kernel.org/all/20240926135418.8342-1-ramona.nechita@analog.com/
v6:
  * Patch3:
    - miscellanous changes regarding coding style
    - switched timestamp type to aligned_s64
    - removed length variable from spi_write/read
    - modified the cast from reg_access
    - used mult_frac from math.h in the calculation of the frequency function
    - declared struct device in probe funcrion and reduced the number of lines
    - removed shadowed error codes
    - renamed spi_transfer structures to 't'
    - added comments to all the fsleep function calls

Ramona Alexandra Nechita (3):
  dt-bindings: iio: adc: add a7779 doc
  Documentation: ABI: added filter mode doc in sysfs-bus-iio
  drivers: iio: adc: add support for ad777x family

 Documentation/ABI/testing/sysfs-bus-iio       |  22 +
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |  46 -
 .../bindings/iio/adc/adi,ad7779.yaml          | 110 +++
 MAINTAINERS                                   |   1 -
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7779.c                      | 909 ++++++++++++++++++
 7 files changed, 1053 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 drivers/iio/adc/ad7779.c

-- 
2.43.0


