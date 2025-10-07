Return-Path: <linux-iio+bounces-24827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD87BC1EB1
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C9614F7356
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B72E62C0;
	Tue,  7 Oct 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nr4hR6SC"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B72E5B26;
	Tue,  7 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850581; cv=fail; b=ER2zT2vwc3w05kFE0SsSmwiKomnnKD641GOz2k1qs6PWHEMS5g3q74D3oq7bQtHDBNXHCv9MgR7b3O14q6OhZvO8A+NQEaWlEnUe0Ttq7FM49bpZ37aXhLIJsXISTPbyMnnGU2wt0eNJg9BKItJYTvsTfEH0ZdZaUQRQTZfOOGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850581; c=relaxed/simple;
	bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RzL+sTXypU3OlT7H0iok8GuAfDXy1zoZRi/zVUSyeOMFr/u7InT1xDJ/iDTi9Rd9Nwq1JFOGdfo3TUt7VZjvZshOC+TOcHYztbyLcR520Cc3ywguSA07QXZ+Bd3veBzhOztpJMdstHb9EgCeb2V10ybaPMmDlN6wCLB+DB2vf4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nr4hR6SC; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQAO4XX3LAzWZ63AoV6utKbb3MpUVWEweP6V1cIaNOAufgPN+RViLQMh0JUsI48RUbjQt3Qjmr3f0EUwBRHzMjPvqipd6K7O0Yk091YjGlPpfWOP9i+dJIdsBoOixw13mtfD0vB3Iy/GVWNu3QeBrxcAe3N+0IXlSShDWgDbpM/skSXJ/+K4JkfgluYeOwkIcroSl2sy+L7OaRghBTe9uCOYEPqNHfEGZBPAWEBYaQK+6kzNar7AK/49VlvmiB19r6JlXS9NULfGt9qV0vFfrURvICKV5EtgE8e2P2QMmoEbpoRNHASoGYgHo7jwGNhE2JADNNYSTccrusWmSdPIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=hIVm0TCL+b5BQZgLB70uaGyvwSudgn7ABrOpOPevYBcAHlTeOi+vjH7I0IzwMvh7nxlsAYmm14TkO+i17lu2JqgNCui/9NqZoU0CeJPAgram8qo5/Dw6sihzpGGxK3nZ27Hk+j/mPbSFmfMBR4MWYQSTSV+td1+3y9g3csHp4u8HquTdb7MG0iooJp9XgLj2sv+kBkoDsRXE2vHLXfg4CJGImsFVVh0Tiuwzw/rtiVo4y4vfWAKSZuSZUIDK4ewnxYNvoWMQnWud+OT4ucuHKn93H9HhpZTFeXdSQKK8mEfZpeobSn8LNel6sRi17SfdqZSrfRA4fwfGnK+HYQ+fyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=Nr4hR6SCwUPfjaqWAW90F827ntNPnGWi0Mqn4C8mhlDlr2roUS1dKLRhdUb+0dQQ8/XfQPy7MsuqNnze2gaZeSkUDzu5f4r/MTn9BvopuXrteFWgiGOw9KZg26QKqsk+gJ0ti+b1/Ju1U+yBHqTMdsjlnupN1RgzgVNMWFn63M15Oy22kJVax6misbBN1gHNvlXnn1HHfIS2gi0D9JCE0BsVjSRjyF9d6Yp83F1p5wXOmIoXj4vyYm1b/xX1Bhh3rA1oPe8Q8C7ic73aYuLVLhtwjhZbwG8/zvirtVLMcUlTQnQ9cXcdw/3F+C1y6ooB3sHrNQG4YRti1J+bPbkKvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:22:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.015; Tue, 7 Oct 2025
 15:22:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 11:22:17 -0400
Subject: [PATCH v4 3/5] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v4-3-3afea5105775@nxp.com>
References: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759850558; l=7659;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
 b=saBtCxZFDmUnT0WuUgPwmD0D1BdXC09jblAbwiL0XecSzEHDyad+1fCiH63njtWb/wHhe7ZXe
 HGZ88UGmSrUAxMcirYXdeiWAqbjJqOx9yzkqvglrouSemMNb/SBGPBS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c54357b-65d0-4d26-c2d2-08de05b5628a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnIrMUhvQ29IcE9odFpKWXVyYjl6VExlczF3MkhUTDdic1R3aEpnRktsK0VG?=
 =?utf-8?B?bHlxMkQyM0tHNmlzZjVXTTlnb1BTc3JUdU8zcEh3Wm9VempsQXk0cVdhSUR3?=
 =?utf-8?B?Slp3eUFtaFIvM1RYUEZUMGJvYzg0eDB0MjNxSXpNY3VKMFZlT2UxZWRnaTlu?=
 =?utf-8?B?bXdDL2dzamlDb1ExVzA0bW1NVXY2MlhOMDVJeS8wNGxTVzMwV2s4TWxaUUxr?=
 =?utf-8?B?ejlkeHJ2NWZlNEZCelllSG0zbHJPazZ4cFZQTERhYnJFREQ2NVJTT2Y4Y2gr?=
 =?utf-8?B?aThIenlvOHBvcS9hWm5WalJDUmJWUkFMT0JwNUsya1ExMm5GLzdnY0lWemFt?=
 =?utf-8?B?bDhUWVJ3aC9pdkJiRTgvL2R5R0NCT2tsMy9pelhYMzlxYU1Pd01uaDhVM1JG?=
 =?utf-8?B?ZFpVNTJBNFVldklkOTlNeWNpYzc1NHFzWlYyVVVEd0dwTlN1dmE5Y2JnNzRj?=
 =?utf-8?B?RThHUGFSMEdiL00waVliR251TUM4ZFJUTVdLc1h6ZmhLYXpUQjVwSVRHdno3?=
 =?utf-8?B?c2EvejRkL0lxZVZJOS9xaVM4SUhEeGdXV2RyUUUrQkgrM3AzcFd1Rm1iSndv?=
 =?utf-8?B?U2pySHhWcjZ3L2RHcTNMeWRwU2VPT3M1TERnSW5QMGRNRWNseUJuWWlqSUJl?=
 =?utf-8?B?N2VOa2NsWnFJK1kraVpnRDdYR1NWL1NpYjZFRnBtQnJ5QzRHK1NGY25NZGxC?=
 =?utf-8?B?L3RQRjdyK1VRUXAxMFpsYm9wdHJZZmhPREFrYytuY0Q5RDc3UFYrazhoZCtU?=
 =?utf-8?B?NW1IdnFjalYvc1RRaWd4c1dOL2dTRng3TE81dU9JYXB4eFZTeUl5Tko3dlhU?=
 =?utf-8?B?eGtLZHlQWFhZWm92alBFNERXdjFMVVVoQUR2dGQvUGdrQ3NmRS9ZajJ1NjlE?=
 =?utf-8?B?QldmNWFzNk03TW5TODliRzZJMXhLaldYK2VtWDJTVEVwYlJEVFdLN1ErdDcy?=
 =?utf-8?B?aks5bVdrdTErNExZaDIxSVpvNUxEaUY1R0swQktZU01zQXlPQ2J5Y1FGSWph?=
 =?utf-8?B?ajF2Sm1PMmhGQjBpbzR2b0hmYXpnN0pYR0VZMmpSTUxLSzlLU0RxaG5UczZL?=
 =?utf-8?B?QXlIUndMempxR1NHT1VFaiswUUw4NDlvNlJ0YlFFNEdZbnNiRFgrWXpDTHhY?=
 =?utf-8?B?MEtIMlJUQjNkUW1hM3BQRTJKbTl4d1VOUFpyTkZ0STY5a1g2bGtvUXF4Rklz?=
 =?utf-8?B?RitPVW0rcmppZkduQWFjbVBkc0tsTGw5MlpNUm5ydHd4QktMTmJIWThTMEgv?=
 =?utf-8?B?YWlReDhsWngxZTVZNm9hU0E1bndHYTZCb0J1Si8wd0NuZmhSSzE5Q3dUL0hQ?=
 =?utf-8?B?dnpEWDZLL3dSR0xyQmpwRjc0aXdncXBsVzNCa3k3SkR2RGdESkVQWXExOWtr?=
 =?utf-8?B?aXVybmM5QjJ6MDRneWVGa2pweVBTdUpQMWFkUEdUTXdpTGthTW5XSWNLckFh?=
 =?utf-8?B?QjlkQStRYUU2NUtRYy9GZHVvSVFMRFFRWDQ2Mm5DWGx0SlZmTzVQenhwMzF4?=
 =?utf-8?B?YnFMYWd1QjJxWHo2SFQxSmVodEt5dk5iMW84MWFzTW1ES2pDMTlkS0NRV3R2?=
 =?utf-8?B?aCtZaVdiZTkxQ3U1a0h6a2FmNEF1ZmJmVXZYQnpSeTAxVXk5dlptNlFpblVO?=
 =?utf-8?B?ektGc3g4TW1ab3ZTTGZndGdPcGpjUjM2SFdFdWdMcXA2S2wyVlV5cDdMbUdh?=
 =?utf-8?B?Qktwbzd4RzJBQTZNZ0hXeE91cU8yOUMvK0JwZ2RxN0g1VEc4ZFZ2Q2poMmVy?=
 =?utf-8?B?eXd2K3hsdElXZXR0SStBSHVHVmFzY0pGYmI1ZDdEVE1vcTJkcjZaZzh2Y0NP?=
 =?utf-8?B?d2VpTnRiWjNnMnFJYTBNTXhtY2tUUWdFS1c2K0dCVnBzaTVjSkFnWjNoL0JY?=
 =?utf-8?B?OTd2UHhGendyQW5PWnNuZWYrVzVkNWR1U2pMbzlrZ3VocUR5YWUzQ1RiTExs?=
 =?utf-8?B?MUl6dU9YNDR1dFYxNXFuc1FlYk9DTU5RSGxwcnZZeXRFZmRUenJjWHBxVVAx?=
 =?utf-8?B?TzVMbXRSRFpFTlFJN1JrR0dLMjJrUnNWUW1ZOWZMczNTQmkrWUlyQzk0cHAx?=
 =?utf-8?Q?7WPSly?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlBJb0hqNEZzdUo5MzdBYlZjVDBVQWovS2VNOGQvUmdUMGtHSm5FOUkwNlJx?=
 =?utf-8?B?MElRMXFaQy9jQmNNZWRnQ1R4RjQ3RFFUTTRMU1MzVEJzb1JvVmhQcHBlL1o3?=
 =?utf-8?B?Ti9VUnJkbEl2SmN0Rml3ajJkaHdTZ0hiUlZzNFBqV3lTcEptdVJpbDN5U1By?=
 =?utf-8?B?TVBUQ2lhWCtEcUxRUjhGa3ZiN1ZJUzRVcEVHQnVKSUdvbnhoMEg3Q3NwK05s?=
 =?utf-8?B?MWlZbFZtSjVocjN1Q3NqRFdHOHBUQm1BWGt6dTVlT0lDcEhsekM3RHpvaTRY?=
 =?utf-8?B?SDdhbDJ4VUFUcDdXZ1FQZ3p4TkJtYlErditzdUVrTGNGcWI2S0ZWWVZZQlFt?=
 =?utf-8?B?MGY5L0p1SEltbkJ0UWhvMWRabmF1QjMyUVJZOEVwdXhaNUgrQm9NT1k0NEpm?=
 =?utf-8?B?VCtJNHlqOG1YTFZrQ3QrK09YUHE3MXVOcml6SDV5emx6WlhEVzZtbHhhTDR0?=
 =?utf-8?B?bEJTaGV0bGVUMFlGYTg3NXZUNnNLV0RZNWMvakdjRGJUbzVTQnBZY3RCbVF4?=
 =?utf-8?B?dUwxS0NWbG0yWHZzOENpdzZxQmRkeTlNSDZjNFVKMjl1WjVJNmhOMFJxd0tP?=
 =?utf-8?B?dG9jTnpUaSt4QnRWQXowL1dBNFY3bEt5Y0NKeWxNejBKdDFjZVBmS0paMVhW?=
 =?utf-8?B?SU9HR3paVVJGOEk2Q3JIVHRML1JBMk5xOS9yaGt0LzdYeVIybWd2YXk2NjNV?=
 =?utf-8?B?d2x4ZWIrWnNZYno4ZHBxaEdCeTZXOGxpMWVucmMxVmJKTkVaTUNqYjRWZk5v?=
 =?utf-8?B?VnNaZVE3bllDUTFnSk0rOFVKdnY2NmZocDhqK1BiSjhPQUNTUnpYamNyOHhL?=
 =?utf-8?B?a1Fhc1REYm1jdkZPNVp2NGQrNCs2d0I3dmMzRW1yV0MxQThUbkRSek5Oeldh?=
 =?utf-8?B?SnVOQUsxSktwNkx6bFdyNE52UE9GK3VlV1lvLzM3Y0M0Q0RRTEdOT1VmMmRp?=
 =?utf-8?B?eHozZVBEbW42eElUYmRERGFObTVrYXd6U0t6WURwZE82T01DbHpKdXZ1UXlr?=
 =?utf-8?B?clZUUmpIenprUGZ5ZFkzUTFIWFY0Yy9Ud3pvSW1NYkFZaW95ZC9zdFkvdHZZ?=
 =?utf-8?B?QmV6aFBGL05XaFNRV2l1ajBZdDhKVjN4WDF1Q1d6Q1MzQVBJcllqMWsxMlBr?=
 =?utf-8?B?VHpKVjNCc3NaQlMvNDdVenVCR2o3YjNpMC9EQ0craUtVdlk2eXNTYkFuRWw5?=
 =?utf-8?B?a0ZXNEMwQnNTcnJtb2ZwV0JUT3JtWm5sZ2ROS2Q3cWRQdXZOUjM2VFQ0dnNJ?=
 =?utf-8?B?b1NxUnB2T3RrZWVLLzNiTCsydVljSlJZWTJ3V2xFeVM0QzJ1NmlwRjhwdGZq?=
 =?utf-8?B?dEhJajJPSHBLcnM4ckF2aXduelkwT3V3UGZCaVNXdFFBYWF1OThYaFdZMW1Y?=
 =?utf-8?B?amYwRSt2TERrK0luZlpSOWthQ0huTjhlMkJZY3Z3ZUo0WENacUpWUHI5QjBF?=
 =?utf-8?B?dmNXZDFFNFBESkh1YXFRaHdIVTd5Rlg0WDdvSkRHNHR1eTVRZDNhcEJJSjBF?=
 =?utf-8?B?RkFVYnB4Zk5PZTU4dFhuNWpwL09vRVJLUVBJa0ViTHBHVWpVYmRMWGxVRjhs?=
 =?utf-8?B?ZmdPMDZjSlNGcDFaRUNaalIyYk1YeFlrSXpsdElyR0JzajlnVENZbXZQc1Ry?=
 =?utf-8?B?cTdhaGY1ZEQ5V3ZuWmxabThGendZTU1FT29SNDhwQlB3YUZ4eHFoR2RpK0Q3?=
 =?utf-8?B?SFlDaDY1elJMOGpTRTlDTWsxb0prTGl2UjBKVUNod2I3SDNaaVZwbzJSQldv?=
 =?utf-8?B?Zy9rYXJOOE5aRmZrV2FPMTVRa1l5WC81SGZDZlQ1djRMVUNZdThnWENBSThh?=
 =?utf-8?B?bDdpRFBPR2N4eDRFS3FqQkNwVUt5OVcxczBxWkwyTFMvelhWMXVBdk9jNy9k?=
 =?utf-8?B?dVl1MXl0UG1ZcUFBTko2RGpZV3ZiWGVpbzJXUWZDdTR3Y1JHWm9nOXFsczhO?=
 =?utf-8?B?UVhKWWxzVWRzdm9yb1lvYnVVdWtFZGIxR2hzMzhzS1BZbTRuczd0dUNGenlj?=
 =?utf-8?B?UVZqRXptNmQ5TDVvSDBMUkxwc3doUFRLWGdncVR4aStGdFdoeE05ZFFHTW1Z?=
 =?utf-8?B?VWlLL09VUGZjaktqOTFYVHZ5VXZnREhCNGtQbzR0a2N1UmF0ZC9wVWZVWlJa?=
 =?utf-8?Q?QlVd5kLJy5qGoA6NCyhilrbK/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c54357b-65d0-4d26-c2d2-08de05b5628a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:22:53.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2GzbU6pVGBn7nPjjBzeVGSvDp/JVa6orjOTtpp9K562Jj3Ntjl2pYX9rmBEfLYouqA7aS9EMYSKr6QSJIK8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- use hdr_cap.

change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 77 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85..f25c9ed561290d2a33046855b84702eb310590b0 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -389,7 +392,17 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg = 0;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -780,6 +793,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1293,6 +1308,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+		if (ret)
+			goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1386,7 +1411,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1399,10 +1424,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1412,7 +1446,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1459,6 +1497,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_xfer_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1648,9 +1691,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1658,19 +1700,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1869,7 +1924,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,

-- 
2.34.1


