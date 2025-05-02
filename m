Return-Path: <linux-iio+bounces-18962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DABAA6D40
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B13188E269
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93822DF8A;
	Fri,  2 May 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kDV39Dzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B22B5BC;
	Fri,  2 May 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176382; cv=none; b=F5Zi5MkAWi6sMMNGIlXGTwLS7aEmHvmiHJC9dLVanYbgqWo13n+11L+jqqOs2bBzvB/gfb3FqFMCJZPWlvU0A1wwzIjyIBMVYXa/14MJMAYgFIl3pJvbZqlRZAj5YFi8myH0Y4Iid0qVnoSkiPqJOPKCKUzPyszyOmFF8kpXJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176382; c=relaxed/simple;
	bh=o8DGWtf3j/QZNiMhxiHZvikbZyLGBOWmz0ZY1ILiOMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSufqHnAyVItHJbjOhwdg3j3B+fEEZO54Kqd1jWOuUjXh3Nw/7zlM0rkUlbWuUYh2IJgmRsNoiaOth4qTtNZDEvDjB7x1wFdfeMMULVnuZyQoQz+P/XNEmONXWYqbQYz6Tk+8O09IZaeiynPBnrzHMXxmJl53e4Hx/04JuuomQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kDV39Dzi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54263tvA019299;
	Fri, 2 May 2025 04:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Et6yvxhJOxhR2wQ54MbbiDYYzv/
	zTXJFQWtEOb+6oMw=; b=kDV39DziItzaqC1abs80j/bmPVskWWuLrU9IM2Hn2eF
	GonnDGQb68u1vnJ2AxxsRR8pyKoardFQTYXu5LDhBKw4QAuUisk0xS29vcfw53CL
	kJBUy4Wuv+eRaJMh1Tq6Vgn282R6JT45TMJDE6tGX4g71MK6NCtAWDzZkCuMmIcf
	8R+AjjGfYeYkUtgNU+iv2bRUNgPbsqRLlEZpxw1LP8cWhWd+QaxkgUchhue2RU4B
	nJIhsiX67NzNzY/6ToEIbanTEJialSRV5I3AePK0cSWS7pJTa4YKklFa80piemmF
	ih8QuXwTo+QXvZ15GmENF1AFsFIJnCDC7tO6Cmyy0UQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46cm5pskhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5428xUiW058958
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 2 May 2025 04:59:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 2 May 2025 04:59:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:30 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7J015723;
	Fri, 2 May 2025 04:59:23 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 00/10] Add support for AD4080 ADC
Date: Fri, 2 May 2025 11:58:55 +0300
Message-ID: <20250502085905.24926-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: cA_G--cdEV8p9gDnb3YQiEW69qriaIrg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX0nyr0WCMVwoR fVTDLbDvGS4funYQrSrKKgIbDOE157rsGrRN23gHXJ7LfTCbIi3TGWJsCPF2v1/VhDHuEgHw8fF Q+H55MzikaCznbgBdrCEwApCayqsN40Us4zv5pyTvVuO0OdwcfC7n0K6sXOhNxcsL+8w2fbm/7z
 F9sc2K+PPnXglg+Z0k58AKrUSz8CdMJGM9j4WvVrwHneRG8LKpzkbKgoQR0bH9gCr1LegcIt3l7 r6RlLSaBUeycKRBHmAABR41rjXizSS70K+AqEZuyKRvi+omDeVCTq5ORwmiQekf368OUBTJvMba /Te2Wol0jhf7F6ngNLfir+qHKHRR64AAke6ezSC35EbLBWn6PKL35W9Uo+Smk+RT0nNXUxZD6/s
 iEijHo8Nx+TnjPQ7YDR0RRTsJb3u+ngVfqDmBh7aqHdqf+N7dSAJgRtwmnCJzro7Osd8QVW2
X-Proofpoint-GUID: cA_G--cdEV8p9gDnb3YQiEW69qriaIrg
X-Authority-Analysis: v=2.4 cv=RYCQC0tv c=1 sm=1 tr=0 ts=68148974 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=dt9VzEwgFbYA:10 a=HubKl35eoKcbRmig0ccA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
Drive, successive approximation register (SAR) analog-to-digital
converter (ADC). Maintaining high performance (signal-to-noise and
distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
of 1 MHz enables the AD4080 to service a wide variety of precision,
wide bandwidth data acquisition applications.

This driver aims to be extended in the future to support multiple parts that are
not released yet:
    AD4081
    AD4082
    AD4083
    AD4084
    AD4085
    AD4086
    AD4087
    AD4088

Antoniu Miclaus (10):
  iio: backend: add support for filter config
  iio: backend: add support for data alignment
  iio: backend: add support for number of lanes
  dt-bindings: iio: adc: add ad408x axi variant
  iio: adc: adi-axi-adc: add filter type config
  iio: adc: adi-axi-adc: add data align process
  iio: adc: adi-axi-adc: add num lanes support
  dt-bindings: iio: adc: add ad4080
  iio: adc: ad4080: add driver support
  Documetation: ABI: add sinc1 and sinc5+pf1 filter

 Documentation/ABI/testing/sysfs-bus-iio       |   3 +
 .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad4080.c                      | 569 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  90 +++
 drivers/iio/industrialio-backend.c            |  49 ++
 include/linux/iio/backend.h                   |  19 +
 10 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 drivers/iio/adc/ad4080.c

-- 
2.49.0


