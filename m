Return-Path: <linux-iio+bounces-11909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D49BC2F5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 03:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6884EB21EF5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11358262A3;
	Tue,  5 Nov 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFAWorZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41D22301;
	Tue,  5 Nov 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772583; cv=fail; b=m1VRMfg/yeXvFU4q1PlZYlk697KZj/0aTMestWwOel885Bi1uXhMqdT3yUP0XC4lXfO57IbOhGGxbEpLuPYAFVPOc7ugBWf1fE17aibRsfrS/pHnp8XRwZYGKSmD3jytCSchTTHLDSfkoGXOmafz/aH4V1V2cyd9A9/xNTk6o68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772583; c=relaxed/simple;
	bh=t6LkZwWNPktcVeJQ7ikCjXEyrYLIHng9ruUaJrmBzz0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qd4XU3r8+8Ujf2myG9ObElhPExBIKYNzIMW+dZZYohtwktrmGOoSUlZ8Cf5ElgmJln/td3IcvE/XTWgaEva/8q3TAghyDmiIJ+2FSkOSQlw+cebpmLc0mfHTuqboGaw8JkQq+oIRC/NIpAqv81W4j2hxLqEVxb+B8zodSG2uy2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFAWorZQ; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8hDFHomiFv84RzxjEI/ipLv5YTpzqsEaXrDvdTsYd8xasKLU6w628Vt81fLY86hnhYJSf77ph5+c4pnFZwyNkz7/F8k5F62uI0/QDG6GyjyLJ43PQ38EUqUuN4Ep8e6ipHXHIjyJcV7zHOsV0RnThcDgcnEd0DKObpArBncNGOzI24NMZKhEPnnWwoYBtKdRNhfruOwE5lQaAsR68irJzAO72BQo8L/2jMt3NQ8g7/SdW43Mm319oP6dzMSFCyhUFfoXU7pWHNNh6wKpT/l/lEfFwU1lg++FSvEs7BUWOc8yBHeKmqeOS5yDWWJ44XL4zRA1dHaRWxscyTb2OFaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6LkZwWNPktcVeJQ7ikCjXEyrYLIHng9ruUaJrmBzz0=;
 b=AEJ5g9LuQY4TkzT9p8vYAe3SR8FxE8YQ5VyqVo6dMxsLUhacHx6cGQ0DTlAmcLR8syj7jxkftz+FnKfn2Myv+HFcR2H7+BhR04zjlh+7YO9D7+T7k5QpQvSmxiu7YDepdV9ltLJp/ZC7/G+nZPcawWfau0UpRNJi1S7Z/eQb7NhAe8LYVvsBACzZknaqF90nEpVCmp+JPyIJewPjYHZezDTX3NwDGTe7bDd3afBr950b+jOvj6xoS7ry7lNEBHLIjQW0Z+zear+tFVAE2OU6fsn4r8dC0RyWVLifgGfKGg+kS/K4hYeNqhYMhxIGSQwDk8F1Cdg3SQaPSLZyEzcv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6LkZwWNPktcVeJQ7ikCjXEyrYLIHng9ruUaJrmBzz0=;
 b=IFAWorZQIZBE1+r1pmXxCX9Cggge+kGHrz1DcZpB1mq/aMbVBKCNenTe1twVR32WlPl+fwTbXeYm6uD0s2N5UlUf4D8+laZf2Zgh0ql/5T9lwEPm9T1feNRW1uz+UjdRYD2rf2IhbYMABFXCMC96Qy8gWO4X5pO9h0RsmritzzEWpSFUrpUkBP76lpy6FWifATlb9oz/CtEK8lKfBKuxcvTHyqwbpnJWoiz5vcS5sc6PwW31wCCWIbDNQzrM/HDpfU7iMzptbBb/tJ2w+rwNtMJOH3mN07S0nRIQNEo9K6+R5qOv0jsUl14qmJjepg50gN6l8pTlVDBTMZfo5T0TVQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBAPR04MB7398.eurprd04.prod.outlook.com (2603:10a6:10:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 02:09:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:09:37 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, "open list:NXP i.MX 7D/6SX/6UL/93 AND
 VF610 ADC DRIVER" <linux-iio@vger.kernel.org>, "open list:NXP i.MX
 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number
 to 4
Thread-Topic: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number
 to 4
Thread-Index: AQHbLw7+sooaDAgeWUOhfqGsxn26abKn8Tlg
Date: Tue, 5 Nov 2024 02:09:37 +0000
Message-ID:
 <DU0PR04MB9496C9BB0A80C0142A32F9DF90522@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241104231200.2745342-1-Frank.Li@nxp.com>
 <20241104231200.2745342-2-Frank.Li@nxp.com>
In-Reply-To: <20241104231200.2745342-2-Frank.Li@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBAPR04MB7398:EE_
x-ms-office365-filtering-correlation-id: 026fe898-2b4b-4db2-f6e1-08dcfd3ee684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?emlMOFdMN2JKZHZKMkpXU3l6Z2VEWjY5YzlnaytBQUd3VGdGTDhXOFdDbHA4?=
 =?gb2312?B?UmtjSzZCNkN5YXhYbTNFZGhDOHdPeEQ4OE0xNzd2bjNmdmlVc2tGMEdaVHlO?=
 =?gb2312?B?SmN5NWxFS25YbldxMEFweGwzaUhnZmVpM0N5UVpWVmRMU1NJWWdLWXFKWGJy?=
 =?gb2312?B?NWpBRW5IajRTWGkwcmdsS245bnEvZVBmeG5Tc1R0SkgvTEVpKzBFOFR4MWFD?=
 =?gb2312?B?NmdKYzNZOGtDOTRaOWJzekJwYWRBZTA4Nzk3R1NwMVhzbWN3b3g3RmhFQkpj?=
 =?gb2312?B?Q3RwOXlBdDZGNkpXSkU4Zk1vNnZUZ3RmRE0rSUl5Ym94Nk1oZ0NMVmU2T28w?=
 =?gb2312?B?WjJ0ZStUTmpHSDhuaW1mQnA3WDh3cUZmMTN2cm9TUkJ1VnVGTy9YWUdOSzc1?=
 =?gb2312?B?V0pJdDNWRkViV2JKNjh5RTlTNUVZQ0ZjeFNyTHJXK0VGRnhIbHM0bytjNk1E?=
 =?gb2312?B?SGlQZ29PMlpSaGFXUDV4UnhCQTNkQ0M2bTdqczg2QXFrTFVxZEZQMmZlblFs?=
 =?gb2312?B?OFFOeUQvT3FtbWpaenZHUE0xejd6OEMxZTAyeEZraENtMFp2amZ3V2dWSWpT?=
 =?gb2312?B?RkcvNFJLWlRYdG9XY25xOVpKS0tyaTB0RExod1hJUmFLUHF0d0dvYXhTdGNq?=
 =?gb2312?B?TWFiZUhQMWRhRWg3SVlEaWFTc3Joam9FMklyQ3pRNXRsZFhXZ2NuQmx2dnlq?=
 =?gb2312?B?dlBhVEMwbjM2dmh3emtrZkk0QXhhdDNQbDFUbWFzaUhiU1NjUHEvR0htVGgv?=
 =?gb2312?B?SEcrVkVJY0VObmJJVVhTUW9GRWx3WjUva2NnR2dpZXUvVVkwTktndU5BOEd5?=
 =?gb2312?B?bHBkb0ttV28wMXVWa3k1U3hvZjdnMCt5TkthcUdEL3lnUFNHTDJJTk41UlEz?=
 =?gb2312?B?dkJuanc4Vjg3ZXczZEpvN01tWG5qeEJFS1NFZlVNTkM5TUR5VnVIUWtLa3Np?=
 =?gb2312?B?WFM1SURBcnJuUmsvcktvTnVDbDE0dVJVV3p2SGphS0ZIaERZTVpydU53MmFC?=
 =?gb2312?B?UHc2d2RrVEkvNzlmOE9hME1jbzF1ZzlIQW5kTCt5S0JPUUpyODNPQ3RjSENJ?=
 =?gb2312?B?Vkp3VUxqcFEweDkrUHh2UGM3ak9SdjZRVWgraXE4Ty9QbmNoRUkzVFB6cGpK?=
 =?gb2312?B?MTZxaVJEYjE4T0tsbHczVy9uczUvbEY2dUQzckJBOUNXUElIaWNoektMS3hZ?=
 =?gb2312?B?LzdHdSt5Mlk1VkQ3bE9HS1VjNTBRUFlxdWwzRGxQZkJ1MjY4T2tyUzcrVmpP?=
 =?gb2312?B?YmF2cUdUVlRJOGVvTGQ5VmEvajV3R2ZFM2Z1a01ZREt5dG95WTRRWVluYlV3?=
 =?gb2312?B?OCtxc0wzMXpjYWxpYnZWb2Zaa3luOGRPZExRM3NwbFBDL1BnbEdIQXJ3aHM2?=
 =?gb2312?B?RVNpYmZyZ2lWWHMwaVpVNmZGalF4Z0pCVFEyMWNxaGRXMzVKMVh5TTdYUDV1?=
 =?gb2312?B?NGhJbWdwWkxSMjZ4WDJBbXBQYWdsOHE3OVNNNDJpTzc0Rm43eGJnSThEUGR2?=
 =?gb2312?B?NVZGQWZSaFNPcG02czRUTFNIRFpmVmNUbnhLL1drZWlSZDl5MTVDTW5WWVZs?=
 =?gb2312?B?ZktmRnhRQkpYZWErb3REekRLK2RTeDhuOVg4QXNXNzV2c1hjclgyM2FtMEpM?=
 =?gb2312?B?STVoV0gvaXdadENSMkgyTHB0b2FYaCtJOWRnYi9CeXA1b3JYMWNTV0c5VUZW?=
 =?gb2312?B?Tk1JWkFKNXBZZ3Z6LzJYM2x5YzJHNVNrYzYydTcvS2xVRnNYdmlTTWZOby9X?=
 =?gb2312?B?WitkcU5MSk9WS1dGZERQS2VFUjMxV2N4L0VGZEtld1JmNlU3alNxQlMyMkJY?=
 =?gb2312?Q?8ZoEQ24o2dK7kRhzkMe52sva2WsQT2BvXmG5g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?blBWS2tKRUVpaUdtTnZobXNkeFVlYW5sNmdXY3pqaFNNZ285aHI2U0NWV2tC?=
 =?gb2312?B?NW5Db1QxdndKWWlUYXRDQkQrMjM0WE11akJyT3dCR3VvNGw1bnRiY21Scmg2?=
 =?gb2312?B?V29CelowWVZHVjArQWg4SnVNenZTMzVNSk90RXZyZDU4WTh4NkVSa2tZZ21B?=
 =?gb2312?B?cU9ZM0pxQzRpQmlBUlF6YThKSi9OdmRwRlZSYU44b3FuL09QVVFLaVFWc1Rz?=
 =?gb2312?B?LzlNSjFkNkRoOWF6cDJaeitCTFJPYmxxa0FURHk4QkFPRHNaNnVlblBUM2hj?=
 =?gb2312?B?NU9tM0lZa1cyNWluK0RCREp0VGZ5K3dBcFVzdzk4dXJhWFhoa1l5ajNIRklT?=
 =?gb2312?B?czg3WWR0K0RMRkk2L2svNnpWaHJkektDUkoxdkxXU1BhQU41bjNEb1ZML3hW?=
 =?gb2312?B?OWdCMlpraGJUWnFvWE04czk0bXgrS0FiTVE4RDJRaE1NazZCQlpyTWExay9p?=
 =?gb2312?B?ZEZJTTZxNG9Eb0M4Nm9RQ0JrQTNkeW00M3hrTFVvMEhzSlY5cXNRZ2hEdm9m?=
 =?gb2312?B?Z2VLcWlsUkY1WGtsSUNxUXBYSmMvQlZRdmZrd2sweng3b0o4Q1JEUVkxVUx6?=
 =?gb2312?B?bjBGVERVWmVydXFxQVdOTlNkUzFlQVY5UG14VVVUaktqUnFIbG4rWEJEaStw?=
 =?gb2312?B?bUpGNU9ERlVNS3dNL0dUcmxkTGdHa2h3THdJN1FIL1BkcnJCaTIwb3AxQ0Jq?=
 =?gb2312?B?VU5pU05Wc1VvQzA0clR5NHBkOW5VNk4vTEZZU0FaS3pOYjJPOHJaMTcvSlZi?=
 =?gb2312?B?SEl4WGR6Mkg2OUF5cEdRUFVHYzRaaXdzTkJTdy9lU3RhdUZhMzNRUW1ua2JB?=
 =?gb2312?B?RW9ZMG1hQ3F0SkFYeVQ3NTdoTzRtOG9ieWNqcklKRzh3dnRvZkVvTVNEY1NL?=
 =?gb2312?B?dGRkUTJwTDZucXFvM3dqWFJWSzlwUjZoczF6c2RsRDJ6bmlKRWVBTUpCbnNM?=
 =?gb2312?B?Qk1pMTlXR1N0Y21ySEdOdE1GNVNKQldWbTVqbkVvdEdyY3hCL1h3TjNVcXFj?=
 =?gb2312?B?M2o5N1BtcFZ1OW5DWmo0Q1ZtOXVQSnpuS2o2SDZMNDZ2N0QrWFhjdmZlQmJP?=
 =?gb2312?B?aEpJRjBCdW1XMnRDVlRMY29RNkd4elZ1ZWRKY2tKMUpDZE9KUldtdERLaVRn?=
 =?gb2312?B?cUEwRlhwWTdxZUxDRHJZMzl4ZXR3UmdSZjErRFpHMy9BazdaWWFWTjVsT3Q1?=
 =?gb2312?B?clp5ZDZmV1gzNUxKSTZuNUUxQTVDUHM5aDJoUlBnN1hFYUhFSXNuV2p4dk5N?=
 =?gb2312?B?bVYxRXJvcHVTWUd1cWs2Vi9hbEtDQ2duYnNFZ2RteTF0VnY1aVVncDJmZkln?=
 =?gb2312?B?ZFUyZnQyYlh0b1FSUk55bWRWZFJscEpKdGRLNnRkVTJDMkp6VE9TOFgzSmRP?=
 =?gb2312?B?UUtyYjZFTHpzajFldnNNaHI1MWJKeElIU0Vlb0ZwalNOejNYWmlEc2RLdFd2?=
 =?gb2312?B?bXUvTXRPM1BZL0w1OVVSM3MyTitsbWdOczR4V1BBaEF6VEVrcVQ4ODJDY0pQ?=
 =?gb2312?B?SnAvVzhRSkRpTEdRcFQxTkJ5eXdybmFwOTV6TXVhVWJKc2luOUh1ZlNEQTZC?=
 =?gb2312?B?dmVWcmM3cGpzWk1YVEk4My93OXRjY2srWHloNWdaOStuY3g2NGxDZUdEd1NZ?=
 =?gb2312?B?K3FEL08vU2JuYmFyZENLR1Y4Yk52dGtycnNTSmxnNVdtUUY3QmhwWHpKNDhp?=
 =?gb2312?B?MHZxNS9wNGFiSmhzNXdCWHpFVGFlaXZCZ0xJOC9YdnF0dThFN1lkUXVsMlBV?=
 =?gb2312?B?ODlOaml2cWRxQ2lKaXVMeGFqanJhQnJPb2lPZnJQWTZJRm1UKzRTWG5Qc3dN?=
 =?gb2312?B?WDMxenExY3NJV295a1FMNnZLY3pab1Z3NUpaUGYyOXZTUmNUWjlMb2RwM3Ro?=
 =?gb2312?B?ZzEvOVlSM2FFSEpmd2taOWNXRWxzdHRnY2xhWVExb3dQVWp4SmV0ZSt2VTVh?=
 =?gb2312?B?Z3hnbmd5ZHJCYnBxNk9vSmZucWdMRUhZVGxxMzBxTTFURUpiVjc2L25EdUFa?=
 =?gb2312?B?RDZBU1ZaU0ZZb056bkg1UXZiUkdhYzNPWE4yWjlMUXk4dU9JQXcwZHdrc0lD?=
 =?gb2312?B?bTVYbVA5NUovOUVMUWdManJBZDIzNndQOGtOMlBJKzF1K1BrUzRtYlBnQWxE?=
 =?gb2312?Q?aBc4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 026fe898-2b4b-4db2-f6e1-08dcfd3ee684
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 02:09:37.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zz9lrXTmhp6PfJ/LXX0x7SjTGTLT1tzIg0j6EG2WOfxdCkrjgzwAQRhjXHM8he7zaEXRHE0NAoPCaRgqd5bLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7398

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTHUwjXI1SA3OjEyDQo+IFRvOiBCb3VnaCBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqaWMyM0BrZXJuZWwub3Jn
PjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBvcGVuIGxpc3Q6TlhQIGku
TVgNCj4gN0QvNlNYLzZVTC85MyBBTkQgVkY2MTAgQURDIERSSVZFUiA8bGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZz47IG9wZW4NCj4gbGlzdDpOWFAgaS5NWCA3RC82U1gvNlVMLzkzIEFORCBWRjYx
MCBBREMgRFJJVkVSIDxpbXhAbGlzdHMubGludXguZGV2PjsNCj4gb3BlbiBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBpaW86IGFkYzog
dmY2MTBfYWRjOiBsaW1pdCBpLk1YNlNYJ3MgY2hhbm5lbCBudW1iZXIgdG8gNA0KPiANCj4gaS5N
WDZTWCBvbmx5IGhhcyA0IEFEQyBjaGFubmVscywgc28gbGltaXQgY2hhbm5lbCBudW1iZXJzIHRv
IDQgZm9yIGNvbXBhdGlibGUNCj4gc3RyaW5nICdmc2wsaW14NnN4LWFkYycuDQoNClJldmlld2Vk
LWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KSGFp
Ym8gQ2hlbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+IC0tLQ0KPiBjb21wYXRpYmxlIHN0cmluZyAnZnNsLGlteDZzeC1hZGMnIGFscmVhZHkgZG9j
dW1lbnQgaW4NCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvZnNs
LHZmNjEwLWFkYy55YW1sDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL3ZmNjEwX2FkYy5jIHwg
NSArKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgYi9kcml2
ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgaW5kZXgNCj4gNGU3MzdiMTkzYzAxMi4uODQ1NzNjZGZj
ZTVkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3ZmNjEwX2FkYy5jDQo+ICsrKyBi
L2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYw0KPiBAQCAtODA5LDcgKzgwOSw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gdmY2MTBfYWRjX2lpb19pbmZvID0geyAgfTsNCj4gDQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB2ZjYxMF9hZGNfbWF0Y2hbXSA9IHsN
Cj4gLQl7IC5jb21wYXRpYmxlID0gImZzbCx2ZjYxMC1hZGMiLCB9LA0KPiArCXsgLmNvbXBhdGli
bGUgPSAiZnNsLGlteDZzeC1hZGMiLCAuZGF0YSA9ICh2b2lkICopNH0sDQo+ICsJeyAuY29tcGF0
aWJsZSA9ICJmc2wsdmY2MTAtYWRjIiwgLmRhdGEgPSAodm9pZA0KPiArKilBUlJBWV9TSVpFKHZm
NjEwX2FkY19paW9fY2hhbm5lbHMpfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+
ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCB2ZjYxMF9hZGNfbWF0Y2gpOyBAQCAtODcwLDcgKzg3
MSw3IEBADQo+IHN0YXRpYyBpbnQgdmY2MTBfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAJaW5kaW9fZGV2LT5pbmZvID0gJnZmNjEwX2FkY19paW9faW5mbzsNCj4g
IAlpbmRpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ICAJaW5kaW9fZGV2LT5j
aGFubmVscyA9IHZmNjEwX2FkY19paW9fY2hhbm5lbHM7DQo+IC0JaW5kaW9fZGV2LT5udW1fY2hh
bm5lbHMgPSBBUlJBWV9TSVpFKHZmNjEwX2FkY19paW9fY2hhbm5lbHMpOw0KPiArCWluZGlvX2Rl
di0+bnVtX2NoYW5uZWxzID0gKHUzMilkZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gDQo+
ICAJdmY2MTBfYWRjX2NmZ19pbml0KGluZm8pOw0KPiAgCXZmNjEwX2FkY19od19pbml0KGluZm8p
Ow0KPiAtLQ0KPiAyLjM0LjENCg0K

