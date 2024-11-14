Return-Path: <linux-iio+bounces-12250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD759C8B6C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26863B2D7D5
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EC1FB3C0;
	Thu, 14 Nov 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aB+wLTsY"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F21FB3C5;
	Thu, 14 Nov 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588740; cv=fail; b=n8wEwtZXb/T/ma+0iZ/fAh25qsLe3bwkwhwgnwGa4vbJFCwLC1glISWZbsJGpe2jCrIwIPdgVdew4X9pjNZJbjTSituo46Em2VE1SkeUSnhlj2G9JGHWhnoogUrPlTLzFJkIbiCr3epuuTEArhEqDkbZr3MxpwGsB91rFa3f+nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588740; c=relaxed/simple;
	bh=Wi2JSPHPlCIcHSGRqkGcX7ESbZgJVDOL7U/ID1WCahc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NURQZQwIjOO1ARvatzedD7gdWTkkGcunvaIpYtGgUucM38IerX8qif6gZojddgslX28BjLrTUDmo/yVc0mVfJIsfyJxP8vXFgMxEO8YX1Th2VVl+5Mu3MO5SnNB7+NN0hJBzf5ycgJUBxD40H2sqMa8pVMkIWOvId2qjxZiL2rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aB+wLTsY; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN+iSQ2pEF6emDOKywRgS4Wobd0vYXDumEA2xohYT82+jpTFXh62CFCOMUy2t6m6l6YvfXoN8xx1DaiUzRmrQ5h9T5K2hdQNS674crzODabpwrIIpvmEpYZC2zoHHH1Mbqui0Ed22Hqo9TtQRskggswa8T8D/gsWTtA+j0qvWGlJQpyEtA9v2vDtnvUR3vj1+xe7XNdOqYTLxSq22AENOxugXLVCK7oQ+dpxYYkGRdOv4HVvSK3gvaGS6Wxjpvlpf0ryPkSz59cedtZZNJVQPv33j1bi4JEZ/1sTpLyjt7v1HkkWTCas64GBoTUIKJrCub22csxPCx0pwnJ3PdtMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi2JSPHPlCIcHSGRqkGcX7ESbZgJVDOL7U/ID1WCahc=;
 b=nRbrkJMq13H9z/b6tgdFt8A5u1zZoEiZV9E/c1nbgTu5WB5uTZV08WL5e8cCuU+5xcE/f5VjYbktIv0Q4R5UK1/m+RcbW6JqOMGU/i/CqCQ9xPew2Dm3CkWHP2qOeDCg3/AFgWPYpj7Y8ouwbRFt0doX5YDjbik59X1x1BpJ1dqZ4HfFr4GVvPiMeRZvT4XMAyTGTG7rjGU+aTL0Z5ptCTBxcLJrJ20OHkTzoVPyDiyNt8WLs58/lZm47F5lPy9bp9YPJ/aIhaUsxQbKkTnJAW0q4kxQkGxSGHT5YPrtzGrBINHzGwah9uQ4sJYiVExXKNhxdyMoQY9RNDVDMjT/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi2JSPHPlCIcHSGRqkGcX7ESbZgJVDOL7U/ID1WCahc=;
 b=aB+wLTsYF+hRxUG4nLZlYpnuSPXUtllmEO5MzO+Sx5ZpDXz1LfghGFqTzmnw+7alAXdJZ0iUyNNJzh9DBP/Y72PCXJfWBl6Hda4WZWpB/Px1yYl1VNkp50sfZzKk2k6Ma0KFLJ8YOktHxXwREb6cHGWuV6JaVq5bATdrVLxowAQQLbfPG1jwIRALddinLElpWhJEPLxtZQYXWFLXs/7O45gtiWC1LNGsKU4HJyKVxKiyIUAmxxtNZgRfQxF4CrL8gWM5+Jn1VN+HpvrpO+K71fJ9mIGF5kbhnXiZ1Fmav7Oe9ImwHMxVnkOMiQfBi2k6DGxHh5fFFNlMdq2wITE/Vg==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 12:52:12 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 12:52:12 +0000
From: <Victor.Duicu@microchip.com>
To: <andy.shevchenko@gmail.com>, <jic23@kernel.org>,
	<matteomartelli3@gmail.com>, <lars@metafoo.de>
CC: <Marius.Cristea@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Topic: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Index: AQHbNnIAmHY7uJINYUWxTZu6VtQ26LK2m/QAgAAfMwA=
Date: Thu, 14 Nov 2024 12:52:12 +0000
Message-ID: <faed3b586e1af2d946d3f9b185a94b6ebf0f6f32.camel@microchip.com>
References: <20241114084702.3499-1-victor.duicu@microchip.com>
	 <c1b30741bec25e25c6e57389bf45d04f@gmail.com>
In-Reply-To: <c1b30741bec25e25c6e57389bf45d04f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|MN0PR11MB6208:EE_
x-ms-office365-filtering-correlation-id: 1b9cbb75-1998-49d3-a846-08dd04ab2886
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0dYbmpDNW53Qm4va2FjUDMxa1VKa1QwaVhRWDBnRWptM214RDZpTWVKUGlM?=
 =?utf-8?B?aURUNTM4Z0FlNE1JR01FSWZYVm5YWW9XbHA2OGZtZzRkNElIOWFWbVA3NFJP?=
 =?utf-8?B?U0R5Q2RocVB2cDg3cDhEL3B1MzVZSm9yaEU0Zk1SRm13VkxyampzYWVHbGRH?=
 =?utf-8?B?WWJSSC9Bb0YzS05VckloRDdjaTdubkRlK1RnSXR1YUtvcUw2RGdXQXNPRVox?=
 =?utf-8?B?RlpBU1llVSt4N09rUERCbmF6L1Z3NnBxWGhHaExvMTREN0szZkRGV0dQaENq?=
 =?utf-8?B?TzhXQ25tRUZUaElDMGZRL1krTDZpckF3aklvaEZZT0dKWmZwVzU4ZzNMQjRh?=
 =?utf-8?B?eTV5bU53cjQySFA2NGNMNmRkdFJvMHBCSXd0clZXaVNiZ3VmU1hvODB3QmtH?=
 =?utf-8?B?QVRXOHpmazk5anBuMVU5eXY3RDFqYkdqcFBTOW1sOERIdkQ3TlY5b2dKTjQ1?=
 =?utf-8?B?dDI2ZHJ0MmppczU0amlrTnhtNDVLMFVLQysySlR3cUJUZU5aZis0aW9FaE9a?=
 =?utf-8?B?aTlZeU1UWGczR2picVB2cXJ5N0pOeWNtVjBJbzA2SDA3Z2FnSHd5OXVGYTdr?=
 =?utf-8?B?NDBobHgyeWoxS2wrRHd5eUJ1NnlVdzFRTlN4YWNsZVBLMmpwV0htL0ZTaEhl?=
 =?utf-8?B?aVpPa2drMjluSThGRS8rcFRhZjc0TDVnTzZaZEVHd09FSlJiVFplZ2trLzVM?=
 =?utf-8?B?QkhyMGtkSzVSWCtJbnlMYUJTV3l0MDJkVjhiQUpXN24xc0tFZDVzWnE3Nk9E?=
 =?utf-8?B?VVlEVHBHVGxMUHhjMkM3ZTJIdXQyWWZ6YWQ3NnNHKzJiNVZnY0xITEd2aEQ0?=
 =?utf-8?B?UHJKMk5leUV6K01pQmJwUjhDZjVML3RnUDhGSERDcms4NmRqTnA1bHlHSFZq?=
 =?utf-8?B?NFNsV0tveE5OSUt2TjFaSitPNmUxaWRRand0WE82VmhQSE9oR0g5WmV3S29x?=
 =?utf-8?B?ZmpxTmdZanpzQnBDM29hQ2orVTl6Si9MTnp3VWpWb2Jib2dxSGJPTjRmMTY0?=
 =?utf-8?B?VEtlT1ZmMnBUZWZzS21yRTNQa2c2cHpLRTJMM0hqaUVrYlRMSTlVVWhYb1M5?=
 =?utf-8?B?dUJzRjNRODRRcDNueWhjZit6Y3FpWlZVVUxibGZPOE9TL0hvQnpkcHpWNWhK?=
 =?utf-8?B?ZVRxNEREWFRrWnBwWUR1R2ZVWUcyai9vQytUWWFOaW54OE00a21LZWRMbEhB?=
 =?utf-8?B?NkZpWEo1R0c1US9BRFphZFZGSnZZcTYwdmZmakVIOHNwNFFFTVRUSFRCMmIw?=
 =?utf-8?B?elpXa2RmelJRdzR2VnA2V3lQRmYzNFZqTXlDLy9idHBJaGcwNHBQTVdtWXU1?=
 =?utf-8?B?YUZSSXZ4RG05OFUzUzg0TGxQeGkxYWlqNnNmazdxNldHc2l3Y1l0UzNPRW5v?=
 =?utf-8?B?b0h2UmN4aW01SFFQelMrK3ptLzBKdm1mTlNJT1hYV2FXTnBBQXVXZEpOdklV?=
 =?utf-8?B?R2ZhTjNzT21jd3BBZk8zSUoyS3RRYlhtc1A3SzZudWFzaGY5MEVCNSs5YURp?=
 =?utf-8?B?NFR2VFVMT0tqQ1lwYUdiYVFUczMzY2M1ZENnN2lVQ0FUOW9hOFNGMHNlMnhz?=
 =?utf-8?B?NW5EdmtDdjg2U2t6c1BTZlN0YzU2bm1lSjNkZlB1N1E0VkIyd2UzUXc0TEdH?=
 =?utf-8?B?NFFLUjVrV2tYckhjeWVUMlRVVk5OZUt6R2JMQVlxODUwd0c0UXpkc0EyeGtI?=
 =?utf-8?B?SjNBcHJCc3F6ZnhCdUFENmFHb29LSVFrV2xiUTllOVRSUXo2cXFwNnJ0c3VQ?=
 =?utf-8?B?RTFrNTNSRE5MYlRuZjhhZGliWTVmSEtuc3B6QkhtSXlwUm4vYVFwbHAzTHlG?=
 =?utf-8?Q?JrtMNncGoZDpX7WDjdqdXM89VXhZ/we/9m3q4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWlkeDdKNmVBbEI5ZDRoUXA5aE9uQzFDNkNubTUrbUtjaER1RmdWYjVXZGhF?=
 =?utf-8?B?OWNOK3N0NDkrM2pQckJ4RjZseHRhM1dIQmNuYVJVMTZlTmxqWGN2RW1rOHBE?=
 =?utf-8?B?VEFwMWw3enc5ZVNKVm16eS9BTDNjdnF0cC8rcnZuY3k2RVI0bjRadFFmS2xL?=
 =?utf-8?B?L2V0ZjBVRTZRVWxSelhxRGdWQkl2U1VDUXZEWHo1alJRV3NTUGNsQWRoVHNE?=
 =?utf-8?B?dFFNQjNlSGlCY09ScnM5Mm1laHN5MGFqK0hrR0dyN1NMRENQRTRFVVJ0Nko1?=
 =?utf-8?B?MWd5UjNDNnp1WllyQS9TSzRINEh2OWlNeDJ4NlV4amRQVXZyeDIrQjlMZ1Vi?=
 =?utf-8?B?WkZKVmdnRlNxV3VSeDM5MUxhQ1FsL1RiU3lpU2hlWTZTVFVHck9PYW9MVzB5?=
 =?utf-8?B?a2dDOFlKMFF0c0JZNHluN3ZLdDZMVUt3cjJxbWs0S2t1UnZ3VUZ3TkVrcjUx?=
 =?utf-8?B?UFFvT25nRldUYVRmMUhxWmc3VThWbEQvU0daa3VhVUNXY25ZSjJIMjlFU2k3?=
 =?utf-8?B?d2tJRSt2VmZ6UzVaMzdTN1NGbVI0NmZwYlNTT1hCSkk2bXhuL0lDSXVUWXEy?=
 =?utf-8?B?Skxjd2d0NlRZeGJiZk03WkZhNCtzUXFucXdOYUV4V1hiR0VrclpFUGlYNVpV?=
 =?utf-8?B?amJTS1JwMDZQMTlTdkxwNGhueUZOR2N6cHZER2h2VngwMjNLUXJYem85bWtE?=
 =?utf-8?B?KzR4TXBhYzdsQUVGMFdNWk82QTJjQ01JOWlRRUhtK2hva2U3b3Y5dk15aWps?=
 =?utf-8?B?NUhlTmFCVGJZOE04Q0FmeVh1VEZWaEZYUUpib2NBVlVWRS9qMXFBeXNyMkxw?=
 =?utf-8?B?M0pCSGtRODlPbDRBcVQwNU1PVVdyRDlON0VON2NjRnUyeFgvSTNtaXNGaERu?=
 =?utf-8?B?d1lsWmloTGVBZUgzWU1tOEhzdlBGSGV3TStTL0FmNjljcW1ybVpEeG13dE9k?=
 =?utf-8?B?YVFPNXRjZkluNnh1bGt3NkZiYlBVTVZjV0JITkdsWVU3ejBiRDdKcHI5THNj?=
 =?utf-8?B?VUxyN0NDaW94M1RwcU5Uc2VYTmhaNUFkK1l6d3pFbzRxU3FDOGx4RjZacFlw?=
 =?utf-8?B?ZDhSZ1ROdGMwN2owZnlYbUNvaTVLNlExTEVZY1lIYlp1VkNmK0FUblVubFBL?=
 =?utf-8?B?Z1MvbzdDY0pxM2xIRVMrNGFyQU12Z1UrVkxVbnJ5K2RBNmVHUloycVh1WHF1?=
 =?utf-8?B?QXVhckxBTHRiQjdRM2Q1UThYa2lTQ3gxWVBjaEkxWFdmZm5Uem9jNFRvam1W?=
 =?utf-8?B?M0RZYWllSUdiazNlb2NKVWVrMDZqckNWQlc3V0oxZk9qdy85Z2VCK1l3c2xq?=
 =?utf-8?B?NFdpM1ROQlJ4K0xaMmlQMFR0VHphejBPeUpyUWZHdnJZTjZxYWxpQUhwR0VY?=
 =?utf-8?B?Y2FnUkVlc0F1V2JwWVl3NzFQdmZabmhQZWpUVlZ5VVJVRCtLakg0dUpneWx3?=
 =?utf-8?B?R1UwaDJZU0dmNUlNNnN1anFGYmYzd3cyMzVUZWVFcVc2MjBRRnBmN2doLzB6?=
 =?utf-8?B?alZCS0dhRUhacTFWczZZSmVOUVJQdWV4ZDNmOVFFayswclZPOFFURzczN1d0?=
 =?utf-8?B?Nnc1dy8xVjYycEtHZE5nK1hRMzZKWHFlTUxuVUdzWmVNRFF6MHdvRmxXVFJo?=
 =?utf-8?B?K08zMzFxWGFheGVNbitYUU5DMXhmZ3JtK1RpMkRva0lZTnI3STgzdUY1cnl0?=
 =?utf-8?B?M2V3QTNGVzdwdE1hTU1DcGtGMG9JN2ZNNGNRbk5sRVhEQi9WTWVoMnNXME5j?=
 =?utf-8?B?RFhGQlRQMlJpbW52RDVrZjdmd3M5dk9RcEdONnVCL3BTNzBVUFBmSTJ3N1lo?=
 =?utf-8?B?c2lrdkRaNTFRRkV2N1pvZTVYVEhRdlJTM2psWnIyYy9PQTN2WkNPampIWklE?=
 =?utf-8?B?Y0ZGb0RRR1B6djJmSm5pMmlmbmFqT1FUaGtKbmNUSWJyTEdxTzZLdStWQ1Ra?=
 =?utf-8?B?VXV2VmJCTENlcU05blF4ellPbGNiWWxUT1NwT1BjOTJESkpIK0RjOUNiVUt6?=
 =?utf-8?B?VHF5eW5NdnZuY2xDVjd5eFB4dW1RSE05SS83WUg3emJuejZWMUg5aU95K3Mw?=
 =?utf-8?B?ekFoRUFKSVNNSlQ0VzNLQjB2d2pDa0dZajJpeHhOUTJEOEd5NlZSM3ptK0xS?=
 =?utf-8?B?dERlazl1RWRpQWNBSTd3MnFOK3paYzlUOHp5R2JOWVd6V0c1WUNiczEvRWho?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C0C716421A96949B4C7A78571AFA40D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9cbb75-1998-49d3-a846-08dd04ab2886
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 12:52:12.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c72DEeHaPi9gtS+6qiXiJMwc3jxF05hh7Jb8iRwB2hvAp4omEjX8p+Ic/+J+LDvPgPwBsPlwPkZKXxXs2HAU23hQzCpLTMsmf3qdjh4qabk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208

T24gVGh1LCAyMDI0LTExLTE0IGF0IDEyOjAwICswMTAwLCBNYXR0ZW8gTWFydGVsbGkgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCg0KSGkgTWF0dGVv
LA0KDQo+IE9uIFRodSwgMTQgTm92IDIwMjQgMTA6NDc6MDIgKzAyMDAsIDx2aWN0b3IuZHVpY3VA
bWljcm9jaGlwLmNvbT4NCj4gd3JvdGU6DQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3Iu
ZHVpY3VAbWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgQUNQ
SSBzdXBwb3J0IHRvIE1pY3JvY2hpcCBwYWMxOTIxLg0KPiA+IFRoZSBkcml2ZXIgY2FuIHJlYWQg
dGhlIHNodW50IHJlc2lzdG9yIHZhbHVlIGFuZCBsYWJlbCBmcm9tIHRoZQ0KPiA+IEFDUEkgdGFi
bGUuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgRHVpY3UgPHZpY3Rvci5k
dWljdUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+IA0KDQouLi4uDQoNCj4gPiANCj4gPiAN
Cj4gPiArI2RlZmluZSBQQUMxOTIxX0FDUElfR0VUX3VPSE1TX1ZBTFPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMA0KPiA+ICsjZGVmaW5lIFBBQzE5MjFfQUNQSV9HRVRfTEFCRUzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxDQo+ID4gKy8qDQo+ID4gKyAqIFRo
ZSBtYXhpbXVtIGFjY2VwdGFibGUgc2h1bnQgdmFsdWUgaXMgMjE0Ni45OTk5OTkgT0hNLg0KPiA+
ICsgKiBUaGlzIHZhbHVlLCB3aGljaCBpcyBiZWxvdyBJTlRfTUFYLCB3YXMgY2hvc2VuIGluIG9y
ZGVyIHRvDQo+ID4gKyAqIGFsbG93IHRoZSByZWFkaW5ncyBmcm9tIGR0IGFuZCBBQ1BJIHRvIHNo
YXJlIHRoZSBzYW1lIHJhbmdlDQo+ID4gKyAqIGFuZCB0byBzaW1wbGlmeSB0aGUgY2hlY2tzLg0K
PiA+ICsgKiBXaXRoIHRoaXMgdmFsdWUgdGhlIG1heGltdW0gY3VycmVudCB0aGF0IGNhbiBiZSBy
ZWFkIGlzDQo+ID4gKyAqIDAuMVYgLyAyMTQ2Ljk5OTk5OU9ITSA9IDQ2LjU3NiB1QQ0KPiA+ICsg
KiBJZiB3ZSB1c2UgSU5UX01BWCB0aGUgbWF4aW11bSBjdXJyZW50IHRoYXQgY2FuIGJlIHJlYWQg
aXMNCj4gPiArICogMC4xViAvIDIxNDcuNDgzNjQ3T0hNID0gNDYuNTY2IHVBDQo+ID4gKyAqIFRo
ZSByZWxhdGl2ZSBlcnJvciBiZXR3ZWVuIHRoZSB0d28gdmFsdWVzIGlzDQo+ID4gKyAqIHwoNDYu
NTY2IC0gNDYuNTc2KSAvIDQ2LjU2NnwgKiAxMDAgPSAwLjAyMTQNCj4gPiArICovDQo+ID4gKyNk
ZWZpbmUgUEFDMTkyMV9NQVhfU0hVTlRfVkFMVUVfdU9ITVPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMjE0Njk5OTk5OVVMDQo+ID4gKw0KPiANCj4gSnVzdCBhIG1pbm9yIHBvaW50IGFi
b3V0IHRoaXM6IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB2YWx1ZQ0KPiBjb21lcyBm
cm9tIChJTlRfTUFYIC8gTUlDUk8gLSAxKSAqIE1JQ1JPICsgTUFYX01JQ1JPLiBUaGlzIHdhcyB0
bw0KPiBzaW1wbGlmeSB0aGUgY2hlY2sgaW4gYSBzaW5nbGUgc3RhdGVtZW50IGluDQo+IHBhYzE5
MjFfd3JpdGVfc2h1bnRfcmVzaXN0b3IoKQ0KPiB3aGljaCBpcyBjYWxsZWQgd2hlbiB0aGUgc2h1
bnQgcmVzaXN0b3IgaXMgc2V0IGZyb20gKnN5c2ZzKiAobmVpdGhlcg0KPiBmcm9tIERUIG5vciBB
Q1BJKS4gSSdtIGZpbmUgd2l0aCB0aGlzIHZhbHVlIGFuZCB0aGUgbmV3IGNoZWNrIGJ1dCBJDQo+
IGZpbmQNCj4gdGhlIGV4cGxhbmF0aW9uIGNvbW1lbnQgYSBiaXQgY29uZnVzaW5nLiBJZiB5b3Ug
Y291bGQgY29tZSB1cCB3aXRoIGENCj4gYml0DQo+IG1vcmUgY2xlYXIgZXhwbGFuYXRpb24gYWJv
dXQgdGhlIHJlYXNvbiBvZiBzdWNoIHZhbHVlIEkgdGhpbmsgaXQNCj4gd291bGQgYmUNCj4gYmV0
dGVyIG90aGVyd2lzZSBJIGFtIGZpbmUgd2l0aCBpdCBhcyBpdCBpcy4gQWxzbywgbWF5YmUgdXNl
IHRoZSBmdWxsDQo+IHJvb20NCj4gZm9yIDgwIGNoYXJhY3RlcnMgcGVyIGxpbmUgYW5kIFVPSE1T
IGluc3RlYWQgb2YgdU9ITVMgdG8gYXZvaWQgbWl4ZWQNCj4gY2FzZSBpZg0KPiB5b3UgYXJlIGdv
aW5nIHdpdGggYSBuZXcgdmVyc2lvbi4NCg0KV2UgY291bGQgY29tcGxldGVseSByZW1vdmUgdGhl
IG5lZWQgdG8gdXNlIGEgY29uc3RhbnQgYmVsb3cgSU5UX01BWA0Kd2l0aCB0aGlzIGNoZWNrIGlu
IHBhYzE5MjFfd3JpdGVfc2h1bnRfcmVzaXN0b3I6DQoNCmlmICgoIXZhbCAmJiAhdmFsX2ZyYWN0
KSB8fMKgDQooKHZhbCA+PSBJTlRfTUFYIC8gTUlDUk8pICYmICh2YWxfZnJhY3QgPiBJTlRfTUFY
ICUgTUlDUk8pKSkNCglyZXR1cm4gLUVJTlZBTDsNCg0KRG8geW91IGFncmVlIHdpdGggdGhpcyBh
cHByb2FjaD8NCkFsc28sIHRoZSB1c2Ugb2YgbWl4ZWQgY2FzZSB3YXMgc3VnZ2VzdGVkIGJ5IEFu
ZHkgdG8gaW5jcmVhc2UNCnJlYWRhYmlsaXR5Lg0KDQouLi4NCg0KPiANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gTWF0dGVvIE1hcnRlbGxpDQoNCldpdGggQmVzdCBSZWdhcmRzLA0KRHVpY3UgVmlj
dG9yDQo=

