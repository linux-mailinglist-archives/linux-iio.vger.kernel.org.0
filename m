Return-Path: <linux-iio+bounces-5537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED988D6325
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F62B27458
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E5158DA8;
	Fri, 31 May 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="M87+et4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCA33CF1;
	Fri, 31 May 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162603; cv=none; b=Scttjbsp9y7lpFFSCZZhSgVzrTQdZ4TktUtMqEU3HygF4ztmiYlChKmzEy5g97z9ePjLQZVIUI5OBombh7SRMCBEXqZ2uf7VbyxfEw5Y/D1hGIzGYb6ZomG9GihIt5bOZCieVA8ypksPRdDSKCEzwRZpheITjqS9Be8vVAyN0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162603; c=relaxed/simple;
	bh=fn20dGx87hZm43/fi8GvAgBZOI7xvT0Wysw5+egYsAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XEbfyUirz/fj9DtGWPIkNsNZWbkQS/JS601CqxGqifXX8i+5aYG9zjIS028w2Haf4s3eTxkarZUKR2XJk78StpM01pogfTMTiayqhiCS9Rw9e7IkW9YBnhY7vXb+PyatbAUtEIt+Z7QE3hK6R6M5sTgUBz3roUWGVfVp+g83a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=M87+et4K; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V7sUfw030255;
	Fri, 31 May 2024 09:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=rkyvpbvPE8YaG4nx3cDWUbOvROT
	VXz82CU723yezSMM=; b=M87+et4K2c2FODmniSRuBrCBKhNQaef+R+vcrB2aNko
	Yu0PZafl0mSBBsI8zdAvryI/GpitDYH5P2vF5ejHntthkJo3EUC5TOdw/cO9yMMQ
	S/ysr7oiqNMEikE53N4Go3XMtdlarhdOe16ofM58/pFTxgGj/dimErYWdvXrP9SM
	nQMYhD7E8BrkrWL0evzDdzlCC421qTHwzT1r5HXs8h45igfI4ALKoZCb7UcQBygw
	PFDdh+PFgTipCVevsE2tQz3+l4UZz4uq3WEIROjOlqGJk4Yad5SxgavKZTQhHLFW
	h34sfZbr/jn5TgL8L+Vm4LiBVfEa/Cta35fW6ZmbUOw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yb9vq0k34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:36:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44VDaQ2T063998
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 09:36:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 31 May
 2024 09:36:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 31 May 2024 09:36:25 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44VDaF86020041;
	Fri, 31 May 2024 09:36:18 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/1] dt-bindings:iio:adc: correct previous patch
Date: Fri, 31 May 2024 16:35:51 +0300
Message-ID: <20240531133604.1380-1-ramona.nechita@analog.com>
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
X-Proofpoint-GUID: wPiWAEBf8cNbd47hJ5HGqQHcaUbbEE8G
X-Proofpoint-ORIG-GUID: wPiWAEBf8cNbd47hJ5HGqQHcaUbbEE8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=712 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405310100

v3 changelog:
	* remove clock-names from yaml file
	* update name appropriately 

Ramona ALexandra Nechita (1):
  dt-bindings: iio: adc: add a7779 doc

 .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
 .../bindings/iio/adc/adi,ad7779.yaml          | 87 +++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml

-- 
2.43.0


