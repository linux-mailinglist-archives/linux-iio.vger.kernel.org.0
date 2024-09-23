Return-Path: <linux-iio+bounces-9736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D003F97EB9C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A65A282131
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AC1990C7;
	Mon, 23 Sep 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="p6tMOHAX"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4D195B1A;
	Mon, 23 Sep 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095255; cv=fail; b=IkTnPfJRUvzosDK4XhETnTgVZTt0qCHBq/iKrjt0nbKZsFGkFy2z4VLPEFH3p5u2CwThWdRNwxhaB57C0EAsfY0NJzdD95/945K/gMN29GqyNkjQ1SjGLbIjgpT2K+dV7WG/vFHy/oT3XlTSyOVL6JdlcffItxQRAtuRksxzebw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095255; c=relaxed/simple;
	bh=llmlBn1l+72tBxiaVi4eHl8WtKpnOFZghtVxT7xFDBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kl2dSD21oZDcihcWx6oOB7HBInT/vKLULFVd0RvSSjxWEmW8rdxLK6KBZbOu88l1Z54WILVviACEhxT0Tf00qejr216B22Xf12+Y55GTy219kIFCmCjJOZGOtm1XFsHlNGEqAATGGaaIbBLOUmvlYLXbf0gNZG1OFU6AkHdoFqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=p6tMOHAX; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uawIg7q/L2bchSUvizf5587Ns9sVh5BzL6YGJ5Up1LECbJbsCpBANS/qR1NXKMo4Ef/fWkwaaSV5ti6rDMFGJ/tqAslRQuA5JJ1lR/np3zRTiRXOvRNxChziT6Dq1Bg5W9rGJyzE1zs0xiuQhyd6txOA50hSPTJXmiBTOqSExnWsET1/a29asDRRoPnEqUjdWsVYcMlH6xn9mfP8onkoGGWRPvyp2niq58q/s23aofyZIVQTGVrpZlKh0O1Ou1Bpy88aWP/o574CfOLGB001TjafFo8Szhaxknjm75scJqdamvyR/MxwMeFFwVwj753CDBoHj28iQi8QeFipQsfDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8VEQ5LvxSajqirhl/H1BDdoQOf8N3eFxQ4YZR1h1WE=;
 b=CDxPGq0br6DMxyA0w7hHd8+FuiKRiQsCrFN2oWv6f3O4FaogdGED7NGha64tD9OQ/IHDOQlsS8rNPdpCmiN4iNEM9QXwqrr5BLmx4OA9ToO//jROpxrnARJ6BpaXqEasczEo3DkhVXpuObqE/rSf9lMS+2s3/Oqc9t+7SmKN+sEdpqSNvNtYmZo2Z+Cw9Uqb+CdH/4W9fmV+hlN6lRpbgmnDSrv8ieWoY3WIfyYBaM0x2D4L/f9frsUTAWLPOPcolWbeufFcptzlidGGKtquE4NTHuDut2hUwpDMe5Nu8H4tBHN2nLsY5UcIAvH/9csX8zGHEX8LlP1/0lk6fTY7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8VEQ5LvxSajqirhl/H1BDdoQOf8N3eFxQ4YZR1h1WE=;
 b=p6tMOHAXZ2omMG7sufhTq/tNib4CQxvC4KT+GBqj1DQsgmZmA8XfwtvxI/KbLS9ew8w5D3vfh/YfQ5a562MUCgfjXmMS1YLq8upqWjvcCJu7uON0Sppk9qAAMirabyEm7wkRMuxe3ZAz2KkYZRMmh6PyZa+uOFnT0XAP5QQzfuNZCm1tzABlrXUYXQzSA7KfEWUGgqkETe7xT75ePAPNf970O9y/qTyr2lD2JgWQOLgyx+vyVBIY+zeFoykzZGeieQJrS4aSY1wahNnUPTNBydTkd1HOPSAwUSJuoTbcMK1K9/iGcgF4s5H/7XLYnGXywIoa4kjVmuAo/WIi6mJD+Q==
Received: from AS9PR06CA0199.eurprd06.prod.outlook.com (2603:10a6:20b:45d::18)
 by DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:40:42 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:45d:cafe::8c) by AS9PR06CA0199.outlook.office365.com
 (2603:10a6:20b:45d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Mon, 23 Sep 2024 12:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 12:40:42 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 14:40:31 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 14:40:31 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v8 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Mon, 23 Sep 2024 14:40:15 +0200
Message-ID: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|DB9PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 214c016e-8a1b-42e3-533e-08dcdbccf023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2JOakpYRWZBYzQyaUhnZHdEbXV1aEZld3JsTEdVT3JvSEEyM0NHZEJSZzVl?=
 =?utf-8?B?aHhyZStLK1JScW5RWGY4OCtqVWw1N2ltUmJ2aVIyRkp1aVVJdG16ZGNUM3Ni?=
 =?utf-8?B?TU1rbmZvQkNxR2VEbjV6ZkdxMUhsRjhoSWZXMzFHNnpqMENBRnBJYVd4UDhY?=
 =?utf-8?B?RVhNRExLYmRyam1TbUxXLzdUNEpkUEZlWk9yVzU2TWY3TnkvNkkrS3I0SGJV?=
 =?utf-8?B?UnFTS3gxOUl2bzlIT0k2NU92K3NXc21BRXJudkp4andsbnQ0NkxjcWg1N3RI?=
 =?utf-8?B?ZTFUTDRsTWU3anR5Z3NDS2RhQ1krK0lHUXNuZDFsdGl3OFI5bGRuNEVMSm9v?=
 =?utf-8?B?dHlFQituNjk0Y24rZnJzYWNDRFNDUkVmcXlGNWZUcTdPY1J6ZFhROEZQcWJs?=
 =?utf-8?B?NUwzNUtPZVp2RFcwY2doWEEzampPWlhPUVUyQUIxenpUN01sQ05FWkxpRTlp?=
 =?utf-8?B?SnlmS2U1QmhPNk9HS0xMNTVHRzV5N3FxSjV4dTBpd1ZoQjdxdWVYVWhRczU2?=
 =?utf-8?B?THR5dmZ2Mys4aFpVL1paVUY2bTJjeTBqbGdLSjRpUVAzbktTUDMyeTduY0xn?=
 =?utf-8?B?a21sSWdsVzN1VlNkeS93MTJQTWNaZTlTaFUzUHJTQU1uNkUzZDZWT3B2UG00?=
 =?utf-8?B?U3lad0JvVFZwQXczQjNvQ2R5dHA1ZXVrdjlNdGFTdEtXekZoNGVIK1M5NUdJ?=
 =?utf-8?B?OEJnZHRNZGZvQjBMeVdsN1ZJS0ppajI0VGQ0RkdrQmhZdlNQcmJad3ZjYVlm?=
 =?utf-8?B?dDF5T2lVODkzeEFqeUVCVzFLaWNXWTErellrYm85Q3AxWmlzaUk3NzhsWTlS?=
 =?utf-8?B?RGQvYzJpaCtjKzdPa090VVRzV3R2Yy9xOHpTOW8rZ2VCVU45bm9LbjFsek9p?=
 =?utf-8?B?R2ZDVFl1bHJ1eEFNN2JKR0JyM2xUcm5TMktnTnUwd0d4c2VFVWRsZ0x5Umxm?=
 =?utf-8?B?NFkrSUh4ZHpta0NxZkQveisyMkVBbnR5QkV3ajcvZGxTbXZyK0hiMjJRcncy?=
 =?utf-8?B?QnpoRzg1TDF3bEFrNVBMMEhLOFJpQ21mcWxKdTJadUpVWGI3MDJvcUdkRlov?=
 =?utf-8?B?R2xWMU0rWmJKVndrNDJWdWpBWGZkTW43SHVoN0t5Tjg3blZRZEt2TGVrN1FC?=
 =?utf-8?B?eHB3OU9tS210bThTR1pMUU9tM3EwVlNoNVRUbzBCQnlLSVUybEhzdmlGVEFJ?=
 =?utf-8?B?RjY2Z05ON2xzQlRnQldFTG9GeENBN2xmTXcvdHhZRjVsRGUzRHpZeHplaWl3?=
 =?utf-8?B?bnQzcEhxK3FTTUp4RGFGWHZkd1FFNVJRT3NLemtNUEUxVHF6V1V3TVJ2U2VM?=
 =?utf-8?B?aVpBejRoN3RXQ3IyaCtuaGZIMG1sYlZmTVVYc3RCeTR6T2RvdE1RTU5oMlFn?=
 =?utf-8?B?TFRGY1VwZzlmZUdMR1p0NHBoNnhWYXJBWnhORE9qU1Nrc1c2VGFtdVI2eWN3?=
 =?utf-8?B?ZWhxQ0Y3TC9aRld2dkt3aGljUVNEUThsbVUvTlhWYkF0Q2VnY0xURHgxY3Ft?=
 =?utf-8?B?dUhTbG5oWjhuTDVvU20vU2hYeklkLzFBK01zSTM3M05iL2YrSmd0TUt2YnI4?=
 =?utf-8?B?djZqSTZjYTRYSElGb1c4ZHdIbG1SaXExNmNseGRRSUozK3Y5bmRUTEFPVUZu?=
 =?utf-8?B?N1dTVVU4YWFXSk9Gekxua3Zsc3A2d1ltVUI0TmpVSXhWMlRzTmxzU3NVcTdB?=
 =?utf-8?B?cCtuSWtFT1RDQXJyRmhFd296VmgyeWJKdHVPci9wZGE2L2NxUzk2NlBvSnA5?=
 =?utf-8?B?Y3V4VzZlUUI5R1VGL0lLZjFyZFdacGM2WkU0YUpsOW9BdnFiZEd3bFE2TFB1?=
 =?utf-8?B?eThGbTNBWlZSZkwzOGR5T0FyWnhlYi9jUHJZSURwZno5QzN6dndCbXlTT2hw?=
 =?utf-8?B?RUUxY0NMOHRoUG1qNXpNUWMxOWJFM0Z3bXRXYU13aDNrVDQ0N2M2TWFmbHR6?=
 =?utf-8?Q?G+7PW/vhcxnjz6V5tRjkX31CwW7pnz8n?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:40:42.7644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214c016e-8a1b-42e3-533e-08dcdbccf023
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6643

From: Shen Jianping <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi240. The smi240 is a combined
three axis angular rate and three axis acceleration sensor module
with a measurement range of +/-300°/s and up to 16g. This driver
provides raw data access for each axis through sysfs, and tiggered
buffer for continuous sampling. A synchronous acc and gyro sampling
can be triggered by setting the capture bit in spi read command.

dt-bindings: 
v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style

v2 -> v3
    - Improve description
    - Improve supply definition
    - Make supply definition as required
    - Add supply definition in example

v3 -> v4
    - No changes

v4 -> v5
    - No changes

v5 -> v6
    - Fix checkpatch findings

v6 -> v7
    - No changes

v7 -> v8
    - No changes

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

v3 -> v4
    - Use DMA safe buffer
    - Use channel info instead of custom ABI
    - Fix other findings

v4 -> v5
    - Merge the implementation in one simple file
    - Add channel info for acc/gyro data channel
    - Fix other findings

v5 -> v6
    - Fix checkpatch findings
    - Fix review findings

v6 -> v7
    - Fix offset and scale

v7 -> v8
    - Use memcpy in spi write to keep CPU endian
    - Fix some minor findings

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: add Bosch smi240
  iio: imu: smi240: add driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  51 ++
 drivers/iio/imu/Kconfig                       |  14 +
 drivers/iio/imu/Makefile                      |   2 +
 drivers/iio/imu/smi240.c                      | 622 ++++++++++++++++++
 4 files changed, 689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240.c

-- 
2.34.1


