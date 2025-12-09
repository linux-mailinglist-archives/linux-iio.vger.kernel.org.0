Return-Path: <linux-iio+bounces-26975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E622CB075B
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E9D430D283A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7322FF672;
	Tue,  9 Dec 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="NkdvjBKb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022091.outbound.protection.outlook.com [52.101.66.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01F27F759;
	Tue,  9 Dec 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765295267; cv=fail; b=MjV+ANkspTz83l46sML2/+zD4cBn11owCAh8kDc2xVU1/aisjcHICkFWJUJ4zKO305iaRO+dnWFm8C7UsKOx9cHA8sO5fz0NGkLui8Zz6lV4SXqbUfaBMwCrH5AJ/Ugm+8t1f6yjnVJ7uAHWHAGn2enZjIYzEV01e+amQfKK/DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765295267; c=relaxed/simple;
	bh=qz9JDfSWeIclZ1n3gEl0RWGzPKjnQ/UClUOE2WtOqQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RG5zJNOWOB5vN8Y768juAlwfocdNO9wfSKmRMXCUsbsA9WL7KJGLj7GpljFadKVmyEYmgxK39/YnaiVD6eRFJBYx+tSmV1M8LgQOl4yauVKoN7r0r8eH8ESnWKTMAAzTZTWItqiqWSg7iu/JGqX2/NHzsveEq5A1zmwn91kf604=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=NkdvjBKb; arc=fail smtp.client-ip=52.101.66.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd8mGc4p3dS0UqoTqii7RAipazlkDabm1xArOf4jeEubuAJRzbsJOGmR+7BiWwoQ2ISR6TwVHkbLy//YtUIsxUsVhUrU/1tTRNilsP2Ck7jdwUSAYRxgmx2KnMNXXHo4n4fXpaDyPmAhfqagTBp4bX9xT/NwLTSLGUlUwmW8Vgs7yqtbfDKrDMM4Q8xAXjWkXB0GY2XVqq2CqQd8lqbwz3RjS74hGOGLUEWtMZkOY2ePc+ih6sVPVGzce0lq/lCBNjDj74amuUXyfTQXxSvxhX429M2gm5FXQP2spN5eYbPeJIsWK+wAnQZyyC1mqDzdr8UsysEGJ3G6m75p6QWVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAiVMuG8Epna+Q6krFxPMcVvUYSCC3mpaZ021toLkhk=;
 b=h57kOg9BkW5n2zhLuo1PiufyGVlwF5fmP3A1nD6QzX7EAmp56jVB+mkkKYxuq96+GiiybMr8y5Bem6S0EXRKLpYxeEbQlzaX+PC/FGwSUEZgnTtOj2SusCad8XyxclbKuiOHbjGYB9krXZb5r2pOxU/p7IuQHr2kD9fTSIcwWWQhEBVy4nr1Vvqr20USwthX+0MW+5n5rErFbfJac7VKZ3BZizQJBQC27w08SfrDkVS265zhu6lMdoETEuE48Svf7hnRq0YX7hey+heA+9kxSm7XBboarkFXL5JpL1V9sae8pZFdRwWCjvAxr3Sl616p/KnkndrFAP/FjSAFnOeefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAiVMuG8Epna+Q6krFxPMcVvUYSCC3mpaZ021toLkhk=;
 b=NkdvjBKbfjKc7cq9rW613OmjjaToNtk/Mpyo6G/Od7FiX2xUOQzLIm/S8Op/fhY8GXXG5CCifeu/Fb6wjYgCYaEfUYIDhK2RezcTyAebwfsuBphKzzbX5OqJ6kkvRm9FbKh9uaPK5rXXOGpUeWBsHP8g4nSJO4H7wMs3Rl5PWr7zw5UD1QBQtiWFY1CJd06aXGtI/5cUZck33QDoiIWRINPy0siiYrFWldo/IY45tX8NrzCWFb2Tu3+DY6LtAi0u6IRdEcnDy7iJ349NTod/Dof6p++WMr3YdM1++FvBL8KJ3YR1GOMDfCKRcd/20NIg+7+Khj5MAz8UP0rheT2oUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9536.eurprd06.prod.outlook.com (2603:10a6:150:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:47:37 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 15:47:37 +0000
Message-ID: <7a792f4e-edba-42f3-bcc8-76004972c2f7@vaisala.com>
Date: Tue, 9 Dec 2025 17:46:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: ad9467: sort header includes
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
 <20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
 <CAHp75VeOZHvxr60R0TCS5_c-xsrmfC97gWdP4-EWvFPpbodLTA@mail.gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <CAHp75VeOZHvxr60R0TCS5_c-xsrmfC97gWdP4-EWvFPpbodLTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003836.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:1f) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f43bde7b-c378-4ced-1685-08de373a4758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFpubVZHZFQ2RG8yOUgwMys3Q2QzSW9nQTU0UDVjam9rYXZzQ2JlaTN4QmlY?=
 =?utf-8?B?UjFrTDdJMkxVRjhsVU4xVVAzWmdaTmM1T0h3VGxIM1lLcmZ5U0dPK0VsUmtM?=
 =?utf-8?B?MXdDSkppN3AyNlBUTFRSOFFpWmZyc0Y1TUJVK3g3NWx1WW9ObVpUNTVWcnlC?=
 =?utf-8?B?TXZOSkxHZ2VBNlRoR2M0WmowTkhYSElmY0l4MjB6a0J5MjMxYU4rUnErWnVW?=
 =?utf-8?B?MU1PbEhYYmVpR1MzSkphOEVqanIvcmZob0hWdEcyV1JyTUJ2Rzc3bHRYdFFD?=
 =?utf-8?B?cWl3cUd4K0tCelpvN21rVXlrbTN5YTNxZUdXNmdFZ2pQY2taQXRuci9NbVBN?=
 =?utf-8?B?SUdGUEtCWFZiRTZCd2hpNkUyTjFxanNjUjhad0JkNU43bGxqVEpQaEswMVpE?=
 =?utf-8?B?MDNzSEJwUjN5WFJTYnlNbWxyQW44UUM3TGhoWnR2ZXpKcTdXWlRVZFhiUmxS?=
 =?utf-8?B?aTM0VHg4V29JejdmZFhmQXRrRkJKc0NPWGtUOHQ3VDJMZjdvSWx6aENYY3Bz?=
 =?utf-8?B?dGIrS21XZ3dNVDVZUmt4MVdDU3QvS2ovdjdldzB0MjRkeVkyWlM5S2NSQWlR?=
 =?utf-8?B?Nk5Sek1QTllHYTE3TmNXTnB4VzAvR0IrVmpOVnAvbExSOElWbkhxZW01WDJI?=
 =?utf-8?B?TlZsQXY5MXVEWXhjc0grbTlWUEhKYkxLeXBqYXNlWFRBak5waWtZOWZxS1NN?=
 =?utf-8?B?Um9nU291Z0gzYWJZRkUzTW1aZzExNmJVd1o0bWl6d0FidTJwRGVLMXl4UzNs?=
 =?utf-8?B?NUZaVEl4akNhT1VGUGFSRHJjLzhyTGh6OWduZTJwZmNJU0hjV2NxOHpxM0pj?=
 =?utf-8?B?Yll6L2pWVnlCSDhhc0c0QmVKZUhTVGE4NHNYV0JBc1lXSEdqT1h6VG1VYUpk?=
 =?utf-8?B?ZXA1SjZFQzNUU0FVcnVGZDJsK0IxMkZSN29WVHIvN1VNdndvOW5iQVd4WUlO?=
 =?utf-8?B?Qm9XcnRmNnZFYVBqU0xmYXNFS3pVVFZlMk5aK3RmR1lLOXhmSm1NZVlpM2VT?=
 =?utf-8?B?Yk5RTGNNaTdaTFZQUlliVzBXdm8wS1haNGloUXV2cW9iYkhTSkNzM2M3R0xj?=
 =?utf-8?B?bVd5RWFMR1FBUHYzT01EUVZqdjhLMnV1dUZUc0NGL2gxM212bG5ncm9NcXE4?=
 =?utf-8?B?bjd0YkFrci83NlBiWXp0bWZSWFQ4S20vS1BTWjhBOUwwZHZ0VnV1eHlpOHFo?=
 =?utf-8?B?N0I2UHZPVzhWMFUyTnRyd0R4SVhsTWVVYkc1ankvT0lIUEdaTlhJWXB0L3Rl?=
 =?utf-8?B?VTJmL0wrbXNzcEdRNnlocEZpSnNiTXg0REl4a2g3a3MyMEEzZXprUVYwVitB?=
 =?utf-8?B?SlJDTHUwR2szYWpLczlZZGduSzVGSmVDR1VpbFl3eDRCR05ZQ2RwWWM0S3Vn?=
 =?utf-8?B?eExITDR0bjViMm1pWlpVWHBETTExVGdNbVhXTkNhbGRWRHA1NUJIaW9vaFVK?=
 =?utf-8?B?eHlWTW9XUGV3U09hVjhHRFJ6TWlTdldJbjJVK01OTFU0dnlFSWQ2b2VBdEQz?=
 =?utf-8?B?UUZGYUtxa2F5WmYwLzJKS01NREs1MCtqSjNteDY2dW9EOWFjSTk5WmJyN0pK?=
 =?utf-8?B?YS85RCtWaTNmNkFUZzFIMTk1UmpFSHQvam9abjB6RzV0cXUwMDNVUFpwQ2RQ?=
 =?utf-8?B?azBxSmxxMVVqeTlwZERaa3NwaUw2Zy9HMkVheHlrTE1mcGJyZEdwYnRUazg1?=
 =?utf-8?B?QjdvZUpFUy90N3EwdlVyV0JGM3hqNDRFVnlaWFhWOVIrdWtIbHBZQlRiR0h3?=
 =?utf-8?B?WDZ2Z1Ric2l5OU5CNlZkUUFjSUJVZ1ROdHdwM2p1RERkdXJBVjZpS2Y4QkNh?=
 =?utf-8?B?SG14VndueUZuNVJnM2JWT0tXbitpZ0plcjlwQkFnaXIybVpLdlZHdjlUWSsw?=
 =?utf-8?B?OTRyTlVXOUEwS0IvRjNsbG5QUzB4aE4vL2xpRVRlOEpoZkhlMTEyeVZhSzBm?=
 =?utf-8?Q?tvWQTUwZOvK8KZd50Q0858y92ZE1zSzo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymo4QUFXdTVSRzNWSzBtS25rcDVFa3o3M0xRTU80ZTBSSC9LaG5TdnBRZnB0?=
 =?utf-8?B?eTdETlp4elpHanFkc2p6cmp2UkRMY25GWTk4Nzh1bW1OQXo1MjV0R3J3cnIv?=
 =?utf-8?B?Rm5FOWVuTEIzZ293dC9zdDFWenpKWjMvT0xkRVdCdkhMRFh1RjBSOXRkeVlj?=
 =?utf-8?B?Nm5wOERzYUhxZmtOUng5VnhLaG1JcFhVa081WnBUdkdkRk84YXVGMGJvQjNO?=
 =?utf-8?B?cjhmV3Z5ZjdiN0xUM0pNdjJ1RE5uV2poZXVCT1l0V0dhQWh5TGhldkNTeFdY?=
 =?utf-8?B?em5NUXFnSk0yMlVGU25NM1Jmd1VtTXZkWnpKUHlTenZKQUcrRmw1Z2ZnTFpD?=
 =?utf-8?B?YzhQbDhvUW91MXZqM0JPd1hkdENvUkU5YTMxZVhuL1h1bW91bEowVHVqMHc4?=
 =?utf-8?B?L1VZWDFpdThRM3hhQXdMUFFndnpOeit3b1k2bzRwTTdSME1kUmFRRC9UemNL?=
 =?utf-8?B?dnR2ZWJKaHV5VUZrNm5nYmZlcWMyV0xwRm1sQ0pCY3VnR1NjUUsrL3ZGajJp?=
 =?utf-8?B?TFVtOFRYSmlyRU9uZ0tGQjNxU2F2d0tRTXMrMnBvK1BSRURqL2E2dHNKSWpO?=
 =?utf-8?B?UXZlMDdHcGVIL2VZMU5aK093R3VzWjVkL2JCY3dSTzU1U1MxQkpicU1Jd0Nn?=
 =?utf-8?B?Q0tqeExpeXJvcG5oZ1N4bWUzRHJpaGpLS0s0SWo4SFV1dGZ4Q1RpRVlMNXN4?=
 =?utf-8?B?aEZKUThFa3Mvc2FaRjlKOS91Q0RxUzBueXUxU0g4NlE5M3I1b1lOZHMyb3ZT?=
 =?utf-8?B?TkRaZSs3eElsdWlxYlYzUkpHcGttY0VJc3l5dm5YajlObkNpNHYyLzRtTTls?=
 =?utf-8?B?aXZ4ZU9nSm1aNGIxYVhLdTlqa2ZIRjBYNjJJakNNUTBYQlQ4SnJkVngySVo1?=
 =?utf-8?B?OUZoNnZaU3B1YkVQUFNtUThkRm4rUm5Jd2FYQllXYTNaanFqMkRvekhtejha?=
 =?utf-8?B?WXBGcFRxbU8wWVJ6dnBaV2lTSWV0TW5rOGZrUmlYS0lyR0d1dlVzdlZ5T1NJ?=
 =?utf-8?B?SDBEYVJobW9XdnJCMHN5aTRYTVhDYWVUVmpJMnowOVczUEU2dFZTcHZEZFdB?=
 =?utf-8?B?dFFLYlI2b3lxcDRiQXBpaXR6MytBSmxGQ2xXRjBpWldKYUlmcXFBbkpIbzls?=
 =?utf-8?B?YmZ3NkZ1Sms0eDR5NFNzbnlNSHJSc1Y1R3ZkVW5FNFdhUG5CMXVnbWVkTjVn?=
 =?utf-8?B?T3VnR0cxZllCOXNpOVJiazNxeE9Pc1dxbmg2a2RvRGFZVVVNS0w4WUhScXVF?=
 =?utf-8?B?Qzc4dFprOVRha3laWXcxa2NJRndVMmVMdWZsbUxsanV0S3BoSXFITzk5MG85?=
 =?utf-8?B?K09lRDI4VldxMC9xOHI5b3d1SmZIdzlNL2FHM3B0SjJDL1lGSEtwUW91U1cv?=
 =?utf-8?B?bVFsWlhHWmU2bkloU094QnNZNTFwaWdaRk5USDM2aWhOQklnM3Ixc29qbE96?=
 =?utf-8?B?U29wZUYvRU5DaUdSTXBzZzFNN3F2L01RaklJUnRwWk8xd2JXWHJadGFIU1BS?=
 =?utf-8?B?MHg0VHhXYkhxSlR1U0pPamswaE1NMTAwZEFVV2hWdWR0a2o1ZDRlUzVwTGty?=
 =?utf-8?B?bEZoV3NROFRLTHVwQWNUaGY2RDI0OUYwNHdnNGFmbHk1S2Y0ZUdaSnNEdXZt?=
 =?utf-8?B?ekIrSk5mR2diWGN1bi9sUlZnSzd3SFRpMDBnNmgwSEY0NHhyVlR3cml0cUR4?=
 =?utf-8?B?YWtHeitkMXRqL0VJR3liVzlQYks2c2NNUHNDWVIyVEdib3RJd1VCcnZkMkhy?=
 =?utf-8?B?Z05GR0UvYVJwM28vQU1CTzZPK1Qwa2tyT3NTSm9UL2dhS3VVTTJTdld0Titu?=
 =?utf-8?B?ZmhsSnNlUGkzblZ5b0Z1aFI2QWwrL25JczdCeW9UVGpYaXdYOUZxaC9EUmRR?=
 =?utf-8?B?VXJ0WDZpQUJrQWJBRFFGcEJUSmpwWlNseElSZ0xMU0xma0VnTFNwOXorUERs?=
 =?utf-8?B?Q3VJS3QwcHl1VWIxcEpRVk9lZnRxVzhrcmh1S1FqaXdtN2hUc3JhZjJzL0F3?=
 =?utf-8?B?eU1OUUlzV3JrSEFJZStqczNPQmpkWXU2VnpTWWhkNTJubTk1V0VNajExcUJ4?=
 =?utf-8?B?cm01eUY4TEFLd25SRWw4YzJDeUZVay9tZEo0c3pOaXl3U1FrVlRyV0padHNt?=
 =?utf-8?B?bUhIWE1pUGxmdGRmNEwxUC90SjAzY0RIL0VkY3B0QnpTajBLWWlHbThnNjEw?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43bde7b-c378-4ced-1685-08de373a4758
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:47:37.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiC2mIhM4pFYGxpB7C2aDV8FOhBBDOBTDWhHL883Y1k0UyUjxDzqqiSFAG5vyRJpO+5Lxiu3BOs2ndMh7WuhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9536



On 09/12/2025 16:41, Andy Shevchenko wrote:
> On Tue, Dec 9, 2025 at 7:34 AM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>
>> Include headers in ascending order.
> 
> Thanks, but...
> 
>>  #include <linux/iio/backend.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
> 
> ...this was specifically grouped to show the relation to the certain
> subsystem. At the end we should have something like this
> 
> linux/*.h // generic ones
> ...blank line...
> asm/*.h // generic ones (optionally, if there is a need in a such)
> ...blank line...
> linux/iio/*.h
> ...blank line...

Thanks for the clarification. Sure, it's not a big deal to do a new
version. But FWIW, that convention is not AFAIS explicitly stated
anywhere and with even recent drivers not all following it, it's
somewhat hard to know what expected formatting should be.
It would really be good to have that documented somewhere.

Thanks,
Tomas


> 
> So, what I meant with fixing clk.h is just to move it to the main
> group and sort that.
> 
> You can check (recent enough) drivers for the examples. Yes, some of
> them (but minority IIRC) might have linux/iio/*.h among linux/*.h, but
> usually they are grouped separately.
> 


