Return-Path: <linux-iio+bounces-13613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF59F68B2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A369516387D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA261BEF6C;
	Wed, 18 Dec 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T6C36971"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C5199EA1;
	Wed, 18 Dec 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532666; cv=none; b=Gy4tVsr7xHxZ+4vNLacUfrcQxg065XQOfohwi2ButqTIefhfQs5qLOj3Nj8dRZXHklfKwHicPIzn+xW7aFUJcZYX0+Y4YXsXLEsdjjQOmz0cjfANoO/BWH9Qylnp5wzndGQbDBzlyrMAyuCJBoSeMv6Yt4aCNDUj6Lt8rN7i/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532666; c=relaxed/simple;
	bh=Qmm4KBkY3reT/YQX878vAWm3kg5dKLeeD6CzGyp7KMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7OrmAus5MEI8yk05eeEnoNW9StnAwyDZ4urgUjgX8wwZQf9PhBVLsOaaaImKKWRjaiBsgtZaw1Ft+AagRJrTXJlIssWzF4QKodFtpHjN1P0QlFyscVrgMuOTbEjWRYJc4Sp3tf90yEFFQo9pHYI8sKf7iOE9GJGn1ulIHZw+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T6C36971; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BICgWiF006384;
	Wed, 18 Dec 2024 09:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=38MO/nF0YX0X8BxIQXwVnYC5JfA
	D59WTFa8cJDGJcCI=; b=T6C36971BXVGDvPwV8kuqI5SkyHJVQavN+xZwKySBgG
	oYmQPX5tdtUgVpyv+m5cefd7jvb+xkLOoXu/su/cnWk/uKpRTzL8PX9CT2SUjCDx
	drb7nX8PH1CIxtXXaGdFCPk+cSTjB1tTJ2R05yH4G/802FA6D2511tOtkM8dlRpl
	vbmlUwR/F3k1AaVIGHxVZv8enzQpQ2tMP3KM+jc8FxIAon6r7Sd0DemGv+pCQxi+
	qzuuvOvBFtp0Z8OP0x8gsBQ+7NixXt0kdQCzGs1zS2Ucjf2owomP6tUDkifL1Xs5
	7jmQyZ/wn8WsVgNJSQTo06wzoc1d+ROZUHtQl0Iiw9Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43kxmr0gvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 09:37:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BIEbGFS022640
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Dec 2024 09:37:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 18 Dec
 2024 09:37:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 18 Dec 2024 09:37:16 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BIEb5eC030544;
	Wed, 18 Dec 2024 09:37:08 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <ana-maria.cusco@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [RFC PATCH 0/4] Add support for AD4170
Date: Wed, 18 Dec 2024 11:37:01 -0300
Message-ID: <cover.1734530280.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YMVXyVSwYe4itCuyAQDfqBFxJxtDoWSM
X-Proofpoint-ORIG-GUID: YMVXyVSwYe4itCuyAQDfqBFxJxtDoWSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180114

Add support for AD4170.
Initial driver for ad4170 was inpired from ad4130. Then I picked it up from
ADI Linux repo and changed a lot. Clock provider support is the same from
ad7173.

Most disruptive things are:
- Draft support for negative/bipolar voltage reference supply.
- IIO channels sharing setup number will share configurations.
- Draft ADC documentation to help clarify/explain why so many possible ADC
  input configurations.

This is big so not expecting to receive any review on this any time soon.
Happy holly days.

Ana-Maria Cusco (2):
  include: dt-bindings: iio: adc: Add defines for AD4170
  iio: adc: Add support for AD4170

Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add AD4170
  Documentation: iio: Add ADC documentation

 .../bindings/iio/adc/adi,ad4170.yaml          |  473 ++++
 Documentation/iio/iio_adc.rst                 |  280 +++
 Documentation/iio/index.rst                   |    1 +
 drivers/iio/adc/Kconfig                       |   16 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4170.c                      | 2049 +++++++++++++++++
 drivers/iio/adc/ad4170.h                      |  316 +++
 include/dt-bindings/iio/adc/adi,ad4170.h      |   96 +
 8 files changed, 3232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
 create mode 100644 Documentation/iio/iio_adc.rst
 create mode 100644 drivers/iio/adc/ad4170.c
 create mode 100644 drivers/iio/adc/ad4170.h
 create mode 100644 include/dt-bindings/iio/adc/adi,ad4170.h


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.45.2


