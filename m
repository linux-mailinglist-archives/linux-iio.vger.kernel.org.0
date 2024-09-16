Return-Path: <linux-iio+bounces-9603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E31979BC1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ADD283480
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1574F5FB;
	Mon, 16 Sep 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UlFCQMxH"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141414962C;
	Mon, 16 Sep 2024 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470111; cv=fail; b=WFQCqo2K/ZCfBbTQ+v0JK7xkgt0rIdrq1NQWCR0E4MV/OF6WKwpbU3Cn5j1X8UUYyGd8CCL0M89Ain3QUDqSaSsL9eUZngghPKBprah+nEEgu4So3yaGr93c3HNG9kHx+9a/1VSK+QN00BqGjpDofHBBec0EUfUm+9GknZkC2FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470111; c=relaxed/simple;
	bh=or9eYAydk9AsvA1sFeA+8byFb+R+gUDkJ9XIAG9YYRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EavgHJ/RijFSjaBqbjR+LN8FOEFAdZ+qRiueuHqvDuxUoAj+lReB5juC2monmh3v3Wh6juCYXcnJdEZGFxcKjYSsExTpFXcfK/7S86oDwxQpKJxZl0PLGMd0pZAVfJIBbnZ40gBlfxhJJcjxtsyZELFqS/pLMNzTQV2/AYZ08eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=UlFCQMxH; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+nX3INBr6ihayniQrT92/FiNsY3QmpYlMYI9MKu3EblUs33LbK0x6qNJ+zxRN5h67FbOGrr/V5ngvRNjGKij+9uBrOj38SHN9O/wZnFpWXhrOljYKfW9xpASuTEoR/OIWwJDRn7fl7ThMWUFuO/awZFqOLNRVai8asNzZZy1fELCUNYa/kO6Ol4USaC7J6gTwvWh+IRPbLQBTJ1RhDLREAgCEYJcPivW+V9xVbMVZaebfAPMzDXErgJNleizi2Dhsl/TPeCIVJBjqZrpk8GM9D4jOYOLqT7t/X0xTmJJ9DXCz0WhYJrDiDR4gcsVw2Bs4FPQIrpGAIHN3tQZUC6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or9eYAydk9AsvA1sFeA+8byFb+R+gUDkJ9XIAG9YYRI=;
 b=qdhnBb/LkZxvJtWppgokKc6/CPEEReaiz+UgqbjPhCjufZRL8+Zcot/PZ3r2apTmwxVNeFDpeVKwIo3rI/gIwh3vfxZ9J/gHDIo/UDu+JO/+x4NjbLDnlU49orDXTCqQtD+JO4Ob0ifdKFgk7ZDpLjxW82AoYx0KnwR9JWncKiDW5r7ICAdbcKFWBFj0kwSzICTyiYYGC8ngAF5o8yxTYAfRTz4iknuO/Pb17JBlWK3RAaEpNEY4OgspvT5W5jSadG+XJL0ZB53/0YLEvtvl1KMLMDbREcy4NSGxKUzR3n9JDVgq5luYJTaARcjqYrpcrl8B2GRfxPPmaRXHzK6c/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or9eYAydk9AsvA1sFeA+8byFb+R+gUDkJ9XIAG9YYRI=;
 b=UlFCQMxHWjOZPAm/Q5sRa/oYqUiyEy6bz9RCpAx8ARzHCSnEL+HuHYx/B/JszB5SNUFj+iDNNcSB1lm9bqh1gA8PvLTUxm9SyfBlzTrzq+2VD50UcTc5R4QTywQx96hTCJmwc7qRiAIEGgDkRJI2ErSBd4d7G7l3tBoWMzrUO1Y=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DU0PR02MB10424.eurprd02.prod.outlook.com (2603:10a6:10:477::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:01:45 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:01:44 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>, "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Thread-Topic: [PATCH v2 2/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002
Thread-Index: AQHbBcNWU3Y28WjQjk2QRvUR6948I7JWBAKAgAP9CYA=
Date: Mon, 16 Sep 2024 07:01:44 +0000
Message-ID: <70d1f90a23e35da3dc12dc4425c4b53c816b2ca9.camel@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
	 <20240913-add_opt3002-v2-2-69e04f840360@axis.com>
	 <20240913-stimulate-swell-3964c45e6e81@spud>
In-Reply-To: <20240913-stimulate-swell-3964c45e6e81@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DU0PR02MB10424:EE_
x-ms-office365-filtering-correlation-id: b858b01c-54fd-4e7d-e72c-08dcd61d6cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDRIRTFSSDhreVNObU4ycTJoVG1Ha3g3Y0QxelNLLzBJNHNXalcvOXdSeGFY?=
 =?utf-8?B?S0phdFJPeWgxRnFHM2lJc0hKU3dpUFowSDB2bEpMcVNmM01qZk1Ea1pMcXYr?=
 =?utf-8?B?YlJ5R0V5WGZRanIrcTdwc2FZdGRaUG5SZEVQMm1LQmFsenJHRml4WUR3Q1FM?=
 =?utf-8?B?L1FBbERlMWV4QVlVU3FnRy91bk9CZkpVSWc1YmxoYmk4TDc0K0lyWUxWYTM3?=
 =?utf-8?B?TVpndXR6OStPL1c2REtYU0o2NWlTSjdSS1VrNFMrcGNFcDZiOFlGZW9FSy9N?=
 =?utf-8?B?cnVaTXFxZnJSTWdLUk1Bd1N6dGF5NmIyTlpTZEdYWWZtOUpPa1JlZktPYUhk?=
 =?utf-8?B?dTRIZk9NcEh0N1dWMDBnOGROdjQ5SFVkM1hZTEFidzVZSnA5cHhZK0xZVXpk?=
 =?utf-8?B?ZUh3L1I3UU1sOFRLZmJxQVh4WDM0MHBaSUMxdW1laGdndGVkaUZzV1B3TCtE?=
 =?utf-8?B?THVZenorSVRMN1FNNVdzM09PRUpvYmQzU3Q5V3VnOFF2ZDJzTjFJVDB2UlFp?=
 =?utf-8?B?MmMwWnZtd0xtQjMyYnRxcHVuUFhTa0JSckNkUFA2S016cjFhYzNnZUFSY0NJ?=
 =?utf-8?B?OUpqM2dYcTh6S0lXN3lQR0F2YVczVmR0RE5sZVY3aGV0SjQ0a0FVSXJhZFNP?=
 =?utf-8?B?TnRNQURYV0V0RDdpdkhPQkorSW9mQ1pvTTNDY0pwZ3RITmcwY0hISGgwMWNG?=
 =?utf-8?B?aTVmY21ycVJCdnpZazBiWXRMOWJBb1FTTUpGdHhqQXdGVzRRWnVja3h4Z2l4?=
 =?utf-8?B?TG1BTld1azlMYldidjVGYmo0ZTdvRGp2M0c4Sjc0enpMcTNNRUI3MC9JcFlY?=
 =?utf-8?B?QzdyVmFFRFgrTFFrY2xGcitGYytqSjJIbEd5VW9zUHdTeTd3OXVFYlFIZFRj?=
 =?utf-8?B?aVA1cmUydkdoeEJEMGdZYUZnL3FWdS9ObXRxMnhjTHBad2JlbFlXdzFCMTBL?=
 =?utf-8?B?THVLdTRSOWM4d2ZJNmg4b2cvZFdKTXdjelZpZm9hcWlhOUxYWFhnT1hyVFow?=
 =?utf-8?B?MUF6S2hjSnZxM1dSa0VJbTFqQVU5TlF2S2dJQWxpQnB5blNoajlwOXJLNlA1?=
 =?utf-8?B?bzlzVVVacjNsSzE3Z0NrYWc0YUVwWVlOcllOV2ZHQnRnRkJNUU9Yc2RXNll6?=
 =?utf-8?B?YjgxOHhlcktvQzlQVDh4M0hYUzFvcUx0Tks3d2lRR1JwaEl3RnRYcGQ4eHRB?=
 =?utf-8?B?U1ArR0d1SkZOVjRXdjFvaDdKdDJxNmF3cXV0QXhsemZaa050VHJSVTdDRmxF?=
 =?utf-8?B?Vjc3M3MxWlp3SEdqTU9PZVh2azl4VWtGQUtEOGY3TjZWKzdxN0M3VHFLOHA2?=
 =?utf-8?B?OVpQY3ZZWFRYZEdHSS84WVNvT0xSUVJlSElwbWRHNVpJQXNoQXpyY20vVHdp?=
 =?utf-8?B?TTRVMFMySThaMHpMcmt1QW51OUtMWGR3WXp2WVMrbUVxcjBTWVdrdmoza3pn?=
 =?utf-8?B?TU9CbitBd1lWamloSHR5cWRNZkg2azdyVFRNYWNtTEtZck5YbU90RXVHRzFK?=
 =?utf-8?B?QUs0VG1LTEl4eEp2Y2RRMG14WXh4RnJhdWUrbXRDcDRzbXRoOU9rL1RtZGQ3?=
 =?utf-8?B?SzYxRmZMRWl0aFVROExJeVBJSVB5aUdSeFprM3FNTjk0Wi8reVd4dm9lVkRD?=
 =?utf-8?B?bnM5eDBJTFl5bitMWDJzSDRlbk1hUW1Jb3E5c1dZYmhDUVhRTWltaklHZ2ln?=
 =?utf-8?B?a3p6VlUzbFB5U0RhSWFkcHZhTlRjSmFTL0NyZXRkRDdXd1hsV0Zwb1RKNVhY?=
 =?utf-8?B?ODdaa2xVS2Z1NXJ6Z29NeUM1NDNmeVVWMFVBcjBjamd1cnVWRUQ0NzhudjRX?=
 =?utf-8?B?RGVHM1BaZDF2dWxRQVdseFJBSnE1M2lFWW1JVUFpMzI3T2VkUEh6dnBVMkcz?=
 =?utf-8?B?MFhBRGpqTTR3cVV5Und1TFkzWkEzdDhOVmRjcDdOanBUSEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXlKRENqMzlwcHNkeUdpSnJVN3dmWG1Zbzd6VXlGaVQ4WlN6Z1FOMlh1VjV4?=
 =?utf-8?B?QUo3ODhlLzFOczA4U3V4dWlCV0FEOURua21zZzNhWlltUXlCNGpWNFZqelov?=
 =?utf-8?B?VGJWMlVLN1NIUUJVdGxLWDkzempGc3lvcFUvTHJYZ3VkeitXQ2ZmaWFOWlNr?=
 =?utf-8?B?b3lQTEVMM0NRUElOSnZJNU5TZXJVRko2QXNIZjVZa1p3SEhsTjUyUlZBUUxW?=
 =?utf-8?B?dTdEdysvU25OOEd0bll2ZmZ0T1VSNHZXaG1NSGNlTlgxSXJoYks0WUNTVnI4?=
 =?utf-8?B?SWZ3d2VDUGd6T3ZydjhJbzd6YkNldldjcG5vSlFkL0dnQkdvTEp4UDZITlM5?=
 =?utf-8?B?WGl0Q0p0dGIvL2szMDlZRGNhTkRzaFJWc1FFelVkTkJISU1aRnlYa3BIeWly?=
 =?utf-8?B?bGM0Qmdmb0psOTVhM2FIT3FqZUJuVmMrRjRJRXhhYW8zcUx6TS9FL05JQmk3?=
 =?utf-8?B?RUhBaERZZDJUSW1lbmNxNVV1QU9tMWhkM1JDNU5PZlpJL3dtK0FvTGVIem9O?=
 =?utf-8?B?NSswUlJUYTcrSStvWFRON3RQSWtDdUxjQzc1d1NoVERUbWhXUWorMThtTWVy?=
 =?utf-8?B?b2ZTTk9zV05UNnVsWjVLNkExTEVJcFlrbnZpaktzTkl4eU5nOXJmdlpVYWRH?=
 =?utf-8?B?cFpTU0EvcG81OU5OYVpycThHTGhXRWdUc3dxZENCR0dqZStFZzNHZk1JZFN1?=
 =?utf-8?B?Z01abHlFRnRLQlhCTFQ3eCtPMWg3M0tZVkIrUHNDN1ROVVBmYTJZZUdxVmNK?=
 =?utf-8?B?VWFTNUFZLzlISTU5dUdSaC9UaEJ1VElmNUhyaUFnTmx5QWgxSzR1c25vNFBT?=
 =?utf-8?B?VFRYLzYwMk42bWNyeFFOMXFsKzJlNVptUTIzbWFiL2F3M1ZrbHdyMDFiZ0oz?=
 =?utf-8?B?Y25vUlZlR2pQd0dRKzhnajFoZ2lKUzJldW94N3pPRjNwaWRNM0hLODg0N0Z5?=
 =?utf-8?B?YUZFMDBEZFVkUkdYRzlEaHdkS244WUtiMDB1QUNtVmZKcmEyc1pUZ2JXRkF3?=
 =?utf-8?B?dTBDYmJCUVF2SlI5aXgzVjJPM3VDcjhwVkUrNkR3aWR1aG5NTG5yTnBUb21L?=
 =?utf-8?B?U2FTWVVVUXVKUDhFbTA2RVpVVXhrU0hwYjBHSUszYitib1ViWEVEQTdmSHlO?=
 =?utf-8?B?VU5nL1dLNkdFajRCbUlxdzYzc0FZb0RpL05kaWNzbUdxcTFuYkFSQmxld213?=
 =?utf-8?B?eEZtaUlxODlCdndzTzh6ZS9MaDRSOGxoZFM0MUJSN0xmOG5JZm9lcTdPNW1h?=
 =?utf-8?B?ZTJjR3l0eE1sQXlobm1sZ0x4UGN3SE4zKzBkQlFFcjZGWU54bEsyR0JGN1BL?=
 =?utf-8?B?QjhhRnUwMzM4WWxzcXNtalNZaVNuZlNGTG9CRi8xTGdQOE8rdVdnKys4SlFq?=
 =?utf-8?B?bm00dmhUNmNaZEdISTMwMXFuR2Q3WWtCTWsraGZMZHViWWUvbVAzcXJTUkMv?=
 =?utf-8?B?Z2lDN09XdS9SZGdBRXV3VktoeEhZRHFOVjFqZEQ3VkxuNVFCb3huNmN3bnBC?=
 =?utf-8?B?NHhsWHRQT0FJL2J5RWdYY0JyZE9qV2QyTm5Wb2M3dnlJaFpNWktySGIrTjNW?=
 =?utf-8?B?TUZwRFNNd3VmdXFDZ2tPZHA0WWdydkZVaDIyckZNVWcrMGkwSjBIcmVMQUhu?=
 =?utf-8?B?MkRrdWtBdXFaVEl0dTVyUEVoS0E3a2tmeVlSUXNDM1QvUytQTytZUE9xN2pP?=
 =?utf-8?B?Q2ZESjJrSUlmRDNZaTlIb2M2Y2Z3SnpwN0ljWlZieTBjcnR6NnBWak9QZmhR?=
 =?utf-8?B?UDFQM0ZWZ1cxMUEwUFRzMmVUNkwzY3pLbnQ4b3lnSUVKZTIyVGRJUE42OXNS?=
 =?utf-8?B?UHo1M0Ixc3hSL3hPdlhKWmdKTFJPN1E1Uk02akRDaWQyL254MDVCYSt2c3hh?=
 =?utf-8?B?UEh0RkhzSUtXRVVFWW90TkcyL3hOOHRVU1YzcVFnSk90NE9rOFpTRCtUbnR0?=
 =?utf-8?B?NGpCL2ptUTR4SG9CY3k1VmtpbE9CV3cvZktqSnQrTXhkWGdSaFlQTGZzZEpk?=
 =?utf-8?B?VUZtMzYxVHB1cHUxVEpVZTRUSU8wczhGNVVhT1ljdWExTjcvNlNFcUU1Zmht?=
 =?utf-8?B?TkVhRzBhQVZTbkRXcEdJODhCTGYyMlo2Wk44NnlaOGZpODNaK2J4VUttdnNI?=
 =?utf-8?Q?rlEAHnSSnF9aioPsw9fCj4nW0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42DA1452D2E895429E36BE742C1280CC@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b858b01c-54fd-4e7d-e72c-08dcd61d6cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 07:01:44.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7k2ueiyx/aavWAucGzkDpSOXta9B0ym9ipzZgtPxfrzjj/NjRKOIbty1XrDKGWZj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10424

T24gRnJpLCAyMDI0LTA5LTEzIGF0IDE5OjA3ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgU2VwIDEzLCAyMDI0IGF0IDExOjU3OjAzQU0gKzAyMDAsIEVtaWwgR2VkZW5yeWQg
d3JvdGU6DQo+ID4gT1BUMzAwMiBpcyBhIExpZ2h0LXRvLURpZ2l0YWwgU2Vuc29yIGJ5IFRJIHdp
dGggc3VwcG9ydCBmb3Igd2lkZS1yYW5nZQ0KPiA+IHNwZWN0cnVtIGxpZ2h0Lg0KPiA+IA0KPiA+
IEFkZCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2Ygb3B0MzAwMi4NCj4gDQo+IFlvdSBzaG91bGQg
bWVudGlvbiB3aGF0IG1ha2VzIHRoZSAwMiBhbmQgMDEgZGV2aWNlcyBkaWZmZXJlbnQgaGVyZSwg
YW5kDQo+IHdpdGggdGhhdCBkb25lLA0KPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+IA0KPiANClRo
YW5rIHlvdSwgSSdsbCB1cGxvYWQgYSBuZXcgdmVyc2lvbiBhcyBzb29uIGFzIHBvc3NpYmxlLg0K
DQpCZXN0IFJlZ2FyZHMsDQpFbWlsDQo=

