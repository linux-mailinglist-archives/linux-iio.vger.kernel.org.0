Return-Path: <linux-iio+bounces-20790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58363AE12AB
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 06:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0647A5C01
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 04:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F11E5207;
	Fri, 20 Jun 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="hhzbaqRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034C30E826;
	Fri, 20 Jun 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395353; cv=fail; b=C2it9CvoqcGby1mBMBCaVIzgSqRKcOmQMXWyr68w0hWO2z5bXzP/NlD1UDMdKq22eZ8FWYTMEAeCRhUsZpHwSV0byeRdy7LTVgoeDyPnzuAg3XWpZIySEgYTNgcCxDLBc54NoSlZidOfN0uRIsjp7UoCq5UmJeDH0wVRzm9siHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395353; c=relaxed/simple;
	bh=ARkg33rY7XjfTHfa9bbdCwN8OQjX+WV2E2jALtbE/SA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JL8Y5jTvBrO976m+GCuVzyWvBOeBk6XkZ8ldcFHeYYLmJPbSaLUGfczKv2mU9oChKa0k2kpJRmwgkCdtwPLJVMSAETozyjofHU2ObaBWnSAEgHcUz8YHpBZIbsyofQDJsplK4a9oNBvW3/LYU70THBPM5Sha2U0yH1ygrg8jVV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com; spf=pass smtp.mailfrom=in.bosch.com; dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b=hhzbaqRL; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrZ0+VVJ3lYKI6eMUUP8MLXL+plIWVpR5LM2QAa/PvLwYGi5NO+OJ/UMm5pwOqrjV235XiZS5uPSJ15xscd6vmDHFqqwCBKuuxRS80ohQGi0CRt6/AsJB8YqnQkJc68ij4bI9E6aiNLKyc5CCX9s9VpJ+JsbCE58/yu2YKdiRctCFEAZA7KIJwvDVtprmarY1oDEwgUh6rLI9aOuzAua2UHY/Z0RyfLJXHm61U6TFNTYF8DiUAlErbKDPrXgmPcpVsqOI2Gqx4JKp8YcH2ZnSaYc6a3MkukdK3BXCRT57TPkhYBU8wUsWjuFlsiqk9ypZNM2u2qCAwNzvuVA0XDFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLM8xQMykI6kPN6iZcoGXkeGAbMrW4qm+3q+RKFWlZo=;
 b=r/9DNO1JfWuPOGh/NbpfOhQEi28jLnIz7ZJ0fhPq+YhVjgNYQixC4b08c8HZtiFUV+L2y1T/FM2NajgnpI7jYtdcWOr3TNhZP8pjJCDYVK3FHr4CpN1soIxyIav1rx1Ysde3tnPprn5KOGcNrHc/kFArBQWfi58nLpxH/e3n9YW/aK6SmgIWk2LJsNyDpWHoW8BVRbkV8uKhCIxE3grO1RH52+H6JjPdNZBNpOSi9JLcWzaWnOO700YB6Iv9IjQqpRlo2pMpDSrldLs8lGUhHvMPxd8hIJpv5ARKigvFSGs77AADjk+7T1JHO8uExGdqF55TQykKeq+XLNXkEwgQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLM8xQMykI6kPN6iZcoGXkeGAbMrW4qm+3q+RKFWlZo=;
 b=hhzbaqRLqADL+LotvbPC6dRgcsFf531yHA9yEqQ+aEEYZkBAL+ryJka/C/m2SIixo3epw6sluf+57fEAk5stptoTa9nJEnBXBdagzpeo05u0o+RldWYIjyortkkZrwiq7x2e8dJ1pGqVwuzGAogHS6VxFHAlLbtQptE8C5TLbmMkLPRpiQvIFk6HEo0VNnb5SAybv8R+e7lrEnKE68klBggMRj6n4vXFxGUUbz80zC24ak22d8XiTqweyzw22WOtXAYy7V96RoTEtkCn2soUBfaNzOpUvmZd4HNfp7Kqbk2BPaikmhhHhwKCL0tMmUCDxhclV6NWaMDf3ANUOzTiKg==
Received: from AS8PR04CA0199.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::24)
 by GV2PR10MB6068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 04:55:43 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::c6) by AS8PR04CA0199.outlook.office365.com
 (2603:10a6:20b:2f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 04:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 04:55:43 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 20 Jun
 2025 06:55:37 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Fri, 20 Jun 2025 06:55:37 +0200
Received: from COB-C-005HH.cob.apac.bosch.com (10.169.242.187) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 20 Jun 2025 06:55:35 +0200
From: <liquancin.mereenamathai@in.bosch.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<vassilisamir@gmail.com>, <marcelo.schmitt1@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <Xu.Zhang@cn.bosch.com>,
	<Maoting.Bian@cn.bosch.com>, <Liquancin.MereenaMathai@in.bosch.com>,
	Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
Subject: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and support
Date: Fri, 20 Jun 2025 10:24:53 +0530
Message-ID: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
X-Mailer: git-send-email 2.47.1.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|GV2PR10MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1bd7a-49c1-417d-f8e7-08ddafb6b678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aocXfmLxBgCmI0pvsW2XuEWTc7wSqQ+ylEK78Gf2ZhOtv/7vNKBvrSD7zWwV?=
 =?us-ascii?Q?w4q9Eu8Km4CkWUrM19SVhEaP8h6byH+ls53wV8OjSJrcruL6As4ER73gTH7j?=
 =?us-ascii?Q?8sW+x3hlQhCO0MAYpfux3WBrgjMSiQnNzLVKE0zbCdvTFDMADYLt5b0Z43vO?=
 =?us-ascii?Q?E711j2p+v56zFdtxeJZJEtcf1Ij4AbxpNeTgbdyryr0t/9Z5sUrbRqZTWzQl?=
 =?us-ascii?Q?p9LVpSfuPz97tFMMVWTKnCJMWXPwJ9aNt/vP6Emgr6Jx2hkbnDLxuDQak2Jj?=
 =?us-ascii?Q?pPIuj5q5H80xMARR9f6yIR2aQ2/eQi48LR26Aj/jCO3YTpCjV2Fr/V20GkYZ?=
 =?us-ascii?Q?NUBGDI5Tcfba58uLXVPwdngVRYJz0i1DAOrEe/fKX91ggV40mJ9SAQG0lxnL?=
 =?us-ascii?Q?YOIvnxkPQmfhc3JRQ3xHw8QHuHrAxuIKrjT5UOqZ3S7m5dSsG/55ULKPbSdH?=
 =?us-ascii?Q?JkxPX58uktO9ApmUvhst12Gma8G0bfzMIYrkZ4iTweQc0s+RSuDcQY1cL8DW?=
 =?us-ascii?Q?hm/ZjOVX1fxb+WNwTwjvGhTMmJ+O0HVlkwui2vh5Pv9VtDqAUuC5UNLcljjP?=
 =?us-ascii?Q?CpiUR+t4lZxE4nG6HN1C044PPgBmxuNHyOy1JBSCCEMtJkThS3ZyAfrFFdw4?=
 =?us-ascii?Q?UwolvEuiJFuqBWxzw2Wxx73UkpHcCFzJZWtRpUqywZD6Ae98ulXg+aRDdH7m?=
 =?us-ascii?Q?wE/2oQ1kek5ZZMmSQDJ/WY8Mir50PJxIWf4EwMd81LlNirZTS3PuYiOVSWrH?=
 =?us-ascii?Q?2pGmrf7tOzzQsDESv10Y+Mrgnl7tBeUMzc54mNu2+PpckqnwwDglUq4lbsMq?=
 =?us-ascii?Q?NGYaHpCvalK0jkk+ee4z1r5NgIOImUFf1kIGXhwbPMMf5iwAdOpoziAUTgxA?=
 =?us-ascii?Q?Un4TAcX7rqgg0wiATLyyyJtqvxn2pJ1F7r5zH5fGjjotsAXEVuyi1sBQdJ6U?=
 =?us-ascii?Q?lfgPhvSeHyQ/CXMeq/Gg+6/ikJiFBH7qeRnPK7sKhf8R3oEna2WDFtIEXG6u?=
 =?us-ascii?Q?ukvUCEBpC0XUHoYK8z2zk57EksjRf0dfjjA5qYtNQrRt41YOcEN9lopj58dD?=
 =?us-ascii?Q?+zc9cQbWFj+/rEu7Jt4GxNmki/8y76mvvjECBVEi3ThuWd3LtNtGik6nQv0c?=
 =?us-ascii?Q?aQrYRYxjSzrcVlhwREVgDkoKlWfbW6xI01TS6etJVmCgcVzf+1f6BmcFazDT?=
 =?us-ascii?Q?WutWw78eobusxMteaeyTh5UUhGIDp5lTX/7Y0Sksm/jL4nVuaY4ygDthdSIi?=
 =?us-ascii?Q?aB+iqKIYP/Iy/iqQgR9Sjs1i5o8ZNlGUlve87GFsCXuSw/iYp2lGSqM8SnH3?=
 =?us-ascii?Q?FV2q/hf+BMno/4toVavsQvUi+diHoWbsAPO16GRU1dl6aA52r5fUTkxG+afH?=
 =?us-ascii?Q?5AhGHGGzhZa8HN/yDLmhSCFF2JbHl4Rr22poEywZCuvIGY3dE6h/u1CA0EDL?=
 =?us-ascii?Q?Yjqz5iIGaDBX4eg6Nnx5T6sJSRN+qds7j/+FKBsrgRA8u3F+Ir451MbwfYWN?=
 =?us-ascii?Q?1FqpabgLjld9bvY+KZ3bKsJh11T54BsALroR?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 04:55:43.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1bd7a-49c1-417d-f8e7-08ddafb6b678
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6068

From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>

This patch series adds support for the Bosch BMP390 pressure sensor to the
Linux IIO subsystem. It includes the main driver implementation as well as
the necessary device tree bindings for integration on supported platforms.

Patch 1 adds the IIO driver for the BMP390 pressure sensor.
Patch 2 introduces the device tree bindings documentation.

Liquancin Mereena Mathai (2):
  Add the iio driver for bosch pressure sensor bmp390. The bmp390 is a
    pressure sensor module. It will support SPI and I2C protocol based
    on configuration.
  dt-bindings: iio driver: Add BMP390 pressure sensor device tree
    binding

 .../bindings/iio/pressure/bosch,bmp390.yaml   |   65 +
 MAINTAINERS                                   |    7 +
 drivers/iio/pressure/Kconfig                  |   26 +
 drivers/iio/pressure/Makefile                 |    1 +
 drivers/iio/pressure/bmp390/Kconfig           |   29 +
 drivers/iio/pressure/bmp390/Makefile          |   32 +
 drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
 drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
 drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
 drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
 drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
 .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
 drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
 drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
 drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
 drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
 16 files changed, 7296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
 create mode 100644 drivers/iio/pressure/bmp390/Kconfig
 create mode 100644 drivers/iio/pressure/bmp390/Makefile
 create mode 100644 drivers/iio/pressure/bmp390/bmp3.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_i2c.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_spi.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_defs.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.h

-- 
2.20.1


