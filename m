Return-Path: <linux-iio+bounces-20201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAFACD7C8
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294167A2087
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D31D8E07;
	Wed,  4 Jun 2025 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YZh5ats5"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AA12B73;
	Wed,  4 Jun 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017842; cv=fail; b=XoUyO7da7J8A5rjE2We3eOEbaLNBi9FiXfzIWW1oZRCLKg3Lj3CpXfhY/f/yxl8ZKqEdMpunPHULqeNBaQBLfWCNYDUeuVQlELkc5IJMAt25PCVHbnDpFtnvEgz8ZCPT7dlZti7mAKZ4Xv4a+6/+R5er3z3psZ2KBUsy1xwzDAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017842; c=relaxed/simple;
	bh=2RajOS6/1IFZYGJHHhhfhrKceW6Dly6GkcPlIIpBCRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RA1LBVAu+bkGjSW50+gtxdZmnlU7xaG5bA8MIsGGVPR8fl3qcDvW5sxsWjGWCq5L4sDh3kgsQ0C52UwfsiTTkg/h6gAv3lX1Fjdtmx0W9YDNI6Z2y7mpQ8m3XQMDNOEmL2h3jz+Sp54gXpECDIUD1j+eMf81D/I5e2USxIXGpUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YZh5ats5; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nluPVFmI5rBjJr3yCLcOZvf0GDLLN02CcubYAe8/1LUajQ85njGZB5mN0vDyIT26Oj75SGXoqPZmt5pw7QB9pLvWjtOKGv04O94+G6ePD+9QFE/+DrtPlOJ66VZNPMeuKUaijtAfFBMXSv3/AC2ITS6AdwKMEWyWr8eU2gQc7DHM31umCPYbjyrSAKO4XVB7F5F0zvjlEwZI+Ddqea0ukLKQNJtBrMGY7SrhO0WqTCqJOPgBL1y/XegwsAfvdDGz0CIkpOSIQZb+3ngspN13580VQ911nOZ/sgnRPidRGYlvuC4XrwBAqp9wD/WAKtP8BMiK9sWgFC6U5K/BaCHQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RajOS6/1IFZYGJHHhhfhrKceW6Dly6GkcPlIIpBCRw=;
 b=aYJI63TqLWumRL99/6ui0tkr9IxgNsLt8r32QN99Td5ZFnKWxYpSTMN41SMWxpj21KeSVZQKdAs1BQJqm+Lnri6ZfLIF/G0WLv/TVviBfmk0j9T0PiOkWmH5COvrzbZH5gye1++if3VrgXR8KhtG4/5Is/JVzWI4QCS77G7h1g6WSTggMRSz6WWunoAmSCOHWungt1uwq+T8NO+vy3XHzf8F2kOyXIuz3x8XbBwxh8h4thPR/NhvXveD3ro0EvGmWRkXsIy1M5Sg8dvYU/aCSXi5fr1ytgkdsXX7WsKzgsfI0p3Vb2QMK84rRsl63q/z8Hsi0uHuVWzaRzJu42S6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RajOS6/1IFZYGJHHhhfhrKceW6Dly6GkcPlIIpBCRw=;
 b=YZh5ats5jlGqe9Skvl+w8BDmqHEUeWRUBagAwXEizsISScvj2eJCoS+pl9I8Vh63KN/NxEOBhTXIaXIi6LeOu/27xjtnen9qwO74FT+62VsCmeCTXS6oyqJe2u7Jsi7qiC/wPzrCCgGjdbzal0S4FYHQ9rd5V8J255+0HWf0vRsEVGKC1+YpETaOYx+5VbG3g2c4Z4TS2IouCmhyVw6Z9TPx8R3Km3sueO9tM4aNMV/jz2D8NjptIxX/9PH6LWaqAZJ4lBWSN3O0dZMSbqgzs/kY4QIPsKhjxIkA6Axp3iBTNHM8Je1GqSH4zwrHKK9Fz9Eqbz6ZkYMeT1mZI9fl+Q==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 06:17:16 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 06:17:16 +0000
From: <Dharma.B@microchip.com>
To: <dlechner@baylibre.com>, <kamel.bouhara@bootlin.com>, <wbg@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] TCB: Add DMA support to read the capture register AB
Thread-Topic: [PATCH 0/2] TCB: Add DMA support to read the capture register AB
Thread-Index: AQHbz5eoRxwKaWCNoU2VSHjGz2Ho37PpvPsAgAjUj4A=
Date: Wed, 4 Jun 2025 06:17:16 +0000
Message-ID: <7e9d228c-62e0-4b60-ad65-b7e23f6ced8f@microchip.com>
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
 <b9b9aea9-e02d-4d5f-9f07-ef1c54e46b89@baylibre.com>
In-Reply-To: <b9b9aea9-e02d-4d5f-9f07-ef1c54e46b89@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: 9abfed56-575d-4f63-a6fc-08dda32f7458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGZzRSs5UVFDcTRidVBnY3dKVXY0L3krYVJNMjBIdmZmeml2UkF5K2Y0clJz?=
 =?utf-8?B?ZFRQZGUrSVc0bVNPK0kyQnAxQmVodit5S1ZRTm55OG1sd0d6dmxkSkkrR1hP?=
 =?utf-8?B?a29BTmVmcEIrOEs5K1phcHd6a1paWUhrM1U2T2FBaGhFaThBdmZnZXh1Q1ox?=
 =?utf-8?B?Q2xRSnBFUWp3ZzBMWjBxWkh3eHBxcGd0M0NHczE0dVhxMnh6ckdDUU9YUEs3?=
 =?utf-8?B?R1FwZnhNNzZkOWZGTkFiMDB3cU9KMlJaenJFSDBScS94S0U4Y0ZkTjhDby9N?=
 =?utf-8?B?SHRqNWo3NURDd1BFMGlkVkJZMkRSZUc3VTNGd1dMMHZLeFNTc2lmUTNYc0dQ?=
 =?utf-8?B?NFJVZzZvT3ZXMTh6Y3ZIbmU4OGZIRWs4azB3bFRpZkdJY2xpd0YvKzBBYWIr?=
 =?utf-8?B?anVIQlFIMTFyeGoyNUtmQS9XYTYvN2VjYmdMKzEvcUFqRHZoTUtUekNZOHBw?=
 =?utf-8?B?QW9TTlRMQm5HWWdHaGwzV2s5MUx6enJ3Q0xlL1NtODBraVRvdUtrWGNDbkhQ?=
 =?utf-8?B?Sm1aRDBUTlpBTUNRQUNZSWNndnJyTVF1MndCSWZvVy9xYTcxelRtMXV3NVQr?=
 =?utf-8?B?V0FZdllWYWJ1aHd5enFZZElmK3dtY29abzhRRVgwVTgvcVBWQUdaaDVEVkhz?=
 =?utf-8?B?dTcvRnF0WXJDUDNPTS8rQkR4ajB1OXU0ZTJNRmVmcnhISXZKektPb2tyQ1Fy?=
 =?utf-8?B?TVhZNzB3OHZjNzdzVmt3ckZGdStadS9rN2FzUU8yMDN2dDBLNmZVL1BQblNI?=
 =?utf-8?B?ZFpuN3BnREluM041SjBCbmpmTFhHOXAzQ2xUd3llZGZCUXFSWWZQU0lCekdQ?=
 =?utf-8?B?VTBzcGxoMkpaaDJLZHpLNFhMcXZqcWhZV245aUNYSGt2M09sRzhWZDlXUEp6?=
 =?utf-8?B?TGdIVEhLdVlydTd2eXNQQzNPU0FaQ1NidjF6dUVuNnlOd0MwTFh4eHg0d20w?=
 =?utf-8?B?S1g5YTByd1FVS0g2WHg4Z0N5d3VqYmI1S3NBdngzTmFCT2FTVERZNTB2bVlQ?=
 =?utf-8?B?WUtMTGppUkVjRlNnT2VWYk5odVF0MXRTNTJWZFB1TXNiVVFWa3FqSTcvT1pF?=
 =?utf-8?B?dmNhaVIyRllkY0ZjMkkvWXR5bGRVWnZFczc1RklWeWw3WlJEM1NJdW0wcGFO?=
 =?utf-8?B?WVA1MFdJMGVrNlM1cnEvWGtFdTFCeHVlNUMvdFRUNGRsNk1lVnB0OENlMEZs?=
 =?utf-8?B?ZklVSi9NWldDbWNvNC96S0w0TUVyL3lJMVpCT1F6b1dTRk9BZ0V4cE9WR3FH?=
 =?utf-8?B?K2c1Mkw5OGs5S2FaNjB6YTVmS2ErNVJIVTNQc1V4ZVk3elBRd2djVVBWb0ds?=
 =?utf-8?B?dWJGTGJFNlQ0ZFVoVmhqenp0aVNZcmM3Y3M0a2MrQ2ZycDdmSWVqNmRPc1JI?=
 =?utf-8?B?M2lGUlR2MDAzQjZlcUJBbjlkZ2dRbTdBQjFZaWo1cmEwdnczYTBQTGVpR0xT?=
 =?utf-8?B?WVZob2hranVIbWUwS0tkTGM1M1Y3TERPRmpQVHpUeFVOak9OaE5EclFra3pC?=
 =?utf-8?B?enlpK1Z2Y2lkR29WNmE1Q3NONHRwTkhzajJ4RUlPRE1FTmRGa3dndGhoK3dl?=
 =?utf-8?B?amd4a1p5SmUyWDBta2RwQTNDWHpDaWwzVU0rTGRodFRPSjlFOS9iMkU1NzdP?=
 =?utf-8?B?WWMzbnRMWU56cDg3YlZLN3dXUGdzVHZQTlQ3RVl6QWFBenNMbDNJbXd0M0c2?=
 =?utf-8?B?RS9zbGw3OHptVE9NRlFEVkVkSlk4aU9IbkV6Z1orQ2JrUGExU1l2OVQvbnM2?=
 =?utf-8?B?cExTYjdKRm9MMGtIVldnUVNVcFZ5dktrMGhkMkdZL1ozYlJCMGw1NklCNldl?=
 =?utf-8?B?SnU2TlI5dWNVUWR5WGl6dnFCRjMxMkhldFZLQkFIK2pySmhkdFRVWnhJNVhv?=
 =?utf-8?B?NTYvSW9JSFlSV0dXTDN0M0FLUEJUV2R6MnNWMkxiZVgyMGJobHRvRGlnbGNY?=
 =?utf-8?B?eEhRZS9yWkxrbTAwUnF1VFpHM3BGR0pSeTd2QzBVZGV5RGZncFBxQmZXYUtp?=
 =?utf-8?Q?9MpgDTKuY6qi4rLCAnw3kZPKJjRKvU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG9sWXEyTlNaY1R6NjZoVHp0cFJtZ2dNSUhBRURRS2ZtWXJOdStPQktqVzgr?=
 =?utf-8?B?cjNoTHV2U0NZVjhob2lqL04xbTR0cWZNOVNRS2ZxNzVHWVp1USt1TThpMjB0?=
 =?utf-8?B?d0JDR1M5RmNtK2NiMkljUkVnSTdjNEhnMjZETkRLVTAxQm9pWCtwbk94TE5K?=
 =?utf-8?B?WGZPVWs4VWtLSmtDclg5MndyZDR4bWVQa1h4eFpRQnBQaHMwZm1BQXJuaXZ2?=
 =?utf-8?B?TXo0RVo0VEd0a2JWVE9sYmg4ZUpYb2dXdldFQmdXL0dvczVkeTZTdE5kdUMw?=
 =?utf-8?B?bnRDSWx1cHZPMkg4VkNVRTBzM1dISWNBOHQ4c2tSZVVKNjdhbThCck5BU1JR?=
 =?utf-8?B?QXRlYmQ0WVJXWk5wczdoSDhSNHZwS09tTi9zWUdkeVlHMElFa2FIZjVjSnNl?=
 =?utf-8?B?d3JmTnAwYnlJY0lQdmV6eG5DNXJwVnlJbytUOGRBWE44WFJkcUJjRWE0a3Z0?=
 =?utf-8?B?T3pqQi95UDlxdG1ja2IwejVZaXlTQU9OVEQ5UlQxOEVPeUc3NmQ2cVAzS3VU?=
 =?utf-8?B?bGFjUkNvMWlEOGk5ZXZqeHVTOENpdllXY2Z5Z2dLaGYvMi81eFRMZkczZnJz?=
 =?utf-8?B?TzhneWdLUy9veU9Cd0N4R0o2YzRjeFpqWEV0aU5rU0RraWpvWWFHcnE1UllG?=
 =?utf-8?B?Tkd4eHl1Z1FOSm9vSEhHeGRVWEdVYnM3bGRSbUkrZnhUSHJHblkzclc4d2ZK?=
 =?utf-8?B?TFFLQlBCS2dBTWE2R01VZ0t3K1c2WXc1L1ZJWlhabzZ2VG9oQlUvZHd6dG0y?=
 =?utf-8?B?MEZjS0xRUE50bGJuRmQ3K2w4dnJhVTVJVlUwZURMRTlaclVVZUlKNmRLV0JL?=
 =?utf-8?B?eGtiT3grZngzVmdxenZ2UERtTS9JOE10U3B1TkhzQnhpSzU3Y0FKUHpHQWlR?=
 =?utf-8?B?QVFYaTZHZFdkSGJJMFZvT3FlenFBVUUydkJPM1lXdHZ5andsL3pEVGlNNWZB?=
 =?utf-8?B?c3pRZHVKOHZ2aFhDT0hBejR5NlZQOWtVcDhnSGtGOWdNbzVoTnlqaHhTUTRH?=
 =?utf-8?B?a0JvVG9uNTFoaTFKSFFNV1FKRS9ack1yQWk2T28ybGx1Mk9VS0JZVEFUTlNt?=
 =?utf-8?B?ZVFIbHlSTDJ2UmhwMjczaGZ2T2tSampkY1ZDODVYYjgwdVY1azJQVlFrb01C?=
 =?utf-8?B?RWE4SVIweUtBOThHb2Vlb2hKZjFlUUZHR3NuNDBPT0pkNjB5a3ZMZGZKQ3Zz?=
 =?utf-8?B?SUZuMk02L3U5b09MMUE5WTE1SW0vMGxmMWV1NnlrQk4zc0VjZmpHTm9zd20w?=
 =?utf-8?B?UC9kSG44RlU4SER2STFWa0VpRTl0dlVyUzh6Mm9DUFA2eHFCQ25ZWXJuc2p1?=
 =?utf-8?B?OWtCS2d2U00raE1FRzFFc3VYT1FXbVo3U2M2bVd0V1AvSmlwcjFEU3VXRGUx?=
 =?utf-8?B?NGVJT0dJR3U4R1BZNU9KSWRmZFM4S2s1WjdRTDYwU2hra213WG1ZOHBTM1hM?=
 =?utf-8?B?VTdWd0UyamE1S21MdjFNRnBTZm5sbWNralNvcVF6MlpPYXhJVnlSY3JNTktr?=
 =?utf-8?B?WFg3d2o5cXVob3ZGWiswQnFYd2dRTjJvMDR4RmtZTGVQUDU2YUtQa0pGdmh0?=
 =?utf-8?B?cDZST2NHaGhVOWx6MStXN2U1QlpuMGhmd0g0YkZIQlZ5UkpuSElhKys5dHZT?=
 =?utf-8?B?cDU3QzZEY0RqSHlOcGdWSHVHZnNrUTlpZWUxOVRJaDc5M2V6SU9nc1Bydmx0?=
 =?utf-8?B?YkR3UWZKSWR4WWJvOUJidnFSVkFaeGw0S0dSYnN4K1RGY1pEU2R4eGczd0ZT?=
 =?utf-8?B?ZHA1RXY0WTFUOXQyblRGcFprUXhLUE1jMm9ka2FlOWlBcGp1VG5oYkhQTk50?=
 =?utf-8?B?OWhwdUltMWl3VDg1V2tnN1RMTTZiby9xbHhYVFhTTzVQaHN5TS9id00xeng4?=
 =?utf-8?B?Q2JINHhnbWsvUGFoSHVLaFJUb3Z5MHE2bnBZaUJlakNNWjhKZVBhM2htZElj?=
 =?utf-8?B?eFNKNzk1K3hLczFiRk9KbUYzc2NXRmJHMkdnUWRUTXFQVzJEZzVIcmhhZFNB?=
 =?utf-8?B?UFFhbk5ad21TU3pOL1dWNVhRbG95NlNsczVQaVlaWmlMNm1IU1h3MERtTFIr?=
 =?utf-8?B?Mk03SU9DQzhydjFNclcxOVk1YnRyYlhnQ290bzNhYXprUEJMbEY4UlpaeG1q?=
 =?utf-8?Q?dFVkOfmfaC9mXMR0A09XIqwJr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4356CBD173005B4EA05B80430F9370D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abfed56-575d-4f63-a6fc-08dda32f7458
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:17:16.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYIeiD+WDaB24VbbtjiOWKn5DoeJw+8tPDtMH7DHpWylDvF+VDC2iKqGwf32EHoqbTR41gGjSNKD7CgHSW45iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144

T24gMjkvMDUvMjUgODo1NiBwbSwgRGF2aWQgTGVjaG5lciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBQbGVhc2UgaW5jbHVkZSB0aGUgY291bnRlcjog
cHJlZml4IGluIHRoZSBzdWJqZWN0IG9mIHRoZSBjb3ZlciBsZXR0ZXINCj4gYXMgd2VsbC4gSXQg
bWFrZXMgaXQgZWFzaWVyIHRvIHNlZSBhdCBhIGdsYW5jZSB3aGF0IHRoaXMgc2VyaWVzIG1pZ2h0
DQo+IGJlIGFib3V0Lg0KDQpTdXJlLCBJIHdpbGwgdGFrZSBjYXJlIG9mIHRoaXMgbmV4dCB0aW1l
LCBUaGFua3MuDQoNCj4gDQo+IE9uIDUvMjgvMjUgMToxMyBBTSwgRGhhcm1hIEJhbGFzdWJpcmFt
YW5pIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IHRvIGVuYWJsZSB0
aGUgRE1BIHN1cHBvcnQgZm9yIFRDQi4NCj4+DQo+PiBXaGVuIERNQSBpcyB1c2VkLCB0aGUgUmVn
aXN0ZXIgQUIgKFRDX1JBQikgYWRkcmVzcyBtdXN0IGJlIGNvbmZpZ3VyZWQgYXMNCj4+IHNvdXJj
ZSBhZGRyZXNzIG9mIHRoZSB0cmFuc2Zlci4gVENfUkFCIHByb3ZpZGVzIHRoZSBuZXh0IHVucmVh
ZCB2YWx1ZSBmcm9tDQo+PiBUQ19SQSBhbmQgVENfUkIuIEl0IG1heSBiZSByZWFkIGJ5IHRoZSBE
TUEgYWZ0ZXIgYSByZXF1ZXN0IGhhcyBiZWVuDQo+PiB0cmlnZ2VyZWQgdXBvbiBsb2FkaW5nIFRD
X1JBIG9yIFRDX1JCLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IHByb2JsZW0g
dGhpcyBzZXJpZXMgaXMgc29sdmluZyBhbmQgd2h5IHdlDQo+IG5lZWQgdGhpcyBjaGFuZ2U/DQoN
ClRoaXMgaXNuJ3Qgc29sdmluZyBhbnkgaXNzdWVzIGJ1dCBJJ20gdHJ5aW5nIHRvIG1ha2UgdXNl
IG9mIHRoZSBmZWF0dXJlLg0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1h
IEIuDQo=

