Return-Path: <linux-iio+bounces-12146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65A9C43C5
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C193285AA9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291C91BD9D1;
	Mon, 11 Nov 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/Bp9Lzg"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D561BC088;
	Mon, 11 Nov 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346377; cv=fail; b=sKA0BsvnVYMfjaC9zYkBoCiyNdqBXf/wrbtyMZB4eC0wJtUQ6Gkri746nqA5Kyjo+bxf0XiqO8JiZRa65A23XacIiLvAVUpqIVs2UToHyR+CDHgqK4mhUSPqvpEaVMzBIwLCrUiv90PFFG5TVUL82hAE9+8WZQ92zE+gw4Xj5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346377; c=relaxed/simple;
	bh=SpDIWQ//2vxQS6+qCcRIjEy3XtKoUdTil4zQhY1xDPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l812DMrEw/qsLyMZUeYsCVNhIvFtPA5Dq0CiW9WSYImISCa4fPDmtbGCtLEojtpvLdk/CGZrxKpVSuPF38XAJoE4ounA4UkF1ZhM6+L8EwGM3cnABgGrIbC3uxGqaLQ/69B5axWFG3d4UgO5HB40Ja74BUjD2GjdfdURCXNO5Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/Bp9Lzg; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC+EaNe/2k0IoC3LkpgiWqSqe0QAT8J0F3bs0lepvspKIqyWqSC7AV4wXvs4Vrhk5CX/kPqz+5r4JORuIHMoSWbOtQ0WBE/KvJcb86xLJUkHbYFu1Nv9KoYIfw0mb3f8p9b4txeqTh33Pk6jsXmnIvcSKplf9bXoSvbFTBzvMAY51s42zw0eEiYB+CUWhXs2N3gS3Vx7Xr4kO1iziKtjwKQcibBmGUK4G6LlTqcbTyh1jh09Eo7xA018i2ylRaprkCgnpjz6mqqSYSGuHSXgTqcgNieLB++I6PrVw1BMXiR0xmzpug/Zf+vp/TCngyYiZvM/IAk+bV7E5SfBJbl1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT6CdsGvDvMzmPjYkwFsjKh3un4BoK0qxjjXVW4EnQE=;
 b=D+Hohx72lBuqCymZ7CdkjVsyhJ5EC5DX6L93yd4cLeL8ItlUHBJxyrvWjCueij8g3yNR1nT855PBeOelUGcgmE6O6GE12Kp71xwlpvcxDRgBhEqgNExB+xVOONFRSisyc32WmTYYch1Lg3WSGNcLiAm3mLN4uikGX90uKQo3ZCqeCsW9Ky89wLBBpqunRZkC536vOxNx2G9znHuwEwkc5E3Y4buOXFwJUa4nLu8bkCfqpyKnnp916jH1Tnb0+I5velabS3hW2YuTb/uPjneB2QtJm+8Qkd1P+Tf+zci+tdaB+zRZxoPcP5FUOEOCBB3p8Saq/B1Zxyv8o4L6buVswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT6CdsGvDvMzmPjYkwFsjKh3un4BoK0qxjjXVW4EnQE=;
 b=c/Bp9LzgGSHlMujWX6qF4Kcc0mIed0V+h5RkvjR7RSBra5vkSwtcv6ThWe8oqixJAzY3HRdnG7/cNLMe0Vu3dJzpX7MfzubdRD1JfBF58gvBWKdK5bZgESx4UWPbtG8FWKAvjcpWtRkUl3Z4HzyTu9th8wytD/K8rTd8C9aN0MIt0ASs0s3UXUGSLte/JAOwafyakt2mmPIYjDP0TWVkLajGTel3uAU2KCE/BxbRT2YdfOCRH0adLvJTf8fGBX83WcGssPKs9qqcvB0dzHjzYZlpqY75sQcrYSrrr56sAE5iMOFD6/pDMuygTlLLx6bnh7BGFKr+oq1eCKjfsEt9Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:32:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:32:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 11 Nov 2024 12:32:01 -0500
Subject: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
In-Reply-To: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731346348; l=2554;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SpDIWQ//2vxQS6+qCcRIjEy3XtKoUdTil4zQhY1xDPU=;
 b=oIpjlN20VXx6nYjN61WgpNP1tIR1QU/UWuieY8UlbQO25JrulQUoP9XG0cmluT7dyOPAW0YOJ
 nB0SNpeYDbLC/f386DFQ0SKe8kKngqrX68F3QpJJlnsJ6D1jKJ502Pv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10086:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f05c4c-3b86-4301-5d9d-08dd0276de7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW9rTnBTa2x6ZVVBR0c5YXZDbkJsSHBqWVBtUHpjMk0zeTVqbTVtR2lJVU1o?=
 =?utf-8?B?c2lQT3daZkFFcHJNOHhCbnk1SHhNempCRjRRaXkwaG1WQXlkM0VWcEdBYmZj?=
 =?utf-8?B?OTVrbzJoU0l3T0NJdG5hNDA2bmFZczBCUndia1RoWVFvUGE2VHI4N2IxdlJt?=
 =?utf-8?B?Zy8rcURMYkN2M242WHovY1QzY2FpaTgzK2ZrQUcrcjN5c0w0dG0rSUNTTEdU?=
 =?utf-8?B?YmdmL2ZiSTlPRkpFdkU1YS85TWhkYUpMcWVUVXNPOFNYSk9iaUlIQXhSdVQx?=
 =?utf-8?B?VFpaMFhwNUtTS3JPcjcxZlY3alRxNWdXNWd2ZTVuMHV2SVVwQk1MNkFFeEFj?=
 =?utf-8?B?OFc5VzhHZGRHNDdHYUtDaFlDMFhDZ2s2YUtjUW50RUJZRi9oY3RoVDhLM1dn?=
 =?utf-8?B?L0lEM0RkRHNLeTVyYU5UaWJIbUNCWUtzSzU5RE1iQklPWVNydHg3VzN4TkE1?=
 =?utf-8?B?Y2N4YSt0ZXhmR1ZKMyt4VDBsWlEzcWZrOFZ4aGpPV0twYU5UWUs0M1F5eHFK?=
 =?utf-8?B?eU5wQTJ4MEoyazZ5SExoWUNkL0h6NldTbUIzZ3h5S2VGcENDNmNZQUZwbzRC?=
 =?utf-8?B?QkE2eDFWdXZ0c1BaUnRjeFZ3cDNMNjE4YmNNVS9pMEU4RVVTRzVwY25OaHg5?=
 =?utf-8?B?eDdaZk52ZUZrNmFNQnZJNDZjQzZnNmpEWUhrRmxLQmo3Yk5OTElOQVh4VjVL?=
 =?utf-8?B?RW1jUVFmRGdxZ2RkQWhBaVQycGh6eGlIZHZkTXFkaWNCcVh4WHhYakwzY3Uw?=
 =?utf-8?B?Y1g3VlphQWlidDhNUEY5QTNKNXlrUjkzQXYwTlZHVlJxTUYvcmNiRDY4Z09m?=
 =?utf-8?B?NjloYlBQMVh2b1dPN3o5emlBNjdQMjZGLzVRc3pvVElRK3dEWGN4U2liZHNS?=
 =?utf-8?B?QzNja080TG1PYXJoMUtIZGdYMDFZdDl1U1IxNG4vaGtwOWloZkk4UnFGNE8z?=
 =?utf-8?B?VVFGcUdrY1UxZGJVYzdwSy9DbUNKc1lHelg3bkJ4Z2dWcjZpelpjK0lMZTZL?=
 =?utf-8?B?bGlBU3BtZ29RYkpGSWFoRUtGOWw2c2Z0QXR3Q3dvdUVyUTFrTWFNWDFaanVp?=
 =?utf-8?B?Rk5nQVhRUVZuWmFoWlRXRmc5cFZSVVFWT1h6VFFjY1NRMlZpVjJFSk5CSTJq?=
 =?utf-8?B?MjVFQ1h1VlQ3UzN2N0dCNFQrSGx0Uk12Nm4wWW00YnN3QzkvQmtxNzlXS3Fx?=
 =?utf-8?B?ejF2MFJ2ZFJtemFUdVFTNzNDTG5RM1AyeFRlV3F2azViblhraEZPMmtvcXNK?=
 =?utf-8?B?MFB5VHVZcXhKYTFiU0VJenFhVDJpdGxFNTIrdElVekVjYUZ4amtua0RTNHJw?=
 =?utf-8?B?SENDNmtIazZpNHcrMC9haFA0K0x6OXpmK2JldGd4R3VCQ1N6SS9jN2ZVWXhk?=
 =?utf-8?B?QzBxTWJ2SXZkVm1sYjZzMW1zNFpyRHZYSnRkR3ZVdEgrNFU2QjR2dlhWVnpC?=
 =?utf-8?B?Rk5YWlU1eW5oeldZK2MzYnN4WmI3THAvU1JTaHZRL0hPVS8zZDZHSHBVVGxZ?=
 =?utf-8?B?QjlwMTNDSitRWHM1cDBTRjgrQ3l2MFFub2gwYVFwdFhQcDBrL28zT3o1MXJ3?=
 =?utf-8?B?a1hHWlk0dzdja1A2SDcxa21zMWo4STFldG14bUNZUG0rZnIwUENka1A2YWRQ?=
 =?utf-8?B?MlM4VHZQTFNxV3lRUGRablVVMDJqcFMrV0laQ2FVSEtOVHhwcysxcGxLL3N4?=
 =?utf-8?B?bG1paVJVTVNmd0x0ck11RE1vMWwzUnJiTGxQQ3I4OUVtSUF3TEYzWWptTFo3?=
 =?utf-8?B?bjZGQy85OTh0WEoyaW1odGlaeW4vTi9RRXRjbmVMeGUvVHl3TFpSUDgyWWxr?=
 =?utf-8?B?MDA5d2JXeURVeitHeTFhR1pJQ1dKVFV2S1pTY2NPUUdRZ2w2ekl6djl6MEkz?=
 =?utf-8?Q?TS6VfIuF8mGPe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTN3VEJnNjJWSHo3UzRRVWNSQXI5WXhWSmVlRVZuN0dqbDdsTVJ5U0s2dXVT?=
 =?utf-8?B?REhiWjducEQrOENLcktzQzVNOHZNSkgrV2QvbzEzRFdyUTAxbXZxZkZMR0oz?=
 =?utf-8?B?Qy84YXp3Nk55OGRUcktIaXAzSFVicjdxOEVMaEU4OFkyTXBIVWp0S3k0Z3da?=
 =?utf-8?B?d0V0NlVzQ3E3SjNlZlhzdUllcWJoQXl6SlVaZTZPZnE0bUZZVFlGUERDODRQ?=
 =?utf-8?B?VGszTFkyYUJnOUZLTlZZZ1l2Z3dPRTRqNWhpSUowaWJwREwzd1hOZ3FYOFhN?=
 =?utf-8?B?ODB4ZHNuLzd2VFcrQWM0WDVGZzVUS1EvOGtNVWJPaGltUlNHbTUraDZLbmNR?=
 =?utf-8?B?ZzlaNnkxNElHUkRYUXlZekI5UHovWXN6dVVhQ0lUbnluVDByc25nTnpsenFp?=
 =?utf-8?B?cm5VV25pY0JOK04ySFF4TFlpUFhvZ0VoTFFxZUE3eHpmMFVGdVF3cFVtYzVC?=
 =?utf-8?B?Nk0xSm9BMzZpYWpOWVV6eUlkQms4UnZ6VDdRckhvUkh6ajZrK2RRMW9ISGtL?=
 =?utf-8?B?TkI3L1V3TGZtWFJKZ1ZtbVNpRUJ0WnVEa080RDFBdC9SaC9STzRKNXlqVXI4?=
 =?utf-8?B?UkNEWHRlNDY3WWRQdVJzV05OUjZhcFFzSTVPaWQ3bGlTZFBRaVpTMGNGTFFL?=
 =?utf-8?B?L2JZYlNUdDhkSlJhNk5YaldXbWJzNnpIcDU1RDhSM21FSlNMSU8xV1hVWDAz?=
 =?utf-8?B?am9xQ2s3UG4yeWQzRzk0Yjg3ejlDSVh3dGtkOUY1VnZ5ZnFwZ0F4WWtrVTI1?=
 =?utf-8?B?RW5oVGdBRlB6MnFWMHR4QmVYNzE3NkJGSitsSHdKNlU0VzMreEJOc210NXJy?=
 =?utf-8?B?MTRDeUpMYzZ0OXpFZ3czdmdROHcxeFF2VDQxdm1helRqNU9YYTVyT0hKdWZ0?=
 =?utf-8?B?UVA5R0xZQ3QzOTdwOEVXL2ZpK3BnejJ5YnM4djd2VzhmU0REcW5WdUlubm95?=
 =?utf-8?B?T2JlczBXUUdGVjlGUGpyYlV3TWNIb3ZXR3dWakxpd0JGOFExajBHOVJtNlFI?=
 =?utf-8?B?SG1NYWthVmF2RzBzMTd4TVozOWJOOE5zNmtmYkY5T2lMTEpnOGJ5UnZVSWNK?=
 =?utf-8?B?elo1dWl6WllrQ0l4VjQ2akxrazBySndISmFpNlJIU2RqbmxqeHJGOW5JbkI4?=
 =?utf-8?B?SEoxT29PaEVYY0xTa1BPelh4OXFublI4SFU5WmIwMGVzbGx2YnozMy9nOXBJ?=
 =?utf-8?B?TnJKdjRYS1ZYdlVHbklRK3Q1S3NNUmxIL3I1ZERCMjNkZi83bVJJeVFWNzli?=
 =?utf-8?B?ZWNSU1JSR0xDdk4yMDJBSUVyQlBqYnRmTmhCT1U1cFYxUzRjbStSOXdsTG9E?=
 =?utf-8?B?Z0kvTzQ1bzRoRDE5bDJwWVc5YzZnak1jS2ViL0ROV0RQZkNhelh1K2lZeXRO?=
 =?utf-8?B?ZkFNd1Zlclp3cExBbU9qQUhkTHg1N2ZhazdjT2lMR0FwOHdkT1dCbnJXRlU5?=
 =?utf-8?B?L0J2T2xaK0lQSjV2TG5xYUxxS0trY0ZXVnBtUDcxOUxoSVV0UDlKK3VUTWpP?=
 =?utf-8?B?d1hneG1ERURTdXpUbnZyYkhucGx4MGNxaFdGcjBkM1VFR3ZEaFdGaXVHL1V3?=
 =?utf-8?B?RWZsM3FmTThTL0piSHJ2TUloa1VVeW1NazVGcmxvNkRwelNVaGtSeFRZQmow?=
 =?utf-8?B?S0MvSkF2QnRESVdpZjhnWE5pREN2UTB4Zk5iVDBWb2EweUJtSXVYVkNWcGpL?=
 =?utf-8?B?RVNTdmtwQmh5QU5xTVZuclhEVkxkcGh3TWlaODNCOStSZ3lvYWl1VWdtZE5D?=
 =?utf-8?B?bzhnS0ZOUFFqWit1ZlpCVHZkb1lZY3Z1d0hJZStxUm1wMjYxTzZCQnpudUU1?=
 =?utf-8?B?VG1uRFRyN2JvTGlqV1pXbzBkelBpbExTUmt5SmhNOVdabWZhS05Wdmt2Qys5?=
 =?utf-8?B?cVUvVmx6NUFTOVRTOUxDRjdxeEVoTjR4UVVpOC8vZE56enhCbVAraEFrbkRz?=
 =?utf-8?B?K21QRTg2dDBCejNqKzVOb1U5Sk50MFg4QWNyQ3VHNEYweGpoN0VxL2t1OHlt?=
 =?utf-8?B?NWpnSE42dmFaQ2ZZUWNTUHRheFhUSTdTZjhIdE14K1kwQUFTV2Q4Nkh1ckFn?=
 =?utf-8?B?bTdzdWZ6dEFFZ0MyemhhWWF6dGJWMlFuaGs2TUx5Y0xBdTB6ZEU5Z1RKc1RK?=
 =?utf-8?Q?4cYxDN6nvz0YeKBgDIvPCLWM3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f05c4c-3b86-4301-5d9d-08dd0276de7c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:52.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGjZxn2whdG1axEBtNPWu33HEX2oqfJv3lxFSgYkc5+g4GNq6cGk/Vz0rSElFBb3FwSSPdcV2phE/5g4O3CTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

Add support for I3C device in the tmp108 driver to handle the P3T1085
sensor. Register the I3C device driver to enable I3C functionality for the
sensor.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- change kconfig to select REGMAP_I3C if enable i3c
- remove i3c/master.h
- remove , after {}
- use #ifdef CONFIG_I3C about i3c register code

I2C    I3C
Y       Y       support both
Y       N       i3c part code will not be compiled
N       Y       whole TPM108 will not be compiled
N       N       whole TPM108 will not be compiled
---
 drivers/hwmon/Kconfig  |  1 +
 drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d43ca7aa4a548..9579db7849e1f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2298,6 +2298,7 @@ config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
 	  sensor chips and NXP P3T1085.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index bfbea6349a95f..deb1505321335 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
@@ -442,6 +443,36 @@ static struct i2c_driver tmp108_driver = {
 
 module_i2c_driver(tmp108_driver);
 
+#ifdef CONFIG_I3C
+static const struct i3c_device_id p3t1085_i3c_ids[] = {
+	I3C_DEVICE(0x011b, 0x1529, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
+
+static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
+}
+
+static struct i3c_driver p3t1085_driver = {
+	.driver = {
+		.name = "p3t1085_i3c",
+	},
+	.probe = p3t1085_i3c_probe,
+	.id_table = p3t1085_i3c_ids,
+};
+module_i3c_driver(p3t1085_driver);
+#endif
+
 MODULE_AUTHOR("John Muir <john@jmuir.com>");
 MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");
 MODULE_LICENSE("GPL");

-- 
2.34.1


