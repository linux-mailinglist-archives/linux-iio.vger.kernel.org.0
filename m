Return-Path: <linux-iio+bounces-8498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EB953722
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1741C24390
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEC1AD411;
	Thu, 15 Aug 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="ALyQxPng"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4739176AA3;
	Thu, 15 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735586; cv=fail; b=TVaW9KinsuOdGVbSBPENRghxZO7Qa91kGrUKPYk6n6wrrcqK8xuXL8sxRZ7Wth7evBbd9NR1FZtVdIor/hQvWpvkL2HUU5f3r20LVOiRZ6IaKNOK7XL6vcW5sEPfNK8Hjr+WSKOt49hdeUC7PMN2aKAR99akq9/WI4yJkoYLIow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735586; c=relaxed/simple;
	bh=t4ojcTLuWaJ7+UTHJROPz/3J0KRxrwl3+JFAQmEOvNI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibZb0NE7KQ89OswrP0O5RRShORCQoc6ll9VRJolgzb1ocvx9yUMeol3MpM2oF21D9Wj/MaG5h7saIDmoDCF6M1DOsdLQKX0JiAEaxCOsf0v6oVMU6mvB3MNgx1QpFu4RqLxv9ekYXtcg+kNSH9B7RdzYVxWfUsTVoMknAXpk6xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=ALyQxPng; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6+ma8GcEnxXRpTNr1PsLI8HkhZ04yIEy9KU2R2DGzRUf1VqLN0ot+3wpgLR3McNVi14XRlflw5qNFcvyMsHlggo7i2Z9IGcXE2eTaUdOuQQuTI8sgWgMzDPZ0YVPOQZB7/Qua10wwzbL4Iwcf7XdnFpeR+QDveoxlcRyTN1fAEnto7qky6rCYnjMWggjD/407U5sUzQRuiqQaraV1fM49GFNoSTjb3ZBXuo0d5+IFgD+35e01DYe9H1+Iv0uYgW0uRkV1QJE59IaiyOe3ektsoO3L87u85nn2MRDkFQpfm0hhRZJBcXsWtTUCW1dXoRf9bm84IbTAuvaTSdZRjb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15FDFEWIr6J0gKYLUnwoHpR3dNzuFV4LwBW528+Yy/Q=;
 b=JbUzJBiH3a4miLNxXPTenwNvdwV+V977MF0WgaCUGF1kizryXH8rIa8cWrKvB3SWNQS78iEuWpiccGQJGOrdex6GtWAqYM7cY0DBxdJ0xh0NEGletg8Iwm4BU9oJxJlf9z+dHM51zojup4SvEL73GnK17vNbXqI4Fl/fCi+zYjW39cAMZexLJq8+rtbsyJKum6fjOED4rOwANY7Q8/NvLIMWVIgcDYwG8uqiYoSqeeaH9A4KyaSrzFTI0bYIRALhLwDc3rbyetlBThhq4DwCnbeSeJ9+q2vK3MyI55n0avRzY7nUQQY1SHUY0n903K2AuToe0mtIandUDI+LtT34vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15FDFEWIr6J0gKYLUnwoHpR3dNzuFV4LwBW528+Yy/Q=;
 b=ALyQxPngpxIxrLpkNxreM1XQAlqG/MmDxxK/KM7Ry0HN9T7E3cddftt6q859kzhZ8xxrXbv3n4Y3iZvs8JbwxhKQoY3fTijQCJ4iSKXE1DvSf3WAuxxcl3+PxEAMNtWdWV0b4IUaCSNdnoGND9EOSLfhEBnOGEhfWkReJXT8CG66+eW9wrcY19Hq6daZ/XYm6ZlHcqQO4AzcToTZf+H9YXbUc4SIS82VfN005OtYNw1E1OH8ZC7IYI7BCLQso9YrpbQY3MOUF68gQemwljoFEQ6jJOouEXCzKqNriYueCjT2katqTy4KW323wmJsnrRKI5CEdLspel/DD8pN6Grsaw==
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by AS1PR10MB5627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 15:26:19 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::74) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 15:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 15:26:19 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 17:26:05 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 17:26:05 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v3 0/2] iio: imu: smi240: cover-letter
Date: Thu, 15 Aug 2024 17:25:43 +0200
Message-ID: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AS1PR10MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: ca52d7f1-27aa-4c2d-7752-08dcbd3e9c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU1wTnFIV05DVHdnOEo1RStDWGkxYzRGS2RtUHNBTTRKRTlLYzNsb2p1VmJl?=
 =?utf-8?B?N2k5YzRCYXdjTm1KQmFPTUVtMjk4Q0NBQkpQQ202V3VWelV3eGdUa0E2T0h3?=
 =?utf-8?B?c0R4VStTYWxVNFhzM0tRQVhpUVQxNEx4S0hodytGaDh4blYzc3F5c1p2TXlw?=
 =?utf-8?B?dTBOMk5oTmR1Uk8xV2JDUk9YZGZDeUtBZk9pVENaQVFhMUxQV3NOTmZPcEVD?=
 =?utf-8?B?YVllcEV2b01HcGNyZVhTWVZyQng3MjlFTldFZVJlSk5YeXVRa3Q3QUw4R2lY?=
 =?utf-8?B?Nk9Ma29oS1h5Z0ZRbGI5ZDAyeXZXdWhNQ1I0djlFcEtucklzWFZUQmhDd3Bj?=
 =?utf-8?B?SXhjUXk2OEtLOS9rM3RRVUo2SXZWQXJhZnRFUC9ENWhPUXFBSG9mNWU0d25P?=
 =?utf-8?B?R0NtYURqd3dyYm9tR1pSbVdSWXVNZ3NxZE96M3Q3NG9FVEhPUTVCcER4TURF?=
 =?utf-8?B?STBJdkh2SnFsQVVQR0VGVThvUFMrTXBlL3F0d201ZTNWbzJtYVA3UDBTaGw1?=
 =?utf-8?B?K3dXYnBtWTllSmRRbTF6VjBqZGdoenF2eHZTUEhYUWdxL0JkOVEvS3hEWGFy?=
 =?utf-8?B?MTR2VjlmMUlJc0xPRzRKRm1IZnFNTnZKNUtFazlGVXRyY0ZXTWtzek9qZ0JK?=
 =?utf-8?B?cWx6NUZ4bjZXM3pwRXVuZWMxWkR3b2tiZjcydjh0OTJ3azNSMmRMN0FlYTAv?=
 =?utf-8?B?d3dsT2hpQ0swNGdwY1pueE41c2EzRkNKekVyeXZBOE4rcitkbDdsNlVZYit5?=
 =?utf-8?B?Wkh6OTgvbDRPZHd6bWFFZTJLVS84eWh3OVZ2cndVdkxRUkZubXpSMFpNaHpv?=
 =?utf-8?B?cU1xWUtYeUgrcnAraHBLTjB1NXBWd3BtaUJZcU1KUjk2QWVJWXN1Y2xBbFI1?=
 =?utf-8?B?QnlXeGV2azgyeDlUcUdEWEVab09Sd2RuYVprd3ZBWUtiTnFlVG1oc2VVUFlR?=
 =?utf-8?B?RkFPVVNGTlNLUDFOZmhpMzhpMHkwUWZ5QzY5UjRIR0NldnZqN3plZC9WeSth?=
 =?utf-8?B?VURqU2JrMUc5UVNuVCtNa2ZvQmUybGpBQzVkTExXNjBzS2Q5eTdIbFNOQWVJ?=
 =?utf-8?B?TGIxNEJzTzQ1NGNnRHc0d2hURzZyb0k2UkpDMEltUGYycFU1anp4ZlZLSEdp?=
 =?utf-8?B?K3grVGdnWEl6aWRCeG9rRzBTTGNaVmZsWllvY1lVMVc2VEdwb1RaSjBxUDdM?=
 =?utf-8?B?QytVQjJhRDN1MVNhVEErT05rNUFqMGR5RnhrRU1YUURJS1N5WllVNmRlNjZL?=
 =?utf-8?B?VU9hRWY4OHdySTAzYURRUk1kNlBXcUV1a2dxcWdVdjNpOFNscE5iMlQ0b0dQ?=
 =?utf-8?B?dTVNMStGbDhRc01sWlFFLy9BbGxoZWtnMzVUaVpOaWdKOXROMnJQZGJBRTJq?=
 =?utf-8?B?UTE3MmpNdkRYQnRUdHdaRnZoVllPSjBwOWRwS3hyeUhJb0tQREt0T1Z6Ri91?=
 =?utf-8?B?TlZMOTVoUFZrNkVTT3JyV3l3MElpWmh2Q3lBcTZCQklHbEVvZUNET0ZGQ0R2?=
 =?utf-8?B?dkZycUhjbXZVN0h3a2VCSzV3MWRPWVg1aytpcVdFRjI1VUNjb096TmFqYTVi?=
 =?utf-8?B?N3cxemNWNnNjVmtTK0VhdGEySkpSODZlcDdJL1ZMZTNxSmZzTGNSTW41TENG?=
 =?utf-8?B?QWVwbzQxZXlRdTJnbnpVdUMrVS9jbXpUUDY2OE5sTkFaZlc4NlVtek9vRTQ1?=
 =?utf-8?B?RXF2TytYWUR4Vkg0TWhtMnlrc0l2L3UrNVhxSEwzRXFGVDZHNElUNFRoWHcv?=
 =?utf-8?B?aExCWHJEbjFhK2Q3STBXQ0Z5Z1FUUHpyRVFGbVNNdHRta2daS2c1QTdaV2lB?=
 =?utf-8?B?ajU5K1c1aURoS1A3Z0FJSmZiTWFEVW43MGRybVp4NEgvRmwrb0ZrcDU5SWZa?=
 =?utf-8?B?eEZIWmtUdUtBY3VqUkpmLzgyWmxsZ0gyUXAvZjZHdXhFYXFJMUpxelk1OXVn?=
 =?utf-8?B?MHJzZEpBajUraHNlU1V2bUhiTzlrb3poRW1OL3RGbmlBaVd0bGFCQVY2VUc0?=
 =?utf-8?B?OFRVTG5BQm5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:26:19.1861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca52d7f1-27aa-4c2d-7752-08dcbd3e9c9d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5627

From: Shen Jianping <Jianping.Shen@de.bosch.com>

This patchset adds the iio driver and the dt-binding for bosch imu smi240.
The smi240 is a combined three axis angular rate and three axis acceleration
sensor module with a measurement range of +/-300°/s and up to 16g.
smi240 does not support interrupt.

dt-bindings: 
v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style
 v2 -> v3   
    - improve description
    - improve supply definition
    - make supply definition as required
    - add supply definition in example

imu driver:
v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions
v2 -> v3
    - Use enum für capture mode
    - Using spi default init value instead manual init 
    - remove duplicated module declaration
    - Fix code to avoid warning

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: devicetree binding
  iio: imu: smi240: imu driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  52 +++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi240/Kconfig                |  12 +
 drivers/iio/imu/smi240/Makefile               |   7 +
 drivers/iio/imu/smi240/smi240.h               |  32 ++
 drivers/iio/imu/smi240/smi240_core.c          | 386 ++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c           | 164 ++++++++
 8 files changed, 655 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240/Kconfig
 create mode 100644 drivers/iio/imu/smi240/Makefile
 create mode 100644 drivers/iio/imu/smi240/smi240.h
 create mode 100644 drivers/iio/imu/smi240/smi240_core.c
 create mode 100644 drivers/iio/imu/smi240/smi240_spi.c

-- 
2.34.1


