Return-Path: <linux-iio+bounces-12251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC99C8B5D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F6F1F24F30
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B241FAC50;
	Thu, 14 Nov 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GCpUSMvr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F927466;
	Thu, 14 Nov 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589452; cv=none; b=S8gQC1lJsV/UIpxhXJm7HdDVluVYRiX/iqlSvEV8tOfCRqBF7yV53BhPoInKklJRJW0VShRK3iGRT8w2lSLibSjiZazGKp6fJYfD4lpn29UKp21ryRyIMV2zraIIvQHGowkJ+D3jS9hbXoBHpkMLrtWtwt4qvZkqs5gmtYYuLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589452; c=relaxed/simple;
	bh=34vR+sIJdQaBLysw5+UwbRAEiNNJXROKTTLuTJX145M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ez1kK5qrdcsI1QJY1R8XbV+Cn/gz92X3kxstTaZV/BYNQD6iEiZOi45UQvy2gjypVJ3XD6cXI4cgRCLYUN25g9nNSThyd2J4EdZahe6r9NSx8UUkY/vLWDK4We/FjTW3FqqOzXYQGdXDVO/hbltiblzZ8jpmua1nsSyCNnHX3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GCpUSMvr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED2afO001369;
	Thu, 14 Nov 2024 08:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dJADhDHCnEd6Gdp76WtXbyFeqsA
	1YslUiVBa38vR55o=; b=GCpUSMvroqNbtlZv7hf3pMYCee1SbQ6+jTY00mKL7Mg
	0F9f2leh55cjVE96xBgx7+pdgjBiqTqsi398flMZXRZjSidpYKsXb4Rny5loXs0g
	c5FAxv2CTH1eZBCwOze3r8K/+xIQzAiNdz8PSjwco5bd0knCKHodqRDVFujZLyqm
	6BYw9YUdxBUWO81X0XuoVyp+wfo5uXTT+/2vvnSpuMQuYwvMcJ+OYtuletjfRu0H
	m354jAxYojloS2Bu/YinRCBVK8odQuGArf7Aj7DJL2+x9mTZAEkXDAjj+y4g5t/8
	bGIi+24O4Xs4BJ3kzveb/BuQdUJf4Hr1HNxngNjUv6w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42wdrgs9rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:03:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AED3sRH054381
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 08:03:54 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 08:03:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 14 Nov 2024 08:03:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Nov 2024 08:03:54 -0500
Received: from CHEGBELI-L03.ad.analog.com (CHEGBELI-L03.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AED3hfk030605;
	Thu, 14 Nov 2024 08:03:46 -0500
From: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Kim Seer Paller
	<kimseer.paller@analog.com>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for ADF4382
Date: Thu, 14 Nov 2024 15:03:09 +0200
Message-ID: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
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
X-Proofpoint-ORIG-GUID: 0wzmDuIw8pquaj_KDq9Eu-YJLFLeLOqh
X-Proofpoint-GUID: 0wzmDuIw8pquaj_KDq9Eu-YJLFLeLOqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140102

Add suport for ADF4382/ADF4382A driver and dt-bindings.
The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
with integrated VCO ideally suited for LO generation for 5G applications
or data converter clock applications. 

Ciprian Hegbeli (2):
  dt-bindings: iio: frequency: Add ADF4382
  iio: frequency: Add ADF4382

 .../bindings/iio/frequency/adi,adf4382.yaml   |  141 ++
 drivers/iio/frequency/Kconfig                 |   11 +
 drivers/iio/frequency/Makefile                |    1 +
 drivers/iio/frequency/adf4382.c               | 1825 +++++++++++++++++
 4 files changed, 1978 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
 create mode 100644 drivers/iio/frequency/adf4382.c

-- 
2.43.0


