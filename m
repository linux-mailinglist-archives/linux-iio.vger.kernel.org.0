Return-Path: <linux-iio+bounces-8441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279C9506E8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49278281E45
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF819CD18;
	Tue, 13 Aug 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="L5wY97Uu"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA65199E93;
	Tue, 13 Aug 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557251; cv=fail; b=B2WhHTOa4UnLKrnu30UVclrb1p4rWi2mjwQx+icHqNbsGvlXfmrFfokn3hhpjP2Js5jUdDu0zRPyUes86yBmulx/yKQTcNEk+497CjfwzaCrZYG7d3m+WbQhM/iMD8FfNO7pgWVJEq6dTtnMfyySfHEylcIWZBpHny3oJKsBbRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557251; c=relaxed/simple;
	bh=LPzTNrCyyaegaDCqhD9JBbHdURWTkxuQ4hR9v8hLJyA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upU6/LVWIoO5tuIWzoyvnptDok6pjyWdSvUUyBnmdonOOAsq/RCOYY/aflB6WnQm0lsPr0fj8rAuA50KL1CI22UohMgnRn/7Rza3b221+sJAqtlNpRTRIVGg+woKVsczzdjvbpV0FFQ7N2xK4q5mmqr1Cte6zhR21H9XdAt85hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=L5wY97Uu; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZzW0fEL5ZVNMIKhc47sxvVNCbXq4dWGgxWT/b1ultLyqvPZuwXHfbRqSDxsPXe9WaBl6fKMakNe5wv9rqHptJqm3lOdO32IvvaX0yFwI0bYE2aBdtRTJIfZq4ngM4+PRd+us0vI1vrD6H1TAte8x6vCNfGr/Kx7xmN99rIk7jfgmmml0YQe9oeCj5QtckjWXiPmZ9IyIVKbGTkpAAek4z/vpAHvuIORKDvlEcqBZGHcXz3Ox+aNBoYtpxxat6KnGuRtaJCozAcppPeKZgyfya/jguMPu1mL1c8oQJLLo4bOQoCIVQ60XhPIDCydih3OkNuJrmRryvxEgCnIvuMBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPzTNrCyyaegaDCqhD9JBbHdURWTkxuQ4hR9v8hLJyA=;
 b=gJJLYRCuxHrplOcshf056XdWlcL1kxE1dqatXYYUdOUenO4s5h8+yIjtiCTqG5JWvzwiwKG3WVkZ83VK/u2WkFQyQEDv563RSZZSBbAA6CbYdRIMvG6TqlSJGb0V1/N1tQ38PlIHM6akXal5qtvOE1zMu6eGTfkI9b1OBehxmBnJjo4Y3b4LbniEWslTTZAJ88+KjVU4W5PGHZUR/aRs6WZUTMKDB5wQi7PJTMYKcZuE9E6HpZUCFJQQVZ+rglpUmd5QC0F5KFrDNTC37om4TCe4FyJXsiNIhTkslPQZYdMNQkWhWoTKwxCHeM0cqYf1X7vty0lUY4A2CiThAvmUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPzTNrCyyaegaDCqhD9JBbHdURWTkxuQ4hR9v8hLJyA=;
 b=L5wY97Uukxq2sUVGQvXL07WWL0ocjTOSttJcvyuuG3TyT0P2oLasde25vHlJdUIjQwx8e3LwBbSaXa5XKHiHbTHb33wZ3WQoxVEkqmvK6YWAhPkSCHWNbvboqp23o3GeXGDjbgwCh3ETOoC7cmsapubvSAx95e6bY5XERSe48yJBzE/T/qki8yDDwy/0oi+C6n94tFm6t0CN+KxgxTH0N4eOp4laNhmFOR+OHNeNKABKWfY1OL2DVamGZQY4U0ILgRi8Y2uYTyDXkiytalTietYNgWU/IQgfM4IHzlpxB6ckWl0tPLl8c8aREtxdotzguuaMWUfBcwX4WeS76KaEwg==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DU4PR10MB8466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 13:54:02 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 13:54:02 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index: AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIgcW+AgAR0C2CAABFFAIAAQhZA
Date: Tue, 13 Aug 2024 13:54:02 +0000
Message-ID:
 <AM8PR10MB472146AA446E64C63DE3BF31CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <bb33aeb0-7134-45ec-8536-47c524ec9e4b@kernel.org>
In-Reply-To: <bb33aeb0-7134-45ec-8536-47c524ec9e4b@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DU4PR10MB8466:EE_
x-ms-office365-filtering-correlation-id: 325357ac-b64b-4883-895a-08dcbb9f63bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3hnM2Qxa2xkcHVUUWdvRmE4cXpHVW9BU3ZsZUJEdHhwRUN0WDNmSlk2R3Bo?=
 =?utf-8?B?UVpyVlMrallSMDJxa2RoMnJHdmZERXVtUUQwTjRTUm5rQ2dBd004R0ppOXF4?=
 =?utf-8?B?bkhvek9uU2RVN3oyMFMwbTFUQkhZam9QdXlsNU5XMytwSDJqUTlyR1lvaDlF?=
 =?utf-8?B?dU1jWmhTSnRtVTM3SEtUL0lsT2p0aVFFc3cwSzU2dk41eGFrNXBJVkpySHNZ?=
 =?utf-8?B?QWhpcXRJRnhpZURWVnFxMDJESGhoQkZNQnhJVFhPYXBGcDhnUDBxQUo4eFE3?=
 =?utf-8?B?YWkvNWN6YWd5emRSODhsZWhUbFVJT2xpYXhJd2N1dkgvZGZqWVZrMHVIcXJz?=
 =?utf-8?B?NUVRY0hNRWY4b3FDQ3gwb3pzYTZWRGtYTjJmOUNLS3FraTZkMEdtZkQ0Z0Vi?=
 =?utf-8?B?bEZOWDljaEVsNDZwSjVKazBUb1NEa2NhbzcxMXU5MnVUeFNCMnNxSjhla1px?=
 =?utf-8?B?Vlpyc25zSDdzZlJaRkhoZWhBM2ZlRmlPOFBkL2pLOG5VRjBFOWRMZzRUSDVI?=
 =?utf-8?B?QXVNQWNQNGRqOUJLVXF0TENxUFNjS3YrR2R0Ris5YSs2UmpVMjUydDhYUE1B?=
 =?utf-8?B?dWpRMEtZbXR0VGljVG9jZlYyejZISVRTNU1BVXYwd2ZNRXZEaWV1cHc1L1Y1?=
 =?utf-8?B?M2lScUNOUHRxMUFHY2g2ei9NZ1Q2bXMvS1ZFU3Z0VDZPMlVjZm90NElFT1R1?=
 =?utf-8?B?dDBzMGlVMEFyMlBmRTN0dmNXb3BUUHBKaEpKc25DL0QxamNacGJOS01UN3h0?=
 =?utf-8?B?Z0pOWHdibVc0dE1CRVExSUQzTDRWZUpaYUtlMlJ0K2JWbjYzN0FzVUZ0NVZH?=
 =?utf-8?B?QUNmRGtBK0hydVRKekUvMVowMWNXVUR0R2UzbkRzRUNLM1lIQjdmeXB2T3hY?=
 =?utf-8?B?SGRydWt4NTUzemtIOGw3OSs4bGZBbFdrQi81ZXFLZlZTWDNQb2VDTy96b0sr?=
 =?utf-8?B?MEJxUWZHanNpc2I3T1gwUHVmMkFxTnRTMmluTndXd05UZ21JekZ2ZG80YXlr?=
 =?utf-8?B?djVvRVVHWEl6Z0swcWNOeHBCaGgvQWFvdEQvL0hDNmo4ZEdrdTNKVmlubHZt?=
 =?utf-8?B?TnB4c2ZGUUp6ZTVodnR3V3gyTkw1dHNzUythckZsNmZpWW0vRWFlMGp3Mk1y?=
 =?utf-8?B?RmFQdCtnZk4vUytqaVFqL0E3bU5VZ0dLRWNWMU1VQ0VSaENlT1duR3Z5SUdw?=
 =?utf-8?B?SG5hOEhjbGY5TXNTbXVJdFB5ZWJKS1NaelAwWHlEYVZONElIOVdzWjh3Ukpu?=
 =?utf-8?B?bVhRbUZPNVNXRUs5eEhObW9weFhuR3R2ZGdGZSt0Rk1qaUw5bWRDRHk3SUwz?=
 =?utf-8?B?MG9ZazVqRFpOVkc0QmMrREVHTGl6ZGFBa25mTHZKSXdWM3NoZlZnTDFsWWhG?=
 =?utf-8?B?bTRIR0xoSTlwQWFudnZPSHQ1YUlLdGNnNDFWd0ordnZRY2creGlneU84UnlK?=
 =?utf-8?B?dGZLQVZIcXI0VkxOT0c1eXVUOXczc2R0N1p4ZTVQcjJLU0VvWDRrWUFrcEJv?=
 =?utf-8?B?WGdqSjJHOTZyb093SFhaWjJNSmxQV2xEUGd2b0hYN0ltejhFRHAzSmd0YVFW?=
 =?utf-8?B?ZS9wK1EyeG4rWnpjajBCK2dnR3FqdlZweTFpeDhlVDBvUGw5OTVHUWkxSnc3?=
 =?utf-8?B?VEl1M1BpdFFzUmRXa2tIMlBBUTZuQTFJd1dJNXV4b3d2eWRCTHlreFBpbzlV?=
 =?utf-8?B?dHlzZmpZQ3gySVd1Tm1yQnNtUEtHbjExS01zZ0V0eW5kcWhNT1JHMHBsa29U?=
 =?utf-8?B?dDhtbTZxQkpRNW5ic3dUOFRRaTVMTlpJZWIxSEZSN3Z6TUJTUjFZdGV6Ulkv?=
 =?utf-8?B?U2g2eUZtemg5QmlTRVZPRklPK1ZEVVdFTjZUSHEwUUxpdFRNTUxSZ0FTWCs0?=
 =?utf-8?B?d2FkZ1dnN2RaR0lrRitWZVlzd3VCdWZxZXhqRXJrVk9xak1uSG00azA0MDVQ?=
 =?utf-8?Q?1CmsCNnl1uE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXBMWGFRT0FIWnRQTnNGYnJWR0UvWnBDQXdwOXhDaFJzc1BVamxXR0lUVDRa?=
 =?utf-8?B?QU1XU1NuK05qU0RsY2tzV1ZlNVVJQWJ1cWpVcE9zMXBtNmp2Vmd1bGpVekkx?=
 =?utf-8?B?eFcrM3lFUm5wSmpIU2NrZVBPa29mL3FITFEwMHAzZi9oWHhCc3c0dFMyTWF1?=
 =?utf-8?B?K3JUcldGQ1BGMVdzVHZ4LzgzNS9qSUN5cEc5NEp3U09xamNRUkZ1RW1hV01x?=
 =?utf-8?B?T1ZGOHZNZXFrMStFVnJWZFI4UTF1TGlZdDRLeW5nNmhjZkx2c0NwRUc2VGU5?=
 =?utf-8?B?QkpnTms5b1M5b0o2T0NFSFhTL3VwdlpENVpkc0JzSWd0S1JRUk1FTzFXNHRI?=
 =?utf-8?B?dEJqTXNJRnp1QldMTVVNeCtLWmUvYnZhKzdUemRwRm9HOFZTTDZMQWVuY05E?=
 =?utf-8?B?djJ6RUNSaGttVThRWlkraTA5aVpKb3lCZnBEU1JTUVphS0hvb0t4OENzN3JQ?=
 =?utf-8?B?TW5nZ1BTYmxKSiszRWlneDU3VFltL3hXMWFYMitzOS9JaXduc2l4b3RBMXZZ?=
 =?utf-8?B?OERtc2l1TDBMM2RCbmVYUjgyTnZpY1hudWk1N2RXTmIxM201aHllbmN6bWM4?=
 =?utf-8?B?cm5OaWpvQjVXalp1WFdKa2Z6SlZ4VjhIVE5VRk1nR3JxVlE5VTlTMExVdlFj?=
 =?utf-8?B?Q09ZMlkwY004ZFh4WndTM2FFQWt1RW94NkVmaytKckRKbmwrUHdEL0w1OVBT?=
 =?utf-8?B?cWJpc3NmZDFtTUZ1dzdGTGpNb3dEam5UNDVVNERicHV2b0VNbGtBWkp5OEZQ?=
 =?utf-8?B?dTVwbDl3RWFEaFRmRjdjKzE0U202U1BTQ2U0UFFMb0lpTDY3T2lHN0djcWpu?=
 =?utf-8?B?S3d0UlFuS2RNR3lZSHJhcURPQkdBU0k5d2NwcVVMS2JuREVpaVNlRFVYSnZT?=
 =?utf-8?B?cVk3T3ZUcklKNS9halovZ1hXSmJuNzFjOVNlMmxjamtxckJhSUJYR2JFVVZJ?=
 =?utf-8?B?QVpVelppdjFNS1JBS2FDMFVvOFF0NnpzYVoyUzNuOVlZeXB2ODNGVTZXSXNx?=
 =?utf-8?B?S0tVNFptMExIQlFEOU5wcGlzWUhpbDkyODh6a0NRTXVTM1ZROVlzeFczNVhW?=
 =?utf-8?B?TG01SGpxTWNPQ2VoMWZhb2FKM2xvWllQNXFIdlArOURTam9EOEprRmU5a3Jk?=
 =?utf-8?B?KzAvSlQ3dkw1c3E5SzVYaGN2NitucXBGL2NlQzB6NGlwNTlManpLUjNuR1hv?=
 =?utf-8?B?UCtQWFdFbGtEZ2w0TWdqMjYvQWR0Z2IyRCtSVUNIZG8vaUM4OVRKMTdVTjgr?=
 =?utf-8?B?ME0vV3NZK2EvaUs5eDZMSXIzWkM3SnYxd0lKU2I0eWFSSHdqNHNuNmZseE5J?=
 =?utf-8?B?TjE1SjJ1L2hXb0kyWWlMcG1BNGlLSnJLSG0rMkxZd1dQRGdRWlFPQUprR25l?=
 =?utf-8?B?L3VvZjY2dVJLVHdERU1xUWtUSEViVUdaa05sRDdHZ2gzbVFBaTd2bXBKQm8y?=
 =?utf-8?B?YkoxNVhLaHM1ZGZ1bit3RWRsN01WWjZXQ1NCQ2U1d1J1WkRpY0ZOWXdsWnlW?=
 =?utf-8?B?cnBCVGd2RUJaYmxyV3phck1kVEJwWjlWOCtGdFBFYmpBQXJZR0pGRTcrdUQy?=
 =?utf-8?B?NTk5SFE0MnpsemptdEtuZDRvZjdSM3d0anRhMVJYNnV5NW5pK0hjY2d2Q01W?=
 =?utf-8?B?NTRaWUVNODNPcjFUcXY4eDJqa0E1cWxYZG5QQXVyTXEySVVIYUpKWHM3Qk1r?=
 =?utf-8?B?ZGxwMTg2MTA1UFNrQUdWbFZQTVRDU05lbjNhd1hwT0pYT2NEeC9RcmJ3Rkoy?=
 =?utf-8?B?azFEUStORUJMcmtmaVE3dytyTXAyWlZzSFNEdk1pSG85UlJaSXNLbm91Sjhp?=
 =?utf-8?B?N1hZbGtLV3RrcXJyNWk4OFdBOFZqbUV4NVd2clp3ZEZDUkpWWUo4cTQ1RjJY?=
 =?utf-8?B?QUZNdFZtcS92MWsxeU5KTE95SVlhRzBYKzNTZkRiTmgvUXAyVDdDY0FiL0NQ?=
 =?utf-8?B?NkdicmE3RS9GdVhMQVlnWEpkUnNlekJkbWhGZ1NyTWNmTjRxRUljZ3BOWDN6?=
 =?utf-8?B?SVdMVGh6V3U2K1psTkRsRW5wa3BhcXZ5OURId2VsRndzcUUvV2lpcEUyUUto?=
 =?utf-8?B?b044L0lGMXRiOVEzbE9PRXdqanlHOUxBVXlPdkQwMEM3ZnZ0cldUQjg5c1Rq?=
 =?utf-8?Q?7rFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 325357ac-b64b-4883-895a-08dcbb9f63bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 13:54:02.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/bbUIptMAkyu6MreuUUElo+WogVNlqNsT9pTqkJ0sHxc6Dz8XHSZtt33mN//MKGTS/174hPsPrAufSmNThebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8466

SGkNCi4uLg0KPj4+ICsJcmV0ID0gcmVnbWFwX3JlYWQoZGF0YS0+cmVnbWFwLCBTTUkyNDBfQ0hJ
UF9JRF9SRUcsICZyZXNwb25zZSk7DQo+Pj4gKwlpZiAocmV0KQ0KPj4+ICsJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgcmV0LCAiUmVhZCBjaGlwIGlkIGZhaWxlZFxuIik7DQo+Pj4gKw0KPj4+
ICsJaWYgKHJlc3BvbnNlICE9IFNNSTI0MF9DSElQX0lEKQ0KPj4+ICsJCWRldl9pbmZvKGRldiwg
IlVua25vd24gY2hpcCBpZDogMHglMDR4XG4iLCByZXNwb25zZSk7DQo+Pj4gKw0KPj4+ICsJcmV0
ID0gc21pMjQwX2luaXQoZGF0YSk7DQo+Pj4gKwlpZiAocmV0KQ0KPj4+ICsJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgcmV0LA0KPj4+ICsJCQkJICAgICAiRGV2aWNlIGluaXRpYWxpemF0aW9u
IGZhaWxlZFxuIik7DQo+Pj4gKw0KPj4+ICsJaW5kaW9fZGV2LT5jaGFubmVscyA9IHNtaTI0MF9j
aGFubmVsczsNCj4+PiArCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShzbWky
NDBfY2hhbm5lbHMpOw0KPj4+ICsJaW5kaW9fZGV2LT5uYW1lID0gInNtaTI0MCI7DQo+Pj4gKwlp
bmRpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+Pj4gKwlpbmRpb19kZXYtPmlu
Zm8gPSAmc21pMjQwX2luZm87DQo+Pj4gKw0KPj4+ICsJcmV0ID0gZGV2bV9paW9fdHJpZ2dlcmVk
X2J1ZmZlcl9zZXR1cChkZXYsIGluZGlvX2RldiwNCj4+PiArCQkJCQkgICAgICBpaW9fcG9sbGZ1
bmNfc3RvcmVfdGltZSwNCj4+PiArCQkJCQkgICAgICBzbWkyNDBfdHJpZ2dlcl9oYW5kbGVyLCBO
VUxMKTsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBy
ZXQsDQo+Pj4gKwkJCQkgICAgICJTZXR1cCB0cmlnZ2VyZWQgYnVmZmVyIGZhaWxlZFxuIik7DQo+
Pj4gKw0KPj4+ICsJcmV0ID0gZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKGRldiwgaW5kaW9fZGV2
KTsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQs
ICJSZWdpc3RlciBJSU8gZGV2aWNlIGZhaWxlZFxuIik7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIDA7
DQo+Pj4gK30NCj4+PiArRVhQT1JUX1NZTUJPTF9HUEwoc21pMjQwX2NvcmVfcHJvYmUpOw0KPj4+
ICsNCj4+PiArTU9EVUxFX0FVVEhPUigiTWFya3VzIExvY2htYW5uIDxtYXJrdXMubG9jaG1hbm5A
ZGUuYm9zY2guY29tPiIpOw0KPj4+ICtNT0RVTEVfQVVUSE9SKCJTdGVmYW4gR3V0bWFubiA8c3Rl
ZmFuLmd1dG1hbm5AZGUuYm9zY2guY29tPiIpOw0KPj4+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkJv
c2NoIFNNSTI0MCBkcml2ZXIiKTsgTU9EVUxFX0xJQ0VOU0UoIkR1YWwNCj4+PiArQlNEL0dQTCIp
Ow0KPj4NCj4+IEhtPyBIb3cgbWFueSBtb2R1bGVzIGRvIHlvdSBoYXZlIGhlcmU/IFdoYXQgYXJl
IHRoZWlyIG5hbWVzPw0KPj4NCj4+IFdlIGhhdmUgb25lIG1vZHVsZSwgbmFtZWQgICJCb3NjaCBT
TUkyNDAgZHJpdmVyIi4gQW55IHByb2JsZW0gaGVyZT8NCj4NCj5ZZXMsIHlvdSBwdXQgTU9EVUxF
XyogdG8gaG93IG1hbnkgZmlsZXM/IFR3bz8gVGhyZWU/IFdoeSBpcyBpdCBuZWVkZWQNCj5ldmVy
eXdoZXJlPw0KDQpXZSBwdXQgTU9EVUxFXyogaW4gYWxsIHRoZSAqLmMgLCBqdXN0IGxpa2UgdGhl
IG90aGVyIElNVSBkcml2ZXJzIGFscmVhZHkgaW4gc291cmNlIHRyZWUuIFRoZXkgZG8gdGhlIHNh
bWUuDQoNCg0KQmVzdCByZWdhcmRzLA0KSmlhbnBpbmcgU2hlbg0K

