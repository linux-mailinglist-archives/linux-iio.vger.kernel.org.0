Return-Path: <linux-iio+bounces-26637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25601C9BE25
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08A544E3636
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4941FA272;
	Tue,  2 Dec 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Gz70urME"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021085.outbound.protection.outlook.com [40.107.130.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A52AD00;
	Tue,  2 Dec 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687683; cv=fail; b=NTYb/vHX6bpN1reRUPUZEpTPF8UiQpt8aeUgMCJgfYXor1ruxJy9k2R6T5+ZwirQTNWCNinS/oVjaUCkoLlsdCnIoZYtVr54MZ1cPveHivXWyapBcy4/cQeTjK3UZCvWC4OybA8/Z6OvZTk+R/JvjXjAU4L/8cpVTjKnymIiwK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687683; c=relaxed/simple;
	bh=4QH+tf4e7ung8dT0DuCI7Zl1HZws8fRij9rH06ve16o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWCaJzbFR0mZkKlSXfGvjKwaIyHz1f1jmEITu0CphKP3dow5aZaaEtsXPHk9uCEPe8LTdK/lALwoBRnKc3E1Cwwt+dj/LdBTXkXEDNBR4mmdfRQiB546uhB6kt9If/2gGgx5y4/fGDgmjedN9/K/mClOgR600xdI4DJLVsMrbhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Gz70urME; arc=fail smtp.client-ip=40.107.130.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns0huZsJYL/YLxCNhOKm80ZWTLhc1Da8krmaA+guqLTEkJrbZir5uPtuNn/kV2VxYJAS+MbLIXdIFtAGM4XLV8AJaCpyENg5hkiaap22UtKHLyfF059Ve01HhjoDuoIdRIYtl22SJzYNMpNJsDQcA0Y2aJa/efa9JOBbU2ZnedYy+Uy2vj+S7h1TXUNMhhp2N+qDjO70+61jo8EtXEwwAtdaQFHKIlE8bgn7vGrtxYcV02fbEAXp6MX8rmUaDuwc+AIMsazoo7U7uBMCLjFjhuUmahXqZfDW+BM/EYmWIZRTf2RXbpsPXIYpGceQbutyNMujfXNmF/J0/kKWCO97aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQU0kNZ823WAZgmiP07I//cQN830z7Mg96ildAlq8cc=;
 b=zQ31gHspXZ6AZIxHFc8/yP+pkcJ13v0iKola9Lyq8lc8EnfjPEj7OcxeG2R5ZbHhWVrGSwg9iHNHq5YL7of1UUuDDv+TxKq13fU9EXtel6fU4sNm57w+b4aZD6reRaBiYJQYbguhumqdht27ZOTiQMeMFSy41tHvMsd14aGkqdNrcqF0ZSL3jB6a82hoBcPcYAWFOQDWHPQD/ZkaTwh3aY0jXz3hW2sNC2VgG5K56pC6RTAdHjScALhUvVIJ9SnYQqkb2uxe4+2B+OlSbz7BFGn35NBeiab7vB9iktcHhbp/svo4CDC407jE84sE+v7n947808V9xvaVLNoKCXqQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQU0kNZ823WAZgmiP07I//cQN830z7Mg96ildAlq8cc=;
 b=Gz70urMEC+OkbZLRNyYXs96RLKHX0K0gOoKyCt2nzqtEzQnlZEdphX3knGz/77ml6P1WEeuYFlIIEg2mV/ThLxK0ADTvFYwiuJScW+cB8QLbOM6Yhc2CKDxujoiAR40Hh5N4j7RuM5wf+Lp93Nzzwl9kEyrx9Vm2eEBG5rCkdlyD76u/Ig4G6VmgJSwAIQhLkNZsnARItO+sqyNckOxwno9ev8ti1FEejki4WIhK/jhitnDawHBe+nTWPS8H1pgRB/qVwnfioH2+URC20YgdD1waGIHSjtjlpy/I2cPzhWR94U9m++HNZRiLML3rIYh3oZoHHSewcROU//z/wStoTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS4PR06MB8517.eurprd06.prod.outlook.com (2603:10a6:20b:4e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:01:17 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 15:01:17 +0000
Message-ID: <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
Date: Tue, 2 Dec 2025 17:01:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::20) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS4PR06MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa9bf93-c9a6-4abc-0839-08de31b3a4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVhhLzBMSlE5WTlOSWJBZ3RVcWlwSU5FL0F0eHdrbktQeCtCNUJOSlZqMVl6?=
 =?utf-8?B?dVg5WXpxZDN5R3ZBQ1hGL1p4ODdVcEMzZlNBaHB5L1dOc2NKb1FVK0NxNC9Z?=
 =?utf-8?B?VGU1bmVqTGRaeU81anVUUlB5UUhycSs5TUQrNDQ0ZFZ4bmg3RmhzYkZ4VXdT?=
 =?utf-8?B?ZkdYd2dJQlhGK1plYTlFR0RNM2xtMjJBUlNVN3hKUk1Ea1M2OHhwQWZ6SXJn?=
 =?utf-8?B?TlQrTUdLWFFTL3dWL2Z2bDZiMjhYNTFDbU5FM2Ryc0dLeW9GQXVuWElVZ3NV?=
 =?utf-8?B?dEY3ZXR6UVplYzlmYXd0YlZTUGNxWFF0dE04UnEzMlkwcWdvaEgxTkdYbzlp?=
 =?utf-8?B?UzdBM2dFWTZtU0xBYVFRY3Q0eVpLcUVwZHExZ243VXRLZGk1c1JCQ05IdnYz?=
 =?utf-8?B?STBDcUxqQzRjdnh0Q1ZXRGRxM3UvMmdXQk01MjVMU2U1YkZwMXZ6dEVmRHM2?=
 =?utf-8?B?bTZUbFRVYlFLdHRKQ0ttTjV3Y05oY2x6WitrZ2dYbnlxaDFHWnlTM2t0dVlC?=
 =?utf-8?B?TEZzU21sMkIyNVVBMUtiRmxCUFVlWUFaVWNIUUZKTHJBZWFiMlp0NFRMSnB3?=
 =?utf-8?B?UVo4anplczVoaXdXbDlSS1ZFVkErOHAwUkxiWm9EWFpEY0tlNjVXVE1hbnJQ?=
 =?utf-8?B?MEdjUXFZcVAwTWtyQW14ZHFiYlF6ZndjZnJPcklZZmJFRnZYdVVJMU44U2NL?=
 =?utf-8?B?YXdLZDlWZzN1eW9tdXJnV2VVUDN4bnBwS2dwTU9KblBVRG5LWktibHI0VWM3?=
 =?utf-8?B?VHNtaGNqRit6N0UwOUYwLzBWS0hLcERBTmFJVExIeTE0Y0MwQXV2cHB4d0k0?=
 =?utf-8?B?Tkgvd0phcWhLSHdFdElGeUhxZS9EQUwyMlp6d1pVZHVFUGVMZnMzMnQrQmhN?=
 =?utf-8?B?dFEzUERjWlZtY3Z4NWY4N0UzK1FVc3lTaGJ5NXRDYWhvZmxaZnduSHVvak4v?=
 =?utf-8?B?ZmhFYzN4RnpBZVlITFNGUjc5TFFxZENhVTlOTDhYUUpxTnIvNkFFeGYrelFQ?=
 =?utf-8?B?SG9CKzEreTRtN0RWRFlPejdpMUlKcG5LM0lIMUU4bTlSUFBuL1NQVnpLSWRF?=
 =?utf-8?B?WXRxK0NjNmxrcnViQitjaDIwb2g2VHhxN1F6VHVHaENwNGthR3c3VzJ0QmpQ?=
 =?utf-8?B?NCsxUzM0VmlTSWRndkN5dkNJOWt2WVlPZVB3M3VlU04wZW51SVBRWWlrUTJC?=
 =?utf-8?B?dHloYWpLdGpGWm1xekZuMzA0RCtRaStuV2NEK2w0SisxWHQ3UVQ2OWRJMnhK?=
 =?utf-8?B?L0svd2lwbmNXN1pUdmVENjRPSVBkbFNZQVZWMnVNZ0ZwZ1RLWGlmSWgwaFRj?=
 =?utf-8?B?MVUralZIZmJIcnU3REMwT0dXcG5YT1dwWHRET3A0TTFJWG82enVVd1Q4UXVu?=
 =?utf-8?B?KzZJTTZtazFVdXNrRVRmRHdTTnNpNFB0RzJJK2thMk1PNlhDSWo2UXp1WjM1?=
 =?utf-8?B?VUdDaHZ5bGYySmdvYUo2bTBtcURVWFZHYWNqNnI1RGFVL1FLVlE0ckhWbmdi?=
 =?utf-8?B?azNpVVE2eWZwczRaR3doaVFMdnArVmZtZEwycWZLbzlRWlFwSlFLUGNGc2hP?=
 =?utf-8?B?dEwxK2dNMVFacGdZQVp1d0Z1MDNhcTkrWTdUdUkweTdZVFFPaGpDNUZxN0pv?=
 =?utf-8?B?K2FVdzNKRFBDQjlBYlRxNkQ5VkZBYmpvMEdyR3hRZkZnWWYvWGpwdkxYZVpW?=
 =?utf-8?B?d3NwQ00vWUxxMEQvbXpGZmRETDg3Y3ZUV2FLZkczc0EyS0JVM3F6RTRKWlla?=
 =?utf-8?B?dDR3b1NLUzZwdDdhUVZTWCt0TmNpbkU3cTlaMHE2bnpVNGQ4REM5QnJWVEZO?=
 =?utf-8?B?SDBuV050NDIwUzl0eDNyaTY1eTFDbTRhdTltd2k3NzVoVU1lME9YZ0ZlQTcw?=
 =?utf-8?B?THNyVEtEVi9lTmROa3ZOZUJ1dER4VWFMZGVjaFRETmcyenczNVhsUUJLNThl?=
 =?utf-8?Q?mRhpxyXy35kttVb1ptwpkVgNz2/flFvU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm9LVTVPalJUckRoaVRCZUpmVVJrajVjTklhYVlnN25DVUM3VEx6LzhJRmI1?=
 =?utf-8?B?OE9qMDhJM0V3M0Fmb2lXZUdvZS9DUjlUYXBoV3EvWXJqaFhwRS85dUJFRTdm?=
 =?utf-8?B?NFR5dnhaMi9TQnR3NXZHMnkvUFl1WTlCZzFLUzd3VFkzdUtibHNIdWhoVzRk?=
 =?utf-8?B?YkJubVdhaiswM0YySWFkbkpNVy9Ba0s4czFDV3NsL1Bwc0xmakpVZ1VJOS9L?=
 =?utf-8?B?OWllSXpNbkJLNlNZT1JuVHNCdGJwL2JCR2FBT0xtY21iWjFJRkxPOVlqbVZD?=
 =?utf-8?B?TlgxMk5JRTZkL2xhcTV1MzdrQ25EWXF4MjgyL01RRWZ5UmlEWUg0WldFb0p3?=
 =?utf-8?B?SkdBL3Q4S1BVTVpWdDVkRUVaVDZmTHErYU81dWkzU2NubThDVjUxSjArd3Mx?=
 =?utf-8?B?QWZ1RUZMUWVuZExMdGhiMHRyNDF1eFd5NU9RdkFIUXRwWkJMYVA4aVFNQVBN?=
 =?utf-8?B?Q1RHeFpId1dndnZPZkhWZUtwck5SUUNlemV1OVgrT1pYcUp4WTdPOVBSaVFJ?=
 =?utf-8?B?Um02amdqRTVGK2N0SlgyZlhhLzU1QUhiN29NZmx6Mk8xS0l4ZE95OGl6NjFU?=
 =?utf-8?B?OVZMZStReDMzSGdhYW1xTGJnTFBCalJUSjUzbG8wSGNtbUVURnJUZHlDWTlt?=
 =?utf-8?B?eXFWaXM0ZUJlaWRuQ3BER2JQQm8yNjN4dnNSSExnRjJlbXNuOUZSdHRab085?=
 =?utf-8?B?M2RSU1hVUWtHbERJOUVXNlB2aTYxMVpwSVE2T1NZNjF3QlRYQ3dpUm8renhF?=
 =?utf-8?B?Zmp6SmhkWnV4UTFLdFZWYklHdVBGNGw2WXVRYjdaQVBVREVWSENPQ3YrWmRH?=
 =?utf-8?B?ai82aFJKVE5zYmJLTFl6SDk4azhyRG4vUTlhZ3dwTlUyOUM0ODA4ZFlXR2F3?=
 =?utf-8?B?cW1iOWc1OE1BU1pCM0VJUTQzdjlUdHZaL2VROE9CaDNBbnM1ZUtVZndjcEMy?=
 =?utf-8?B?MExOQVYvNVlIT2ZGbk85MklHSmlHVjlLTEVKOTVVZklXcjR0OHFuNjlFR1pJ?=
 =?utf-8?B?UDFkaTcyMmNvSEg2WVBlcG1neEJyQlludU1ZbkNRYjVlSWRkK0ZmZHlSd1VH?=
 =?utf-8?B?MjBkbDR6ZEF1QlJ4R0w4KzkyczQwdHNDYVZCZjM0MWNiRXdudGpUSnFvMU9x?=
 =?utf-8?B?eDZIVnQyd2RlbTg3Z05neGkzbm9keHJqKzdWSDRaajRMd3l4SFYvaGlVemVR?=
 =?utf-8?B?SUFPS1EvV2lrWU1ndEM3bnF2cUk2YVg2dFNtVm1tOVVtVXBxaEZoR3lOTENx?=
 =?utf-8?B?cmZXbzNkWGdqMDJNSFZYWm9IN3VSRGlrZHhzL2lqdFFEckZmeTN0S3lIMGRo?=
 =?utf-8?B?c3BZUUtTeENRWVZEVFpkWGNzRkJwWFZBTzd2cXZ2WWNBVGhuUVhKWmNoVHBV?=
 =?utf-8?B?MWswc0JyVEwrb3hOTTJZbGdOODVmbE5iVHVPRDJWYnYwUU5VVDJzRkdseWg5?=
 =?utf-8?B?a2ZRQ1NaYVdCVjJ0ZE04WUMxZVNmUlV5QlRYL2tQUmM3eFR3S3pwUnVCeCt0?=
 =?utf-8?B?RnZiWjZQODhHZUcwZ2dCS2lWVkRKN2oxa2srRkp4UHAzbVg4Z3pUTkhmbE02?=
 =?utf-8?B?Z1lkWms0QVkrdnNzVEdVSXdab2wrb3BnV1FqMnFsVVUxc1hvS3BWWmhJcmJs?=
 =?utf-8?B?YWtaaFNTVTlZMnlRK0RlK1p1KzZWL0JtMEtvSHJtTWlwUjNoN1BKN05qZnh4?=
 =?utf-8?B?UithQVJYSU9nZmMwRFpHMUM5L00wT0JoWWNMcWlybHJWdGlyVTBBRHpyMVQ1?=
 =?utf-8?B?M3NKcDdOaElibEw2eGNTdUliNksxSi9DYlNkYkhEeTUzM0I5cjZWRGFUeDVI?=
 =?utf-8?B?RVg2dnRKelpVTDRkcWNnUmRZSDFJODNRaVZqTk4xMitPb1hqWTlqVWtieDE1?=
 =?utf-8?B?QUttMUZFdkNWNytWQnN2b0J5dVQ0OXhYdWh5U2VldTBvNUMxUjl1R0NFSXdH?=
 =?utf-8?B?dkxsZ081NlJiRkdnR2kzbWZFamhJNDgxTU9EaVBKOWYwMlVKV2lVQUE1ajl2?=
 =?utf-8?B?VWZ3UlNNU21qL0FMRU9MRFFHVllFSEt5SE9acEhEY3lXZjZKOVhrMk8vSUht?=
 =?utf-8?B?VVU2OUQra214V0dIZmdMRlIxbGt0KzVkSUdqNTFyTmVUZHQ0N1lnTm9xNURo?=
 =?utf-8?B?bmJXc2haOXlWVWNWdlhlOG56VWVCOG5WUUpySmpFakxMeit5bjQ2YXVkWklG?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa9bf93-c9a6-4abc-0839-08de31b3a4db
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:01:16.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWLrUmA1K33VEeB3WEDu1rHW9h1IEccGKvujWTbv14EZdhZWiVlBafPaLjTPOsaoZ09MKSoe8OYu5kWgijvY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR06MB8517



On 02/12/2025 16:11, Andy Shevchenko wrote:
> On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:
>> Support configuring output calibration value. Among the devices
>> currently supported by this driver, this setting is specific to
>> ad9434. The offset can be used to calibrate the output against
>> a known input. The register is called offset, but the procedure
>> is best mapped internally with calibbias operation.
> 
> ...
> 
>>  static const struct iio_chan_spec ad9434_channels[] = {
>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>> +	{
>> +		.type = IIO_VOLTAGE,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_shared_by_type =
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> 
> Wrong indentation.

Can you please provide example of your preferred indentation for this
particular case? This is used in several places around the code and
seemed like one of the more readable.

> 
>> +		.info_mask_shared_by_type_available =
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> 
> Ditto.
> 
>> +		.scan_index = 0,
>> +		.scan_type = {
>> +			.sign = 's',
>> +			.realbits = 12,
>> +			.storagebits = 16,
>> +		},
>> +	},
>>  };
> 
> I'm not sure about macro-less approach here, I think that we want more
> consistency and hence before doing this change probably we want to clean up
> the existing macro, then split it to two, and add another one here based on
> the low-level, which was split in the previous clean up.

As mentioned, this is only needed for a single channel, and since it is
different than the other, it needs to be separated. Do You think we
actually need another macro for this?

> 
> ...
> 
>> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
>> +				AN877_ADC_TRANSFER_SYNC);
> 
> I would make it one line, despite on being 85 characters long.
> But it's up to you and maintainers.
I would like to not fight against checkpatch here.

> 


