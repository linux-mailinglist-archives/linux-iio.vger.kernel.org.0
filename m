Return-Path: <linux-iio+bounces-22777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EDB28B6D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E4C5C6EF4
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14B2264DB;
	Sat, 16 Aug 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vj5gLPNp"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B94C98;
	Sat, 16 Aug 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329363; cv=fail; b=Ur/ZHesdMh5SY7fPzfRXbXuf1buGeEaSrL+o8715EJUmagKXmPj6G3q+STNKX7Y9brJrUDTUwErt5uC4fuiTxQYfF1iSCBL/XHwbdWmVHlU8d+W8uSqbgF9LK9NohDY4Wzxq3MtyhxOwrDs+MX7auyZoG3dVQ0jjZbF5p9GW0Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329363; c=relaxed/simple;
	bh=z6AT3CDQT75HY4kV6ENosuikjXdC7ZE+dWcu94lx7wk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WGuDfwOPWMrIMOAB9g//IgaEtSn8jItv+E5b2JFtdaV529Wi8QPs6mNvxyO44Q4fEIDuRR4FN13e9s2ppudEnPKzYmtNIlUwGIGsQQNi+93IAGPNUVBN4r7kI5vClZKUNpqzOAzTT8ZhpN3Ab9oWFxFtPkHGvWrgP/c+9JrT+Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vj5gLPNp; arc=fail smtp.client-ip=52.101.126.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYGQI+zBXMV/ASYz3NvW7NCHmGzj9fatUwqZIHzAzWIJRJ+Lk/qUiql/Xxwj7xxCYHtBioKbHZvlWapRTNG31KGia+Uqa4yiYs9KzVVdOGmDWSj8DQY8EaTpcoxrmVFcyn6WWkk5Y4MfsdYNYanydfT+xpm1XXR/r2rJzz11YoI2BVvAToZR6oebnH4HPJtBFguMunfvt1qIVGTbITWh6V/XE4+eaPx5GqQP9mD3gvzSqpekMp0qXxUyUqzXu3bainGJByib0ljdHteiaWoO+kctE3o9CRQQDIjIM5PtRPTG+N45DE173DVVSjfzca3KvwxYl91Qp6g5S8FEVo3i7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+11oxe8AJPQgNFDSMY7l1jgAU+N2kSyc5p8bN2nhtjk=;
 b=IkiMkNfbBsU1I33+8Hgy60c3AL1Ejz1UfokCHCdQGUVkhURJk8a+Trbtga6ZG7hI9IwAV23oc7ehsr6JX3uBFS8VTHfIIG5h2a2jGm1UaMnSDtSTe16DSg0sTTpgHkZ/MSiEPJndeDsLRLIuVN0tfeoQjQLOZH1/n1dRC4frlzPA6Yp2YioaSCx1rFBdEyr92Q8+TP/LfzpywCSzyolFCyxnKq9CV/izmRYwQkpUqZdY4vxg4jUCWmtWFZ+yQihclaNCU3yHCr250SFflU6ffc7ubdhwZ/OttQV+ALbvqUAlFBCk+f14kkIJG260JTXINtVtd+8xjPEpLmbKyemV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+11oxe8AJPQgNFDSMY7l1jgAU+N2kSyc5p8bN2nhtjk=;
 b=Vj5gLPNpTtS6K5RBw0SiJGQyj1sR5QlPlfwZgQCaF7LhANbHS/edtYzi+0bHDMwSleIL0BOl1LKjwS3Bkx3cW+gCXT4jsmjqlaxJ0pPhvdzrbURXCQBee19dgDyEJtisJv9UAR2D9XPez1svJ98U7dTlJtqiHZXtiOItlVY8W0a5mwWxUe8jlIykxWF+4jLtsBcUzl1fLlMFqP6YAGEJDoghG3hIIu18wFabXn26tqTqHYOCNs78ErxH8V0g37Hr9Eg2f0DAVujL87c+4lcx/ZWI88SatIBsIUrbe7v17gjmv5DZz9xouN0wjdjgzJFklOuPrLnCI+LWBSl/zWROGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB6220.apcprd06.prod.outlook.com (2603:1096:400:35c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Sat, 16 Aug 2025 07:29:14 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 07:29:14 +0000
Message-ID: <61dbf3f6-6b45-4823-a7ce-794c3ad5aca2@vivo.com>
Date: Sat, 16 Aug 2025 15:29:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: use min() to improve code
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815080649.582775-1-rongqianfeng@vivo.com>
 <8b739044-2854-441d-b744-b014deea4eea@baylibre.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <8b739044-2854-441d-b744-b014deea4eea@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c83c83-55f8-4f40-85c2-08dddc9699e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDM2eWNSd0xKU25laFZYOXJEMm42ekxCSnhKUVhDSnR4MFRTSjBjellzK2ht?=
 =?utf-8?B?N3FIR3J4RDcvaFZqSVdnL3lHSDNLNHR0NVJTUVNpblpwbnY2bFMxSXRjMTVZ?=
 =?utf-8?B?clFTbjhOUUR5VVE0OEUzOGU1RktEeEVleVRtYmhINVJXZW0wbi9EVEZqNTRy?=
 =?utf-8?B?UUk1NUZtbUxhSmV3bDRtTHVudHlrSGJ2WGRXSlpFVXBDc3FEZTliM21uQmFC?=
 =?utf-8?B?eVBjL05lNHVFeGdEYTJSQlRyTHllM2pzbXhwaVJkZzRqU01iaFhSUld5WVlK?=
 =?utf-8?B?alpwZWF3dXFtcWt6WW0zS3JBVDNQcURhVjE3dHl2M0R4N1dFOU0wL0pmZHJ3?=
 =?utf-8?B?eDVCTkFrbXBXMHdCNlZKWkVoNkFrZWo5WmsvRDJVMUMrR05UVk9iaWY2S043?=
 =?utf-8?B?dUVEMGJoZFZZYjFXbHpTSUdPYWFra2NaRGwra25KVENGbmphNXUxNDdFWmNu?=
 =?utf-8?B?Y1BjN2lpRGtwOXhGMFFrVGVrTmhFQVF4MUhYRkdHQ0Ura2hzZ1BXS3EzM0oz?=
 =?utf-8?B?WW5CdUYra0lTSCtVcEZGMXBWY2RlTU1GWDQvWS9vMHZTWExOTUkrdnMvbDRp?=
 =?utf-8?B?enJxVGE4Q1hYbXdPZkRwbFU2WGpCOGFJZ0lPaWNmTSttUEUzWFBGSi80bjVW?=
 =?utf-8?B?NDcySk1HMFRsYnoxdERjTmVxWmQ2TUUyN3p3MCt0Z0lFWFpHQ21TYjBMWS9v?=
 =?utf-8?B?enJsKzdjSDVHMG0vd3lrbEcvWmt0VGIvL1hNZ3pyT0NsZDU5Y2xwUy8yelMz?=
 =?utf-8?B?OS8rZkUzcTcrd0hrSzRRUHZTSkoxZkFtYUo5U2FiZFNzWUM5Z3BWOTJXNTcx?=
 =?utf-8?B?M2RNWnc4SGNnZXZmWDkzTVh0WE9BRFp4TmQwczY1QWJiTlF0Z01FSnNKRjhL?=
 =?utf-8?B?UlNuMmx3cExJT3MxUzBVYjBoeEdreXhMa296SmpaVVNrdStXNkE4QnZKelNh?=
 =?utf-8?B?SVFnN0h1bFFRSms5TUNmMVQ3OUlGcC82b0JEd2JEemNkR3loOU8wYlhFWURT?=
 =?utf-8?B?WHFBZE9HTy9ncmYrcVM2R0wrakxNdXlCZUxYVlVuZVV3YlBJbFVPS0lxSjh4?=
 =?utf-8?B?dTE4SEQwdWNqZStHb24zNms1dk1ISFFZR2ZJTzQ4ZEtiMHVsRlJueXR3MXk1?=
 =?utf-8?B?L0pUOEFtZFRaWnlzcjR2anFtUUpxSlhON3Z6WHdRS3JZSm51c1FoeHd6SWtQ?=
 =?utf-8?B?OHVjQ1hoNmJIYTQ1bjlxaUpMZGNIcEpLOXo2M0g3NlorekpHV044eDNWL3JC?=
 =?utf-8?B?WUM2QmIwbGtOQzdUMkFlOVRTTEpVaGZCVDVQRG1BMEFUTEs1QjZrUG11SWsr?=
 =?utf-8?B?QUlNc1NaMGR2RHIyb051UHZLa1JnYjZEeFZRUTdHNGRCRkF2bVZuLzVEOWE4?=
 =?utf-8?B?UFV1d00ybnh4MGJOMnZ0NS9xUStEcWRqSDBoKzU4UmVJcFQ5enBkSU12eUZT?=
 =?utf-8?B?aERxSXZmRnRsQ2RTRk5DVzk0aXpadnBzS0ZkWkc4ZmpnUWpPVitMcGo0KzdI?=
 =?utf-8?B?bjYxMG44VFF6aXRiMFBoS3hHTktkWnZrZzg0d2VPZHJSTU45aWZQVDZ3Z0VS?=
 =?utf-8?B?dFZtRmZzamJ6R25LVVRVeDZzdmZXS2d0QnNuNG13ZW1CZVN6UzJJTGswc1oz?=
 =?utf-8?B?Q1hlZ1Nkd2FwOVpWdWcxUHhZaEZBcStRQjB2MHo1aXdTZGJnYWxFRzc0Q1Fu?=
 =?utf-8?B?cndySitNMDV0WlBGay9EcWJpeTRDd1R6d09CM3U0STF2N25tRW1ZRWhZZW5I?=
 =?utf-8?B?SExOc1hFQUFUeFVWOHIrN0dxb2VXRkdtUG1JVHBGbmhhb1RjUG5BMVVvMWlt?=
 =?utf-8?B?dUhZZTAyU0l3SlNaY1haN1dYVlEzUUdqUVZVTmJTRHRqSTlON1JyM0gvWEZj?=
 =?utf-8?B?VGpRRE1IMnp2REhucXl1R2hOTWREcFdsZzI0SWZQeHllV0NGQ05VMUgzYWZV?=
 =?utf-8?Q?JRvJVTNdVr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1VFZ0JnekxMUU1kN0ZMV3RVNGU0ZkF3V0w3V2VoZy9USzI4L0ZEejNtWGNQ?=
 =?utf-8?B?YTBCWnpGOVRuTUhCaHVsOVlRZStwcm9lNkp1dFpUcUxQWXc5K1FrMlpmWW5I?=
 =?utf-8?B?V3J0ekp1Y0hmZnQrK2RBeGljWUhQMFlKdVpKa1B5bU5tbE4zTktsUjNKc25u?=
 =?utf-8?B?YjhuUy9pSTFJVnJIbVpSM1NHVU1tdDVJcG0rOGkxbU9rSktaVjJJb1h4Z3Qz?=
 =?utf-8?B?OHd3SUJUYXQ5WjY2QzZISTdWVzJRdjNvNXZ5d1NRVFhYNXk4QjdjalBTcFZE?=
 =?utf-8?B?TmRnTDJVbWFMSmlGWm1USjdMcjZNRkdVMmRPZ2owMHNmZnZQdXBwUm9mSlJ2?=
 =?utf-8?B?NW5VRjdkcG1pZW1VUVNQbTFQMVlsbVJvTzF3VllHNmxSbU1kWEJpWHhFaXdv?=
 =?utf-8?B?a3pnSUF3L3dwSmVQVXhTeDliYUJuMHQ0WHhjNERZajZKREhzcVpsUTJtaTk4?=
 =?utf-8?B?Qm9xSmpyZ3dPM2xNSDJJQTZxRmVLQ3NCbnVNR1JHbXI4NDNLK291MjZOb2li?=
 =?utf-8?B?MjllYXk4V1ZEak5FTjFPaEM2TW1JWTFLdmk3aXlycmI3SUUxVVV1RXFsSmJz?=
 =?utf-8?B?MEZyQWdBZlp5Z211cEExRFJKbzBNVjJobnFqUmIxTkJqYlZDdVhncVVrcVBS?=
 =?utf-8?B?STRyb3Axd1U4Tzhyd21GdVpjTHZ2Mit5alkrSmZlYTlnamZDclBvYU5WbFc1?=
 =?utf-8?B?KzMvRExZc2Q0Q3lsZXpSaW82dk83RjRjN0NoOC8yMXRzWE9MTjhNeUNGRXRP?=
 =?utf-8?B?V1RnVlpJSytZNVBRRTd6TWpFMnk0c0dpMEZGa2ZmVlR0WVBiQWlybndNbWlD?=
 =?utf-8?B?RmZ0RTdyYk5WVWJXM0hDb3FyTHJudGY4YTVmNnduMFhMUHAyZzJxRmhRQWM2?=
 =?utf-8?B?emNWc1N6SnRIeGlnU3dRSEY0Q25NL3VFcUdHNC9jVXhSc3pPVjFJc1ZnK0NS?=
 =?utf-8?B?NSs4SGcwNDVwWkVUY3l0VW5uQlB4dExwbG85Sk9FZTdZcEwvaS9vcFpSNUxi?=
 =?utf-8?B?SXhROW9yMDNHNEthSlZNTnpOMVl6V3AveU9QRXcyU2llYldGQm5EQmkrL2M2?=
 =?utf-8?B?V0txTXNFYVRma2NXUjB2blpWMDF4Yk9tSGtJdkFiT25NZ2hySzZWTmZWRmN5?=
 =?utf-8?B?eVkySnc0SDJiaWswZnkvbE9zZkpkSCtrZzdybE9xMFhtTkRnSWdNbURhdGdj?=
 =?utf-8?B?ZmtkUWVBaU9FU2s3ZGJ1V2E0RXdtbldGNjdLaXF4TzZWS091S2RTdWptaTl2?=
 =?utf-8?B?bHdJdGphejJVTHpSNWZ5UTUzaGxtR3BRbTFWbGozYUFSMU1rRm01Mmw2WjdP?=
 =?utf-8?B?TU9BSXgrNlAzTUJvZCthdllZd0NqdUtvV0RJanhiSnNRb3VVckN0MXJJbXRC?=
 =?utf-8?B?Umx2bGl4VjZWMjMwM1RuSVJsVncvekRaT0dFQlRXK1l2cFY3SXhmenFMTkYz?=
 =?utf-8?B?MlltK0ROWDlZQXI0clc1Z294VS9QdTJzbzErcHFqSEJSemUvWDZXZ3hPQng3?=
 =?utf-8?B?N3lobEU3M3RzK0M2cVZFK0Z2V3VSREl0V3FkS2Zad1N1U3dVTEFSREh6b0tz?=
 =?utf-8?B?T3JFUk9jUmJjeXZTKzdEd1BDZDN4TnZ6d252UXRzVjdlTTV6OWJBbm9tQWNP?=
 =?utf-8?B?OTF6bjByTUFwVk84VTZkbGNQZXJwUVhSSlYwMkpXcE1kSXlaei9HZVZER3ZO?=
 =?utf-8?B?RHVDbmVUMWpZRXBES3pSTmgxRjAvcnR1SW4zTkdEY3hKT3FPaTE5cUQ2Rmpj?=
 =?utf-8?B?MlVSbFNFZjNscWdzV29jQ1BybHpRSUJjUVNySEdRZWs1WWpJdWVSZ0NqZW81?=
 =?utf-8?B?bm9XbWhLZlZ3UFN5UHRTeFFUL1BWN2JFd3VFaFBpL2FwNFdWaXRvcjhqQ01Z?=
 =?utf-8?B?QnB6L2JDeXVPd3JzUlMwdXM0c0k3aHJTbExnSzc4ZUJHczdhN082cFdQV0ZG?=
 =?utf-8?B?Sk4zZXpUUFAxaHdjVW5PajRwY1g3UkVHcHkyMnRLTlNVamJBbEM0VVlhUUN2?=
 =?utf-8?B?VjJpSGFTdzRNSnV5aDlDMFVGVUZscXhqT2wwdXJ0cmk1RmNhVENpRDZRUkVN?=
 =?utf-8?B?ajdXWC9IYVFhNG5EWjRjcDNvVGxSVU44b28yeTViYWozaytjSXAzU3ZrcHdT?=
 =?utf-8?Q?/hG8yHXdiJYVrtXT/9wnJwoc7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c83c83-55f8-4f40-85c2-08dddc9699e6
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 07:29:14.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSRV3sW4ueU3mlcHZbjdigUOqvI2Cy2JO+T1TZnqs7QTqLYLhrvooKt5MEBvsSEkQ0zgy6gQNLhQ+gCjODwhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6220


在 2025/8/15 22:25, David Lechner 写道:
> On 8/15/25 3:06 AM, Qianfeng Rong wrote:
>> Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
>> and inv_icm42600_buffer_update_watermark(), and improve readability.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>> index 7c4ed981db04..91d166de1231 100644
>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/delay.h>
>> +#include <linux/minmax.h>
> Would be nice to put this in alphabetical order the best we can.
Thanks! Good to know this detail.
>
>>   
>>   #include <linux/iio/buffer.h>
>>   #include <linux/iio/common/inv_sensors_timestamp.h>
>> @@ -112,10 +113,7 @@ void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
>>   	else
>>   		period_accel = U32_MAX;
>>   
>> -	if (period_gyro <= period_accel)
>> -		period = period_gyro;
>> -	else
>> -		period = period_accel;
>> +	period = min(period_gyro, period_accel);
>>   
>>   	st->fifo.period = period;
> Might as well just drop the local variable in this one and save
> another line (and a blank line).
It is indeed better to drop the local variable.
>
>>   }
>> @@ -238,10 +236,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>>   		else
>>   			latency = latency_accel - (latency_gyro % latency_accel);
>>   		/* use the shortest period */
> We could remove the comment as well since it should be
> obvious from the code.
ok :)
>
>> -		if (period_gyro <= period_accel)
>> -			period = period_gyro;
>> -		else
>> -			period = period_accel;
>> +		period = min(period_gyro, period_accel);
>>   		/* all this works because periods are multiple of each others */
>>   		watermark = latency / period;
> Could probably also drop the local variable here and still fit everything on one line.
I will try to do this in the next version.
>
>>   		if (watermark < 1)
Best regards,
Qianfeng

