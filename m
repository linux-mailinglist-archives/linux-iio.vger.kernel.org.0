Return-Path: <linux-iio+bounces-22383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1AFB1D4AA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0FE1718A8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93D8221D96;
	Thu,  7 Aug 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RG2JmMh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406521B424D;
	Thu,  7 Aug 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558778; cv=fail; b=o/BNgrG5sAc3RFrpRETUj3FzNaZMjovfTMcj9kv2194mpf2vmEn2MMh6yj6AgcOImrLqZOJUqfpVm7jLu2YU06i1ecaleluKvB572flyBJXihOKrUpHYFaVP+aucgVzLMqUnP8PrRQ2nyig/tiVm0kPS0F5Q8u2WvstfX/sR0fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558778; c=relaxed/simple;
	bh=X4rRkQmHQO7oOwdHGz1NBg/DDo2ztffwo8FPFjabvIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNdspFsLtAOsT8mMVvS1o+QBmn3QkfXbMN1hIb2XRoVX/EPq0nnk13gkdGhpxVh7+lMYPmWgeNHpqDzWjXdBOkLVAwKnh5r9h6b+cLw0oHjXKVb/06k6V25EGB1gVDK+dknTturJuhWiBTuRft6gd+FuVHoQtZMQ/VjTB3TEQM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RG2JmMh3; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFAqyIcmLQIG82sARkWiqQ32h57hKNCrxmik7Skthghaf3oajfqR3dVpT8c+9AEEl5huxBmgVehX9VhAOWBOv5A5EQ08SXSS40OYbGWErbwB7+18B+vL4UnkuYmyFd9dTpyPgEB67zS+fV3etQ9FNZq5uMCc79iaj3f+XiK98gdmmY+cAk2FfaS9KRshlRjkYG5aWWag6OUSzJ+t3cGcswoZ4JTUvsrZ8iRrDbAphz3kignrwZgQ5p32Pof7CGpOUq8pzf7R5Q4hyupCfmu+swi0guh2wL20xS/eXhaJHMn2nDUE4NjP8lkmUP2MbiW8dxzZq7r7Lg3OZP0OeGMZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4rRkQmHQO7oOwdHGz1NBg/DDo2ztffwo8FPFjabvIY=;
 b=clS8/VId2xSb+cUm/QbfHBMuU+jPMMvaTKzt15jMIOk6qBrrAQggOIWa8EkUl0C9oN2c1U/0zq4um630p2oFEAzYuKRph3eB8/cUYa3vKtSxw6jUXKz578AXwB8hYqlMEK2k22CQpyHmhZMTs/uQbS5N15fEa+gv8ppHZV9nTJVDwavEPH3YOchFBRGvVAYNmoSYGjm+xicH+xLQozPMwfP4ABYvPtUUA4CLMrYEL4XqjASK9fXDDy79F4YNoKzYLdh0ucssSsU9gxRcuQUYzWse5CQsm5+2SdOjyewy6ReJa0Ta67lptt6AGLge7eXSkEm2XfmLoi/3g9lwVgCr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4rRkQmHQO7oOwdHGz1NBg/DDo2ztffwo8FPFjabvIY=;
 b=RG2JmMh3PCICGsJhS58MmlwfyCtJ4+Ge8BJvsXRSjgfVQYbACXt5rB/+uLAMmwg4JZtPkyTrgengFYunWLURmSCcDJKEpfpQFrarLhn2fx5RGXo/qdKyDi+w2pSK6T+cQJQ9M6GysOKZbHoXzDXJR066mZGJmjlU00NnyAxbp9/bB5ZorzrrFEdW8J+Zed4ZRVsToHo5Z9KC3I7jy5Yig4A2w8gW1IOry9h+VMo0jXx1uF26GtCSZvVR/oel3wUx6xwPdPq1rXoYpyj0PukGmDbU9dLKg/IXuNksd8hz4l3ClSmcD1i9aKT26slLkI1lWCxLZT/q/Oy6D7Ul5vY43A==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 09:26:12 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:26:11 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Nuno S? <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "andrej.picej@norik.com" <andrej.picej@norik.com>
Subject: RE: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Thread-Topic: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Thread-Index:
 AQHb8W26y5fO8SJjh0GULyxs8/1/5bQrgNAAgASqt4CAAPmcAIAAq+2AgAqSl4D///Sf0IAabtKAgABOKCA=
Date: Thu, 7 Aug 2025 09:26:11 +0000
Message-ID:
 <DU0PR04MB9496AED41C069FB2456954A6902CA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
 <20250713160247.0f22bbfe@jic23-huawei>
 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
 <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
 <20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
 <DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <19634e51-0568-421a-a3c4-b9988c2ccfb1@norik.com>
In-Reply-To: <19634e51-0568-421a-a3c4-b9988c2ccfb1@norik.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: a06e3ec9-c346-48b3-df68-08ddd5947311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?N2xCWURVaHZ6RlBybUI1cmRndmx3UHRVL2tmWWhXc280UXNsZWF2VlJGQWQ4?=
 =?gb2312?B?ejlBZWhmQVQ5VWhXQnV4SkFxMzJORXFITXpOemlIaVBRSUM0VjA3Z2lIaUZs?=
 =?gb2312?B?UVJQM0F0QXdadkVGSkdZcDdmWk1lRkYrblJSclRjaEFvQ3hNajhZNHFiY2o1?=
 =?gb2312?B?R2ZFYTZFU1BzYW9DbEJBNFMwdHdXT21EdWNpRkhpRDUxNmVEK01UR1R5K2Vz?=
 =?gb2312?B?amtqWmlETXNENk5DQXB5bXZvYm8wY0JlejFJeWI2ZGhsT24yQ0xvYm9Pc1do?=
 =?gb2312?B?a2VQOThzWThyYktpNURvWUF1N1dFUWFNZkhERTlUMjRVZWZwczAwcHhMTmNQ?=
 =?gb2312?B?bHNaV1lZLzNFSXFoQU84UVRmYm1wZFVLc3VDaWEvczUrQTl2dnM5S3NFakM2?=
 =?gb2312?B?M2dvS3FZam80OFl2WTlWcEtHNE51ZVdPTDNybUdET0RuL0t1cnpDSmQ3cU5G?=
 =?gb2312?B?TWRRdDFtdzgxYS9LVm5wNmlTL3RTb2pEMGp3cys4cGp0L3lNRVRlNWZXWGg3?=
 =?gb2312?B?Rm5BV2QwYmFoRjZxZStaNnBiVGJLb21TZjFjOXZ3UkE5M0FQY0RiZ1NIZmcy?=
 =?gb2312?B?eW51T1J2OWVxejdtQm5GQkFNZDU0TXkyL3IrTFFVUzRHOUJlU2kxK3hBTFRz?=
 =?gb2312?B?dWRKNTdUdGo3UXVQVTZ5Y1BjZG1BMkp6T2taVmpVN1VFV1dIMGsrRkhXVTg3?=
 =?gb2312?B?VUF6b0xzWnVlQXpDRjcyRy9sbVJHazhOU0NPSUY5SFNJUThhUEJzS1BkMDZw?=
 =?gb2312?B?dVRtOHg5TVBCdFFicGthcWtIWG1PVmJUbXRkeEFvOVVLMEdlcU5JVW9KRjBy?=
 =?gb2312?B?bmVNQkhsK3p2b1BBNnZ6VTV0Vy9xV2dwWlo4M1JMRTJ2bFdJSFkwSE1CNEhz?=
 =?gb2312?B?SGlSYU56KzBPSWJmZjJ1VEpqWHhoQnZwcXRPa2RSam5FQzd3aURZc2Y0WU1F?=
 =?gb2312?B?enI1UWNFMHQ2RXl1UnFSMlNWaVJHMjJhakN4Q3lzeHh2bzUzSDRZVjIxRTBN?=
 =?gb2312?B?M2F0dmJZWFlVR0E1OGtXc3ZYM0w5cmpzUFp1V21Gd1AvWFprVmZPMjI4Q0kx?=
 =?gb2312?B?aFBtUFRtK3p6TGtucjRPM0UyUlBYMUFiMmFHM1hTQmVkM1lrZHVXbDhrNjhM?=
 =?gb2312?B?azhTTjRzUzRlUkt1RS9FcEFTQ3YrdGdOcGZyQUM4b0hkUERZOGYvY1AvSThF?=
 =?gb2312?B?M2N4QjR5Zzg2OEh1VHZJQzVVL2lCaHpVamtSazFnNk1nWkl2Mk5DSWdIM3JO?=
 =?gb2312?B?VHJVQmFrY3dOOWFLcmhBbkJsMERWM0gwRnRpMWhSUTc1SzdJLzFLUUpwclEw?=
 =?gb2312?B?dUtidVl2YXE2OTE2d3BWMEtCczFmYncvMjBuNExQTkdlL24ySUtwRFhVNlpo?=
 =?gb2312?B?WFJXZmVKY05HMktBV0FtWVVraVBoVVRUQ0EzQ3E4cm1YdGtNdWc3cHNLS0Vp?=
 =?gb2312?B?S3BMa3ZSckdidGJsRTQ2VHEzWm01ME80M3ZIZ0VEYzkyUmFZbWtsYVlJclRz?=
 =?gb2312?B?OVFUZjErWkIzaXdMMW44TE5QVUkrVzVnbElqZDJPZVB6bHZIcEN3ZWFPSW1V?=
 =?gb2312?B?T3pQZEZFTXNxZCsvRFIrZ3VMNjEwU05mMXVma2FIeDZqYkRxR29LRS8vTTM0?=
 =?gb2312?B?RDYyUWRtcFMvT0ZDUFF4K3JtS2oyKzkzMWc2QUt6eWViazR5ZmRiN2ViTm1T?=
 =?gb2312?B?dWZsTHowc3NQeHNYeEk4TnBUMVJMZHVLSElPR2l4RlM1YUp0ZkZNM25BWlVm?=
 =?gb2312?B?dmJrdi9FeUxCMWMvWDNZbDYxeXloeUlONUFPRWxCMng5TVhBelFIRGFJVll6?=
 =?gb2312?B?ZFJpZDlMeVE5T2NRbmRSc1hhenJVYVVZVFF6ZlRxWm1lZjNzMENEWlVTTngx?=
 =?gb2312?B?dG1QRlJaRUJIZlJGdUNPWEdCNEVkTkNoUktRbEFuajBhaDREM2Yrbk5xSk9J?=
 =?gb2312?B?bUd3RXNKaXczUGRCaE90em1pbUJac2NTMzZRWkQ0YTNsUDNYWEpNZXZPemg1?=
 =?gb2312?Q?AzfUVfjnAZXtoMj/rQFd3W0deFgVio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RGhWVkNYWHlWYmE4ZUJSNzVBSjRzT3lESHIzbU94ckwyYkd1VjZyVVV6TENy?=
 =?gb2312?B?UVo4ZjNhMk9kdkNsOGE3anhJSkR2anN5UkVHSWdDNWFkMDJCeENwUGhHTWJa?=
 =?gb2312?B?TnFwSDBBSE9NWXUwSkkwSmxlU09OWlIzSmh0dGNEMGUrUzJxQ1V5V2tiY0ZL?=
 =?gb2312?B?em1NeUpEL0hPbklCQUhnNXIwQVBvQ1I1bzdpWWhCUnNHWWlBUlFMZDM0WWZE?=
 =?gb2312?B?ZFFRVDQ1M3V5UGZuUUFLTGVKZU1TdDlrOXNpNU9BLytDYmtTK2RDcENxNllZ?=
 =?gb2312?B?cU52TC94OWswMldUTFhCenhiRDExNjhVY2NsNUNYeTN4N3VWWUxiYWRETHBw?=
 =?gb2312?B?Y3o2WWxCYURaU0o5VkhzMlBjejF3dXhCbUh0azkzWnZLUGR2bUVSMWdGQlJC?=
 =?gb2312?B?cEhQbmt0NHFVRSt3cWpLZTViOXBQaTcvT04wcmxEQ3BETTVFbGt6RC82d2tr?=
 =?gb2312?B?RG1sUGlFKzB2NHJFY0xNOW4zMXFGbG10ZWpjUi9LU2lWSVB5OWgzV25IMDJi?=
 =?gb2312?B?SkpDYnIvaG9rT29DVy9aV3R5dFBJcVNsbGwxbnVaZlBJTDN1UW45cnNKT3dX?=
 =?gb2312?B?K0dDZHQ1ZVRSSm42c01RNTMyLzEwYis5Yllia2g4VjM3d2xES0RPUVpldDVQ?=
 =?gb2312?B?aSt5MlZRTjJJVGtqQVpxaVlYdVFjM3ZhT3hONGVoeEtHMWZGVUwrZ1hqc2g5?=
 =?gb2312?B?MFI4YjFtcE9wbG5VNkU5SkpEclJrZUx6RHBLL1NZMURsWUVBRmhlK3NreW9N?=
 =?gb2312?B?dDlZd1VlZzYvQWtoRC83R2ZSUEk3WnZQZUVnVXJET1V4djBvZ3E3MFdoY0dn?=
 =?gb2312?B?RS9XOVo2dmFBSngyN1NaaXk2bmR0UzFSQU1Ibnczak5LcHZabXozK09Ubyt2?=
 =?gb2312?B?dklobkhVUEM0dm5iWExJYnphQWJBNHY0ZUJOOWpNbUZwSTFMVG5ybGNFS0sx?=
 =?gb2312?B?N0dUOGV0dlY3a3VsNklJSS85WUlaaGk1cnZzbFh5V1JuWnJvQys3YTVhSFhK?=
 =?gb2312?B?MndzN3JzREd6REhSdW9adWJXQkltM2RSbDV5L3pvQ2lsM2FrMDJlbFY4eHZL?=
 =?gb2312?B?VWg3a29ZalJJTEU5M3RESENSWXlEZ29pQXF0TDJuQU1JNkhHclB0aVNtVjBu?=
 =?gb2312?B?dFc2bUtrM0JTZzlVdzVIdmpVblJYaUZSRi9wdDVuZzh2NEZjMzF1Nk1DMXQ2?=
 =?gb2312?B?bzBlaTJwUU54RTBZNzM3bWZDNUpSWjF1d01XNHZJKzVKN0MrVEVOVkZPeVdu?=
 =?gb2312?B?NUZTZUVZbFRFM0VBUGZ0c1RrNG40cmZlM2s0emYvTlNqVnRCYUhRVUMzOXFB?=
 =?gb2312?B?R3JrTUxVTm0zV1plTmt6VCtzUmVNRi9kR2VFdU9LL2pqMThNdVJGZFJGdW1u?=
 =?gb2312?B?aXU0eGhlcUxHUHJaOXRRcWIyZjdBRVQxWEtaT1B5eHB6ZEdWNTZzem5Dd1Uz?=
 =?gb2312?B?VkU4R3UxTzA5bDJycEh0OWN5dzl4SFNIK0VBKzN2Z1g2KzNBd1QrdkZMNkhB?=
 =?gb2312?B?UUxKb3Rrc0xnbUUyb2tRRWNLajZJVzBRdERwQ1E5OVlocFRDTW03R0svU095?=
 =?gb2312?B?UWdKUnlBVHl3cnpwTlFRd2hKRnQ3RW9ISUE5VytnS3ZUcjBWMGczNi9zMlg5?=
 =?gb2312?B?eDhJTC9UeVFDSzBnZ05sRStHU2M5T3pXd2swREFBeHRWVEVDcGRUbnVKZFpZ?=
 =?gb2312?B?aFdLV3ZTaGhqQ2ZDNUZXS09DVXN5NlM0ZVdmVXJXVEpJdzVmTjlyTVJ2bGxk?=
 =?gb2312?B?S2dJdlZncEROYXFQbElyTXRQZ01VVldSbkdiMzZHb0lwMG1kSTUwRVlJK0F5?=
 =?gb2312?B?SjhPTlcxQ2hudVQveGNmendSdSs2T2djcXpOQVA2YWh4Sjh3UGpkY05ONzgr?=
 =?gb2312?B?MUtxTjB3ZzFUd3ppcTVZdCtIUzJxZjQzdjk4L0ViVVhSMmxuN3h5dDVRVTZI?=
 =?gb2312?B?ay9BRDU5RlZ0U29VeVQ0aE1pdlR3bjVoTzZidDRDdm1wRVNxTHdvTE42RzJS?=
 =?gb2312?B?WkcxRTA1bXVvS3RMRllrRkpjc2V3djlWQjNXVmZDNXNLblAvYVpGanpWbEgx?=
 =?gb2312?B?S0VoalEwTk9jVXZVclZmenJFd1lnOWk2ZDJBbGhKOVh0VGdTT2V5NXNtV2Vu?=
 =?gb2312?Q?djbxFa/fhhV0L6bB1i5bGeKic?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06e3ec9-c346-48b3-df68-08ddd5947311
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 09:26:11.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNrm1PQ5avoUMLvYBNRxsUTv4lWd/1E9bfqztqmcWJ1FinUJckKssPn7jcDomv5cuVBLlVzyqzSGzwtJMZacqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQcmltb3ogRmlzZXIgPHByaW1v
ei5maXNlckBub3Jpay5jb20+DQo+IFNlbnQ6IDIwMjXE6jjUwjfI1SAxMjozNw0KPiBUbzogQm91
Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFu
QG9zcy5ueHAuY29tPjsgTnVubyBTPyA8bm9uYW1lLm51bm9AZ21haWwuY29tPg0KPiBDYzogSm9u
YXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IERhdmlkIExlY2huZXINCj4gPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT47IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hl
dmNoZW5rbw0KPiA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJv
bml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+
IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBpbXhAbGlz
dHMubGludXguZGV2Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyB1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGU7DQo+IGFuZHJlai5waWNlakBub3Jpay5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogaW14OTM6IEFk
ZCBjYWxpYnJhdGlvbiBwcm9wZXJ0aWVzDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDIxLiAwNy4gMjUg
MTE6MDksIEJvdWdoIENoZW4gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gPj4g
U2VudDogMjAyNcTqN9TCMjHI1SAxNzozOQ0KPiA+PiBUbzogTnVubyBTPyA8bm9uYW1lLm51bm9A
Z21haWwuY29tPg0KPiA+PiBDYzogUHJpbW96IEZpc2VyIDxwcmltb3ouZmlzZXJAbm9yaWsuY29t
PjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA+PiA8amljMjNAa2VybmVsLm9yZz47IERhdmlkIExlY2hu
ZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IEJvdWdoIENoZW4NCj4gPj4gPGhhaWJvLmNoZW5A
bnhwLmNvbT47IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkNCj4gU2hldmNoZW5r
bw0KPiA+PiA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kNCj4gPj4gPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFNoYXduIEd1bw0KPiA+PiA8c2hhd25ndW9Aa2Vy
bmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+ID4+IFBl
bmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3Rl
dmFtDQo+ID4+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyB1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGU7DQo+ID4+IGFuZHJlai5w
aWNlakBub3Jpay5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdz
OiBpaW86IGFkYzogaW14OTM6IEFkZA0KPiA+PiBjYWxpYnJhdGlvbiBwcm9wZXJ0aWVzDQo+ID4+
DQo+ID4+IE9uIE1vbiwgSnVsIDE0LCAyMDI1IGF0IDA1OjExOjMxUE0gKzAxMDAsIE51bm8gUz8g
d3JvdGU6DQo+ID4+PiBPbiBNb24sIDIwMjUtMDctMTQgYXQgMDc6NTYgKzAyMDAsIFByaW1veiBG
aXNlciB3cm90ZToNCj4gPj4+PiBIaSBhbGwsDQo+ID4+Pj4NCj4gPj4+PiBPbiAxMy4gMDcuIDI1
IDE3OjAyLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+Pj4+PiBPbiBUaHUsIDEwIEp1bCAy
MDI1IDEwOjQ2OjQ0IC0wNTAwIERhdmlkIExlY2huZXINCj4gPj4+Pj4gPGRsZWNobmVyQGJheWxp
YnJlLmNvbT4gd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+PiBPbiA3LzEwLzI1IDI6MzkgQU0sIFBy
aW1veiBGaXNlciB3cm90ZToNCj4gPj4+Pj4+PiBGcm9tOiBBbmRyZWogUGljZWogPGFuZHJlai5w
aWNlakBub3Jpay5jb20+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBEb2N1bWVudCBpLk1YOTMgQURD
IGNhbGlicmF0aW9uIHByb3BlcnRpZXMgYW5kIGhvdyB0byBzZXQgdGhlbS4NCj4gPj4+Pj4+Pg0K
PiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2VqQG5vcmlr
LmNvbT4NCj4gPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQcmltb3ogRmlzZXIgPHByaW1vei5maXNl
ckBub3Jpay5jb20+DQo+ID4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4gPz8uLi4vYmluZGluZ3MvaWlv
L2FkYy9ueHAsaW14OTMtYWRjLnlhbWw/Pz8/Pz8/Pz8/Pz8gfCAyMQ0KPiA+Pj4+Pj4+ICsrKysr
KysrKysrKysrKysrKysNCj4gPj4+Pj4+PiA/PzEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBkaWZmIC0tZ2l0DQo+ID4+Pj4+Pj4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14OTMtDQo+ID4+Pj4+Pj4g
YWRjLnlhbWwNCj4gPj4+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vYWRjL254cCxpbXg5My1hZGMueWFtbA0KPiA+Pj4+Pj4+IGluZGV4IGMyZTVmZjQxODkyMC4u
ZDFjMDRjZjg1ZmU2IDEwMDY0NA0KPiA+Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55YW1sDQo+ID4+
Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhw
LGlteDkzLWFkYy55DQo+ID4+Pj4+Pj4gKysrIGFtbA0KPiA+Pj4+Pj4+IEBAIC01Miw2ICs1Miwy
NyBAQCBwcm9wZXJ0aWVzOg0KPiA+Pj4+Pj4+ID8/Pz8gIiNpby1jaGFubmVsLWNlbGxzIjoNCj4g
Pj4+Pj4+PiA/Pz8/Pz8/PyBjb25zdDogMQ0KPiA+Pj4+Pj4+ID8/DQo+ID4+Pj4+Pj4gKz8/IG54
cCxjYWxpYi1hdmctZW46DQo+ID4+Pj4+Pj4gKz8/Pz8/PyBkZWZhdWx0OiAxDQo+ID4+Pj4+Pj4g
Kz8/Pz8/PyBkZXNjcmlwdGlvbjoNCj4gPj4+Pj4+PiArPz8/Pz8/Pz8/PyBFbmFibGUgb3IgZGlz
YWJsZSBjYWxpYnJhdGlvbiBhdmVyYWdpbmcgZnVuY3Rpb24gKEFWR0VOKS4NCj4gPj4+Pj4+PiAr
Pz8/Pz8/ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+
Pj4+Pj4+ICs/Pz8/Pz8gZW51bTogWyAwLCAxIF0NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gKz8/
IG54cCxjYWxpYi1uci1zYW1wbGVzOg0KPiA+Pj4+Pj4+ICs/Pz8/Pz8gZGVmYXVsdDogNTEyDQo+
ID4+Pj4+Pj4gKz8/Pz8/PyBkZXNjcmlwdGlvbjoNCj4gPj4+Pj4+PiArPz8/Pz8/Pz8/PyBTZWxl
Y3RzIG51bWJlciBvZiBzYW1wbGVzIChOUlNNUEwpIHRvIGJlIHVzZWQgZHVyaW5nDQo+ID4+IGNh
bGlicmF0aW9uLg0KPiA+Pj4+Pj4+ICs/Pz8/Pz8gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+Pj4+Pj4gKz8/Pz8/PyBlbnVtOiBbIDE2LCAzMiwgMTI4
LCA1MTIgXQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBBbGxvdyAxIGFzIGEgdmFsdWUgYW5kIGRyb3AgdGhl
IGVuYWJsZWQgYWJvdmUuPz8/PyBBdmVyYWdpbmcgb3Zlcg0KPiA+Pj4+PiAxIHNhbXBsZSBpcyBz
YW1lIGFzIG5vIGF2ZXJhZ2luZyBhbmQgZ2l2ZXMgc2ltcGxlciBiaW5kaW5nLg0KPiA+Pj4+Pg0K
PiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+PiArPz8gbnhwLGNhbGliLXQtc2FtcGxlOg0KPiA+Pj4+Pj4+
ICs/Pz8/Pz8gZGVmYXVsdDogMjINCj4gPj4+Pj4+PiArPz8/Pz8/IGRlc2NyaXB0aW9uOg0KPiA+
Pj4+Pj4+ICs/Pz8/Pz8/Pz8/IFNlbGVjdHMgc2FtcGxlIHRpbWUgKFRTQU1QKSBvZiBjYWxpYnJh
dGlvbg0KPiA+Pj4+Pj4+ICtjb252ZXJzaW9ucyBpbiBBREMNCj4gPj4+Pj4+PiBjbG9jayBjeWNs
ZXMNCj4gPj4+Pj4+PiArPz8/Pz8/ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiA+Pj4+Pj4+ICs/Pz8/Pz8gZW51bTogWyA4LCAxNiwgMjIsIDMyIF0NCj4g
Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4gPz9yZXF1aXJlZDoNCj4gPj4+Pj4+PiA/Pz8/IC0gY29tcGF0
aWJsZQ0KPiA+Pj4+Pj4+ID8/Pz8gLSByZWc/Pw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoaXMgc2Vl
bSBsaWtlIHRoaW5ncyB0aGF0IHNob3VsZCBiZSBzZXQgYXQgcnVudGltZSByYXRoZXIgdGhhbg0K
PiA+Pj4+Pj4gaW4gdGhlIGRldmljZXRyZWUuIFVubGVzcyB0aGVyZSBpcyBzb21lIGp1c3RpZmlj
YXRpb24gb24gd2h5DQo+ID4+Pj4+PiB0aGVzZSB2YWx1ZXMgZGVwZW5kIG9uIGhvdyB0aGUgY2hp
cCBpcyB3aXJlZCB1cD8NCj4gPj4+Pg0KPiA+Pj4+IEl0IGRlcGVuZHMgaG93IEFEQyAxLjhWIFZy
ZWYgaXMgd2lyZWQgdXAsIGVzcGVjaWFsbHkgaG93IG5vaXN5IGl0IGlzLg0KPiA+Pj4+DQo+ID4+
Pj4+DQo+ID4+Pj4+IEZ1cnRoZXIgdG8gdGhhdCwgSSdkIGxpa2UgdG8gc2VlIHNvbWUgZXhwbGFu
YXRpb24gb2Ygd2h5IHdlIGNhcmUNCj4gPj4+Pj4gdG8gY2hhbmdlIGl0IGF0IGFsbC4gSXMgaXQg
ZXZlciBhIGJhZCBpZGVhIHRvIGVuYWJsZSBhdmVyYWdpbmcgYW5kDQo+ID4+Pj4+IHBpY2sgYSBs
YXJnZSBudW1iZXIgb2Ygc2FtcGxlcyBmb3IgY2FsaWJyYXRpb24/DQo+ID4+Pj4NCj4gPj4+PiBU
aGlzIGlzIGEgc25pcHBldCBmcm9tIHRoZSBpLk1YOTMgVFJNLCBjaGFwdGVyIEFuYWxvZy10by1E
aWdpdGFsDQo+ID4+Pj4gQ29udmVydGVyIChTQVJfQURDKSBkZXNjcmliaW5nIGNhbGlicmF0aW9u
IHN0ZXBzOg0KPiA+Pj4+DQo+ID4+Pj4gMS4gV2FpdCBmb3IgZGVhc3NlcnRpb24gb2YgZnVuY3Rp
b25hbCByZXNldC4NCj4gPj4+PiAyLiBDb25maWd1cmUgU0FSIGNvbnRyb2xsZXIgb3BlcmF0aW5n
IGNsb2NrIChNQ1JbQURDTEtTRV0gPSAwKS4NCj4gPj4+PiAzLiBCcmluZyBBREMgb3V0IG9mIFBv
d2VyLWRvd24gc3RhdGUgKE1DUltQV0ROXSA9IDApLg0KPiA+Pj4+IDQuIENvbmZpZ3VyZSBkZXNp
cmVkIGNhbGlicmF0aW9uIHNldHRpbmdzIChkZWZhdWx0IHZhbHVlcyBrZXB0IGZvcg0KPiA+Pj4+
IGhpZ2hlc3QgYWNjdXJhY3kgbWF4aW11bSB0aW1lKS4NCj4gPj4+PiA/Pz8gTUNSW1RTQU1QXTog
U2FtcGxlIHRpbWUgZm9yIGNhbGlicmF0aW9uIGNvbnZlcnNpb24gPz8/DQo+ID4+Pj4gTUNSW05S
U01QTF06IE51bWJlciBvZiBzYW1wbGVzIGluIGF2ZXJhZ2luZyA/Pz8gTUNSW0FWR0VOXToNCj4g
Pj4+PiBBdmVyYWdpbmcgZnVuY3Rpb24gZW5hYmxlIGluIGNhbGlicmF0aW9uIDUuIFJ1biBjYWxp
YnJhdGlvbiBieQ0KPiA+Pj4+IHdyaXRpbmcgYSBvbmUgdG8gTUNSW0NBTFNUQVJUXS4NCj4gPj4+
PiA2LiBDaGVjayBjYWxpYnJhdGlvbiBydW4gc3RhdHVzIGluIE1TUltDQUxCVVNZXT8/P3dhaXQg
dW50aWwNCj4gPj4+PiBNU1JbQ0FMQlVTWV0gPSAwOyBhbHRlcm5hdGl2ZWx5LCBNU1JbQURDU1RB
VF0gY2FuIGJlIHVzZWQgdG8gY2hlY2sNCj4gPj4+PiBzdGF0dXMuDQo+ID4+Pj4gNy4gQ2hlY2sg
Y2FsaWJyYXRpb24gcGFzcy9mYWlsIHN0YXR1cyBpbiBNU1JbQ0FMRkFJTF0gZmllbGQuIElmDQo+
ID4+Pj4gTVNSW0NBTEZBSUxdID0gMSB0aGVuIGNhbGlicmF0aW9uIGZhaWxlZC4gRGV0YWlsZWQg
c3RhdHVzIGNhbiBiZQ0KPiA+Pj4+IGNoZWNrZWQgaW4gQ0FMU1RBVC4NCj4gPj4+Pg0KPiA+Pj4+
DQo+ID4+Pj4gU2VlIHBvaW50IDQpLg0KPiA+Pj4+DQo+ID4+Pj4gTm90IHN1cmUgd2h5IHdvdWxk
IHRoZXJlIGJlIGFuIG9wdGlvbiB0byBjb25maWd1cmUgaS5NWDkzIEFEQw0KPiA+Pj4+IGNhbGli
cmF0aW9uIHBhcmFtZXRlcnMgaWYgb25lIHVzZS1jYXNlIChtYXggYWNjdXJhY3kgbWF4IHRpbWUp
IHRvDQo+ID4+Pj4gcnVsZSB0aGVtIGFsbD8NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFNvbWV0aW1l
cyBIVyBndXlzIGp1c3Qgd2FudCB0byBnaXZlIHlvdSBzb21lIG9wdGlvbnMuIERvZXMgbm90IG1l
YW4NCj4gPj4+IHdlIGhhdmUgdG8gdXNlIHRoZW0gYWxsIDopLg0KPiA+Pj4NCj4gPj4+IEkgZ3Vl
c3Mgd2hhdCBKb25hdGhhbiBpcyBpbnRlcmVzdGVkIGluLCBpcyB0byB1bmRlcnN0YW5kIGluIHdo
YXQNCj4gPj4+IGNvbmRpdGlvbnMgdGhlIGRlZmF1bHRzIGFyZSBubyBnb29kIGZvciB0aGUgY2Fs
aWJyYXRpb24/IElmIHdlIGNhbg0KPiA+Pj4gaGF2ZSBhIHNldCBvZiB2YWx1ZXMgdGhhdCBzaG91
bGQgcHJldHR5IG11Y2ggYWx3YXlzIHdvcmssIG5vIG5lZWQgdG8NCj4gPj4+IGZ1cnRoZXIgY29t
cGxpY2F0ZSB0aGUgYmluZGluZ3Mgb3IgdGhlIGRyaXZlci4NCj4gPj4NCj4gPj4gSnVzdCBteSB1
bmRlcnN0YW5kaW5nLCBpdCBpcyBoYXJkIHRvIHVzZSBvbmUgZml4ZWQgc2V0dGluZ3MgdG8gZml0
DQo+ID4+IGFsbCBraW5kcyBvZiBjb25kaXRpb25zLg0KPiA+Pg0KPiA+PiAgICAgICAgICAgICAg
ICAgIE5vaXNlIGluZHVjZWQgZnJvbSBQQ0IgdHJhY2tzICBFbGVjdHJvLSBtYWduZXRpYw0KPiBu
b2lzZQ0KPiA+PiAJCSAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4gCQkg
ICAgIFYgICAgICAgICAgICAgICAgICAgICAgICAgICBWDQo+ID4+ICAtLS0tLS0tLS0NCj4gPj4g
fFNPQyhBREMpfCAgIDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08LSAofikgZXh0
ZXJuYWwgU2lnbmFsDQo+ID4+ICAtLS0tLS0tLS0NCj4gPj4gICAgICAgICAgICAgICAgICBeICAg
ICAgICAgICAgICAgICBeDQo+ID4+ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
fA0KPiA+PiAgICAgICAgICAgICAgSS9PIGNvdXBsZWQgbm9pc2UgICAgSW50ZXJuYWwgbm9pc2UN
Cj4gPj4NCj4gPj4NCj4gPj4gU28gT0VNIEEncyBib2FyZCBtYXkgbmVlZHMgZGlmZmVyZW50IHNl
dHRpbmdzIGNvbXBhcmVkIHdpdGggT0VNIEIncw0KPiBib2FyZC4NCj4gPg0KPiA+IFRoZSBub2lz
ZSBvbiBWcmVmIGRpZCBpbXBhY3QgdGhlIGNhbGlicmF0aW9uLCB3ZSBkaWQgZ2V0IHJlcG9ydCBm
cm9tIGN1c3RvbWVyLA0KPiBhbmQgSUMgZ3V5cyBzdWdnZXN0ZWQgdG8gZG8gbGlrZSB0aGUgZm9s
bG93aW5nIHBhdGNoLCB3aGF0J3MgeW91ciBjb21tZW50cz8NCj4gPg0KPiA+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBh
dGMNCj4gPiBod29yay5rZXJuZWwub3JnJTJGcHJvamVjdCUyRmxpbnV4LWlpbyUyRnBhdGNoJTJG
MjAyNTA0MjMtYWRjcGF0Y2gtdjEtDQo+ID4NCj4gMS1iMGU4NGMyN2FlOTglNDBueHAuY29tJTJG
JmRhdGE9MDUlN0MwMiU3Q2hhaWJvLmNoZW4lNDBueHAuY29tDQo+ICU3QzIxMDENCj4gPg0KPiBl
YmRkMjc0YjRkYzExOWZhMDhkZGQ1NmMxZTdmJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMz
MDE2MzUlNw0KPiBDMCU3Qw0KPiA+DQo+IDAlN0M2Mzg5MDEzODI1NDM1MDgwMjclN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0cNCj4ga2lPblJ5ZFdVDQo+ID4NCj4gc0lsWWlP
aUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZR
JTNEJTNEDQo+ICUNCj4gPg0KPiA3QzAlN0MlN0MlN0Mmc2RhdGE9Z1clMkY3RlBDcmN5VlNkdXlq
MGRLJTJCVm00clFKNGh2aUVzVGxUSjA2dXZIDQo+IDBNJTNEJg0KPiA+IHJlc2VydmVkPTANCj4g
DQo+IFdpdGggdGhpcyBwYXRjaCB3ZSBzdGlsbCBnZXQgY2FsaWJyYXRpb24gd2FybmluZyBob3dl
dmVyIEFEQyBpcyBldmVudHVhbGx5DQo+IHdvcmtpbmcuDQo+IA0KPiBXaGVyZSBjYW4gd2UgZ2V0
IG1hcHBpbmcgZm9yIHRoaXMgcmVnaXN0ZXI6DQo+IA0KPiAjZGVmaW5lIElNWDkzX0FEQ19DQUxD
RkcwCTBYM0EwDQo+IA0KPiBJdCBzZWVtcyB0aGF0IHB1YmxpYyBpLk1YIDkzIFRSTSBnb2VzIHVw
IHRvIG9mZnNldCAweDM5QyBvbmx5Pw0KDQpZb3UgY2FuIGdldCB0aGUgUk0gb3VyIG54cC5jb20s
IHRoZSBsYXRlc3QgUk0gYWxyZWFkeSBhZGQgcmVnaXN0ZXIgM0EwIGRlZmluaXRpb24sIGhlcmUg
aXMgdGhlIGxpbmssOg0KaHR0cHM6Ly93d3cubnhwLmNvbS9wcm9kdWN0cy9wcm9jZXNzb3JzLWFu
ZC1taWNyb2NvbnRyb2xsZXJzL2FybS1wcm9jZXNzb3JzL2ktbXgtYXBwbGljYXRpb25zLXByb2Nl
c3NvcnMvaS1teC05LXByb2Nlc3NvcnMvaS1teC05My1hcHBsaWNhdGlvbnMtcHJvY2Vzc29yLWZh
bWlseS1hcm0tY29ydGV4LWE1NS1tbC1hY2NlbGVyYXRpb24tcG93ZXItZWZmaWNpZW50LW1wdTpp
Lk1YOTMNCg0KSSB3aWxsIHNlbmQgb3V0IHYyIG9mIHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMNCkhh
aWJvIENoZW4NCj4gDQo+IEJSLA0KPiBQcmltb3oNCj4gDQo+ID4NCj4gPiBSZWdhcmRzDQo+ID4g
SGFpYm8gQ2hlbg0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBQZW5nDQo+ID4+DQo+ID4+Pg0K
PiA+Pj4gLSBOdW5vIFM/Pw0KPiA+Pj4+IE9uIHRoZSBvdGhlciBoYW5kLCBwdWJsaWMgVFJNIGRv
ZXNuJ3QgZ2l2ZSBtdWNoIG1vcmUgaW5mb3JtYXRpb24NCj4gPj4+PiBhbmQNCj4gPj4+Pj4NCj4g
DQo+IC0tDQo+IFByaW1veiBGaXNlcg0KPiBwaG9uZTogKzM4Ni00MS0zOTAtNTQ1DQo+IGVtYWls
OiBwcmltb3ouZmlzZXJAbm9yaWsuY29tDQo+IC0tDQo+IE5vcmlrIHN5c3RlbXMgZC5vLm8uDQo+
IFlvdXIgZW1iZWRkZWQgc29mdHdhcmUgcGFydG5lcg0KPiBTbG92ZW5pYSwgRVUNCj4gcGhvbmU6
ICszODYtNDEtNTQwLTU0NQ0KPiBlbWFpbDogaW5mb0Bub3Jpay5jb20NCg==

