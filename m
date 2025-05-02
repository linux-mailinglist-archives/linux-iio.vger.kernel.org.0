Return-Path: <linux-iio+bounces-18974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2BBAA6E01
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B911BC6376
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81D22D4C3;
	Fri,  2 May 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PTbcRy0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7E21C190;
	Fri,  2 May 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177863; cv=fail; b=GGgpfhVpPDo689KcCDcux3ko7GIcr9CaYs1RnpIIYPYzMBgMToN5llz9WI4zuME6OYOmplVhNUZvp6auS+ekUuzG8uGIL7hPqLKfzK3eH9x9I9X9L/Wfw498ixAnPVrSqhtb1KAH7Wl5tUql9Gp4wi8BfL/0smi+/ZlSBbLbKhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177863; c=relaxed/simple;
	bh=kg0BtUn+eqhQrmOYToUZaULw003PW10hnxGsu0e7H8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCYIy4RhL0T3eS7tIGePfEseZPIthlR3SoCGeSM7p6oCZo3ZdfGUM0dBX2o5f2OKBPVv9SkBJRz0KIJzHjVseNAhdcKam2KHjegr56r5h4Hez7DhT8bRrLDEyeMMZFUmweaObYP4Ej/VGvOM5QprQce3ysED72OUfL/oyaK/hTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PTbcRy0F; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+sP0AJi4UwrpjjORHM9zlqb26gRfjJZbc44gWqzW15mDQwL04TX3PjQkSIWAYF/7q3FKoCYa6KryaZ3cqaluTLWO9NFkGCPc4A3HZ+2ODnyEAbLEkFiTH0boPZ3gGVAdVsZ77G283uN6TXagwZjD7E5cjtDIifQuSkVQU1AGzr8AuyGFoWRq1VZzml6INvKuzQjKCRvvD0JyH3IMudMvMnxmeX+mx46ZWko1fDJfemCqInao4pTKHAg52Gpz03ydFGEcTg1jgqXDGzLISjY1tpfqw+dzSRcV8ICGWPefsbMZdaFqT+76XTXIixS2EVWkiNNMCAAhXx/57lmdlTx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg0BtUn+eqhQrmOYToUZaULw003PW10hnxGsu0e7H8U=;
 b=vPTsgthSKw9SRchQMaWwwwAsK+CvtolHnhKBqIdxOSJ5nGE1MyPQYMVT83VBLO66xqN6l9Sw5X+y3LUpvra4do7zBzYZrO6SWtQ52Gcc2Z7jzzhVyzeb5CAEltKDhhul62Fuahhu13a988QSXw5lBzmrOna5jHSkFXGfpZsoTRA/fAIGsXepCoJtaRXqMwxAm1zTkLFm3OYrW8eHLfnalwceHMpeqOW74fXDDAP4SgxZsA3dkQjXKTmokaYBxBVFmWw/nJysQXK8rriA5VCLpO3akUIY63yGbN/DWW3b/d3pDYdoQ1jnsDro5IxPW3y7TlnsIEvX8d2wIgTvNnIAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg0BtUn+eqhQrmOYToUZaULw003PW10hnxGsu0e7H8U=;
 b=PTbcRy0F+frrgcAWEBj77iZ9cnq1It0TfHEGCHKhbvNQn+bemSKinh48q4vt1AXB6EoBXc/mJDhSi3UdE1u6N/+Ahy1wRQLAZiJrupqd9tRZ4LsADRJvxxMY/qATLi5jKVMoCOzxdYw12rNigGzGTz16losUAbIPvRWeOInbGZOMmGke2gbmHbzxMGtVJejeFJ2bNfamIFkj6DjAPUkZ0wv8cWD5s/49xGcw0Lul0Hf5Tse3N7yd6d4aCM2tXydFHwelA1JeycJU0nMBdyqiWdbuPtupHoM3MzOFWXeJC6IS7pD2lQAj4ABwzvQ0UQZ/MNwZh47g21EYHKG2FiTqDw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 09:24:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 09:24:18 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Convert atomic_t -> atomic_long_t
Thread-Topic: [PATCH] counter: interrupt-cnt: Convert atomic_t ->
 atomic_long_t
Thread-Index: AQHbolDYQ16oLDKQdUqDAUL9NlRZbrO/Q1KA
Date: Fri, 2 May 2025 09:24:18 +0000
Message-ID: <91c00e75bc25267d57863494d638f0a43e499ac4.camel@siemens.com>
References: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7147:EE_
x-ms-office365-filtering-correlation-id: 96188314-a442-498d-9582-08dd895b1d32
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czRYTkFscFZFa3dTOFBpME5WUDIvY0s2YjlNdXZlWGlyaE54aEQ3RXJMa0tT?=
 =?utf-8?B?amZzQzJPcWpqWGY0OS81cktsZ2J1UVVIYm9aL3gvVkg5bks1VGcvM3RPUkha?=
 =?utf-8?B?YW5UZWx5NEd5VmExM0JKbHVpZzM5bnJIL3BiSmFpcVVzTUxKbkU1R1lWWk94?=
 =?utf-8?B?QjhkSHdtNVF1NmdoT0pTZVBPTTBRSlpTRHQ4a3hyemo1bXJXbnluQURCMmFn?=
 =?utf-8?B?Q2FwaEFkblFuNFpodytKVGNUYUgxNUJ0c2FaUmI3TmhzVnM4TGhCVU1SSG9K?=
 =?utf-8?B?bEFOaXBhc0JGV3NmaFJzaUF5RDY1bk4vOWZDZHVhZW9RY1N0YStnVzN5MHBZ?=
 =?utf-8?B?ZVFpMUNHSzlxL2ZYSHFNQ1N4YTJSNXNXWFhpc3ZvVlNGeERjMm5LcDA0N2Z5?=
 =?utf-8?B?Z21zdGtVYmFZN3RENlhiaXgvRGN0S0c3aktKY0hoaWkxcHlGS0NMRURlOThJ?=
 =?utf-8?B?Y3grN21OSHgvZCtUdkZDa2lPcUgzM01zSm8vMmJGT0RaYXNyZzJicEkrNTZX?=
 =?utf-8?B?c3hDVHhrSkgvVE1lRTcrL1FZZmtMWmpqL2c5cDgvT1RhZTY3RWhralBoRnZy?=
 =?utf-8?B?cUNrRUcyNWxXSmlpaXlSaWhqSDRndUF2UzdOWHdCQ0ZjeFhtQzd5QUM1OW5S?=
 =?utf-8?B?Z1VCS2p3TmQzd21ETkRjNitlRDh6b3cvSHNOaW5CZ3VxL3E4a05iL0hOeGlL?=
 =?utf-8?B?aE04WTBFb3RuQnNpbXNGaFZ1ekduL29pUzhGSlNoQVkwcXNXaFd2SUhPSGZi?=
 =?utf-8?B?eHJGeUNqZWhzM0dXb0loSkhwZzhqc3ltNFZMbDY1dHM3T2hzUDlsL2NhbFlR?=
 =?utf-8?B?b21PMDE3T1BXdU9pa0dSVWZoRFJsLzBlWUNmS3ZrNTFybkxuc2lFaitvQllN?=
 =?utf-8?B?Uk4xTG96R1YrY1IrRTBWNUhCL1YvUFk0OFlkRzdCU1RwSS8rZ25kUUxGM3Rs?=
 =?utf-8?B?TEluS3V3UEVQWVE1ZFo5aWtSRkJYSEVqOTg3THpaMVhVZ1VDVnRvZzIrNit4?=
 =?utf-8?B?YnhReE45RUJrT3dwbitGOWpHNDYxYjNxamxheGFNS1pJV3pQMUFVbEthd0Nt?=
 =?utf-8?B?cWsycStDU1ZCY3FMdGduWU9oUHlKUVZ5QTdiQ3IwRDRxbVcyVklDNnp2UkZ2?=
 =?utf-8?B?QWZjelh3OFhlYzM2UlhNOGZnSVZQNmNkVVliRFNjMllUZVVHelY3NjhUSC9L?=
 =?utf-8?B?R1B6ZU5xTEhVQ1AvMzBoQkhHMTgzd3U4ZHpsUFVnL2U3M3Nkb3ROVzYxQUVK?=
 =?utf-8?B?Um90bU1oY0g4ODBWckJXMnBJbHdqTnd0MURJYVhnVThxdm0zeCt1TGdBWHd2?=
 =?utf-8?B?MVRyMGIxVjFzZmpwMmJKRkhiWnAxTHdZbjlUdE8vUmx3NTlTQVZlUUJLbmIz?=
 =?utf-8?B?aGZIY1NYVVBkdW9Zb21YKzh4UThyR2s1bFhnNFNIWC9UZkRpbVcxY2hQelNk?=
 =?utf-8?B?YlBKRUs3MjJma25FTUdHcFNFT0ZGaWtjeTJkRllwcXBWeEs2NWc4R1l4QnRl?=
 =?utf-8?B?MVE5MVZtSmtNTnJiNTVkeHZ1WE5oaU1ELzk0ZkFoN2c3cWFUanFUcm5VTE02?=
 =?utf-8?B?RnFKNFNpck9Ca3RYSDhCTDFpWExpWFZmcXNiUWRvczVDQzlUa0l4NWtES1Zz?=
 =?utf-8?B?cnJpdUM4WTVqNzg0Q3ZLbUhiMGliS2U2MVh3U3l4OEJIN1U3ZmVvUzYvTGNQ?=
 =?utf-8?B?UFJTS2xNRitlbzI0VlFRL0V1NTYrb05YaXNVOE1WUWN3aWlKRzFSWkRNdjU0?=
 =?utf-8?B?eTIrTlFqVE9xRW9PZFVTbjdvMlhFeWdmQzhkcVpyR1dHTE9ROHVvOThLNUdD?=
 =?utf-8?B?UGNGeG1vK3hXajdWYWttTVE3aHc0MFRUSHhaekVnZzlCRkswWTFEUy9DQW1z?=
 =?utf-8?B?MEpiV05SSXVKcU81eEMzVGtYN1EyelhMdXQ1VEJvaUY1Y1FTcmFsd1A1YXBI?=
 =?utf-8?Q?Ms4jK0h2194=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXd1MzhpNDNNNmV3dzZSY1hGbVZ6bkNOcDkxcU82RHd0UUtvTzBsZmNpSnM2?=
 =?utf-8?B?Wm0xVlNibVArTEJVSFZYRjNkc1hGa0pvczd4WTRxeDV2TDlBU0UwMVhBQnh2?=
 =?utf-8?B?K1pORzk2Y0lwMHc5RkFERDkwSUdON1hnakZTSTRBUHQwR2JoV2E5RlVLSVo2?=
 =?utf-8?B?aWV1dWtjU0s5SXdUOERkdkk3V1VpR1RNWGNWS0ZRRFhlakEyNmk0dHZMYTRu?=
 =?utf-8?B?bmNadEgyZEttZEhiaXlsOTRtRWM1Ni9zQi9ZTUwxdk8xQXJ4dDlnbXc1dWwr?=
 =?utf-8?B?cVBqcDZCMTNheFpmMWhiR2VBNlBVYW0yZHRUU3JqWnFKZlc0MWRDREJCajJL?=
 =?utf-8?B?dEd2eHpnZDkrTnErdzIxV0I4WkFUb2lCZzNXMVhiSUNwZ0NiV0FKck1BN09i?=
 =?utf-8?B?Y2F5SVBYcDhGd2doWGZhQnJzR3lXMVBZU0FWdWF6Rmt0TjJyaXRUVHNaV1Q4?=
 =?utf-8?B?Q3VPV3c1VUpUWDR4c0dMMEdianNQM2Nialh5MGI5eFlubzNydzE2akc5YjJx?=
 =?utf-8?B?Sm1DVm1sK2phUC94cUxkZWZpMFhxamdkcjBkWDEyNWtWYlJmWTJZcG9qakdD?=
 =?utf-8?B?S010bWlQRTVLNllRaW5pREdJTEFQd1F6NjE2Vkxaa0tvQ1pua2xJSXZucnJZ?=
 =?utf-8?B?b3pwOE5vb2NNaTRiUGpLdEFXdmZUVnJjYW9hcmhKbnZHNmw5amdlWVFQTjlH?=
 =?utf-8?B?RUV4ejRQZWlBNTl2RHhOOTE5MFhHb0xwY3QyWWVoSU1KbzVGcmQ2dk8xU3l0?=
 =?utf-8?B?RVN5ZXpCT0JmTWtEL1RRL0pkNTNocGJwdE16Y20xc1dyY08wUGRwVnhBc2hH?=
 =?utf-8?B?Wi9mOFA0VkFkdWVyeUR2bnpiUXVEUGVKV2JWRkhTbFpkem92SkdXYjFyZWgz?=
 =?utf-8?B?eVk5djlPSW5VUlRjVFVYYnZ0SXdUcmhkOWM5MjJzSnRLZm1wdjQ2RFdLV2E4?=
 =?utf-8?B?bDN3dkdsSzJQdy8vVThHcmhnYWJFL3A0YUwwUHhhQlNJZ0FIWmd4ZDQxdk5R?=
 =?utf-8?B?UHpxcjlQMk1wV0c2OVh1QUxIcGEzSG45OG9rcWlTUlpMbTlLb2VLUFZ6MWtw?=
 =?utf-8?B?OWp3d0ZUUWJrUDR0V1orSXYvdzkrZ1pCelhGbFpnbVNidWtNcmt2OWVHTk1N?=
 =?utf-8?B?ZnV1a1Bibms0V25mcldxTlo5RDF4ZXFvcHNTbXBZbklCZ1NtSkNzUjBGMXky?=
 =?utf-8?B?STZrVE5HcXhRSUtGWGFEOWhlcFJFNjlhK1BkM3RSRnZSaGNoWnhPM3drVDJ3?=
 =?utf-8?B?aVNEM0lIZ3Y3VHY1VmhqdnZWLzlXSGlTSlUyTjhibHlHem84QXAwK1d1R2pB?=
 =?utf-8?B?QVFOS0h3VUVPb2loVjdJWDM1TEtFbkk5c3FKTzV4QWxZTWNxc3ZscEpqck5o?=
 =?utf-8?B?YnNTTjFFNzVDQ2ZCcFdnTVlIcG5QVUpOTGtCcXpnempMVlRRNDJtRzhNQks1?=
 =?utf-8?B?YklteFV6WWwrTkN4NXJ5NVF3U1B6ZDNLUjhIN2twdjBSVzhLZVdQWmhEY2hp?=
 =?utf-8?B?RzRHYXFOOGRtY3h6R21SZDZndUZubmtGVnZYTDVRNklrdDNlTEZDN2RsT1VN?=
 =?utf-8?B?Sm9pTm9sL1JVWWsxLzB3REtyWWJFMTJJRFdWdG1rdWJ6c3p6RnYrSHg2K0RO?=
 =?utf-8?B?cGx0MDBrZEZ5S2JScGw5b0IyNFgyN3N4b3d5RFFBMnQxUzRrL0hYVWFUblNs?=
 =?utf-8?B?Ujg1SmV4U2ZIRFF1VXltOEsrenZhWnRoSkNjZWhXeS9NUFIxUk1tdlpJTjZn?=
 =?utf-8?B?WUJBUTVLV25raVhEL3dUZ3ZuWUMyOWhPMmRxeWVLUE9iMHNxQnFEWXhnanBC?=
 =?utf-8?B?L0xOWTBGeHh2cHlENjdtcDlYKzNRb2JzQ0xuQllXS0srbWhmVXZycXhzUVFL?=
 =?utf-8?B?T0dsVGh4TFJVSlRLSllCcmd5QzJiZlVZWmwzM2ZIa2x1NTVQSGRJQ0pYOVI3?=
 =?utf-8?B?L0ZNRGs2WDlFdlBmNytXeHF0RHBkSmdONGhKYzR3OVBlTGtXZGx2SGxhWUx3?=
 =?utf-8?B?UE5lQ3NsV2FvOURYZEx6cWZ3b3QzdE84RmhTdkRGaUlZRXQyc21PaVVjcmFJ?=
 =?utf-8?B?Nnhmd3RmVDZWeVFCOUx1cXZYUTlEdHBmRjJtQXE4WmJPWGRteTM0RFg2bnJs?=
 =?utf-8?B?Z0tlQTBhSVVqdVZNWnNJSjc1TzVkQjVudzNGS1ZyQVZuZGdpZUJTTjhja0NW?=
 =?utf-8?B?THdIRjRhZktxdmJsVHpzeEFuYklLVUV4OWgzVUFpeGtyeWw2YklTSmJ3MGoy?=
 =?utf-8?Q?fSLE6Gpk+GsPzMmgN5H8gd+sK+80PYczynxH3GRwdo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84D551418254694EBDCE2B97FC08FF88@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96188314-a442-498d-9582-08dd895b1d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 09:24:18.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EOtfJ5DsKKA/60/p/69MlIqeE7hAizYgBsGEbieHPXgs0hWHDdxpZ6wsshnuEA67sWGu8WQmVN9P4/5rLNIQXuAjjPWONvba3YDB5mkFb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7147

RGVhciBtYWludGFpbmVycywNCg0KT24gTW9uLCAyMDI1LTAzLTMxIGF0IDE3OjIyICswMjAwLCBB
LiBTdmVyZGxpbiB3cm90ZToNCj4gRnJvbTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIu
c3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IA0KPiBDb252ZXJ0IHRoZSBpbnRlcm5hbCBjb3VudGVy
IHR5cGUgdG8gYXRvbWljX2xvbmdfdCwgd2hpY2g6DQo+IC0gZG9lc24ndCBjaGFuZ2UgbXVjaCBm
b3IgZXhpc3RpbmcgaW4tdHJlZSB1c2VycyBhcyB0aGV5IGFyZSAzMi1iaXQgYW55d2F5DQo+IMKg
IChzdG0zMi9pLk1YNikNCj4gLSBkb2Vzbid0IGludHJvZHVjZSBwZXJmb3JtYWNlIHBlbmFsdHkg
b24gMzItYml0IHBsYXRmb3Jtcw0KPiAtIHByb3ZpZGVzIDY0LWJpdCByZXNvbHV0aW9uIG9uIDY0
LWJpdCBwbGF0Zm9ybXMgd2l0aCB2aXJ0dWFsbHkgbm8NCj4gwqAgcHJlZm9ybWFuY2UgcGVuYWx0
eQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3Zl
cmRsaW5Ac2llbWVucy5jb20+DQoNCkkndmUgbm90aWNlZCB0aGF0IHRoZSBwYXRjaCBoYXMgYmVl
biBtYXJrZWQgYXMgIkNoYW5nZXMgUmVxdWVzdGVkIiBpbg0KdGhlIHBhdGNod29yaywgY291bGQg
aXQgYmUgYSBtaXN0YWtlPyBCZWNhdXNlIEkgbmV2ZXIgcmVjZWl2ZWQgYW55DQpjaGFuZ2UgcmVx
dWVzdC4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL2NvdW50ZXIvaW50ZXJydXB0LWNudC5jIHwgOCAr
KysrLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb3VudGVyL2ludGVycnVwdC1jbnQuYyBi
L2RyaXZlcnMvY291bnRlci9pbnRlcnJ1cHQtY250LmMNCj4gaW5kZXggOTQ5NTk4ZDUxNTc1YS4u
OGRmNTQ1N2IwYTA3NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jb3VudGVyL2ludGVycnVwdC1j
bnQuYw0KPiArKysgYi9kcml2ZXJzL2NvdW50ZXIvaW50ZXJydXB0LWNudC5jDQo+IEBAIC0xNSw3
ICsxNSw3IEBADQo+IMKgI2RlZmluZSBJTlRFUlJVUFRfQ05UX05BTUUgImludGVycnVwdC1jbnQi
DQo+IMKgDQo+IMKgc3RydWN0IGludGVycnVwdF9jbnRfcHJpdiB7DQo+IC0JYXRvbWljX3QgY291
bnQ7DQo+ICsJYXRvbWljX2xvbmdfdCBjb3VudDsNCj4gwqAJc3RydWN0IGdwaW9fZGVzYyAqZ3Bp
bzsNCj4gwqAJaW50IGlycTsNCj4gwqAJYm9vbCBlbmFibGVkOw0KPiBAQCAtMjksNyArMjksNyBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgaW50ZXJydXB0X2NudF9pc3IoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KPiDCoAlzdHJ1Y3QgY291bnRlcl9kZXZpY2UgKmNvdW50ZXIgPSBkZXZfaWQ7DQo+IMKg
CXN0cnVjdCBpbnRlcnJ1cHRfY250X3ByaXYgKnByaXYgPSBjb3VudGVyX3ByaXYoY291bnRlcik7
DQo+IMKgDQo+IC0JYXRvbWljX2luYygmcHJpdi0+Y291bnQpOw0KPiArCWF0b21pY19sb25nX2lu
YygmcHJpdi0+Y291bnQpOw0KPiDCoA0KPiDCoAljb3VudGVyX3B1c2hfZXZlbnQoY291bnRlciwg
Q09VTlRFUl9FVkVOVF9DSEFOR0VfT0ZfU1RBVEUsIDApOw0KPiDCoA0KPiBAQCAtODksNyArODks
NyBAQCBzdGF0aWMgaW50IGludGVycnVwdF9jbnRfcmVhZChzdHJ1Y3QgY291bnRlcl9kZXZpY2Ug
KmNvdW50ZXIsDQo+IMKgew0KPiDCoAlzdHJ1Y3QgaW50ZXJydXB0X2NudF9wcml2ICpwcml2ID0g
Y291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiDCoA0KPiAtCSp2YWwgPSBhdG9taWNfcmVhZCgmcHJp
di0+Y291bnQpOw0KPiArCSp2YWwgPSBhdG9taWNfbG9uZ19yZWFkKCZwcml2LT5jb3VudCk7DQo+
IMKgDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4gQEAgLTEwMiw3ICsxMDIsNyBAQCBzdGF0aWMg
aW50IGludGVycnVwdF9jbnRfd3JpdGUoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0K
PiDCoAlpZiAodmFsICE9ICh0eXBlb2YocHJpdi0+Y291bnQuY291bnRlcikpdmFsKQ0KPiDCoAkJ
cmV0dXJuIC1FUkFOR0U7DQo+IMKgDQo+IC0JYXRvbWljX3NldCgmcHJpdi0+Y291bnQsIHZhbCk7
DQo+ICsJYXRvbWljX2xvbmdfc2V0KCZwcml2LT5jb3VudCwgdmFsKTsNCj4gwqANCj4gwqAJcmV0
dXJuIDA7DQo+IMKgfQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3
LnNpZW1lbnMuY29tDQo=

