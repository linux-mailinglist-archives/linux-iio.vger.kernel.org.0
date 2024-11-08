Return-Path: <linux-iio+bounces-12031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBEE9C1D3A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB091C22DA2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA01E882F;
	Fri,  8 Nov 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ADjZUYns"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15481E511;
	Fri,  8 Nov 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069891; cv=none; b=qrrJqFeIq2TNct+uFFrKXWUN6LrHaiGHPCtaLPxS0jeD7Sk/QNtOORXh7CxL4D7h54JSiuUTDU+FkPdui1OD4PTDwmPIFh+DVpJsbmmwiM+AmXSvrPjiO/caqEqxLMQQALCOAWXlnspaPKWb2idSr23JIkWDg4fCyZsVxb3o0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069891; c=relaxed/simple;
	bh=VxAWivFUEmSR1sHlx4cQ19rKA4wRFTXr6ZAX4Z/WaiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2AcoRwRDusopggelLBZShgAeIZUkufXuXoLuTh/MwvjfsLCc4b2j1ZRiwDpNFaUKUYYuhz6LgIahueyidyLGg/dswCB+maHYOtCFzMVN9Th/pK/IDG4I9YaZTWQrNAEQhZ/ylYTtz+/KtyOBcNkxWBC6edkGxO55sOLMFWKbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ADjZUYns; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AlxPC018409;
	Fri, 8 Nov 2024 07:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dA1YLsdCaCS/8y/Ngu7ogxG/GOE
	BFopfyix9BrzJi28=; b=ADjZUYnsd/gzIkDGF+DGYbEqitH6i0284KYem6ajFjW
	AgYbTF0Rta7QYlZpE9NS/lMfpU9EfuedwCvHkawtV1NF05MvYkAIoyUn8zYhGwJt
	IhgBm56i95KMpF9OcCpbphxmVHW/DVTzmT8IRpg6hRF3KT+NKKuwM7p/iLoJplxJ
	EMEN6Z8puzQYlNhrbMz8BEWzWb3AoXVBfLtZ0QKMXcFmpOeW4U/4O8GkMR5ahahG
	ZICx23wSjjnTTHpb+njB7HRfuZukb9wNlY7hAn1jguXDNQwvKXmeSZQYZofL6BwO
	C5F23NkOI7VN15TgzWRcKt3KU9FzXax11oT58sc4lCg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6g7k745-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 07:44:35 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A8CiXcD020345
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 07:44:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 8 Nov 2024 07:44:33 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 8 Nov 2024 07:44:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 07:44:33 -0500
Received: from localhost.localdomain ([10.48.65.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A8CiNcX003412;
	Fri, 8 Nov 2024 07:44:25 -0500
From: Darius Berghe <darius.berghe@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <alexandru.tachici@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <darius.berghe@analog.com>
Subject: [PATCH v3 0/3] iio: imu: add devices to adis16480 driver
Date: Fri, 8 Nov 2024 14:58:11 +0200
Message-ID: <20241108125814.3097213-1-darius.berghe@analog.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: pkDzyvyx8KVJNiimEQrj2jdY23ihg_H3
X-Proofpoint-GUID: pkDzyvyx8KVJNiimEQrj2jdY23ihg_H3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=757 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080106

Changes in v3:
 - resend v2 using get_maintainers.pl script, hopefully everyone is in
   the email list now
 - edited the dt-bindings patch to use oneOf

Darius Berghe (3):
  iio: imu: adis16480: add devices to adis16480 driver
  iio: imu: adis16480: add devices to adis16480 - docs
  dt-bindings: iio: adis16480: add devices to adis16480

 .../bindings/iio/imu/adi,adis16480.yaml       | 42 ++++++-----
 Documentation/iio/adis16480.rst               |  3 +
 drivers/iio/imu/adis16480.c                   | 75 +++++++++++++++++++
 3 files changed, 102 insertions(+), 18 deletions(-)

-- 
2.46.1


