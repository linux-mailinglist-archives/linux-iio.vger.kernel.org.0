Return-Path: <linux-iio+bounces-19652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC5ABB6CB
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179C818984A9
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70C269882;
	Mon, 19 May 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5fwy4AqL"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1139A31;
	Mon, 19 May 2025 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642166; cv=fail; b=MdulJD0RFMv1hzxZLaekGqPvA6Ba7C6WAvcLXsmY6x+ZxpgvmQX3lM1N+gZuHi5SU+5wAVvbGzwgtwsjMs9kFD3E2bPDBOmiqNEh5nNTyWmin9M5mAcqDIa718Qe6WI41I7BubJZe6jaRaZAhkxSaQuSr8HPhFYpTyfH7xzkPzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642166; c=relaxed/simple;
	bh=2dkXvzh42wYlB9RlUAuZOUPzhcyfnF0iI7pQDNQaKNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAR0R2E1QY0LdHo2X9i6cVZwvJBD66ye/1s+XlgM/rjxUu8li52Gheh2sIeskAGfH5tzDs0SdT9jvaEivT+YtMhKb+gOzAW05raQ7CmfpXwaPoK26kItXfIuPr0hFVxZn6anbD0Uk1gMOs5GHQM/PguK70R7aDHjCL3HK9xTzf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5fwy4AqL; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfF7WoB/TlPSCuMeq6ZT53kEiH7px0XlYCw9lc2V8PU+0yToW2NZNQnrFPXPxxLCuHMrlzPW92zwdKU43hjWVtxhq/HZvihErBMt9E8JAHVVIu8pq0bxybxqxjjzQP4Dge1kFyZdNeAM/JuIQ68O4JuPLcOtr2dew2rddGGXJih/NO880Yf7cWPdjTTZVurmmTojDGK/TMJJ1UJRa/nINIIk7K5etG1AiPBnWRwA9YKkQ348WOyaiLgQMl9yDbmspZul9Wun2Uz0ExbHfQ2vTh8ySOKeEEvuCNuduLPAX5JLiFixYhldhADZ3A7HuKGW/lw7wOG7zj5AiRj+6SiMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dkXvzh42wYlB9RlUAuZOUPzhcyfnF0iI7pQDNQaKNQ=;
 b=yTedkfNjVDFYMUUk89WwVwHldDhrxJWW0sB1kWwbG2ABO7BwhnfMIWS8abZNhQa5Z/py4QBabUCW49EzLh6sdFswG/2uZm6TrI6zi9rQGy0HNa8OK+OX+ROhF55qrmK88+q35aRLXMZ0GZhR2dUzTxohfGFStk/kzPlSQIXZNtIVg+F/EufPtLzjcV5ST6v7I1MDkbdNKdlRbYxzkqextoVIGpdoqrOyREVFgBg6LlsFW/z4s85OyBJO3pjRQQ3jXhF5j2yLTS+QvQfQIHsdCwA3v7OMCbC1ryOZ5V+5aT+Qaj+JLr2HpMDhjlEV4hJfJuSV4elaaVaWVWgQRvdzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dkXvzh42wYlB9RlUAuZOUPzhcyfnF0iI7pQDNQaKNQ=;
 b=5fwy4AqLtO58rOfVJuf2/OA7t569577J2TJqkkN+FQde9y4HI6DHGU/aoDBsmcJosivH5nbhJU1r8uhlfLADyJ3dPnbuPNY5zDrSVEESTkwv/xJjXrmyQXVq/axogjKK267ouW/ws4pAqk5ebu96Q5J9OfeEZ6uQfaIrhXMDbknPmc3TVrLzbw4vjdkInwvhCyVziUIPdn37zvmksSZ/bTHnODPmWL6uKPlHRRPz9EAYyg/R8Estc2nc/9vGXKPv98PzFMlP4oQlsps8BNa3hKwekKnGQzW6EbRsqgVxlUEyUkBduQB6TmCCyuMhRnAOXQLKc/Z6j4zhLJFc2zr7bQ==
Received: from BY5PR11MB4088.namprd11.prod.outlook.com (2603:10b6:a03:185::32)
 by DS4PPFE90FA9325.namprd11.prod.outlook.com (2603:10b6:f:fc02::5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:09:21 +0000
Received: from BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa]) by BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 08:09:20 +0000
From: <Marius.Cristea@microchip.com>
To: <linux-leds@vger.kernel.org>, <asoponar@taladin.ro>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <wim@linux-watchdog.org>,
	<lee@kernel.org>, <angelogioacchino.delregno@collabora.com>,
	<aardelean@baylibre.com>, <jic23@kernel.org>, <pavel@ucw.cz>,
	<tobias.schaffner@siemens.com>, <baocheng.su@siemens.com>,
	<matthias.bgg@gmail.com>, <contact@sopy.one>,
	<benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH 11/16] iio: mcp3564: Fix type incompatibility with
 non-macro find_closest
Thread-Topic: [PATCH 11/16] iio: mcp3564: Fix type incompatibility with
 non-macro find_closest
Thread-Index: AQHbxXarkQxknoWn1EymlkvKjn06x7PZn7aA
Date: Mon, 19 May 2025 08:09:20 +0000
Message-ID: <4bf6a6e3fec803c31adb8b227bd4ca95907ebe30.camel@microchip.com>
References: <20250515081332.151250-1-asoponar@taladin.ro>
	 <20250515081332.151250-12-asoponar@taladin.ro>
In-Reply-To: <20250515081332.151250-12-asoponar@taladin.ro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4088:EE_|DS4PPFE90FA9325:EE_
x-ms-office365-filtering-correlation-id: 9ce173b8-72b3-4eb8-4cfa-08dd96ac7569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzQ1eGlVSjlEaWZvM0xhY1NSSlFNT2FmbmwzV2F5V0tzRk5uZGpyK2U3ZHcx?=
 =?utf-8?B?cXU5R1c4Sk41cEVjTDFPL1cvUnJ2R1BOUVRjRzJUdFJJbTFFZThUM21DMDVE?=
 =?utf-8?B?d1ZiblZaa2ZMN01RYklUck9DMWNiTXlSU0lLRFZPbzdyZ2hTcmNnbFJ6eUEx?=
 =?utf-8?B?d0VhVmRyUG8wenZCRHgxMWluQkJEcmM4bzBxdUE3dUkrR2hlNktMT29MMnYz?=
 =?utf-8?B?V0lEVThnUWpRNG94T0dUb0pkMHZrRDNFL1k0RnlJak9UVEl6c2NTR0RJbmtw?=
 =?utf-8?B?TEdzWWl4ZURDMDVFWktkakN0Zk9WQ0NkaG9QTkVMK2d4WmVWemhBNVZHSUpj?=
 =?utf-8?B?YVhzby9RSTlKZWl6VTJ2aXRySGNSaWtlbWpKdC8vRUNhdWovNW5IVDVvUzRO?=
 =?utf-8?B?VGorZGxrQnMxa0JvZHhtYW1SRGx4YjZtcDEwVnBhb2xoZUI4bGRGSGFjYm9U?=
 =?utf-8?B?am51QUNxYzNObUNVUGIxWm8wcm5rVkY3OUtEMGVpY0p2WlcxeW1HN3ZSZmRo?=
 =?utf-8?B?QWdUdS9zMytqZGp4WnczeEd5OFV1V2h4WWlIN214TjVpM0VMWXVYTTBzTk5P?=
 =?utf-8?B?eFQ1Y2huc08rTjYyOHhzMVBqL3IwWXhhU3Q0UzVRemJiVDkzY0d4QllIUThG?=
 =?utf-8?B?TjVRNTBveTNBSEc4aXhleEVwd3dqb3FUKzJqMkgyQ3NGeHpOa1kvSGQ5WHJv?=
 =?utf-8?B?Ui80UDllcnlPNnp5NU9JNjdqc3B2ZkdtVGtVMXFqTXBYNWJpYTdhb2lGK3RT?=
 =?utf-8?B?UDRhWjR6N3hIdzdDalcvZXI0Z2lkS3paMFROS0pmbjN3K3pjWDRNcVZZUStp?=
 =?utf-8?B?dU53TVJuREV6WWZieXFlUFh1UG5Va1RLRjhtcDVKQStib0JNVGpGQ0RjWG9l?=
 =?utf-8?B?VFBwVFFadzRFaUIycjlnSWpBekRzOEV0ZUJMTkM1aTRjdEZJZ3BFUlE4d2xp?=
 =?utf-8?B?ajZsTjE2VUV1aStiQVFaODBWRi80TUh0V09sbXV0NW0wUm9XYS9tRGMrajRr?=
 =?utf-8?B?Z2FvSXVBNDZLS2xxME01YXpHU3pMTUFHNzMyR0dLTFp0WHFLK3E1QjVNdlZk?=
 =?utf-8?B?eTRLejBGTFJSNHVQTG1GdWxCb3BtL1Rtd2xkalJmWWtOSlAwQXMzWE5acGJw?=
 =?utf-8?B?bGtwOUo2V2RyYXZxNU56enVoSmdYN1A4YUxHT0ZhOGI2RzlKS1YweXZEZHI4?=
 =?utf-8?B?ZGFPcVQwT3NURnNzT2ZTRzhBbWN3eTkvMzd4dDZhWWZqakRSeGVDU01PYkdF?=
 =?utf-8?B?WEdCaUEvM3RuM0g1SVBxMUxNYjd5a21SWXpaOElWd1NlMmI2aXBPVHN6L3hF?=
 =?utf-8?B?NThxSGZzSUM0c3lhSFA4a3hUbWVaM210R3JxZjgyeCsrb3dQTHJZYUJPdlBw?=
 =?utf-8?B?S1p1UHl6M3RuR3Y5VW5BdnFxVW92eXdnTklVT3l6ZE1TOTFQOG1EVzZEU2p3?=
 =?utf-8?B?RE92N2VTM2ltRSt6QVc1M2RzQnBWWkNvZkRBMTYrK3dCVi8vNlBrQ0dLbkor?=
 =?utf-8?B?Tk00akRMQWVkbGh1QThQY21Pdkx0SGdTcTBBajN1VG1uRmtkRU9mdzhvYmpo?=
 =?utf-8?B?aEprVWdIZUh6WVlkYlZCNHZhMWFna2JEMm1uNWVLK2lJSlNRY1FtSDI3a3FO?=
 =?utf-8?B?UkJPQ2tKQmgrMUpONHh4RS9EblBwSVdLall3dzQwR056dmhpYUZtemUwSmxX?=
 =?utf-8?B?Mi9sMUZHYm1YSmJQdEdjeHFqdFRJcnU5WDhZNDNObnFVVFg2NkxTblVSOU1w?=
 =?utf-8?B?U2EycDJVZnZKbU82cnlzNVE5OFM4b2pUNERsT3NTN2VvYno3bVBxVEVRcnk0?=
 =?utf-8?B?NlQ0MnovT3pXdFQzWkMxRmorMWViMVF1VklIbDIwcjJZdEFmRG4ra3o4eDY5?=
 =?utf-8?B?NVU1cE9ySkxWdVBtb0J2ZUd2aXJBYnlVTlU3bG5UNFNDY3lCellsR1dndGJO?=
 =?utf-8?B?bVVpRWRIeGc5VG1KMkVGSlRNRVZIeEFKc2hIeUVjQmVYd21LV3d5eEFOVUc5?=
 =?utf-8?B?N25EVDR0TmRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4088.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZitGdUo0cXlJaFU3d2J0Uks1b0ZSaEc3NkxHYnROVVVKTVhxSWNxTFFUeGk2?=
 =?utf-8?B?dFMxTC9qempPdFVFMXlldzNtc29yYUhGa2V3VmxUOW1vb3VFdjhLdjBNRm91?=
 =?utf-8?B?VjNTcWkyNWcxZ2IxOXN3dHFSVjdZUzFwOEtpdVVXOFNpeDU0NDJudG1WeC9B?=
 =?utf-8?B?SnZFcE9Ncm52N0ZPZnZTTlAvVzhuWnJRNHpXVFNxeEQ4UTVQV0VMZStXLzdz?=
 =?utf-8?B?ejdYRGYyZGVIbHQ2WmdKUC90Tk5IU2dMYWFENnBmWGpzY2RGcXh4WFNZT050?=
 =?utf-8?B?K04xZHVRdkt2cWc1cC9GcTV6Z0s3ZXJsYmoxRjFQcTFOeHZyYmJWV1hXYisx?=
 =?utf-8?B?dktueldYbzJrcFhXYlFkQkVaOFdVY1ZtV0s0Y1Y0WTJ3UlJmMk8zZExTbGZN?=
 =?utf-8?B?WFUzSWlkY2x6UHE3di9oVXNEUEh5WGF5bURnaWl0RXNIYXNJWkdCZVN0bFly?=
 =?utf-8?B?cVFraDV2a2ZKSlBkWTZqampSVEthWktzUytQMWVqUytMVGNBd2tNOTJnTGRI?=
 =?utf-8?B?VmoyQ2VoZ3FhKzhOR0l3ck54OG51YnRNVmtlVjY3eU14UDdaN0hiN3VyenJV?=
 =?utf-8?B?T1hGbU91RU1QNjdQcTVXdWJGcDJ6RGVxbENvRE53VkxKVyt2c1F3Y0RxNlQy?=
 =?utf-8?B?VmhVL296RDYxYmNGUGt2VjF3N3NUUHo5SzQwNGFMNVQxVWdkdm9FRmVIa0JP?=
 =?utf-8?B?NGF4b0NiVEVwZmNicmlQWFpiQ3FMdDdDaWN4U3BiT0RRZEhNSEROQ2hEM3NZ?=
 =?utf-8?B?aGszNWo2djRXaEtQVWJicElPeVN2K3RkWUFpU0RrS3FOZGcyMFQxT3JTOW5R?=
 =?utf-8?B?bUJsTkk0OWRIUXVkaWVnOTQzd3BBWHI4YWppb3J5d2x6UXpyaGl5VzNvQVow?=
 =?utf-8?B?T2ltVjdUU2h0K1h6eDZ4VXlQa04xNUQyM0VPVnMxY0Jod3JxMHMyTjA3SU40?=
 =?utf-8?B?Rzg2MURpeUZhTHAwQTJqVGR3K21aSlNlMmlveVBYZ0NKSWcxV1ZaQXd1TkF2?=
 =?utf-8?B?RTNkMHlubFA5WVFPdDZLckpScE9jam1yczZsYTViRVBZUkV2NU41WkxuR2xt?=
 =?utf-8?B?YWZHUENsOVcvVnd6WGRKTXR5L1pLTlZMNWdaWjd4WmRWODJVU3pndWoxK1JJ?=
 =?utf-8?B?cExzaHMwK0h2dGttRUFHRUJPemI0ekJrSDRFMHpCVTU1T1RUWnVpSkdpUHZw?=
 =?utf-8?B?TkRlVHBaYUlHQVJSa1pXNm5SU0F3eFpjNVM4TllRcndzendwREk3akdJcDV6?=
 =?utf-8?B?ZndUT09ERTF3MWR5TU4wQWRLY0ZpUUVUK1VuYnFPRHJVdTd4UVBjYjhxSzVs?=
 =?utf-8?B?THZaNzVIWmpHRzlBdzYzTjU4NjVHNHRmQ2ZoNXpTeVZ2b2s1ZE5mdjM4WnNL?=
 =?utf-8?B?OGFJOHV2d2dLbmJTenFWMmkzVExsOE9QQkVaeUVsaHlTc0I5bDBMZGJ0ODZY?=
 =?utf-8?B?SzBlTTRNRktHaW1BblhpNU1qUjMrMXM1aVBFWC8yMGpWQk1Dbm5Gdm8vVVR3?=
 =?utf-8?B?K0lzQXVpWERrNmhRZ3NJNE1FV2FYL2JVKzY1QzIyM3VvUHJqM2UzQ3E3SlNO?=
 =?utf-8?B?aFdIaHRHemxha2tsVitTOWUzcUx5WE5zWk9wMkRCc09zMC94NUNqZFZ4TU9X?=
 =?utf-8?B?c0R1SDk3Q3M0K29NVnpyK0ZiTU5CSVRaR3BpV3l3US95Umo4dUlVc2xSSEFw?=
 =?utf-8?B?dkdSandWN2w4czhYTEJEUnh2WHpwM2RyWDE5UUhuR1JtbEhZMUdONEEzMjNK?=
 =?utf-8?B?V05kdS84R2s5STVNcWRSMFNseTg1TlAyOGV6RkNYUTlnY0EzZUNtNmdtb3RM?=
 =?utf-8?B?Sy9lWjVObnMrR3JnWmRQRENWdUpDN1krb3RlZE9nM1hKZ1cvQm42Q0lYQys2?=
 =?utf-8?B?TzVlckUvU1hVWEQrODRZWWJJQitNWlJ4c0sraHpJTUh3QnlySC9sbHd4WmlC?=
 =?utf-8?B?V0k5eXJjdndWa1lFcU1rZVN2dHhtZlRCTzJiTWpOcXh0WkIyMGI3bTVRQ1Q1?=
 =?utf-8?B?R1l3bHpLK0lzc3BkQ2JjVE5BenNqNUlMTmtYY2lENHlLSHZkRkJ2YmVGUzhL?=
 =?utf-8?B?K1dudjNvMVFaV2thbWN4VEJpQTlucW9Gd1V3VE9aWWVXdW9mUHh3ckZLa010?=
 =?utf-8?B?T3FVV2pJYXJPU0tudTFaZVRvY0ZnVzA4WkRhM3lXVWRaQXJSQW81R0cvYWR4?=
 =?utf-8?Q?mYYD7eK0J0kBuZXC2CkyGMA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3110C77DE7BD9940B63E8928A07711F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4088.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce173b8-72b3-4eb8-4cfa-08dd96ac7569
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 08:09:20.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5G7rBIcftd6NsNmqgE5fCk0pokP4u68bOf6c8AkO29AdG7UdhpHufu96IM2Nc20ADNzePtGl8QCLiPkoF1TC8BH0hWGI/rLwoSXxZF5fM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE90FA9325

T24gVGh1LCAyMDI1LTA1LTE1IGF0IDExOjEzICswMzAwLCBBbGV4YW5kcnUgU29wb25hciB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgbWNw
MzU2NF9vdmVyc2FtcGxpbmdfYXZhaWwgYXJyYXkgd2FzIHByZXZpb3VzbHkgZGVjbGFyZWQgYXMN
Cj4gdW5zaWduZWQNCj4gaW50IGJ1dCB1c2VkIHdpdGggZmluZF9jbG9zZXN0KCkuIFdpdGggZmlu
ZF9jbG9zZXN0KCkgbm93IGltcGxlbWVudGVkDQo+IGFzDQo+IGEgZnVuY3Rpb24gdGFraW5nIHNp
Z25lZCBpbnQgcGFyYW1ldGVycyBpbnN0ZWFkIG9mIGEgbWFjcm8swqAgcGFzc2luZw0KPiB1bnNp
Z25lZCBhcnJheXMgY2F1c2VzIHR5cGUgaW5jb21wYXRpYmlsaXR5IGVycm9ycy4gVGhpcyBwYXRj
aA0KPiBjaGFuZ2VzIHRoZQ0KPiBhcnJheXMgdHlwZSBmcm9tIHVuc2lnbmVkIGludCB0byBpbnQg
dG8gZW5zdXJlIGNvbXBhdGliaWxpdHkgd2l0aCB0aGUNCj4gZnVuY3Rpb24gc2lnbmF0dXJlIGFu
ZCBwcmV2ZW50IGNvbXBpbGF0aW9uIGVycm9ycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhh
bmRydSBTb3BvbmFyIDxhc29wb25hckB0YWxhZGluLnJvPg0KDQpIaSBBbGV4YW5kcnUsDQoNCglU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGUgcGF0Y2guIFRoZSBwYXRjaCBpcyBPSy4NCg0KUmV2
aWV3ZWQtYnk6IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0K
DQoNClRoYW5rcywNCk1hcml1cyANCg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvaWlvL2FkYy9tY3Az
NTY0LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYyBiL2Ry
aXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gaW5kZXggYTY4ZjFjZDY4ODNlLi4wMWVmYzc3Zjcx
MGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gKysrIGIvZHJp
dmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiBAQCAtMjUzLDcgKzI1Myw3IEBAIGVudW0gbWNwMzU2
NF9vdmVyc2FtcGxpbmcgew0KPiDCoMKgwqDCoMKgwqDCoCBNQ1AzNTY0X09WRVJTQU1QTElOR19S
QVRJT185ODMwNA0KPiDCoH07DQo+IA0KPiAtc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBtY3Az
NTY0X292ZXJzYW1wbGluZ19hdmFpbFtdID0gew0KPiArc3RhdGljIGNvbnN0IGludCBtY3AzNTY0
X292ZXJzYW1wbGluZ19hdmFpbFtdID0gew0KPiDCoMKgwqDCoMKgwqDCoCBbTUNQMzU2NF9PVkVS
U0FNUExJTkdfUkFUSU9fMzJdID0gMzIsDQo+IMKgwqDCoMKgwqDCoMKgIFtNQ1AzNTY0X09WRVJT
QU1QTElOR19SQVRJT182NF0gPSA2NCwNCj4gwqDCoMKgwqDCoMKgwqAgW01DUDM1NjRfT1ZFUlNB
TVBMSU5HX1JBVElPXzEyOF0gPSAxMjgsDQo+IC0tDQo+IDIuNDkuMA0KPiANCg==

