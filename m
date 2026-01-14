Return-Path: <linux-iio+bounces-27683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 000A6D1CDAC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA17F3010062
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883E3624CB;
	Wed, 14 Jan 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="EenCIFeo"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020092.outbound.protection.outlook.com [52.101.69.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD236212B;
	Wed, 14 Jan 2026 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375911; cv=fail; b=Tlr02mZU4PB00p/EHTQUYpOTwDBpa7BlH+NLCUu+Rp9dCbNdycVq5HTMdXyU9H+nJQWS3ICmMN6Lg1bQ14l45WmsRlzX1xjAcVEDFX/U4jVuiwU1IbIyLNE5MQsvDx1oAOW7O7HIU5p2qZ50MD9xmOGQIf5J0EtX1d0k7UNlmVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375911; c=relaxed/simple;
	bh=UoGPR5o828XmRLIDrrfeeBjNC/up3RuvcgrIoyJDglY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxpMzC4aEdz2Oj0nrkMtS1U/xqo6WC7k/28NmhbO2rJXmayixAGuGQqSz++SFwYCWeUQgE2vLbq1pHFbsgLkjqUk3fqq/VW/ZQAjo+xEKtCPNTFaMlvUlGRn8RvKBQ6RHe69jF2cNb+C2z+vY1d9IJC0k/9+tmTpni3acdJVEZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=EenCIFeo; arc=fail smtp.client-ip=52.101.69.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik8bBzbtE+BJBXVmsKmcOlXrKX0V8AQwMo0WWMVAAqQIJKWWzySkALad6V4mDVQGcQPsSPU2fyLFSOEtQKvs+7SRWnhqfnJr4qsR4Egx7NKVgYA2OoPedcuF/QzQDvopYJ8lreCxQCHQkAJ9acUrGqDU5773wyB/BykMsvoDoqljuVerLbRATYLir7G8j0lEv+bxJhNhBpjBmOQXCK2luI08YxjepPCDiP7GmeV86jhLVKdopGGPygkMcrgB1UFxcAYV6Fw4MMrUVoFldz6MKrp0NLOemudbX4uuhAPIcOAHVq+DaJGG10l3C17bUCsdgHTVMbX8a01pRmKJG55drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueBmGOfCk19kzJJ+eJ3AjoDZlR5qDZPwBDTRciP54cQ=;
 b=i0dXrwBzmBTj/2+NZ6r2cYhYU8ycQv0GgdniYHu+CdHJvArcoM6jyXPlFZNB+L4ZhP7ez2aTQU10vDLD73RZ5p2xe9m+Omz8DWhzRtXIUn5klaaQNYKaZkqDdC8YEsep5iZEYXiCVEYYJS596Bpx6DZiqLM9RXwoSJUh8pXE9yIBQoB+G3eziAURVHhjbxdZxyAViNBf71qmp7LOH6sbvt0pBW2RsWGNhHiY4mxOGRffiKWSVWdo8NkRUIuK7xyX+3CTq90/7zatYw9E1jPSyIioX+bc1GEQEqUXKPpNlyw4H1q3KkpQDZlruUCmTqcvFBldvikEQLZ71Ge7nsc60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueBmGOfCk19kzJJ+eJ3AjoDZlR5qDZPwBDTRciP54cQ=;
 b=EenCIFeoJ8xGSiubIgUUT796Rp70EimC3gNCby0/n5IJAP4wMTuaxw77UveRWZOw2iOv+MNGMCa8h5j21z1LpTr97+x/zvgT6CY+bYwRcmSRZNeKKBWHF8O52XC/EbOognzEFfYyix8mHtlPJTRRB92MreGRB5LORQhSeQl/7N2Cxvhk6aPEC6gjbdo106zBenZuk/0fGmrw8pj3ZHnT0UuFqonjSun8znui3T3mXJL0J7/W8aGWOL0/rqFu80MmWr2mU3y+6ZU9EKENWsNY/xVxGRov83+M8ApEL0WuChGYHejlHcLz4AZ4qhQeh1PJeBmlH46Q8YXV08FRyrXlow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PA2PR06MB9754.eurprd06.prod.outlook.com (2603:10a6:102:417::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 07:31:33 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 07:31:33 +0000
Message-ID: <b1982479-7563-4c12-8b9e-95182e1243c6@vaisala.com>
Date: Wed, 14 Jan 2026 09:29:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: industrialio-backend: support backend
 capabilities
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
 <a9c067c6-287d-4bd7-91d3-fabd6d5b67a4@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <a9c067c6-287d-4bd7-91d3-fabd6d5b67a4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::27) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PA2PR06MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0e8314-9e30-4f7e-8e40-08de533ef106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU1XclYwcUFuMjFHQTZTZXl3SlVnMW5PVkZIWWhVR1JkOUN0WXJpSmR5ajE4?=
 =?utf-8?B?SG1CWVVCeWpGZmdXeTRBMHF2Smd3ZXZsblZ3U3hmYlYxOVBNTER2MGtBdkVX?=
 =?utf-8?B?NTFldWloOGd1VXQyRmlzdmIyK3ljTGFWYzluZlBTLzNaTzVMcXg2ZDFKL1pv?=
 =?utf-8?B?RjhQbkFxOUN4YzFEMDErV0V1cHpqcmhubm1zREpJWXliUjlrUTBKTWlCM0Fj?=
 =?utf-8?B?TWVmMWI3K1g2STFwUDdzYlBQVHIvalBVVWdETkd0MGthVTczQk5XN09zbGJH?=
 =?utf-8?B?dHBIVDJjN010WHZmS1pYeFl1aUJoVThDVmpmMXU3VVVEN3NBT0JtcGNmTnJP?=
 =?utf-8?B?bm8xL1RUVk1OanoxWEgvUk94SjNmbEduNnlnMkJmazcybUlzcTNXUnJmY2ly?=
 =?utf-8?B?SVhBekdvZGRMb1E3MkJYZ2VpcFR0dWZ2M2dnY09NMXlCdFNSYU4vMExrL2dJ?=
 =?utf-8?B?QzZGdkZEb0o5Y1kvbTBzOVNkdU5IeXFDWk1tT0VwcE1KOUlmemw3bXZQb2tX?=
 =?utf-8?B?K1IzQmQ4bUlKSlJ1ZkRtK2I1N0lFdFlESEp2QjFmNjBmc0FZeTkyUDFKSito?=
 =?utf-8?B?aElvWXNMMUdCNDBVMnVUelNlQkJsb09UYjBqVi9lRWhVS0lVV2lOZU05TWtv?=
 =?utf-8?B?dzU1ZjZBcm9JdXJnc1lxZW5ZT29DOG03MkQ2TWpPZzJnREk5dGlFVVJFL2tw?=
 =?utf-8?B?WFhaOHUzelBidUtVZTdDQ3drK25uZURtRk5MaWptbVNNTGNVMjVEZGQ1OWNZ?=
 =?utf-8?B?ZktueXF0eVBKeEhDRjl5WTBwakRjYnI3TEphZWZObVpQa3BxMHhaV3htaWVs?=
 =?utf-8?B?V1JWU0F4R0NTUWE3ek4zaWRzY1hRbllOK2NOV1ZCL0k5citQY1FTZW9vazQv?=
 =?utf-8?B?ODFNOGRrZU1BVUZSQ29saVg3UEIxS0I1dFpqTVJBVmxJTFd1ZWtRQ1E3Ykpv?=
 =?utf-8?B?enFrWGs4Zi9JV2xLdzdFckhKVWQwbC80aitYTHJOb2FlSGdDSDZqN1M3Q0tT?=
 =?utf-8?B?Njk3MDBnNjd3KzIzQngvRjdESnlldzI3Q3k0eEJDSWtPb3Q0SXo0bmhzUk5I?=
 =?utf-8?B?TGdiS2llTi9rb3BWTEJnWDIwWXNOempYc0szYlFkM1ZiNkY3NCs0eXpCN1Mz?=
 =?utf-8?B?ZTZUeWdBS0ZpT1RTcW5lQ1VYYzg3eDFXMk5FNTQ0RXNmNVlOak5EdW9XWlcr?=
 =?utf-8?B?SnlodlRSSE1tU1Rib0dUcTk4WFhzMDAxTjA2TEtON2xnYXNwL1NDRnkvd3ZL?=
 =?utf-8?B?YnNkSmd1WnhRSjN6YmR2Tk5pSHRGK0doblBBenZTUDAwMkpURW9CUElWeUdJ?=
 =?utf-8?B?NjFqalo2S2xlbXlBU2VFeTAxcEhZVndWcVh5L0tjUVBPSmQxRG50V244SmRn?=
 =?utf-8?B?UGZJTFlwc1JmdkhIQVNuM00wSTdCazAyYUtHd28rRDNuVFg2WnU4UlhqMTNi?=
 =?utf-8?B?V2ZRQkVyWjVGUG4rcVRCSTFCTXNOOTJpRGZVWDU2NjVlajhkdDlBYTZFejFE?=
 =?utf-8?B?cEZGQjg0QkJGNzQ1YUczYU5nQU9reXBuNnNLcjF6THlTMEx5cVdJU3JZOFEw?=
 =?utf-8?B?clpCblYxM0RwUFdlRUhKd3lwWC9PU1FreVFOTnViVkVwSVVGSjI1cWlENEJt?=
 =?utf-8?B?VUYxY2c2RTBQRThGR0xZOUtqeHM3Y282RnRzWGVUUmpqbEhOemd1L3JnNHp6?=
 =?utf-8?B?VG9TRlVSSEJFL3V3U0dBV3RuUmdVRm1DR1pKSjBPTmNpbEh1V1VQNXNMWjdv?=
 =?utf-8?B?UzFjcUJvSTdlLzdhTnpMTGpVZDBnT1VOWEFaVEZWUlZNOTlDS0ZnRjVmNkVL?=
 =?utf-8?B?T2NRaklWd1dwWlNTWGlNZzhIcXQ5TUtTVUg1Y3FCK2dUT3pyZXZ0M2JKTjcw?=
 =?utf-8?B?TmhtVWNEUEEvampkYUcvV0kzTUxkSk5Rc2RDcis4V1I5Wk80Q0czZWFNY1h5?=
 =?utf-8?Q?lsnmI9Pz9BB0RO3zqr6dUCuBKJiL4dUa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hLYUMyZUhra1BtRmphc3hWc1Zja1RxbEZoZlZXZTdaTTFlZkdudWlNUWZZ?=
 =?utf-8?B?Zm40OXJ6VUkxNkZRZzBLNWhqZzBtWElhMkhsZ0ZFbmt3UXZZYjB5bTlFcWZ4?=
 =?utf-8?B?WEx2a3M1V1ZRVnlQbmlkRlBNWjhxZUZ4UFUyVEJxVHdMNHAwb3Q0NXgxQ0x5?=
 =?utf-8?B?UTFUZVRHdlQ3dWE4VEk1Qlh3VWxXZVp5bzdHckhVUGpndUFDV1U1TEtyNkNH?=
 =?utf-8?B?ZmJIMXFadU5ZblVocDdQeWI0dWE0VWtVTlFCMTJEVVM0K2xTTVRkNk9CZnAw?=
 =?utf-8?B?a3Y0SU5iUWxMQk9GNkhkQ1dmUVQ5MmNJMXhwVjVRYlZNSVNLZ1NYZDlncW5p?=
 =?utf-8?B?T3hzTnhyRW9KeEhhcFVzMjd0YkM3U1VTU2luMzZ0SmdCSWgvd1lJZTdMNG1p?=
 =?utf-8?B?R3Bka3NLTzFmTlZITFlYYlY5bkY5TklnUHBOVW5kU1FMQzVBckU5akxhWmRw?=
 =?utf-8?B?bXhiVGU0cEk3WWNKYllkalZyL3FMYnRuc3pCTU9sd2lmMmpVUUpyN2F1RjRo?=
 =?utf-8?B?dTNFOUc1cUFsbERyR1lRb2lmcWs4T3lrVWxVR3RqQ2VDeFVCZzZVZzdDMGJV?=
 =?utf-8?B?alJQK3N1c3FqeU44UXNadGZTQXlBSjJSZmIvNWxnVTNlK096RXNhYWlFc1kz?=
 =?utf-8?B?a203T0xubUcvWS9wSWFIZ1ljL1kwd3dGam4wQVRiam1IbnpSWU5HTG8xbWZy?=
 =?utf-8?B?VkwwWDAvcWJ0Nk01YWp6eGRCL1pQdTE2SklGejdSeXJIcGFLOWtaUU54Vjk2?=
 =?utf-8?B?bGNGU2MyVGtXY0hkeW13TVdjUW1VT0x6OUtBRzFWNW4wdGM2MjcveXlyRHY5?=
 =?utf-8?B?K0JKRWRZN1lNWHZ5N1ZSNElxQys1ZUV5aEs1QTdSOFBDeVozUmJYcStIQ0M2?=
 =?utf-8?B?L1ArNjhUYmVZMEcvRUpHTGE1TTFHTER1dHlnQjh2d1VDRGhyanNOeWN6TWVQ?=
 =?utf-8?B?ejZOWGtSNzQzcjJZNmdrRHRvQU5HaTloTjhKREMyQ1hYSXFrNWpwMEtrTkZq?=
 =?utf-8?B?b1MwWFU0bnNYd2VBUTdERGp5b3YvUGpaZTk0VldFV2ZtUkd6QThzN3YvMGJN?=
 =?utf-8?B?Zmx0M2kxMTdKdG1qOTVYV3RqZWNWVFJPNHIvK01RWlNnZUh4VU9ZWncwNmVL?=
 =?utf-8?B?RWZPWG53RUNSdW41Zm52VG1mMXVCb0ZDU2lhb2dqcS96UWZ6dGRxUjg1U2tr?=
 =?utf-8?B?SGFKZ3U5UTJpRGZlUFRyeUJ1MEpWbnI5VXlBQnAxUnlHb2xFdEJuK0dvT1pF?=
 =?utf-8?B?ZTF3amNEK05NWEhzaDRjZ012NVp3M2gxdytFN2lqOWU1QnZwM1ZnTUNvOENB?=
 =?utf-8?B?OGtEQmpwV3h3OFZucURYNXhLa1NzaE8wWTJFVjFsZkgwQzZQbWJIV1ZZVVZh?=
 =?utf-8?B?TVVuSzBYZENsdDV6Q3htN3BPSjF6OEkzQ0VHaHBkdjYzMHJmZmRtVXRRWHpN?=
 =?utf-8?B?WXJqRzd2cWFNMnU0WTNSU00vb0JCbTI1bWF4L3Z5aEVOY0pTNkFtQzFCMUhB?=
 =?utf-8?B?QTdDM0phUkE1ZkVSQXQra3RXbTJ3dWNKQ1JYWEJXRU9iS1dBODYraDVqNVZq?=
 =?utf-8?B?QkMwa0lIL2pQZG5Mb1RId1ZnaVREdGY3Vng4dGw0ek94R214TWtJVmZnTFhS?=
 =?utf-8?B?dE1xM2R1MjhtTGRBVk16ZDgyTGRheGRIdkc2U2hoSTVGbmIyM0hHc2tlU01v?=
 =?utf-8?B?TzVvQk5yTVA2Y2xlZWY0TVJPY3NkbktheXhDZFZzdlRCYnMrWmVkZWVkVm1w?=
 =?utf-8?B?R21tSXZBTjlkOXpmblNHS0k4dVI5RlJtSnlOcHU2cjF2MS8wR3NtMWZVVTVn?=
 =?utf-8?B?bklPRkxxaWZicE9IREc1dEFublppdUJTS2FrV2FjUlF6UG5pVnhoODh5R3NI?=
 =?utf-8?B?NlFKUTVJL0xjY3JPV3BMVTdCbzYya0JqWG9XWlFMTmluODh6dWZLK0d6cmtr?=
 =?utf-8?B?MU0ySHQ1Y3Q1ZnRwcDRqQk1qK0JKbjJXKzZZc3FoSlRZOUwvV3FKWVIyZ2x0?=
 =?utf-8?B?Mk9hbml4T2U4bUF6VUZSMExXZXBBSmt6RFpPeml0R0pXS1FWMjhsWndwR1Ax?=
 =?utf-8?B?N3dLK3JpWGJVS0F6QkE5bnFzNFlsdjVYRVA2Tjl5K3FZMWdpSHI4TkVUdDFB?=
 =?utf-8?B?WFNGZ2Jhc1VxWExXU3lKMTVrQjRBdktxWFQrSk5RYUdBSHR5OFFmMnhpUEE2?=
 =?utf-8?B?VUNpQ0l4THlVQ1didXUzc0tMZlNOcFplUndtSmRWQmduck53SjhKdk55OElD?=
 =?utf-8?B?QmRVVEFaZGdmSUJmVEFPMXBHamFpcSs3cFl1YUJLT3R2SW0yUFJHWnNBN085?=
 =?utf-8?B?QUhhak03YS9LNXhXaDJWVGs5Wk91UUJtNkp3THY1a2RUT0RBOCtUU1JoU2gx?=
 =?utf-8?Q?BwXcTqu63yTZVj+o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0e8314-9e30-4f7e-8e40-08de533ef106
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:31:33.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5FkC18RQvvBKhx0Grlkx1DM4Q7arPB6dJn1mHLNsgvuos1PvxK5oCI2jE4t27gvy7aSlCP6Cw30bkcUTxpeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9754

Hi,

On 13/01/2026 17:18, David Lechner wrote:
> On 1/13/26 6:12 AM, Tomas Melin wrote:
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
>>  drivers/iio/industrialio-backend.c | 10 ++++++++++
>>  include/linux/iio/backend.h        |  9 +++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
>> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..997ec743dc67e7cf420ff667af33b4f6a71a5377 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -62,6 +62,7 @@ struct iio_backend {
>>  	 * backend. Used for the debugfs directory name.
>>  	 */
>>  	u8 idx;
>> +	u32 caps;
>>  };
>>  
>>  /*
>> @@ -542,6 +543,9 @@ int devm_iio_backend_request_buffer(struct device *dev,
>>  	struct iio_backend_buffer_pair *pair;
>>  	struct iio_buffer *buffer;
>>  
>> +	if (!iio_backend_caps(back, IIO_BACKEND_CAP_BUFFERING))
>> +		return 0;
> 
> I would be inclined to return an error here and leave it up to the
> caller to decide it if is OK to ignore the error or not. Otherwise,
> the return value of 0 has two possible meanings and the caller would
> have to separately check the flags to see which one it is.

Good point. Thinking now perhaps this check should go into the frontend
side and the decision be made there whether to call this or not.

> 
> We also need to add this flag to existing backends in the same patch,
> otherwise it is going to break existing callers. (Or we could split
> it into multiple patches - 1) add new enum and fields, 2) set flags
> on existing backends - 3) introduce new checks).
If the check is moved to frontend side, this might change slightly. But
I agree, this needs to be kept in mind.

> 
>> +
>>  	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
>>  	if (!pair)
>>  		return -ENOMEM;
>> @@ -774,6 +778,12 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
>>  
>> +int iio_backend_caps(struct iio_backend *back, u32 cap)
> 
> This would be more understandable to me as:
> 
> bool iio_backend_has_capabilities(struct iio_backend *back, u32 flags)
> 
> (caps is fine too if we want to keep it short)
Ok, sounds good to me.

> 
> Also could use kerneldoc comments.
> 
>> +{
>> +	return back->caps & cap;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_caps, "IIO_BACKEND");
>> +
>>  static void iio_backend_release(void *arg)
>>  {
>>  	struct iio_backend *back = arg;
>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..c020bc48cc05d6fcea00d23e471b12a29b5c0551 100644
>> --- a/include/linux/iio/backend.h
>> +++ b/include/linux/iio/backend.h
>> @@ -84,6 +84,12 @@ enum iio_backend_filter_type {
>>  	IIO_BACKEND_FILTER_TYPE_MAX
>>  };
>>  
>> +enum iio_backend_capabilities {
>> +	IIO_BACKEND_CAP_TEST_PATTERNS = BIT(0),
>> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
>> +	IIO_BACKEND_CAP_CALIBRATION = BIT(2)
>> +};
> 
> These could use kernel doc comments the specifically call out the
> functions that these correspond to. And also an explanation on why
> we don't have them for everything (I assume we are just adding them
> on an as-needed basis).
Sure, will add doc and comment about the usage.

Thanks for the review,
Tomas


> 
>> +
>>  /**
>>   * struct iio_backend_ops - operations structure for an iio_backend
>>   * @enable: Enable backend.
>> @@ -179,10 +185,12 @@ struct iio_backend_ops {
>>   * struct iio_backend_info - info structure for an iio_backend
>>   * @name: Backend name.
>>   * @ops: Backend operations.
>> + * @caps: Backend capabilities.
>>   */
>>  struct iio_backend_info {
>>  	const char *name;
>>  	const struct iio_backend_ops *ops;
>> +	u32 caps;
>>  };
>>  
>>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
>> @@ -235,6 +243,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>>  			 long mask);
>>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  				 struct iio_chan_spec *chan);
>> +int iio_backend_caps(struct iio_backend *back, u32 cap);
>>  void *iio_backend_get_priv(const struct iio_backend *conv);
>>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
>>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
>>
> 


