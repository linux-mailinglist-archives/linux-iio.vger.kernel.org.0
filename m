Return-Path: <linux-iio+bounces-15850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50808A3DA58
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FBC19C0648
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87A1EF0A3;
	Thu, 20 Feb 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cScRkjos"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023139.outbound.protection.outlook.com [52.101.67.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052429CE6
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055679; cv=fail; b=lYpGHIoRry5+MM/Q8mb3IMEoEs8q4pRJnv6pZuXgZVD2vhhXmIcT4Xpcnbwxrv1j7eC8Q9/t63usYkAnZfBjkVjVTAs0ybGuRPGxX6Lnrw3esPPXw2duNnO+ySsc24VApH7N/jv+2oOsoXqMujOKWATp9Qe6Zpv42gOSL3ab9Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055679; c=relaxed/simple;
	bh=IY6gHB87njDThH4/ETqLwAzJDY10tcVmK9hXSPilnQY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKEEIrXjvUfOJUJF3Y4jjR9wfNudcKUgmWI8Iq9sOk5SrMxzfA4g1jq9OoHhUd0lgvkyRBtJDsuLle4vBCOBksQ+rjeBWq2/+inBKmenL9UztpeOlMClBzN773lAxe4eikXYdN7XeUc6jOb6LiQBqeoGDLFOxN+wJL56VN03WH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cScRkjos; arc=fail smtp.client-ip=52.101.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8sN5JlqDEETXKd7CT113c82m+gM2YdwjCKFyzAuF3xn2ahd8S9aQ3XGXyneWqMq2QiysmXJZlxX+W5agX74dZqqurcHKQcZ+mWcVQJwaLoYitJaQzZau1Ge36jqWQz91CVkeMNgIsYUMc0qRwh+sTwWGae3EX+YwVVy8SMm+LtjBatV8Kk/EbtdkxCJ4YZy3GOL3dKIM5YXA6Z9MFc+jaMArxkdh7xIlU9cp5LxMSkWXoYuqm8rISToAGv0aTSBRBGMiYhHt55Fy9nP3wuomSWcxzf3OQWrgp9iXu9X8dG6eaonUHawIjfgZpf7+VtbaUjMQ15Ajxd/5Rw4WCdemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44pDICAtDYpctNo2Uac7Bw+CIFc5odLKgoi5XCDILCU=;
 b=e5UCxxA1KujDiXLPX0+WmF2SPXgEIGrLuYRdbxdoE1wfd7siBMI6ut2yEUKYW4y4iewidQ1YX8xI7MkB5dWBwFr+FQhGWUqMFTsNdaiHtTt1vmZDxjOrOHi+3PMox5xufCSDcpHXC4R5ysjCpMVzG0OPpvllxnoewad7KEBJJrnOZ1+oG3LpzZ3M2wtE9GlrL8dNJsEjxiuG5CP91vnUsWJ7zIXnhHt+F25mgGyX/zyWK9NzH1qa4dhgPw4vSWJ7iVSS6hxOVWRKbmghppKuGDas+oXXAgAmOxeBNRa6T0b8dE2JGAz4+2IJpqNCPZAr+c3TxW/KZPfi/o67HmlQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44pDICAtDYpctNo2Uac7Bw+CIFc5odLKgoi5XCDILCU=;
 b=cScRkjos877uJTl/tg2lB5iCh4ZXWshLqp7ACwEun5xaod0287r+tqmLJWOFfRNboi+HmX6PetZYv8U4hWzbBBZSuqsAR5ZPgr6fhpLw68zYYjpG2OQiWHlToSn3e5k+5oiA6nIhH4y9q+QjbE5iRVvx/jAMQ27XdQJfJua4V5qlXA6brJkZr2Gpvt06cBx+JsRXij8hOBNTWO/DJH5OoQ6W1f++0iZg3++JAswnV5X59O6j/kQwaPo0F6II4ROqxr92pV5nT1SKpbJMI95Jm4wosccs3+//BN8WbUKNTfLkuVQ8Q5GR1Ppx9W9hcx031+P/1vBnURJFRvyRV8qvsw==
Received: from DUZPR01CA0263.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::11) by AS8PR04MB7701.eurprd04.prod.outlook.com
 (2603:10a6:20b:293::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 12:47:50 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::85) by DUZPR01CA0263.outlook.office365.com
 (2603:10a6:10:4b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 12:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 12:47:49 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.106) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 20 Feb 2025 12:47:48 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS1PR04MB9697.eurprd04.prod.outlook.com (2603:10a6:20b:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 12:47:46 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%3]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 12:47:45 +0000
Message-ID: <644646c5-fa5f-472d-98bb-9d1eeb40545b@topic.nl>
Date: Thu, 20 Feb 2025 13:47:45 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 29/29] iio: adc: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Phil Reid <preid@electromag.com.au>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217141630.897334-1-jic23@kernel.org>
 <20250217141630.897334-30-jic23@kernel.org>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20250217141630.897334-30-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0069.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS1PR04MB9697:EE_|DU6PEPF0000A7E4:EE_|AS8PR04MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b56591-b85b-422e-a2b7-08dd51acc882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dFBtMnhKNWp3OWFCQWh4VVFFNGZORDd4a1lITXJKVmgrdUZ5R2FkYzQ4QmpX?=
 =?utf-8?B?ZzdCb0d5YnVBRUhrRG9PRDJRdTcvdHRnczRUMExTdS9HVktobHNEQ0lZeDR4?=
 =?utf-8?B?OVY3Q2VUY2RNNXZ2MjZxaC84YmhZbld2YlFzS1c1SEhJNld0UEI1VmpYeHZz?=
 =?utf-8?B?NFdJOWtZd0Z1R25mMHJ0K3EvSXNDMzRzWEUwRUkrL2pJcE0wWDcwZXBYdXUv?=
 =?utf-8?B?RWhoUUY2NFpzUXhsL2RJdFhTRVhWVS9sSVZGNGJZYWtMVmJZcXcrQTltMHRt?=
 =?utf-8?B?UlBWbEZ3MkRXdzRPZXJRc1pqQm1KZnAvK3k3R2pueVJuaDZyL3BpbHUyWk1D?=
 =?utf-8?B?Qm1iQ1VDSWw1YzhLNTR1WlY5TmdpRTd4KzBNVS8zK1lvUzgvS1pqQTBhT0pk?=
 =?utf-8?B?RDJCMHhZOUZyajZEbDltYzBkVS9XM0hBS3BpYkQyUE5ZdVBXbGFSUHppWmFX?=
 =?utf-8?B?WGRHcDZHWmljeUVmM1RMTlpXcWlOT0ZMTG10UWVlclJ6S3lOTGZtcGdvYnlE?=
 =?utf-8?B?di9YQk5JV0U4eEVEVU9sNGxVdmhIMUpqdXdaOUFNUnNXRUFFMXNTT1JTTTlo?=
 =?utf-8?B?NkZOWFllYmtDbEVjZWh6T3F2eVNjWjJNOXNpaDR6UXlDYTdtK1NYdUVqSHBl?=
 =?utf-8?B?cWNGT05BN2JuZUlTVEJLRVhremg2SzR6dllQMlB6Z0JENWVFRzdZTUMwSmZx?=
 =?utf-8?B?cldmdjJEK3NtRmNFYUlHWmIrcjBNVFlYL3NVQTQ2dDFrVWFVRmhaUlZGb1Zi?=
 =?utf-8?B?TUo0amVoWE5udnN2TzgxdCtVemR0MVNabEVuM04vbzhuYkdUMGVIZUdMNUM2?=
 =?utf-8?B?LytEeTBhbEdXU3VtajIrY2svVTR6eG9CN3R5ZG9jOExkQ09zbmV6ajZrNDlP?=
 =?utf-8?B?S0lROEtsN2ZrWHhDUGxNZmtDODBwYUJvSmxJUW5hZDRkYkpyYWxLUkpWSEVC?=
 =?utf-8?B?dlVDMDk5SFl3UVl4ZlR0RnJuK3BtblE1Rk9QR3ZMck5zRGNxUmRZTG00U3d6?=
 =?utf-8?B?dDNjc3NvWEFiVXlUMEQzQUpGTzZrTUZwaFY1U1kycjhEUE5PU2d6TGpPT1Zk?=
 =?utf-8?B?bGhYdEJlc3E0d1dUaVhhZTZKNStDTHZtbXI5azdiRTFRSzAxU284RCs2aUJR?=
 =?utf-8?B?R2Vib0NubW55SzhVVSs1RllzM2FjSlQyaGxJRzlkeGNyTXAvamFDTHZocnlk?=
 =?utf-8?B?THVWdyttVUE5SlM3V1Y4M1p4WmFnOGRId013RnduZzVwZnNJcmkvQ0Q0UWts?=
 =?utf-8?B?emQzZ3ZpZXh4cjczMHk4RHo3cTRMQy82S0JWSk1naTVHaE9HSU90WVJqbjFi?=
 =?utf-8?B?eEIyS1VLTHhvaC9tWGlyUS9LdVFxbzd1M0xaQ3JWMHo3OGxWb3Awd1NNaW9v?=
 =?utf-8?B?cFp0c2ZmODlVSjBhdy96MjhRUWp1ZVNQcllTSTJONEJocFUzR2F1M0ZTeWFL?=
 =?utf-8?B?OU1idzRjZ1ZNelVCSzR4bmJsQm9WMFlzemFFOVFWeGZ2QTU1VGFKMktjV2hK?=
 =?utf-8?B?YlVGODZ1WHhWeDZ6VEczZUpZd3NwUTczcytoc1ErZUllRDlWZ09aK2VYczFq?=
 =?utf-8?B?cm0wYWpEbXlzU1RJbHRqM3NKZXNiSlhzUVBSeDFmV1d6WnRCY3hTRWEvaTNS?=
 =?utf-8?B?UE42YThSc3pDaDFFYllqTC9TZUUrM2VjSDJsUE5KT3R4dHhlTTlWTUE4YVVY?=
 =?utf-8?B?OUhQOW1zU2VoblhBWVQ5V0dZbnRYY09CQmYxblQxdHZ2d3NheUd1Q29JYW96?=
 =?utf-8?B?d0NmQmxnamhsbzk4bmRWYTVqVExqRkQ2TzBpWk5YUldLMlNJeHVEY0d5TUJM?=
 =?utf-8?B?NEN1TktJMVpyZDhKVnpncTMxNWpDWEpIdjhPekUvQkpvclMzaXA5WFcvc0hF?=
 =?utf-8?Q?GgR+ZMDtPM6Wi?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9697
X-CodeTwo-MessageID: 96cfeb4e-8c82-43a1-a5f5-6ce49fff0ecb.20250220124748@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7b9f0529-0928-4854-d89d-08dd51acc617
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|35042699022|376014|1800799024|7416014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1MzejY2NGRyL3U5bk5sR0g1eGtFazJwdW9MQUlSZFJ6ZVlnVGhUK3FHNkdO?=
 =?utf-8?B?L1B2VWVHbzN5aGJwTTl1V004YS9BbnNjYlE4dnNoYzdKVlMzejl0UFZrUUhK?=
 =?utf-8?B?TGtsSWFmUk81Y2VSY2pzZzNIZWcrZUowOUZHK0NvNUdlZE82NnMvY2tCQ0tF?=
 =?utf-8?B?QVo3VE5BZjNEeHpxbG50Y0cxZE52Zk1LcEdKK01CL2RSK2RNZzFjcTYxQ0pE?=
 =?utf-8?B?K2d2bnI3NW0vc090ZTAvc2poNU5Qc05ROEJjTWhFQmJ4QmlLdldZNzUweVFz?=
 =?utf-8?B?MlNPYllMaThselRMSDhlRjdyZEZadTAzN0wreUR1dCtzVzdwaDJmUnFTSXJh?=
 =?utf-8?B?eUZ4YWNWN2JBcE1IL3R3N1Bwa0h1Vy9LNGpUTFUwdFlraUxNOE05Zkp0QTIw?=
 =?utf-8?B?VktmdmRicHY5NWZuekt0OHVpeDRzSEZkZWxrbUtIT09UeVU0R1ZZZTBJOVRX?=
 =?utf-8?B?M0hmclhheG9VaFFocEtZZ3NDYXZqOG1hdklPME5JVHVPSmowQkh1VkVSakRq?=
 =?utf-8?B?eTMrTTJBSVRCVURzV1Nid0tBb0Rrc1diT1RmcUdkWCs0SW1BaGI2c1BWWStr?=
 =?utf-8?B?ZTFZWDM3Tm1oa0FidFNreDVLTFNUSjI1ZitMR2ZrdjhRQzF4aWFpUERRdHJh?=
 =?utf-8?B?cWZQVFo0U2EzRENBS0ZDbFNtUHFaZEp3L2VzekIwMlZQRFFZUnhpQUFMa0Nj?=
 =?utf-8?B?a1cxUmJUeDZjQUdiMFhSTjM2R2lscUhyeW9SMDlJanB4U1dZNHhVWk44YTBr?=
 =?utf-8?B?RGJGMkxGa1FZWkJHQVZIQjZJdU5tZ1E2Y1hXWGxVRVVpRmR4cTY0NlArYnNP?=
 =?utf-8?B?ZjRwa0xqK3BPLzRjZGVQUFpkL3J6cEMrVWVXdzhEU1g5enpxM2VNeDQxY1B1?=
 =?utf-8?B?ODQyZ0Q3emdZbTdvOTdHYnNnKzE0MTVzR0dhRmdPZDJPYks0dVlrNnZ0eXQr?=
 =?utf-8?B?U2pyTi9tS1M2YWRLWWcxNjcyWFdoWWdid1ZuNnFoVjFoQ0tGRkRtaUs3aXoz?=
 =?utf-8?B?cFYzNjRlNzdlSy8vekNBbHYxb0pUMEx3TVYwTXEyU0d3S1NqNDl2VmNlb0or?=
 =?utf-8?B?dEFyQjNNN0lFSG9tOEN3dzlscWZoaTZXUEY5Y1ZLQlZKUTJRMzRHQy85NXVL?=
 =?utf-8?B?RW03eTVEREJRSEJqRWZPRXJvcHA4Vmk4S1BSMGxDUzd3clA3eUt6OExNaFY2?=
 =?utf-8?B?TGJncjk5NGhwMkI5QXArKzNFNWpaM3BpR2Z5TDlFV21Ib05nKy9GYUZwQU5w?=
 =?utf-8?B?cFZLQmgrdDc0Sk1GWkRveERLbHYvbnk4OTBmdUpNVmIxRW1sbUZEUmFHRWds?=
 =?utf-8?B?QW4wMHkvOWZITUQ0eGplblY1b3BieUpqbHk5ZE9JamFjYlZDWGRXeXJJQS9L?=
 =?utf-8?B?Ny83Sjl6Y2E5ajQzbm05bFZ3S3JOS3ZsNWs5WjVVY1VpaEh6eC9qWmxGQzE1?=
 =?utf-8?B?NEpMbVlvRWlKUitZTTN3K0JkeU1WaXg3YjdjME0xV1BuQ3RyTTVoeTNDYXg0?=
 =?utf-8?B?WHlKdGN0NzFYeHUvN2k5YmozZDZFdEd3VWFLTktrbGRBSDVmM1lQOWUyQlM3?=
 =?utf-8?B?N3ZkdDNhdzFsaitZbm9EQkdEeDdvZFROWjVvRXVkbUdOckFya2haMW1keG5J?=
 =?utf-8?B?ZEZkT2lLQnZBUENrcDVyZ3lhVzBHRXhKU1V5eGhrYUpxMUZIVlkxek1XUzBv?=
 =?utf-8?B?bGNYUitJTko1K3JZcEVjbVBLbkE2QTFtVEx2aDFTZ1U2cnppcnBzaE1NL1M4?=
 =?utf-8?B?WUppWmVyZnhaRzcyZVI5czh3Uk9kWEwzQjdrdThqRUdPUlpXNHZscGpDYnM2?=
 =?utf-8?B?VEdld0wxQ1BPbEpyalVHVmJxaEtDU0thLzduNXQ4eWZ4ai8zZ1ZrbkNpR1h3?=
 =?utf-8?B?TXd5WW55bWFvb2NNRDZ6TWpYTDc0aTErNzJKK1QyOEgvM2pZb1dhZlZnTVpT?=
 =?utf-8?B?OGhvTmFhMkxheGpjRGszUFgxeVplSFZVUXRPc0RXeHUrc1BXc3M0N1VDTDhZ?=
 =?utf-8?Q?w/1cyve+cpXQ6zbJbNVrU6x5naeyhg=3D?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(35042699022)(376014)(1800799024)(7416014)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:47:49.4207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b56591-b85b-422e-a2b7-08dd51acc882
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701

On 17-02-2025 15:16, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Single patch for all the relatively simple cases.
>
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Cc: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/iio/adc/ad7173.c        |  9 +++---
>   drivers/iio/adc/ad7266.c        |  7 ++---
>   drivers/iio/adc/ad7298.c        |  7 ++---
>   drivers/iio/adc/ad7380.c        | 56 ++++++++++++++-------------------
>   drivers/iio/adc/ad7476.c        |  7 ++---
>   drivers/iio/adc/ad7887.c        |  7 ++---
>   drivers/iio/adc/ad7923.c        |  7 ++---
>   drivers/iio/adc/ad7944.c        |  7 ++---
>   drivers/iio/adc/dln2-adc.c      |  7 ++---
>   drivers/iio/adc/stm32-adc.c     |  7 ++---
>   drivers/iio/adc/ti-adc084s021.c |  9 +++---
>   drivers/iio/adc/ti-adc108s102.c |  7 ++---
>   drivers/iio/adc/ti-ads1298.c    |  7 ++---

For this one in particular (ti-ads1298),

Reviewed-by: Mike Looijmans <mike.looijmans@topic.nl>


>   drivers/iio/adc/ti-ads131e08.c  | 14 ++++-----
>   drivers/iio/adc/ti-tlc4541.c    |  7 ++---
>   15 files changed, 71 insertions(+), 94 deletions(-)
> ...

M.





