Return-Path: <linux-iio+bounces-7857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A593B45A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94D11F2490A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F715B548;
	Wed, 24 Jul 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SMeNHCP+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F41598F4;
	Wed, 24 Jul 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836581; cv=none; b=UoQeQNKCJJxp56CjqNhIpCyWVFnX5J55Wd5BZsQRu3uEQ7nbe849XXjTnvy4duHXGbb2opbPxiAKxNx4lazKIFdShcGwVMNPhXDQB1eAhu7duE9S1/wndEkb6ROCn/ihMQGXG0Vu8jolalJBQP4SHoBNePR4aEQqm9f+jWW4dgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836581; c=relaxed/simple;
	bh=K+IgA/6BPzCWNDJbSvsmdW2tWD1rAS4elUTUiihSuXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=frRAZqAlUocwsRjZWOoP4Lr93KwMFAgPt16PDX/zrC1OV/Odi9GKGAEazc3gZDKySPOKEErVVmH370LfqwrQL0SqBVhtOP3lTIG+zu1FuiNySTvBDoBu0VRxh9V248KYzoAO9YXGzkK1DbdBF7cAl3QiurTmUl4qqRoeTXhp+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SMeNHCP+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEVO1s018996;
	Wed, 24 Jul 2024 11:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=C6pzJ2hkyI841OCo/4PPcXfGrDN
	ICpwn9kB3Lwma94I=; b=SMeNHCP+io2Vuj9szx0NljPiukjVMOKYPpptcFcMdRu
	Gzn51BokA2qz1QmKnJpPpokNCFF0VS4t72CUSlltJ79Vq+S5qxJrM+gCypu/GfGp
	pI/vE0K7PJVqIJZXq2eQC6V3GuDx733BUsxS2MSPtTgP7FeQgqhmL50bZzCXzpgK
	mTk/NGrvYol7E53LIUh22Cbze65t7dbK85ZjGyFrkqtIO31uhuoIy6OcCs2KQXWR
	WjnsRTin6S9GlZ29xmw77Ov7bjbJYvCvrWEpZofxs5m5wek7YwB+R0P2PGhKox/+
	FXEYJVfkXdSLrXdVW1rXSg+4traLHj02bpwyoC7emmQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40g732ptqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:55:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46OFtlnr046212
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jul 2024 11:55:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Jul 2024 11:55:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Jul 2024 11:55:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 24 Jul 2024 11:55:46 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46OFtP3Y002602;
	Wed, 24 Jul 2024 11:55:27 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Nuno Sa
	<nuno.sa@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        Liam Beguin <liambeguin@gmail.com>,
        "Ivan Mikhaylov" <fr0st61te@gmail.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/3] add support for ad777x family
Date: Wed, 24 Jul 2024 18:54:37 +0300
Message-ID: <20240724155517.12470-1-ramona.nechita@analog.com>
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
X-Proofpoint-ORIG-GUID: 1SKF-XB7NWNEtO8-AGu-_54E8CE-f1-J
X-Proofpoint-GUID: 1SKF-XB7NWNEtO8-AGu-_54E8CE-f1-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240115

v4:
	* updated commit description
	* removed misc indents in private structure
	* removed "_filter" from available filters
	* updated calibscale/bias functions to use get/put unaligned
	* switched to iio_device_claim_scoped
	* added comments exaplaining necessary timings/buffers
	* misc line breaks/wrap fixes
	* switched to iio_trigger_generic_data_poll
	* removed writing to indio_dev masklength
	* switched to kernel_ulong_t for driver data

Ramona Alexandra Nechita (3):
  dt-bindings: iio: adc: add a7779 doc
  Documentation: ABI: added filter mode doc in sysfs-bus-iio
  drivers: iio: adc: add support for ad777x family

 Documentation/ABI/testing/sysfs-bus-iio       |  22 +
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |  46 -
 .../bindings/iio/adc/adi,ad7779.yaml          |  85 ++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7779.c                      | 952 ++++++++++++++++++
 6 files changed, 1071 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 drivers/iio/adc/ad7779.c

-- 
2.43.0


