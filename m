Return-Path: <linux-iio+bounces-6191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2414090517C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03091F2324C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61ED16F846;
	Wed, 12 Jun 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vj2e5h0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E716F0C1;
	Wed, 12 Jun 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192306; cv=fail; b=Qnt+VOs8Kq6CavSc1Ry8+Z6Cvnren25HEPM/NUHNsspngrqtON1CXZfKTMVStYtoRYxC+0d3F3zMCSP9p4nmo4yP2lzc5Rzvd55z9LPzh0oZ5gf0afUXmKtFmRYZi/33RgYj66JcZaBLuOhZvGJBbn5gQLGQ2LiEIu64wC79nJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192306; c=relaxed/simple;
	bh=FkTQINzxwWHoq2OnAT3FZZsknZ+YTKMIUSDTPjLRgEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GJumyqKR/Gqb9acQTMJQayPQegBZPbYiF8ZHO1eWh3vwJrskMnkGU/SbuQijSuxUZxaetRq3srsTJJ8JWOVv2FZIcwzEOR17AuBXl0D+6cJMsAQvvnoQaTlu5L+BzSv7v84W6NmKvdUwJVGW35rN9ObAjcxXnlHJ5bnx9f/vVuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vj2e5h0f; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C5Iehl007682;
	Wed, 12 Jun 2024 06:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ykqL5
	y2KToGqpLoSESQUJh7GajeEsIPS0in0Ve7QBpo=; b=vj2e5h0fOHVPSwRBFA8rR
	lH/ZC6iBJEyQD/LS/SicQU5QkjYCV5dkLx+vctmNrLroA9o1lVUtdbNFUJjOREb5
	9464mX2Svr9B/OHgVJ03Hl5h6uc99QshkV/lm6Ycp4M5eYljyP8qxC64sy99WGfv
	/oAKUS+DddVObbYJ411/kiyvAuVpA8o2A7TF3gw1ZEsIFPfsbbsunNKqPoekonRX
	9Gvq3LwJlxKN+k9dHjP8u3Prq/bM1hVYmX6if+3Td2544SWCPyqb9d00sFSWJn5l
	P+bvXfe2YQtuWPumHsPF35xtqu5hTNi7orDFcjQLmwscUYHBIpElipsahR4EdS36
	g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ymh27wvx9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:57:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXyf2VDkbfxaOiMCodcmu8nOkRBYMG/flfNBA7sy3QPgd9mJwQo4Gcgsl6Juv2Oag/c5kuVEqhAzkh/FORbe6ivMBKI0yJ1ggKAFIpPGyfKKy60Cb3lazTFV04KjsyX5cqGs1cVCJ6HYyGP4hjC7vtsqQj6YUm0xfzn7mHekoOybt+fwLTbTDMPoNTRhVbZcyUfoUJlaTMhrUQ2ljqJPF4lEOOmgPZ0Q6ADwHv9YG/9d/bemTz4hHXEj9RnSmEWdjr7u94Xa+PGzu3zMV1mMAnouH00i+n774dsNRg8sqonKfyyRr0lVrrvXv5Umx2rMSWNSozXuJ9xSuPbAzNnNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykqL5y2KToGqpLoSESQUJh7GajeEsIPS0in0Ve7QBpo=;
 b=P9nTyTC8nMnfOEwvEL1GC0GMB+Hzi5k122W6yfQBHkMbDWM/9aPZI+MJlu+Bc4TLDcw1C5MNDRcsU+sNkwR9GcLDhXzenHdrdKR2SjVfPOu3MPw1mKZw8dvy9eVIN6iLxn10gdL0B5sw336/1KntX98J7kjCDbtat5yzcI5LJYvck9uvCYYzGB6XtsGprJT0N8Lj3UeJKJm/oXxRyvUAaLNkpNFbA45nUG0tPH9+NqsbuNlovzS7JUrDlXkdIEpcfCfT1oPEJHfb+AuWVPkNyYExCltZy+Z4kg/kkcSiiO3Iuo5nPhOkZKQHQ7WqVGt0BG2kvQ823CHZ4NOBvX7vFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 10:57:42 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 10:57:42 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DAC
Thread-Topic: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DAC
Thread-Index: AQHatVSHmwOhJ2StkkygP01nVjkJQbG9+RGAgAYJYgA=
Date: Wed, 12 Jun 2024 10:57:42 +0000
Message-ID: 
 <PH0PR03MB71416493AB2788638599CAE4F9C02@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	<20240603012200.16589-2-kimseer.paller@analog.com>
 <20240608154053.1cf1097e@jic23-huawei>
In-Reply-To: <20240608154053.1cf1097e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy05NGU2MzY3ZC0yOGFhLTExZWYtYWFmNC?=
 =?iso-8859-1?Q?1mOGU0M2IzM2Q2NmVcYW1lLXRlc3RcOTRlNjM2N2YtMjhhYS0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjQtZjhlNDNiMzNkNjZlYm9keS50eHQiIHN6PSIxMTIxMiIgdD0iMTMzNj?=
 =?iso-8859-1?Q?I2NjM0NTk1NTYyNDg5IiBoPSJFTjlRYy9aRUppc2pKQzcyUXVTa1VhQXFw?=
 =?iso-8859-1?Q?c1E9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-1?Q?ZOQ2dVQUFFb0NBQUQ1YzVsWHQ3emFBWTFQb3RIdVBndExqVStpMGU0K0Mw?=
 =?iso-8859-1?Q?c0RBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|PH0PR03MB6368:EE_
x-ms-office365-filtering-correlation-id: 29d58d56-9dd0-4066-4590-08dc8ace7b98
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230032|1800799016|366008|376006|7416006|38070700010;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?IMQjanZuFIedR24wyL4G7LenVdXbbtuEKkB2XA9EE1MEpntttsWOfG/ULZ?=
 =?iso-8859-1?Q?b2paqSbboyZ+NOp/CSNY5SoWWFXk1FxB/0oiCNgBNyv27qmIver+d1v+Kt?=
 =?iso-8859-1?Q?2bPyCVINYk0X2ZEgQNSrbDUqHwrH2H3ELc1kNJaKqqjqRXYe5IMA+i+bIN?=
 =?iso-8859-1?Q?o6MWkxZAF3OejVbjFzLumUGSzkac9Gsu0Ea22c0DIo8ope0+ur26DONKdd?=
 =?iso-8859-1?Q?P8nRGQ6EoSJmOHcP8Q/wfbznolUh3LWMZ6y5kM+N0HsOhPTAvrMs3gC8NC?=
 =?iso-8859-1?Q?JUs2M1s3rv/VvT7/PwDWpVTJ6bYk+VZYhsaACsR0nJ/Gk2bPvTRTB/9gMw?=
 =?iso-8859-1?Q?ohWqsZbWvfFYHjzKI5vV6KGjCC7WqUjXCSQOBmIhDwHWm0aItlP7x9gXSc?=
 =?iso-8859-1?Q?kz3kWMlwlmCCHt5vyYzAMlMRc3pFOc1sJ3NZOU6J4QTD4bxv9sjfozlbkh?=
 =?iso-8859-1?Q?QDAf2fBLhzztI4qufvmwgb+PSn/G9WtQhpQoj8354vz+2MVBH+Ca6InkG1?=
 =?iso-8859-1?Q?Rx5sqAYtBkKOc5X9BV7cnbt7syk6Hp2OvW/vDmzrM53Rrais7m/BcGLVax?=
 =?iso-8859-1?Q?B4kO/y1zFT/SLH2SrH/qCZAVpS5kjI6IWs1G0gyMhC3o3FQPTcZzhyR97K?=
 =?iso-8859-1?Q?f4V/DMHMgZ+EXQ+7bElrP+Nqo08ovPtlxp3IR8knMTtv6G7vE8WviZa3gP?=
 =?iso-8859-1?Q?oLqz2NH+MIxN3ffuJq9LZTG8w7MctXJRu4qrzstxpV++Mcz/+CLIZhqoKg?=
 =?iso-8859-1?Q?KgFw2pdlO6wBoGViyxPphA9byRt9j0ylJZscwZXH2LzIU/YIEY3PGQ2z5v?=
 =?iso-8859-1?Q?NBeMRLd8Ii/bYZQWG+3NBOGHlysgbVDkJMidWvvaAsN4jw0vjaKbprw4gp?=
 =?iso-8859-1?Q?/WNtkstaiqT/PSyGFQKRP410vKKFvWl22Nv0tIX4ajyGVGSi7fW7qcprkw?=
 =?iso-8859-1?Q?bYjOGuma9yoHo+5jt7Ce/zgJ9pRCWPOfOw4teYsBkbY+5Deuj9LvUWk0rI?=
 =?iso-8859-1?Q?6Q2LHVCEWp8mkPSg9tRoPNcWBZ9ok+7gLTPHmoQc9NTYjWJf2JWZgflJ3P?=
 =?iso-8859-1?Q?Xro7e3Xzs7uvQtA/6hcIOOvHMF3viJ+iSaDSiVSUHJA2sn05c9kLWa+Rqi?=
 =?iso-8859-1?Q?E4vF7OqPA3qT1Kykh71fQGcSAbH+J3jM+2eRoUsewiYosAAZfMUGm3ZAQt?=
 =?iso-8859-1?Q?UnscDUu6mNZ6FRbTY25Z5Vmo6jedrB0Vh2oak4hKfCk03j6/lH4in1Biw4?=
 =?iso-8859-1?Q?Xelv5hFMSGhMIiHj5QoQZiN0ufkVD8wWNjJV/+hOSOe+ANlJh0eSoaHaUy?=
 =?iso-8859-1?Q?nfUKe1U+CwZzq6vEw6ujdFH92ddt6cDRD1wPOMuzBClVFRF9XkTAWorR31?=
 =?iso-8859-1?Q?1+CucMsNxYmU0V1nLocXs7uu4Ve1DRgq04KeYiNVgmFoS6GcUA9kM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?x0R55pb7gReyu0CQtzYDX/sBiVhW85zGIfafOYW6jeNrEO13f8I7pRQ4tK?=
 =?iso-8859-1?Q?/IZnfXSMxqk3wADdEO96AaYk9wypiNAj8OyckmHCm81FFDp5dQERwqy7EP?=
 =?iso-8859-1?Q?QblD4vNbY0TNmlb8Db3Lm5i3J8vyx9UtQH/SOAqO36yg2k2Se0RVNstEUm?=
 =?iso-8859-1?Q?lo/lxd7b2nMTTXbI196mA4i33JWg9ANgbYdn+9m/jjG3U914D8js6HcRbv?=
 =?iso-8859-1?Q?EvzzzYM7eX+tueArMLSpYyKX3eHi86bJnScNhyoKVyDAuOxnclhCRvDrVo?=
 =?iso-8859-1?Q?Y74dZ7mk+VGahNqaHmYHCngMQn9boE6bJqR6KKfp7gH6r1PLQ7tmRdBgE4?=
 =?iso-8859-1?Q?5gAnrG6KXNR9saFQ+C761SeFMfAEAV4Z3MM/szH5/FAAYFMvMk5Wgq8htd?=
 =?iso-8859-1?Q?0nVAIMyQbyt/KHQUnfQGMgtNhKXEHjy9Add8kK9ULtzgvzUqD7OAfnhN/u?=
 =?iso-8859-1?Q?JiazrqLSFMHbbDO9/ToVmNDdtw+pZy9Mg3BRlLZguEjzhU+As3Pch1nR67?=
 =?iso-8859-1?Q?2IWkDsFSEiR3sR1NUDaEQjJj2XJnya9g7CrELbNK/xxzbOZW5uenf58OHn?=
 =?iso-8859-1?Q?Fd5KFmQG+wztNovSTGF79nkK4ARVnV03OrLEo9F78cPQNljGpGntHRvPoD?=
 =?iso-8859-1?Q?eM5dItWOkhUoMWUU0u+DLqWRVIQ5eX2dEgP0SKqaxHvOmkqo9BvN3CxGMr?=
 =?iso-8859-1?Q?ACvRurqspMkvnSKHwBph7zfhQyp9JLmxy1z9K+EoV4qijktSUr+5SAjQ7D?=
 =?iso-8859-1?Q?B8QcetsWfZFOlWc34mhb88oi2K/icUYM0Xoi+DXWR3K7DnH3+jC4kdsa8o?=
 =?iso-8859-1?Q?E6GPIYvZ7WNHBlekwbCALkf3xUE3NL0tQQpl8Q0g1H34E7R8yPzgXJcC9R?=
 =?iso-8859-1?Q?c7m2SSKKQ8odOo/gTYanA2w27xrm+sChjYaCX2JYUHHcXO1zjSt0ZDlKe9?=
 =?iso-8859-1?Q?ZEsdFj2UKLO+d2rp1uiAwG4j17svaFrtcpAmR1cTC9/A569yfGSUo7pIPj?=
 =?iso-8859-1?Q?g3jYpifTbnRgBcNn+CkmAgiSB13BclNaRn/0bAeFOdyF83tKefdMrlGdHt?=
 =?iso-8859-1?Q?h743Mwy1vQWnjDbHI5x6z8nEuPKZX/u3AuU3OqFFD1/LVvvdHL2zjfpV8g?=
 =?iso-8859-1?Q?3kxrpRKYZ9UsIs5b0Tw/aq/hkdk9AFnhjyQWUYFyF50vIgRtoVcJL8cHg8?=
 =?iso-8859-1?Q?oquT+P7T7fCkhgNVeYbb5TZHgnj/10+fdyz7X0ww/SpsF0nfak/PpZYL/z?=
 =?iso-8859-1?Q?HGatlTy9wyofc102L8qKaS9HaRDUCeYm/hnU6eIXVf86HoPGP/X2qj3Vo8?=
 =?iso-8859-1?Q?LPxIILUmP1n1tShbanEk9uaK7hr1ycKT8krd5Fd1nLDv2J5elp465D4cBy?=
 =?iso-8859-1?Q?Kchvz0a8639ltpRDl/1cQi8sdiN7CaBbPHV61ex5mCrwavPa1LOZ5fPhh3?=
 =?iso-8859-1?Q?wtSXXhDqgeEaS32S0aATrV10EKXo3WDqEC9X67QvLPw9yHT90g53zial+D?=
 =?iso-8859-1?Q?5TsDf1vDJiIkdny5jUrl9HMUGDrTF6/ZCN7nehf3FaJrNZM4eJsSKeoXoB?=
 =?iso-8859-1?Q?TDd2oFxlZI4QaeRgwHnRY+CjUUpa+IykNFR6OBAtSM3jC2UsbCq5QFPi8J?=
 =?iso-8859-1?Q?fgCOAjry4P3I8LL8IJFt4Nfyhxudd8so0j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d58d56-9dd0-4066-4590-08dc8ace7b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 10:57:42.0646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL0CehJrJATF06uxbcuaWB9Z7+jKGXU58uyr1vcswDGc7TrsdrARjOj29MiiJjBufOCgqmtxxl1io0JL0sbpBfFfgvOzem949DJuGmEE9Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6368
X-Proofpoint-GUID: Yfx9neBHmGi2F-c6liv3t9oHNrbWecD0
X-Proofpoint-ORIG-GUID: Yfx9neBHmGi2F-c6liv3t9oHNrbWecD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120079



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, June 8, 2024 10:41 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; David Lechner <dlechner@baylibre.com>; Lars-
> Peter Clausen <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v3 1/5] iio: ABI: Generalize ABI documentation for DA=
C
>=20
> [External]
>=20
> On Mon, 3 Jun 2024 09:21:56 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
>=20
> > Introduces a more generalized ABI documentation for DAC. Instead of
> > having separate ABI files for each DAC, we now have a single ABI file
> > that covers the common sysfs interface for all DAC.
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>=20
> A few comments inline.
>=20
> I wondered if it made sense to combine voltage and current entries of eac=
h
> type
> in single block, but I think the docs would become too complicated with l=
ots
> of wild cards etc.  Hence I think the duplication is fine.
>=20
> Jonathan
>=20
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-dac   | 61 +++++++++++++++++++
> >  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     | 31 ----------
> >  2 files changed, 61 insertions(+), 31 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac
> b/Documentation/ABI/testing/sysfs-bus-iio-dac
> > new file mode 100644
> > index 000000000000..36d316bb75f6
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> > @@ -0,0 +1,61 @@
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_currentY_toggle_en
> > +KernelVersion:	5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +       		Toggle enable. Write 1 to enable toggle or 0 to disable it. T=
his
> Tab vs space issue - see below.
>=20
> > +		is useful when one wants to change the DAC output codes. The
> way
> > +		it should be done is:
> > +
> > +        	- disable toggle operation;
> > +        	- change out_currentY_rawN, where N is the integer value of t=
he
> symbol;
> > +        	- enable toggle operation.
> Same question as below on whether this is accurate - Maybe it just needs =
to
> mention
> this scheme needs to be used for autonomous toggling (out of software
> control).
> It works for software toggling but may be overkill!
>=20
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_rawN
> > +KernelVersion:	5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute has the same meaning as out_currentY_raw. It is
> > +		specific to toggle enabled channels and refers to the DAC
> output
> > +		code in INPUT_N (_rawN), where N is the integer value of the
> symbol.
> > +		The same scale and offset as in out_currentY_raw applies.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_symbol
> > +KernelVersion:	5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Performs a SW switch to a predefined output symbol. This
> attribute
> > +		is specific to toggle enabled channels and allows switching
> between
> > +		multiple predefined symbols. Each symbol corresponds to a
> different
> > +		output, denoted as out_currentY_rawN, where N is the integer
> value
> > +		of the symbol. Writing an integer value N will select
> out_currentY_rawN.
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> > +KernelVersion:	5.18
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +       		Toggle enable. Write 1 to enable toggle or 0 to disable it. T=
his
>=20
> Mix of spacing and tabs is inconsistent. Hence the odd indent in this rep=
ly
> version.
>=20
> > +		is useful when one wants to change the DAC output codes. The
> way
> > +		it should be done is:
>=20
> Hmm. Is this true?  If we are doing autonomous toggling on a clock or sim=
ilar
> than agreed.
> If we are using the out_current_symbol software control it would be commo=
n
> to switch
> to A, modify B, switch to B, modify A etc.
>=20
> I think our interface has probably evolved and so this might need an upda=
te.

I agree that the description could be clear about the differences between=20
autonomous and software toggling. If we were to change the description, wou=
ld=20
this suffice?

Description:
        Toggle enable. Write 1 to enable toggle or 0 to disable it. This
        is useful when one wants to change the DAC output codes. For autono=
mous toggling, the way
        it should be done is:

        - disable toggle operation;
        - change out_currentY_rawN, where N is the integer value of the sym=
bol;
        - enable toggle operation.

For software toggling, one can switch to A, modify B, switch to B, modify A=
, etc.
>=20
> > +
> > +        	- disable toggle operation;
> > +        	- change out_voltageY_rawN, where N is the integer value of t=
he
> symbol;
> > +        	- enable toggle operation.

