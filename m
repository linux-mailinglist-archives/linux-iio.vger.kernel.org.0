Return-Path: <linux-iio+bounces-20948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90CAE6FC2
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 21:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8447A698B
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBB22E92C1;
	Tue, 24 Jun 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ql0rPa14"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7E2E8E0B;
	Tue, 24 Jun 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793779; cv=fail; b=qjr0dmuUUHOsBhni7ax7fU0kNcomEUgssSscdVuNCyJrRP7aU57TfMy3mhTquci8Qi3iJEWZ5mHT7GBZkvS8UzfTEcZlLEGniHzS2ach+1vqFAPnyuUCdmxV5uK8hr0I4D8sVLqu0iVekx6PNzKcrk0sfpr36dDRZZPUfAGa4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793779; c=relaxed/simple;
	bh=4NG0oSVieNbiQl+fLPcT74nwge9WxM3FouzKqqFcqoo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tEHa0Eo/I/OnUravWIhpyXGR8o4NZeQWYGhi8w3B759guZOlM08ICfXIgmaWfF75JHgOyb+GZfBBc2ZsxQPxybNEfY3Bcb0CgVkPDzhinonYm2XmXAuSnHrXX5+HCio0QD3ahJRnk/uQq+zKa6FY1KU5Tof/8RHUGECW/pq/VKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ql0rPa14; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD1gEj1T+ASNCCXBcXzME67vRMTNOf6U/4G0ahw7WF9tQ2u9UsWqk6cFCKDypntAfrDGjTfM5et/VC+6F2COIAhftN9vU8JbtHhR1acBYsADeRtK/voh6cxlWvH/UbbjTVfTzoaXTwRfAO8tQ+aDBVPJnmPh8xTKjKeAS/nvezZGSgOvpF3mb2vYN+MeO6d8U2PUKepta3b5nAAxUVqyYWI6mLS6euoJEuMWGq/XxfDdoEh2wi6fz1Sikx+edVp7v2xIjJXHr7eh1SKpEykot7FdUo5v6YAPjiVUEKDeBAz2t585i/8giGY1249AyXU1tCDWVld1GAt+hzjlgwJaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9lNhIGGSGpTvHkYZOoWIpB4h1KH1Pqs5EYR7M+ptvU=;
 b=Qf8OxdhRu0hdZEKLBBtODnRDYtZoJYg68nWgjpxVhUc9pNsskoigOa/FpYk0qOe19qWl3w5rPBC/ikslrNzSq1JCtyNi3wDIVYRpK4sq9PmVajapuP1O+jMpqzdxnwqhDQSvYf3Ehn9ChZOwtIQsXYWZsB407uG+AwQ7hOkPWcERyvfnUStFuGc5dgDn7/bfbWYi5qtt3g9O9yjoZOyie/gdZ+xMUVO9RY6r4PgwKJHa0njMxHzTUDUpW+tQ6zD3LSH65qYZQ1sJBcAIvHO3heNzJaFGQM5d1qP8NDR8G6ODgis75pBFPAMM9CcbBLK/iWfYXUyMiQm5/FNXvbZIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9lNhIGGSGpTvHkYZOoWIpB4h1KH1Pqs5EYR7M+ptvU=;
 b=ql0rPa14oYy10Rd98PuZ2ccohWzk69J/CvaldSpcco+qCipVYvS4Gu/bjz65ie5M693YBI7LSOuK8KAE9hYLJSYkCtZlTXWTyBt6960peF+JKbdf6oCbVvArHkIWJDdRa1FYDg6XoilFC93opau3LPFINFlrCiSpdnMpTtT0FS4=
Received: from DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) by AM9PR02MB6515.eurprd02.prod.outlook.com
 (2603:10a6:20b:2cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 19:36:13 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::f1) by DUZPR01CA0099.outlook.office365.com
 (2603:10a6:10:4bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 19:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 19:36:12 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 24 Jun
 2025 21:36:11 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250622113312.1e60b008@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 22 Jun 2025 11:33:12 +0100")
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<20250622113312.1e60b008@jic23-huawei>
User-Agent: a.out
Date: Tue, 24 Jun 2025 21:36:11 +0200
Message-ID: <pndpletaq50.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AM9PR02MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b454e1b-29e7-4134-6fd9-08ddb35660c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hTVPP823KOVu0J69c0FsCEHZ2c/gjAXlEoDjM8F4cbc2ypu/CX1XKq/2uIxs?=
 =?us-ascii?Q?dH+MHyLvKvKf5ojDFItL1WNYEJ+z6/bTxO29ugyXCVN4IcPj/C13uKQ+YoYi?=
 =?us-ascii?Q?EcBZzUHZ/2G4ikN40tOaJa3EZaSR5kpvcwmlal+9HOQJFr/F5ija4S+vrumr?=
 =?us-ascii?Q?JFeSxNXYYPue6qBess5gVrL9IBqxTGFiey0HhfNCcdOrPUHtCGVB7iGGipBb?=
 =?us-ascii?Q?AQe5fo6Mfj7U5CtX3C28VTHd2wIKiX7Lkvw/c7b7tXbgOYJrFMuNhkBiowHx?=
 =?us-ascii?Q?AsWbASbUlwVj3CwRTMUWb6hXRoQ/TRuboUBJykLvkoS41Vx4dSEx4lrabCN1?=
 =?us-ascii?Q?st3kbh+pF+2GPBNLDOnV3ttsZMzVhjYv5vpRo+cdcqT66Hqu/vtkfJL6N8eH?=
 =?us-ascii?Q?RlVH6JIBh0FZBnhG0xr7um5YekKK89XJeqSOFGFA6bMi43O7ENs1nAD7D/IM?=
 =?us-ascii?Q?UVsjBmgaM9c1zSCBNOlQBRj86gwRhHqZgFcTFblFnf6V1HtSN2hIeTA1kI/9?=
 =?us-ascii?Q?WxoS7K0Wogta9oQhJXr+dvo+G/1nRp9v9FxVbcW5bY6RJ2/yYSMefZWogsfP?=
 =?us-ascii?Q?lbjv2baMYNX7oks3LSqylTS9WeFYdE9SEZMKz76SubZq/BfSVEPddNxEFBw0?=
 =?us-ascii?Q?uSUTaBoTzsK2UQKWtLqBdizsQBi51Y1tjiZDFW1r1yJNWGFkVOZYOExPdEUO?=
 =?us-ascii?Q?o/R0oi3qxXjdSL3Ge0gcQAofwqUfNK1Nz3ZlEH2NvyYBW0eic2xnbBIJx60d?=
 =?us-ascii?Q?1oZw1v3GNUKu9O25QrDPua1BLRpg6ddb/SVV+9rJCxzi4KKtGx9CBkoiR39X?=
 =?us-ascii?Q?G6oGGq+/28PYavUEUMtLfMzGR5YS97rWwTjYo7VAz0QLx/Z4B5yjTcYOxyXQ?=
 =?us-ascii?Q?LipdgrU8CgX4iRW1qe6hjylcdP1tVlUI/6/O326sk3ctVZrjB/Fja1zJ028e?=
 =?us-ascii?Q?bdiszcVmq7X9GWyjn1R4HCaOqd9O+Si2EW4JX1LLQI/pCG3VqbD92noXdB8F?=
 =?us-ascii?Q?t0YgNnKN7ky7DbvJEqk0Gs0QbZzyq7wVtuK4GB0nrahlF1dbvJvHUc5/o7GS?=
 =?us-ascii?Q?upB4ejqEYwR2nmgP8cRCT67Mx6aoXJvODWpUjj0B7fYpH8NOjAmHUlw67wWg?=
 =?us-ascii?Q?ajR1KkSje9oRgkm3Av17ghihTv2G9LnlPq9BGQhdbD7RKv0QSlGmqYwyYSTA?=
 =?us-ascii?Q?JNb/vq5Udxo1TYstwSSpkPrQLh9Vjo1QmAkUVTmrBf8xZzekLVzqAgZeYY3l?=
 =?us-ascii?Q?hZbXuaVEUy+ZebHp5qBSppJ1MQnp17mfKqFOLUY9hXdzSFnn047T+K7ukIFq?=
 =?us-ascii?Q?pmDGLJO+MhFucGwg6bRjoCsWNvMTNH5r6FibiSK9AEyd1gBkd1S5NpvWWRZZ?=
 =?us-ascii?Q?oaTAdgq7GKp/nHHlHOkZ9/mkwUwNAsDZ9Z48IIAUOUpJQgZaoUeM1ngcy8KT?=
 =?us-ascii?Q?K3AXU+ZRTQ1B4Z+zcTohcnD4/RDOS4Bu0yC+tY9VFm4t5m1WC8nAf7WOa9GA?=
 =?us-ascii?Q?oM4lOGBCqQc8y22paZOpMtJvrXehq2BncB6T?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 19:36:12.8272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b454e1b-29e7-4134-6fd9-08ddb35660c8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6515

On Sun, Jun 22, 2025 at 11:33 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 15 Jun 2025 00:13:52 +0200
> Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

>> Waqar Hameed (3):
>>   dt-bindings: vendor-prefixes: Add Nicera
> I guess you didn't +CC linux-iio on this as I'm not seeing it locally.

That's correct, solely relied on `get_maintainers.pl` here.

>
> Given the whole series including that patch will ultimately go through
> the IIO tree, please make sure to include that on the next version.

Makes perfect sense, will do!

