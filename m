Return-Path: <linux-iio+bounces-12330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B99CF63C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 21:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87737B2CC00
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A21E8859;
	Fri, 15 Nov 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a4gDZCU2"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CD1E25FD;
	Fri, 15 Nov 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702260; cv=fail; b=kvaplfKThVbhMxb4gLToIsr0t6TG65U45SsPt1cksQ33P88bsdgr9Ztd3MbIyNPHiJp/bbEz3VRARGeO6htg/JA0Kdr57qgn1SGq2sy4q5YXJo0LY1HUW8DxSnpmoLoV6N65wEvg4AzFUC/ti1hacGrqyi7DyP7vo9k016UT260=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702260; c=relaxed/simple;
	bh=CDlvA594/gczoNE+d0SQqGPV/v9MvmdD4EjemFAfknQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GKrHeoqLdh9La+k825VgCObKBZ//TErWldF2NN31J+UOxbvCgmHolf0FM8xC1juWZJWBVDKg58BOmRJ8+XDHK/tFeFVX78WDRjwoxt4mgTXQtMISc4+t99NRrWgja+rJ1uxHOdEAjYH6/iUw5y7wBSOGuvZPFVHdTDCFWH+syuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a4gDZCU2; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnZrZoi9+DhRKVxLV6LJZX0jAkYZlfNYH+vvjF94dvSOpFzSg9Mq/FHJvZWhifbrzjecMOJxv0pP11Pq1DKJr14h4/SKqdDHBnmkGyvN8CfSvMk4zH73XpTkvBUjymoyeY3h1hkLLG5Mhmz1DysZHGU7vdxJoUBEFnmGNHCT/wRZMQ8KB6+nggS2nzTUjUhASXRW4fDFPCmSbcNuNCv2qPyiG0ZryJBj25tIbijdfPvLhij8B7BImClKU82/m+w6uarsymSH0qEE/yjAKubpnbDt8PseK0CHRpRb61mX1ku1hKxCh1B/s09m1zOOHVj23d93MYf0IZnMCVlt7Ab6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o572prkfG4fBU1vV+ZKYwIky6CHiLDuvvCUUmzlJOVI=;
 b=lc5yb2Mtr25gIuL0CqdOOz5q4gqjIrnS99FE7zx5o4pjgWvSovZbNQKINOjyKu8fj1fKnql9+ZeN56xDVL6HLAOMMm1e704/BAWjnm3i+Dm6WxRooMdjBWJewiTU/VrdlVW0sW3D/yckzrVKpMVyWAOqbONKttXskUC04TMBnwm7BLqnKsh2T6qZ0PdDZp14Y23sERYg8Lc7LW7X1oVFo0ZcJ77KIfA79PSyiY3CeCnuhwefZkBi5a1SfO1hL16q7rdhIIXV+N8ZFazxn7XuaGlCWQjRT7N4IRNYmiH6k8hkFXr6y4IWuz1OGDM0vWqLkMM8274o+UIObRYiD5ULoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o572prkfG4fBU1vV+ZKYwIky6CHiLDuvvCUUmzlJOVI=;
 b=a4gDZCU2qo54bJJBaku7z2MV+aDruMQCH9l2XYWeKkO7DR71HqWiepzwOqKWclL/hCw4H00YwfniX2jcXcTDdzW09fDGxwzpS1rjPgMCHOMXjg9HeRaIMRtX/snusy8tRHSUPdI7Mp/NRKJWLL8yGcXJMjOxcjzcGyAV57RB6GrkoqfwwHUCCwN9MBj0zDrIvbb3sudPoy62pXdRS8V6sn0xJoZHxvMBT1mgbl+YevLcokUSwDBYvEHoxpOBx47kxyl2Y0zoNnODHq2SsmerLkPIAGvvxjav0e/eYpIuVyRtwcBM3Xl0tlFa+ob4/eMudVG5clwv1nRUXFB+G/jtXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8231.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 20:24:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 20:24:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] iio: accel: fxls8962af: add fxls8967af and
 fxls8974cf
Date: Fri, 15 Nov 2024 15:23:56 -0500
Message-Id: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANytN2cC/12MywrCMBBFf6XM2kgnrZi68j+kiz5m7IAmJZEQK
 fl30y69u3M5nA0CeaEAt2oDT1GCOFtAnyqYlsE+SclcGHStW0RsFKdXUHPXDGZfx1co6uqJJR2
 ZR194kfBx/ntUI+7vXyCiqtWFWsOMI/Jo7jat58m9oc85/wCDjMjklgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731702250; l=1107;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CDlvA594/gczoNE+d0SQqGPV/v9MvmdD4EjemFAfknQ=;
 b=M0SCSeSxI3cKelCAh29xnmGiZkZPFGMCzuJJXvePJ/6bbgxJMZdBpb69a/K+f98dGc2RWh/5E
 KDpvi2KzPkXDPvy/ArrkMJ+V4TPuGWGmxK5kD0fI3BDevQIU5xZfZ6u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4ad506-e933-4d36-fefd-08dd05b378d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWlYWFQ0VlluNEFTS3h5Q2hBd1BHY2tzaVFCN1A5VDB4a1QrRzFjNmVTei9F?=
 =?utf-8?B?dDRXZW9aU1JzZEwwYzY1Yk0vRVdwTGhhOFkzT1pNMm1tdnkxeDV0TDVWeFhE?=
 =?utf-8?B?OWJWaFU4SWorTmtlMEZPSldTT2JXcDlzcTk5TitOZk9HNVRNdWJMTmlLbmdt?=
 =?utf-8?B?ZG9ReHZxWkEyVmhubTlJN3N6dXQrOFNWYm9uSTBuVUdoN3h1dEJLYUx4YjhV?=
 =?utf-8?B?OVRQc0F3NXRNYU1DVFJNQjhrc2NRRytiTWMvY1p3WStFU01SVDAvMGN0VUUz?=
 =?utf-8?B?MmVBUDdzVHh1aGNLQXJkczlDZ0VPUFBjL3VzbDhUTmtja2k1c2tLZ2dOQUVZ?=
 =?utf-8?B?NjFkRW1PVFEwMzVGcWwwMjBqbzFod0FQSVVPR0FZdld0a0VTV2RaMjF3ank3?=
 =?utf-8?B?bEcyNkU4RFpCYjlwVUVGR3dOOU13NW40c0RkS0JCSHFuUDhGdmNjRUhHS3lD?=
 =?utf-8?B?OWlmdHZJTGxtZG90SXVlZnhRc3VLNU8rVVBGdGtVNHlFS1NKNk9zak1EZnNo?=
 =?utf-8?B?ZWVVNDdITFhsZStmWmRyMHM3eFZKcUtoYnRpemZEU3drcGxMZ0NYVDlEMkJQ?=
 =?utf-8?B?WEZWb3NvWmg5a3FKVlVGeElnZUNjVUNHN1RDVEM3V3d4RzVxTHlUWjRzamdj?=
 =?utf-8?B?Z1FaTFY1SU4wRWFSS1RwMGpLQmhqVk1NSzZRMEsza25aQ3ZZbmRwOVJnclRW?=
 =?utf-8?B?YjhrbWdqbWhTbGttaDVjTWhEenpHOTQzdThpWlNER1dCVk0reDhkZFJ1RFJP?=
 =?utf-8?B?VTZGcDZpQWFBcFB4Uk9GV2xxZlhITjZYRDlqNFhJNFo5L2hpMHF1eUpOQk1q?=
 =?utf-8?B?NnJqMTdYTUlYc2VYbkhqOGdJaElBVjdXOCtnaFk0bVgvYVZDVmpPRzdEaHZn?=
 =?utf-8?B?RXFRQmJFN2FVcFRqM0xxSWFqVTlLTndOSjgyZzZpbVE0c2tCaU1vdEk5dUk3?=
 =?utf-8?B?c1AwQ05sdGtpMW1OUllaNytlNkxLTkZ6NHFRaTF6NU8rNXpURVB4U0QvazBx?=
 =?utf-8?B?cGg4V2w1TXpCMzlGekQvTEE5Y3c1R3hmaXkzMTBwM2dsRTZLU0FlNFAxajNj?=
 =?utf-8?B?R2ZjRWhXL1kvVVl3SFVoeTNGdHZ4Z3BiS3lpS3ZsZUM2OHM0endyNndOYmg1?=
 =?utf-8?B?RU94Z1U2TXdqR1VOcnFBZDYwNURiWFIvWDgzeExSV01ZVzVRTkw0b2tHc09h?=
 =?utf-8?B?My9wNitaamhOVkdZeXRicUdDT0YxTUgzRkliVk44THlFbktBYWE4NExTdVQ1?=
 =?utf-8?B?SzZMS1FSaWpJTlkyVzkyeGhjeDA2VVpkeHRRTW5IaEl2U2cwYXptYzFwaHB4?=
 =?utf-8?B?R3FmYjh1ZXNaSXlYdTVJdkVoLzhFYUJkZVRMbjRmZUQ3Vm1jb0VaUGJyMU9T?=
 =?utf-8?B?b3lqSFpPVFpaTUpsSFRmUEVsSldFdmVEVFc4bTdXejlNSmV0Mk1jVXd5cTRU?=
 =?utf-8?B?QUJyL0RlQ3VzQVhJZGxLUm5iZXdGNFBhdWp3KzREZDhvWXQvM2lRclJzR3Mx?=
 =?utf-8?B?aEFZZVdubTRTc1oyQVhUd1Y5SEFBd2VnM2tmYitQK0NNbGZRYnBMb3YwME5D?=
 =?utf-8?B?U3ZNalBQdGhxbGtvM0VTdFVMMm00dTlZelFlZDJST05DeTloUk1UWmlTUUxq?=
 =?utf-8?B?MENwbjh2UllpcmxvSUc2WDZjeWdhUnhVM2ZEaW9LeC9idXlxVXUxS3ZmTUxK?=
 =?utf-8?B?eE9xdllySHlNRUV0YUM3UzhObVdLWkZXNnZZSUFGYWN3VXRhaVNiU01LbXl4?=
 =?utf-8?B?VHlQYW1vV01OajZDb1VwK2JzM0RVeFZiUE9WbG5Fam1zSDJVbnhwV2lsL0R4?=
 =?utf-8?Q?rBS/rRTpHuhpuU3Wuv3vJBX60QP+mabUigrCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWtGWkd3bWFSd1hCUkxVWVMvSkVTYUlnb0E0K3NZeTBNa2xyNjB6aFJpcHVu?=
 =?utf-8?B?enVhL0xmZkplTEpWeGRSQ1hJdnFMMW85c0dDR1c5dDcxNFJvNnlrNit5dmNU?=
 =?utf-8?B?ZzREaFhYQXRIWmRFYVFyOXJYemRBUGswNmdUbURoQmJyTTVFM0ppQk9DU01E?=
 =?utf-8?B?RUkwU3RiUFIvSWd0Z0VYRDU5cnlGMG5qR3FJdVgzcXlOaXFYaUVKcXpMN2or?=
 =?utf-8?B?NE5ZMnVwQm8xL29Ga3Uwb0lvUGx3R0NjUVFlMzVRMzJRZjQwb093Z1JscE00?=
 =?utf-8?B?dTg5czJOTFdwa0U4cEJuckdWT1p0U0U4SngrdG0zekhqNUVzNk9XSE00RndM?=
 =?utf-8?B?a0d6ZXNnMG9UQTA5d1lKbmMxWXFTWFJBcjBRMUJJNytjbHE2dU0vU3k0RXpP?=
 =?utf-8?B?NG01cmJyRXlDemxNaG1McDZGUUk4UW5jWjZjRWoyMVZNOFIrWUlKdTlQOEg4?=
 =?utf-8?B?bkVOVGZrQ3JCSk5Zd21yU0FyZkUyRU9QNGpiZXgzemV5Ni9vNHp5ckFLdlpz?=
 =?utf-8?B?RW9XTUo4Tmt6czVGVkdaeFZSMXpSZUVmN3BqeWoycENvZXNWMUJhcFZLa2Q0?=
 =?utf-8?B?ZEo2QVI3VXU2cXJ1djVta3crVHJma01oOXNIRDY3NFBsTEJrV0dRUUNBdXdB?=
 =?utf-8?B?WGpXMDV2RGxaRndGRGhZSFR4T3k4Sy9zU0ZRWENzWStYRmcvZm5CM2pyakdn?=
 =?utf-8?B?UENZaGt4R08wckwvcldWbDFjR1dVSjRRQWFLcjFWZTlkbEg3cWkycDVsS0sw?=
 =?utf-8?B?Z052d3JuNldLTnpUemdHcEkvQitIWVdpR3JvRk1PR29DbWRnWW1aLzl2NVRK?=
 =?utf-8?B?cjArelFwdXBCTFdwZXVGOWg0WU9wcWRzTVhJNnVCMWtnZGlyLzZEWjVXRUtj?=
 =?utf-8?B?L1BjVUxzaW9GanBNbXk4NFFLajY0N0pzanZzMTRqUHlxWWNBZ2RaVS9SenR2?=
 =?utf-8?B?NTYyaXl6ZDlyaGhJVkhWeVo0Szh0UmtFZjZ3Q0dJQnRRK2lTcitseFE4bFJM?=
 =?utf-8?B?blpSTGV6bnEvc1JqOFduSGRFZmpXanVUbG5pR2p5ZXVGcFo5UFVxOFNtMjJq?=
 =?utf-8?B?SjNkS2pnMVhQV1N3RWJYUTlvRmpwOWg0T3pxK3E4WFAzd2lPYzlsTTJFY3p6?=
 =?utf-8?B?d2J0alc2K296UGFBUG41VUNTc01RbGJKUUNPRjFWc004YjdYTzgwcFNlamZG?=
 =?utf-8?B?RFlML2lSRW1zNkJJZy9pNXdOREtBNXBrcC9CWjc0bmx3UmxLSi93eXVaQ3Fv?=
 =?utf-8?B?MjIyM0JrWkNpZ0dxTElLZ3Viblh6VzBiSVFYMWVWV2ZQR1VKVVNzdzdYTnNx?=
 =?utf-8?B?ZFRaenBxcm1adVV0RTZhOHlMQ2FuakRGUkxSL1duRW9udTdmSVRXK2tuZnFu?=
 =?utf-8?B?ODZ1VU54b1FLNVVJcG9vck9kZnB4Uk12c3Uwb3JRQkFnUlhLckI0SkRjeVA1?=
 =?utf-8?B?Q0NIekV0N1JKWUhQQklYcDlMa0Z0NkZLdnJYQkQxV2VjMlQ2QzlVNEFKWTBK?=
 =?utf-8?B?SWRrS0xPUnFoNlZpVUZEaWpyb0xRTjFGRFVaVkpBK24vNGdPNGJVTVNEL0VW?=
 =?utf-8?B?Z3RrUWthMzF1T3hJTXhvb3l4WmtWU1VLNWZkaWkrNFVrOEhWMWE4RGFwL0lq?=
 =?utf-8?B?M1hhUzJiYzdOMU1mNG01bzdZYk1FWEhXY09kWGhGZkFwVUlXdjdXcFdOVjQ1?=
 =?utf-8?B?QmJheGVLVGZvRitzZE85THE2L2Q1ZHd1enpEamRBQXJCWkJ1VW8raHgzRE05?=
 =?utf-8?B?YkdmcUJXMzR6UHl3OU84eDdBUWRaU3loZTFIeTBtdFVLY1VlY0FOaWpuZjZl?=
 =?utf-8?B?T1YyZTJMR3RiQ0ZHRHpDNHFGWWRucWRROVcrZnBFY2dGN2l3bFNrNWhxWWpz?=
 =?utf-8?B?TThjUjcxY1cwQUU4dVE4cWk4M01PMVVmTlp3dENnS0ZjYU01UnUvSFNJNkE3?=
 =?utf-8?B?dUtEc0NrcjRxb0pyR2FaU1ZkMWN0YnEwNVRzN3JiNDNwdGdHVXY2cnRMb1FP?=
 =?utf-8?B?UHlKWVNmaTRpNGlqeFI5OE5xbWE2NHh6WHZIak1qa2dsamw2b0JJZEZiN0tM?=
 =?utf-8?B?WjhTZHVSTysrTXZESXpXYm5TUExGdG9pbk8zNmI5Uzl2ZEpZenZNejF0SWxL?=
 =?utf-8?Q?vCPZ+xyFRNFozVF+MoSogIrua?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4ad506-e933-4d36-fefd-08dd05b378d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 20:24:14.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT/iKGiE/V4BVpfDEq24gbreiCC1YLuPJh8JLzbaM33dwHwtHKVoGruJcK2L6Tz2wuqH25bmFm13oWf7VXChDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8231

fxls8967af and fxls8974cf are similar with fxls8962af, only change ID.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- make nxp,fxls8967af and nxp,fxls8974cf fallback to nxp,fxls8962af.
- Link to v1: https://lore.kernel.org/r/20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com

---
Haibo Chen (1):
      iio: accel: fxls8962af: add fxls8974cf support

Han Xu (3):
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8967af'
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8974cf'
      iio: accel: fxls8962af: add fxls8967af support

 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml      | 14 +++++++++++---
 drivers/iio/accel/fxls8962af-core.c                        | 14 ++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c                         |  2 ++
 drivers/iio/accel/fxls8962af.h                             |  2 ++
 4 files changed, 29 insertions(+), 3 deletions(-)
---
base-commit: bd05b9a700c10473c2f52bf12c5c5938c30e80b0
change-id: 20241113-fxls-d93a888889f7

Best regards,
---
Frank Li <Frank.Li@nxp.com>


