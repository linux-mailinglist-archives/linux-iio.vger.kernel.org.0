Return-Path: <linux-iio+bounces-14798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5180A245EE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 01:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E013188967F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 00:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFCC2F2;
	Sat,  1 Feb 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="OLhSgFu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD90A934;
	Sat,  1 Feb 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370091; cv=fail; b=H/n09CQD+RYmHgKw3Rg3wssTmU+eJFs+Np2n+hpfiiH3AipF009JRxS5TJxOFx/Ug3TA1nP/vi8bhKbPRGW0OirSTZ2WZNH+OTlHZiSF/QJoc5B/NNtrHFkSnRcKd3xi9BJO+n0rVgzE3bSIIx5CfxKt+Na9yOq/PjMxERu7St8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370091; c=relaxed/simple;
	bh=+tbBmg+mXQ1sIosRDOMeyzZCD8tuQ1Pr0ATw7x/ztY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dwhA2l4dNlzoX3ZTcVrKnStZL6pYXfylwstLe8OkNH/z+qEtF0orn17qpyxQvxEuAb8DNH2yg6VLOtk8O0ffwNGnJWcQNuIrfmvQ+Rhyv6d3D5dVhRFLm6RO4AjQavmz4q7WpyUwhWNHLioOX2QNz+dGIO0sQ1huGVVgYZ7Gm8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=OLhSgFu8; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBYUVK0V3Il1eTg6jYJtlfJNooXNMr79o4aPuSr+90yNxsRqThycxq7b55M34P1uJ+fqxMmPiy3LWok88E44bHPIY5QAV5hPsynPzlYL5FnfxfHdTDWuDfq/LnBjtLhmSDcoXbuk8vBOm9OUxFfL8nNz2+dA0pcAk3jVsU22LBxlCY5EDUJfnXnSR6obNm5RUTeAWmkHeEJlgdGrP+K7nFNyc5ElUEeR5DnOzeYbgFsy2nRPpyCULm3CA3ESpzB+p1Wz+cdnLY7xdSxuAsLEab3dnGeRoj6nkOxdt+0urjYL7HE+3HRhCXkUefNlf3YAjC0aHzJeQGBPvdMjJqyj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6SRmMov27SAaOceCWcKkhxS/ZAIc/zmvHGHTvh2pFU=;
 b=nTVquyzqG1U34sEfocbjA6Ig2MV1tb7EDtcz5kEHHhwy/CO9xI9KjupIYfQe55Kl3x1GhSpbe6vv1ZC1hOhW6YW5TAzQ1i361M/6d7pHyx3AcbiLzMNdh7fQHqLsyrQSrB3C2QDNENPGPgv6GMsTYWC8gy/9OWpA/wEaN9q1kzJtnc6zRKwtJPaLs3EDec2C/R7K4nXp+DwPn1ciizeZrtje9Ot3C5+aekgA2f9YU6pPXlIhcRMq6dakCN7JRhz0gwWa7j57YTvjeORxxK8EzHthdzAPq7JC6WBzg21Kp5K013d0OjAmSnnLuQU9vxnplk7c1fYGZZ2yoJ5TwtU9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6SRmMov27SAaOceCWcKkhxS/ZAIc/zmvHGHTvh2pFU=;
 b=OLhSgFu8jh7thLPcqwwwfpxMD89YyHWkC++grcCEIRrNHKkybpG9Z+bM4+9xv8xBQTs4GeOlM3ToShAguXEi6D5WWUiyJcydSO7d73ZxQSJLvujrQm99o3zBVnhVpmBM7hiNNM8is25ZQVzeyEx1g8yAA5EkS4Tdi2wUipsxBNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by VI1PR02MB5839.eurprd02.prod.outlook.com (2603:10a6:803:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Sat, 1 Feb
 2025 00:34:42 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%6]) with mapi id 15.20.8398.017; Sat, 1 Feb 2025
 00:34:41 +0000
Message-ID: <33c1524e-2b05-4d10-f15e-400b6195c46e@axentia.se>
Date: Sat, 1 Feb 2025 01:34:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 10/13] mux: gpio: use gpiods_set_array_value_cansleep
Content-Language: sv-SE
To: David Lechner <dlechner@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <20250131-gpio-set-array-helper-v1-10-991c8ccb4d6e@baylibre.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20250131-gpio-set-array-helper-v1-10-991c8ccb4d6e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002E4C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1f) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|VI1PR02MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bd5cc2-2716-49ef-0fd6-08dd42583799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzRlT3JJMUw2bXpvZFFkMTFiVWFtcHhjbWJ0MTZBSkl0b0VTYlRrK1ZXOVpY?=
 =?utf-8?B?SEdOazFMQVRZbTFaM2IzOHdscEhFQmozejY2VXhNSWtHM3Y2a1o0eHdiQTNL?=
 =?utf-8?B?R3gyNnI0RkxEMEpOcnFMQUJqUkhuM2VBeU52czV1bUFLdFdmaWxXSFBjT0My?=
 =?utf-8?B?dHVsenYzNXpER1VuS01od0YwWGRhdThJdExaMjJtQmNVd0M3bHpYbGNWWWty?=
 =?utf-8?B?ZUk5aG9SNThVWkEzcHh0Y1drQjExK1NqWk9ldXU1ZjZCMHNLS1hCWHNVcEVm?=
 =?utf-8?B?U0ZpZ3g5endKVi81Y0tJUmtnSisyUzlJZVIxMjZJMXdPTmpKVlE5WUR3WUF0?=
 =?utf-8?B?NVVESitwbjFPcmdDS0YyR01PTjFZa1hib1N3eEVmWVMwVkoyMjJNb1RFRUdC?=
 =?utf-8?B?UzRwVDdKZjluL2YwUDZBYlFZRUUzN1lRdTI4QUdrUVRBMXdRT201VkE2SVdW?=
 =?utf-8?B?ZjdydmNGSGJjSGlOWEpqQ09ScWpEbmg3NWkrRnJFam9xdEQzUkNvVitiTkVs?=
 =?utf-8?B?ZUE0bjd3NTdURUFOZHJaUS9BODZlbzBZMUdOS2htSUNNVHVLaUFJTXEzN1lp?=
 =?utf-8?B?WURBaGxzMmNnczJUT0J3am5HV211MlVMeXg5dXRmbXFvOWFiL3MwdXI0dTM1?=
 =?utf-8?B?b2RsZ29lQVVWR0N6blFZUGxXTEVRMkk0aVUxZXlhZjVqZnBOcHE3Uk1mK2I4?=
 =?utf-8?B?b1JtM3RBT0ZtSjdOUFI5R29SZlF1NnVsSmZ1K0J0QmxmMDZ6a2hvOTA5bHlX?=
 =?utf-8?B?NGpxNFp0NnVJZVQ5R3lpY1hXNkxOckVzdkJVYWhEa2lqRDgvS2VNN1ppYzV3?=
 =?utf-8?B?QzZ2SUUrYys4MUsrd3ZaWnRTSGFTOGxnT1lUV3FNYUlSTXk1RXZTN1lIU0py?=
 =?utf-8?B?T3cydkdLeEk0VU9Ja3BHcUx3N0lBUmY3akVPdjdtWUNTUTUzaGsrMUsrTDRL?=
 =?utf-8?B?UEc3ZHdxZm5yQ05xOFo2TkVCZE5sdmpVbDByU0NJOU1Fck4zQzhvNWxmYk13?=
 =?utf-8?B?MTYwM1RsSVBLRlFtYy9JMkIyZUVpcUY0YkdZNi9IakVUYTFVall1YnJnR041?=
 =?utf-8?B?eUFNaCtRbjREcjlsVXY4cWlTNlMzNmw5c0tGakR1cEhNcUJmb1Vab0tlY1dB?=
 =?utf-8?B?N0UwbGRlbEJuSTNEWXFFMllsNys5bmg0aXczZ0NISWNRbVllQjhxVStOTVVS?=
 =?utf-8?B?WWh6V0U5NzhQd3oxSFo1UFBla2dkbksvTGw3cFBDY0hEa3RzTFhSc0duUVh5?=
 =?utf-8?B?R2EyYlFIR3grVU42dThmY0FmZGhpTHdCYjNtN2wwNGFRL3dMbXdNWExTMWlE?=
 =?utf-8?B?WkEvNU9TelhPMkJYK0VrQyt2LzRmTS9ld29PV0JwZDZLdTlPVGtjZW5BQTFV?=
 =?utf-8?B?KzBSbmpTL3FHRVgwTXJGcDdCQWJWWUIxM1ptK1Q0S3hQUk5uaHUyMEhkbGFl?=
 =?utf-8?B?cUQrNzdWRzdEeE1GQXY0ZytOS0VWT3pGKzdPQzE0ZzhjUlNGVkpoS2d3bW5N?=
 =?utf-8?B?ekphTEsvbUk2V0ZHN3BnS3RwQTEycVNuSVdnSGNsK1pXUjVqdkFtVGJRZ0FJ?=
 =?utf-8?B?NURweHZWek9WTmJuZXRtRHpPOFZ2RitSMDJXZ014U2wyelN6SlUwMVlzQU9U?=
 =?utf-8?B?YmNnM0hwQStQYTNxMFRiazdEMGZVcEIrMFlBYmFOckVqWmdzTVhsb1lLMEo3?=
 =?utf-8?B?d2JYOGZwSlFuU2NaN3ZIRmx4R2FEV0xoRDBJeFF2ZVlnSTh6a24ycXQxMkxT?=
 =?utf-8?B?REZMREJKc0lyR0FOZXdwbXhsSGJSOVlkZWZxemVXbnRuU3NWOFNHenNOcGZM?=
 =?utf-8?B?am94MkYxNk5oRy9IdGVHNmtNMXFsdkFDRlR3WlFoWVlPR0ZEMVN4SVl6d0sx?=
 =?utf-8?B?WlhkOUpNdVlMWTRzZkhDekoxcEJFNWx4SmdKbWlNNkpoeDVZTzdtOUtVQ01D?=
 =?utf-8?Q?adGOD9FU34s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmpKcStQZTNJSDMyMEFnZUlGOHFUNUwxdUhxeWpNWUdVeVRGWGVEL0owdmVE?=
 =?utf-8?B?ajNwZ29jZ01Ma0luaUNLa21jc2RpZ3pPK2lIZzZJUkEva05yZ3RaVGRrN0pK?=
 =?utf-8?B?Q21tM1pEQmtkVEV5Z0xtK1UvS0hCb21FeU9UVmVpZUFmTkduV3czNGJQMFlH?=
 =?utf-8?B?VzdYczBITmcwQ2NlUG45WkI5akdYeE13b3A2Yk1mYkUxZ2wyQ0FnTmxJR1VT?=
 =?utf-8?B?MUcrWk9kK2ZuYWtrdzI0S0NXb1c0ZmtTWDlsdldrQmdhMHd4enJUMzJsTG1z?=
 =?utf-8?B?UFU2YXIzZ1ZOOGluaDUvQ2k0dzRFRUVQZ0xOQVRlTUZKM1JreXpKUEhTSnA2?=
 =?utf-8?B?MXNYZ3NhT2xFWVl6TEZZWW5VaGR0bVkwVmh1YlcyVm1TMUlOZE01V1g5RklL?=
 =?utf-8?B?ckN0ZHJMQzUxRUtXRXhTV0hwKzVidlJhSXlSdXY3WVJGTnliR1Q1S1JUZjZw?=
 =?utf-8?B?ejNRTFNtWUJSZW9Qb0podDNZdmlVT29CT3JVd25NZXhybEpIUDNGYUFmSlA3?=
 =?utf-8?B?dEZuRzlGWXQ4ME9QWFp0SGk3c2k3RXp3R21sZGZMU0JtNC9nS0NPQkxIcTV6?=
 =?utf-8?B?Zk94TDhIVXBpYWd5UnZSTExydjdPNXREZjhrV1lyWk9VOGpNTDI5QytSTHdC?=
 =?utf-8?B?ekhpV244YkdubmVvTGowdVpJb1hhTzdRQ1dWdWhaTWVJRzE3RnlwY2tpUnBx?=
 =?utf-8?B?V2dIOGFndnQ3ZnhLeFVWQTVwRDBBTTN0aFNFMVJhampnWmtqZ0tiVW9QdHRk?=
 =?utf-8?B?MmN1cFVoWHBGSWJpWTJiZEdabTlpT1gzNFVTZjErWVZld2VxSGRwaUhmYWsw?=
 =?utf-8?B?anZGWlFQNVc3VEM3ZlZGQ0syeUYyRExGT0VsWm5qUDNQcnN6OWJVdmdBdEx2?=
 =?utf-8?B?aGUxNExPSnJ5eGNIeU1IZ2NPNHpveDRvek02cDhKUVFzM1hGTEhpT3Z0TlVk?=
 =?utf-8?B?L3k3bDBod3NWNGdkZnZ4OU92TUdBZlYrR25rcHFNL2tuN0RSMjhDeVpjSU5H?=
 =?utf-8?B?SzZ6YUZ2d1g0UEpHVE83WFBvaTUvTTR3aXJlZUJIVVNGbkZkelhiSnAweWN6?=
 =?utf-8?B?bnFtUk5xc1BuZm1qbWNmdFdjSjJYVW1WQjgrOGF5UUxHZUJzTjFnYjNOcERG?=
 =?utf-8?B?cmFMMXlVbm1Ea0lXTUFjZHY0eFgzZUpSRWNjUDJrRUlrL2NVNThWcU5nK3Fh?=
 =?utf-8?B?NWtyR1BPeTdsQTJhMW1pQVkvWFUvcitqMjk2OHR0QW5kMlJFU1VQdCt4OTJq?=
 =?utf-8?B?czBPSVlRR2QxeWFKcGJjOWphSEg5a0dpdFlveFdVelBZM2dlY1FtSTFiMFpC?=
 =?utf-8?B?QUMwZnM5My80eXk2cG1WL0JZVjJhOWNoWkFGTEtIRjJ1MkFzb0w4RU9RMWlK?=
 =?utf-8?B?YzVZNUgzdi96WkRZT3F6S1dORTlXUEdVVEJjUnBTR0FLSVBnL3RFZFo2VFJZ?=
 =?utf-8?B?UlgwNnpiMWMyRUFqSUx1VUF6aVE3Znh5ZWl4cTVSVFJPM3MwNXJZaDMxVXVJ?=
 =?utf-8?B?cXp2MHZ5V0RoZEZVY2NXN3FHZjY2R081bEdEcG8zRE9Bdlp2SW5XaE1GV25R?=
 =?utf-8?B?dHZ6ZW14ZmlEekNKZzNLTDlSMUtXS1JkUVBrLzlFRWNvd2kyOGFoS003OHYw?=
 =?utf-8?B?Y2hSQk1SaFJwREZXYUVBa0VXQzZPcU5LLy9WMkFQQkMyc3JIdzFwM001TW9K?=
 =?utf-8?B?N2pGd2sxbDdxa3pYTlVYSi84enpzVFFpSXBOVzZBYXZHNG9sWnM4Q2ZTSEtv?=
 =?utf-8?B?ckFZM3lONENPbGFhaVZGdGY5RDRRZWlGYnhvSThVa3BLbnBvQklzbmlQeXVz?=
 =?utf-8?B?Zk9wL3lMMG5ZQzJGMVBpNnp6YlhsRy9qckdyNFFUMFBVOEZLNFdVQ2ZHOVZB?=
 =?utf-8?B?djZMWXkzVlVLc0VnRENRSnJYZG9BZW5PMDUxdUFSUVlkUzl4cUFBek1RS1M3?=
 =?utf-8?B?bjFDTCs0V2E1YlRmSDdab0JYZnZtMldFbHN2WWl1cGxnV0QvbldrM0ZqeExs?=
 =?utf-8?B?dG95bVIwSmhmb2xGclVFVG8rK0hwMmNUZ3o0S05DMUkva05NeWp6MDFVbzg5?=
 =?utf-8?B?dUY3R1dDVDljbGg0bGl5RHNTTml5OFdNcFFBQllDNmVlMWFXZERPZ3FHa1Fk?=
 =?utf-8?Q?UyE3UIp5f5xN+k2/1FaIvRPZ6?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd5cc2-2716-49ef-0fd6-08dd42583799
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 00:34:41.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNFZn2gChZ3e9bkwG+EOmatMUUoVdKehumpOp/RrJHiylHt7Gjy/2eJZMTBzcOtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5839

Hi!

2025-01-31 at 21:24, David Lechner wrote:
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Looks good to me.

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

