Return-Path: <linux-iio+bounces-12677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD49D9726
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 13:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D8B20F8D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F21CDFAE;
	Tue, 26 Nov 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bILxSn9y"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3831196D9D;
	Tue, 26 Nov 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623331; cv=fail; b=Oq1iictIJ+ykOZZv38oSA7k9/fSFbndNvOpggs00lSyQp23EQmmizFozQRMcnOeXO4dCfGROrmqMJVs6cD7c5uQMDhkSAKyu5S+xPDCzEYGW/GpLOyC6fab4IPY6m+vmpTdoQn/LYc8Iymvlrv1KR5rjsjXUkI/WtWr4jvqibiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623331; c=relaxed/simple;
	bh=TFI/TYkqNy5pti3gjusdAKj6uf6J7d0u9SD/OoBcIyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EB6T0J9Hn9y+jYv5EN1YlTd9rR0v5BVQ1BKQSTuIwkQkoLgA85n4CBjRid3D+nCp5XQ86DUkd9ieO2hT6vlboA8vM3FIRKgxDzuq88YKbzzdx1TOMAevdgHheHRL5I/IjVpkr9IUUOKDPZ0ibxIiyrWkBviILrW4gNUBR0zdNCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bILxSn9y; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIv1sFzBK+/EIb+GsnRfGGw5xpoPB8IKSFgmHZ01rUzvjOukHx23/jiXOHDEWokZL0gKPu9IPHrae5c9xs0VcmwRsw3ycFfauvjT3AfR54oqiyIjXCW/n36Wk9axuC5HuSeCVZqPpj36k8glz3lrmL06Z4cw6q99gdNWx3tMBeHEPNyQwFkKDLjAEY7pnKCWvE0mLKrq1PzHi+uZER9LDuNoP9eNRUmSuDT+W+SVdO4T5Nak9Pwea4djQzS2l1iNRARyetqTGv4Fy5rYvJTohL5wc8JMJH/aQvvtdYI7y3PnmBgyeluEhs+7kXLIK6xBiRBLFKr8wkn8EP+0SXVuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIgh2Q0qEBRvrGuLh9SSpPgHgLe7jrWKbqWGGT6dmFg=;
 b=FgkATYxEDIPlGUTNdk554Bl5sXJeYZJ2RFtj9lu1h8RJ53xCc4QLmnBRvChe6YoXv1R3RtyvAnYHHESZbsEiWXXL6knG+0k93K5qDOf69WgZgxFEH1lqbM28W3cECqxnVSdi5xskFdYC//Xw0/2yBRvYR0A6c6HXbnuiosoVsSEWLa6C1+X12pBSb47oYyy7H0W0qTqJ2IhEI9EnD4KySTaLimAqj89D5vQdWMna5+gLsHekxundSqS/nmqF2zoa1tzDUc+EH8PJn3LsVPjMw4DOBqzIBqh57FkR6P1x/CW/3rxlvZi6K0CGIg3oT2BOqhdlA6sKKiHKVSclqVpXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIgh2Q0qEBRvrGuLh9SSpPgHgLe7jrWKbqWGGT6dmFg=;
 b=bILxSn9yVygbPBuPeSq1E5qwL+kYwolCQiqEtN07wLBLfLkTZqV2fZV4zQStjcRkik5e9gwCZyOnUyRCsdVupVNTyBoiAUwa0fw7NDiltbFJ3aMsi9r3qFtQUAUnKzMysybpD3GJ5JVZkq6yKSqxB/Ua/EFoRsdVWRpLYZnwtrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by DU0PR02MB8955.eurprd02.prod.outlook.com (2603:10a6:10:473::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 12:15:22 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 12:15:22 +0000
Message-ID: <0695085e-5f93-4a48-81d6-ec66a31663a8@axis.com>
Date: Tue, 26 Nov 2024 13:15:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241106120036.986755-1-perdaniel.olsson@axis.com>
 <20241106120036.986755-3-perdaniel.olsson@axis.com>
 <20241109150955.7526c416@jic23-huawei>
 <303bd71a-bb38-4afa-a9e2-046425084b69@axis.com>
 <20241123145825.769e1ea0@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241123145825.769e1ea0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|DU0PR02MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d028b5d-f241-466a-fa6a-08dd0e14002a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d20xZVZDZVRzUFdpSVh1d3FyMjBrcU5zcGFDYW4xUDgzVTJjSFd5Sk4valhy?=
 =?utf-8?B?QS9DbTE2OFVhWHRBdERROTlxQXNWOVhlQVdGQ0IyOW1wYmJWaUxPd1VOTXNy?=
 =?utf-8?B?VkNJTi85Mkk2dmZxU3BuUFgzYjIrVGdaNUVWcU1MbTQ4RFVPTFJxQkdZWkNK?=
 =?utf-8?B?ZEFBMTkxNTdmdmhFQy9QWnAwOWZaazdFdldNVDJTNko3b0M4YkFpWmI5YWtw?=
 =?utf-8?B?MUdKZjVJaGtGZ29wSjZEa0VNdnBIT0pqZ2FodWUwR0dYc3NjSG5GQTRlWkxz?=
 =?utf-8?B?Vk0zdVFwSGpjcHZMNVZEaGEyQUpSd1NQd1YyN2JFQ3I1R1JKTGJjdFFTNGJB?=
 =?utf-8?B?dDBMaHlyWDQyNmJUUVBMZFo3SkJjbThBMUg3dmFpblJwYXZ5Q3ZIN2dMOGx5?=
 =?utf-8?B?cTBUWVNsUTJtenUwaGxTNk0rR29mSlorc2c0a0ZMYjkySFJ3U3IrbDVyOXBF?=
 =?utf-8?B?MkI4MGIxRGVzVFJwYVFYQmJlTmZSbkFFVklnbUZyUGpIaSt6Y2dXcDJpT1Vi?=
 =?utf-8?B?WUcreXdhVWJqdURaYzhQZGJPdklCZVVrbVViYk9reVlJcnlEeXVxelpPR1g4?=
 =?utf-8?B?RlN5VzVmcmFCZDZOeGRjcWd4WFc3eGhVYmJqOVFBVTNLbzcwVGxKQWxVcmM1?=
 =?utf-8?B?ZGxjMjlWL3hzdlZlY1BNam83ek95TDlGVXd4Ry9oOVBIcDc2cUxJcGdWcnJV?=
 =?utf-8?B?RXc0ajJTajBWaWxCQ0FIZUdhRk0wL3Y2blpjSUJEaUhmL2phN3IwQ3d1MUtN?=
 =?utf-8?B?bUFQV3llQlc3Y3gyVG5rMFdFaTZVRHdOV0xHMkRUZHhsQjRQVXpWbXlxczh0?=
 =?utf-8?B?MDk3ODc1MzcvM05DTWp2NVRjOHc2SWdOcWpKajlmYzRCdUVqVXp6VTNKd0lU?=
 =?utf-8?B?Y1RldmhvS1doM3A0elIzOFpIdTZrZEpaZnIwaVJGanZod1o5bUpianRXNW9a?=
 =?utf-8?B?WkZpZGUyV1E0OFZySnNVVDg3RlloS3JaVVNVcW40VEZFTDZLMmFHU2QyNmVr?=
 =?utf-8?B?SlJ4TkoyWW9NUE5yYVA4VUhLNTFPUXh5aXRBVVFMOXVCcnhGRlBxT3d6RlQ0?=
 =?utf-8?B?Q2RRc2Y3V3VOaXJtWklZbzFjREFONFdONFZrK0V5NktFWUVUYUhlZHd5cmFD?=
 =?utf-8?B?dEd6eGZSaEdEcFY5VnJvb3lHQWFuaVN0VXJCNi8vYUJQbHNuRFd6ZWd2M1Jj?=
 =?utf-8?B?aG1IVW14UnVOeitrMXFzNFFKU3FEVGUwaWJPTEhrT1FsaS9vWUduSmhRU1I1?=
 =?utf-8?B?R1cvTHJrT1hiTlo2Y3hJNWQxb0RiYlFWWStlcENOVEhzNHk2c0hmbVplQnBV?=
 =?utf-8?B?R1MzeXRrQ0xXaFYvT1g1dERtN3ZFNS9zZk1aMmN2MXUxa1hCVHVGWmJOQ1o0?=
 =?utf-8?B?TjhDL2w3VjlTK1MzRDFBaHNWcklPNW51ejdQZjliWTVzYVQ2aklRVjdPUUlv?=
 =?utf-8?B?Qm42VEdWSC9OMzl1V0VjWkhUVERvbmtHRmEyVGdUK0JSMjVZZkliWS9UaHdO?=
 =?utf-8?B?ODBEZEF1azk4VXN2bEdobXFjK1JTWHVSSkxoWW5CdFI0eWN3NUpBazhjZFoz?=
 =?utf-8?B?OU9YdDZiWDFFWm1iakxRSnNaNS9xdDJFZHcySHZUOTFDaEVidURET25uMkQy?=
 =?utf-8?B?N1BCK0MxZVc4RlJaZUh3ZDV6ZVNlNzFpd2J6cWlibFlyM2Erc01zUzl0ck55?=
 =?utf-8?B?czZndTJZKzVqSFh3eWMwT2xDZ1RHa0J0cnp0aGkwN0VhVDd6QkxoVlFVVEI5?=
 =?utf-8?B?RlozdXJmTWlveitzKzhNU1l2TXRGaGJ4OWVZMWJzMk1YZ1hZWW93dk1Ed1Qx?=
 =?utf-8?B?czVIVTFxZGlnZzJlRGhpUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhkcDBaLy9tampzbG15M2oxVmp1VXRka081TnlzRzlIQkRIUXUwMWo3aHVp?=
 =?utf-8?B?eldWOXhySzhENGU0VVgvRTcrZ3V0N0t3WWJ4U1g1cWE2Ty90TkFFdDV5OTlh?=
 =?utf-8?B?NVBBL016U2h2aDlRblRMQVNwSE1CM3dTeHBLRU44SVdJNnR2ZnJvQkJmNkEy?=
 =?utf-8?B?Y0g1cGJBRG9nSXRkK2J6eDNQU3ljL0QrZ25DcGVjZHdjZEVGNVpjWDRnRU5n?=
 =?utf-8?B?dko5UkQvWUhkYTBsUjNUcGwrZXJaR05jMzV4TFNZeGNLaUhqY080Y085ckxo?=
 =?utf-8?B?U2dicVhpdnI4ZHJMZk41eGVUM04zbFhMcFFGYXJpLzhQK25wVWpIMml6NGZK?=
 =?utf-8?B?a045U0dueXhwRnMrR09OMXIwT2VpQTZFZGsxcGdTTUhHaUFyR05makh6YmhH?=
 =?utf-8?B?T2NwSStzSWczRzlMbURiZElMU2pmMGtVZGpudzJtSzMrMmUvTng1eDgvOXN6?=
 =?utf-8?B?RWtWUWtqU1NoK29rbHROWS83WG9SVFFXbURORVpGWTBPbVNWbXdUa1dPTXlq?=
 =?utf-8?B?eEZpdHo3TzgvUEo2bmN3REVxcDBEZkJRb0xnSlRpVC81ZlBYcGV2ZFVLNVlW?=
 =?utf-8?B?OGVxc3F4bHJUcUNxamNmbSs0S3YzaXdrVlFTTm9YRVB0WFVlNnhDNDRib2dm?=
 =?utf-8?B?TTRYNWoxSncvMW5JcUNWMVZzK0FidS9jd0txclM2enFZTHh4VlFQaHIvMUFm?=
 =?utf-8?B?aytJd0JSTVRpSFdTOW9Fd0ZrdGJKaWFCbEVQR0Fjdmg3MVlzNnJYQ3JUaDg0?=
 =?utf-8?B?OWRaR0ZtMGM5NlhhNy9aeUNFUDZPSFprbjBrVi9nTE5XUHA3ZVRFSzBFLytu?=
 =?utf-8?B?U08vVHRqRVJiYkt0bnNkaDlXWHRnSmhZdTFnaUFnVW1wOWFHdmRKYStBVDFG?=
 =?utf-8?B?T1BaT1NOWGE3Z25HVzJ6cGxYU0NZblE3eU52VUEwWTg0MnU2aVI0VEMzYnAz?=
 =?utf-8?B?Y0dpTkxJWk5xdW92TVZoUWNDN21EWnZPZkhVa001TitZV3dRclMwNzA4UU5Z?=
 =?utf-8?B?cjJSTDVLbmN5NGhvWCtVeW5QNmdvRk5QbDh4Tk9aMENjd2tRRFlpb1doSUoz?=
 =?utf-8?B?RDVXZ0dSQlNydC9OeUNVNlROSTUwU1FMZUFmaXpYTFAzdjMrdExwSzVzazh0?=
 =?utf-8?B?bWp5UGZOdzh4THhMWjVHZFhlUnpMakVuc281NnQrUFU1dHg5ZXNSVHhsMWov?=
 =?utf-8?B?KzY3R2ZwVkgzY1RmT3hBQnYzZ3Rscm1zNi9KTUV2am1NeDM1SWFXNWdEemxX?=
 =?utf-8?B?OHlqc2FpNHJtcEFlbXBPRHBkajc4TkpwaXJDT1IrMkc4RW5CU2JzYm04V0tP?=
 =?utf-8?B?MlN2MVdwOVRkU3RMMG9DN3NmeWZ1bDNxYkt3dGgrWmlyL0JXbUVDRVRnYWIx?=
 =?utf-8?B?RjlST1k3M3ZJUy9tLzh1VjVaUnkwNVpOWVhXcGFManptazlkNmQrclFpOVBJ?=
 =?utf-8?B?WVRDQWdtUTM5TkZPb3hhMkt1a0dFZkRzN3EvS1RBRUZQUHFDdXNPa2xPVDlO?=
 =?utf-8?B?Qi9MZ2k4YmgwQTJqNzN5b1ppdkExS09iNGRrdEVPelhuWVVCdklJV2wwSHJi?=
 =?utf-8?B?bzVrMm1HUFFCdEFnN2pvVGI3bEpjaXdITnU1NzVUcUJKb1JaMW02a1VTT0hI?=
 =?utf-8?B?VXk2UUFRQ1o1MDhkTzAwV0RFQjNlUmhkdGpXTG9iSnFVMmFnOWp0UlhyZUZG?=
 =?utf-8?B?cllzMzhzK2dxc0QzMzVUbTNtYzRxbXdmZGRodlNKQ3Y0VzlWTmtEYWo4LzRB?=
 =?utf-8?B?ZzZ5am9vWTZtMWd0R0YwVWdUS3dCK1ZZSndKRUZkc0JjUFZMWjErRFlPZTBn?=
 =?utf-8?B?c1AreTFFRlpYTWJnTHNmMnR0OWpTdEtBZUdVQ0ZWeWxwNVhLWElWTFg4Rlk0?=
 =?utf-8?B?NzRaZVQ3N3h6SVB6Q2NTODhJQWdqT0taSkV6Z2c4bkVMQUNDNEs0VTRxNSt4?=
 =?utf-8?B?aHlSRzZjMXhSdlRJYlZBVllEUTY3eTZXRVIzVUxlQURBZDBPSWwvTjhsY0VL?=
 =?utf-8?B?bDlzd290VmlQdkFuYzhNT1NSVDdaa3VqUE10Q2JFMGdaWUR2cS9YT1pWU2h2?=
 =?utf-8?B?cU41TmZpRzJDZERYNEI4NUdjUSt1YVpOWklTWHlYWWdKNGtoSS9SUVBuSFY4?=
 =?utf-8?Q?XFmQ=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d028b5d-f241-466a-fa6a-08dd0e14002a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 12:15:22.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE/r41qS4IqJfg3fvdqxjq1XKmN0EBspyGjnX8zJPveF6HWyDxjaI+2hPswNFRtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8955

On 11/23/24 15:58, Jonathan Cameron wrote:
> On Tue, 12 Nov 2024 16:35:18 +0100
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> On 11/9/24 16:09, Jonathan Cameron wrote:
>>> On Wed, 6 Nov 2024 13:00:36 +0100
>>> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
>>>   
>>>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
>>>>
>>>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>  
>>> Hi Per-Daniel
>>>
>>> Main comment in here is that the ABI is standard (though oddly
>>> missing in some cases from the main ABI doc). Annoyingly the
>>> docs build process (try make htmldocs) does not work if there
>>> are multiple entries for the same ABI, so we need to ensure that
>>> the documentation for common ABI is in just one place.
>>> That makes device specific ABI docs tricky, so instead we tend
>>> to use extra rst files in Documentation/iio/ to provide more details.
>>>
>>> Jonathan
>>>   
>> Hi Jonathan,
>>
>> Thank you for your code comments, I will fix those in the next version.
>> I have been trying to understand what I should do in
>> Documentation/ABI/testing/sysfs-bus-iio but I don't really get it. See
>> my questions below.
>>
>> / P-D
>>
>>>   
>>>> ---
>>>>  .../ABI/testing/sysfs-bus-iio-light-opt4060   |   66 +
>>>>  drivers/iio/light/Kconfig                     |   13 +
>>>>  drivers/iio/light/Makefile                    |    1 +
>>>>  drivers/iio/light/opt4060.c                   | 1282 +++++++++++++++++
>>>>  4 files changed, 1362 insertions(+)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>>>>  create mode 100644 drivers/iio/light/opt4060.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060 b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>>>> new file mode 100644
>>>> index 000000000000..187e750602ee
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>>>> @@ -0,0 +1,66 @@
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw  
>>>
>>> Huh... This is general ABI but not present in the sysfs-bus-iio
>>> where it should be.  There are some control parameters on these channels
>>> but not the actual channels.
>>>
>>> Please add them there instead of in a device specific file.
>>> Also group the 3 colors together as done for intensity_x, _y, _z
>>>  
>>
>> So you want me to add 4 lines for in_intensity_X_raw where X is red, green,
>> blue and clear? Should I add those together with a description in the end of
>> the file or some place where I find similar definitions? The closest I can
>> find is in_intensityY_raw (line 1629 in the version of the file I'm looking at).
>> I also can't find the entries for in_intensity_red/green/blue_scale? I can find
>> in_intensity_x/y/z_scale but those were added in a commit for the as73211 driver
>> and as far as I can understand from the driver, x, y and z are coordinates and
> 
> xyz are color spaces coordinates for CIE XYZ color space. Which admittedly gets
> confusing when we use XYZ for index numbers in this file.
> 
>> not some kind of unknown variables in that context. I'm sorry for what I assume
>> are really stupid questions, but I just don't get it...
> No problem.  There are often no 'right' rules for this, just better and worse
> options!
>>
>> Basically I think I need to add the following 7 lines to the file:
>>
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
>>
>> Is that correct? Should the _raw ones be added in the groups starting on line 1629?
> yes.
>> Should the _scale ones be added to the group starting on line 469?
> yes.
>>
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Unit-less raw value for red intensity.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Decimal value for the red component of the light. The value
>>>> +		is normalized to give the relative red component
>>>> +		independently of the light intensity.  
>>>
>>> I'm not sure I understand this text.   Also why Decimal?
>>> Maybe something like:
>>>
>>> "Scales the raw value so that for a particular test light source, typically
>>> white, the measurement intensity is the same across different colour channels."
>>>   
>>
>> Your text is also not totally correct, but probably better. The parameters are
>> first scaled the way you describe but then divided by the sum of the 3 RGB channels.
>> This to give an estimate of the color ratio between the three color components
>> independently of the light intensity. A decimal value between 1.0 and 0 will be
>> returned. Is this the type of oddity that should be documented in an rst file, the
>> way you described further down?
> Hmm. A divide by the sum is unfortunate.  The only common case for this is
> quarternions (where the 4 elements are normalized).
> 
> I suggest you don't divide through, just leave that for userspace to do
> if it wishes.  Fine to document that procedure in an rst file though if you like.
> 
>>
>>>>  The raw value for red
>>>> +		is multiplied by 2.4 before being normalized, this to adapt
>>>> +		to the relative sensitivity of the red filter of the sensor.
>>>> +		The factor for green is 1.0 and the factor for blue is 1.3.  
>>> An unfortunately characteristic of the ABI docs is we can't have duplication so
>>> once this is moved to the general docs this detail will have to go in favour
>>> of generality.  You could add a little 'footnote' to the entry to say that
>>> for this particular device the meaning is this.
>>>
>>>   
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Unit-less raw value for green intensity.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Decimal value for the green component of the light. The
>>>> +		value is normalized to give the relative green component
>>>> +		independently of the light intensity. The raw value for
>>>> +		green is multiplied by 1.0 before being normalized, this to
>>>> +		adapt to the relative sensitivity of the green filter of
>>>> +		the sensor. The factor for red is 2.4 and the factor for
>>>> +		blue is 1.3.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Unit-less raw value for blue intensity.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Decimal value for the blue component of the light. The
>>>> +		value is normalized to give the relative blue component
>>>> +		independently of the light intensity. The raw value for
>>>> +		blue is multiplied by 1.3 before being normalized, this to
>>>> +		adapt to the relative sensitivity of the blue filter of the
>>>> +		sensor. The factor for red is 2.4 and the factor for green
>>>> +		is 1.0.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Unit-less raw value for clear intensity.
>>>> +
>>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_input  
>>> This is already in the main ABI doc.   
>>>> +KernelVersion:
>>>> +Contact:	linux-iio@vger.kernel.org
>>>> +Description:
>>>> +		Lux value for the light illuminance. The value is
>>>> +		calculated using the wide spectrum green channel and
>>>> +		multiplied by 2.15e-3.  
>>> It may be worth capturing these details in an rst file under 
>>> Documentation/iio/  Just remember to add an entry in the index.rst file
>>> there so that they get included in the docs buidl.
>>>  
>>
>> Ok, I can describe this in an rst file.
> 
> Great,
> 
> Sorry for slow reply. Things got a bit busy for a week or so!
> 
> Jonathan
> 

Hi Jonathan,

Thank you for your answers and clarifications. I will remove the normalized scaled
values in the next version of the patch and explain the usage in the rst file. I
will also update the sysfs-bus-iio file according to your answer. I will also update
some small comments from Javier Carrasco. Hopefully I will send the next version very
soon, so if you haven't already looked at v6 it might be best to wait for v7.

Best regards / P-D 

>>  
>> ...
> 


