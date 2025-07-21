Return-Path: <linux-iio+bounces-21805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E9B0BFB4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC6D1891D7A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD3288C0E;
	Mon, 21 Jul 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XOAXZ5YW"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952D172BB9;
	Mon, 21 Jul 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088954; cv=fail; b=loidoXH2ViCyhoiIh1wicPAF3HW1sa81SMucljP3wD4/yWlhUNr4xeIL48oIeY+Pb8InS977KoM8l/p27qL/kMHsSREJ8iQq6CceTBIvo5r+Oh22hHNDnZVwpb6ND86VPD1x1LR2kFGFzFNZwa73MVNS61Rwx69jW2Qxap+KL/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088954; c=relaxed/simple;
	bh=fTnF3xoE1Gj9YXbGBvi8uC+kAkByDNTxkfejT4MXRGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fba/guE7K11t8V0he7F/Zrtcr8/DOMkCYCdelHw+Rxp/Z3qpGRCE45+pDKwvcxJg/Qq4xsDMH+lT747ZDnuo+Jl6e7UPOl/AKJxV+tnPH64eCnUwuwrHBeCwMoFUXH6jc9xLMAksyDCwf07gGrKTuyBJwXyNxr4A/MKehwpIdHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XOAXZ5YW; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqyrHI7msr9l8jJplYm8t55X+q60yUbicp/n6O5xDEcXAQZeWdHrGZ2utvcmbVBXbjJZc9u33hwBprZEV2yU4NAT+PmtNslaIdxlhnnPAqpv+0oR/IeBj0ZYqmYDPEbEYn5dBVdeKzIZVyTswwj1WO6LLOaOXxUYiN/mOKi7Fy509A46zkSTrlhU9wYFeEgDvqnYKPBXA4H1hse/qgqgyoacJkUDQYQruBuJ5FZCzKqFzm/QhR/yzHM5u6zQQdFUF0TIdSbi15ULdt31UykifhRGk3Kq0/Fk2mcYFpP/nnYOZcWAIqNHBnjlHNZXyOn+3fxAGjME54Z9NrX8w8G8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTnF3xoE1Gj9YXbGBvi8uC+kAkByDNTxkfejT4MXRGY=;
 b=NoPWCZke1VBj4t74rg4+Tq29R76XMkW+C5XHaBLPMA5l9PKlYaPaqlvWAcuHFs0q9BpmQE+cydO4Knhsk6vHnP458pjSPkG/bHB9Jot1HexKPh3yKQsfXgmudo04Fexa8g2iF+hMFgLKUtIw6zo6+m8kvwHJxIXzH/qcf6fBDiFeHFvY9gylK7dBpVQHfs6E0pkSORhGjd9yoVC8u8J+l2PzPrfZSLe4QiTsTgTKN3Bmj3cJgMrY3f7Tnpz5sjYnx6fqeAxIXspTq7lvOeoaaXaV/UwAUMSn0345b5x1mOks9NWbN0QzlseK4Mp0XOkg1O4HqqqyL1EpfwR2wl5lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTnF3xoE1Gj9YXbGBvi8uC+kAkByDNTxkfejT4MXRGY=;
 b=XOAXZ5YWogIvGNIXVRqpAslh2q7OnkAUlpS3MmVPZ6SytFUc9Wwwjzl7GaYF0ZpjfM2KYsyS8Sc7eMIO5vNL8Sqd0GUZZlAzLXRvs3hLNQmYye8B1S6tbMvXpHexFZDhrelTFEtpTkvfLRXvsdY34QJCEyT3hH6FCPAJXUKDENoFb1xjOCH+WPg33QUVuvbg0GuauyWGha3Opv0qlhrKXvc7Nklxaqdp34rBCxZrZ5SqgchL/vwg2SY9xzZh2zq2uAELoERzajQjOVr20HlY9AvQ7iwpdDYkN4A/dGKu1sspKLUtUpaNivXDEi+rExaAIc74bB1uR0Tt22Foy1uZ1g==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8770.eurprd04.prod.outlook.com (2603:10a6:20b:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:09:06 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 09:09:06 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Nuno S? <noname.nuno@gmail.com>,
	Primoz Fiser <primoz.fiser@norik.com>
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
 AQHb8W26y5fO8SJjh0GULyxs8/1/5bQrgNAAgASqt4CAAPmcAIAAq+2AgAqSl4D///Sf0A==
Date: Mon, 21 Jul 2025 09:09:06 +0000
Message-ID:
 <DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
 <20250713160247.0f22bbfe@jic23-huawei>
 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
 <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
 <20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8770:EE_
x-ms-office365-filtering-correlation-id: b95e984c-59c5-4fec-3fba-08ddc8363eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?eEtFbCs3WFM4QzFORDVSelNxektTQytLT1hrUGFmUE5DY1dMMlZuSFdzRkhn?=
 =?gb2312?B?Y09Jb1pMVlJveE51UUpZV040ajVlb1JSbFZ3UGJVaGdoS09hYjJxeE9FTjdw?=
 =?gb2312?B?NWNPSXlXNjdIZkF2N0hZc0R6LzRmcEpaTVFvZlpKdFJjcDRNblJjWThEV044?=
 =?gb2312?B?L0dHUTh5SE9HTWcrUjg1Q2svVEVTVmM3bVNOTXROOWRtQlpLdjNFcitzOG1L?=
 =?gb2312?B?MGVvd1dhV2JaNE5HQ0RGbjhlb3J4a2E4b2pPZTVINmlhNUgrSVZrMkpRaGpD?=
 =?gb2312?B?MmxuU2RWTzlsR3RFWVovVlhDNTRlcVpMNWdLM2M1U3BrVStrV3VhaTc5Qlg1?=
 =?gb2312?B?TjRDZHZ6bk5QMTh5cmFMNE5xbnVINlpybUw0SE5VemU5MGp4cUNGVnJ4czdz?=
 =?gb2312?B?M0hyazZwOUQyVnI0dGVrRi93TXFYajJRNGwyM25HT2EwaGZ5MEtPOWNBZ1Bm?=
 =?gb2312?B?dUNwOUloL1ZjdFM5clhUQTZjeXJJZnV5MnUxNzVQQzZVdlFuck5aNVZjZVdp?=
 =?gb2312?B?Mlk2TTU5cG5DakJ6ZUdHdUdGYnlXQVY0ZUFFeXJxdEtEL1Fid2FsR0lycUJH?=
 =?gb2312?B?cjI1M2gyakQ0eDAzWWc4OWhxRGtHVk84eGx2RFhCRjgrN3I5bnluU2MzL2NJ?=
 =?gb2312?B?cVZzOGFGejRBSE03c3ZJUFJBVCtTM1I0eGF0WUJOaWJaUm1OVkV5RmZ3NW1a?=
 =?gb2312?B?aTVXVWlnRkVxZGtjRkVBbHY4K1VTY1kyNm12K0R1U1Bzd0FLR3BWWjhLLzRS?=
 =?gb2312?B?bzFZUkZvRGg4OUFWYlZwWU1OWXF6WDA5T1B2NXd5TkFGVHZzRTdnMFE1VUV6?=
 =?gb2312?B?MXN2TWdRa2xFcXBoamFNQmdLNEdlQXI1ekUydk1PTS94Vmp4Vzc4Z05xQXJv?=
 =?gb2312?B?eW84eTBpTmJZTGZpVllBeFd2NldRSERlY0lQdGRwRjNZL2Mra3JZY0txRnhJ?=
 =?gb2312?B?MXRMMkVlVlVmejkydVc0R3EvV2hqck9EK2FBK1dHTTlENHlUWkF1RExRVHJL?=
 =?gb2312?B?RmE5T1lpUi8wQ2hqUnpXM3pBOVlSNVBxSG1scTlNS3YwVDV5emNEYi9YWmho?=
 =?gb2312?B?Z29ZRUJmQVErQkdnV0Y3RUV2cjM2V2pVSitETE9va1pjY0RNMEVRa3k5cW9Q?=
 =?gb2312?B?bHEvNmdlbERPdU9xZXl6OTg4Q1NIM1Q5VnRYdGxvMy9NMUU1aERZRzhHNTF5?=
 =?gb2312?B?UEJHQ1NUZ3FKZnpReW1UVmVTeXk0NVN5TEE4d1FCMWxQRm1DYlpGL2ZpRXI0?=
 =?gb2312?B?UUlwNUNyK05wOEVUR2ZxZi92bUdnVHZSUnRpcUU0WjJiZ0dSZWlXSGhNdVVj?=
 =?gb2312?B?WDdXYU1wdnVlb0ZtbzFuK01rNDdCMnBLN1ZCN3ZvMUFPMFBYZXpWVTRKM2Nv?=
 =?gb2312?B?ci9UZkE2Q2RJUTJ6WTA2TDZpRkgrRDFia3I3T2tuQTBMd05YYmpJNWczL3Rr?=
 =?gb2312?B?anJtalZ3M3RFYTFIZU5PbVFvQ1ZiZXRTNWZxNFI2MmJTZTdPSklpVDd1ZDc4?=
 =?gb2312?B?bFVtM3FzSUM2QmUvZDBBTkJJVzFENTJjVG8yTUNWS1dxbHpsRjZQWHR4aFZo?=
 =?gb2312?B?alJsRG1SSHBET1Q0MndiS05XNXlEM1ZINUhJdTU5QlRvc3VTUENYZU42WDlR?=
 =?gb2312?B?cytyY1FVNnVpR1hzVlhQbG5VMUVtVDBPWDRvRk5TK052WHJIMEhOOGI2b2Yx?=
 =?gb2312?B?NzRhZktkcit3UUVFWVJvTkFoeEwrNFBrSGl3K25VLzJaMzdQV0sxMTZqQnQw?=
 =?gb2312?B?ZDRYWmd3YURFUW1oR0FDck1UU1Azc3RZbFBUeWpJNGRTZ2h4Vm5IN1o2Qzg2?=
 =?gb2312?B?aU5nNGw4TWg0S2ZxemljL3A2eXJWdFZBcSttRlI5bjh2RDZydGx6YjEyVEZY?=
 =?gb2312?B?bXBPek5FZmNmeHlDN1pMelgwRVE2d0ptTStKOVhxWDJxZ0RCdEZVaExoUEto?=
 =?gb2312?B?TDhlZmpqVzJYMVdtMlZnNkVxWEJ6REdKbjV2TEZsOS9Gakt5aU1vb2oyN0Jq?=
 =?gb2312?Q?AmaPOTYIKchtrKA0DBpZAxn5KL4TgY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UHczdXNHRU4rakdCOG9JMy95djMwMVFFRzI3QldQQ1Rjb1JWUk1BUUR0aXI1?=
 =?gb2312?B?dVVVbDlBNkE2Y2doNnQ1MC9Kc2kxK0w2L2hIVzV1RForV3pzK09DSzN3aDlK?=
 =?gb2312?B?YURaVkxaSm1FcFJsN25CMjlaMUJka1VwYkFJSlN1OWxHMUpRNTgwM2FwSzh4?=
 =?gb2312?B?dnU3cXVVa1JBSEszTmJBVWtPSkRoS2RkTU9OdXhBQnE3NnRwLzBiL01ScCtF?=
 =?gb2312?B?RTdDVUJpT3pNVXF0a3ZjK2pDZFlnZ2lMaE9sb055bjBCUm4rbXJVamQzM0Zq?=
 =?gb2312?B?dXRFUGlVcTR5N3hrY0ZDcFh6YS9HZ0Fja29GbHRSTWgycGVSQUU5NFB0VkVR?=
 =?gb2312?B?elNUVGJ1T2tlSitpM01oc201M2V6QUVZTFZxOUt3UjR3MVgyRzlmK2JuWXcy?=
 =?gb2312?B?OUNadTY2K205ZzJWeG9jM0hNc2hPMUx5OTZlTEt3RTlOUEN3Z25ITW5JeFBV?=
 =?gb2312?B?cExkRkdEaWNlZnpHdHpTYmtvbVczdm9UV1M1SHc5WlNpdlRhRXRYZDJlbFVE?=
 =?gb2312?B?b2FVMWFVaUxtTCtielVlektaS3BmcnZYbmt6TzJBOGtMaTljSzVqeTdEMmp5?=
 =?gb2312?B?ZFZ5OFd1NC9VRHV1UU1aVW8zMXVjUjNiUUhVUnFhcVV4bWVnSUFIelFmY2Yy?=
 =?gb2312?B?SUFpOXk3MklVRmk3a1JjczRZekpWcDNheis0SktjUWtaTFlJNndXSlgxdG04?=
 =?gb2312?B?djhKZU1QeHhWVGZuSFlsMlA2dDFTaVBKTCtlUElWWHZid0s1UzhCZGVoWXJj?=
 =?gb2312?B?WVliSEhtRkllSGl6SDcyS1RwRE9sSE5NZ0wzbmdWWDhVOWFtYXBoSjR0dWtn?=
 =?gb2312?B?bTVSWjBoa0FrbWRWQnlpd0Rqc0VZcVdtaUo3dmtOMkZ5K1phajdFWHoxY3ZT?=
 =?gb2312?B?SlJVV2puTlAvNTJtQWxqaFk3c1JiUVRvOVdnZVZlbjJiSHc2RjhEekMzY291?=
 =?gb2312?B?VzFnQ2o0cFVDM3hXTEpJa1FWQ2sra3lZcnFyWmpWeitnMmtmekVZRXlDdDVn?=
 =?gb2312?B?LzJRZEJzcHNvT2NlMCtxZDdHdEE4YlU4UXFzMXBQY1l5UjU2NW91eTNrUlpw?=
 =?gb2312?B?WS9zRFYvUThxZHlTTGVuMmlSb2ZZaGZScXpKWUJDZm9NUHRhSWtOSG1KK0Vj?=
 =?gb2312?B?aUlORU9mV3g3WnFuNFd1b3pVZnRmYmtmemwzWTZ5K3E3V0FFVHVsREhkY0Ns?=
 =?gb2312?B?U3RwZlZHRCthUmtUd2tyaitOOVkxVXJ6dkF0OGNJWEpnMkx4akVhSUl3OW1K?=
 =?gb2312?B?dHlqNTZic1BvL0pNVXlEc2l6L3ltQ0czandXbFhsMHFOcGxYZnBwenFYdjc5?=
 =?gb2312?B?WmVqdjhwVG9jbTBKbngxeVRSeGd5NFJ3b0pTK2ptTFQ2NGdWZ1haQzFITnJo?=
 =?gb2312?B?UlFmMDNuMFg4amdXMWhNMTczZUsrWkswc1VzampBNWlNWG5jQ2s0VXlNdWVh?=
 =?gb2312?B?TGdTdXlGZVlycGlTOXBMa21mOGJoajFSOW0rbEF5Uk1yUVczYVZPWHVKcDRj?=
 =?gb2312?B?YnZRWTJoeUZMbnN0VWNQbTkyNVFKbGgxTURVNXppSXdnZXJkT0JVWk5rUmZo?=
 =?gb2312?B?Q0M2S0l6Y3RZS3RJY3JYbzdBV0t4cjFWdGJPTEFSVFZ2Rm1weUhyc2l0RzMv?=
 =?gb2312?B?dHhvQU1lS0Q4cktseUFOV3BnYzdLRUlPL1hpOWxBRzFUcFVldHEwRFpLVFFL?=
 =?gb2312?B?cml6NU82Y0wxRmU3ZjlGZ2tic09JOW9makpkUThtbW5Rc2lmbitZNEJWa0VH?=
 =?gb2312?B?czloVTVWUGRGYUVCazdjWFkzbHhCeEVxY1NRTnNUUGRVUUVoVU9YM3RwMXIy?=
 =?gb2312?B?Rjl2RWFGbVFOTzE2VlZwQmVzZjREWU41aE5ZUUtYWnhMeTFIZFkvM0RZcEFx?=
 =?gb2312?B?aFlRQ0pPTTlKNGFaTXRmNWF0dDNib3ExZWp2WnR0SGNFR1ZDaUpBMnJZb2tL?=
 =?gb2312?B?N2VoUmsxYmIvYkdUUXJPdHlKVzV6WVl1amI4WG1XNEZIRmhmeHF4aWtkQXZr?=
 =?gb2312?B?MUwvMDFHVytUMm5ybGpsR2J2UVJPQUd5eEhZSVppc1hFOUMrMFcwc21NWStk?=
 =?gb2312?B?VDZ6NElCeXRJTC9UK1JSTVFuSXBxTVZ1WkdETmJFbVN5VXdaSWxadzBNOVVh?=
 =?gb2312?Q?+kfo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b95e984c-59c5-4fec-3fba-08ddc8363eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 09:09:06.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlqfSYrRqMpWVg2frAko0q56Txbs8sFRS1hSzqLek7BTxKSNjQCl6f2Cx/56zdhgg+j6YLJPUkk5rjt5KrQtfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVu
Zy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IDIwMjXE6jfUwjIxyNUgMTc6MzkNCj4gVG86IE51
bm8gUz8gPG5vbmFtZS5udW5vQGdtYWlsLmNvbT4NCj4gQ2M6IFByaW1veiBGaXNlciA8cHJpbW96
LmZpc2VyQG5vcmlrLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+
OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBCb3VnaCBDaGVuDQo+IDxo
YWliby5jaGVuQG54cC5jb20+OyBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNo
ZXZjaGVua28NCj4gPGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBE
b29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBQZW5ndXRy
b25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0K
PiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgaW14QGxp
c3RzLmxpbnV4LmRldjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgdXBzdHJlYW1AbGlzdHMucGh5dGVjLmRlOw0KPiBhbmRyZWoucGljZWpAbm9yaWsuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogaWlvOiBhZGM6IGlteDkzOiBB
ZGQgY2FsaWJyYXRpb24gcHJvcGVydGllcw0KPiANCj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQg
MDU6MTE6MzFQTSArMDEwMCwgTnVubyBTPyB3cm90ZToNCj4gPk9uIE1vbiwgMjAyNS0wNy0xNCBh
dCAwNzo1NiArMDIwMCwgUHJpbW96IEZpc2VyIHdyb3RlOg0KPiA+PiBIaSBhbGwsDQo+ID4+DQo+
ID4+IE9uIDEzLiAwNy4gMjUgMTc6MDIsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4+ID4g
T24gVGh1LCAxMCBKdWwgMjAyNSAxMDo0Njo0NCAtMDUwMA0KPiA+PiA+IERhdmlkIExlY2huZXIg
PGRsZWNobmVyQGJheWxpYnJlLmNvbT4gd3JvdGU6DQo+ID4+ID4NCj4gPj4gPiA+IE9uIDcvMTAv
MjUgMjozOSBBTSwgUHJpbW96IEZpc2VyIHdyb3RlOg0KPiA+PiA+ID4gPiBGcm9tOiBBbmRyZWog
UGljZWogPGFuZHJlai5waWNlakBub3Jpay5jb20+DQo+ID4+ID4gPiA+DQo+ID4+ID4gPiA+IERv
Y3VtZW50IGkuTVg5MyBBREMgY2FsaWJyYXRpb24gcHJvcGVydGllcyBhbmQgaG93IHRvIHNldCB0
aGVtLg0KPiA+PiA+ID4gPg0KPiA+PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWogUGljZWog
PGFuZHJlai5waWNlakBub3Jpay5jb20+DQo+ID4+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFByaW1v
eiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT4NCj4gPj4gPiA+ID4gLS0tDQo+ID4+ID4g
PiA+ID8/Li4uL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55YW1sPz8/Pz8/Pz8/Pz8/
IHwgMjENCj4gPj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+PiA+ID4gPiA/PzEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+ID4+ID4gPiA+DQo+ID4+ID4gPiA+IGRpZmYg
LS1naXQNCj4gPj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlv
L2FkYy9ueHAsaW14OTMtDQo+ID4+ID4gPiA+IGFkYy55YW1sDQo+ID4+ID4gPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55YW1sDQo+
ID4+ID4gPiA+IGluZGV4IGMyZTVmZjQxODkyMC4uZDFjMDRjZjg1ZmU2IDEwMDY0NA0KPiA+PiA+
ID4gPiAtLS0NCj4gPj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2FkYy9ueHAsaW14OTMtYWRjLnlhbWwNCj4gPj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55DQo+ID4+ID4gPiA+
ICsrKyBhbWwNCj4gPj4gPiA+ID4gQEAgLTUyLDYgKzUyLDI3IEBAIHByb3BlcnRpZXM6DQo+ID4+
ID4gPiA+ID8/Pz8gIiNpby1jaGFubmVsLWNlbGxzIjoNCj4gPj4gPiA+ID4gPz8/Pz8/Pz8gY29u
c3Q6IDENCj4gPj4gPiA+ID4gPz8NCj4gPj4gPiA+ID4gKz8/IG54cCxjYWxpYi1hdmctZW46DQo+
ID4+ID4gPiA+ICs/Pz8/Pz8gZGVmYXVsdDogMQ0KPiA+PiA+ID4gPiArPz8/Pz8/IGRlc2NyaXB0
aW9uOg0KPiA+PiA+ID4gPiArPz8/Pz8/Pz8/PyBFbmFibGUgb3IgZGlzYWJsZSBjYWxpYnJhdGlv
biBhdmVyYWdpbmcgZnVuY3Rpb24gKEFWR0VOKS4NCj4gPj4gPiA+ID4gKz8/Pz8/PyAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPj4gPiA+ID4gKz8/Pz8/
PyBlbnVtOiBbIDAsIDEgXQ0KPiA+PiA+ID4gPiArDQo+ID4+ID4gPiA+ICs/PyBueHAsY2FsaWIt
bnItc2FtcGxlczoNCj4gPj4gPiA+ID4gKz8/Pz8/PyBkZWZhdWx0OiA1MTINCj4gPj4gPiA+ID4g
Kz8/Pz8/PyBkZXNjcmlwdGlvbjoNCj4gPj4gPiA+ID4gKz8/Pz8/Pz8/Pz8gU2VsZWN0cyBudW1i
ZXIgb2Ygc2FtcGxlcyAoTlJTTVBMKSB0byBiZSB1c2VkIGR1cmluZw0KPiBjYWxpYnJhdGlvbi4N
Cj4gPj4gPiA+ID4gKz8/Pz8/PyAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPj4gPiA+ID4gKz8/Pz8/PyBlbnVtOiBbIDE2LCAzMiwgMTI4LCA1MTIgXQ0K
PiA+PiA+DQo+ID4+ID4gQWxsb3cgMSBhcyBhIHZhbHVlIGFuZCBkcm9wIHRoZSBlbmFibGVkIGFi
b3ZlLj8/Pz8gQXZlcmFnaW5nIG92ZXIgMQ0KPiA+PiA+IHNhbXBsZSBpcyBzYW1lIGFzIG5vIGF2
ZXJhZ2luZyBhbmQgZ2l2ZXMgc2ltcGxlciBiaW5kaW5nLg0KPiA+PiA+DQo+ID4+ID4gPiA+ICsN
Cj4gPj4gPiA+ID4gKz8/IG54cCxjYWxpYi10LXNhbXBsZToNCj4gPj4gPiA+ID4gKz8/Pz8/PyBk
ZWZhdWx0OiAyMg0KPiA+PiA+ID4gPiArPz8/Pz8/IGRlc2NyaXB0aW9uOg0KPiA+PiA+ID4gPiAr
Pz8/Pz8/Pz8/PyBTZWxlY3RzIHNhbXBsZSB0aW1lIChUU0FNUCkgb2YgY2FsaWJyYXRpb24NCj4g
Pj4gPiA+ID4gK2NvbnZlcnNpb25zIGluIEFEQw0KPiA+PiA+ID4gPiBjbG9jayBjeWNsZXMNCj4g
Pj4gPiA+ID4gKz8/Pz8/PyAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50MzINCj4gPj4gPiA+ID4gKz8/Pz8/PyBlbnVtOiBbIDgsIDE2LCAyMiwgMzIgXQ0KPiA+PiA+
ID4gPiArDQo+ID4+ID4gPiA+ID8/cmVxdWlyZWQ6DQo+ID4+ID4gPiA+ID8/Pz8gLSBjb21wYXRp
YmxlDQo+ID4+ID4gPiA+ID8/Pz8gLSByZWc/Pw0KPiA+PiA+ID4NCj4gPj4gPiA+IFRoaXMgc2Vl
bSBsaWtlIHRoaW5ncyB0aGF0IHNob3VsZCBiZSBzZXQgYXQgcnVudGltZSByYXRoZXIgdGhhbg0K
PiA+PiA+ID4gaW4gdGhlIGRldmljZXRyZWUuIFVubGVzcyB0aGVyZSBpcyBzb21lIGp1c3RpZmlj
YXRpb24gb24gd2h5DQo+ID4+ID4gPiB0aGVzZSB2YWx1ZXMgZGVwZW5kIG9uIGhvdyB0aGUgY2hp
cCBpcyB3aXJlZCB1cD8NCj4gPj4NCj4gPj4gSXQgZGVwZW5kcyBob3cgQURDIDEuOFYgVnJlZiBp
cyB3aXJlZCB1cCwgZXNwZWNpYWxseSBob3cgbm9pc3kgaXQgaXMuDQo+ID4+DQo+ID4+ID4NCj4g
Pj4gPiBGdXJ0aGVyIHRvIHRoYXQsIEknZCBsaWtlIHRvIHNlZSBzb21lIGV4cGxhbmF0aW9uIG9m
IHdoeSB3ZSBjYXJlIHRvDQo+ID4+ID4gY2hhbmdlIGl0IGF0IGFsbC4gSXMgaXQgZXZlciBhIGJh
ZCBpZGVhIHRvIGVuYWJsZSBhdmVyYWdpbmcgYW5kDQo+ID4+ID4gcGljayBhIGxhcmdlIG51bWJl
ciBvZiBzYW1wbGVzIGZvciBjYWxpYnJhdGlvbj8NCj4gPj4NCj4gPj4gVGhpcyBpcyBhIHNuaXBw
ZXQgZnJvbSB0aGUgaS5NWDkzIFRSTSwgY2hhcHRlciBBbmFsb2ctdG8tRGlnaXRhbA0KPiA+PiBD
b252ZXJ0ZXIgKFNBUl9BREMpIGRlc2NyaWJpbmcgY2FsaWJyYXRpb24gc3RlcHM6DQo+ID4+DQo+
ID4+IDEuIFdhaXQgZm9yIGRlYXNzZXJ0aW9uIG9mIGZ1bmN0aW9uYWwgcmVzZXQuDQo+ID4+IDIu
IENvbmZpZ3VyZSBTQVIgY29udHJvbGxlciBvcGVyYXRpbmcgY2xvY2sgKE1DUltBRENMS1NFXSA9
IDApLg0KPiA+PiAzLiBCcmluZyBBREMgb3V0IG9mIFBvd2VyLWRvd24gc3RhdGUgKE1DUltQV0RO
XSA9IDApLg0KPiA+PiA0LiBDb25maWd1cmUgZGVzaXJlZCBjYWxpYnJhdGlvbiBzZXR0aW5ncyAo
ZGVmYXVsdCB2YWx1ZXMga2VwdCBmb3INCj4gPj4gaGlnaGVzdCBhY2N1cmFjeSBtYXhpbXVtIHRp
bWUpLg0KPiA+PiA/Pz8gTUNSW1RTQU1QXTogU2FtcGxlIHRpbWUgZm9yIGNhbGlicmF0aW9uIGNv
bnZlcnNpb24gPz8/DQo+ID4+IE1DUltOUlNNUExdOiBOdW1iZXIgb2Ygc2FtcGxlcyBpbiBhdmVy
YWdpbmcgPz8/IE1DUltBVkdFTl06IEF2ZXJhZ2luZw0KPiA+PiBmdW5jdGlvbiBlbmFibGUgaW4g
Y2FsaWJyYXRpb24gNS4gUnVuIGNhbGlicmF0aW9uIGJ5IHdyaXRpbmcgYSBvbmUgdG8NCj4gPj4g
TUNSW0NBTFNUQVJUXS4NCj4gPj4gNi4gQ2hlY2sgY2FsaWJyYXRpb24gcnVuIHN0YXR1cyBpbiBN
U1JbQ0FMQlVTWV0/Pz93YWl0IHVudGlsDQo+ID4+IE1TUltDQUxCVVNZXSA9IDA7IGFsdGVybmF0
aXZlbHksIE1TUltBRENTVEFUXSBjYW4gYmUgdXNlZCB0byBjaGVjaw0KPiA+PiBzdGF0dXMuDQo+
ID4+IDcuIENoZWNrIGNhbGlicmF0aW9uIHBhc3MvZmFpbCBzdGF0dXMgaW4gTVNSW0NBTEZBSUxd
IGZpZWxkLiBJZg0KPiA+PiBNU1JbQ0FMRkFJTF0gPSAxIHRoZW4gY2FsaWJyYXRpb24gZmFpbGVk
LiBEZXRhaWxlZCBzdGF0dXMgY2FuIGJlDQo+ID4+IGNoZWNrZWQgaW4gQ0FMU1RBVC4NCj4gPj4N
Cj4gPj4NCj4gPj4gU2VlIHBvaW50IDQpLg0KPiA+Pg0KPiA+PiBOb3Qgc3VyZSB3aHkgd291bGQg
dGhlcmUgYmUgYW4gb3B0aW9uIHRvIGNvbmZpZ3VyZSBpLk1YOTMgQURDDQo+ID4+IGNhbGlicmF0
aW9uIHBhcmFtZXRlcnMgaWYgb25lIHVzZS1jYXNlIChtYXggYWNjdXJhY3kgbWF4IHRpbWUpIHRv
DQo+ID4+IHJ1bGUgdGhlbSBhbGw/DQo+ID4+DQo+ID4NCj4gPlNvbWV0aW1lcyBIVyBndXlzIGp1
c3Qgd2FudCB0byBnaXZlIHlvdSBzb21lIG9wdGlvbnMuIERvZXMgbm90IG1lYW4gd2UNCj4gPmhh
dmUgdG8gdXNlIHRoZW0gYWxsIDopLg0KPiA+DQo+ID5JIGd1ZXNzIHdoYXQgSm9uYXRoYW4gaXMg
aW50ZXJlc3RlZCBpbiwgaXMgdG8gdW5kZXJzdGFuZCBpbiB3aGF0DQo+ID5jb25kaXRpb25zIHRo
ZSBkZWZhdWx0cyBhcmUgbm8gZ29vZCBmb3IgdGhlIGNhbGlicmF0aW9uPyBJZiB3ZSBjYW4gaGF2
ZQ0KPiA+YSBzZXQgb2YgdmFsdWVzIHRoYXQgc2hvdWxkIHByZXR0eSBtdWNoIGFsd2F5cyB3b3Jr
LCBubyBuZWVkIHRvIGZ1cnRoZXINCj4gPmNvbXBsaWNhdGUgdGhlIGJpbmRpbmdzIG9yIHRoZSBk
cml2ZXIuDQo+IA0KPiBKdXN0IG15IHVuZGVyc3RhbmRpbmcsIGl0IGlzIGhhcmQgdG8gdXNlIG9u
ZSBmaXhlZCBzZXR0aW5ncyB0byBmaXQgYWxsIGtpbmRzIG9mDQo+IGNvbmRpdGlvbnMuDQo+IA0K
PiAgICAgICAgICAgICAgICAgIE5vaXNlIGluZHVjZWQgZnJvbSBQQ0IgdHJhY2tzICBFbGVjdHJv
LSBtYWduZXRpYyBub2lzZQ0KPiAJCSAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwN
Cj4gCQkgICAgIFYgICAgICAgICAgICAgICAgICAgICAgICAgICBWDQo+ICAtLS0tLS0tLS0NCj4g
fFNPQyhBREMpfCAgIDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08LSAofikgZXh0
ZXJuYWwgU2lnbmFsDQo+ICAtLS0tLS0tLS0NCj4gICAgICAgICAgICAgICAgICBeICAgICAgICAg
ICAgICAgICBeDQo+ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgfA0KPiAgICAg
ICAgICAgICAgSS9PIGNvdXBsZWQgbm9pc2UgICAgSW50ZXJuYWwgbm9pc2UNCj4gDQo+IA0KPiBT
byBPRU0gQSdzIGJvYXJkIG1heSBuZWVkcyBkaWZmZXJlbnQgc2V0dGluZ3MgY29tcGFyZWQgd2l0
aCBPRU0gQidzIGJvYXJkLg0KDQpUaGUgbm9pc2Ugb24gVnJlZiBkaWQgaW1wYWN0IHRoZSBjYWxp
YnJhdGlvbiwgd2UgZGlkIGdldCByZXBvcnQgZnJvbSBjdXN0b21lciwgYW5kIElDIGd1eXMgc3Vn
Z2VzdGVkIHRvIGRvIGxpa2UgdGhlIGZvbGxvd2luZyBwYXRjaCwgd2hhdCdzIHlvdXIgY29tbWVu
dHM/DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1paW8vcGF0
Y2gvMjAyNTA0MjMtYWRjcGF0Y2gtdjEtMS1iMGU4NGMyN2FlOThAbnhwLmNvbS8NCg0KUmVnYXJk
cw0KSGFpYm8gQ2hlbiANCj4gDQo+IFJlZ2FyZHMsDQo+IFBlbmcNCj4gDQo+ID4NCj4gPi0gTnVu
byBTPz8NCj4gPj4gT24gdGhlIG90aGVyIGhhbmQsIHB1YmxpYyBUUk0gZG9lc24ndCBnaXZlIG11
Y2ggbW9yZSBpbmZvcm1hdGlvbiBhbmQNCj4gPj4gPg0K

