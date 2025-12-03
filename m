Return-Path: <linux-iio+bounces-26678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438ACC9F24D
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B953A6A7C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72C2FB615;
	Wed,  3 Dec 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ckiJDpK1"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023089.outbound.protection.outlook.com [52.101.72.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CD2FB601;
	Wed,  3 Dec 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768814; cv=fail; b=hVQS+3bEJ0Xb4hgCQwqpifUXcV8cene8uOMCWwXi8ncuWK//a27YlGzgSmXa6uTeRW0QTGnrZwIsBRwLExatQ9KACPJHmnDuqRHkCt2QVube3bk8Bina/+xRUEjfZF6K7gtMPOLN9N1tyAJq3S4ODJzrOhbuKxpv4iPbLsnKBmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768814; c=relaxed/simple;
	bh=Qb+mtLzMMC4+Mn/qXJNGOvo4msHJSN7x6aiWK6wJir4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mu0B6H7PlSwrClVEoZUgQtBTvyp1DpR3FsMNeC+B+VzxIHqZ7i+7q59xWvUx1LYzUniq/5qsRha4aDoI89ya9uemwSLUqYgp39u5E7rB6hyboH5FJCsW+eceMppICkPdh8nTV+nzZJUfPG2e692HNGVmt8rxBW2fqKHUkn8u2wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ckiJDpK1; arc=fail smtp.client-ip=52.101.72.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H46e7/ONf6u9h/lBDSutVgwua8dGWuXSJym8D46yb50JhsTaOmEBn12ANgYBpIUFyGrKENbqqlF8CRrTbdhZmSdNwzgC2y+24RigXkPf09Q3RjQdTh7Iz2EmARliL/U/L2D2pWZ01731vok3CginI6VqbmfBX4u2lbD1IU/6jpAp4jvwPOT+N2h3G+/k4m9BGcz8rHjWUI0hEyHrbcoeOBuG0sD12fUq7j4/bVLUU4sgOQkXQo2WC8vn9zJCczpNZrwpp4ygWaBwKfKDRilQGwkMnBxfcWe1Gsz01kTkWE/g6hGpJqMy7p4uDg07uka9OXtLmFS6OvDBjAGeebW3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zr0ElROFGJjfL4UG6O3ThQzxx47+s6BoNhyiXsUloo=;
 b=MYqndutiEULMmDeTNsVdGt3FS9DYUEjsmokfWypsiEe6aafMnCHFCS9tj+Ge0B1eoySDfZenhiFGKULkwCojek43YqLh0ptnjHaNlrhk2pXD+DQFl1jO78AZ049TMzQHbRylvS85xFZy6cnQT4IBVaV5e45KZanzmjYxVAOHZi/VWkNi8pGeDds1hiFu8codq3ONBnTDN7HSld0+fi8R+jRrVTfBwYDeFwsrcwMpO9+qtg6t4tUEYMs8vtwL0LE8YgNMu/EiFVcMOmTUKJDpAs41gLrZSt11rJpYv7JkK/ZI8I4QGO5IHGsQ6YWGPPFi80XlgMxhcFmvxSuJYfaVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zr0ElROFGJjfL4UG6O3ThQzxx47+s6BoNhyiXsUloo=;
 b=ckiJDpK1N6Who+B6C1ao2pNW8V7XHsSa7/ZED4jgqCMHZ4b8bXv42ZupcfzVJn2XxrIsnJwvViELRbQNAiiWxDg8pVgoeWVGnKL7hANrForenK5IWsWlGz5x2e9LbzxJDGruzdDgy7V/6NIKvPdTQhzouduCHD2BggbtG+nwjkjz1gMLtjva9lib/pCCQslLkLmYrl4NbJyIaBWkjR0HJc3uXlbUGs12eh5dcNyWnLtsZbGig8d2N6WSn2HD1vxKKN2Gk2LnRXDK86lFL3KMe10Z/yl7RjnBhk4E0fGVIg1WGOuMkVGBRr0+JOtxb6Za848cXLulRRDoU7Sxo/sQ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM8PR06MB7810.eurprd06.prod.outlook.com (2603:10a6:20b:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:33:26 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 13:33:25 +0000
Message-ID: <d9651903-6b3b-4d9f-aafa-6377e14879a8@vaisala.com>
Date: Wed, 3 Dec 2025 15:33:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: add support for ad9211
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
 <20251203-add-ad9211-v1-2-170e97e6df11@vaisala.com>
 <aTAxo5sM90vwgxTT@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aTAxo5sM90vwgxTT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV3PEPF00003672.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::389) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM8PR06MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a09af6-b6d9-466f-0497-08de32708971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0t1U3ZHQmU2Mjd1OGdmbElYWG5UV0JDQS9oVmc4SU8waTZRSEdIa1U3Z1pS?=
 =?utf-8?B?a3lZL3NwdSs4dVJaNTZPdjZNaWFkZXBlYWdTTDY4eklvdnI0MU5uYXdNbGtR?=
 =?utf-8?B?YXVpRnpTMjdZRnQvRjErV3lVODFOU3BXQUMvNkd5YzFHb3dFMndzdEdGakY2?=
 =?utf-8?B?ZHdEcWMxdERrY2xKck1yUFF5REZ0NnBwQkNlUmlMRnF3MCtyYVpCTHBIUkUz?=
 =?utf-8?B?aEJEOUp0ZnRRZHFhcWNtNEd5bU9IZFFwZjBkaTZ0aStNZ3czUldJaENXbXNs?=
 =?utf-8?B?SEZCeEdlTmQzbkVFZ2s5ZnVLRVhyZHluSk00blNjUTlQNG5YWHNNbWtyK1di?=
 =?utf-8?B?cS9idE9JVXNtMWFGaVA2MEV6RDh3emVLRDdQc3B3QU4xdEtxaHlGY2dYZmMz?=
 =?utf-8?B?SlRyRnNBZU83NFVtSFdKQ0dKS3p2WkRaR0Y5d1djZ1pMUDlmTVJ6MmJKN1VC?=
 =?utf-8?B?THB6ZnV3eXBkQ2FBRHBoZkxnc3Z2L1E0eDYwaHBwdWFvdkx3TGM2dktzQXlw?=
 =?utf-8?B?SkdxREo2NkV2WjFsK1lVRlAwcFQ0OVpzLzliaXhWZVpaMk9tNWJWbS9qQy9M?=
 =?utf-8?B?M2FiUnAxeFdMYXRjT1dQSTR1U1NibjJtNlNwNzNXYVVxcWh2TlZwZjRxdWhk?=
 =?utf-8?B?Umx4a0pTRUlHVzJyYTcvRlRhMFI2Ri83eHBuQ0w0VTZFMEJOZDdGZlc5UkFn?=
 =?utf-8?B?bzF3ZDcvMnpEbTZwR2o2dHNzOUpSVHpzeFgxZitoa2hrOHZzaW5FVHA2UWZk?=
 =?utf-8?B?N0c4L3B6STJUVUJJQXUyUEE4eHZZaVlzSlNNVzVJRmRCUVJVTFkwbk1FUW9t?=
 =?utf-8?B?WGxkdmVPT1Y1RC9YQTBXZnZ1Y3NnRzltSUlYS291S20yV1JwWVhpLzkzZWln?=
 =?utf-8?B?VjVNYks1RHZSc1FuelJKbVMvWS9pN0drN1hQQ3ZoOXhrWERUc25lSE53K3ZV?=
 =?utf-8?B?MUU0UG5YWmtpNGFaa1Flc1dKekEwQk5sbW82U2Y0K2U0RFpDTnF5MHo1MzhT?=
 =?utf-8?B?UHI3SWMrVm1sQ011STlTT21vZ2pFL3VxUTRPRmttN3ZEdWY2THVadDZRcUhz?=
 =?utf-8?B?cmhkUUpiTHQ2c3ZrMmhDMHRIQ0xXTGlqY3VGV2VIcHMxTmZZcTMrcERTb0wx?=
 =?utf-8?B?UkhsWkpOWk93c3VVTkVsU0JuaE9iSUJ1elpNZVNZVWZSdmx1cWJEeld6cGJ4?=
 =?utf-8?B?ckpWM21HZXhWRDhRR0duVjJ2VjZGMkVZcWw3NStLZzVvdlViSnlNVHEzWWhu?=
 =?utf-8?B?Rmh0dEkwOWk3Z0FqRDd5d3h6TXY3ZFVFUEZCb3FObXdnVEZvWVBmQkpsOHpJ?=
 =?utf-8?B?b2hyL0lzOUIzMmIrQWYyTXZMRFVmOTk3UnBVM3FmSjBqMFdPdk5vUFNIRlBH?=
 =?utf-8?B?MkZ2dU9kZUN1dmhFbExRS2oyVWgwNTJrbXZoUU5kRlljUzhVMVgxdmRZOHli?=
 =?utf-8?B?TCtOVDdidjVpRTdDVnVUVGFCS3NaRENIUSs3WjdmaGZ4aDI1VG52YVBvMXZw?=
 =?utf-8?B?SlVTZXJsK081bkNOM2NYMnlxWGl3QVB2YnJTbUc5TStQb3N1Vy9VWnJ0WHJU?=
 =?utf-8?B?dEZLeE9vUlZVWENLMVY5cjJ1SXhaZEdGaURFdEFrTkVocDVUSFdCNXF3YzlY?=
 =?utf-8?B?NmNWeHdWRno4VDY5bmh0dnI5d3M3UFNHUGxwMXdJamFnNjk0Z1FTVzNlVmFV?=
 =?utf-8?B?L292ZVZlbFZLMlgrblJUazdqK3B6VUJnczdqMFZpYTNsUkE5YzEwNmNVUy8y?=
 =?utf-8?B?d2t0MmoyRG96ZG4wOS85aWl3cjBtMlRVWDdFcXJvUDhUdkc5Ym1YN0d1azRE?=
 =?utf-8?B?UlhPYzdDc0Nobzd2UkltT0Y3aUFWb0dGc2dJY0d2enV3ZVZUZGRKM0RheDMy?=
 =?utf-8?B?c1VldE03OHRVTC9xblQvZ1FSdjR2VlkrOVRpQTRnTEdnT0p6Z2NnOUNyRlpR?=
 =?utf-8?B?TEx6b3RkOS82WnNQajh3QkQ2cjNPRWZYbDNDalgzdnBTNExzYk05Z1hsWkRy?=
 =?utf-8?B?bHQ5dkFCNmRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzB1ZkJkdldGMG1OWnlZK1RvWi9iUU5UbkJvUE1UWGtJeDJOTG9vdzNnamRX?=
 =?utf-8?B?ZGhHQnF6OHJLd0VoYU5yQkRRSEo5TFhHZC84NVRKcWtjUklWN0szNm1Od3Z1?=
 =?utf-8?B?MUh6WVJFU3F4NHd5cUNIQ3ZIV1dZTXdhZ2E0S0RueWdMQW9CSUVXSmt5aTRy?=
 =?utf-8?B?NFJLOFlMMkw2VCtXd24ySTExdkZKTXkvRndPYWV2dEJGWCtyRUxtK2FHT3R5?=
 =?utf-8?B?cnlMYk41aHZQVTFBQXhFUDJZbXRmRzRpbG1nU1BoUFR1bndBWTlVWkg4TUZn?=
 =?utf-8?B?UWhwemtuVDkyeDNMdFJFRHJnbVByS2t3VlI5NjNYNDAycHBKWTg1eEkwbWZn?=
 =?utf-8?B?WGtnRmRzMFVEcHBYbHBPdkRKYU13QTV0V1gwaGVmdWo3OU9LOE5WMXYzaExD?=
 =?utf-8?B?Ris5YTNxa3gzM2d0dmNjc1ZqNlVjQnVjZW4vRVdRL3dDcTdaTVdOTktNZS9s?=
 =?utf-8?B?ZzB6d3pBaVA3Y1hpZHFFcW5jbEExMzhjZzU2bU0xWkc1b2xqS1BVLytGYzlK?=
 =?utf-8?B?NGxWTW56SEI3VDZQOXpXcGhCdUJxT3R4NzhHS2krRmVLSzJiYnZWeHg4MHlZ?=
 =?utf-8?B?ckdBTStDTWxsK2FQeWtIaGNJMVZqUGphNk1MZXVjYmJhdDBUdVdhLzVxYWFj?=
 =?utf-8?B?bVhaMGFUV01SaHRvcVYvZXZRWDZrSTdlVFVXSHFvcE9OY2Y2NE1ybFREZFlO?=
 =?utf-8?B?c1R6MU95cGQreUIvYnVxRnFlSytrMEozMTFqemZnZWxuSXFxV29wSXZzQTFR?=
 =?utf-8?B?ZHdTd3VjNysvb2FvK0lTa3poUXo2aUxoV0thcDk4d1ZMNWNIaGlYWi9sMWhW?=
 =?utf-8?B?TmFBbDRDUlVwYWh4NXJGSUVjTmJlNUZOOEJaR0t6Mnk5SnJyV2V1K0l1a2py?=
 =?utf-8?B?cmdwblluRGFnNTI0K1RMK2dwUGVrZHRDcy84SGRBSlo3eE1LUXFDd1VwMFpD?=
 =?utf-8?B?V05RdnVyemxPYnpSb3VKN2dhWWRpeFNHclQxcEoyYVRteVJDTEJndXhONFhz?=
 =?utf-8?B?bzQ4T3loSUFEYnBWNWVLZExGWUM5YmMyMUFFalFpUzQrTnV3b0VZUjEvWHVy?=
 =?utf-8?B?MmF4b0VseGlCeFFkdlRpUVZDQ3N0YTdjaUJYY0prajFWRThEOUVlbVlRdlVl?=
 =?utf-8?B?RU9YV1VIWjk4dm1MK1Zkb094YXJMK0EvUzhxTW1ObnRmRFpQcnFqSmdyOHNn?=
 =?utf-8?B?Mm9KeDNySlZVUnZ0cjJ5MkpvMlZwcjNXTUtoc2pxTEk4OGJjRW91NlpZTmJZ?=
 =?utf-8?B?VDFVd1F3SjBORi9tZ2dtTlZGbys3NkRuRHpQdzVhNU90NDlIOG1nUmdzNnNF?=
 =?utf-8?B?TjVobzEvTlIzV2NTMFhicENScE1ac1RVK2k3bW9CTXBQYVdHczRNZGxQK2o1?=
 =?utf-8?B?SzdDdEZJd1hBbXJwYWxuZXZodkQvbGxqdkVQZU5sbWFQRlp5N2lqZ01XWnJr?=
 =?utf-8?B?TUNTZ3BDcTA2cFd6VFJzRmtQZnJleGtaRXZkc0pEWDh5R2s4QWJoK0taV3Ni?=
 =?utf-8?B?Qk5uMTI4WnI3UkF3S0hmcXIwSGNqQWN1VkNYcVpwR0hMNTZyTG14TXkvaEpt?=
 =?utf-8?B?S21mK3ZjYVRpbk40dzMwYlBkZlhCZmRrQnhlUUVidzBUcWo4Z1R1THdFeTY0?=
 =?utf-8?B?aXVmUW9OMlBYaGJSNjdPdEVMdFM2ZVlnWVpnRUdZK0pNcWhyaGxxNEJJVnNZ?=
 =?utf-8?B?dEg1d3VWbk9CSjNGNFZLZld3M2lwSGNtUmxKMEhuVzZLOEhFSFNyTGVlN3VW?=
 =?utf-8?B?R2ZjT1BSRldEZUdFeVRsL3RUenVKZXk0QzFyaklLc0lFckZQNnFaZHNaZGVi?=
 =?utf-8?B?RUtodmIvVGhOY0VjUXQvYStFMldoejUvSThxb3BZUU9CVkd0ZUtURlFBbnlN?=
 =?utf-8?B?VkpGN09hL29sRGN3YnNWUUZ0eGRwcjZKUzZHV1J6WVh5VUJ6NDgzajE0TG8z?=
 =?utf-8?B?TXdWVjBzQVBEQWV6b3RIYmpsRk1teUpHSVZPTHBZZlB6d0ZVRE80eHVKNkg4?=
 =?utf-8?B?NjVDd09HVzB0SFBGQW1USFlIUEV2dHE5VWJ5a2tMbWR0S2EwVXkwTyswUEZa?=
 =?utf-8?B?cHh3Qks1ZlNHM1Vhd0NxVkhmSDIyanlxV1dLM0JXZlMxd1lnZzYyQi9GWDRS?=
 =?utf-8?B?NG02T2RjNnA1eTJQMkNqMjNBT2oybWhQQ1ZGb1JyZjhEVDRCM3FYWXpTd2hH?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a09af6-b6d9-466f-0497-08de32708971
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:33:25.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCct9MqKG93DC4VNwrPa049CUkOPiNMM/oYhXY47kijebPSTWy5heRW5bMwCP+ZNa0eC7WTrFS/J+PzCNtfEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7810

Hi,

On 03/12/2025 14:48, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 12:20:34PM +0000, Tomas Melin wrote:
>> The AD9211 is a 10-bit monolithic sampling analog-to-digital
>> converter optimized for high performance, low power, and ease
>> of use. The product operates at up to a 300 MSPS conversion
>> rate and is optimized for outstanding dynamic performance
>> in wideband carrier and broadband systems.
>>
>> The scale table implemented here is not an exact match with the
>> datasheet as the table presented there is missing some information.
>> The reference presents these values as being linear,
>> but that does not add up. There is information missing in the table.
>> Implemented scale table matches values at the middle and at the ends,
>> smoothing the curve towards middle and end.
>> Impact on end result from deviation in scale factor affects only software
>> using it for scaling. All the possible hw-settings are also available with
>> this implementation.
> 
>> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> 

That will give

WARNING: Unknown link reference 'Datasheet:', use 'Link:' or
'Closes:' instead
#22:
Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf

So I would like to keep it as is. Or then please convince checkpatch it
should be accepted as a valid tag ;)



>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> 
> ...
> 
>> +static const struct ad9467_chip_info ad9211_chip_tbl = {
>> +	.name = "ad9211",
>> +	.id = CHIPID_AD9211,
>> +	.max_rate = 300000000UL,
> 
> It's too many 0:s. Less error prone is to write it as
> 
> 	300 * HZ_PER_MHZ
There is no typo here, but I agree with that suggestion, thanks will update.

BR,
Tomas


> 
>> +	.scale_table = ad9211_scale_table,
>> +	.num_scales = ARRAY_SIZE(ad9211_scale_table),
>> +	.channels = ad9211_channels,
>> +	.num_channels = ARRAY_SIZE(ad9211_channels),
>> +	.test_points = AD9647_MAX_TEST_POINTS,
>> +	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
>> +			     AN877_ADC_TESTMODE_OFF),
>> +	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
>> +	.default_output_mode = AD9211_DEF_OUTPUT_MODE,
>> +	.vref_mask = AD9211_REG_VREF_MASK,
>> +	.has_dco = true,
>> +};
> 


