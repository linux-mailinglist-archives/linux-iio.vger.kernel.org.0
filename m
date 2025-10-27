Return-Path: <linux-iio+bounces-25543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1DC1157F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 879F7506F62
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5B320CCE;
	Mon, 27 Oct 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UC33+IFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34232779A;
	Mon, 27 Oct 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595752; cv=fail; b=TC1xtA35HWOaisERX9K/xDu4rHou9UoYmM/MOroo24G0+m4840xtQON6jq7p1e1dRtIy2glzXAFk6ARD7F4pnQq+8XHfFazcmESXfnzr+vCz6GJO94MynE/uoJIj2F/SJhAZ2L2/SvuqOMQQXWIjLKdaRhYdgKmwwpOU+rFDRY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595752; c=relaxed/simple;
	bh=MXdfcOlomcKxNyAr9MXZ8gD5rAqp/+jFkqESujXramw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=igb3xpT0YS88QoFtv5deaF28ep4mw+JoeA/ggSwZMI9s8UMDFnuOJt3/w9eRkmRS4nJzHe5LHd8VV44nI/ptReYZzm4v13zWd9Cenmz/yb8ZwJpw/tU3meYMssHD6h/zIAXC2KokK1PtvnB4DijZonNu0abfhjta3Slaf1R6OiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UC33+IFI; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkXZXI1tjQTU3W2TVcl4w7ar6IrzWyxmyNDJrL0wiz5x+u6PFeu9Y0X1cQjwh0cMo4Widi5F/GTm6TtvJ+lDxNMHvnhcJqZWEC/DEMHRyKMsNY4VkVUH57cOoRyMe90/vJssJ3BFDxGlOlgXV/yfiGgD1kKw02R/pVAGLYM+unDaTgLfYeJj2ki7wg0oFJEc7Gh1HYBQCfv2suGX83gydQlzNrO9+kYGIhJWcZRiEA0AvihXqFTTq5lcxOzEUZyDOMrQgwIilu16o/P85DueG0MCMXzTOE8tc4h7xn5CDdm5pzG05pbulC16DMEK97LOAiFaL0iulOVXlaALxyUMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcscuMED5rYImIkNErwswgsCNJqWvJZ4j6X0DuqFZw8=;
 b=xA4cVygdlM1ICJ4BI1W9PaAMI7qp62kdJ9chsvsLnaLP9DVtkYi2AQkMILwANRT305Z9Iv8F308cZSSQ/x9izW/WaKlgYvR8cFS7TdBYXWi898oYell9Z6vjkS4/3ju7tnfzX0PGpROq4QTXJ/ZjtVna5jJ23QQhfoOqmoAloNNOWdEonL0804NS/hHnE31SWqXIlhQ8HqaWEv3ZfihsE7Zr2pPr7vgngzkqxBkstE+XJma6x6Fpwrnwsx4Jc7NR/nCh7RaX2Set/MmDgXErkWYJyB/4LN3XujfOvC1Nj50nBlp/bL9Ai/E8B1S0JbpmIPdYTV+CsAz/sjP3B53DKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcscuMED5rYImIkNErwswgsCNJqWvJZ4j6X0DuqFZw8=;
 b=UC33+IFIdqXMB/pyKuvcigsuuZfywcZze7dMyvQEaCwEAhfkTPtFK3EJehR+Q/SMQUteYsGJQP2ynheObOkOpqIu3djOqNd24AFH5+/fOujtYorN3d5gIMfs0SVSPuE2s/TUz8ZsZhbuQcJ5hJUDiLvUsv+8tSKTD4Mbu1fH1TVIy73VBkONTIKz+QaOQCzLlN4yAbtBgT38XATUtxf6oGTXGqZ80wD69UxuP+/bz6CwAobDxfwd+/LZjNsotDnlo1Y7/zHgzjIHxAC9mg8MLSl1knW5AjCKivbvrxMxnePF/5X5W/mgwR1IvMSpJDQur2PIVp6MP5cEjpPhfC+N0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 20:09:04 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:09:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 27 Oct 2025 16:08:33 -0400
Subject: [PATCH v7 5/5] iio: magnetometer: Add mmc5633 sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-i3c_ddr-v7-5-866a0ff7fc46@nxp.com>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
In-Reply-To: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761595722; l=18712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MXdfcOlomcKxNyAr9MXZ8gD5rAqp/+jFkqESujXramw=;
 b=ggr2HQ/e6W2o68zR3YgiXlm7vkO/NfYIoAPnanW3mz7vbCBv5Yq24Q+SnMf61q9zjx22CgBRt
 vAj3Nm2R9uaCtkllyawABvayVqh77uGfUpRBGVoTnSLzBKpt8ZebUmg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH1PEPF00013303.namprd07.prod.outlook.com
 (2603:10b6:518:1::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: a98af173-2c6c-4cfd-8345-08de1594adb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU1ZMW5mRWNqNWE1NlZlRFNGSnhmam9UbDYzMVhQSTBOeFZzVWhOeEIzQURH?=
 =?utf-8?B?RHB1WllpMG1uczRMemJFeFN5QXVLbTN4cVVDbnZmL3JJSVZwcG0ycy9EdjQ1?=
 =?utf-8?B?RWxockp0aDh5M2RCL1Bmb1RZMUtjMTdPa2Q4aFl6SkV6c0w1a0p4ODROU2g5?=
 =?utf-8?B?L2MwTGtQUVpZWENMYkY5ajUzQnd1MjRuUzVyNVBzc29XeWRlWDV1cm9kVjJF?=
 =?utf-8?B?alN1cEdXY3BCVGpMa0wwS2xEYVBwYitJV1duWmxQUSthbzZoMFhwVHhmOGsr?=
 =?utf-8?B?WmRzalc5Qmt6SGNrcXRLcWwzdWFpYllleG1WSzNtTjdKdUpPYVNMRElJY3ZX?=
 =?utf-8?B?Z0tpdEJkelFzdzVqU3QwUFc3ZVJOZXU1RVM0KzZUMFJSRkR3Q2lTN2gvSUwr?=
 =?utf-8?B?dDBONnpyUnkyVXV0ZHlZOUdQU2RtaE1vNHBjaldhWCtuQ1R0dDJIS1hxNnBa?=
 =?utf-8?B?bjVoUTJzT2czeG03cS9CdkxHOVNVVDUwUk4vWW1jVHBuVzV2TEVyQjBpQU84?=
 =?utf-8?B?SEVUM2wyeG4zd1IyNnJJOTVwWTlXZmlLYkJ0RzF4aXVmd1BDbXdCcklpb1pz?=
 =?utf-8?B?STNMQkp3THhiSE5udG1kODMyUnBybUdYakJTWlVRMDVkMHlkRWRENjR4VkFp?=
 =?utf-8?B?eWdoVjRPT1N4TE5OTUE5ejMyNWVQNFQySURJK3NpWWJneWhSQXE0RFEyZmNC?=
 =?utf-8?B?S0Z2cU14Ymx6a1BTbjhKWEZWSW1BZnlJSVBOcWN4Nk40VXdqOU1CL0NJVUdi?=
 =?utf-8?B?Ui9ndlBVWE5pbTRXRlhZZjJENDdGaEt4UXVVMXlHK3VOMFhtR0g3MlJYVWdK?=
 =?utf-8?B?YVlWeGJNNHJLUWUwNm1sejhISFhPalNXNTZkUlVNVzlxTzNhSTZMbWprVG1w?=
 =?utf-8?B?Y0piRGpST1AwMVM3Yldjano4Z0NldkVOcHZGdmdxRWd4MWRCcXFVMjhNKzcy?=
 =?utf-8?B?M1hmMG4yNmFWenVjWjQwSU0vaExxSlJma2xNMjBvdGdPQnhnZ2I1dkpCNWs5?=
 =?utf-8?B?c1RSRGU4dEhSM05XOUgrMThMNmxGVlhEUUkxQkUrQ00wcnpCMGNJQzBBNDNW?=
 =?utf-8?B?ZVBBRlZ3cGNpeVNlUHprNnRUaHhKWXZnTmsxeHpBZmFGY0tpNWoyQVQ0aUVv?=
 =?utf-8?B?dnpadVlzbXJHM3BuNkhoYTJjWTJoa0RRYmhZaUFQVW5wTUdacXczN3Y1cTZs?=
 =?utf-8?B?SzFROXpDT2wyM2w4czJKRzZMUk5EZThreFk4ZFl6Q2xCT0lTNkgrUWJ1Z0RY?=
 =?utf-8?B?N05VUmhYb0JnUWtrQjdCVDBqa2ZZZ2R5ZFJHbUtNcFNsLzVEbFBacFg5dHRs?=
 =?utf-8?B?UWFqVUdaVEJOY21lWHcybVc1ZmhpM1UxSHdseStwMFBIdUkrNGNYUGVnS0JS?=
 =?utf-8?B?VGtPYW9RVDc1S1dOdDRXaCtLQlcvMFNPNjR3SCs3RHJETkgzM2hmcDVwTGtJ?=
 =?utf-8?B?N0I4TCtpd0RRWWZCZUVwNzRwUWZiVWluQkFoZHIxa0JFYXUrcHF3Vkt6WnFU?=
 =?utf-8?B?TDBUb3JLRWtxblczMHpvcS9uREdwV21vR2NBUnJwOTljbFBMWkl2UWs4bUR0?=
 =?utf-8?B?bmVCY1dId1BxcVMrUDR1VC92MU9qWFovN1QycEpZbFJicnZyNjlub2JLL3Va?=
 =?utf-8?B?WCt3VmVyZzBEZ0oxM1ZFeDV5ZFFxZE1FTnY1cG5XOVV1eDJhUXJlcG44V0pl?=
 =?utf-8?B?d0JTQmYvdllEMnkwY1htR2pPd3lLNXk0d1c5M3lvYkRudzUrVVdVVW1KSURm?=
 =?utf-8?B?alZGUlVDU1RyRlZVODQ1aFhYWE9rWlhmYWFNdGNrSGtJamZjTnFlbVdBTEV3?=
 =?utf-8?B?RHoxbHByUW94UW5VQ01NM2hKWkppaGxnK3NVN2NnRHJuajFzRnRFZE5lU3c0?=
 =?utf-8?B?Unc2dnQ0MFZsNFM2dzB4elRvU01hMHYreGdWT2M0VTB2U0tNWlhmQm05Wmpm?=
 =?utf-8?B?NjE3THR1cXNZNG05SW9kNTBlWTJBMjZMNjRzU01XMHhIRFQ2KytQcUsrb3dp?=
 =?utf-8?B?RWQzTFlka2hCQ2dMRVdUbERVdHBTdWlld1UvYm1Zcm5BWkNjSkp0WnhiajJO?=
 =?utf-8?Q?Yvs4HN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTlwcndMNXpINzBYUlJGOXg2S3A3UHBEdG8ySnhzbjMreHFibHJldlhoMjJJ?=
 =?utf-8?B?NkZFUmRMbm16TTZyQXNhVWJGUFptSnFKeGtMMjJ2U1NkUFNvTVZ5VTg4anVG?=
 =?utf-8?B?SlFrcEt0OGcxT3Urb2Z4eDJYa3ZYUWVuOUc4bTQxU0FtRVREbzRqSFE2dzF0?=
 =?utf-8?B?a29qRjc0VCtoUGZjbUYyMCtsM29lVEVwbXJBREVleFJyRHZrVjh1UzhmU3dH?=
 =?utf-8?B?bnJjMEFwbEV4Y3RtR1lPaE1Jclo1T0ZQbkQ3VCtFeWFnY0tIRHBUMFUrWjJR?=
 =?utf-8?B?VkhtbnBrdTB6S0IxSVI3QXdRY1ZnWFVVazZxb050TlIvM3pONUl4cFV2TU5T?=
 =?utf-8?B?dzQ1K1d3TlBOUXA5RzdLbEljUmVpbmNSbmtNMjVPcUdoMEx0ODFzelkzdW9Q?=
 =?utf-8?B?OGM5aDFWVWVqNlpOTXhPRytobzAwRWFvTklacE80WENta3ZhcVJDWmFtNWdJ?=
 =?utf-8?B?WS8rUVFXU0UrSUE3R2VNaE5CUGY2aTdTM2diaFBuSjJtS05OdndXaGwzelFF?=
 =?utf-8?B?aFNkeVFBVVlOc1JYdmJLejNnQkZMZXY0aDlxREtnUWRuQjNOdXM0bzdJR3FB?=
 =?utf-8?B?bEgyQXE3Y3VWV1NzTUFzTjArYzJmdG1pNjJBcHpEZ2pmdXd1UVVKLzMwamcv?=
 =?utf-8?B?dFpka3RrdkMrc3VnQ0pwOGlMZzZUMVZuQk5HdkxTQUNGd2tHd3NPeFBjOG84?=
 =?utf-8?B?ZXErK2hIMkVPNDN3UGF3Qy9KTlJjODd6L1diWGQ5UTdxb1RMZElQOHN0T1B3?=
 =?utf-8?B?YzlpbC9LUHpQOG5OUDFFeVdKR0pTL2dxVjMwc2xrZ0czeVdTSEdDSWdVcnVa?=
 =?utf-8?B?Yzc4T3NPRmMyT3o3RmZxL016KzVwME1zeVNidWRKdjNsdEo4d1lmWG1vR0NQ?=
 =?utf-8?B?SU9qbXN2dTROb2U1T1lWeGtkOXlLQm15RlZsMmZVbkdxbVQxOXdnVjZ2VG1U?=
 =?utf-8?B?YTMwWC9UYU9mL0RsRWc5VTlGS1AwaDhBY3p2OHFTa29ic3o0a3IwOW91am11?=
 =?utf-8?B?ZEJKQkhWelNyKzF1Mmc0Z2M5MjNhZFFHLzVjZXhPSzlyRVFXemJHWHd3bjdF?=
 =?utf-8?B?eXZKU253dTF6ZVorRFduQWFsNE4vQyttOGNNMUQzR0dzZ0pwNjVDUzNZNmxx?=
 =?utf-8?B?aUxrTGhvNWg0aXM3aUE1TVBQMXZvZnh6bmNONHVxUVRNeUcvc1Zva3hZcmFk?=
 =?utf-8?B?OFg3MmNGVHdZdW9BeFd3YjdVK3k0ZnhSSGpiVXFCZ01LcmhPU2ZsL1U5UmtF?=
 =?utf-8?B?OXNYTFFmTlJqdlNSNUhZekQ5eitWNWs4ZWdKWUo3ZTM1bWhuZ0VsNXBFZm9R?=
 =?utf-8?B?UnEreS8wYlZ3TzRrVjkrdDkva2NhSVd2UTFxWmhTRHBZc2ltYUdnc2tjUjRi?=
 =?utf-8?B?TzBJNERnZURWY1hHRjBKajFlRkRVZWRwRXRwd2lNSURSRjdNaEowd2l4TjAy?=
 =?utf-8?B?TXJERUxJV2lSV1BxZmRDNWFyWlZPSHpTdlBQdlMrcXkzRENtYkNVejJxV0Jw?=
 =?utf-8?B?SGoyMjkzUHpkSlBvR1VpUXc0OTVTQjl0am5LbGtFMGdzeXlCNnhKbGNxUm4r?=
 =?utf-8?B?RmRRQ3kwRUROTkloNDlTU2ZMWHliQkhUK1ZuUUd2eUpRRHcvOTJGN1NTd3RP?=
 =?utf-8?B?YkNuUFFSOENKNlhlWjRaQ3VrQWdPZUNYOWpxeTRMa0dsdG1BYXVCSlovUWFa?=
 =?utf-8?B?ZW0xazZldlJlK3JRTzdpZ2NxTUZoNEJhQllvUUMwWGdSdW9rNTZpY0VLSVZj?=
 =?utf-8?B?L0tVckM5cWJ6RTA4RGdwQ083QStvZkZucFR5MVZ3ZmRudWNoeHJhVitEZG5j?=
 =?utf-8?B?VkJ6UldCcnE3L0Q4emV1dUl2S3lWOXFRVVlTN0dXdVYyaEVVeUZnVS9sU0FE?=
 =?utf-8?B?ZEc5SzNHMndnMzg0d2pFQ3dCRlNoYk1oZHR1aUs4cGFLU1p4Tkl3RU8xTVJ5?=
 =?utf-8?B?Q0NRb0FvSTY0bWJzZ0JjT2g5eGpxMEdtNEdNVU1KTXdxREk5Q0RNRkNtZFVl?=
 =?utf-8?B?ZHpuWnhENTlNcFBwdkRBcTVKNkVnOGdiSTQyYXBvRHFDNTNzL3RnSUk3Z2NG?=
 =?utf-8?B?T2pHR1VoRmc2U3hTYUJpMjhvRHkvWTBqQ3lJK0RjV0Y2KzFnUkhHNHBuWFdz?=
 =?utf-8?Q?OzTc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98af173-2c6c-4cfd-8345-08de1594adb9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:09:04.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKco7/gPCzIyB08zEOM4+0u4uToRPfExoC6EAkMjTonqKrzFnFFAGVLnK6fNT9q6ZhhYOGuB27LuQG/v5IrKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919

Add mmc5633 sensor basic support.
- Support read 20 bits X/Y/Z magnetic.
- Support I3C HDR mode to send start measurememt command.
- Support I3C HDR mode to read all sensors data by one command.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Co-developed-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v7
- add missed *.h file
- remove reduntant empty line
- add comments about delay 1us after SET
- use USEC_PER_MSEC for timeout value

Change in v6:
- remove acpi part
- return 0 for success path at mmc5633_write_raw

Change in V4
- use { 1, 2000 }
- Add _US for timeout
- Use GEN_MASK for MMC5633_CTRL1_BW_MASK
- Use { } for terminator.
- remove !!
- fix mix tab and space
- add mmc5603 (merge https://lore.kernel.org/all/20251003000731.22927-1-fluturel.adrian@gmail.com/)
- add tempature measure support

Change in v3
- remove mmc5633_hw_set
- make -> Make
- change indention for mmc5633_samp_freq
- use u8 arrary to handle dword data
- get_unaligned_be16() to get raw data
- add helper function to check if i3c support hdr
- use read_avail() callback

change in v2
- new patch
---
 drivers/iio/magnetometer/Kconfig   |  12 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5633.c | 588 +++++++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,18 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5633
+	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
+	select REGMAP_I2C
+	select REGMAP_I3C
+	depends on I2C || I3C
+	help
+	  Say yes here to build support for the MEMSIC MMC5633 3-axis
+	  magnetic sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mmc5633
+
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dfe970fcacb8664b293af84893f7d3e3e8d7bf7e..5bd227f8c1204bdd8b8a43da180833eedca1457b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5633)	+= mmc5633.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
new file mode 100644
index 0000000000000000000000000000000000000000..3e29324f0720a2b8268ccd63409483a60e48802b
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5633 - MEMSIC 3-axis Magnetic Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ * Copyright (c) 2025, NXP
+ *
+ * IIO driver for MMC5633, base on mmc35240.c
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#define MMC5633_REG_XOUT_L	0x00
+#define MMC5633_REG_XOUT_H	0x01
+#define MMC5633_REG_YOUT_L	0x02
+#define MMC5633_REG_YOUT_H	0x03
+#define MMC5633_REG_ZOUT_L	0x04
+#define MMC5633_REG_ZOUT_H	0x05
+#define MMC5633_REG_XOUT_2	0x06
+#define MMC5633_REG_YOUT_2	0x07
+#define MMC5633_REG_ZOUT_2	0x08
+#define MMC5633_REG_TOUT	0x09
+
+#define MMC5633_REG_STATUS1	0x18
+#define MMC5633_REG_STATUS0	0x19
+#define MMC5633_REG_CTRL0	0x1b
+#define MMC5633_REG_CTRL1	0x1c
+#define MMC5633_REG_CTRL2	0x1d
+
+#define MMC5633_REG_ID		0x39
+
+#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
+#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)
+
+#define MMC5633_CTRL0_CMM_FREQ_EN	BIT(7)
+#define MMC5633_CTRL0_AUTO_ST_EN	BIT(6)
+#define MMC5633_CTRL0_AUTO_SR_EN	BIT(5)
+#define MMC5633_CTRL0_RESET		BIT(4)
+#define MMC5633_CTRL0_SET		BIT(3)
+#define MMC5633_CTRL0_MEAS_T		BIT(1)
+#define MMC5633_CTRL0_MEAS_M		BIT(0)
+
+#define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
+
+#define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+
+#define MMC5633_HDR_CTRL0_MEAS_M	0x01
+#define MMC5633_HDR_CTRL0_MEAS_T	0x03
+#define MMC5633_HDR_CTRL0_SET		0x05
+#define MMC5633_HDR_CTRL0_RESET		0x07
+
+enum mmc5633_axis {
+	MMC5633_AXIS_X,
+	MMC5633_AXIS_Y,
+	MMC5633_AXIS_Z,
+	MMC5633_TEMPERATURE,
+};
+
+struct mmc5633_data {
+	struct device *dev;
+	struct i3c_device *i3cdev;
+	struct mutex mutex; /* protect to finish one whole measurement */
+	struct regmap *regmap;
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5633_samp_freq[] = {
+	{ 1, 200000 },
+	{ 2, 0 },
+	{ 3, 500000 },
+	{ 6, 600000 },
+};
+
+#define MMC5633_CHANNEL(_axis) { \
+	.type = IIO_MAGN, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _axis, \
+	.address = MMC5633_AXIS_ ## _axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				    BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5633_channels[] = {
+	MMC5633_CHANNEL(X),
+	MMC5633_CHANNEL(Y),
+	MMC5633_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = MMC5633_TEMPERATURE,
+	},
+};
+
+static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
+				       int val, int val2)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)
+		if (mmc5633_samp_freq[i].val == val &&
+		    mmc5633_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5633_init(struct mmc5633_data *data)
+{
+	unsigned int reg_id;
+	int ret;
+
+	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "Error reading product id\n");
+
+	/*
+	 * Make sure we restore sensor characteristics, by doing
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET.
+	 */
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Minimum time interval between SET or RESET to other operations is
+	 * 1ms according to Operating Timing Diagram in datasheet.
+	 */
+	fsleep(MMC5633_WAIT_SET_RESET_US);
+
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* set default sampling frequency */
+	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+				  MMC5633_CTRL1_BW_MASK,
+				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
+}
+
+static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
+{
+	unsigned int reg_status;
+	int ret;
+	int val;
+
+	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
+	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
+	if (ret < 0)
+		return ret;
+
+	val = (address == MMC5633_TEMPERATURE) ?
+	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
+				       reg_status & val,
+				       10 * USEC_PER_MSEC,
+				       100 * 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(data->dev, "data not ready\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
+{
+	if (!data->i3cdev)
+		return false;
+
+	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+}
+
+static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
+{
+	u8 data_cmd[2], status[2];
+	int ret, val, ready;
+
+	if (mmc5633_is_support_hdr(data)) {
+		struct i3c_xfer xfers_wr_cmd[] = {
+			{
+				.cmd = 0x3b,
+				.len = 2,
+				.data.out = data_cmd,
+			}
+		};
+		struct i3c_xfer xfers_rd_sta_cmd[] = {
+			{
+				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
+				.len = 2,
+				.data.in = status,
+			},
+		};
+		struct i3c_xfer xfers_rd_data_cmd[] = {
+			{
+				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
+				.len = sz,
+				.data.in = buf,
+			},
+		};
+
+		data_cmd[0] = 0;
+		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
+			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
+
+		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
+		if (ret < 0)
+			return ret;
+
+		ready = (address == MMC5633_TEMPERATURE) ?
+			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+		ret = read_poll_timeout(i3c_device_do_xfers, val,
+					val ||
+					status[0] & ready,
+					10 * USEC_PER_MSEC,
+					100 * 10 * USEC_PER_MSEC, 0,
+					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
+		if (ret) {
+			dev_err(data->dev, "data not ready\n");
+			return ret;
+		}
+		if (val) {
+			dev_err(data->dev, "i3c transfer error\n");
+			return val;
+		}
+		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
+	}
+
+	/* Fallback to use SDR/I2C mode */
+	ret = mmc5633_take_measurement(data, address);
+	if (ret < 0)
+		return ret;
+
+	if (address == MMC5633_TEMPERATURE)
+		/*
+		 * Put tempeature to last byte of buff to align HDR case.
+		 * I3C will early terminate data read if previous data is not
+		 * available.
+		 */
+		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);
+
+	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
+}
+
+/* X,Y,Z 3 channels, each channel has 3 byte and TEMP */
+#define MMC5633_ALL_SIZE (3 * 3 + 1)
+
+static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
+{
+	if (index == MMC5633_TEMPERATURE) {
+		*val = buf[MMC5633_ALL_SIZE - 1];
+		return 0;
+	}
+	/*
+	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
+	 */
+	*val = get_unaligned_be16(buf + 2 * index) << 4;
+	*val |= buf[index + 6] >> 4;
+
+	return 0;
+}
+
+static int mmc5633_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	char buf[MMC5633_ALL_SIZE];
+	unsigned int reg, i;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &data->mutex) {
+			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = mmc5633_get_raw(data, chan->address, buf, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_MAGN) {
+			*val = 0;
+			*val2 = 62500;
+		} else {
+			*val = 0;
+			*val2 = 800000000; /* 0.8C */
+		}
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = -75;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
+			if (ret < 0)
+				return ret;
+		}
+
+		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
+		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5633_samp_freq[i].val;
+		*val2 = mmc5633_samp_freq[i].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5633_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+
+		scoped_guard(mutex, &data->mutex) {
+			ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
+						 MMC5633_CTRL1_BW_MASK,
+						 FIELD_PREP(MMC5633_CTRL1_BW_MASK, i));
+			if (ret)
+				return ret;
+		};
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5633_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)mmc5633_samp_freq;
+		*length = ARRAY_SIZE(mmc5633_samp_freq) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5633_info = {
+	.read_raw	= mmc5633_read_raw,
+	.write_raw	= mmc5633_write_raw,
+	.read_avail	= mmc5633_read_avail,
+};
+
+static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_XOUT_L:
+	case MMC5633_REG_XOUT_H:
+	case MMC5633_REG_YOUT_L:
+	case MMC5633_REG_YOUT_H:
+	case MMC5633_REG_ZOUT_L:
+	case MMC5633_REG_ZOUT_H:
+	case MMC5633_REG_XOUT_2:
+	case MMC5633_REG_YOUT_2:
+	case MMC5633_REG_ZOUT_2:
+	case MMC5633_REG_TOUT:
+	case MMC5633_REG_STATUS1:
+	case MMC5633_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5633_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5633_REG_CTRL0:
+	case MMC5633_REG_CTRL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5633_reg_defaults[] = {
+	{ MMC5633_REG_CTRL0,  0x00 },
+	{ MMC5633_REG_CTRL1,  0x00 },
+};
+
+static const struct regmap_config mmc5633_regmap_config = {
+	.name = "mmc5633_regmap",
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5633_REG_ID,
+	.cache_type = REGCACHE_MAPLE,
+
+	.writeable_reg = mmc5633_is_writeable_reg,
+	.readable_reg = mmc5633_is_readable_reg,
+	.volatile_reg = mmc5633_is_volatile_reg,
+
+	.reg_defaults = mmc5633_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5633_reg_defaults),
+};
+
+static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
+				char *name, struct i3c_device *i3cdev)
+{
+	struct mmc5633_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = regmap;
+	data->i3cdev = i3cdev;
+	data->dev = dev;
+
+	ret = devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &mmc5633_info;
+	indio_dev->name = name;
+	indio_dev->channels = mmc5633_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5633_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mmc5633_suspend(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+
+	regcache_cache_only(data->regmap, true);
+
+	return 0;
+}
+
+static int mmc5633_resume(struct device *dev)
+{
+	struct mmc5633_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	regcache_mark_dirty(data->regmap);
+	ret = regcache_sync_region(data->regmap, MMC5633_REG_CTRL0,
+				   MMC5633_REG_CTRL1);
+	if (ret < 0)
+		dev_err(dev, "Failed to restore control registers\n");
+
+	regcache_cache_only(data->regmap, false);
+
+	return 0;
+}
+
+static int mmc5633_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return mmc5633_common_probe(dev, regmap, client->name, NULL);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend, mmc5633_resume);
+
+static const struct of_device_id mmc5633_of_match[] = {
+	{ .compatible = "memsic,mmc5603" },
+	{ .compatible = "memsic,mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5633_of_match);
+
+static const struct i2c_device_id mmc5633_i2c_id[] = {
+	{ "mmc5603" },
+	{ "mmc5633" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
+
+static struct i2c_driver mmc5633_i2c_driver = {
+	.driver = {
+		.name = "mmc5633_i2c",
+		.of_match_table = mmc5633_of_match,
+		.pm = pm_sleep_ptr(&mmc5633_pm_ops),
+	},
+	.probe = mmc5633_i2c_probe,
+	.id_table =  mmc5633_i2c_id,
+};
+
+static const struct i3c_device_id mmc5633_i3c_ids[] = {
+	I3C_DEVICE(0x0251, 0x0000, NULL),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, mmc5633_i3c_ids);
+
+static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
+}
+
+static struct i3c_driver mmc5633_i3c_driver = {
+	.driver = {
+		.name = "mmc5633_i3c",
+	},
+	.probe = mmc5633_i3c_probe,
+	.id_table = mmc5633_i3c_ids,
+};
+module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)
+
+MODULE_AUTHOR("Frank Li <Frank.li@nxp.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5633 magnetic sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


