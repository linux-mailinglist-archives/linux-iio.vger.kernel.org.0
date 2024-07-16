Return-Path: <linux-iio+bounces-7630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15D931EE8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B561F2284C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAD6AB9;
	Tue, 16 Jul 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g+wm0+C3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206410A03;
	Tue, 16 Jul 2024 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097163; cv=fail; b=euH1RROsFu05NYoucC/aPAYZ4Yc9b8eQV/rsdG9YA/eVwDdiV0O3ooenzKDKaVyKa8scPW6iVrqVB+K3YbXfHyjyE9C3hQjOUnHsUlNYbagY8MHRv+TFZrgaENTN5pgza5YZzlpB2JxK6DSSBAmYpQn0nIlYQSh4PGvqe1Npifc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097163; c=relaxed/simple;
	bh=u776RhUBMVMjYy3OwPZYfYpf2RIH6SLNlKBRjHdEcgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QyejwcSgjmk86hB1msrCB/E2bYB4tkf7xosU+83zWDKh3kOLJPE5kJ2bqYM1j1f6POuZ+3EZ0w8KxtvyIKyrOpiB9prnk4D2+hbEzJJyeYIUmNxAHqz0x/Pl3fq7NxX6zIIvsqsedG+b8dzmzbuCSkBQ31IEsaAZK1XjerhisDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g+wm0+C3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FIFN87026007;
	Mon, 15 Jul 2024 21:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u776R
	hUBMVMjYy3OwPZYfYpf2RIH6SLNlKBRjHdEcgk=; b=g+wm0+C3hLGxHJI1Uhpps
	6M19ivzHed6lwInoLk6sD1kz5yla6LzHl+k8OpYwcextUDvTLJP4Iiw0QfmSO3SK
	CHKALFXeC5bs509iwhRx0ydQ8SapDf5T2NJe7GGUvi7eLxV3khIZ85VKNgm4LyWj
	y81EkLbSyP4anW2biKl1nljdtvtoon6n0IJRfJsQ5+oqORbGGoEraZhNx/+RcE7j
	U++NceGtzNO4Vvss/ih1m+CY2UzTYEPIJDaE591Oq32tc3igVzvJCWbNsy6MFOPt
	yAno4rQ/VXR4Y8LSLA74PSYB/aZKXqQ6FCuvybPrBR6OGTlyS7Fjrs+vFKAwjR/E
	g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40bp74ybe4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 21:50:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6vNIPRjGlEyEumg+U705pXNnMm4heK0tX8lfQLzmM+U++yDVoDiB4ja3qlDgWr5mXYiAVDh45fMS0ZL97SNysFNaSmR4DQPjNrtisp7ChoL0Y0g343ubts6DzgCOX2PL9nf0KD9KrlDAEhlMZd9ixB6GeAMdEug8/I8CVh6h7/vxvxV0l+a39Vm5uVrGGtx6LfM3/aleoSKrPGWjFNMvLamMVDVUYtW6vMGYTVQMxN1tWeSNloZGkyApQIS8SrqsT7FwkE/n4yHcYdp8P8H2Hs5r93diXArwTBj3pGqEmEvNy9Ox0+R+0uQpbtfdjWV3VGVegbbRX/k5pJbOifzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u776RhUBMVMjYy3OwPZYfYpf2RIH6SLNlKBRjHdEcgk=;
 b=Uy/5uc+Gah3Y1Wr5k5lWDJ4iH6UT8mRks7a0+J+NSNZrPS5JjxoKYQYTVuiSi0PrPHZAKSHRF6BOiluX4C+WNk6mePK49IdcQ2CUF3uRPBk3K44jJy2Z320yRX1sDGUWI/NXSCAKJxorMbJKqjsQMNtTukQbkZ2xYtWf9Oq2smbGcKsHR92zvOB1omev27wdYvHPhO84KLKcoZfha5VwLsBDjEcQ5e50jBaeAF21SQr1TBGm1/mdZvtroTbxRETsaexUBIuRPxN4cNKBCM0VV92WJ2PJjatG3sy6e4FCm61VYMdDSpG02K/x18UNaOzA/5k/Kyh3KBHPsa6tpD5hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH0PR03MB6001.namprd03.prod.outlook.com (2603:10b6:610:e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 01:50:23 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 01:50:23 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHa1fIKypoGO0+cUUGRLiCsvbmNpLH3+UYAgACfTOA=
Date: Tue, 16 Jul 2024 01:50:23 +0000
Message-ID: 
 <PH0PR03MB7141E98ECA32AF462D3AFF15F9A22@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
 <20240714133000.5866-5-kimseer.paller@analog.com>
 <20240715-numbness-chooser-d1bcb0438ba5@spud>
In-Reply-To: <20240715-numbness-chooser-d1bcb0438ba5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMTczZDY5Ni00MzE1LTExZWYtYWFmOC?=
 =?iso-8859-1?Q?1iN2I2MDBmNjM3NDlcYW1lLXRlc3RcYzE3M2Q2OTgtNDMxNS0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjgtYjdiNjAwZjYzNzQ5Ym9keS50eHQiIHN6PSIyOTY2IiB0PSIxMzM2NT?=
 =?iso-8859-1?Q?U2ODIyMTE1NTcxODQiIGg9ImtjWXZUbUdTeTgzQ3ZRR2tpejQxS3c1S3gx?=
 =?iso-8859-1?Q?VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQkFyMjZFSXRmYUFTbG8rencxUjh1REtXajdQRFZIeTRN?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH0PR03MB6001:EE_
x-ms-office365-filtering-correlation-id: b78af592-b6d9-4ddf-9c31-08dca539a880
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?3hlVdKzQcOJypYcBUakQ+58mN+QIhYjQxuvft3NZgxD4fOOAr/HB8KBAZZ?=
 =?iso-8859-1?Q?NPjvaQD4GH8ifRoISc6QRfOStMHAv+5Hn7J4xwR7/U0/NJJMR8VkFVtS0J?=
 =?iso-8859-1?Q?Z9+lzJUngKrh5u/e2kB+eJlPY7RaPNRWVRHYLXonoJLLimoujAWsT9zfsb?=
 =?iso-8859-1?Q?SzH0Zpv9fTIZl5pL8auQn71PotKLZvHsfDnsi/cHj+bWRGUGXzkOGwLltf?=
 =?iso-8859-1?Q?jSxYxM+llceLiWeZuki+a0iPjTHbDjwd1xDFyHBbikRUxQc36Y76dYb26r?=
 =?iso-8859-1?Q?UJQbJfLF1EBZDVcGWVQ1C09iAal1Qv8sN2weJwyICuw+SvjAn8/EBdTPcx?=
 =?iso-8859-1?Q?i74ZBKc3lsQuNfesZjUj/5PdGExvk/ojXPCKIaK7mKMKKe6YxFasAt1xBz?=
 =?iso-8859-1?Q?Z8KKXykGNpAYTQGSyMZSTUx/PTAFxbwhmHMak8bBzymXnlVx/SttDCdxFh?=
 =?iso-8859-1?Q?ovk23U4kbBPNvOu/AwFO19a4QspS92h6oAMMU5UV1ze2GhPDnRUuvHwu61?=
 =?iso-8859-1?Q?pSLvee5U3M5NEwRv/689NCJTzloyrzJa74U0dEgvLgQui+G9S0KWn71bRt?=
 =?iso-8859-1?Q?Sdd/SCAlpaGsEp0bUrWFMs8XlpOyW78uGuoLvPBQx6CRiHv67TPtGWiPdI?=
 =?iso-8859-1?Q?4xdQ6mzyl/6rPpLq0t+PO70qsY+I0edbPuiE3rFadiNrx8fRjNhS2LvhU0?=
 =?iso-8859-1?Q?3SlFcAHiukHUihyzoqLebsW/DYufFmSFty/7T99gFPPoWhZjP4KXJVSNi8?=
 =?iso-8859-1?Q?zSsBVlKmKHzGDH15YQeb6vh+w/zcMtogYVFlk0hro7cmyJLqXjjfNwK99p?=
 =?iso-8859-1?Q?mK5SW++Gm7Z5TawavM8MRkJN0GH+ZSZiTwQvMtnZ32Hmoqu4Oqz1P+1Eyl?=
 =?iso-8859-1?Q?LFWr+Jdut8FxytjJqgXNspoMyl/lBM5gpBVPWoNNxiYgg4FLFLvxpHGK6Z?=
 =?iso-8859-1?Q?L5+OxeBisDttYK/1lYdhbC1Nbscl0rmx9JOr6cZeICDmnwcpAYIzRAJcRI?=
 =?iso-8859-1?Q?unF1VWk5gd1vz1tb4nkpiW/zO1pzunNMCTTgWS8WB07KhBPuNMrq8CIehs?=
 =?iso-8859-1?Q?nxe43ZV4TjjuzzdValnt9RjKIVNBixaV5/k3eIz9mKKi2nwQkABwsTLOl8?=
 =?iso-8859-1?Q?Mg7FTq+8xKVC1I1YT6tbTZkJJWK2hpbSfXvrY65TfWniMSIpnLA44iepZs?=
 =?iso-8859-1?Q?WJpaa//5xtyp9SfdxrpjIQ1jBOg0AIwfjci+FE+SDaJkAtOsL0U4yMIwRv?=
 =?iso-8859-1?Q?s4ffYgTBykUycHmTKZFCskeOn2jnA4jxq4+TvBhU5IVadoqWg/W7NOQPmJ?=
 =?iso-8859-1?Q?eL+MIn7twRRfCqJVH0yyGXY9CaSmaWVq4u2j5rpVXJpa7DmD6D7fg1dNF6?=
 =?iso-8859-1?Q?0P1oq5D0H3fOOxJAeMe7ErfOdFIC6wqvsq4K1nvs0n6gVrtC0M9XFYkJh/?=
 =?iso-8859-1?Q?1AmA8xvcpkt+4OpAQYlYA3qG+1bd0kIcAi7cKQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?WXmwFHr7BG5Y92d0EyF4rRDC9oarKlQIZs22g8IctXkjAZrdQ2Lzm+Fv1e?=
 =?iso-8859-1?Q?cqurs5PB9Z2FYp3FAr4UddhEylznWly9ByjIhSP13kWyFuF8kFulEJKD8k?=
 =?iso-8859-1?Q?TLfG8x7XcAJ1FTcbANkvpt8Uh1RxUuD+AhlQlPUZQKGJODtyCIweOWYvCt?=
 =?iso-8859-1?Q?0NFChKn1LX8Khl2wCgcUZ70jEF32a10CXRzKSbH3yUKMzPUWsYr+YoioGi?=
 =?iso-8859-1?Q?g6EsJNKqeKSNpHVfqfidc3/QWVhxuJhmtS+Ub19h2r95bqvkiq5cpUcpfj?=
 =?iso-8859-1?Q?ZZAwRAUU0VoMRQm45mZ4YrsoPudPln9xpjYCORL6lA2fDY6T3Gqgz4HdV7?=
 =?iso-8859-1?Q?zztM/2ZqigF+cbCHNOzK6WuO4wMEgXM3Y4GJRI9Q7FsScdDnBMsM/tW5Pt?=
 =?iso-8859-1?Q?8TIAz7/Z56GOpX7+tP4JFJOi2NJ42i462Yaf8C1u8KPogsOOgoU9EBhd3x?=
 =?iso-8859-1?Q?hGTTXjrIUweRk1mafzftAgUozg7V7V1Jv8rGqMxmpTj8x7rrfj9nwENvpU?=
 =?iso-8859-1?Q?eidIKyHA5MJHPmVJkjUDyjQbxFWAgDhARCr+z2tGD43AgQo27mlZ2Vp7+/?=
 =?iso-8859-1?Q?E8m5An/9LB0CJeJZCnoJDMnJxMhAEUhVqer+xiCnCgJuqmrf3M+kkS86h2?=
 =?iso-8859-1?Q?cZsKjjjw9yzCpTRCgZSmTr2eBZx+aK59CcePSsZU9/Qjc3wv52J56JDdEe?=
 =?iso-8859-1?Q?N1kOck0NKwvJ+X/tD05djn+hCz0gIoCxdKMJj1DDoAppei6gJpchOz+0Jr?=
 =?iso-8859-1?Q?q9razrT34CkfsULZisk3I5AyDerBQP0l0Px/OsJ1Kl8lpdwenVOMXZRs70?=
 =?iso-8859-1?Q?MAyNk0pc58VCIEJU6hPfIDjLDqzq7H9YLTth/ptUJCAhnZ44wOCusfgaey?=
 =?iso-8859-1?Q?gmLv0ExxkKuUiOTJ88wBs+swUraGrSd95VuhpAMfZ//Oi+vqA05Vn9Gd8d?=
 =?iso-8859-1?Q?uKuIByKOJ/pKECduVMU990e5yFeSCPynUzha4Q8k80W4v8hgOf5+vGOKGf?=
 =?iso-8859-1?Q?j5BxWgszSJpn4EKfQAuthg922JjiqmsRUBUTnibggfL4aP8O7QQXWDK6QK?=
 =?iso-8859-1?Q?aALMTAUy9yjkRU32+Ii2N5SoPFnKnD8NWKqg7a9ulpYdBcIGjj3tuaaU4K?=
 =?iso-8859-1?Q?oRa7aMZGEK1l0a3neyg3XcGL7HCJyNuWipys3UrD9swMyx9w1bgHI5aZaM?=
 =?iso-8859-1?Q?HYpk9wQtY4HXFEiHbOcMr2BPbS8ZoF8HL2WQ57HhaHPW9BX5Mkovbv8EkR?=
 =?iso-8859-1?Q?saeKQGrc2J1512wEzwTtbbcQBMT2EYszHtA72immSkoRU9szHBhlyYoIf2?=
 =?iso-8859-1?Q?bsAl3JJ/Y+qWZWWOlu/8fsTButZ8KifNwA2+UY0zmixPYfema1N+50ZN/h?=
 =?iso-8859-1?Q?/T0OQxv8YCRzEbGNqGjO2fK25dbwYJpPBUpEcK1IfBrnukXt1ARTBp8FH+?=
 =?iso-8859-1?Q?hBI0lbKbP7oXGRAu6r8IIpQP29QK24s1/Z8t8JKmYv/BinVkDFWOfzMjCM?=
 =?iso-8859-1?Q?VbXRRnQlVQ/yiYepK4iuamf9Mrnk9TWff4OjONDYkJ7L/E9u09mm2vLAlT?=
 =?iso-8859-1?Q?EAy8tLGnRQYcGTSBbtTrrIxPmxOAeCpt5wbt9h/jTd6+5MvGVe7M9TuMvB?=
 =?iso-8859-1?Q?Le7/cO9CtTGxWqJO3DPvcJ8pHyRB34N8sU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78af592-b6d9-4ddf-9c31-08dca539a880
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 01:50:23.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSUoRnMAUVAwZreo1BoCIziuryqKgj7g74/0uN+StBY3qncS1gtCJzubY8DoBkrftVk6gC3tMIInZ4phr1tqqIn7FwWSm78JcVrmevz8D6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6001
X-Proofpoint-GUID: sVDBzCx3nl-sGJ7BzYnBlZlRy4TaxQjO
X-Proofpoint-ORIG-GUID: sVDBzCx3nl-sGJ7BzYnBlZlRy4TaxQjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407160012



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, July 16, 2024 12:18 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
>=20
> [External]
>=20
> On Sun, Jul 14, 2024 at 09:29:58PM +0800, Kim Seer Paller wrote:
> > Add documentation for ltc2664.
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>=20
> IIRC I gave you a reviewed-by on v5, was there a particular reason you di=
dn't
> add it?

I made changes to the 'output-range-microvolt' logic in v6, which I thought
might require a new review. If your 'Reviewed-by' tag still applies, please=
 let me know.

Thanks,
Kim

