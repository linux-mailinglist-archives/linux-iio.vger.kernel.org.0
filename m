Return-Path: <linux-iio+bounces-12210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33D9C7831
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C57284B13
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29A1632CC;
	Wed, 13 Nov 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="isExRsj+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCD15AAC1;
	Wed, 13 Nov 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513974; cv=fail; b=p7FxC3SL1veuZW9K/2yYNy0QGa8FxHUQhS+ZfwH5ZzqGKk5igHN5v4vfEEwnvYdVl9+o5Xzo58XfjFdzNRu2wKibdLU/2UFFDIsqsAv4aOUyjm1dC2aGDc23VceRVc92gT/k0XUcJiS2ZE9ik3oyyIJwqfheJfv0tMj8NsiiFLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513974; c=relaxed/simple;
	bh=2GIglc2YRUNBiUOAdgC38eW+xKyjgXnkl5eInQ+r8TY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AzZ5H/n/u+C8IKXvEXBROyQ3DXZFPZsteC3jeTJw95sAeReoz1wIMJt63I5H856LEehvl6cl6Cza45n5X+gTI4BBeajx9jH6UW2566mh/AaOLLIV5Kdit7tN7GWNunptkTl64vSRVT1DKuD070MjHU/ApfJhuB+Pq9qjDtaN1ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=isExRsj+; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj/Tu/71pFSfSXqxA7XE2AgGVVM38YMnOBiUbx5bDKM7us2HAl2wqzUP63fQHu7KnPUQvdBZz2g+m+R5HGXW7nzuOm9ntoT/emdjAgpNFwpiRUR8uBIZf7d9/FO4m5Ewpp5oqZhine/WQPbJYN2EV9YXcvKdxIAi9XivR0F6XcvvK5283HunjYEURpdb/ZXWBcesNJnJ9eNjq5vj2RvtJCs9J/GRMtLxWst0fyxJ22xL/G6D7uY6o1Fc8PsOLOq+q0Li0GwSx7a83DK6ewj+/mRoVU1HYHyoUOWr2ItMB3nWXx0dKQLbugP0IQlkNk/HzjB9JSX2UqgyERorbDxrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD2YT29Dl+fFYJOLSPRlz+RUWDUIDHD46InX/O8WC0s=;
 b=U1kQKLo8nfe+sb9aQwhOtXiUP07ZTtdmAD4St3wIRN6L1e5Fe3CZ72EnBXaaBYRVRQMKA6mtoYR9MJQqPH4P14O2Ca2NRsKNtAk3il2li/NwQtXbAbKt3OikLSU916DmFVCscoTelcN1RzxxFpEvtx1CoZyEO+sfO0U3Zf5RjyApuGa7UOIpygWA9nWwyUw2rKuXTPtBTt5+fIr4h3LPu3G++VyTJh+52qAJaUnSj6xeQDHjPwnGJuHdQQc29lIvo3n9hYIpQPIggjShOaWZ2tfYLdTmVGFdVovS38xhORTjQaJtO5eqOIeTJ2hg+udhDtDUfFLvnO3d2bPztYtDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD2YT29Dl+fFYJOLSPRlz+RUWDUIDHD46InX/O8WC0s=;
 b=isExRsj+43IoylLSeQjzoW2H7CyMJEumpkYkB0K1M3QZgupXF1t96Nuc8stInlM4ITi6Zz/3a8bRtYq2RzEVj+SQqmWRE7FBrS2RrUGheZhoE3KEb84bc6qPJE0LBbnNYmdoOuaPOlo+LKw/xQQVv8nbalfkdydM65mt4BIfjI0S0ImYRD8u1sbEjxwesBoBHuz+uiY9KQI+5FlORmXp16ZAEzsyRxPbwOqpTlgzcueYYaWiFngvmV9Pa7GPlAwyYRp3nbW52zB8h8gAsT1BftyhUVbpB7qex3CcVJO2GanmeUMJJFkdomaHgZy2IU0iHGYtjV++zoTRlli6y5yvLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:06:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:06:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 13 Nov 2024 11:05:56 -0500
Subject: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add
 invensense,iam20380 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-iam20380-v1-1-cae690c4674d@nxp.com>
References: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
In-Reply-To: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731513964; l=911;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y/SLDHvonML6ftv90FsRHjUfTdAiylXC+GFSzJIAgKc=;
 b=Jh/4IJkb5k6a8E8pv6OFnJ+W/3D/GPNkYqgTktn54VOGMEWwWWrRM/Hc94U3vIfGHR7xv9l/X
 RkmdK02FCx+CwEClKvsN8qWzbx3cXOe5Yg+vbnMsF0VmgpcFDpQVG1Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b786dc-8d16-495b-209f-08dd03fd1711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjZSWno5TVRTT0g4QUptR3NhSlgxaVVEbTE5WFhPNlBLV0QzRnM2czJjMnV0?=
 =?utf-8?B?bnNLWmJzYkhiblFBNFRPaUlnMExnSXNzRmozTkllNkI4M0thb3ZxR0x0SDJ2?=
 =?utf-8?B?c1pjejdMMW9ScFNXUmo0WG1jTlM5blNzLy9ZSCtUY2xaRDB6c0hHZmIvTWpz?=
 =?utf-8?B?ZkJSVVhydjdIU0xWS2VBaExwVU5OcmlEQ09ZUVNiSXNtZ1dPOXFmWnU4RU9p?=
 =?utf-8?B?N0VxbzFMdzhDMUMwRHlUSHRxTTVyVWV0K2tmMGVWVzlNRGtsM0krOVB1bGFi?=
 =?utf-8?B?VGJ4MTRoRmowMGVBVXZDb3dQVFJwbll5d3QvT014SVdFeCs3eDRrVVVVd2RK?=
 =?utf-8?B?Rkw0VHd1VEpTTXFueE9tU1d1ald2RWNVQnRDYXF0a3E1ODhZSjQzWjJxM2s0?=
 =?utf-8?B?c1BwZ1QyTS95TCtuQ1N3cVY5RHI4dHQzSUpJcW10WS9oSVBsbXppUStkK3VV?=
 =?utf-8?B?bW9sYTF2YmhYRVIrcGNkSFNwbGpiOVFhRWlWZ3lQL20zNlZOSzJJZHlyUEg1?=
 =?utf-8?B?YTV1UjZKYWlOWDJ1Z1pYenFabTJrSXVRM3NOUGgzRlQwRlNjMWllNTB0VUxk?=
 =?utf-8?B?aDF3THdqYzMzWTFSTm44S0NXZ09DVHhWODU1VG1wNkkvS0N4SHJJNk12MHVM?=
 =?utf-8?B?V3FjZkV3RVZJNEJ0N2FZbk84bHY2ZGxBSm5aT2lhKzZlYmZ5UlVLMmUrRkpG?=
 =?utf-8?B?b25ORGhMcWNKTXpVUzhyeWJqa01iWG54a2ZMYklHc2VUVHFPTk1TWkdFalhW?=
 =?utf-8?B?ZFNDazdRSU5pSzA1TENOV2U3MFkybmpVUWM3ajhibGF5NDMwK2FYc3R0UXpI?=
 =?utf-8?B?NU41ZndVYXBvejBWNVB0R29NNWphOHJ2N2JRTE4rYnNkZUsvWmlLc0pWU2hS?=
 =?utf-8?B?ODZCY2MwcXBZQ1BRb3R0L0ZkVHI2Y2pTVkpyNUZWUzNESENWam54eVg2UHds?=
 =?utf-8?B?RGFvTzdSMHlMbUcrL2NaYi94ZEhoa2Fwc0xjM3U1andEcW53YVk1ekFvaG9X?=
 =?utf-8?B?Si84UWJMV1N3VlVvMWt3R3NFN2pkdnROTzE3QXo3UU1JNXAzU3Q2TVJQY2Jy?=
 =?utf-8?B?alRnakZQUGd6aERXSmlSODUzRWtKUloyZEw0ZHBUVGltYTJWVmVsc0doL1dt?=
 =?utf-8?B?WTMxaXVFRmxSamVzUndQcU5TdEVoUllCbGxmMCtOeHhpenVpa3lzcEY4NXRw?=
 =?utf-8?B?c0c5bHVnUE92QXFuM3FITm1yaHJLTFE0aFc0d0RDdGpkdUZXaUh6b1pnUlNV?=
 =?utf-8?B?N0IyMXdMMENycHFEcjVTYVMyUmdCRExvUURpUEZkVEZVTUYyWk13bHRyUjYw?=
 =?utf-8?B?ckJ2eEczaW1odHE1SzZtZHE5cC82UHlEZVhlL2lzbmRxLy9ESFJMNlJzd2xw?=
 =?utf-8?B?c1lvR3hCZVlWckRrNE1oZmtjZFY2VjBBemgrZ09VRVY2YXM1UWlEVzlCd29V?=
 =?utf-8?B?OU52QldCbERyTkI2Sm9JNnYvc0NlR0hSaXBseFhsYkJBTjJ1OFhRRUwrMXY4?=
 =?utf-8?B?QVZSNTRVQ1JLVE5tV0F5eFhyMlRxT1JOYVd1SWV1WkJIZ1RUSWRRTmh6RWJu?=
 =?utf-8?B?RFRuK0hUd2pVZnJCM1BjY1VBTHltSEducGtWaWh6RGRhcElDV205RmxQalAz?=
 =?utf-8?B?RHNML2kvREo0UVE4Q08ra25kUC9sVUhsRUdRbHp0bG1HUUlvMTdIZnFnODEx?=
 =?utf-8?B?QUkrSXl1TmhIVk8wK1EvTS9Ma1NEd0hsNnFSZy8wZUo3WEpTYWlUMXkrV1dq?=
 =?utf-8?B?UVB3ZXUwT2ZGRlhBNFZSaTRLK2k1VnRxc1EvWXRFNDVUSm0wYmNuZkdqc0p3?=
 =?utf-8?Q?i72EG1irVuHm4W5QUMIvjMEF9qqYWjSDRO3ec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0dKV3ZpdndoeFo1MEIxNUR3Y2t3OUVMa2MyVUdlak4rejk1R2dOczBVVEVy?=
 =?utf-8?B?ZktQcVRjWVdPQ0xMM2Jua2ovMDRQWVp3czczaGJ4cVBEL3oyaGRxVXZmNmNN?=
 =?utf-8?B?Z1hIa2FsTklQbHh5SFA1cVRZR0xPSVZsekJVWi8rSDNYeVlnMWhBY3ZPVW0w?=
 =?utf-8?B?bUxpcUdubWh4eWdSK0VKS2xZY016OVpPUWJTaXV4YndoVUMxUndqMzNJQk5s?=
 =?utf-8?B?MGZFNnYxQWNTQTFDbktRNXl4dFJQem5pZjFGQVZ4UU1BSDQ2c1IxeGdmSnUx?=
 =?utf-8?B?QjUxejFkb05ZRVdUejNBdjJiQnNqQVBJMThUSFNMMjdlYlZXV0NnR0FJR3p0?=
 =?utf-8?B?UHlqWXNuNms4TCt5cWFrem5UMXlYSjhYYVZZSUVVY2RZWHo4YkVXc2Z4ZExy?=
 =?utf-8?B?SHcvMXRaR0xMMUhHeDRiU3lhY2dIK3FsTG5OeFFtWi9hOGJueXBxT1hyKytt?=
 =?utf-8?B?aTIwRDZGenR3RnU5Zk9mbG9naXZMMkxvOElsL0lyYXlQTTlvSk4rRXVLbmlQ?=
 =?utf-8?B?QUczbld4VEhGc0NmUURlajl2TkxBNnRJdjVOZHdrc3p3eS9DSGE3M2JFaXV1?=
 =?utf-8?B?ZmJ0YjZ3WGVQaEJ1VjlqaDFmMzV0WWIyTS9qRk92NmdIME1wMWlWb3Uxa2FR?=
 =?utf-8?B?YzA5dWNGc0x4dXVFSFlwZURaWThYVFRtSWVqaysxdkQvQ002V0VGa1hja3dx?=
 =?utf-8?B?WkhZL2FBc0FvUFhnc1o0UVVaNHd3RW5yL202UWJQSHYxZlFSNFB1eWI3TlBs?=
 =?utf-8?B?My9UTHJGUU0xTlVSUXkvdGV5VHZ6bXBxNkJ4ckNPV01FUzJCQnR2SVA5ZTRm?=
 =?utf-8?B?dDRVdXJOUU56OThLdG8rU09nK09Db01TK1UvZ1BRR3h3bFdWem5zSUROUnBj?=
 =?utf-8?B?aVFwcnJXVGk1WHMvTFJ4OFF2UkpwS2p4K29jeHJ5b1RNQmZsYmtMYVI2c2NW?=
 =?utf-8?B?cHJRb1kxYXFYUjUzVVp6aHBGd0hrdWdGbnBIUHRQeGpNeGlBV0ppbnJkMi9G?=
 =?utf-8?B?b09yL3NCM3pqNGZwUVFrN2dQK3NNQ1dLbHc0WlFEZ3JLSldZeTVrYUhZWDlk?=
 =?utf-8?B?U0I4dkphRlZLeXFVcTBadlZ3elhVWTg5dnZHQmZ6SzB4Tzd0M0dweUFpY2Ji?=
 =?utf-8?B?eUNoeTFQWWN6QXFZWTBmLzRQYXZOWlNjdG9PN3dKRktMZWpidEFrNTMvVHZk?=
 =?utf-8?B?UFZaamhYdzBpY0h5RGo4SGs0UEhZWlg2MEZvN1FwMHRkdjA1NkFSN29aN3pO?=
 =?utf-8?B?SmZGc0FhYUpkQ1Y4cWRlelhnV0ZhK09NYmpMU1BKZktEb3RZcFZWQ08vYThr?=
 =?utf-8?B?SEJDWDJSbDZCZmJMZHlCalF0K3RjYlQzcXVOSkNYdVNvOVFWWUdTODMzbHRM?=
 =?utf-8?B?KzBKRGMzWmZRam9TY3MwTkxOc3U3WW4zTnV0OEcwb1V5eGgyVkxKaEY0UkVn?=
 =?utf-8?B?dkpSSVJaSUJlQ3E0VnpZTHJVTzNlL1NVMmlOc09mTHhSWURzcEVnU1dsOE95?=
 =?utf-8?B?OUdqbzdMUHZoRi9tNTM5ZmJTd0E0L0RUNUZ3TFhOaVNISkd4WEc1V2VUYS9l?=
 =?utf-8?B?Z0ljaEwxeDRJaXBMdktjdDFOUmk4RGlaVE5xU056cmpLVXNONlMxb0lLaFRa?=
 =?utf-8?B?UFFXUkUrNlZCTDdqOStsVU9kbkR5WUk0OTdFbkNNaUNyMWUrK1R5Nkg2MGEx?=
 =?utf-8?B?QTlWZ1ZmZkdVSmo3OTh3NC9CQm44TGM3ZHdaN0FpTFRjd0hKOGRLcGhMdnBu?=
 =?utf-8?B?Q0g5d2RFMW5xd29HdnNWR3hZSVdQUjQ0RnNSc3dLQzBNbUxmekh6Ky9SUC8r?=
 =?utf-8?B?R0xlYnlHZ0k5SFBXY2I5UHVid09POEJVSGwweTBCc293blF4N0hkUzd2RE9B?=
 =?utf-8?B?RlRKREZkL3ZwTnZKU012UkNuQWFoWjExNW5RV2FFTnZkOEwrWWdydDIwVmh2?=
 =?utf-8?B?SEdORS9zTVB1TXowa292elkyV3NpTUF4bmRvMitSdVRaWDdBdEtRQ09ZWENy?=
 =?utf-8?B?V3B1blFMYnYvaG5LMU5iYmR2ZzhLeVFRcnJXeFVuVTg0VkJFY3FuSmlDKzB3?=
 =?utf-8?B?Wnh3WVhNaGtrckVESVpRcG1DeDh1dUhZaTRmYXNUU3V3QW9sUDRjMSswNEtD?=
 =?utf-8?Q?xkGDhwoEneGkChB+dyx4jH3Q3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b786dc-8d16-495b-209f-08dd03fd1711
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:06:10.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tUOToh4ULcCwVhS2lfb0X6LWVTzPC99FF34pLkN07WdfbhJ/Xjwo5kP2FhL4itZ8GT1u43zBFykDGK3QCsf2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400

From: Han Xu <han.xu@nxp.com>

Add compatible string "invensense,iam20380" for the Invensense IAM20380
sensor. The IAM20380 is similar to the IAM20680, but only supports gyro.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index f91954870a44c..0bce71529e34c 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - invensense,iam20380
           - invensense,iam20680
           - invensense,icm20608
           - invensense,icm20609

-- 
2.34.1


