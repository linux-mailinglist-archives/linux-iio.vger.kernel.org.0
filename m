Return-Path: <linux-iio+bounces-17542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD9A788D3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BC13B005C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD9232373;
	Wed,  2 Apr 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BrNFsuql"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551791F3FC3
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578946; cv=fail; b=rIMQYTgRknvUwTlzy0mq72NaYBT64LuC/DeXYQcWc5pH2mVty4XIe09M1Q1Z39ebno0dkjy4f3d74CQ9OfVPCHXPlcK88PxHKUff2M8LzHOBLECQV/DY9EDAMR3gwEBIzHmkBw4bGYByMzxCtUEifZPg4/ce71HkvPhYD7n7rhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578946; c=relaxed/simple;
	bh=QLZD3XEIZ1bqxaHM8rO8Qy/PBHQ5jxQjJq7aeh6TpF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKNJH0/TuIJO2J4kofy6NL1EMVBGAFHWP2WK1gdaDn34m277oHYTcrR/J4E3z/Mx8pTcCv5bpIJV2hw7Iu6omwrZ4+wcf02EwGKXxTzaeBH5kgnWI1gs5O9heoGJE9KlOsL861yqOTOSFdPqTiWVDvLhnuo8pcC+hb583+gcfcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BrNFsuql; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LilZtVm8R5Vs49DbbR3Zwrr5hEyeKWRlk4MFh9/RETXrKxAAm8jI75KWv8mQYrDJDTR8IJaQgxkf4+Lp2rFangHGJu+dbg/70JSSVUzTnoaftDoVNDugDQZGLcIlQjR5G7Eg0XFTPGSYnsPKQabpyKzl4Pn8q4tHLe0tJO0TrPAeCS0Led/ZSopFYOPQleTiiVXXDVQ+oOIKOGV3gjdnc4Nb6wHEpSNvijzBFj7J76PJx8SsIPRfB7xSff9RLoxcjvWp8ZwjHcisRsTONqS2/SdbWfiolKd6tKZpQZLyRpmkxUay6j3H1ZVIQd4CJY0tbibKfJ1Yc0rxM5mqxjbObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVfJeptHl9cHrRD8Dl9WIQZz/KFJc4DTKh/XBuUAJz0=;
 b=Gvylx2zhZ37qCLG2J1kcGwtXHnoKYpWSRGU91B20kefG91VsqH+eKXbOxqXo00rd1DbKtYlv1GGDNpdfPigiTKutUSWGtDAXl7h9KIMvO9ANXDiaS/C6AEdd4d5dNb5kIo16mC5roE59e0bdz1CE5PuGXgqGiqs7FN+r9OQHEyQcRZTUqF4mJzVmdaMxf6CDoha/L5o/TUch5RJ1RGQ7PxgWifeKJbCZwMroypg1i522cpktlLRz1xCOxN1j8Hki5on8wBYtIsDRuR34ndSL/SpjYJzXHdDD0tuG/ZfoIcHi6mtJGLpDU/bIuSbo27tRtcFjye3+3chsSAgs/LtXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVfJeptHl9cHrRD8Dl9WIQZz/KFJc4DTKh/XBuUAJz0=;
 b=BrNFsuqlzctJUJyJ1xbQcoGSgof2b1aWUyvfsdgn6LapQ5zicrRgFmFiX3brgqpJriR+rszlRJfL6c5I3xN2JcEfFLzrvRli0qOPJoR2T/fov1fJbtDWMXkLEH3q7RBfLzMQLsL3HDVwSEPbOtp+6t19rsrrArsJ9P+W37NJOSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAVPR02MB10415.eurprd02.prod.outlook.com (2603:10a6:102:32b::7)
 by AS8PR02MB9982.eurprd02.prod.outlook.com (2603:10a6:20b:616::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 07:29:01 +0000
Received: from PAVPR02MB10415.eurprd02.prod.outlook.com
 ([fe80::9e91:6e9f:c23a:bc57]) by PAVPR02MB10415.eurprd02.prod.outlook.com
 ([fe80::9e91:6e9f:c23a:bc57%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 07:29:01 +0000
Message-ID: <6336de27-dbc3-421c-bed0-fa053831db7e@axis.com>
Date: Wed, 2 Apr 2025 09:28:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] iio: light: vcnl4000: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-18-jic23@kernel.org>
 <4d1666ef-8683-4d54-bb4b-7d858569c5a3@baylibre.com>
 <20250331124408.69c27d42@jic23-huawei>
Content-Language: en-US
From: Astrid Rost <astrid.rost@axis.com>
In-Reply-To: <20250331124408.69c27d42@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To PAVPR02MB10415.eurprd02.prod.outlook.com
 (2603:10a6:102:32b::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB10415:EE_|AS8PR02MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ab5572-e9a2-4ac2-e646-08dd71b809e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FyazNvOXMwdWRMcEQrdEFCa3BrdWVkQlhObDhXVjJKNzMvbUljcEg1RXBH?=
 =?utf-8?B?QUxVcWRJZkNhcWplM0VCU3ZjMFJsalRtS0JlL0o2YjZXRFpmcDZSSmpDTVFw?=
 =?utf-8?B?YnFMTkUwWVlrU1Z4M1NtUzE0VUNndTFGdU9kMEZaZHoySGFTV3hidHcvbGhh?=
 =?utf-8?B?VndOTGRxdVVBOU1FQ1NXUXZjSy9tMFE4b1F4U0JJMUg1M0hxSVNXZ0VkTloy?=
 =?utf-8?B?Sk0rMU1JR0lmYnRKeTRCY0phK1RHWnhqVTR4QjVpSGQzOUNnaks1YWhXd3pV?=
 =?utf-8?B?Vmxyd0QyUVZkd0xVZVpZV2tFSytWQ3pNdzRwRzUycEZiL29FMlN2M0hlSmJI?=
 =?utf-8?B?K2RlYkxxNmlvVDhVRjhHZFZlTEQzcGJnRVdWc1FmVWJxa3hDSDFqWExrdWtn?=
 =?utf-8?B?U2hueitOMDhUakxvd0M3N2htZ0gySlRXbndzUWgwazBMcHUyTDEwL3ZEeUJU?=
 =?utf-8?B?Zm5XMXVrUDdIVjdTTk1WU0twQnBsbEF5K0R0aGpIK2VqM2NwV2s1dks2ZGox?=
 =?utf-8?B?UTZWN0hQeDVJb2lKMEZkRXFRUlNvTjF0Sm04aDYvajArSTFLZVhpK2hXSzEw?=
 =?utf-8?B?aHdCR2h4NklwV0x1RU9KNkcxSXhuOWxvSUdSMXNtV3BwdmU1aWhKRkF5Q1Ur?=
 =?utf-8?B?L2h2djFQMGJxbVNmRWRpTms3QUJCYkZlSkQyYTdmc0ZwNGFERmlSYXJOdUYz?=
 =?utf-8?B?SloxVmZSeW5oODhNS1hBam1rYjdEcXI2dkxUdWlQa3M4NWk3ancza2V5T01E?=
 =?utf-8?B?di9BTitZZFB3eGlFZ3BoRkZ2aXdpSzdRTFVsY0JLK2tEUUhzditha1JobFFZ?=
 =?utf-8?B?eVM2WmRqTVZ6bjM1SVhmU09UQXFwdjVYdklMSWROZW4zMFYvT25YYmt3Z3BE?=
 =?utf-8?B?bHZRbkJCWk80dXZ2QjdCRTg3Z0JYL05RcDFnZmFqcXc2ZWQ1M204TmZwV2lJ?=
 =?utf-8?B?M2VQdi9CeW5jbHh1ZUJ6VmFqY2dzbGJBWWh1MXc1ZDc5UVc2ZU9jbmVJemNm?=
 =?utf-8?B?N20yQnl6YklROXJVOStjZ3JkSXl1UzZXT3hpR2g3QlJwaFBNU2JxRmU5bHJV?=
 =?utf-8?B?MjdsS0ZKZFZQYjdadlUyb1V0VVRQTk1VbmI3dHg5YmlBMjVPQnE0R0RnQTNO?=
 =?utf-8?B?NjRxRVU5ckhRUnYvWlVHYjBpYmRBb0FUbG5JVVZnYTdhK0dyYUxnaXhvRDE0?=
 =?utf-8?B?bUZLVW9HbnNIREpWd0lpYjlmTUdlb0pyZkNTTVQ4TjV1aDlsOUx4K1dzL2VE?=
 =?utf-8?B?ajEvNzMrZ2xidVo3Z1F2U3AzYy91OERoQjlLN3VZK2ZKalplMHFsQmQ3T2J5?=
 =?utf-8?B?SjFnWXBaNGNDOU1rWHl3R1RibkhOWGhmeU9aRjZXN3dhZU1RM0F5cjhtVWhW?=
 =?utf-8?B?TFhQUVB3MVpCNEszY280NC9TUk82L0VQOXlZS09Kd1JqVUZlcUpXTDdwdlJp?=
 =?utf-8?B?bHcvbWN2ZTZubDIwemtnWFVKK0lMU3B4b3p5K1FMSDVPTlg4QnNPMDJUSTFY?=
 =?utf-8?B?ODRHSGVqVTg5M1J3REswS24venVqdk5vNS9xd0xMbFdNdGhrTjBSVTZMKzFN?=
 =?utf-8?B?c0pSKzdXK3QxUy83OG11TXgrRXlOcXpmMHFrM2c1V3BrMmxtNVJGN1B4S1I2?=
 =?utf-8?B?NksyNGFNTndqYUk5UGFTc0t0Q3U5bFZkWDJ3ZkI1WFpVTm55SUJoOTJHQTVL?=
 =?utf-8?B?UDZJZDlFdFJYYjg5WEd5QTdTOWVvWmlHbzI0UmVpVVFhZlIvUkZlS0FRTkVi?=
 =?utf-8?B?ZHBNclFoYmkwRjJySyt6WHBUS01UYkxEYUtjOWxTNE80MDdlS0htTktwcE5P?=
 =?utf-8?B?VW5RV2pDQXo0MWR2T3FDMTlZNkxyY3gzcjZWVTFLa29QcjRQMnA0ekxsak81?=
 =?utf-8?Q?vQY9MNaxQqnYn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB10415.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmU0bEdxRGNxUUJCY1RSQ1NwT3I3UHprajdHUms3alpnUGw2Y0lmM0VKM1kz?=
 =?utf-8?B?d0lxdGxSa0pwVW82QTgwNjIwNzNteWVMclJYK1BIRWZ6ZDU0OFdsY3BuZ3Yx?=
 =?utf-8?B?N3pndEZaUlRINzJsLzRIdlNiS0FtN1lvNWVIQ1JQeG83WU1BT1FrakJRQWN3?=
 =?utf-8?B?NFpramtPWGthYUJzRjJzZFphK0FNRWQ0anVtQW9ZRW9ZM2NuT01xTG1Id3FS?=
 =?utf-8?B?Y04zT1RtNFdCZnBhRzN4TlpuMmdhWis3UWFqWGUwRU5sajJJYjZmZEVUVVlF?=
 =?utf-8?B?NTdnSGc5RHVnNVVna3U2emEzS3RsTGJnTmkySGVKaFpTUmFmTXA4TDV2VzRV?=
 =?utf-8?B?OTZJS3ZXdnMweUVUOWRVckNvbStKZ0k1cXYzd002Zklkdlp2b2IraVJlNXFr?=
 =?utf-8?B?Tk1pTis3bm0zaGlJbUphdWpwQW84bEFUUk05YytWVFNiSEVabVZ2MVhJd0tF?=
 =?utf-8?B?Vnl1b1pUY1JqSWV2SWw3cGgwN1NHblg3MklpYkswQklGZVZETEcxbVlJMDVv?=
 =?utf-8?B?clVDcVQ0NDg1VUdvVFB0cmo4Zkt3MW1ndE84S0c4UytsZkFJcFZ2TmtuVUVl?=
 =?utf-8?B?Z2d1Q1lVeDBKeXI0emZsdklmSDBOZjVBdHVhbU5rQ1FmVmRwZ0QweHM0N3dp?=
 =?utf-8?B?Q3RGMWczY2ZLQTJaQ0xaaTRDV3h0NTF3VUVCVWZoRVdLdWsxTU9JVHdwSDJu?=
 =?utf-8?B?Vk12ZzJ5UFlWMkJsQnpaeTRHbmVOY0I4bUVVblNFYlNVK0t4bEtXQ2M1UmR4?=
 =?utf-8?B?OWZGUDNGMVg4UnBoVGZEWTM1Yk1wVWsyMGdxUUR5alhrUGJTU0sxdlkxRmlJ?=
 =?utf-8?B?c0pReWk2VWpmT285YUdXeTd4SitvQzdNaTVYUm1zZjBSVFFEM0ExeEJPOGZP?=
 =?utf-8?B?aWhaendYdUFma3RkZDVjNGJzT2txUmtkUlg3bFJXWWRzRXpSVkt3MXhlMzgx?=
 =?utf-8?B?TVU1UzdtNDA3TnVNZ1lUemdUN2h6T0tEWHBSMDNUNzlsSVEzZWF4SjBHZzFW?=
 =?utf-8?B?c0JVWmlnSWZEOVhsVmVaMWdXK25XVTVvNVBYQnN5Sk5BLzVyMjVVQ3MvOWNY?=
 =?utf-8?B?WjNuNyt5d3lTODd6S0RHRDU0R0dqZlVGcGFYYnFuelJYSDcxMGVlMVdqMEdN?=
 =?utf-8?B?K1ZkRExvRDZxczI3Y2hMTWVhSlI5S2wzR1N6cmFiZzNCRmkvd2FOaFRNNlVC?=
 =?utf-8?B?QXF0RXU1VzFTRTdtNDBIa3hpU2Jua1NXUEdMY09xcWZEQ1gyTUdMSEZ0Ynhk?=
 =?utf-8?B?TytRT09LRk5xR3ZUUDlhRWViK3pQU2pJaW04MjNldFZ3ZGJCRm0zNmpJQnZl?=
 =?utf-8?B?RXpmdk5uSkIzbFFmT2tCa1pjM09nMHlCbFc5eUtLMm05R2UvM3VpMmtlc3Jm?=
 =?utf-8?B?N0NuYjBXSDJVN2lOaTZXMzFrT0FORTJnSzV4WTI3bjFOYXJ6ZjFMcDcxbDYr?=
 =?utf-8?B?S05uTnozTGdWOG9LQld5VHVkdnZNUmlFWTVmV25NUWhVRjBZb2F3ejAzVlZ0?=
 =?utf-8?B?endxdWwrK20veGt3cjBXd3JxNW5wSDFZQ0NZWS9FcGpWWGp2V0lYTU95ZGpa?=
 =?utf-8?B?eEw0emxVeEwybU8zdlQ3bkw0VUxuWHhMVXJBSm5hOEdLbmZKbERyNGoxVEVn?=
 =?utf-8?B?K1c0WkFad0NlbXNlcmtPaEhuUXBTQ0tjY2VUYmozeUdwWEh3bnRWcnNPN2Vp?=
 =?utf-8?B?QTRtRm13SktlWlcwbk5IcllBYStQM1JSRmZuNE1uSmhycG9MUGRTZWJ5N0F2?=
 =?utf-8?B?YklLdXlnTXJYdGJwb29wZmVHQW55d0RuandWSzU5aE91dzA5dGNqaWxEb2FQ?=
 =?utf-8?B?V0p0akl0T21mNEpKU2gyK3BrUmZpaHpqeGdRZXhpdHZhcmUzcHN2YkhJMkx3?=
 =?utf-8?B?U1FuR002MlRyc0FROWcwbzA5YkJjMUY5UHFHQmJRdllkWkw1STJVT0FnRndF?=
 =?utf-8?B?Q1VuYi9PZHlrYzVHRDdQbzRENFlJYVRrQk1wSHh3a2sxMU4xdEt5aDRRdlpT?=
 =?utf-8?B?b3FkTTJoaTdaeEJNdEdVOFFaOGxUanZva3BsUk5ybWZGRG1YakJ0RDFLN2Nj?=
 =?utf-8?B?VGJNTkovYjRWQVZpeVBoZldReHljdWJTTTFEQjlHTzBHZmpEMlJZeW9PQUVS?=
 =?utf-8?Q?iKNA=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ab5572-e9a2-4ac2-e646-08dd71b809e1
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB10415.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 07:29:01.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EPyFeRx/vbvlJGkJyWI+vP55dwGvbnaDEzWGItl8oVI8LDk6Agiy2NO1hyOrza0ZQx7ukyj7Hjm14Uy3kqehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9982



On 3/31/25 13:44, Jonathan Cameron wrote:
> On Tue, 11 Mar 2025 14:11:16 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 3/9/25 12:06 PM, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> These new functions allow sparse to find failures to release
>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>> functions that are deprecated.
>>>
>>> Also split the enabling and disabling of thresholds into separate
>>> functions given overlap is small.
>>
>> Should be 2 patches since doing 2 different things?
> 
> They are messily overlapped because of the oddity that we only
> take the direct mode state if enabling.  It is in theory possible to
> do the split of functions first but that will result in messier functions
> that we then clean up.  I'm not keen on that complexity so going to be
> lazy this time and not do it.
> 
> I'll add something to the patch description to say that.
> 
> Jonathan
> 
> 
>>
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Astrid Rost <astrid.rost@axis.com>
>>> ---
> 

Looks good to me also with one patch.

Reviewed-by: Astrid Rost <astrid.rost@axis.com>


