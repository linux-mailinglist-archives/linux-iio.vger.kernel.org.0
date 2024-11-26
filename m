Return-Path: <linux-iio+bounces-12684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728469D9AA4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 16:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339EB282F87
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB971D63ED;
	Tue, 26 Nov 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nW4KO1mL"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A01C9B7A;
	Tue, 26 Nov 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636227; cv=fail; b=UvAPq2EQdco9EqGYZ0GkSvgLRlGahKJFHlquIApvlKXbZQCDgQkPvyXMdp2XtXPTrbFWdgcOavW/v5oy8QTbrIxjhF3LdiTWW6vjxYsMyGPRG22AqX2Cf/hKcx92I9umq3LviqCLBjDFwHgc597xw5ZQuHPC7USBgFCnIK8sDMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636227; c=relaxed/simple;
	bh=92WFCF79g7cAArx31aYCblC1zZ3u3/O29FI68X4S+rU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OgnrdyG2Nemw/V89AE7auiMpDDR6UrAaBR6ngV6rwr2bMqBQ9KZQMTtUnNwRxqOHVzhLgtIBh2SO/X95m8ztawj72n3qQ4LHLV+NXld4PpViTUqPcKz+tZ3AanywsTGIv2fNoyZ+Syl1DWuNaSwrbs5MBSVIqZIEMIvavyVxaKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nW4KO1mL; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8sTrfmjOBvRUyYkkPnRDw4MAyPj5aevy9jXCVT7O4Qp57y7t9sgJ9QWbkljeWnBPyrh0CzjSfS5Bs6dvisYOhwl61R2chZ7c8Wh3nli4jLqMPfhwJHjfN5qjt+8RE9nMIkYK/bf3/NdZl3Y/AyZNlARHp08ULBWNf8oLz8bcTZCvesmZvfLxoaXsgENsLmn7rH0E/nHwXb9xyEe56NN0I7BRJv+XkJP5WYyGduFO5mlnaa17963w/HsY4q8zhjKXg4i2lvZdmTCqb792+9bfAsV35MkwLl4eoxAZEF0ZfGSvnwg0VkP5nlXwi2gTvl8RS4KxGR7EU+q02DLEwHcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlF2rH3oYajd2Cdy+hTUYAdRE6nk6CPZi6QgX0EpZsA=;
 b=CAD73BGSewnlDp4s1jYENreyCvG58TeTi3fcONT0swTlyu7BNmel3zpvHCq+fkK7sX5I5z5M7K5INfy/YqDaig/oRVUMbrhLO09iEHknMEV6qttlOSMWyqvxx/5Jmpujuor2jUotChECJpPgSSEPL7WWl+BPwO2EvO59O5WG9SqoU2XGBUbthoHvXA0ABIz8zW40vpyUzTQnjaHeDpgut9l7HdkfN7XX584W12y0PzoWGcp/qTHY4caieRi8EX6/c+Uzv9jASxiV44DcDFzEVPKnGV5/2c30VKN9tocwz9ef9k7B7XPT/gPGSQuiE+2K2v7AvogjiLIXo3C4zVAS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlF2rH3oYajd2Cdy+hTUYAdRE6nk6CPZi6QgX0EpZsA=;
 b=nW4KO1mL7QKCG1lJ6s+CDUjswkY9vdUs2yFl10POYCVmOvJyuhaJ4NPOJVetxoZKSbryLu6e90tVbN0cXvvp1A0cNLH7LX0iFY7MkS++3sodGSlMGfVzUSIvinSfoFu2I2MvyYoL/x4XqvuWhOeXgZ3m/QuaH8nLb/pLDTRqIBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AS8PR02MB10241.eurprd02.prod.outlook.com (2603:10a6:20b:63d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 15:50:20 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 15:50:20 +0000
Message-ID: <8c60a107-b264-4846-baff-656bcc480a65@axis.com>
Date: Tue, 26 Nov 2024 16:50:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Support for Texas Instruments OPT4060 RGBW Color
 sensor.
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, rickard.andersson@axis.com, kernel@axis.com
References: <20241126140002.1564564-1-perdaniel.olsson@axis.com>
 <0c5929f6-6210-4b36-95ef-79bc7028b351@kernel.org>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <0c5929f6-6210-4b36-95ef-79bc7028b351@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To AS8PR02MB9577.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AS8PR02MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: dafc3c16-6979-49d5-14d3-08dd0e3207a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0dtRHUwbTkwWTl4TE8zQUx1WnhpbHFaYk51Z0NIZFFWTXAxMUFrVGowSjVa?=
 =?utf-8?B?Z3p4cVUxTEI2SUhyNW9XVi8rTE1uUVNNMVZYcXQ1S1NXNzNoK256SmZYV3Y5?=
 =?utf-8?B?V1dmQ2RoYjJKRm40REFVdWRzNmxJT3Ztd3V1aUplRVhObWFpb3FKSy9WZlB5?=
 =?utf-8?B?aDNDRnJvODVrOXU5SXF4bVdCTDBGM0ZBcmRCMkJZODVnUExBdWdmVXJXbEpR?=
 =?utf-8?B?aU52Q0phQXVIa3NCVnZEL2l2cnExanA5YVNndE9UdFFXbTFmbWlxZlJpWnR2?=
 =?utf-8?B?NnBsemhtdmhxZU42bFFUM0NhVWRWRXkwSmxyQnlFMThSRUMyL0JydjNOb2g5?=
 =?utf-8?B?S1d4Wk5wUzY5ZW1ScXY2NTN4MGRlMU41MjlnTjV3OXZlWFdwdEw2YXpyUURC?=
 =?utf-8?B?d3pqZkYzdWl1T1ZoNWptY1VyMExSNm1VSmVOOW9ITVQxeGlEbmRld2plZUtn?=
 =?utf-8?B?QlpTanoyQitlTU5ncTJlZStURFhucER6SUJrNWFKTUI1NWIzcXlQd3hMTmlp?=
 =?utf-8?B?QXowL2YzRWFJUFlYTHg1S2hpaWhiUE10bGEvQm1YUlhyNnA1bitsdGtxRENE?=
 =?utf-8?B?U3poT1Y0OXBjZG9NejRlYkUvOC9nNGNSQmZNR2wrQ1I5dXduY0h3bnBaZnRn?=
 =?utf-8?B?S2hvN016K00zV1p1VUJESUltR2ZxMzdIMUFoZTkrWjFpYXlGMGNFaHVrMnFE?=
 =?utf-8?B?dzZreDBnTzQ2d2JIS0FRcXFhendiZG9ZQ0lVc1hBR1NjSHdIMklCeEw5MWxj?=
 =?utf-8?B?Kzk2UHUvL2VXSnRuKzFBRy91QXo1K3A1YThFTnJLdEVJcFlHV1NrRFFqc3pI?=
 =?utf-8?B?a0I5c2lQUnFsM0ZoeUJIOEttNnJrOXVLL2gyTGZBVFBBdWhmQmRUK0ZZdVMy?=
 =?utf-8?B?YUVDYXkwS3dUWGRkR01LaWRyeVZQOGgwQ0ltbGFWc3hJNWJtRUtSS1FxQTk4?=
 =?utf-8?B?SFBIeEtoMlF5NTlrNDZjWFRZeTR6NVp0ckcrZUZDd2ZiQWpDcWRJaUQvemta?=
 =?utf-8?B?aWxqMUtZckJLTXVRM3FVdEJIaVJrUk1kZjlMQWZOem55WGFlSjI4U2VPeGxR?=
 =?utf-8?B?bWtia0JVdFpCMUNFbG0vY3JFRVhNblJkRnNoalQrVnIrcmY2NHd0Z2piaWs2?=
 =?utf-8?B?QVovSjBndERDb2R0ZURxa1g5NEdwUFdzUCt1cjNUU3lPdG1VQ2NwZzNDZFB6?=
 =?utf-8?B?OEwvQW4xNjlDdVFXekg5eFdMM1ptTTRTM21yVlAwU1BpYjB6d3JNOURJM1hK?=
 =?utf-8?B?SGdtWHIwYzZvbVMwUWx2Y3Avb0wrd2JVSmNYYWM1NGx3TmoyMTl4cUJIYTMv?=
 =?utf-8?B?THJQaytTTFY0QnRjcjlhZVAzYnJ2ck5UMnpHWHQ1MzIwNHYwSFBNTUd3aFE5?=
 =?utf-8?B?KzlkN0VILysrRXdMU2R6clpOYytUMnpaWGwxZmRmbG1DSm9SUk1NZkdZWmww?=
 =?utf-8?B?NzU4YVo0NmZEeWJzWG4vWkR2RFd0K0pJd3l1QWkvNTg3cGQ1b0NKQitVMVNq?=
 =?utf-8?B?akluY2lNbUcyN1JTVXQyYWRhMStTZzR3cWdOcWNaK2p1TjB0M0JXNk00elg1?=
 =?utf-8?B?Vy9xdHh4ZHFFejlYT0lWUlpMdy80SnVDbG9ScDAwUTZLUVFkUjVNZWtZRUdV?=
 =?utf-8?B?a2dTTHhOWWkwdDhQdWFVb2syNWRGSnpnRHlaNENmcnJRQVpzTVEremxjSnFi?=
 =?utf-8?B?UElJdkNRRU1tQ3NVNUNla0cyRVk4NHNZcW1uRmdyQURvMnNnWG1kTmgwQ1ZX?=
 =?utf-8?B?eEVnNXBxT1NyenljZXFIVWdRaVVEaWhQMkFNaEJwOTVUNVpwTytobEhESWFV?=
 =?utf-8?B?NE9Kc3c5TmhPWW1CNG9xZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2hnVzRiRkFOK0hHVWlsYitiSTNHWlRaV0w3M3ozQzd3K3hUTDRkeEhVMUZr?=
 =?utf-8?B?b2ovZFBYaDBoT1F4d0hEREUrR2laY1N5NmtPRllrZ3dLeWZxTUJsM3VTRHJa?=
 =?utf-8?B?R1Z1QUFFcnNydCtuNGljaldoOExUc3pwMjdPOWUrRkYrNG11UnNUc0RpVnRx?=
 =?utf-8?B?TmpMY2kzVEIwRSsremJQQmxNZ0ZZa3E3ZzJ2NHk4bTZSRDVzUFJOZFdpMFpI?=
 =?utf-8?B?UlhXZHpiV3R4VGZWZXFqY2JDOWVBdlVZTnNkN1hLNWRGUldxY0Q3a25oMjNx?=
 =?utf-8?B?bWRramMyL3cxV2VTUWh3VGUveGUvYWd3SE81ajExbkZKUDByRDNPcjVGUWxG?=
 =?utf-8?B?VlNEKy9lZ0J3Z0N3UmZjWEx2ZEdHOXhNQ1BnMmhkSkpYOG9VWFNBN1FUQnRq?=
 =?utf-8?B?WEhxR296a2pwOUcxZUZWRjF0MGk3RXZnbk94ZnkwVno4NEoyclhWeDhEMXdR?=
 =?utf-8?B?MWdrdWJCdERicm9lcWNzblpMZmRNUWJZQnMzU0FXSnJRd2NHNGlINXQ4YWJI?=
 =?utf-8?B?Zmx0UVNqc0d3MWtwUEZYL3F1TlJENkJjZW1qVk1FNG5xd0xhNjBVeHd3ZnAr?=
 =?utf-8?B?VFJKcWNIRDFLZ3QrL2xTR2x4MU8wSHBQMWpBdTVob2s3dG5Ib3Y0ZjFoUHRz?=
 =?utf-8?B?dzUwVFVSWWZoNUF1M3I2V0d3UUgyQVA0U0VuMGxkKzlDSlBNUDBLREtWVnlD?=
 =?utf-8?B?emd1dHpBc2tUei90SVZwYUFRUFZYdm9HNDVxUnBPMnhyd0dhMElUV3V2U0JD?=
 =?utf-8?B?Wmd0VHp3K0FHaVRBanUwVjI0T09URzUvMCtzOGlhcGZYZ1lhTDhxbGhnSFhY?=
 =?utf-8?B?c0tJVXFaYVpGQ1Z0TSt3NE00eVZ0MzJWTk9VZW5qcjhhUjVmQVgwWnR1OXNE?=
 =?utf-8?B?VkkwVm51YXhpTlI2YTFJaEs3UHVPWnZmQlFqemNTMGUzbDliWWZGeTZKbDlB?=
 =?utf-8?B?TDgydWxDZ1V5Q2VWeXNEYXhQaEhic0dKSTBXdGg1ZllCVkxUNmwwMjVNNGhK?=
 =?utf-8?B?N2VEZk80cXp4SkJzYnBZL2dseTBYZUw5VTZsWDJBQ1VVSmZYS0dmN0xtUEJM?=
 =?utf-8?B?NmRCcHlMK2YzM21CalMvb0xwUXFQcVZVN1pjck5OeWVnMU1mZ3QvMDVJcVd1?=
 =?utf-8?B?VnN1aTkrTzRjd0dvd1hUYVd2TnVRVUxKY1RxY0RQOW1Yd24xcWVTVGJpRTFG?=
 =?utf-8?B?MFgyNVdaMFk0dHRlSm1OZ1RjMzNnVGU1RGl4OW16R3BiaTZSZFFVT1ZzWmdB?=
 =?utf-8?B?bjFmWERPQURoRzVhMmhwc3ZtNGlBKysvcGNxenVBckpac1ljUnduUkFSMmF3?=
 =?utf-8?B?SE9JQmlVdGxicTFnRWxWc2c1aWQ3L2FEL3NjVWxoVW1QR3JmWmlyQlpKb2xU?=
 =?utf-8?B?eVFHdk9ibmRIeVZZVDd1ZHVCTW1kaVovZnlMd29MT3pGMVZnTUpGZEhsNmJh?=
 =?utf-8?B?d0VDcXRHSEp0bEcvc2twbWZsZEM0c1pkVzBFWThnaS9aRDhYQzFPd2U0bWRa?=
 =?utf-8?B?NjhDYUJYM3JzK0RXUmVPQ25ycTh3NUhMS1lybFYwTjZpcDBFV2JnVm1qbC9O?=
 =?utf-8?B?VFFRdWwvTTRwTDBBZW1La3hPVUVDWWpxaXVaRHZiZi8rb05XR21jckRNd0xr?=
 =?utf-8?B?cFAzZ053WGN0OWU4NHBvMFpZT21uLzY5R0tGaTU4QXdXUGdhcGJFL0dDS0xu?=
 =?utf-8?B?RVdqNXMyTWMvMWJmWnh1ZE94dFVJRGtnVHdnelNDWXVjS2VUVi9WblRLSDhn?=
 =?utf-8?B?OEdrWkp0ZFUzeGg1TGFPUFc4RTNUcDh2RFF2VzNsb3N1dEhIMEw1VjVjSTIy?=
 =?utf-8?B?YUtJYnhzbjVXbTdRNWJGSW4rdkwzOGpyZ01FTHcwN2Y5UlV6N1FzQmQxcVVR?=
 =?utf-8?B?emtpS1FrZEhjaklPYmFrSElXRkMrb0pQajlBUzk2WjE5NWlDWHNhRkpaVjRM?=
 =?utf-8?B?NXNQbEpmcmNyTUNpU1hONTZJWjN0UTFUd3hvTFlnaUd2UzB1alJCUVZaeWRu?=
 =?utf-8?B?VWZGVEdoSzN2N0Y1Z0RJWDRxYmRXMDhCVHkvSjlhWGVmSGFzNUhGeHNrVW1R?=
 =?utf-8?B?UTFvVmpkMG9ucVN3d2hta3FTMHQyNzBMN0xnNTZETFlCMk44cTAyQzRJcmo1?=
 =?utf-8?Q?/lVo=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafc3c16-6979-49d5-14d3-08dd0e3207a0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9577.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:50:20.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzQpOoen60qfyHYn6OXDeJ+QE9fiEHhFBA0RSAxh87/R5Zyn+5cnZ7N8DXlHEh5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10241

On 11/26/24 15:15, Krzysztof Kozlowski wrote:
> On 26/11/2024 15:00, Per-Daniel Olsson wrote:
>> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
>> using the i2c interface.
>>
>> The driver exposes raw adc values for red, green, blue and clear. The
>> illuminance is exposed as a calculated value in lux, the calculation uses the
>> wide spectrum green channel as base. The driver supports scaled values for red,
>> green and blue. The raw values are scaled so that for a particular test light
>> source, typically white, the measurement intensity is the same across the
>> different color channels. Integration time can be configured through sysfs as
>> well. The OPT4060 sensor supports both rising and falling threshold interrupts.
>> These interrupts are exposed as IIO events. The driver also implements an IIO
>> triggered buffer with a trigger for conversion ready interrupts.
>>
>> Changes in v7:
>> - Calculation for scaled values changed to remove normalization.
>> - Fixed alignment in opt4060_write_ev_period(...).
>> - Fixed alignment in opt4060_read_ev_period(...).
>> - Updates state to bool in opt4060_write_event_config(...).
>> - dt-bindings: Define vdd-supply as required.
>> - dt-bindings: Removed description of vdd-supply.
>> - dt-bindings: Removed "Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>"
>>   due to changes.
> This is a bug surprise. Because you dropped description of vdd-supply?
> No, that's not a reason to request a re-review.

I'm sorry for my misstep and for adding to your workload. I wasn't sure what to do
in this case with late review comments and clearly picked the wrong path. Won't happen
again.

Best regards / Per-Daniel

> 
> Please read submitting patches document.
> 
> Keep the tag. I really do not expect more changes to the binding at
> point of v6 or v7, especially ones so serious that result in dropping tags.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof


