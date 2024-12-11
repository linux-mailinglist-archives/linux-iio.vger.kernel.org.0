Return-Path: <linux-iio+bounces-13328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D345C9ECDEB
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86894188CA40
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C52336BF;
	Wed, 11 Dec 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TjtDOQd/"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281D232379;
	Wed, 11 Dec 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925752; cv=fail; b=cy0erZPFGVS2e48l19InaPvXOIhKJ1fw9Q//h0EN/562HFpVCNUzXnNUdBFAW6bXbc+pnSvnR8CEnuWNIs+CDcAugyWRntX7lKy0e/mMGRQrPNv93wO16VDMdqKvrfZKqjp+912fCJsO+mtIdzYBIzG9wrK3jNE/ninM+bkqhNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925752; c=relaxed/simple;
	bh=CllWKOdf+ffussFv5qxpovaqmTbBdIIF8wf5Q61MW68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HYEATxUfxCR7j4XYpX+VD5mp/1qoBDKQrpJcRrPofCqg50AHEh/NvT3kjKObegahDLtDRyhodTm8XjeXj7HaO9nN4bDKvB7SAorYMoDeK/UZ+4Hwm3Eup4HPV9TJqCss0X60998RdN/hy3+OCGRZmVnP/91yqqJhIoWBkG/ph8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TjtDOQd/; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItGg1Eiod7rg+wHdEDlMqPCV8WMNXlVl5QT6MLgY4FM+D1QW4v3rlK1vxQScTUiq4sL7kntKV1FsX1HoWTEz/TtrlG4t90O3KPUgYjCmCCFT5yJJnVEs4LfBETWOESwZjvtCsU7V1ZKwmdWoaY7cRp0+I/6Vo5pSZaDoHDiiy0h5EsKD4DfRSg35dI+UolhnUZoSmzHXGYX8H2urRS2js+nBHtLjxLMmx7owOy/3/CRn/pamRfFR+5nWr9bIprTZ9oTHbeCXZbnDZeUcjhAnQyezIGZdYb+HcZko4zUWsji+4QbmP2G+E2UCP1XOdoWmv46ReaVZKjArYS1qtWhOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZcB6m2sAnSJfS17nOG7Xkt6BbMMTXLV3afc9vjLF/w=;
 b=QRwT0Q9hMlKwpjqOzo4dVAy80V/uCANnuRMT5t//TeV+7WLbD9eYE1EH2Jjw9bFs1hvHmhDrNw8ZLm+cR+T8IycmYzCJQ4z4CTUZTHV/tG6evj4Z0QFbMBnH1NBG4ZRrDXjcFNP1gaCpSik9eMxHHA2hCZ8AbVqOe/aK5qsmW5z1H1xTVF1CLWW3Ig6muE1VvXqv2Am27sGRKRLygXzVKge4grGo5GdzXRUDgz/vOhQ0P3l5w8Ucwna0Fyv7CxF75JZdERkdGFBxBPZeAj4dS1Uy7JNrysZIy18vQa1aC1Qbq7NpXeMRMQa6jb9Qaw0iTsC5T05WHp4s7QHpyQHouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZcB6m2sAnSJfS17nOG7Xkt6BbMMTXLV3afc9vjLF/w=;
 b=TjtDOQd/7EO/dTWM810Aahy1ec5mENTxiahYDVb6OHJDvnKnhMiM3HHibsxJam28cOQ0swO40yXr2XCbJOl5ibHBZRPec48oqDqZvxyMaDftyce0JsW/CYC8AeMawxrqxIRMjHov29I/jHd5FeHIbLIlkeS4449bqA3Tgi618pA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AM0PR02MB5922.eurprd02.prod.outlook.com (2603:10a6:208:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:02:25 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:02:25 +0000
Message-ID: <7022f77e-6d54-4b33-97cd-e284cf93e07e@axis.com>
Date: Wed, 11 Dec 2024 15:02:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, rickard.andersson@axis.com, kernel@axis.com
References: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
 <20241126155312.1660271-3-perdaniel.olsson@axis.com>
 <20241201125107.2e62ffcc@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241201125107.2e62ffcc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AM0PR02MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 345eef8a-6cf5-4f3b-36eb-08dd19ec70db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy9mQUhmWUxjN2FxUEE0d2prMnN4Wi9mODlGQVNJQkkzWWpHcitZWHZ6WlM3?=
 =?utf-8?B?WWZ2djEvb05GQWxURVR6TUthZG9hWXMwL1dFNVZmT1pTWkRjNUU4dDBqbGcr?=
 =?utf-8?B?WDVPWldBaUpHUnVzUDZxcjZvSk1kSy9TQ0RuWWVoeEdpRWNaQWcyZ09WMXRI?=
 =?utf-8?B?RkZaQ0ErTFl4TlZtTEJYZ0p6M3BsMXB5SGc5eW5MOGVDUFgxcXdiRWJkbmx5?=
 =?utf-8?B?SzVJbTA5VUxCYUNSSFozMHNLRVhTdk5tMjJCNUp4KzhBcy81ZjJ3djh1ckhH?=
 =?utf-8?B?TUVxNkdlSXpIY1VMdEphNFZNSnB3c2xLM2hHRS9RNC9EYnZqUFRFWEExa2xP?=
 =?utf-8?B?SFZSZzZPRitNV0pCMlhFeENvUjJLbEFOc3d6Qk1jakMrdEdFaFVOQXpxUnBk?=
 =?utf-8?B?MUYrV2JBS3FkRHlrclN3RWo0aW1yb2F5WERIUENkZ0JGekhpRmNocDZMajJS?=
 =?utf-8?B?MkNXTnZacTdPZzhhQm52d0xNZnZNOENIUHhBc0dmRFlYejdwRVlwY1BXRk9a?=
 =?utf-8?B?akg1OGt6Y1NGcEJhQkV2Vm1hMzhwSWxEaTlFTlFwanFHRkVPbzRHRjRjYXF3?=
 =?utf-8?B?cUowNUhqT2crc0ZnNG9JUHQ0QlIxbkpOS1Q1QXFpbU5BWGJwUEVhNGpHam5T?=
 =?utf-8?B?MkptRFpYWDJwVnhVS1crMDRvbUU1YVIvZUxaYkJCK2taQjJaeE5mbklkYWxk?=
 =?utf-8?B?MTJBTGpMK05QTlkybENldGNlT2lVTytvdjJrR2xlUFkvTFlqV2hFVkZMaGRh?=
 =?utf-8?B?UnZ4VE5vakhCQlpUMTEyaC92K0lWMXU1Z20rTTFqV1NoaEtaalpPOFFnY24r?=
 =?utf-8?B?cGJwaFhXMEN1Wnp1d0hxYzRMbU5nY0wrdm5RcHlTTm9tM3hjQ3Eva0l1czkv?=
 =?utf-8?B?WVNORHNaaWJPbDJkSUIzT3BIcDZscG1YRkR5ZmxWcGJScVVJSW9vaE5WcGRq?=
 =?utf-8?B?QUsxNG1OVXNETlhxWWtQWWhHTXpld2NKOGY2NDVuNm9hM3BaOE9QSmo0T2xD?=
 =?utf-8?B?MDVnOGFnV09xZlh6T2NLTGdrUE1HblFIa3kvQ0w4WmtFS2JpMEdGdVc4anV3?=
 =?utf-8?B?RVlsYkYvM0ZmVTdiT1pPS29yRnZ0bnZKQTBQMkhGbXJTYnBuK0lJQm5CTlVu?=
 =?utf-8?B?ZzVQOXFjczJqZ1MrVWxEa3ZvU3VaOUxiMGk2a2VBc0M5Z2xXRVZqeTlGUlUv?=
 =?utf-8?B?bFR0S2FCa2hJSEFadFhaV0h1T3dyQmZqVVh5S25qZngxOTBCTWtid3liSTgz?=
 =?utf-8?B?WjhSa0NuNWdoUHZNQ3BIVDFsdXpPdlJVNmdRZkJUZVpucFYrOStlakpWWjVF?=
 =?utf-8?B?b1loUFBrM1RyNlRPeW96VTdoTnVad1dtMjBYQnFvMmFsZzlkaFd5RXRHWnMv?=
 =?utf-8?B?UGttTGp3WGk4Z09HejgwZmFsV2tTdWduYWMyWUdsMmtIWXFTMnhIeXN1bFgv?=
 =?utf-8?B?VDFEUUFpakpmclpNbUtnN2hja0ZOdFNJMFZjN1JnOThycUhrcWdEOHZyb3Fo?=
 =?utf-8?B?UmszMTRqWktWaHdwNHNibDc3aFkzemcvaFQxdFhmc1E1MkR1WFlPRUhDbmVk?=
 =?utf-8?B?QTNLYW9UaFNqbUlsdE10ZHp5YzFsZU53cnpDd1JTMGJLV3FVd1M4bTlCSFYw?=
 =?utf-8?B?WTJ5WmtzRUVnUXREVGpZa08zMU9GZ0wrb2N2ZzlhbkVBRXNrcFd0b1JFeGZV?=
 =?utf-8?B?clRxWTYyOXh2TTZ2OFV3c1cxN2k4M0s1eWVmN1IrUDF6d0R1cVZrREwrN0JN?=
 =?utf-8?Q?saj9/6lSVa8v4fAKVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGxKQ2pUZUhGdEdjVk5jVkxiTFNpN2FVOFJ5RTdwUXpsRUwwQW9ubktPeFJM?=
 =?utf-8?B?NnYzZDNoT212Qnk4bjhFOWVtNlFJeDlJbXRobTZkZFBKV0h4dStnRjVMdDNB?=
 =?utf-8?B?U3JhU2EzcjltRHdaZ2IwUU5GQ2FlRDdPT0RtYmFUcnB5YWtzNDhQMjhzL0Yv?=
 =?utf-8?B?Q1Bwcjd6WTNIRHAxNHUreWNjSW5EcDBTYlNsdllTMXJjYXl1ckoxK0RIVnRM?=
 =?utf-8?B?eHZTNmNVSXhzVG9JZmF5WlRzUnh0VDBaRXlyOXZDaWVIb21iZWwxak56RW82?=
 =?utf-8?B?c3YxckVkcW43bFJBWjZIQW1tRjNVR2JrWUlhOFdqaGhGVGtVeE5BdjVFZ25m?=
 =?utf-8?B?SFJpZmM5bE92SllLRms1NENFbXEvMG1qWXRMdjJ0V2xrdFQvekRCTExOMlg2?=
 =?utf-8?B?RlRzN1l6Ykwwa0wxbHl2OHNEaVpSMGExeWgyZnZkZDNBdEJ4K3lnaFNOa3p5?=
 =?utf-8?B?Z2xPNGt5WVM4Qk5SVkJySUJwcVMwaCtmdm90YUVqQnZZUUw5dy8zV3dWdWpn?=
 =?utf-8?B?MUVUalpWaEpWSjVmQmtFY1JLdnQvSTRaRXZiL3FLUVYxUmpJcm1GT0hJYVFw?=
 =?utf-8?B?QmRmbDh4TUlFVEVKSzBiUS9Gd2xoZGRleS9LNmVMa2tobXNNNUJkUWtTVlJ0?=
 =?utf-8?B?OGlobWFvT3hGSW1wTWs1ZjM2QW1wVWhqSkhnVFNmdFlGRysyK2xvZzQxNTBt?=
 =?utf-8?B?aHo4Z1dDY200UjBpZ01xYjQ5YzFDY2E1d1RWZ1cycjNkWXg2Y2xkRnFlM2Zq?=
 =?utf-8?B?bEJobXYvbXZJTUtaOG1YT3E3S2xmSUxPMlpzMUtWSlgxdTlRZTNLM1g1SjNr?=
 =?utf-8?B?enZXZmxFWTdOb05DcGdWS0N5ckMrOFIybW00WUZMc0FJbjJibEh6cjdQdW42?=
 =?utf-8?B?Um5kSnVxaVI4WU10RjRWdFpBZWg5dGVkRUZIY0FsZEMrdjAxR1hBZkI3MlZL?=
 =?utf-8?B?UHhlcnB4b3ZEdVZyV2FQc3laaWtiWnJ1MStndnhhNlpyNHFhTFRMeDVsRXRo?=
 =?utf-8?B?UTFkTDB4S0xHaGRTNCt6dUpqSUhMZ2FxUHlmaUprM0lhTGl3ZVdHWG5Ca0s5?=
 =?utf-8?B?OUlvN1RvbjN0V2hKMnhBWGR6UHZCcndXaU82eWZpU1NobkFTWXc2NDdwb21w?=
 =?utf-8?B?V2trNzVYb3o1czFBWHZtVjlzSG9acENsMUZpeFpERGp4Z0ljM1lWZWlqT0R4?=
 =?utf-8?B?WWErTFBOSm5qVHJybXJCN09jckQ3Y2Q5enlaZld2RHBkd3lWRUJMaUhrYUdN?=
 =?utf-8?B?WHJmanRRVUpYZmtidmxxc3FsMlhROTlKTmIza2hvUUdyYVBCVTRJeThmczFx?=
 =?utf-8?B?UmdQZ3BYNVdNbTVETEh2ZUhqV1hYTmoxYUlDN1RCcTQ0NXVOWXBka0JjdkRE?=
 =?utf-8?B?alZFOVV1NWg4WnlYN0xZV3dsMEJMd2FjbmdMNlNJTkNXZkc2eDlJc0JBQ1lH?=
 =?utf-8?B?U1F1OVoxMkJ1OWU0RFBqQ3hCK2NqSFBpcUloeXRDMTFLaDIvTUZubzBhZE1k?=
 =?utf-8?B?dUFvQisyeDl1TGNTVVNjRVl2RUljNldRUkpTMzRTYlZvSGpCeXB3d0IzLzZs?=
 =?utf-8?B?aWIyVXE3VHpPL0ZSVWtGZEdYUklMUGhPVW56RlRScWhXVG11alhJc0NyL1lI?=
 =?utf-8?B?cWxqR1l4Y3k0Z2dtM3hJTW92S052TUdzakI2TjZyQ3BLMnRwbjA3MlZwSWtz?=
 =?utf-8?B?cUlQQkdTU3BrSlBsa1poT0J4WjZKZmhjcFhnWUpvYnIzT2J5aXU2NDZkYUdl?=
 =?utf-8?B?SEV3Z0FkaUcyZWdKYmc5d2F0UEIxWlVxSHpGc2VBOVJlWlQ1ZnZQWG50b0hO?=
 =?utf-8?B?SnNDV1VGd01DTGhlUFRLdUYvMDF1VWVBNmY1MkJTcXhWcVMwWXNZaFMwWHd3?=
 =?utf-8?B?WDlUdVNaUFJSV3NxamJsejRGcURNaElhSjdPZXdONHEyVWplcE5RKzBDenNG?=
 =?utf-8?B?SytUOE1pcWM1ZTR1Rm4wRDZBdkJJSVYvbWE1cGducTZiVGdmRGw4RDVWSGl5?=
 =?utf-8?B?eW9lalZpZm5LKy82V2dXejhaVnJEV1hGa1RmbFVWZkd4WHowVVRXemwwM1J1?=
 =?utf-8?B?VHlsRWVnWk8wa1dMTENpcEJCa2R2Qlh4cHFIdkhRZnRlbGRacmtVZ1hxYVJm?=
 =?utf-8?Q?k87w=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345eef8a-6cf5-4f3b-36eb-08dd19ec70db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:02:25.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgrzdjOVSnxHSX4oaUTcJ7C7asQxBbPCyEwvfJTQy0MISD4uJjB3pwvfE52ljrao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5922

Hi Jonathan

I'm sorry for the slow response, I've been a little busy lately. Good point
about the races. I have now been trying to figure out a way to handle this
issue. Basically the driver is running in three potentially concurrent use
cases, sysfs read, triggered buffer and threshold events. The hardware has two
different main parameters to play with, sampling and irq. Sampling can be either
single shot or continuous. The irq can be set to trigger on each new sample or
just on thresholds.
These are the requirements for the different use cases:

Sysfs read:
- Requires irq on each sample.
- Requires single shot sampling but works in continuous mode.

Threshold events:
- Requires irq on thresholds but works with irq on each sample.
- Requires continuous sampling.

Triggered buffer:
- Requires irq on each sample.
- Requires continuous sampling.

Basically this means that all use cases work in high irq and high sampling. The
potential races occur when lowering irq or sampling without synchronization. My
plan is to claim direct mode from the sysfs read code and the event code. If the
call to iio_device_claim_direct_mode() returns EBUSY, the code will continue
without lowering irq or sampling since it knows that the triggered buffer is
enabled. The triggered buffer will lower both irq and sampling when being
disabled in a synchronized way. I will also have to introduce a local mutex to
protect the potential race between enabling events and sysfs read. That problem
could happen if the triggered buffer is disabled or events are being changed at
the same time as a sysfs read is waiting for its sample irq. The other potential
race is between events and the triggered buffer. That race will be avoided by
setting the thresh_event_lo_active and thresh_event_hi_active before attempting
to change irq settings. This is implemented in v9 of the driver.

Some clarifying comment below.

Thanks / P-D

On 12/1/24 13:51, Jonathan Cameron wrote:
> On Tue, 26 Nov 2024 16:53:12 +0100
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>
>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> 
> Hi Per-Daniel.
> 
> I think we've been talking a bit cross purposes on the scale.  That
> needs to be a multiplier, not a multiplied channel reading.
> 
Yeah, I misunderstood the scale thing. I have fixed this now in v9. 

> Other than that, I'd previously missed some issues around races wrt to the enabling
> and disabling of the buffer.   They are unlikely to happen, but also fairly easy
> to close, particularly if you don't mind not allowing channel reads via sysfs
> at the same time as buffered capture.  This is a common restriction because
> it greatly simplifies some drivers and the combined case isn't a usecase normally
> cares about.
> 
Addressed in v9.

> Thanks,
> 
> Jonathan
> 
>> diff --git a/Documentation/iio/opt4060.rst b/Documentation/iio/opt4060.rst
>> new file mode 100644
>> index 000000000000..f12552f27b26
>> --- /dev/null
>> +++ b/Documentation/iio/opt4060.rst
>> @@ -0,0 +1,58 @@
> 
>> +
>> +3. Scaled color values
>> +=============================
>> +
>> +The driver supports scaled values for red, green and blue. The raw values are
>> +scaled so that for a particular test light source, typically white, the
>> +measurement intensity is the same across the different color channels. This is
>> +calculated in the following way:
>> +
>> +R = RED_RAW x 2.4
>> +G = GREEN_RAW x 1.0
>> +B = BLUE_RAW x 1.3
>> +
>> +The values are accessed from:
>> +/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>> +/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>> +/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> 
> This doesn't work with the normal IIO ABI definitions.  Those scales should be 2.4, 1.0 and 1.3
> not a value calculated from the current value.

I have adapted this text to the scale values implemented in v9.

> 
> 
>> +
>> +The data sheet suggests using the scaled values to normalize the scaled R, G
>> +and B values. This is useful to get a value for the ratio between colors
>> +independent of light intensity. A userspace appliction can do this in the
>> +following way:
>> +
>> +R_NORMALIZED = R / (R + G + B)
>> +G_NORMALIZED = G / (R + G + B)
>> +B_NORMALIZED = B / (R + G + B)
>> +
>> +See section 8.4.5.2 in the data sheet for additional details.
>>
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> new file mode 100644
>> index 000000000000..086fe87e1325
>> --- /dev/null
>> +++ b/drivers/iio/light/opt4060.c
>> @@ -0,0 +1,1289 @@
> 
>> +static int opt4060_trigger_one_shot(struct opt4060_chip *chip)
>> +{
>> +	int ret;
>> +	unsigned int ctrl_reg;
>> +
>> +	/* Enable interrupt for conversion ready of all channels */
>> +	ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &ctrl_reg);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "Failed to read ctrl register\n");
>> +		return ret;
>> +	}
>> +
>> +	/* If the device is already in continuous mode, one-shot is not needed. */
>> +	if (FIELD_GET(OPT4060_CTRL_OPER_MODE_MASK, ctrl_reg) ==
>> +	    OPT4060_CTRL_OPER_MODE_CONTINUOUS)
> With change suggested below to claim direct mode for read_raw() paths to here,
> I think this only applies if the threshold interrupts are enabled?  If so
> perhaps amend the comment if you do block the buffered capture and sysfs
> at the same time path.

This race has been addressed in v9. The function opt4060_trigger_one_shot() is now
removed and moved into a opt4060_set_driver_state() function that is more general.
I had to move things around a little in the file which makes the diff bigger than
maybe expected in a v9 of a driver. Sorry for that!

> 
>> +		return 0;
>> +
>> +	ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
>> +	ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
>> +				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
>> +
>> +	/* Trigger a new conversion by writing to CRTL register. */
>> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set ctrl register\n");
>> +	return ret;
>> +}
>>
>> +
>> +static int opt4060_trigger_new_samples(struct iio_dev *indio_dev)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	/*
>> +	 * The conversion time should be 500us startup time plus the integration time
>> +	 * times the number of channels. An exact timeout isn't critical, it's better
>> +	 * not to get incorrect errors in the log. Setting the timeout to double the
>> +	 * theoretical time plus and extra 100ms margin.
>> +	 */
>> +	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
>> +				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
>> +
>> +	if (chip->irq) {
>> +		reinit_completion(&chip->completion);
>> +		ret = opt4060_trigger_one_shot(chip);
>> +		if (ret)
>> +			return ret;
>> +		if (wait_for_completion_timeout(&chip->completion,
>> +						usecs_to_jiffies(timeout_us)) == 0) {
>> +			dev_err(chip->dev, "Completion timed out.\n");
>> +			return -ETIME;
>> +		}
>> +		/*
>> +		 * The opt4060_trigger_one_shot() function will enable irq on
>> +		 * every conversion. If the buffer isn't enabled, irq should
>> +		 * only be enabled for thresholds.
>> +		 */
>> +		if (!iio_buffer_enabled(indio_dev)) {
> 
> This is the race with buffer enable / disable in read_raw() call stack. That transition
> can be avoided by iio_device_claim_direct_mode().  For this one I don't think we care
> about that potentially blocking reads via sysfs.  That's a common thing anyway
> for drivers to not support when the buffer is in use because it greatly simplifies the
> code and normally mixing buffered interface and sysfs reads isn't something anyone does.

With the implementation in v9, I can keep allowing sysfs reads also when the buffer is enabled.

> 
>> +			ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	} else {
>> +		unsigned int ready;
>> +
>> +		ret = opt4060_trigger_one_shot(chip);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_read_poll_timeout(chip->regmap, OPT4060_RES_CTRL,
>> +					       ready, (ready & OPT4060_RES_CTRL_CONV_READY),
>> +					       1000, timeout_us);
>> +		if (ret)
>> +			dev_err(chip->dev, "Conversion ready did not finish within timeout.\n");
>> +	}
>> +	return ret;
>> +}
> 
>> +
>> +/*
>> + * Scales the raw value so that for a particular test light source, typically
>> + * white, the measurement intensity is the same across different color channels.
> 
> I got lost in previous review discussion, but I thought we were getting rid of this.
> Userspace software tends to assume that if it takes no actions to change
> the configuration, scales will remain fixed.
> 
> If we really need to role these into sensors readings then we need to provide
> a channel that does this.
> 
> Personally I see this as a user space problem.  I don't mind providing the
> color factors as scale, but not a manipulated version of the channel reading.
> 
> Scale is applied as a multiplier on raw, not meaning 'scaled already channel'.
> 

In v9, only 2.4, 1.0 or 1.3 will be returned. 

> 
> 
>> + */
>> +static int opt4060_read_chan_scale(struct iio_dev *indio_dev,
>> +				   struct iio_chan_spec const *chan,
>> +				   int *val, int *val2)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	static const u32 color_factors[] = { 24, 10, 13 };
>> +	u32 adc_raw;
>> +	int ret;
>> +
>> +	ret = opt4060_trigger_new_samples(indio_dev);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to trigger new samples.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Reading raw channel data failed\n");
>> +		return ret;
>> +	}
>> +	adc_raw *= color_factors[chan->scan_index];
>> +	*val = DIV_U64_ROUND_CLOSEST((u64)adc_raw, 10);
>> +	return IIO_VAL_INT;
>> +}
> 
> 
>> +static int opt4060_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		return opt4060_read_chan_raw(indio_dev, chan, val);
> 
> As mentioned elsewhere, this code relies on the mode not transitioning form
> buffered to polled (or the opposite). So you should claim direct mode to pin
> it as not moving to buffered mode.
> 
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return opt4060_read_chan_scale(indio_dev, chan, val, val2);
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		return opt4060_read_illuminance(indio_dev, chan, val);
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		*val = 0;
>> +		*val2 = opt4060_int_time_reg[chip->int_time][0];
>> +		return IIO_VAL_INT_PLUS_MICRO;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
>> +
>> +static int opt4060_read_available(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec const *chan,
>> +				  const int **vals, int *type, int *length,
>> +				  long mask)
>> +{
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_INT_TIME:
>> +		*length = ARRAY_SIZE(opt4060_int_time_available) * 2;
>> +		*vals = (const int *)opt4060_int_time_available;
>> +		*type = IIO_VAL_INT_PLUS_MICRO;
>> +		return IIO_AVAIL_LIST;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int opt4060_event_set_state(struct iio_dev *indio_dev, bool state)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	if (state)
>> +		ret = opt4060_set_continous_mode(chip, true);
>> +	else if (!iio_buffer_enabled(indio_dev) && chip->irq)
> 
> See below - this is the call that races because we don't have the
> device fixed in a particular state.
> 
>> +		ret = opt4060_set_continous_mode(chip, false);
>> +
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set event state.\n");
>> +
>> +	return ret;
>> +}
> 
>>
>> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir, bool state)
>> +{
>> +	int ch_sel, ch_idx = chan->scan_index;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	if (chan->type != IIO_INTENSITY)
>> +		return -EINVAL;
>> +	if (type != IIO_EV_TYPE_THRESH)
>> +		return -EINVAL;
>> +
>> +	ret = opt4060_get_channel_sel(chip, &ch_sel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state) {
>> +		/* Only one channel can be active at the same time */
>> +		if ((chip->thresh_event_lo_active ||
>> +			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
>> +			return -EBUSY;
>> +		if (dir == IIO_EV_DIR_FALLING)
>> +			chip->thresh_event_lo_active = true;
>> +		else if (dir == IIO_EV_DIR_RISING)
>> +			chip->thresh_event_hi_active = true;
>> +		ret = opt4060_set_channel_sel(chip, ch_idx);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		if (ch_idx == ch_sel) {
>> +			if (dir == IIO_EV_DIR_FALLING)
>> +				chip->thresh_event_lo_active = false;
>> +			else if (dir == IIO_EV_DIR_RISING)
>> +				chip->thresh_event_hi_active = false;
>> +		}
>> +	}
>> +
> This makes me a little nervous because we are allowing the control of
> continous mode from here and the buffer setup and not preventing them
> running at the same time.  Maybe there are no races, but I'm not convinced.
> 
> It is possible to avoid this, but fiddly as we shouldn't directly
> take the iio_dev->mlock from a driver (which protects the buffer state
> transitions.  Basically we need to successfully pin the device in
> either direct or buffered mode and if we miss in both (due to a transition
> in flight) retry.
> 
> There is one example doing this in the max30102.c
> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/iio/health/max30102.c#L479
> (that one is weird because we read the channel in an entirely different way depending
>  on the device mode).
> 
> I suspect we have other cases missed during review however.
> 
> The tricky bit is that most races around buffer enable are harmless
> as they tend to mean we get one extra or one less sample pushed to the
> buffer, or an read that perturbs the buffered capture timing.  So it
> is fairly hard to spot a real one :(
> 
> This one is vanishingly unlikely though so I'm fine taking the driver
> on the basis you'll take another look at close the race if you agree
> with my analysis.  The side effect of this one is that we either
> burn some power when no one is interested, or fail to enable data capture
> if we hit the race. Neither is great, but not that bad either.
> 
> Jonathan
> 

I think I have managed to fix this race in v9.

Best regards / Per-Daniel

> 
>> +	return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
>> +				       chip->thresh_event_lo_active);
>> +}
> 
> 


