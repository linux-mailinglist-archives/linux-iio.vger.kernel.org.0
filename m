Return-Path: <linux-iio+bounces-10329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4C2994803
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 14:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99CCB25549
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A351DD54F;
	Tue,  8 Oct 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TeCU2xFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E50481D4;
	Tue,  8 Oct 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389134; cv=fail; b=J87+arf7yz+kG711PAo8vO8Sdt2Z9ZOkJGOPpaaL9N+wx7ke+j9bGkuoxvchhU6iwAaV7A8WXH7F7C8JqTAuqxEykHrWVGAVl5WOR9H/zXtn/uOsvKaWcAxOM5yvVByiB4yiEJeNMDU9ybSBuv59kry03YNvBUC4w9hfhewUrTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389134; c=relaxed/simple;
	bh=2Vpr8xoQdcsYIwnRb4zPEfN16K7gIFhzEyXLX0eb4IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hAuFtwQMzWhi6ruzVmQJkq6MWI6B7P3nHh8tA4J5N6yYkUUAkQa/5jGCprd9xSww662NfDAU3o1Y7jLXRTfwA0iPIvHXAYtucNfkIYVgp8Jhkn7/84TXJmAq5jtMEIRYwdLUjUT7M4Pw9Oh/QwSYrGOJ5ES5Pu6B/1CxBSxaCnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TeCU2xFh; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCAUh+AnzbV+2V4t1pjiC8UZoL0rYE+DY/8JXXqYQryoZKYPZWgDsQJO51j61EZjz216ivapbSBxTq62haL4AKz+raXtUHQ8dXgGhLzgrtG/aHs7pDqgzZaoHllQE3NxvNXiWucheW1NutaEoiygro5MUnHXP/i+7VhndEshkwb0rnOs/bJJjuC1HzvBiFfu4HtVPB88xBBTE4YvDBExCRP+xTkADkN9N/luEFaCfPMlmEnlRMp0SWTf6BI76daUf2PBWli526+rBCYfVANfuAgLQ2qYwICfniAESRmEb5rp644d0ETwN2sOcpaCKw23/ffyQ00WeLZ5+di7aaU3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXy5gMX9QUkXMQuJ9TxHyHdQqHlRST2ND7icO7jcEj4=;
 b=vDTLFV3DtR3/21QwIBHhdpRE+CNwUXxtmlolgn9uZru/TNUN3a/OS2L7uQCpsxMhPYFMf0+Mzh0I0kD/XbSrDiBb6uyeYDJlJcMylAi56i5MR2SG6+/nEFwzQHASChqtzt6ae61Iy4WYsD1ikukRhYNl/lebLyQW404DBcH6HPyXlFXdQ4d/CosjGdKxsvDdwjXYERVMW+KrYZtleJSmcrmy1ulczObrHJm6N4kdHBLrgk10FEka7/kh7HQUHTzMwxMbkuRPpUy0UH7Z9QBjqzUK4SJTav3a/4Qoyu1ScPqQ9p/9AvJAotqo5w8b7iH5LBMsTyhBcPH1zlg5K8nshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXy5gMX9QUkXMQuJ9TxHyHdQqHlRST2ND7icO7jcEj4=;
 b=TeCU2xFhLAZnb2VS+qYOz9BptmzOSS4lpu4UXf8meXmLCNHx+k4KcqimuMXgDT3H01rkrn+a2ukNXj5jxESzgojgW5wMhxlhoekSlrUgiRFSM9+JrQrbYjsMu8n7+kUI6u+nj5+flBcVtKMC9boNoFgcwYZ2gaJhX33MpG5R1mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by DU4PR02MB11073.eurprd02.prod.outlook.com (2603:10a6:10:58a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 12:05:27 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 12:05:27 +0000
Message-ID: <092e20bf-9a1d-40a6-b5c4-f58e0e99d158@axis.com>
Date: Tue, 8 Oct 2024 14:05:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color
 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
 <20241005165119.3549472-3-perdaniel.olsson@axis.com>
 <20241006161850.3f9cf275@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241006161850.3f9cf275@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|DU4PR02MB11073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acbf231-d71f-4023-dcb0-08dce7917f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3BoR21MNi9LWlc2R0piWVJkYVpGVTJLeVFXc04yKzErMVVpVUJRRkQ5VEJ0?=
 =?utf-8?B?bHFtWTZVWURaTzYrVTVTWFV1WTFrZWdUS1drRVVXQnVCSnZtQkpLU1d1eks2?=
 =?utf-8?B?SFZKOTdzYzJ2aE1TeW5aQ0I1K2ZpQ0ZacXdoazNtRWN2S1VVVldMcWJpSGht?=
 =?utf-8?B?ZmFnTUNCYkt6RUtjNmdBVG1MT2RXdkVRb2lORXpSVWdjVTJHcW5LSVRtQ1BK?=
 =?utf-8?B?M04vUytycnl0YVJOUnl0WXVPcUM2MkRsMHNFYnNCdnk4Y1VRdkVvVVlBeVo4?=
 =?utf-8?B?aCtzRms3K0QxRlZVZTY5eEFMemZ4eGhzNlFscHVkUmdHR3VYalVXcjVaL3VE?=
 =?utf-8?B?QnNpeVUzNnNCTFdITnZyRTd5cFRzdkxQNWw5eVhmWWFyTDZtSVpja0FzOFpy?=
 =?utf-8?B?cHNici8rTWhiWUc0UWxSbzNKYWNtOCsyaklkcDZuc282dTNMZFRlTTY4OGkv?=
 =?utf-8?B?UFA3bS9TN1U2VmJ4U09xSTNvNnBVbCtXOXpzOVpaSDJiWFlUUGRHNkkxd2hz?=
 =?utf-8?B?UWVBUThsSG5kTThxUXNaOXFHU1Q2SzNXaDRvYldKOXMza2p1SXArWjB0RXVu?=
 =?utf-8?B?ZzR6WTZ6Qko5V0hSeW1yQzNqTDRyTWhTTFQ2ckk5UDZnWWV4eGhWOTRtQzh0?=
 =?utf-8?B?V2hiODBsaE5NT2tSZTNUeURMYnROd3o1eHFWelpNdHBTc3VLN0x3eFFVT3py?=
 =?utf-8?B?Qy8yZXFUNWlDZk5BWUFhUjJWdXpwTzM1cjJNMFMxZWw0YnEzZS8xNzVaTUxi?=
 =?utf-8?B?Skw3M3h3WjRCdnJTOUpxaWxuL04rSUExOVVET0RQU3JzWGw0MDZtay9pS2xy?=
 =?utf-8?B?dEFKeWFRSDFOZzRJeW1JN2RuQUVqTGs4MnVRSlNaOTgyYm9sMkkwQ0hvZnV4?=
 =?utf-8?B?V0xIUDkxemJLTWpYcHF6alFmYzJXYW8xSmxmRFFmaGNtOVR3aEx6Q0lCOWF4?=
 =?utf-8?B?MHp0R2VXWHRKR3NLV1hTMC9iaXVtb1VmZ3ZuREkwK1VPMFJnd3F3MVUrZW9q?=
 =?utf-8?B?SnIyV2l2Q3NaZk5MVGxWeVdvS21reEhpVVkrTDQ3UlVqYUFPNngvVzg3a0JG?=
 =?utf-8?B?YmtUZXNiRnd5UzhraGdJTkR0Z3BvMXhvSWlQeHNVejBoNElNZlpldSsvaXZS?=
 =?utf-8?B?S0s5RGFNSytvMjUzQjVpVjI2MURiRWdLc1Y1U1A3WEhvQVF0cncvdS9lUlJY?=
 =?utf-8?B?b2FrbERsY1VYNTVia2psSjB6STNxUmMxTHU1SmJ6RWduWlp0dFJhZy9NZklj?=
 =?utf-8?B?ZGRSdDNGYkdQYzdFWnkrTTJTd3VMdGdwS0NZaFNjZ3Q4bWJOQWdIblVDTWZU?=
 =?utf-8?B?RGFWTzRWZElSd1o1dkN5Vy85REVFRDhpNGNkT1MzajlaZmcwcnI4aXdqZDNJ?=
 =?utf-8?B?YUdNTlhmZklNQzFPZFlIMDFsaEZpaXk2Z2VWclByOUZoOWxvQlNVWGtwemlF?=
 =?utf-8?B?VnFmOVR0bEFtQWxUd09URlMyZFlEb3VPZWtTdnlNKzhiZ3pucHgxV1BtZ1Nw?=
 =?utf-8?B?SkNvSXpQTE1SdkozVERoMmdGSytOc1Q1cG5DamlObFVjaTh6U2ZsemhFVzc0?=
 =?utf-8?B?WUZqaldxT1RNTFFIUm1HRk1NUVBUdmsrUzFDVEl0aG5jN1Z4dmY5cCt2NmZE?=
 =?utf-8?B?QnFjaVpWVnpTQkFxNUx2S1J5RHR6c0Z0ajlrQkNBb2xDdUNtaWJMdDlnRHZO?=
 =?utf-8?B?cVZSdkYxM095OWVPRUh2WEVEYTNNZGVYTklEVHE0ODNSRDhoNXBrSEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEZYYVJ1aFFsSm1HODVYV3pqRGpFTG5QL1gxdVA2MlptOEJRUXZKUHkvR0E3?=
 =?utf-8?B?SUo2QVQ1akNnVGFha0ltRWlmOGNtYTZkbTBYTHFKVTI4WGgyNU5GcnhkbFE4?=
 =?utf-8?B?VmpIUi9PMUhrSm4zNFVHWmFhV2krSjRFTFNycWt2ZUM3OHhaUno5UnhUZ2FG?=
 =?utf-8?B?V09ZMytKSGRYaER6VzRnZk1YMkp4WjN4aFFueERSS2x1YVFib0pxcTBNU29o?=
 =?utf-8?B?M2xpL3FmVUw1bzFBWUFmVmQ1aTdRaFJEYkZpaEpXRnRybXN3QXY5SExPbG1X?=
 =?utf-8?B?R1NzWk0zT01MVmtXc2lCYlRuM2pScUlINmUxS04ydFBYeWhyMnJRNDR1M0hS?=
 =?utf-8?B?SDA3L1BEMHFsL2xPaS8waWwveTAwOWNXQmlJWkFCT2NRTXY0ZXFpbDZ5UGZN?=
 =?utf-8?B?Nm9jdm5SMGgxcWxLdEVZbGg5Q0owWUFQL211V1ZENmFQTk1laUw5emNac3VO?=
 =?utf-8?B?NW1tZWV3YThGZTBnQmFaTnVYY1lpeTRxYVBRQzQrL25HOUpWRHNmTkcwMXhQ?=
 =?utf-8?B?SC9mKzRjU2tCSW9NRU5RUTQvcW1TUEgvVm5MR0ZWTWJFNjBnN0ZpYnRRTVlY?=
 =?utf-8?B?NGJsZjdPeVhoMVEzR1c2MCttS1B6M2ltdFVIdVd5elJ1a3lzZjhDaGU3UkJZ?=
 =?utf-8?B?SUJyb0MrK2lEOVZQMkFqVTBxUzJBNmJjSGZFK2UvNi9lNDdmUzhDcHNmaVVq?=
 =?utf-8?B?RUdydlRjaVBSRXhQK0RUWHlBbTJseGFENmhub0dVVXlaNHdrRnZKbkxEL21m?=
 =?utf-8?B?bEt0NEZ5ME10b0hMR2hXUlV3RXgzZFdqWkRUcm1UOVkzcmY3OWQ0eEFRWjRt?=
 =?utf-8?B?bmRSZHNPb1lvTXM4YW5rNERCdStUMzVqUlR4TjJlQ2JoMjZGM0Q0Y2ZHcm42?=
 =?utf-8?B?UHVxVk90WFR2elVBdEI0MnhXTDFYNzJoajdpdDRRQndEVXlYUHRzdkZXZ05l?=
 =?utf-8?B?Q0h1a21VcjAvbFFwMGRTaE9Kd28wN3hkZHlzZGtzVEdtSDZ3RmN6REVQakhF?=
 =?utf-8?B?UXl6Q2tydHZnVVdsRjQwaUN1QWhZYzFHeTRjc25kQm1vQksyZnBzSEFWMGhl?=
 =?utf-8?B?SlJlYmlWVTAyV3dYM2t6bklXWFcyS2lVYUViZ2dQWnkyRjNLWWZXVXFjY2dh?=
 =?utf-8?B?cmJLdW5hSitQMDdNSVo1MlB3OHdmd0xnZlVOSmFiMTU0ZTNaTW1QRVFxMks1?=
 =?utf-8?B?TnFkSG1EeUVBY3A4cVZob2wxaGlWSjNJdlhmOVlybjdDT00rbVRmMWhSK3Rq?=
 =?utf-8?B?S1Mva2o4SjlnbGpla3ZMN3pHWkIyVmhMOCtNejdHZUdseU5aTXFqcEVWbXNP?=
 =?utf-8?B?UENRdkYxMml6bE55T0pGNFd4b0QrSUVjdzlwT1FDamVxL1VyWlpuNEpZRDQ0?=
 =?utf-8?B?Kzg5ZkRGL2pnSlVFYzBRdlFHaGZhQVlHa09TSnhLem9lbFMyL1pYcUF1disx?=
 =?utf-8?B?REJCN3E4eW9DYmlaQzJMTmJLNFZ3SThpZVlvL1FoT1MwV0N6V2MyZWF0NFhB?=
 =?utf-8?B?ZmxuaW5mOVJZUitnUjdmbEEzZHJVOXpUci9mT1VUeGNLdkhXZG5ENG44K1Iv?=
 =?utf-8?B?VGRIenlCT3lZeUVEeHg1Z0RJekxxaFZCeFpWakNQemlHc3B0RTh2eWFPczIz?=
 =?utf-8?B?WGlaeFhmOXYyUUh1a2M1dWhTREoySTNDTzNXcWJ0WVhDaUVUN3c0UGxGdnRT?=
 =?utf-8?B?VWoxdXBvdVgrdE00MENGaGEyU1RnMHF6aWlnQ3dDSTFwTnlLZXYwaHEzUmEy?=
 =?utf-8?B?ejY5UC9FUGQyaEZ1Sk9FNDRmN1BtZW9iTjdCWWZRcUhJZUFodG5KUmFSUUlT?=
 =?utf-8?B?N1pHS05JL3gvVG5JOEdqc0d0eCt5cVd3bThJbHU1YkRIQzQxWUJ1SXBlZWcr?=
 =?utf-8?B?M01MUlhiKzJ6RWUxYVhBVWZoSGg5Z043K3pIcDRmS2R1dmJMdDFQbGVNUXBn?=
 =?utf-8?B?R3BDMzQ3RWJ5YUpudUpQWGdjN0xKUE5JQUNOMEUrZW9JNlFXazkvcDNKbWtE?=
 =?utf-8?B?WFR2UlJ4RGw2aEVpWUkrOUpNU295eGVsb1VRN1NsajFvN09yWnlwZENLbDJJ?=
 =?utf-8?B?a21LWWVualplYjdIY2k0T2ZCN0JxbEM2Z1dtbnR2SEVrTjY0RFZEeklsSmtq?=
 =?utf-8?Q?temA=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acbf231-d71f-4023-dcb0-08dce7917f0d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 12:05:27.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIYmMjfsr3WDNBLONaS6QapiHmyjk9jkTK7Xhs07XCZ0HxSTlT6O2w0hddzz656q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11073

On 10/6/24 17:18, Jonathan Cameron wrote:
> On Sat, 5 Oct 2024 18:51:19 +0200
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> Hi Per-Daniel.
> 
> Thanks for your driver.  Various comments inline.

Hi Jonathan.

Thank you for your comments. I will address and correct the inline comments in the next
version and I will try to answer your two bigger questions here. I replied to your
comments in the cover letter earlier but I forgot to answer them here also, as you
requested.

> The two bigger things I'd like to understand are:
> 1) Why we have a threshold trigger?  That is unusual so I'd like to fully understand
>   the use case.  I see an explanation in your cover letter so I'll comment on that here
>   but I would like one here as well.

Our userspace application needs the values after getting the threshold event. Before
I implemented the threshold trigger and the triggered buffer, the application would
read the values from sysfs right after the event. In that case the values will not be
the ones that actually triggered the event. When the light condition is close to the
threshold, the value from sysfs might even be on the wrong side of the threshold which
can be confusing for the state machine in userspace. I would say that this feature is
fairly important to us, this is the way our userspace is using the sensor.

> 
> 2) Why do we need processed and raw? That may make sense but it is also unusual
>    so I'd like a comment in this patch description on your reasoning.
> 

The raw values are the actual ADC values from the sensor. Those values are the ones
that are needed when setting thresholds, so the raw values are definitely needed. The
processed values are a conversion to something that should be close to lux. This is not
something I know much about, I just read the data sheet (https://www.ti.com/lit/gpn/opt4060).
According to chapter 8.4.5.2 (page 17), lux can be calculated this way:

lux = GREEN_ADC_RAW * 2.15e-3

It is also stated that R=G=B for a D65 standard white light source if red is multiplied
by 2.4 and blue is multiplied with 1.3. We currently don't use the processed values in
our use of the sensor, but I assume that other users will expect this functionality.

> I've only raised some style issues in a few places. Please check to see if those
> apply more broadly.

I'll try to address the style issues broadly in the next version.

Best regards / P-D

> 
> Thanks,
> 
> Jonathan
> 
> 
>>
>> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
>> ---
>>  drivers/iio/light/Kconfig   |   13 +
>>  drivers/iio/light/Makefile  |    1 +
>>  drivers/iio/light/opt4060.c | 1216 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 1230 insertions(+)
>>  create mode 100644 drivers/iio/light/opt4060.c
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index 515ff46b5b82..0e2059512157 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -490,6 +490,19 @@ config OPT4001
>>  	  If built as a dynamically linked module, it will be called
>>  	  opt4001.
>>  
>> +config OPT4060
>> +	tristate "Texas Instruments OPT4060 RGBW Color Sensor"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  If you say Y or M here, you get support for Texas Instruments
>> +	  OPT4060 RGBW Color Sensor.
>> +
>> +	  If built as a dynamically linked module, it will be called
>> +	  opt4060.
>> +
>>  config PA12203001
>>  	tristate "TXC PA12203001 light and proximity sensor"
>>  	depends on I2C
>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>> index 321010fc0b93..55902b21ec0c 100644
>> --- a/drivers/iio/light/Makefile
>> +++ b/drivers/iio/light/Makefile
>> @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+= max44009.o
>>  obj-$(CONFIG_NOA1305)		+= noa1305.o
>>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>>  obj-$(CONFIG_OPT4001)		+= opt4001.o
>> +obj-$(CONFIG_OPT4060)		+= opt4060.o
>>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>>  obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o
>>  obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> new file mode 100644
>> index 000000000000..a917b59cd500
>> --- /dev/null
>> +++ b/drivers/iio/light/opt4060.c
>> @@ -0,0 +1,1216 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 Axis Communications AB
>> + *
>> + * Datasheet: https://www.ti.com/lit/gpn/opt4060
>> + *
>> + * Device driver for the Texas Instruments OPT4060 RGBW Color Sensor.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/math64.h>
>> +#include <linux/units.h>
>> +#include <linux/limits.h>
>> +#include <linux/module.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>> +#define OPT_4060_DRV_NAME	"opt4060"
> I'm generally against these DRV_NAME type defines as they tend to imply there
> is a reason various strings in the driver match when it is an arbitrary choice.
> I'd rather see the string inline.
> 
>> +
>> +struct opt4060_buffer {
>> +	u32 chan[OPT4060_NUM_CHANS];
>> +	s64 ts;
> aligned_s64
> Which is needed to cover the delights of 32 bit x86 where an s64 is 32bit aligned
> and this whole structure can end up aligned differently from the obvious.
> 
> 
>> +};
> 
> ...
>> +
>> +static u8 opt4060_calculate_crc(u8 exp, u32 mantissa, u8 count)
> 
> Good to include the formula here. I'm assuming this doesn't correspond
> to any of the standard crc codes for which we have implementations already.
> 
>> +{
>> +	u8 crc;
>> +
>> +	crc = (hweight32(mantissa) + hweight32(exp) + hweight32(count)) % 2;
>> +	crc |= ((hweight32(mantissa & 0xAAAAA) + hweight32(exp & 0xA)
>> +		 + hweight32(count & 0xA)) % 2) << 1;
>> +	crc |= ((hweight32(mantissa & 0x88888) + hweight32(exp & 0x8)
>> +		 + hweight32(count & 0x8)) % 2) << 2;
>> +	crc |= (hweight32(mantissa & 0x80808) % 2) << 3;
>> +
>> +	return crc;
>> +}
> 
> 
>> +
>> +static int opt4060_read_raw_value(struct opt4060_chip *chip,
>> +				  unsigned long address, u32 *raw)
>> +{
>> +	int ret;
>> +	u32 result;
>> +	u16 msb;
>> +	u16 lsb;
>> +	u8 exp;
>> +	u8 count;
>> +	u8 crc;
> 
> Combine entrees of same type to save a few lines here
> 
>> +	u8 calc_crc;
>> +	u32 mantissa_raw;
>> +
>> +	ret = regmap_bulk_read(chip->regmap, address, &result, 2);
>> +	if (ret)
>> +		dev_err(chip->dev, "Reading channel data failed\n");
> 		return ret; and drop the else.
> 
> Also kernel coding style requires {} for all legs if any need it.
> 
>> +	else {
>> +		count = FIELD_GET(OPT4060_COUNTER_MASK, result >> 16);
>> +		crc = FIELD_GET(OPT4060_CRC_MASK, result >> 16);
>> +		lsb = FIELD_GET(OPT4060_LSB_MASK, result >> 16);
>> +		exp = FIELD_GET(OPT4060_EXPONENT_MASK, result);
>> +		msb = FIELD_GET(OPT4060_MSB_MASK, result);
>> +		mantissa_raw = (msb << 8) + lsb;
>> +		calc_crc = opt4060_calculate_crc(exp, mantissa_raw, count);
>> +		if (calc_crc != crc)
>> +			return -EIO;
>> +
>> +		*raw = mantissa_raw << exp;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int opt4060_read_chan_value(struct iio_dev *indio_dev,
>> +				   struct iio_chan_spec const *chan,
>> +				   int *val, int *val2, bool processed)
>> +{
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	u32 adc_raw;
>> +	int ret;
>> +	/* Set timeout to two times the integration time multiplied by channel count. */
>> +	unsigned int timeout_us = 2 * OPT4060_NUM_CHANS *
>> +				  opt4060_int_time_reg[chip->int_time][0];
>> +
>> +	if (chip->irq) {
>> +		reinit_completion(&chip->completion);
>> +		ret = opt4060_trigger_one_shot(chip);
>> +		if (ret)
>> +			return ret;
>> +		if (wait_for_completion_timeout(&chip->completion,
>> +						usecs_to_jiffies(timeout_us)) == 0)
>> +			dev_info(chip->dev, "Completion timed out.\n");
> 
> It's an error dev_err() appropriate.
> 
>> +	}
>> +
>> +	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Reading raw channel data failed\n");
>> +		return ret;
>> +	}
>> +	if (processed) {
> 
> Having both processed and raw for a channel needs an explanation.
> It's not helped by processed being meaningless for color channels as there
> are not really an well defined units.
> 
> 
>> +		u32 lux_raw;
>> +		u32 rem;
>> +		u32 mul = opt4060_channel_factors[chan->scan_index].mul;
>> +		u32 div = opt4060_channel_factors[chan->scan_index].div;
>> +
>> +		lux_raw = adc_raw * mul;
>> +		*val = div_u64_rem(lux_raw, div, &rem);
>> +		*val2 = rem * div_u64(div, 10);
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	}
>> +	*val = adc_raw;
>> +	*val2 = 0;
> 
> No need to set val2 if IIO_VAL_INT
> The core code guarantees never to use it.
> 
>> +	return IIO_VAL_INT;
>> +}
> 
>> +static int opt4060_power_down(struct opt4060_chip *chip)
>> +{
>> +	int ret;
>> +	unsigned int reg;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &reg);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to read configuration\n");
>> +		return ret;
>> +	}
>> +
>> +	/* MODE_OFF is 0x0 so just set bits to 0 */
>> +	reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
> 
> regmap_clear_bits() maybe?
> 
>> +
>> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to power down\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void opt4060_chip_off_action(void *data)
>> +{
>> +	struct opt4060_chip *chip = data;
> No need for the local variable.  Just rename data to chip is enough.
>> +
>> +	opt4060_power_down(chip);
>> +}
>> +
>> +#define OPT4060_CHAN(color)							\
>> +{										\
>> +	.type = IIO_LIGHT,							\
>> +	.modified = 1,								\
>> +	.channel2 = IIO_MOD_LIGHT_##color,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |			\
>> +			      BIT(IIO_CHAN_INFO_RAW),				\
>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),			\
>> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),	\
>> +	.address = OPT4060_##color##_MSB,					\
>> +	.scan_index = OPT4060_##color,						\
>> +	.scan_type = {								\
>> +		.sign = 'u',							\
>> +		.realbits = 32,							\
>> +		.storagebits = 32,						\
>> +		.endianness = IIO_LE,						\
>> +	},									\
>> +	.event_spec = opt4060_event_spec,					\
> where you have an optional irq like here, have two sets of chan_spec and pick
> between them dependent on the availability of that irq.
> 
> If there is no irq, there should be no event attributes.
> 
>> +	.num_event_specs = ARRAY_SIZE(opt4060_event_spec),			\
>> +}
>> +
>> +static const struct iio_event_spec opt4060_event_spec[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_RISING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +				 BIT(IIO_EV_INFO_ENABLE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_FALLING,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +				 BIT(IIO_EV_INFO_ENABLE),
>> +	}, {
>> +		.type = IIO_EV_TYPE_THRESH,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
>> +	},
>> +};
> 
>> +
>> +static bool opt4060_event_active(struct opt4060_chip *chip)
>> +{
>> +	return chip->thresh_event_lo_active || chip->thresh_event_hi_active;
>> +}
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
> One blank line is enough. Check for other instances.
> 
>> +
>> +static int opt4060_event_set_state(struct opt4060_chip *chip, bool state)
>> +{
>> +	int ret = 0;
>> +
>> +	if (state)
>> +		ret = opt4060_set_continous_mode(chip, true);
> 		return opt...
>> +	else if (!chip->data_trigger_active && chip->irq)
>> +		ret = opt4060_set_continous_mode(chip, false);
> 		return opt...
> 
>> +
>> +	return ret;
> Not an error?
> 
>> +}
>> +
>> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	if (indio_dev->trig) {
>> +		iio_trigger_put(indio_dev->trig);
>> +		indio_dev->trig = NULL;
>> +	}
>> +
>> +	if (state) {
>> +		indio_dev->trig = iio_trigger_get(trig);
>> +		ret = opt4060_set_continous_mode(chip, true);
> 	return opt...
> 
>> +	} else if (!opt4060_event_active(chip) && chip->irq)
>> +		ret = opt4060_set_continous_mode(chip, false);
> 		return opt
>> +
>> +	if (trig == chip->data_trig) {
>> +		chip->data_trigger_active = state;
>> +		chip->threshold_trigger_active = !state;
>> +	} else if (trig == chip->threshold_trig) {
>> +		chip->data_trigger_active = !state;
>> +		chip->threshold_trigger_active = state;
>> +	}
>> +
>> +	return ret;
>> +}
> 
>> +
>> +static int opt4060_get_channel_sel(struct opt4060_chip *chip, int *ch_sel)
>> +{
>> +	int ret;
>> +	u32 regval;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_INT_CTRL, &regval);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to get channel selection.\n");
> 		return ret;
>> +	else
> no else needed.
>> +		*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
>> +	return ret;
> return 0;
> Check for other cases that look like this. Early returns on error almost
> always make for more readable code than keeping the return for the end
> (After doing nothing useful extra)
>> +}
>> +
>> +static int opt4060_set_channel_sel(struct opt4060_chip *chip, int ch_sel)
>> +{
>> +	int ret;
>> +	u32 regval;
>> +
>> +	regval = FIELD_PREP(OPT4060_INT_CTRL_THRESH_SEL, ch_sel);
>> +	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
>> +				 OPT4060_INT_CTRL_THRESH_SEL, regval);
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to set channel selection.\n");
>> +	return ret;
>> +}
>> +
>> +static int opt4060_get_thresholds(struct opt4060_chip *chip, u32 *th_lo, u32 *th_hi)
>> +{
>> +	int ret;
>> +	u32 regval;
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_LOW, &regval);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
>> +		return ret;
>> +	}
>> +	*th_lo = opt4060_calc_val_from_th_reg(regval);
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_HIGH, &regval);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
>> +		return ret;
>> +	}
>> +	*th_hi = opt4060_calc_val_from_th_reg(regval);
>> +
>> +	return ret;
> 	return 0;
>> +}
>> +
>> +static int opt4060_set_thresholds(struct opt4060_chip *chip, u32 th_lo, u32 th_hi)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_LOW, opt4060_calc_th_reg(th_lo));
>> +	if (ret) {
>> +		dev_err(chip->dev, "Failed to write THRESHOLD_LOW.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_HIGH, opt4060_calc_th_reg(th_hi));
>> +	if (ret)
>> +		dev_err(chip->dev, "Failed to write THRESHOLD_HIGH.\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int opt4060_read_event(struct iio_dev *indio_dev,
>> +			      const struct iio_chan_spec *chan,
>> +			      enum iio_event_type type,
>> +			      enum iio_event_direction dir,
>> +			      enum iio_event_info info,
>> +			      int *val, int *val2)
>> +{
>> +	int ret = -EINVAL;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
>> +			u32 th_lo, th_hi;
>> +
>> +			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
>> +				return -EFAULT;
>> +			if (dir == IIO_EV_DIR_FALLING) {
>> +				*val = th_lo;
>> +				ret = IIO_VAL_INT;
>> +			} else if (dir == IIO_EV_DIR_RISING) {
>> +				*val = th_hi;
>> +				ret = IIO_VAL_INT;
>> +			}
>> +		}
>> +		break;
> Similar refactor to do early returns as suggested for the next function (see below)
> 
>> +	case IIO_EV_INFO_PERIOD:
>> +		return opt4060_read_ev_period(chip, val, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int opt4060_write_event(struct iio_dev *indio_dev,
>> +			       const struct iio_chan_spec *chan,
>> +			       enum iio_event_type type,
>> +			       enum iio_event_direction dir,
>> +			       enum iio_event_info info,
>> +			       int val, int val2)
>> +{
>> +	int ret = -EINVAL;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
>> +			u32 th_lo, th_hi;
>> +
>> +			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
>> +				return -EFAULT;
>> +			if (dir == IIO_EV_DIR_FALLING)
>> +				th_lo = val;
>> +			else if (dir == IIO_EV_DIR_RISING)
>> +				th_hi = val;
>> +			if (opt4060_set_thresholds(chip, th_lo, th_hi))
>> +				return -EFAULT;
>> +			ret = 0;
> 			return 0;
>> +		}
> 		return -EINVAL;
>> +		break;
>> +	case IIO_EV_INFO_PERIOD:
>> +		return opt4060_write_ev_period(chip, val, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return ret;
> Drop this as with above always returned already.
> 
>> +}
>> +
>> +static int opt4060_read_event_config(struct iio_dev *indio_dev,
>> +				     const struct iio_chan_spec *chan,
>> +				     enum iio_event_type type,
>> +				     enum iio_event_direction dir)
>> +{
>> +	int ret = -EINVAL;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +
>> +	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
> As below. Consider flipping the condition for an early return
> Check all similar cases for whether it improves readability.
> 
> 
>> +		int ch_idx = chan->scan_index;
>> +		int ch_sel;
>> +
>> +		if (opt4060_get_channel_sel(chip, &ch_sel))
>> +			return -EFAULT;
>> +
>> +		if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
>> +		    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
>> +			ret = (ch_sel == ch_idx);
>> +		else
>> +			ret = FALSE;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir, int state)
>> +{
>> +	int ret = -EINVAL;
>> +	struct opt4060_chip *chip = iio_priv(indio_dev);
>> +
>> +	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
> Maybe flip the condition to reduce effective indent.
> 	if (chan->type != IIO_LIGHT)
> 		return -EINVAL;
> 	if (type != IIO_EV_TYPE_THRESH)
> 		reuturn -EINVAL;
> 
> etc
>> +		int ch_idx = chan->scan_index;
>> +		int ch_sel;
>> +
>> +		if (opt4060_get_channel_sel(chip, &ch_sel))
>> +			return -EFAULT;
>> +
>> +		if (state) {
>> +			/* Only one channel can be active at the same time */
>> +			if ((chip->thresh_event_lo_active ||
>> +			     chip->thresh_event_hi_active) && (ch_idx != ch_sel))
>> +				return -EBUSY;
>> +			if (dir == IIO_EV_DIR_FALLING)
>> +				chip->thresh_event_lo_active = TRUE;
>> +			else if (dir == IIO_EV_DIR_RISING)
>> +				chip->thresh_event_hi_active = TRUE;
>> +			if (opt4060_set_channel_sel(chip, ch_idx))
>> +				return -EFAULT;
>> +			ret = 0;
>> +		} else {
>> +			if (ch_idx == ch_sel) {
>> +				if (dir == IIO_EV_DIR_FALLING)
>> +					chip->thresh_event_lo_active = FALSE;
> false etc
> 
>> +				else if (dir == IIO_EV_DIR_RISING)
>> +					chip->thresh_event_hi_active = FALSE;
>> +			}
>> +			ret = 0;
>> +		}
>> +
>> +		if (opt4060_event_set_state(chip, chip->thresh_event_hi_active |
>> +					    chip->thresh_event_lo_active))
>> +			return -EFAULT;
>> +	}
>> +	return ret;
>> +}
> 
>> +
>> +static bool opt4060_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	if ((reg >= OPT4060_RED_MSB && reg <= OPT4060_CLEAR_LSB) ||
>> +	    reg == OPT4060_RES_CTRL)
>> +		return true;
>> +	return false;
> 
> As below, just return the condition.
> 
>> +}
>> +
>> +static bool opt4060_writable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	if (reg >= OPT4060_THRESHOLD_LOW || reg >= OPT4060_INT_CTRL)
>> +		return true;
>> +	return false;
> return reg >=...
>> +}
>> +
>> +static bool opt4060_readonly_reg(struct device *dev, unsigned int reg)
>> +{
>> +	if (reg == OPT4060_DEVICE_ID)
>> +		return true;
>> +	return false;
> 	return reg == ..
> 
>> +}
>> +
>> +static bool opt4060_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +	/* Volatile, writable and read-only registers are readable. */
>> +	if (opt4060_volatile_reg(dev, reg) || opt4060_writable_reg(dev, reg) ||
>> +	    opt4060_readonly_reg(dev, reg))
>> +		return TRUE;
> true
> 
>> +	return false;
> 
> return opt....
> 
>> +}
>> +
> 
>> +
>> +static irqreturn_t opt4060_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct opt4060_chip *chip = iio_priv(idev);
>> +	struct opt4060_buffer raw;
>> +	int ret, chan;
>> +	int i = 0;
>> +
>> +	memset(&raw, 0, sizeof(raw));
>> +
>> +	for_each_set_bit(chan, idev->active_scan_mask, idev->masklength) {
> Try compiling this on latest togreg branch.  We have removed direct
> access to masklength
> 
> There is a iio_for_each_active_channel() macro that handles this usage
> more cleanly.
> 
>> +		ret = opt4060_read_raw_value(chip,
>> +					     opt4060_channels[chan].address,
>> +					     &raw.chan[i++]);
>> +		if (ret) {
>> +			dev_err(chip->dev, "Reading raw channel data failed\n");
>> +			goto err_read;
>> +		}
>> +	}
>> +
>> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>> +err_read:
>> +	iio_trigger_notify_done(idev->trig);
>> +	return IRQ_HANDLED;
>> +}
>> +
> 
> ...
> 
>> +static int opt4060_setup_triggers(struct opt4060_chip *chip, struct iio_dev *idev)
>> +{
>> +	struct iio_trigger *data_trigger;
>> +	struct iio_trigger *threshold_trigger;
>> +	char *name;
>> +	int ret;
>> +
>> +	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
>> +					      &iio_pollfunc_store_time,
>> +					      opt4060_trigger_handler,
>> +					      &opt4060_buffer_ops);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +			     "iio_triggered_buffer_setup_ext FAIL\n");
>> +
>> +	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
>> +				       idev->name, iio_device_id(idev));
> 
> Where it doesn't result in very long lines, align to just after (
> 
> That may mean you have more line breaks. If so that is fine.
> 
> 
>> +	if (!data_trigger)
>> +		return -ENOMEM;
> Slight preference for a blank line after error checks like this.
> 
>> +	chip->data_trig = data_trigger;
>> +	data_trigger->ops = &opt4060_trigger_ops;
>> +	iio_trigger_set_drvdata(data_trigger, idev);
>> +	ret = devm_iio_trigger_register(chip->dev, data_trigger);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +				     "Data ready trigger registration failed\n");
>> +
>> +	threshold_trigger = devm_iio_trigger_alloc(chip->dev, "%s-threshold-dev%d",
>> +				       idev->name, iio_device_id(idev));
> 
> This needs some explanation. Why a threshold trigger rather than just using
> events?  Superficially looks like you should just use the event interfaces.
> 
>> +	if (!threshold_trigger)
>> +		return -ENOMEM;
>> +	chip->threshold_trig = threshold_trigger;
>> +	threshold_trigger->ops = &opt4060_trigger_ops;
>> +	iio_trigger_set_drvdata(threshold_trigger, idev);
>> +	ret = devm_iio_trigger_register(chip->dev, threshold_trigger);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +				     "Threshold trigger registration failed\n");
>> +
> One blank line is plenty.
>> +
>> +	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
>> +			      dev_name(chip->dev));
> 
> Check for failure to allocate.
> 
>> +
>> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
>> +					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
>> +					IRQF_ONESHOT, name, idev);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
>> +
>> +	ret = regmap_write_bits(chip->regmap, OPT4060_INT_CTRL,
>> +				OPT4060_INT_CTRL_OUTPUT,
>> +				OPT4060_INT_CTRL_OUTPUT);
>> +	if (ret)
>> +		return dev_err_probe(chip->dev, ret,
>> +				     "Failed to set interrupt as output\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int opt4060_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct opt4060_chip *chip;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +	uint dev_id;
> 
> unsigned int to match the regmap parameter type.
> 
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	chip = iio_priv(indio_dev);
>> +
>> +	/* Request regulator */
> 
> very obvious. Drop the comment.
> 
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
>> +
>> +	chip->regmap = devm_regmap_init_i2c(client, &opt4060_regmap_config);
>> +	if (IS_ERR(chip->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(chip->regmap),
>> +				     "regmap initialization failed\n");
>> +
>> +	chip->dev = dev;
>> +	chip->irq = client->irq;
>> +	init_completion(&chip->completion);
>> +
>> +	indio_dev->info = &opt4060_info;
>> +
>> +	ret = regmap_reinit_cache(chip->regmap, &opt4060_regmap_config);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to reinit regmap cache\n");
>> +
>> +	ret = regmap_read(chip->regmap, OPT4060_DEVICE_ID, &dev_id);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +			"Failed to read the device ID register\n");
>> +
>> +	dev_id = FIELD_GET(OPT4060_DEVICE_ID_MASK, dev_id);
>> +	if (dev_id != OPT4060_DEVICE_ID_VAL)
>> +		dev_warn(dev, "Device ID: %#04x unknown\n", dev_id);
> 
> Prefer dev_info() for this as it may well be a valid fallback
> compatible.
> 
>> +
>> +	indio_dev->channels = opt4060_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->name = OPT_4060_DRV_NAME;
>> +
>> +	/* Initialize device with default settings */
> 
> As below. Comment is (rightly) obvious from the code, so don't have
> a comment.
> 
>> +	ret = opt4060_load_defaults(chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to set sensor defaults\n");
>> +
>> +	/* If irq is enabled, initialize triggers */
> The comment doesn't add anything not obvious from the code.  I'd drop it
> and any similar ones.
>> +	if (chip->irq) {
>> +		ret = opt4060_setup_triggers(chip, indio_dev);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		dev_info(chip->dev, "No IRQ, events and triggers disabled\n");
> 
> Too noisy.  At most dev_dbg.  Probably not useful at all as it is fairly easy
> to see no irq was registered.
> 
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
> 
> This needs to be alongside whatever turned it on. Or if that is a side effect
> of later accesses (i.e. it is powered up only channel read) then add
> a comment to that affect.
> 
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to setup power off action\n");
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +/*
>> + * The compatible string determines which constants to use depending on
>> + * opt4060 packaging
> There is only one. So this comment is currently meaningless.
> 
>> + */
>> +static const struct i2c_device_id opt4060_id[] = {
>> +	{ OPT_4060_DRV_NAME, 0 },
> Put the string directly in here. There is no reason why this
> should match the DRV_NAME.  Also drop the 0 as it is currently
> pointless and when you do introduce some data it should be a pointer
> anyway.
> 
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, opt4060_id);
>> +
>> +static const struct of_device_id opt4060_of_match[] = {
>> +	{ .compatible = "ti,opt4060" },
>> +	{}
> 
> Trivial but I'm trying to get consistency in IIO (slowly) on 
> { } for these terminators (so with the space).
> I'd prefer to not introduce more instances of {}
> 
> Thanks,
> 
> Jonathan
> 
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, opt4060_of_match);


