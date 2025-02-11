Return-Path: <linux-iio+bounces-15317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50746A3017F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 03:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F63A3A5EE5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 02:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123217C91;
	Tue, 11 Feb 2025 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pmb9mZiX"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6291C8FCE;
	Tue, 11 Feb 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241008; cv=fail; b=TqC+MCrhOONjd2+ATvlDRF29eqHjJAPAmxPmYhbTeOkiANs+jo3XpeYgqkqqlAsp1npd99Q+5RrddfdbJa2bbUiSfxC3sYWuBZxaHWpbVI7gEe3mapiTeP7HAKNxr4XSEnMpsf3/FB+vHag7MYnFqhJryXWH58i6Hjao1qKockU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241008; c=relaxed/simple;
	bh=aFSYvmx7UQwHs7k+LGxv5PuBxBdY81VdMC0z6fqcUJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nA4QRivGmUfNiAdT7qGK+oq0FDz+pxedZsAtfAe3jIJxrl+7w8LQvKc1MSCNON81HqI55cRWhgFdPrnkZVvu7EMgd4KGjXl4a2OXhlEOK0fRLZ6Lx5eAzTGd+Ok3nCNiqGzI12IwUJ+0RoLyolBK6ouEnWV3Mv0AAFjbCPOIe5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pmb9mZiX; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Suz0AVtRQcM1wSdd925bnTR1VW3V7UxrJMd56xWyEe3ddOdoyLftOwacz/89MCRhi/+KGRD0cyowfEGxUZVkMg/UKRcz4DUj26SNpkhcGalpyM1iEwAx0iN8SR8u9J9kEtvK4ouwoUmr/LTL0yPN+kTrZpTesrc6n6wD0DxF9upsX4FdDjZzvQtvVFSiVww4kq9jb14XE+/DV4L//9zYd2J9gB5/vQwmx5ap80mkcNIxRA+v0vEGbv4ZGirWnAb8QyoKWHoCa8SxMMk5AKAZiBHQBNMwr5Y3Aj57c13iRBEouK+XXDtLP2U8PDymbmL+V2diGv1IIbx6bhLXflmYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFlJ94XwxTN8ILiQZyofIy4sHKsc1y/Q7ED8NwJluJA=;
 b=G3Sm0aLoVogidRFrWnBQKm1AXqki2ofpTk4qKrpMhduOKWYgEn09PHvGVbG+SwcNdybco36w9ohuH6kdcR2teBjCOa26u9fBcSRM4qFSw26+916M2qftCL4iKHsd7VouP3R54BHaZ+MqTY3YlVUua3oL51aeCJ0OeTQSdMjMcMiisnjRk3RY7uFyhRCpCPGUk1/kS2yPi5J8ana9qFcOgXSDD9BgTphX+o97LreFVVFkZkOEvF/67Qaz9z3HYn1DhJ90uanNDoUUscnW1Dr8O3jYa/wCPjwBSpJL/QSYQJscVHuLdtoq0N9flOoN1GXDr+DmyDJTLC0cqnH/Jqv12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFlJ94XwxTN8ILiQZyofIy4sHKsc1y/Q7ED8NwJluJA=;
 b=pmb9mZiXrLQuSZ1+//6CgjoIqctb52ii5XHvCFePU2DnRnI3B2Uw4dy4BKe+x3ivwQO1HAQQ/O2ZimCs6xs0ILtCiE+jOoWsmB7K8Q/GuhFlSB+QI/P6VLzXaUZejqrPbzML4nFArk5FS5YWDORQR7FKYm11Uo7mrnso+Nctwsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by GVXPR02MB10853.eurprd02.prod.outlook.com
 (2603:10a6:150:158::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 02:30:02 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 02:30:01 +0000
Message-ID: <c397401d-63b7-7a6e-80fa-16dd4ceb0537@axis.com>
Date: Tue, 11 Feb 2025 10:29:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] iio: chemical: add support for Sensirion SEN5x/SEN6x
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, robh@kernel.org, lars@metafoo.de,
 krzk+dt@kernel.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-4-Hermes.Zhang@axis.com>
 <20250208161501.7b6c6c17@jic23-huawei>
 <1237314b-78a8-a871-ea24-f3011766606b@axis.com>
 <20250210190942.21ba97cc@jic23-huawei>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <20250210190942.21ba97cc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|GVXPR02MB10853:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fb16c3-dbdb-4e4f-69b7-08dd4a43fc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0k5bTA1dVlrVEFVZldob0pEdnRMUEhpMkM2T0lpdkZsTXBxaFM2QnlyYXlh?=
 =?utf-8?B?K1FXYVhuQ1JnWlBQZms2UVNuZzVoMzN6VzEvdVcyL3VXUWFQSjAzL0FaZ09J?=
 =?utf-8?B?RzErMmJ2cDNCRGdpb29QY3FoZTdudC9aZFhOMDVCNzR6Z1dGVFd4MXNGeW0r?=
 =?utf-8?B?Ui9ZdnBCWmt3NEhBRzhFYmszK0M4VEtLdUxScndicWk4Q1FIbllyMjNJdERu?=
 =?utf-8?B?K1BDV0lld0J6c1Z6cHlNSVNxOElScGxRK3dLVURVdEQwYndoMGRhaFRIaXAz?=
 =?utf-8?B?UEhUUmxNRVNzQzVjRFpnQTQwL0lqYktyVFFGQXJoUnAyNGpxb3ByMWZiNllY?=
 =?utf-8?B?WGRYd0JoODBnMUhDSFhZTS9pR2huaWxEVC9xaHFqSGNZYXp1SHdYZVp0cmxS?=
 =?utf-8?B?VW1TdTBieGJ5SjViTys2Q0RlOG5mekFrOS8wMUYrYnJFaE04Q1FPMmVqSHNL?=
 =?utf-8?B?S3phVnlnWmVjU1RvQ3lQYnE3R2hzSjBSd1NEYVcxaG0xaTdmNm15Z1haVUxy?=
 =?utf-8?B?TEtVTjE2UEJnWktkdE1PczdaaXVWRFNMTktrQ0JNNVVLTmlVclVDYS9ITmpt?=
 =?utf-8?B?NWJENVVHT09USENaMVloZW5jRDA1dWVJZlVTY01UZmpIcWhocnBJMXdyMTNl?=
 =?utf-8?B?S3N1YllpUURXMXF1YTFhUVhsQjZXNW41WTZOQjQvdExNdmxqTE10UWo4L2pC?=
 =?utf-8?B?SE80MFJ6T2NTSlBocnZqQ3E3cnQyZHZuNU5yT0pmcHBqaCtBT0lFR0RGb3Rn?=
 =?utf-8?B?WUFIbEM4SjR0K2RHVDlweFdpRTlMTzdoUkxBbmlTbkJqS0RHWkdlVCtBU0d2?=
 =?utf-8?B?VEpITHBCd2ZNUjh1WjhmdWdUdG15OWxVT3h5YlBoYWI2ZkN1ZTlyOHduZVBj?=
 =?utf-8?B?aE1JNldKUHphbC9yL3BjenlydU84NndwWXZjUW0wSVlBb2V0aDRuVUhTa0tU?=
 =?utf-8?B?L3ZzV1FyU1pQOGVib1VlNVcxL0JkOHVPOWpRQkxkVVZTNHYvMklwMXVWaFFO?=
 =?utf-8?B?clFIV3FVQjcrQy9NYzZLV2xYQytkNmN6OVM5N0xsUHdQQkJJZWNuK3ZLUjgv?=
 =?utf-8?B?OUtDK3VGcldCbXdWYXhHQkN0dU5CejdoeTQ4VlRMbG5GdVdJbFVsemRGRzMz?=
 =?utf-8?B?Y0ovKzlwMXJieVllWno3Q0ZWUS80TnFYOXVJSmRNVjZOR1NZaEd6WVBuMEhy?=
 =?utf-8?B?anBOQVB1N2tqbFFMc0hJaytubS9Fc1hsS3NzblV3TGpUY0ZtWDRad2Y0VzBD?=
 =?utf-8?B?YmlMVDFoMmJrM0NjK2g2amt5eVRLMHFRUjhHVDE4aHFnQlU2TGdyYllnRUgr?=
 =?utf-8?B?US9CdDBuOGFaMGViV0l0bTJHaXpMaGd1amdVVGRDaUxlQWdIeENLOFlNUUY2?=
 =?utf-8?B?Y2VMcStrcUZYTzlXeGpQZmpzZnUrbklUaEd6Z1B2U2xsTWhnZ2Q4ODNJU0Nl?=
 =?utf-8?B?V0k2eWJKYngxUUUwbWk2RDFpZkplZmQrL1paR3dnM1J0eTk1NjhkNHhsZHNX?=
 =?utf-8?B?Ym1OSmNyOUZoRjBQZ2Z0Z1owU3lMVldHekdnbkc3eEs3V1dxR0lRMWd0VkJQ?=
 =?utf-8?B?aG9IVGp6K1g1NHg2ckVSSjJQT1h1cUpKaVp0dWZ2ZU45UjRqb0VQSVV6Uy9T?=
 =?utf-8?B?dlFISzVQVTdqalBWb215MVB4TnpycjR0RzlqdlFXZjZmN3pBTWI3RFY0RC9V?=
 =?utf-8?B?WHpvNHR3eVNlQSs2emVxOVMvU2xLT3BIUEtvNkpVandwemk5RDFYaDBRYjky?=
 =?utf-8?B?dG0rV3JKclVSKy8rMlZYM3hnTHo1UEE1UlF5Q3Njdmc0bjJBVlJRMFp6OUZi?=
 =?utf-8?B?NTlBZ3RQUUI4YUZnV0dNa25BcEpmWFA5Ujh3SzVUa0c0SEdHc3JaUzU3TURN?=
 =?utf-8?Q?zjvv3wDG++NXd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFN1dGVESlI4bVlGay92QnEvOXZrR1NpN082UisvR3hVQ2J0ZnZFZ1hEY3hu?=
 =?utf-8?B?aFJzOERQR0ZDVEpXdHc5SmJXNkFpMHNYcHB2L0FnbjZseS9aY2xyUzh5OFNi?=
 =?utf-8?B?aUljemdmS3pHVU51VldyeHhXbGpDN3h4dEtNL291Q1N6SzI3WWRocEM2cmZY?=
 =?utf-8?B?d0pDSzFHb2MzaWl4U2VzSlNuVnVCb2xLcDlSNzQ3WTNSdmhzZ09XNWovSjR5?=
 =?utf-8?B?TlNJb2JyRUJieVQ2ajBkR0pXQ3JxeHloL0FkMW5GbXZJNzJYblNVQ3QxUkl1?=
 =?utf-8?B?VjVNSXF0M0dkY1lSZXFtWEZ1VkFFZUlaVmRZT01ndGZJSGFUZ0pzMXZTUzFx?=
 =?utf-8?B?SDdxaW9VclE4eXRCT3V4TmFLRTkxbWY1WGthV3RkUnFUbER2VWpPSGo4SlZM?=
 =?utf-8?B?M0hjRy9MZlUrRVpPeHBEVjhVQW5YdzkwcDdPZ1NsaERYNEdYQkNOWERaRWJN?=
 =?utf-8?B?VnlnZnZYYWJoODh5RGxmQlZBbkFIR0FlTm5uV0QyeldjSFUwZkExUStUVE5M?=
 =?utf-8?B?ZjRYdkZ5L1p3cG5MKzcxKy9LL2VQRGJPRnJYc0l6Nmt0RmVrYkF1RXNXcERH?=
 =?utf-8?B?cEtrS0pBcEVKRDVseHpkaXMwWmlvaUUwd2tkR3V5MHlwTEtEU3ozWFZrTTNB?=
 =?utf-8?B?K1JxeGdDWU85WXA4SExPTjBlbkVMWHpDbGExSjBjK2QzTFhJL1lydjBnUGFl?=
 =?utf-8?B?Nm8vRWEvM0E5TUptQmhIcmNpM21Sc2xlcUJac203TEp4ZTY1Uk9tVkhoSnBX?=
 =?utf-8?B?eG11Q3BrUGgwNVkzOEVkbWRSN2wxQTh3L3pqWGlOdXRVaGlib3F1dTJpaFBl?=
 =?utf-8?B?RnRXWnZsTU4wQXA2RHEzVmJQSzRVQkNCZnVkenVwRmluYUw5Mi9hanRIQ3lS?=
 =?utf-8?B?dkhxeHhLY2ZpYmlQVGV5b05YVW5jbkZpSThYNUlObStmUEgvb3FOeEsyM3N3?=
 =?utf-8?B?dUFDUENqSmJwQWJYSmZjSTBUN3ZXNjJkWkdQS1B2YWhzbU1yQWFnTUZVTEpw?=
 =?utf-8?B?aklUZW9CREpRcHFRZ0NISHNhNll2RkJNYXlwRmxvZUprOWJtbWdJbnE0RXF0?=
 =?utf-8?B?SUhaMWFFb3hQU0dHTzFJZWlIMlBoV0hRcTJZMFdxaDJjMzFjeFJRYzZGMVBa?=
 =?utf-8?B?Y3g0V0R0b1FCRWRrcVBQVmNCL3RlL2NYbkJvcTNPQllzTmZvTHJsYlMrS1Fh?=
 =?utf-8?B?TGhlQ0daN0EvdTAwSGkveHJ3RTl5LzlrK0Z2bkpuNFRqVWdVbnJ6NTMrSnJw?=
 =?utf-8?B?MS9KZS9aMnFicER1aVNDeHQyMlFxUXZaTHpETUNFRFd3NGpSR0xjSEtaWTJC?=
 =?utf-8?B?TmlyS1g5K0h4V2RIWXgvSHV4MVJTYVRBbDVGYU5aVURTNE1FWHJ2cDdXZnR3?=
 =?utf-8?B?aFZNMVNjTlJRdDRyc3dFK3d3T0c4U1puNW9pN3dHZEQ4bGpOdDJOeFlVS0VX?=
 =?utf-8?B?TzFEMzVXTzYwQUxmNVVGOTBhb1R4aHkrYWhtem1JRkdzeE5vbEpJUEdPSVFO?=
 =?utf-8?B?MmlNc3JLUjZHa3N2cy9pOEJ2aXRMazlWM2pOK2owQmVZUWRVdGRoZDROdTRH?=
 =?utf-8?B?Wi91WUtRV25taDlnN2RKdkl0QStLTjE4R1VVQ3VORHRZZ2xQNEV2Q2dxVkVj?=
 =?utf-8?B?TXZ3alBoZmNNMkJza0c4UzNESG9temdTUTZ0YnJLZ1Exb1RDT3NkakhKTjR1?=
 =?utf-8?B?YjJaRWh4Ny9qbHJZekJ4V2phS2piTjNvWmIvejRIMG91Y3pKdHJibDNLS2tv?=
 =?utf-8?B?UGJJVm1BWUF6VFFoRXhYUGdFUlYwbks3dS9sOHZocDExaER0UENwMExwM1Fr?=
 =?utf-8?B?emdXTFU1b003NFZJRFB5YWVtMkhJb3hnY2NkNlhtQzRvNFMwbm9JOFd0WHNU?=
 =?utf-8?B?bEhYdUQza1pJZ0xUazhMcHhZREdnWE9GL0s5N1VLWmx1c1BqVjdqR3ZKaDV0?=
 =?utf-8?B?Z3BuZ0ZDZnk1cWZkZ3hxOFV2cDdkYnB3c3A5UFB6K2thb0JoM2NrdmxJbHM5?=
 =?utf-8?B?dlh6ZkRoSkhiYytBOElLSzgyOFlsdVdob2VLVnpXYk5GWmN4aksxaW85UGFP?=
 =?utf-8?B?OVhDdGFtWVBEODgvaHF3bjhyS1VYK1RFWEQvY1F6ejgxODFja3BoQ2Nxdk5Y?=
 =?utf-8?Q?yrnzA4iYR03JUgoOZniqcsyY/?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fb16c3-dbdb-4e4f-69b7-08dd4a43fc70
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 02:30:01.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4mf5hrWaoYlbovPzFa+Z8p3w28x3yYHZTtUUGsQrkBID9fPl1yaDAOq6cGHvS+RLh9F5sj+/+XOAK/Yo4xG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10853


On 2025/2/11 3:09, Jonathan Cameron wrote:
> On Mon, 10 Feb 2025 17:16:57 +0800
> Hermes Zhang <chenhuiz@axis.com> wrote:
>
>> Hi Jonathan,
>>
>> Thanks a lot for your review. I will fix most of them in v2, just one
>> question below.
>>
>> Best Regards,
>> Hermes
>>
>>
>> On 2025/2/9 0:15, Jonathan Cameron wrote:
>>> On Thu, 6 Feb 2025 14:15:17 +0800
>>> Hermes Zhang <Hermes.Zhang@axis.com> wrote:
>>>
>>>   
>>>> +
>>>> +	state->last_update = jiffies;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>>>> +			   char *buf)
>>>> +{
>>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>> +	struct sen_common_state *state = iio_priv(indio_dev);
>>>> +	int status;
>>>> +	int ret;
>>>> +
>>>> +	ret = sen_common_status(state->client, &status);
>>> This is custom ABI. So it would need documentation and will need
>>> to overcome quite a high barrier.
>>>
>>> Superficially this looks like debug perhaps that should be
>>> in debugfs?
>> The status is one of the support commands from the chip, we (from
>> userspace) could read it and notify customer if the sensor is wrong or
>> not. So it is ued in normal usage, regarding the ABI, I see your point,
>> so instead of my way, do you have any suggestion for how to handle it in
>> iio? Thanks.
> What is actually reporting?  I hope something more specific than
> 'wrong'.  Also when do you read it?  Standard software is never going to
> so you may be better of doing some scheduled reading or reading it
> on the back of a channel read.  Unfortunately the nature of failure modes
> is that they are not easy to describe in a generic ABI - sometimes
> our best bet is to just log an error (rate limited).
>
> Some of these look like they mean the data read is garbage when they
> are happening?
>
> Jonathan
>
It's e.g. a 32bit data which some of the bits indicate if the 
PM/CO2/GAS/RHT/FAN is error. Yes, the software will scheduled to read it 
and deal the error based on some policy configurable (e.g reboot the 
device). I hope if the driver can provide such inteface to read it, so 
userspace can decide how to handle it. Is there some similar case 
already in driver now? Thanks.


Best Regards,

Hermes


