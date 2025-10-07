Return-Path: <linux-iio+bounces-24836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F206BC2985
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4518A34276A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E111324466D;
	Tue,  7 Oct 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ScZetSiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832622A7F2;
	Tue,  7 Oct 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867613; cv=fail; b=VQbXVfp5bVcC93N6BUAduoWgvOFDoquyActZ9IuJ5LZwFWWhGqlAK06fIoxmDXxGE3EDhRe72sJb5HM5iYiPpTdZ/l26aWhHWMyuwfGCzzU7688lZtnsWoh7KG3PYsAhjUtrCgD7jQ8CkLovqB50Gr77c4MVDy2ZPeRayc4hAkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867613; c=relaxed/simple;
	bh=GjLXL+gm1jWYNKCEbJdOq+74VWMbv2IY9wXQMF6gNPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RTS+x6w3Nn91S/jsrVTVeTEBH16lc5/eiFa9I2lxkjOdIk+5Ks9Q6EzzC9atrrIG0QF9eYHwO9u9/pcHC+G9jlxUkqjavl/Epg2qbyjb01WV57dmQSVYwn5GO6ulWzoGXp5a1O0kLfCw7xhArUh3QZVEVNVA/xW3zSEm4K5q5yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ScZetSiO; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfKM/vE6GQlaTiCkyHXQOD19kMIGUg455xZ5hDB9JrjI1nJMTtcbimyOEgZPs9upxNIzhVDRQZJYjyZl3YEgbdyxZztBcP5vKUx6787guvKRunjAURFxdSDheWzvwQVp1va+ktS5LxFWgOEEZElXI47633j3jg5gkfFoDqBX6mjRHt7KML5GB/QpLK84k+s0nKegbENcHnielCmNEToXOo44wtPnd+ZqSorXNWHRvIgVilD4VUEpdh4aogZC6+C4BBHu3N1HrtcYQ7MvQ5coxffnVOOtCj1rvDCCbDhelLyx2yRMysd2pzS3Dd/uoAxwy1Ar846hrDNApOfL0AEDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTm35wJWxfE/WuxTJ6c4Nb3jDUh3qajo5MQvh+ik9+I=;
 b=WJcMFlvxTM9nPe/LgOtoaPdUpqAbAOU1ApQPYdL2r0zYZ1fq5jJsA6eCEtyZ0RW4ICiTjrFo8b6I9qhfm8fsBIwKTKfXBuCU3TzmlPdBUN0HIgMk40L24cAGBtOC8/a4ha6w+l0PdzG0HMFLJWNOARUm1+dcoSu8MbXYs4DblAfllrUpeAZUd+jY2orI4kj+a4FQHhHzAbiuG5910L9HAB7ynxvliSXXTgjbQSWX1ie6QW0bXnO2VeVvPmHYJOln3pgIfw0RI3lF4SWZRrfk4OQJPDLA7HAzNL25y8ES//tIO1enqrgnwwnUP4QjwB7Zw4rGgknbg0WejnwJ0HSKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTm35wJWxfE/WuxTJ6c4Nb3jDUh3qajo5MQvh+ik9+I=;
 b=ScZetSiOiQdJBUAo5gSgDDOT0h9dobdCfVNS8Ktu4Mt/8n2ECHSLpPrdAJNab37GJ6eOb0a3RjDbu1h7n8LO9tDiCylG5RetrShzsWtYHM4/4zBuEmS+h6e8RspGZm4ocVArL6gArC7iKT5BXjTGHcWTVejMFfRTxqXQZUf8b+aavpqcExP/nAQwKg+N9cRw6adz/dHz7f/UnMqTfUc2pl7d/+bxJdVDAr0y3sIHsWJ5si0rvCBHtY2K1DH4UQC/j3BCsNZXRsnR0jhC9xx9Vvj7tg2V7fBSlKYwje1JuaCpDAL71kIhPbkbkixnCibUWmTR0SISFWaUk4lXxVkWDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:06:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:06:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 16:06:14 -0400
Subject: [PATCH v5 2/5] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v5-2-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=2992;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GjLXL+gm1jWYNKCEbJdOq+74VWMbv2IY9wXQMF6gNPI=;
 b=P8n0KIzvp0QXgn78Y0RVR7bdyD/gN2+rZIxXpuFTs5uJtcnZZmVD8YqBW4YPxf0nZRn1/qrJD
 8QQMC+JTfU+BOFpv3lS9B77lYgOts4cPGvIcK2bY2+U2xLkjdQ0wkoJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0a117a-0558-46b6-6f3c-08de05dd0c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFoSGlsTi9qNFZMQXNoNVB2NGxFL25BQkRkNVJvd2EzSzIrc1NGckpZeWJm?=
 =?utf-8?B?OFQwTmdvdGVBUEJiYi93b3daVzdVTDRIRCsxT3owTW01aUtmR1A4OVpQUCtX?=
 =?utf-8?B?UlgwVjBlOE93Sk9lWm1PbDNUVm1RL1ZVUi9aL3pVRFVHMUxVNmZKVjlyR0x5?=
 =?utf-8?B?R0ZTdFoweEtmT1VNNkR0aXlUdnJBTEcxOWFsU0piZ3RlcE4zdjdjOGFDWGsr?=
 =?utf-8?B?MjJBSkttZldvdHNFQ2cwRTA4U2Q0c1pobWRpMFNNTUdWamhTUlN5R3IrV01x?=
 =?utf-8?B?SWU4c1R4WEd0Qk9ScVByYXBYMVF3RGtyUWluRkJKVFg0ZDlmUTRDWkZwUU9J?=
 =?utf-8?B?YUlZRExTeVozQ2w2bk5lVWpZQ2xEUDM0NisyMHFFcCtCVGFzR0ZDR2tnbE5l?=
 =?utf-8?B?VmFRclJURXJCVURvRlExN1MwTjhIWm9SN0RXNUNXZ2Z2dUZkTURtanRMZy9S?=
 =?utf-8?B?RjNjWlNZbGM3cXV3SkVlQ1pOOTJRekZkU245MVZoRklxQWpTNEFTY2Q0ZEpm?=
 =?utf-8?B?MWNuelhGNExrcjNXOTREWHpWYkhnU1FNSUdtZkNycVc2eDVnN3htWHdoc2JY?=
 =?utf-8?B?bkRHc1c0NWZsbEVwd0tiWmtHMnY1UU9yVTEyTDhaWHA0NFhsTkI0Skk0VUc5?=
 =?utf-8?B?bTFMWG9oZEkxdDNSbWNVR2dZdy9xSEdhOGFyTzlmNVV2ZTNjUTViQzFiSmpW?=
 =?utf-8?B?aUN1Q3BFdGk2bVpzTVg2Ym5rSCtGQjI1L3g1b0xzWldxSkQ4ZS9IcXJVRTJB?=
 =?utf-8?B?ZjAwVXM4aXVGVTJIaTJmbUQra3hyY1Q1K3Z2SHBmb1QxV3U2eEZ4RTJIekx6?=
 =?utf-8?B?ekl4bmxWbGY4U0VnUVVLNkpiUUdKRC95ZUpqa1lvdFZoalkvdUp6SXE4bXVE?=
 =?utf-8?B?UEVaMHYzYVVyRjlkYldCN09JdzNRVk5meUlGYVZHbGtBQmk4Y3g5UzBuR25o?=
 =?utf-8?B?bVdMSHQwcVZ0OCtlZUNTYW1xbllLb1hYRXpTUG9IUUoraHQwU0pNbEZiWnBa?=
 =?utf-8?B?UWl3UFU5dlBxeUNzTmNrVDNJUWtBYUhqWXE1d0UrUmxXa2NHa2NsbXNjN0hh?=
 =?utf-8?B?NW5lR2hLYldaaE9abHE1QTBOSFE2OWY2SFdIMXI5R0dEL3RkTVN6WmloS1Zw?=
 =?utf-8?B?YU9ueEw4M0NhVUYvOS9OOXQva1FyTGlFYlhobXZwT0lTNFBVTityeHFzcW9h?=
 =?utf-8?B?OHVEcGVpTzBqMndpaG80cVphdmYrL1hwb0YrajZyQU1NeDdEVXlRSTlIeE5n?=
 =?utf-8?B?dCtYZFAxN2FVM3FuQzgwb3RsTzJjUTE5NVdBM0d5VldyWHNiMXFiTkhLSHhZ?=
 =?utf-8?B?N3VmS2F4cEZlV2w5TE9zZE9kZWVrMFFrRnVHVHNqRmUxWHNIbFdJZ0lYUHhZ?=
 =?utf-8?B?algycGI2YTN5RmpMTEtZclZzVExpV1ExTVdSaHI2RllSOHk2TVJ3bjhlWFQz?=
 =?utf-8?B?QWRYSUZvTFM3bkpPb0NBWndndHkvdkt4Z2ZYQU5nU3ZUSjRlNVpSQU9xQWda?=
 =?utf-8?B?VW9xU2NpVlRPY2JjYiswWmx5UExsZWY3SXcyeUZkQ1E0b3poSUwvVXBNUk1J?=
 =?utf-8?B?bkI5emtiWjdrL1NzY3ExcDZLRGFxYW5ESUN4VGpGcElWRU9hV3lCUHZGclN1?=
 =?utf-8?B?d0JyVThoNXJEVDJqbUl3aDBxQ3h1TWNUNzE3Z2J3ZkFBeDUwdzhETWpoN005?=
 =?utf-8?B?Mmo0UDBuNk9LNVh4YmczcUgwZ1BoZ3hwM0I4MXlsUXd0aDhVQXFYa2hqajd5?=
 =?utf-8?B?ZWxCRC95dlh5ZG8rL3FnQmszSCs4OWgveEhPZkZYUFh5VGxvb1hFWk9GL3Zk?=
 =?utf-8?B?U2dKRk02eUdlMUkxTyt3Qi9PMjNTdURYVUgrSUhhanNENTFsVGZpd3ZDT091?=
 =?utf-8?B?elhLNDhjdnpMN1NxUVBNM01yNzg2NCtyakZPTEg0TmhMSDJ0QUZ3WXFlQm1V?=
 =?utf-8?B?c0VzaFdsVGNNOS9RdWUzcXZteTRFdFJQV2N1eU1hREtySTFyNHU0L3pCbEp2?=
 =?utf-8?B?dVp4ZlRGQjBPc1RMWUl4RHlHZTFaUkV0QzZkOGZqaVlPVXdLU3B5cGZSN3E1?=
 =?utf-8?Q?8ceaA9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUxPbWRJRzJwWTh5SUxJbE43WEFNNkw4T1ZPc1J4Wk1ZVzViOW1vUUtwckpo?=
 =?utf-8?B?bVJiVG1Ha05pK0N1TmFPaHhKL2YxazZzeHo0Q1ZhOVNURlNyQkJyUkYwQU5z?=
 =?utf-8?B?ZUtmN0NmOFhFTjVrdjVYM0ZZWU0vbzRMeXhJZ0FNYlN1R3VXdGN3eXRpM1p0?=
 =?utf-8?B?eEZYMmhvRDRsaUVQL2tqM1BaNEhDRzR0Q0lHWjdSbVNidXBSSGlyL05RUHVC?=
 =?utf-8?B?eVdTbHh5ZnJtcFp6WS9vaVo3TThkRVN0TzFyaUsrQ1lXZUJ4c2E3RktKb08r?=
 =?utf-8?B?RGJHNVlnTDB1eGE3VFM3T0U2Zk5SUU9JY0NpYTF2L3IxcklWU3I5SnRrSFor?=
 =?utf-8?B?VTh4VXBmYkF4VnVIWFY4TTM0R1pxMThIOWtMQ25QSEw2cExzT0RiS1RDbEo4?=
 =?utf-8?B?SmNyWVRON2c3NzhqNEp0TWw3VVZoS3lqV1dBVXR6c215clA0aDZXU1BmODhi?=
 =?utf-8?B?aWUrdlVtUWJjSkZ1S3FBOE5wSzFrVzBCZ0VibWFMOWhydTZQMTFlS091YUxB?=
 =?utf-8?B?dlhvd0VxWkp3ZkV2dURKTllqRVc2K3lRYWFndlFhcUltREJ4bWt6Q0pPdDRq?=
 =?utf-8?B?RUoxVW5GLzFZcGRQd2gvSWxlVEF3cnhYQmozdHhNRWFaRmxWT0E5V1RCWEhz?=
 =?utf-8?B?U3A3bS9VamxUQjJSQk5YSzJGWW5hTkVNckhZVFBXL0lhWVpQejhqUm16ZGJ1?=
 =?utf-8?B?L0pXWTZUalRLd2dTbzJsUm5SbjRMbHl4WXhLU0tSV2dnRHE3QVVESVpGWWpu?=
 =?utf-8?B?dUpqdTZUMHl2QVF6UER0UitkVzNOK09aSSs3TVNRdDV0RHlWdGpmWVo5UCto?=
 =?utf-8?B?aEtCYzNUL0w1QlFwNU9FSUQzcktVWG1rcXFvdUhaWjBiZ0hKZUx3eGJ2emxQ?=
 =?utf-8?B?NzhGVUlyT2syLytYeFU2TWRGTTNkMlZkQ0w4L1hmRTJhNnlXMFM3WDYyUlY0?=
 =?utf-8?B?cW96M3B6cG9JWTVOTHpLL25PeXRpaW9xVkl6SVNQbFl5RzNIUVRuN2VnVUgy?=
 =?utf-8?B?d3gzbWt4d1gzcUsvRHAwSU5nVU1Henp4TVRoZ3B0RjVTNzQxV3JHTzl4NEhK?=
 =?utf-8?B?cEJLZktDRXZoT2JqNjZnV2ZxaXBBT2NPQnlQRnNjb28ra3hwck1UcHBERm04?=
 =?utf-8?B?UGRWc3p6ZFZhbFZRN080eGN6blhHVlhyTExYK3lhV0pWdlhEaG5GY3RkNmhq?=
 =?utf-8?B?eXNQbk5VbGd1REZlNEJmVHdYQ2ZkQnFiZ25jWjhhd1dpR3NiZUdUTmg0c3Zj?=
 =?utf-8?B?MEl0NGdONWpEVEhSWUxzQUNsZkh4RXE2L0NOQkRlamx6SEVjMDBRRGZqU25C?=
 =?utf-8?B?SDNwd0FybDExckVuRmlzY3p5ZW9JNG5KY1Q5SFNTT0Q3UXlWeWdOWmxHaGRp?=
 =?utf-8?B?UlBOZGtnRWVTZUZPSDlxaXNzc1Z6Mk4xSHJQVFRCcDM0SHhJV2NoR2plejhC?=
 =?utf-8?B?QzY4b3lYR1pYT0NXbmtDc2RUUGxvRFpEeUlvRlJYdE52VGFHZ1MrQlFRYVJC?=
 =?utf-8?B?V2NnOEpTUUVxK1Rtd3ZibFFuU2tXeUJpZFE4a0tFeEVXRUZpQjBCWGVpRVNw?=
 =?utf-8?B?b1g5MkswdzFkTElQNnJLcVVMakFiTDlsUy9EREY0VlJiYzZGZHora3NyV2J4?=
 =?utf-8?B?cldtOEw2MjZoM0xSWGRkMG12YXVsUi95cTlhZWVDOHNWL2FoS3RheEFWVWpE?=
 =?utf-8?B?R2RMUkhlS3NNVWFUdk4wRnlERHFESnVjaWZWS1Y1VjdOS3FqdXV1YUVZMEZ2?=
 =?utf-8?B?Qms4NGNKVVFRSjFlRzRVOFl0VXhJbDFkcjFyVTJrUEF4bVRpRTZBRDl0ZU9w?=
 =?utf-8?B?SWJDWDNJdjBvWWpaMU95SWQ5QytuamhmdTBCNkVqbHh6bmFRMWI5OTgxUGhp?=
 =?utf-8?B?a0dpZWJvMDJKZFVSdWwrR2xTY21SL00rS1VyTC9QNXluSjFoM2RFa0h1cGEy?=
 =?utf-8?B?K2gxQitTcEZSQzZ2dHVQc1VtMnM1dUxmU00veGVMc085ektSeXBGdFpNREZF?=
 =?utf-8?B?L2lpT3I3QXd0ZEVTdGpITHd2UlZ1Z3NsZXZHMWZTNGpONGJLb2ZEV2dYcGt6?=
 =?utf-8?B?QXJlMndDa0NETE1uVHk0UHdQbE01Rjd3K0tLYjFjUmxvRHZKd3pCdzRObXA3?=
 =?utf-8?Q?sm2SW/GGxS+6GYKrMG2TqO4md?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a117a-0558-46b6-6f3c-08de05dd0c2b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:06:48.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Juo1UegeGc0Nb05rhZD00JeTnwrOul7mSIb/0m7K2mYM9J5+BoIJVhRYHQ6hXdwaJFKg7d6JsNuzf8/JlmuBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

Replace the bool rnw field with a union in preparation for adding HDR
support. HDR uses a cmd field instead of the rnw bit to indicate read or
write direction.

Add helper function svc_cmd_is_read() to check transfer direction.

Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
repeatedly accessing xfers[i].rnw.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b7991360f3a862b34cc1870a9a2ba..956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,7 +165,11 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	union {
+		bool rnw;
+		u8 cmd;
+		u32 rnw_cmd;
+	};
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +387,11 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
+{
+	return rnw_cmd;
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1272,10 +1281,11 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u32 rnw_cmd, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
+	bool rnw = svc_cmd_is_read(rnw_cmd, xfer_type);
 	int retry = repeat_start ? 1 : 2;
 	u32 reg;
 	int ret;
@@ -1463,7 +1473,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
-		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
+		ret = svc_i3c_master_xfer(master, cmd->rnw_cmd, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued, i > 0);
@@ -1656,14 +1666,15 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw;
+		cmd->in = rnw ? xfers[i].data.in : NULL;
+		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 

-- 
2.34.1


