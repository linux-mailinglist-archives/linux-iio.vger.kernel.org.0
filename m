Return-Path: <linux-iio+bounces-15365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BEA31635
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6EC3A25EE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4826562C;
	Tue, 11 Feb 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JbJdRzQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB7265601;
	Tue, 11 Feb 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303935; cv=none; b=RDaB6buaheSFC309z+MUVOFlxli6P/6wRtJpvsAoQaWbGxpzKGmHChjCYlBiZRhbHEgwsAhdKgyMy7PAO1wqG12t2ALKCOhjsTwvx6vU6aFYqochsgyHOgc0zbBmsEanSRN1NFqtbkzIiX440my8KyTpg8ICszozcwlr21ofj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303935; c=relaxed/simple;
	bh=dXrQKTowhcH6aYf16tasRNrt4H28GYsSCzuKO49/K4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLSbU2ese2KAtbgqK9lAHDA2qJkzCxWqx6JY6GcPRXe1t8dyrIGha9YtU4vVj3B5Zm5R59DiPdguN6uPxuU/b9muze3YD39PMPUauNUugVvHbtWKHr8+axRhHWfrcOrxVk7srQnCky4uLg6G/S/e2tFVJPmIqJ18uJVhFXDEbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JbJdRzQ+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJAG2R002756;
	Tue, 11 Feb 2025 14:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=tWWyMB1CD2IcO9XjxWYtDk7+nQm
	rfd/CSOL888tfyBc=; b=JbJdRzQ+/aNBRIdFZ2ofQRX4wKvIgYpSF3GMrc6oePZ
	RTm2DBmCFImchT3I08WZa2ztXnJG2CcypVqeEcxaLzZLc2SSd/aZvICwI4YyME7G
	5A5q23kpz3V3vF4zIav9EFc5jr5Q9zhP/QXhdEAtPKs5K3QPKEwV+ygELspRYwGJ
	WqfVuVqqDyaUPgO/Xbdzkws6KTnthTcpIUvwLweJ6NsFMtLmr3RHeCirEt8HOmiF
	I1SuOvQrtkoOHAdUc8+r3II0Ep7cgP36lN9kOBN7WtNSzaGPvAhY7FbOPmEOfYHj
	IHFMUjffmIbpodZQ3759GIp8zea9Ol+MY7wclMu12kw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857hd0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 14:58:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51BJwQ2D048362
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 14:58:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 11 Feb
 2025 14:58:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 14:58:26 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BJwFR9031076;
	Tue, 11 Feb 2025 14:58:17 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 0/6] Add support for ADIS16550
Date: Tue, 11 Feb 2025 19:56:57 +0200
Message-ID: <20250211175706.276987-1-robert.budai@analog.com>
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
X-Proofpoint-GUID: sCDfWyAc1bk1s3CE3GIFn4oVyrd_G9BR
X-Proofpoint-ORIG-GUID: sCDfWyAc1bk1s3CE3GIFn4oVyrd_G9BR
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67ababe3 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=f1vxr5TaGUlwJKkhg4gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110129

*** BLURB HERE ***

Robert Budai (6):
  iio: imu: adis: Add custom ops struct
  iio: imu: adis: Add reset to custom ops
  iio: imu: adis: Add DIAG_STAT register
  dt-bindings: iio: Add adis16550 bindings
  iio: imu: adis16550: add adis16550 support
  docs: iio: add documentation for adis16550 driver

 .../bindings/iio/imu/adi,adis16550.yaml       |   73 ++
 Documentation/iio/adis16550.rst               |  376 ++++++
 Documentation/iio/index.rst                   |    1 +
 MAINTAINERS                                   |   10 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   36 +-
 drivers/iio/imu/adis16550.c                   | 1151 +++++++++++++++++
 include/linux/iio/imu/adis.h                  |   34 +-
 9 files changed, 1682 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 drivers/iio/imu/adis16550.c

-- 
2.34.1


