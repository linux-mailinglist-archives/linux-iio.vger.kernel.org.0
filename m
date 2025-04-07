Return-Path: <linux-iio+bounces-17732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748BEA7D736
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA43AD2C5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D972248A4;
	Mon,  7 Apr 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hrLUH91K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A7145355;
	Mon,  7 Apr 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012932; cv=fail; b=k2GF5icJZb5PTl/L7FGYrDHFijuZ5SP4kIHhwfF5xU2lONwaSNb6+hChTKYfR9ZeRRjMaxraiWdpJi08AARyxGpwIg7J04miA4UzWQA4I6FX4Glvtg4HZU8EUDMwl/D883DEdFS74s6IR+4kVOIfgHFpKVzyrrsp+8PbA+yRv9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012932; c=relaxed/simple;
	bh=5i1aIPLj5LdXPtbxnFTTOxcI7V2tgArBPanLOleSkzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYaQ+1Dpz6OqURvkfwH+Gc/g341Lu6KWg3Wl6NCLYNUJRzBuNOeDcT+DNlkRyJiY+fxmv15OXaTr/aQ7PjcOVfdVrJX2Dl73b5LhbQ/piUHmh7BdBngnHfkRAdXzWGQ3AYyiJczfdYWza0I4OpDb0i2d8kGOtX7ONGpoW7d27E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hrLUH91K; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5374xJTj009353;
	Mon, 7 Apr 2025 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5i1aI
	PLj5LdXPtbxnFTTOxcI7V2tgArBPanLOleSkzQ=; b=hrLUH91Kx7owBJwCMJzZe
	2aXRgsepsRcr/EoD9/oQ1hP96poJcUnMNscZuZ60C/Q6m2q1Iwyl11EJjv+ta9dc
	0VE19QA6l3d4gFJxIQqmHGKvxdX7CqqOD5k2uzjWMdP2XF2TfDHI9SQ5u/QvhnyT
	vZag5nt/fKJ02FUnoXjaVYpf+64ntjnONmzYGm7UbbRDeUSx+fEPavV6Dqglg6UI
	5ETO/UFkgalfUnNQHMyCHNT/4qG2hLpcc61Y68hQWWJacdSThEPeLFFnBJfji4Z8
	I064X3CADKrv7WDCgPFJXsrDkqNBAvFUUmt7/WTW1lX36R6FdxSpubpBQ42QYDxR
	Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45u15670bu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 04:01:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9qiixZNzebGefV9kLMvcZDUnrSlZohIY8akFpu2yxWL7k+Gc09pu6WaGNMFV187NclzEjw8XSKbBbi2jGuuxgO4bpYQkOYZ0ti+51xQogqmDaiaLg3zx6CfD1PYm8DlW/GvKlfathnZRfbB7JImYICko2otD5O79hAavIDPokXcR8ZE+h98ri0ygTHwuoEFzeEeDEt8LEZCDr5nb7I/JqxA83LkDj3z3ZT/cEKd+CbLJmNC+PEj88NlIlxJaS2MXVZ26S7/aQ9radzMAQO6yC5GrdhJ1YNcA7jLA5D6+u+gfv8QSlN2fFVPe1G+VKK0U/1PA9qgxGcQ60JT74XeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i1aIPLj5LdXPtbxnFTTOxcI7V2tgArBPanLOleSkzQ=;
 b=Gg4C54WUB6beWSthn78RHxhYXRY9EIWeliWjVQTIjqw3cJ6ihEJPYwoYfpbs38lO6TGwSA945pH5AdtXN98Mf0hPd3HNbJGjOfMl26juB6R/c9ijWRLSMtSn1uPiUea4Pr262If0q3C5Cp/Af//jln8NyP3cVSw6PS2s6/UeTQcxeUrQKofzJqiy7rU6DmleEwlKtiVXYeEyCNR/B4OVH0sNpWvbYYSpxyBXfU1c/O5hrcXnOQe8DSUHREApKzW0qIjSJXzVh1jrlTIu0xKR0ip1JC31ElIJuHPC1rwGm5taSjm3fGvQ37AzjTw8umhXNPs/MB/Q5g1BHn9owYEgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH1PR03MB8141.namprd03.prod.outlook.com (2603:10b6:610:2b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 08:01:39 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:01:39 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbpFodVQ0K5gQpPUCv8ilGKsClk7OTytsAgAQPsrA=
Date: Mon, 7 Apr 2025 08:01:38 +0000
Message-ID:
 <PH0PR03MB714159E822B96E7A788A5CD4F9AA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
 <fd2116bd-b0e2-4db4-97ff-1a1e88545413@baylibre.com>
In-Reply-To: <fd2116bd-b0e2-4db4-97ff-1a1e88545413@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH1PR03MB8141:EE_
x-ms-office365-filtering-correlation-id: b11e435a-39f5-4d83-67c5-08dd75aa6d02
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0pzTDJnTk9oSlhST2wvVWxzZTBVQWtRNmxpVDR3bFBOZDQ0dVRKdHdiSnJ3?=
 =?utf-8?B?LzF0VmJSRy9XZWNoRCtFRDRZRjM5Y0RycUJnUkFJd01SajdBbTRsUXNpVmlD?=
 =?utf-8?B?SWJsa0NvNGFtMXlRUjNWRk9uU1h2NEhHR0dib25aaXRFMWZvbHB6eWJDN3JM?=
 =?utf-8?B?aDNjQXI5MTVGdFYvcjFBQUdVc2o2dHlnVFljSTVCdi9WYTd4UXN6YThhaGhC?=
 =?utf-8?B?dnZhNnFFYXJDTHAyaFYxRTljQmFILzhFZHQ3UlRqTjh3U09ZUUN1M3F2ZkJN?=
 =?utf-8?B?SFZPZHhqK25EYjhQdFlaUVNvLzVsai80NURDNzVUcXRCL2hKVGEzb0xBdEFR?=
 =?utf-8?B?VFpYaGZHYXAwY2xjdWNCYi8yUW80QW03dUQyQmNKaHZKenNObkVXSTk3M0Rr?=
 =?utf-8?B?M2xndXdtbFN0cW1nNXB2NlErdTVaWEZ1Uy9kRnk5WDduMUhFUnYySHBZdmdR?=
 =?utf-8?B?bEhSeWJFd1JzdkNKTWczM05pZTJKTVVYWGYyMmJicEZCU1NQaDlZNDg4YWp3?=
 =?utf-8?B?L2dvTW1JWS9jeEtxYVlQQTcyN2FjWVYrb0dTYlZSUlBDanlTZmZiNEwwTkxo?=
 =?utf-8?B?YUdvbTlyQ3lMTjRVMXFpYVRYKys2UmIvazZqUzlpTnJ5ZVNuMExabFdCWkp4?=
 =?utf-8?B?a1pMQmNzYXVJWktGU1ZVck5qVnNXTDhBbUhlS1VvSHZoQUt6MFl0NGpZT3k4?=
 =?utf-8?B?VmJrQVV1T0NORWpVK1BDNzlqTUZ2bDU4WFdEMmYzVkZJb2Q2TmtROTFYZi91?=
 =?utf-8?B?R2FqR3hWL0MvUGRaNHdBSTNNaVp0TzQwZy84SHcyMjhHR3E4M29uTjA3QUtn?=
 =?utf-8?B?anZQWmlMaE1Pa1hCWUJyZGNmeTRHSzNPSzRNYysyOVllQzU1a2lSNm93THQ2?=
 =?utf-8?B?VTFLZHN3REFzSkgzNmhHZTV3SHNrVmZwcGU3N2k4eG9KZ2JrTmI0eW9iWTJv?=
 =?utf-8?B?TTlNaWk0UkMxR3BjV2RGK3Z3amNhelZLYmpyempwaWs5alFiVjBVM29LRm9l?=
 =?utf-8?B?dVRqaC9ibDBZM3NZVURFRWxkaVUzRmcvanlETkozRVcxZHFJc0RJZWhVTG40?=
 =?utf-8?B?dUlKSFFQUGtsek1yR2svazhaNUFWZUxkS09EUXJTZm5tK0pzc1hkVUdHOHdv?=
 =?utf-8?B?RVJGQ2dSeEJHLzFEZXRFcWVqcHo5dkUxdms3Qm4xeVRNempEYUdKS3NnYmZM?=
 =?utf-8?B?MzNaUnZvMU15L0tXV0pjTFlTZWxoNGx0YUVwc1Z6SGdoR3V2Q0dnaHRDT1lo?=
 =?utf-8?B?WUc0N2tLY241d2NqcHlFVENhVlozZGRaWFpuK1FrbEh4eDRCbUxXRDh4NzVy?=
 =?utf-8?B?d2VzQmFLMEFGZnEwQXZ5VktYS3Jkd0Z5VWlZUDVGUTFNb3RPbm9QOGhpVTh0?=
 =?utf-8?B?MWZTUDdNK3JpRjNianU1Rmw3RDdCVGFaQm80YlBJeDNaS1dVTDNVOWJKTXZG?=
 =?utf-8?B?d2pHb2JjVzdhV2Qwa1NUdWUzdSs4clVIcHErZTAxM2RZZHdOVFkycDV4a0hj?=
 =?utf-8?B?OHc5MjdjdnhZYUd3UnVmdEwwcnoxQVpVektUQ2VsemlVK1ViYVNDdDVzK2xy?=
 =?utf-8?B?V2k4UWExZmhYYlVQY2VYdWp5T2NzOUxUeVBUNU5tdU1LWkdtY3VJN0l3Syts?=
 =?utf-8?B?UlZlMzVxMkFzUGFOQVJSRkRZNzAxSW5kRzBpVmdtcGVYVXYwUUNoVHVmVGN1?=
 =?utf-8?B?K3ZweSswb2wrNzZzbkpyUTRTSU42T0RKQjJRR1dBdDU1UktpcWVvVFNkcmEx?=
 =?utf-8?B?Q1VuZ0tZb2pENlpNblVuVkNwcDFkQWFUald2aTdncm5vcFRXNmxJZkxkK1Z0?=
 =?utf-8?B?RE1xR2lIUytQaXUweGdMYk5qN1JtYmx2ems3QXl4NVJUL3BVQmgwVmlTWWpD?=
 =?utf-8?B?VzhqMjhYeHI1T0hCRVI3SEhROTN6SEJmaWdSVHdsTFUvSDM5bENCc1NnTWZE?=
 =?utf-8?B?dmoyYWlnWGNMdmVoZTdvM2MxWkhYaWJKOWttSHNlWG9uVWx1WUY5Q1huaG9P?=
 =?utf-8?B?U0ZxN0x1ajJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2V3NE5Vck1seEJuejBrOWJqV1kwVnhSejVIVkdzVFlvWlo2bVRxZ3JlTkpY?=
 =?utf-8?B?ekVqeVMvcUNmZ0Y2eHJMaDN2M1B3bkNEaVIzem9NQkFKQ3UvQlVQV2syT0Nl?=
 =?utf-8?B?RkE5SmM4VHRUUXd6bnVqdk9Yd2xGZVRDZ2Iwb1RCWDBCQUI0T2FjcUw4bzlQ?=
 =?utf-8?B?dUpCZEllQWhvQkZnMllqWDFGNnp3Y29GL3VVUFNpU3lycWhUc0ZkRUt3V0M3?=
 =?utf-8?B?QWxMS2VCVCtuWXhyYjJOUFZ4aUc4aW9LWVNUNlFuWnlRT3ZaRnhocm5YMG5l?=
 =?utf-8?B?KzlDb2tTQkxoT0NGT1FGNlNtTk95MkxGZncrSjBGRmpUK3llNS9Vd3doUkpu?=
 =?utf-8?B?LzdTcG0rT3hZd2YrTkFFdTlpSW1za3Zxc3VESktjRFdlWmV0MGpwdHRaNmlu?=
 =?utf-8?B?MnBBbnhCQXhWRyt0eldTd1dveWxGTWVKbE9VNUN2dXZOVE9jQ3R4QmZKbXpv?=
 =?utf-8?B?RTdrK21mM1FXZkhFbGs5SDJzWGszVndZQVpHQ2NwTmdnWkF0Qk41cEd5Vjdz?=
 =?utf-8?B?MnpRMEtJek5OZ2MxaS8ycFM5a3dFVlJKaTYxVUswWkJ5aGJoWDdCQkpNWSt5?=
 =?utf-8?B?VDZFcmFaaHBLRUtPdHVBWVRVb3gzVHpmL0NjazV6eFkxcEg4Vjc1YVlXZU9v?=
 =?utf-8?B?dWpnZkllWlNWSlp0TzUyRUJmbXU4OTRTT0J2ZWRQTWIyT1hSMytwdUhTK0pT?=
 =?utf-8?B?VW1SZVhMTThHVG5KZnE2WGY2QmFuU2IxQmswUHkyTURLQUJ5b2Y2K3UydDQy?=
 =?utf-8?B?dy8rSXNhd1IvSndpbmtJeGNYU1NtZFJYSmJRYWFFNldWK1Z6azFzb2NFNUZt?=
 =?utf-8?B?OUI0RkdUdk9Gc3dnaE8zSHZYOHZ2WjFnNXRSeUpCdFJSUFdWalhqMkpGQTlY?=
 =?utf-8?B?Q0d5N01JTW9ZcWpZeEFUaXBDV01HMjRlaENycDg5ZFNPdTk0eXZUcTVXdWE4?=
 =?utf-8?B?cmtkUWFpREZ2Q0xWV1JvNFJ6c0VPVzZNZGV2Y05aTWJhVUlnZWhxMGtPTitF?=
 =?utf-8?B?NDlTeVhEU1BDKzBiZVR5REdpOUVKeVY4dG0xaThyemZyWEx5REJGbEZ4TnJw?=
 =?utf-8?B?WEwvQWdIV3EyL21RM0lYb0tWK1N6V2RtMXNEZ1RjelJjL0dOZ2QyQVJGUUZZ?=
 =?utf-8?B?b083SU5TZ2xyWFZ0d3FlY2owK3V2WUR0YnRaeWlyeTY4K3drcWR0WGl1bmQr?=
 =?utf-8?B?SmZrNVQzWlZOOTdYZ0dyU1ZISHFtQ0VjbERCWFRWZTBDcmZTUmQ0NWtaRnph?=
 =?utf-8?B?dkhNVHFNS0ZWV0JNRFNheUVtK1NRNFpWdko4bjdaTmExM0pNaEMxOHR4NVV5?=
 =?utf-8?B?SktuWkdhZzFTaU1qUUNNVUlxOURMeXYyRE5IMnFxTEE0R1ljQ0JZVGxudlBR?=
 =?utf-8?B?ZmcrL3gwRlpIdFZ0bk8xWm5LcVQzYU5nQWZFZXNLd051TWhvalV4YWd1RWVN?=
 =?utf-8?B?Yy9rdW9xN2VGQnIya0QrZ2wzQTU2c3hoK1l2UXh0a0JCb2VLTDlhT09ISnpL?=
 =?utf-8?B?TXFEQTBZVFpXNEEvTklMT0hKUit5OU4wMnAvTEp5RlpENnphQXNTNE1VTkww?=
 =?utf-8?B?OWRJKzgxY2FZQk9tNjF2YnpNRVBvQk5Jd2pOYmljcWI4ckVMcHBnUEExWW82?=
 =?utf-8?B?U2dGN1BjR1FKZU1HbEVmdVYyRzZoSHZxZ2RjTEgzZE5URGFOQUNIS2lkZS9q?=
 =?utf-8?B?dzlKOVYySXNmQXFaR0tsWXplbGRYUlFWMmlDRks4R0FmTFNneDlmZHRad2dL?=
 =?utf-8?B?UGE2S0NxdXFUejBqZi8wODdDejhiTTRiT295d3JHb0l3Rkl3YmZ4L080cVBa?=
 =?utf-8?B?amR0NjZvY0VkM0pmc0ZKK3ZSTmVyeTVtd1dxMWUvYWFQSHlOckhjS2ZuOFFy?=
 =?utf-8?B?VndDR1lQVkZYb3JRMVNvY2RhWTdSNXRsTjg0YjFkTUFTbXVLSmRzOHpybGFT?=
 =?utf-8?B?VUx2VTRjbHJBQlc0M2xENVhxT1pmcy9hcHFyb2R3M21QSUo3TURrQXZBQk5V?=
 =?utf-8?B?ZmZjNXowWkE0dng2aHpwQklJZWVYeEtKRkR4NnJ5eGxpQVFHSkVubGZnTG03?=
 =?utf-8?B?NXUyRmN6N2E3MGxYeTNZVy9hV1dqZkRkTGl6ZUlSdXZtOW52VHZZc2NxNnRQ?=
 =?utf-8?Q?eDiL619S+aV0+z3DQrjEu2u6r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11e435a-39f5-4d83-67c5-08dd75aa6d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 08:01:38.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XpNqNBvylnefjmk250MQaWPrIBwgSYBukxWAUDV9qXYdTFaxnfUkbO7a4lsqs8UosTK+J1XeWv374FpMGygZqvUQTT1WOxDgFK8+f4y/Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR03MB8141
X-Proofpoint-GUID: zw0gUJ5WXt5DJTehqtKWleK8dJceMJtr
X-Authority-Analysis: v=2.4 cv=ML5gmNZl c=1 sm=1 tr=0 ts=67f38668 cx=c_pps a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=SFJ3taT5VNwcyxwoHpgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zw0gUJ5WXt5DJTehqtKWleK8dJceMJtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070056

PiA+ICsJZm9yIChpID0gMDsgaSA8IGNoaXBfaW5mby0+bnVtX2NoYW5uZWxzOyBpKyspDQo+ID4g
KwkJc3QtPmNoYW5baV0ucG93ZXJkb3duX21vZGUgPQ0KPiBBRDM1MzBSXzMyS09ITV9QT1dFUkRP
V05fTU9ERTsNCj4gPiArDQo+ID4gKwlzdC0+bGRhY19ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0
aW9uYWwoZGV2LCAibGRhYyIsDQo+IEdQSU9EX09VVF9ISUdIKTsNCj4gPiArCWlmIChJU19FUlIo
c3QtPmxkYWNfZ3BpbykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJS
KHN0LT5sZGFjX2dwaW8pLA0KPiA+ICsJCQkJICAgICAiRmFpbGVkIHRvIGdldCBsZGFjIEdQSU9c
biIpOw0KPiA+ICsNCj4gPiArCWlmIChkZXZpY2VfcHJvcGVydHlfcHJlc2VudChkZXYsICJhZGks
ZG91YmxlLW91dHB1dC1yYW5nZSIpKSB7DQo+IA0KPiBUaGlzIGlzIG5vdCBkb2N1bWVudGVkIGlu
IHRoZSBEVCBiaW5kaW5ncy4NCj4gDQo+IFRoaXMgY291bGQgaW5zdGVhZCBiZSBpbXBsZW1lbnRl
ZCBieSBtYWtpbmcgdGhlIG91dF92b2x0YWdlX3NjYWxlIGF0dHJpYnV0ZQ0KPiB3cml0ZWFibGUu
DQo+IA0KPiBJZiB3ZSByZWFsbHkgZG8gbmVlZCBpdCBpbiB0aGUgZGV2aWNldHJlZSBiZWNhdXNl
IHdlIHdhbnQgdG8gcHJvdGVjdCBhZ2FpbnN0DQo+IHNvbWVvbmUgYWNjaWRlbnRhbGx5IHNldHRp
bmcgaXQgdG9vIGhpZ2gsIHRoZW4gdGhlIHByb3BlcnR5IHNob3VsZCBiZSB0aGUgYWN0dWFsDQo+
IG11bHRpcGxlciB2YWx1ZSB3aXRoIGFuIGVudW0gc3BlY2lmaWVyIG9mIDEsIDIgYW5kIGEgZGVm
YXVsdCBvZiAxIHJhdGhlciB0aGFuIGENCj4gZmxhZyAoZS5nLiBhZGksb3V0cHV0LW11bHRpcGxl
cikuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLiBUaGlzIHNob3VsZCBiZSBhZGkscmFu
Z2UtZG91YmxlLCB3aGljaCBpcyBhbHJlYWR5DQpkb2N1bWVudGVkIGluIHRoZSBEVCBiaW5kaW5n
cyBhbmQgaXMgYWxzbyB1c2VkIGFzIGEgYm9vbGVhbiB0eXBlIGluIG90aGVyIGRyaXZlcnMuDQpJ
IGp1c3QgZm9yZ290IHRvIHVwZGF0ZSBpdCBoZXJlLiBUaGlzIGlzIGEgb25lLWJpdCBjb25maWd1
cmF0aW9uIHRoYXQgZG91YmxlcyB0aGUNCm91dHB1dCByYW5nZSAobXVsdGlwbGllciBvZiAyKS4g
IFNob3VsZCBJIHByb2NlZWQgd2l0aCB0aGUgc3VnZ2VzdGVkIGFwcHJvYWNoPw0KDQo+IA0KPiA+
ICsJCXN0LT5yYW5nZV9tdWx0aXBsaWVyID0gdHJ1ZTsNCj4gPiArDQo+ID4gKwkJcmV0dXJuIHJl
Z21hcF91cGRhdGVfYml0cyhzdC0+cmVnbWFwLA0KPiBBRDM1MzBSX09VVFBVVF9DT05UUk9MXzAs
DQo+ID4gKwkJCQkJICBBRDM1MzBSX09VVFBVVF9DT05UUk9MX01BU0ssDQo+ID4gKw0KPiBGSUVM
RF9QUkVQKEFEMzUzMFJfT1VUUFVUX0NPTlRST0xfTUFTSywgMSkpOw0KPiANCj4gbml0OiBjYW4g
YmUgc2ltcGxpZmllZCB3aXRoIHJlZ21hcF9zZXRfYml0cygpLg0KPiANCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCByZWdtYXBfY29uZmlnIGFkMzUzMHJfcmVnbWFwX2NvbmZpZyA9IHsNCj4gPiArCS5yZWdfYml0
cyA9IDE2LA0KPiA+ICsJLnZhbF9iaXRzID0gOCwNCj4gDQo+IFNob3VsZCBoYXZlIGF0IGxlYXN0
IGEgLm1heF9yZWdpc3Rlci4NCj4gDQo+IC5yZWdfcmVhZCBhbmQgLnJlZ193cml0ZSB0YWJsZXMg
Y2FuIG1ha2UgZGVidWdpbmcgZWFzaWVyIHRvby4NCj4gDQo+ID4gK307DQo+ID4gKw0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGlpb19pbmZvIGFkMzUzMHJfaW5mbyA9IHsNCj4gPiArCS5yZWFk
X3JhdyA9IGFkMzUzMHJfcmVhZF9yYXcsDQo+ID4gKwkud3JpdGVfcmF3ID0gYWQzNTMwcl93cml0
ZV9yYXcsDQo+ID4gKwkuZGVidWdmc19yZWdfYWNjZXNzID0gJmFkMzUzMHJfcmVnX2FjY2VzcywN
Cj4gDQo+IG5pdDogc3R5bGUgaXMgbm90IGNvbnNpc3RlbnQgLSBjYW4gb21pdCAmLg0KPiANCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYWQzNTMwcl9wcm9iZShzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpKSB7DQo+ID4gKwlzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHJlZ3VsYXRvcnNb
XSA9IHsgInZkZCIsICJpb3ZkZCIgfTsNCj4gPiArCWNvbnN0IHN0cnVjdCBhZDM1MzByX2NoaXBf
aW5mbyAqY2hpcF9pbmZvOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnNwaS0+ZGV2Ow0K
PiA+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gPiArCXN0cnVjdCBhZDM1MzByX3N0
YXRlICpzdDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaW5kaW9fZGV2ID0gZGV2bV9p
aW9fZGV2aWNlX2FsbG9jKCZzcGktPmRldiwgc2l6ZW9mKCpzdCkpOw0KPiA+ICsJaWYgKCFpbmRp
b19kZXYpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJc3QgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPiA+ICsNCj4gPiArCXN0LT5yZWdtYXAgPSBkZXZtX3JlZ21hcF9pbml0
X3NwaShzcGksICZhZDM1MzByX3JlZ21hcF9jb25maWcpOw0KPiA+ICsJaWYgKElTX0VSUihzdC0+
cmVnbWFwKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoc3QtPnJl
Z21hcCksDQo+ID4gKwkJCQkgICAgICJGYWlsZWQgdG8gaW5pdCByZWdtYXAiKTsNCj4gPiArDQo+
ID4gKwlyZXQgPSBkZXZtX211dGV4X2luaXQoZGV2LCAmc3QtPmxvY2spOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWNoaXBfaW5mbyA9IHNwaV9nZXRf
ZGV2aWNlX21hdGNoX2RhdGEoc3BpKTsNCj4gPiArCWlmICghY2hpcF9pbmZvKQ0KPiA+ICsJCXJl
dHVybiAtRU5PREVWOw0KPiA+ICsNCj4gPiArCXN0LT5jaGlwX2luZm8gPSBjaGlwX2luZm87DQo+
IA0KPiBuaXQ6IGxvY2FsIHZhcmlhYmxlIGlzbid0IHRoYXQgdXNlZnVsIHNpbmNlIHN0LT5jaGlw
X2luZm8gaXMgc2hvcnQgZW5vdWdoLg0KPiANCj4gPiArDQo+ID4gKwlyZXQgPSBhZDM1MzByX3Nl
dHVwKHN0KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gDQo+IFNldHRp
bmcgdXAgdGhlIGNoaXAgYmVmb3JlIHR1cm5pbmcgb24gcG93ZXIgd291bGQgbm90IHdvcmsgd2Vs
bCBpZiB0aGUNCj4gcmVndWxhdG9ycyBhcmUgYWN0dWFsbHkgY29udHJvbGxlZC4gOi0pDQo+IA0K
PiA+ICsNCj4gPiArCXJldCA9IGRldm1fcmVndWxhdG9yX2J1bGtfZ2V0X2VuYWJsZShkZXYsIEFS
UkFZX1NJWkUocmVndWxhdG9ycyksDQo+ID4gKwkJCQkJICAgICByZWd1bGF0b3JzKTsNCj4gPiAr
CWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQg
dG8gZW5hYmxlDQo+IHJlZ3VsYXRvcnNcbiIpOw0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fcmVn
dWxhdG9yX2dldF9lbmFibGVfcmVhZF92b2x0YWdlKGRldiwgInJlZiIpOw0KPiA+ICsJaWYgKHJl
dCA8IDAgJiYgcmV0ICE9IC1FTk9ERVYpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
KwlpZiAoY2hpcF9pbmZvLT5pbnRlcm5hbF9yZWZfc3VwcG9ydCAmJiByZXQgPT0gLUVOT0RFVikg
ew0KPiA+ICsJCS8qIEludGVybmFsIHJlZmVyZW5jZS4gKi8NCj4gPiArCQlyZXQgPSByZWdtYXBf
dXBkYXRlX2JpdHMoc3QtPnJlZ21hcCwNCj4gQUQzNTMwUl9SRUZFUkVOQ0VfQ09OVFJPTF8wLA0K
PiA+ICsNCj4gQUQzNTMwUl9SRUZFUkVOQ0VfQ09OVFJPTF9NQVNLLA0KPiA+ICsNCj4gRklFTERf
UFJFUChBRDM1MzBSX1JFRkVSRU5DRV9DT05UUk9MX01BU0ssIDEpKTsNCj4gPiArCQlpZiAocmV0
KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCQlzdC0+dnJlZl9tdiA9IHN0LT5y
YW5nZV9tdWx0aXBsaWVyID8NCj4gPiArCQkJICAgICAgMiAqIEFEMzUzMFJfSU5URVJOQUxfVlJF
Rl9NViA6DQo+ID4gKwkJCSAgICAgIEFEMzUzMFJfSU5URVJOQUxfVlJFRl9NVjsNCj4gPiArCX0g
ZWxzZSB7DQo+ID4gKwkJc3QtPnZyZWZfbXYgPSBzdC0+cmFuZ2VfbXVsdGlwbGllciA/IDIgKiBy
ZXQgLyAxMDAwIDogcmV0IC8gMTAwMDsNCj4gDQo+IHJldCBjYW4gYmUgLUVOT0RFViBoZXJlIGlm
ICFjaGlwX2luZm8tPmludGVybmFsX3JlZl9zdXBwb3J0DQo+IA0KPiA+ICsJfT4gKw0KPiA+ICsJ
aW5kaW9fZGV2LT5uYW1lID0gY2hpcF9pbmZvLT5uYW1lOw0KPiA+ICsJaW5kaW9fZGV2LT5pbmZv
ID0gJmFkMzUzMHJfaW5mbzsNCj4gPiArCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1Rf
TU9ERTsNCj4gPiArCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBjaGlwX2luZm8tPmNoYW5uZWxzOw0K
PiA+ICsJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBjaGlwX2luZm8tPm51bV9jaGFubmVsczsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKCZzcGktPmRldiwg
aW5kaW9fZGV2KTsgfQ0KPiA+ICsNCg==

