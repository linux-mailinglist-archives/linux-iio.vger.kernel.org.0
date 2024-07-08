Return-Path: <linux-iio+bounces-7421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21EC929B7B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 07:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4AB20C37
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 05:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B08F6D;
	Mon,  8 Jul 2024 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DGLoFB2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE1B658;
	Mon,  8 Jul 2024 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415919; cv=fail; b=AxsEda/o56RoALgtdH5wE8CiJNYD1ckC/aqSD2OXdnP8VXhKA2lgzTpNNiR/rnQoaLbiiFMdme0RivL4FOezZX73IW47+1gJyRSS5HMNM801UG8H//xrEW5lQjgy5ls5luJTvmxHCiD15q6XOhBmlvDa7dOcLCvPbnhFAkhGQ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415919; c=relaxed/simple;
	bh=4A7y/RUUAVgKg5qdXnWuSNlSEVsaZNsul7Mt9O3KVHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOQCXxSGWe24cYKTaka8tXjrJrUQ/3Khd6KwkcxuJG+tMqORI5wUdVxueLeZvm4ioKpdW5z9Pa/kEbhmUTa3uXpRK53KFKW/ZrKvqeasDfb6sufku1ftPTBNuVoJHBSlEnWlib5xlaH/ssBsl9J/FuKGgIujU4TfIh00UXGnZ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DGLoFB2X; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4680n1mA028908;
	Mon, 8 Jul 2024 01:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w/7Lw
	pAc7AJiVCLOCagC630+H3NE8OUkmEK0XBcXDYw=; b=DGLoFB2XQbpWgDqMiD/WI
	DFmReVXxNmktYclvhAf+bvDh+TcIr4gwK1FOi+31+MnaVaFbZoR6IWcj8vGT/xHI
	zvXAgePNJIiVxBdwqCzx7hfIlDMzlWLKtKTOveZ9mSCb7vQI4x7kDfZj9XLZdHYU
	uBsegLbdTdnS6eWk+twX3cFKQNsr7QnOx/dFZ2HKwgOwOpp9M6RliamVsrBynFcF
	bJr+Ma1u7NLGcIeJ+K7hFBf7UrqZiIbsW6zVj8wtFL7rDXT/qWkcPa6Xh7PTGROG
	yTnhf6prZKnGzGvwFs/SUHEOhRHH2ItcgqkFnpTXF9DX4ZPVhuoRmHJcn2cmwJ39
	Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4072u1mfdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 01:18:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKlhh0f5+FHDm5zB4F34heiRDep6lfbmCp+fqS3oI93lu7aUPK0hQ7u7X9B6dThdRNM2Us6y/ZRZxyzQmhizsF1ofqOFffqkIOUU4+rXTP8YmtnDUrDUzwzymAiCBCUsm7zvmXKcufuGxWsghCTjwBkUJo/DOtOpcd70TzbIYB+rvL4K3yg8IqTy3Px2z3sTyth6Kot5h/YlQa4I+L5/1XNJD8+D0fj3kI+s5WP9kodm8ZFPJXDb9zT08YGnwYcyz5Alc1q506fbdJTLQ0spv/FI1iAkQgy1wv/kav/XrRe/2l1jGnVM+2sc7dIbgRKAKIJli1GPo3CzTNiG+OEpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/7LwpAc7AJiVCLOCagC630+H3NE8OUkmEK0XBcXDYw=;
 b=dxDkfZSOXjwpJhvvCg+H2njubR/wMnVsOUVuRAJYXAXFXcLm366H4JWKsr4WH+t4RSoyYYSHsgWIeY2TmEoFTy0xDoNDKf0IsyQQYJOk36HtCwdDb4x1NnvwC4pcaUUW7A7tonhBPIvx9LNhG2G7hD4Dngt1i3ccZOZ967kI3JYk7K8FUVaCgU/0nPmjRV8Tw0Nask8UVcMdeoFi3tHFk1Twt1Q1Um7W5kotQQCCEKOX5HWGpDqRWECEZUgkSFnssN/DfUZ8WgxCWacXxhO2Ft0coxTpkBt0IDYfwdJsIPf6FK/aqnV+CFvQew6TJh5qhAJ+iHYH8TOatIpybPBO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by LV8PR03MB7469.namprd03.prod.outlook.com (2603:10b6:408:18d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:17:55 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 05:17:55 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Topic: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Thread-Index: AQHao8JvQg6+h8gTiUiRiY/wSfSRo7HWkYPQgAc9vgCADtLeYA==
Date: Mon, 8 Jul 2024 05:17:55 +0000
Message-ID: 
 <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
	<20240511174405.10d7fce8@jic23-huawei>
	<SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240628194546.2f608365@jic23-huawei>
In-Reply-To: <20240628194546.2f608365@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG10?=
 =?us-ascii?Q?aW5hY29cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02Y2E3NTYzOC0zY2U5LTExZWYtOGMx?=
 =?us-ascii?Q?ZC03NDA0ZjE1MjNjZThcYW1lLXRlc3RcNmNhNzU2M2EtM2NlOS0xMWVmLThj?=
 =?us-ascii?Q?MWQtNzQwNGYxNTIzY2U4Ym9keS50eHQiIHN6PSI2NDEyIiB0PSIxMzM2NDg4?=
 =?us-ascii?Q?OTQ3MzAwODQ1ODUiIGg9IjUrMEEwdHU5akJkaC9NQ2FzYVA1MjJHNzgzYz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QURnREFBRHBvQUl2OXREYUFXSWVsMjdpZE4waFloNlhidUowM1NFREFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQVNnSUFBTzRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?aEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0Js?=
 =?us-ascii?Q?QUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0Fa?=
 =?us-ascii?Q?UUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZB?=
 =?us-ascii?Q?SEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFPNEFB?=
 =?us-ascii?Q?QUFBQUFBQUNBQUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFBQUFBemdBQUFB?=
 =?us-ascii?Q?TUFBQUJPQUFBQUFBQUFBR0VBWkFCcEFGOEFj?=
x-dg-rorf: true
x-dg-refone: 
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|LV8PR03MB7469:EE_
x-ms-office365-filtering-correlation-id: 6c8102d5-1afb-4eea-fee7-08dc9f0d52c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?F5mR0Qwcp3M5zNSyxe9jY1Nw08PmzJliC4EFGSX5PzGVCYOvbtUWXgkm8H3A?=
 =?us-ascii?Q?R4HLPlQFdqkzTcUu0yBEjn64t9z9BfVpwyx84MMDrTBm9n55F+f4y3cJJKTL?=
 =?us-ascii?Q?hXg06oTeRuCzxJ0wGguR2Ul7GbyJ9lmZ6Nodg4K/9sH4vTJcAXyfy6UTGWoP?=
 =?us-ascii?Q?Rk5Lh6j014djtjNKo6D6gMPynF/RRmzv7lrzDvMsp4emnOdG0gMHVD0zu1W8?=
 =?us-ascii?Q?jADp0p2yJmnlqPv2TeAv29R3B3KBYEdxBjoy19Hdiv4tiVMCrUB6fF6NtxCz?=
 =?us-ascii?Q?T7xBR08G+daOHok1XpXX7Nj6fdunGaQcise5nLgVuOEmE6KONZfMKWs8cCeb?=
 =?us-ascii?Q?qAscYOsjyg06wcqbNEU5u47sr4hTIugsIbwslzD8PoO/d4FHmHyujyx+ln2w?=
 =?us-ascii?Q?RLv8TyB6gFo1pTJNmEoQ0ZwmX55gcE+p6c5Mpq46UQGXFvBNBPji4Gvs/ULy?=
 =?us-ascii?Q?ZJ0A6H75GtrsQlCzd7VovC1uG64f3GVHCs8NW8fCe/ObjfbNFj4U6WNwk2Lk?=
 =?us-ascii?Q?eHj2ZG+f5CqKWhAb0fgmPn/NIeVQxpDtZlNe4lo7njYvxo1Pwbxdin1oBvTZ?=
 =?us-ascii?Q?aOPMpPl9DfKG12AMbe8IMqEQT/2HePLEnIBoaoltvZSx6wHIMK2ILIED2CoM?=
 =?us-ascii?Q?FY/e8dSdb+rZks0X0THMA06x0zJLeY5wrneOSVBPBq08C9poqkvA9ywvdVky?=
 =?us-ascii?Q?S8yGf4BPFiTohPJWfHveggjdWXSTsSCUFKtBj52iXxoELsLrDI897sy2vM+O?=
 =?us-ascii?Q?U77sPiN3WU/GHqnkXh8D5Y5+bzqq+IhWXqTrIdHtJd5K7iWEhWJbjzvPZrGo?=
 =?us-ascii?Q?UL1RKeGdq6KjPI+OPtBp9HF+D+OOrV4OKcN8MZAEGrtpehjDlH8BUe/UmTwy?=
 =?us-ascii?Q?fVyCh2SSCjIhGyF+6EJQf2Bo+U6/Uyivpb7rxOAmNL46HcmcFMwm29aOf5bY?=
 =?us-ascii?Q?6Guq8J8LUebYdhcH4RStfrs7xzX2UBeQhMEJ1QS0YtI01jsU4Yfa7ckB3oHR?=
 =?us-ascii?Q?y3bgoPjSBFftkn4trNd4IJbwnBCmkLY6ZAOf8DBvBTHw5eSDUurjD4Ul1dr9?=
 =?us-ascii?Q?jRwKP/NpIKR9Nuot6fZ7HsGjw/nkZs6ZZB+x4Zm9BbfyjKsrFV22JyPLNPaJ?=
 =?us-ascii?Q?/+N7xq20PeWHMfN4REPF/jOMxTz4yCskjxQ8sjwSMqf3LLLI+w0gcq+sF1uy?=
 =?us-ascii?Q?q+c/hzdLtLKSQyp8yXQLmfulR4UC9T953Lvr+J/dNJM95yrM25dCCjGwTofV?=
 =?us-ascii?Q?a9myW5Wge4yG4J8Mz3uhorQtmkjXlZXMGTCXfVabjHS23dfQHswJA4ez01Wg?=
 =?us-ascii?Q?sP2u3s7w5JtjdlQOluBW02IHBPd1JQyMxe/4FfaQ/6djqZzi6Mlde/5hmp79?=
 =?us-ascii?Q?bOTzkUfBLu/BpUdHRHTuUQzPBZHtSYww4NVqeS6Fa6zdYzGw5A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eP/lKfCkl7H39csGMV/KSd1IUh7fgzLt35DucASlKss/J8XxLLjHqmhReGXz?=
 =?us-ascii?Q?rJBstzw/SvunTkL+QFfQX1XSIdrISK83OZOG8n6WMpmqnqplqRfE94OZvOgY?=
 =?us-ascii?Q?UdC9Zoysiqiqm0zeRFmixME2KczjQYtAyMi+vsEGv/ekz3Scycf7UUSKS6hi?=
 =?us-ascii?Q?aR4vmiw6t7VM/zdFHaxsy0p0lRz8Q9DIESqbn5D4C36qNadfnAUmfxwOUqZl?=
 =?us-ascii?Q?eX6MIDOMAQw/BHddFnUiECL/a0fJ/qkz4Mw1CvDH0o1m+fzdxlBYf7qHdT+c?=
 =?us-ascii?Q?aoV/dS+9B/A3jUw1thptg9IeBabb1QatLCoVKcD7wd+MiartgnMJV7tMr4Xg?=
 =?us-ascii?Q?1ICdfo7iAxGIiP2o57JxxJlXJkm6HJuqaDYJBu1dp68n/DsBK9cLTuCw04Rt?=
 =?us-ascii?Q?EuGbq4mY8XkBwjXpHqirjEfx+439NtCtpCUv71cOPTSwhVj6ZUpCWXu5g9CH?=
 =?us-ascii?Q?5xcgVeQE8gDRIyR9L2SpPB6Jwzo/ZeYKdvR7OezMeiTESUZP98Lun+N7Y+gP?=
 =?us-ascii?Q?Xu2tRJMit52NGcj6CligaaojDUe5rAY2BJdEPHyhepTI92a2O/nJwW2sOt0N?=
 =?us-ascii?Q?vOI/I2sbzP5xerWEYycJ4V+wpvrE0jNxXaqihYeD9twdhKDO+KULXFkjfPlJ?=
 =?us-ascii?Q?cCVHSgV5LUYhVMbCCh3uKOr53NTn67PkGRCP1wZC95t+d1GFvJJTjk//5pM5?=
 =?us-ascii?Q?FHo+mU630Nodgj9J6x/30BqLZhVVYSo0X6s6vwq2StrGPkfZehFEEjo4FQvB?=
 =?us-ascii?Q?6cShTT0fu59hJyieHxTvNgV4wt9SVzLEaTQNyFnTccRs+ZTi+N4Xn5k9/I5d?=
 =?us-ascii?Q?UbiL6mJcCnG2sI78xf0McIfvJZBiW5CDv6Tnq5a6OOZc0LUzyo+KI3Aa19Q6?=
 =?us-ascii?Q?7AxwGydVM62Do7uli86Qm4wKkDThlAJw21bBer/5bnUbhU1qg6MZfs8aIySc?=
 =?us-ascii?Q?Us9qW1YQNHYLgH9IiBEBbioZqL4JgZ4sR4EpSpxSAGgyLSQsKObwKA1d8vz5?=
 =?us-ascii?Q?kHplZBgPUwd9QASJdtpRLEAaFPWnFpM84VotaF3KtNqoCQbVkFcTnmbiz+U6?=
 =?us-ascii?Q?isZ036tVjXzT5/fKrZBebJ4hKIS9f1l94r4A23ROKleUqwBXdJIkC6w+iBdf?=
 =?us-ascii?Q?vPM5ot4JGZrgxmAP67R3vT++eyb2I1TKaeU+LGWLR0GmVubll+yBwP+sBNLQ?=
 =?us-ascii?Q?Rgr8G3+Y7npjapGQjtqA+uMEzvAoQNBb7w/GKRJPUXOM+BXTH5GO7KF5VTFe?=
 =?us-ascii?Q?DSf8WvlZ7sdKReLbf8sdpW2QvlTcClaThMBdync+R38pAn/tjPFGjWb/A3Zn?=
 =?us-ascii?Q?HMxoKIwkU1abY6gh0SYWDLFbBIFNsBFlCnvnKIllrugmxQ+IC4qvmEnUeUa6?=
 =?us-ascii?Q?wZBqwWcfGqysp7p8c+AU0MkVlNT+0cGCsJk0Y1fWLkRAGOuw1e9ZF/+hNcfR?=
 =?us-ascii?Q?Ia3okRWtdxGFpd1bQATw3C5aKLAQ/l5StpOuHxZPcLu36x+4C56/wrkLRLzU?=
 =?us-ascii?Q?/rSRjtuaP38Ao2bV2G4RLAxv7fPqgPuvioT59g4Qr2ksoQMln8bnz20g0f3f?=
 =?us-ascii?Q?6EzKK6xhlfPKK+DMyVF1s/gzQDinb89UCvPC+GH4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8102d5-1afb-4eea-fee7-08dc9f0d52c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:17:55.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lBYbW6VIY2vCDX4bLPu2j5qucBXIXCNrpM+kO0sZSsykJCsxU0k/z7togaoaTY2QZ9MMQYCXf8rHb7eJWKD74K49P7Nrl5BS10hmD3F4TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7469
X-Proofpoint-GUID: DLg_xTpbxhrn4htxh_Q80Pl3t-DeFJxI
X-Proofpoint-ORIG-GUID: DLg_xTpbxhrn4htxh_Q80Pl3t-DeFJxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080039



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, June 29, 2024 2:46 AM
> To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
>=20
> [External]
>=20
> > > > +};
> > > > +
> > > > +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
> > > > +				     const struct iio_chan_spec *chan) {
> > > > +	return 0;
> > >
> > > Why have the stubs in here?
> >
> > Should I move the stubs to a different place in the code or remove
> > them altogether since there is only a single powerdown mode available
> Ah. I'd not really understood what was going on here.  This is fine as is=
.
>=20
> > > AD8460_HVDAC_DATA_WORD_HIGH(index),
> > > > +			    ((val >> 8) & 0xFF));
> > >
> > > bulk write? or do these need to be ordered?
> >
> > For this I used bulk read/write this way.
> >
> > static int ad8460_set_hvdac_word(struct ad8460_state *state,
> > 				 int index,
> > 				 int val)
> > {
> > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];
> regmap bulk accesses (when spi anyway) should be provided with DMA safe
> buffers.
> Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN) to the
> end of the ad8460_state structure.  Possibly you'll need a lock to protec=
t it - I
> haven't checked.
> >
> > 	regvals[0] =3D val & 0xFF;
> > 	regvals[1] =3D (val >> 8) & 0xFF;
>=20
> That is an endian conversion so use appropriate endian function to fill i=
t
> efficiently and document clearly what is going on.
>=20
>=20
> 	put_unaligned_le16()
>=20
> >
> > 	return regmap_bulk_write(state->regmap,
> AD8460_HVDAC_DATA_WORD_LOW(index),
> > 				 regvals,
> AD8460_DATA_BYTE_WORD_LENGTH); }
> >
> >
> > > > +}
>=20
> > > > +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config=
);
> > > > +	if (IS_ERR(state->regmap))
> > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> > > > +				     "Failed to initialize regmap");
> > > > +
> > > > +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev,
> > > > +"tx",
> > > > +
> > > IIO_BUFFER_DIRECTION_OUT);
> > >
> > > Ah. I take back my binding comment. I assume this is mapping some
> > > non standard interface for the parallel data flow?
> >
> > Yes, the HDL side doesn't follow yet the standard IIO backend from
> > which this driver was tested
>=20
> Hmm. I'd like to see this brought inline with the other iio backend drive=
rs if
> possible.

Does this mean that we would need to implement an AXI IP core on the
FPGA side to be able to test this?

>=20
> Jonathan
>=20


