Return-Path: <linux-iio+bounces-6815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA59151C8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B702885BD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07219B3DA;
	Mon, 24 Jun 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RH1qf/pO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CD19CCE0;
	Mon, 24 Jun 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242059; cv=fail; b=WY9wjvwRGfiTsrPQWPtyGUvj6j19T0+5TQlNcDPNp5yVuSBXViK1ofP54g35KWbGZB1wPvppl38O3NJTkLPIsZ7j5vopbEjE6jjXJcEBz1hOk1xataJinksKNBePk5THdKrj+3o++Qrt5X9cgF5ZGDPtfFAwN7QLkKD+oWI6U4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242059; c=relaxed/simple;
	bh=1PDZkPvADtpJgk/r7g7zEx/nBQKIfWKPn2UgBVLZOMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BtxsdTKV+IfkPobMhDp7UQF6JAEhSbKxnIXsbmeyhKfFJE1ZrrFSf1j91S9j09uq9y0OSEheP5nDn881QYqovfOhlMJYROZMkjOAi/EWcJ342ilY6g/t9MkX5HwInNOIghOtznqcx/417m9dHGm79bF2OJsdExLqGIuDn55NL9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RH1qf/pO; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OF3Q9O003144;
	Mon, 24 Jun 2024 11:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SYpep
	He6OGk4P9jtlYgCODE7+yiZRU40fiUJss8AIYk=; b=RH1qf/pO+ApKRV0OdZguN
	gyogJntXQlSwTTdHmSrKZ9W0KRsxeaGaLw9hCYii0Vr1pCHHLw+ySkB7yQSFseF7
	qyNV+XN3SyxlMKEWXXDQcTpBaoeAHn5YmfS7aTFhufyk1pBOnyK4BhpWuBoch9Oq
	9AmOyvbG78JQv0HbGnQw7Lr3W/2obHv0XrZilMFTwsy4+ccBYs5hztI8MbK6hVir
	61sexIXMCUJYtVz7fgrvF92OiiTnO6HxyqejMBpTMt4mDMM6Snz29mPEX7UMFPxH
	oTHrqGQAjHD1dAT1RJqib1XHab858lnCtJ/hUa8Bzzo9hbe1DqmKv8lQE3uTk7s6
	Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ywu84x0bj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 11:14:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTQcl9E0VfsYkf0Kcv75pazqUlIGH5c21c7w8hhkes2mbGU8RG0o9hXuH4o1jzyTFlZzZNeVRtQhda35K4/2/xu0sN+6bQ/AJ4MBTrbTpVIijl/F2px3rsJLQ9VTOt1zmvuha5b576EtyzN6xYVK1RZ0l/BK65PKXzGMj72bDz4JO/ALeMPdWxYQYLgccVR8yOSDpilrATQmqd0lyNwY8lITMCGDzQ0KbnxotsXRiCmcrqMxh7nw/Ay/N9ACAm+cwSaHuIK+kuEiEHv8Dnl4bWhfPKo4xVrTgRAMhIrHyNwD/7+74a0RxrpgTS17Jw2nKPJYEX1lDlZrk4lGO9XQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYpepHe6OGk4P9jtlYgCODE7+yiZRU40fiUJss8AIYk=;
 b=RNkXCi7kpEowTy4w5SJdq47FVxZGqdhuse7sFKWGcw7bbdFlJFebwhlv7gcN67p+8d0avKCfZYBmoErkPrzrCL99Js4S9iPS5aMqVAWeqEZMVq/HWm4CMywHZ7LKlkUdk31avMoUAGrckJkZpx3pAJcsEzqJX6sSQMjYhJXvUDtJK+l75yC1mXtb92f5r5zPYmJKth8+t3+l3btJ1DYgDXC5WixljHOEHrIJOLnEz3Hx8g9wNdJag2mjF/mG0UdgSIOKjuarqcG9Y+HLlRYbRb7JSXwrzqVS0Rd6EtPR9H3ocZLINPRF6Xw9kxfN8Ug55C45xNY1aNdiUVq37bS+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH0PR03MB6065.namprd03.prod.outlook.com (2603:10b6:610:bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 15:13:56 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:13:56 +0000
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
Subject: RE: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHawhTjPN73V4dX9kiEjAqlsQvQP7HPX+QAgAepP/A=
Date: Mon, 24 Jun 2024 15:13:56 +0000
Message-ID: 
 <PH0PR03MB7141FB5DFBCA46C727FA9605F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-4-kimseer.paller@analog.com>
 <20240619-left-usable-316cbe62468a@spud>
In-Reply-To: <20240619-left-usable-316cbe62468a@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy01ZDg0Y2E1ZS0zMjNjLTExZWYtYWFmNS?=
 =?iso-8859-1?Q?1mOGU0M2IzM2Q2NmVcYW1lLXRlc3RcNWQ4NGNhNjAtMzIzYy0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjUtZjhlNDNiMzNkNjZlYm9keS50eHQiIHN6PSIxNzI0NiIgdD0iMTMzNj?=
 =?iso-8859-1?Q?M3MTU2MzM2NDI3Njk1IiBoPSJoWjNDazFUc1Z1aVlJaFlxcDhqamcwK0Fs?=
 =?iso-8859-1?Q?SUU9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-1?Q?ZOQ2dVQUFFb0NBQUN2NGprZ1NjYmFBZC9lTklIc1dkNmMzOTQwZ2V4WjNw?=
 =?iso-8859-1?Q?d0RBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeU?=
 =?iso-8859-1?Q?FHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1B?=
 =?iso-8859-1?Q?YVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-1?Q?FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFH?=
 =?iso-8859-1?Q?VUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJr?=
 =?iso-8859-1?Q?QUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUU?=
 =?iso-8859-1?Q?Fjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D?=
 =?iso-8859-1?Q?=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH0PR03MB6065:EE_
x-ms-office365-filtering-correlation-id: 41f13b6b-b1dc-4799-b98b-08dc94604460
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|376011|7416011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?m1ApqlZULzR7byvzactnngaoja14cnoySWMzHNxkoeLx3aeroJERYwo6m+?=
 =?iso-8859-1?Q?zkN9OqMqk/ACutwVVn2Td+f1Nb+p+AWCjWw04+mGnoPgIJr462zHbxuyWP?=
 =?iso-8859-1?Q?3eFOmJkencpbThy75OAUqk3vB9lvSKST5r35de541N1kb8y4ULwcvgoR91?=
 =?iso-8859-1?Q?OPgoqBFOl5BpUOAntW3rO3mLu8v/N9DPLSKrO6/G7Pweny3KKBK3Z6020b?=
 =?iso-8859-1?Q?MrnEL3Rci5w69uqRCURrjqoQKFh5sNDTHI1hrUE4Rh/YT22m+kwdcOGK8r?=
 =?iso-8859-1?Q?Dj6rhXmfxQ0EvccoqZ2TMLiwmWF5r7JUe/p2TMmEwjJRZjGHFZ6IQ/GXYy?=
 =?iso-8859-1?Q?9lt+5FJFYxUG4rADb/54sUiYxfmKxyyTPJdxcWnr/JCvMoCS7Pr76+3C/2?=
 =?iso-8859-1?Q?rluPL0H2K+K4HVX3KYSGo6NwAQPW9am19+J5ZKS22awnR2IM+jXK/mdaVh?=
 =?iso-8859-1?Q?NlzP8AhNfsA1NPxTTTLomhggTzzwGPdsR7dopWQuFfSP99nFLC6S9dX8Lg?=
 =?iso-8859-1?Q?Tw5UZLL0qW2oCfZMAjHRyWdahKRCC50psWg/4rqz4+37aPBswqQZufY5S3?=
 =?iso-8859-1?Q?RRtBZnFAfYodtqHDZgDl5YRCTifZ4S5slLajBRE8Ts+wa3rIRvPnqsy8tX?=
 =?iso-8859-1?Q?G3O7/8bYetl+1QCEv8Uo16Ebcc/fqaDmijZX+PdsFDY1jYZKXslSj7J4cL?=
 =?iso-8859-1?Q?tTNb/P3wUs2tEMJgmAQ3yptclHHG6ehIC0MKfZf11LxMlVD/2l/YipeW76?=
 =?iso-8859-1?Q?E4obl+RwcYxOxdota2Y62AuFFYbSv91vECV1tXv3Uvusens8oR7PmZ/RVw?=
 =?iso-8859-1?Q?s9zLYtH+Wn2QTOjDhTEd9kZ/QH275IgeAb0ZfNXsBG5YAtmQyuYgogFY/4?=
 =?iso-8859-1?Q?1zS8+1jBsVpinlLorOEWQ1+Q9pBR1hyd6HN7pGawGM2AO0gP6phv1ncPLj?=
 =?iso-8859-1?Q?SlQVmgebeg5027EcCoIFpmfdeXaw+SuIkhsBuRK4NNrAVKV7tzkAeHsVUF?=
 =?iso-8859-1?Q?VRMccBCzOGJW4xqNx/n0Avr+VAYedPBb2u80/uQ4uFn4Xca3MozvFQHmfO?=
 =?iso-8859-1?Q?QjtG64doeoZSGsSWlqRXjofSE99v+Aw0fmBygg8KeL0XhJW1W8MFGop4Cc?=
 =?iso-8859-1?Q?3bFoiSYLaWHR9LzoxiR746mq3ZEgInVJ68Djcz0bglwr4wLgwt+wAUc35W?=
 =?iso-8859-1?Q?n3U2Lt+L1A8u4vGha2CGflWONLq7iKT9prs7bqhVeYmOAxVSqaTQaWrBMA?=
 =?iso-8859-1?Q?vGlLXC+5XUL9tW44ntFpLN3oHDMbceYyyRPxvgYjbl4I84rpbqkg6XhKa8?=
 =?iso-8859-1?Q?4N7JQWoTNiGqIumDpCCarchI6ax6bLo04jghXCyemXW3N1Gristz0tyG1t?=
 =?iso-8859-1?Q?HUJ3SrZPyw?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?rVUz2ywKZfRWSHOoSQd77PKtGx3Ecp2WvpfCSCUCAFfx4NSKXhoy1OK9CU?=
 =?iso-8859-1?Q?MthjpfpOp5PtyGum99eeqjy05asgJdnqhj67yqQ7tO/OVGJ2nVJ0UmQx4v?=
 =?iso-8859-1?Q?OrU6i+ZEthgl5p87PdLyoYRrvyziVRf1/8YSsp0yjaShUFxmTaBQ3JNF4f?=
 =?iso-8859-1?Q?HKr6eL51ze/Sqs3ZzN8QEtzDE+eClV4P0UAXEG7rQwm/52B6Ac4cnlojRD?=
 =?iso-8859-1?Q?mwo+X4JrNrRFMuAmNfFq6E7sS7ogfTr0Gpx7DYazUZMYeTwaX+gFjUpP9B?=
 =?iso-8859-1?Q?+3sBGEZg6y1/yFqlygVqMiegZgivICMY5TUhRi+3ZFgbkSKelBAL69IDQD?=
 =?iso-8859-1?Q?d71KkrqdvyCyajGhIndsCSmTp8De5i0zKJPK/Q1/yhA926Lq37s8bdjc7C?=
 =?iso-8859-1?Q?OoFCGlnLTSriYg35eMihpYo7VC1iLG6ROskb97RpRxZ5Ey11wGZbLhAZTk?=
 =?iso-8859-1?Q?lXjA5OyYMWlBN/sbUgpEsX8FOaKgfvswFXGEcPxpcMLD0xdAxLAWBFiE5c?=
 =?iso-8859-1?Q?4iqahTq/H7m3cyup6clC2rf92sMPX+j0QCd5kGc0MmZg4j2tOUsm+55Hw/?=
 =?iso-8859-1?Q?k4hAvqf5sjBiBbmDIJlAY3YjpOALMtqxx1fYswmm40hiBBojQHtPT/FuBM?=
 =?iso-8859-1?Q?IBP5tLe2XLA83U75XwfBtghsEdjSwW6yALcgysw7oRRowYMh8MnN+Zu5IQ?=
 =?iso-8859-1?Q?ifqHNyshxvvw6nUwhIkQeKihj16v1cYznEyobtLYKQx8ceayfa9Fk49uKW?=
 =?iso-8859-1?Q?u71qtAyi+5AaMKO9ICm8A4nxc94NXHL5+b8Wm8ENPEIx90Anwyfi76ORVJ?=
 =?iso-8859-1?Q?QwX2UqrcNmTeWA2FwtCQtpKkBdLbkRo9RGt4YIVctOthzKkyKUUbc0V69l?=
 =?iso-8859-1?Q?AWoqV1eJnNnMy7Id3dXCvhkRGzugVL/4ZFoP1ZH1nzWA0J1G+FjnDSH+Fj?=
 =?iso-8859-1?Q?jzPHyTXdCnyP6wRneL3CjbOnVzUh5fAtowZSaIY11PbtlLHDLtWV0HSSQ5?=
 =?iso-8859-1?Q?WP4GmfYV/EYBZVxduPLVQoAoU1NkdZgeZqC9Y/I5GNPzbKVytD3knBWznJ?=
 =?iso-8859-1?Q?kzTUUwHi7TGcCunsbzZRtkfw0EPByFQFQvOk+3HgW4T41jvUKqSl0XXJE/?=
 =?iso-8859-1?Q?mY6bXq6i/5zIUERqrXkE1+p+Y4q44POm6ozNkD0A1TNm3QYhHvKh3soR+o?=
 =?iso-8859-1?Q?zD4VZL3h1Q0qJn9/3DjX/4Ji5FgCwCvkCRr82ufQ29qDqd6K70GIDjRXD3?=
 =?iso-8859-1?Q?XUz7ms+2eTV5D9OvB2Nt7fEKY87gKrGATaEltScMDCFR5Y+e7qfKJYl7Pz?=
 =?iso-8859-1?Q?5XMgewJvmK9XehidfMRnHNJDNLSQa0OTpAWqW4IkGa9Lzw64kp9GYEw/pH?=
 =?iso-8859-1?Q?Ae8sIRwapghzGGVj+NvH9OjtFVUxzYzfPV8RAO1prjpECmVttz3GzThJ1o?=
 =?iso-8859-1?Q?hdNEExJ9+fQkVt4JqLCJmLtMCCiqwLBuQnjQOtW9b3n7oqoxO1QKhscoXR?=
 =?iso-8859-1?Q?oTN2udWcWk7dL+4u376lbTtrQomwZgZpbf8GnL4CgEKihCKFMBsxlOyQbb?=
 =?iso-8859-1?Q?sylEpOFhJ3FNJqVWplMLZPdzkSKv/V9A3brbiIkeaQ0r3hnibEdD4Ps0kj?=
 =?iso-8859-1?Q?OxcTVL7YXQL+CuafvHwR0fFelHSENf9Xii?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f13b6b-b1dc-4799-b98b-08dc94604460
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 15:13:56.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvGGL+Nna3xMqZQ8Un9euZJRP4tM4cVCTAocwqvZk4xT3Hl0W9HZRTL4NI+YGresAmQu+1SALqehixi0HbLHf9+t1L9+f3I2skPIrWt4Qc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6065
X-Proofpoint-GUID: 7VWwzDrg2yymq7RAER0KUewuLMJl13cy
X-Proofpoint-ORIG-GUID: 7VWwzDrg2yymq7RAER0KUewuLMJl13cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240122



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, June 20, 2024 1:57 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
>=20
> [External]
>=20
> On Wed, Jun 19, 2024 at 02:49:02PM +0800, Kim Seer Paller wrote:
> > Add documentation for ltc2664.
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../bindings/iio/dac/adi,ltc2664.yaml         | 167 ++++++++++++++++++
> >  MAINTAINERS                                   |   8 +
> >  2 files changed, 175 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > new file mode 100644
> > index 000000000000..be37700e3b1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > @@ -0,0 +1,167 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2664 DAC
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2664 4 channel, 12-/16-Bit, +-10V DAC
> > +
> > +https://www.analog.com/media/en/technical-documentation/data-sheets/2
> > +664fa.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ltc2664
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 50000000
> > +
> > +  vcc-supply:
> > +    description: Analog Supply Voltage Input.
> > +
> > +  v-pos-supply:
> > +    description: Positive Supply Voltage Input.
> > +
> > +  v-neg-supply:
> > +    description: Negative Supply Voltage Input.
> > +
> > +  iovcc-supply:
> > +    description: Digital Input/Output Supply Voltage.
> > +
> > +  ref-supply:
> > +    description:
> > +      Reference Input/Output. The voltage at the REF pin sets the full=
-scale
> > +      range of all channels. If not provided the internal reference is=
 used and
> > +      also provided on the VREF pin.
> > +
> > +  reset-gpios:
> > +    description:
> > +      Active-low Asynchronous Clear Input. A logic low at this level-t=
riggered
> > +      input clears the part to the reset code and range determined by =
the
> > +      hardwired option chosen using the MSPAN pins. The control regist=
ers are
> > +      cleared to zero.
> > +    maxItems: 1
> > +
> > +  adi,manual-span-operation-config:
> > +    description:
> > +      This property must mimic the MSPAN pin configurations. By tying =
the
> MSPAN
> > +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range c=
an
> be
> > +      hardware-configured with different mid-scale or zero-scale reset=
 options.
> > +      The hardware configuration is latched during power on reset for =
proper
> > +      operation.
> > +        0 - MPS2=3DGND, MPS1=3DGND, MSP0=3DGND (+-10V, reset to 0V)
> > +        1 - MPS2=3DGND, MPS1=3DGND, MSP0=3DVCC (+-5V, reset to 0V)
> > +        2 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DGND (+-2.5V, reset to 0V)
> > +        3 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DVCC (0V to 10, reset to 0V)
> > +        4 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DGND (0V to 10V, reset to 5V=
)
> > +        5 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DVCC (0V to 5V, reset to 0V)
> > +        6 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DGND (0V to 5V, reset to 2.5=
V)
> > +        7 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DVCC (0V to 5V, reset to 0V,=
 enables
> SoftSpan)
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>=20
> Can you explain why this property is required, when below there's one tha=
t sets
> the ranges in microvolts? Isn't the only new information that this provid=
es the
> reset values (in a few cases that it is not 0).
> What am I missing?

For specifying output range and reset options without relying on software i=
nitialization
routines, and also for enabling the softspan feature, I think this property=
 seems essential.

> > +    default: 7
> > +
> > +  io-channels:
> > +    description:
> > +      ADC channel to monitor voltages and temperature at the MUXOUT pi=
n.
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@[0-3]$":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number representing the DAC output ch=
annel.
> > +        maximum: 3
> > +
> > +      adi,toggle-mode:
> > +        description:
> > +          Set the channel as a toggle enabled channel. Toggle operatio=
n enables
> > +          fast switching of a DAC output between two different DAC cod=
es
> without
> > +          any SPI transaction.
> > +        type: boolean
> > +
> > +      adi,output-range-microvolt:
> > +        description: Specify the channel output full scale range.
> > +        oneOf:
> > +          - items:
> > +              - const: 0
> > +              - enum: [5000000, 10000000]
> > +          - items:
> > +              - const: -5000000
> > +              - const: 5000000
> > +          - items:
> > +              - const: -10000000
> > +              - const: 10000000
> > +          - items:
> > +              - const: -2500000
> > +              - const: 2500000
> > +
> > +    required:
> > +      - reg
> > +      - adi,output-range-microvolt
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +  - vcc-supply
> > +  - iovcc-supply
> > +  - v-pos-supply
> > +  - v-neg-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        dac@0 {
> > +            compatible =3D "adi,ltc2664";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <10000000>;
> > +
> > +            vcc-supply =3D <&vcc>;
> > +            iovcc-supply =3D <&vcc>;
> > +            ref-supply =3D <&vref>;
> > +            v-pos-supply =3D <&vpos>;
> > +            v-neg-supply =3D <&vneg>;
> > +
> > +            io-channels =3D <&adc 0>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            channel@0 {
> > +                    reg =3D <0>;
> > +                    adi,toggle-mode;
> > +                    adi,output-range-microvolt =3D <(-10000000) 100000=
00>;
> > +            };
> > +
> > +            channel@1 {
> > +                    reg =3D <1>;
> > +                    adi,output-range-microvolt =3D <0 10000000>;
> > +            };
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > be590c462d91..849800d9cbf7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13074,6 +13074,14 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> >  F:	drivers/iio/dac/ltc1660.c
> >
> > +LTC2664 IIO DAC DRIVER
> > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > +M:	Kim Seer Paller <kimseer.paller@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > +
> >  LTC2688 IIO DAC DRIVER
> >  M:	Nuno S=E1 <nuno.sa@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > --
> > 2.34.1
> >

