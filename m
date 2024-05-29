Return-Path: <linux-iio+bounces-5455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B668F8D3B0E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83D51C24575
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692E1802B1;
	Wed, 29 May 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uN+MaIkb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01171B947;
	Wed, 29 May 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996824; cv=fail; b=HKDwy/bHdnNh47W9TPJMCYE8f+dZbVzoApL7kI9Mn+nFOXd6UUCOE+hmB6/DrSfvxXTblxFloUl8gFL7kabC9UXgtJ+jLvjxfqIm9Qdy33v4RKs1LezqD5CK7feceIkmLYe0qVBo1gscVSMjr7tc9g/zuo3P1sQ2bpZG6wIQ638=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996824; c=relaxed/simple;
	bh=VV0pTDQrgwdpCOA7d2dZGHSBCBhpwInomNh58+m4dRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExvmtawwvPFcsmNQ+sDbsbbEuSw5bfrtng8Y7NvPNjHq7Degy2xVnerMl4tI3n2AtZtoxtQtei0waPtLedith2Q+f8j7E6aRUiMAFHp9NF9sXJH+LaR2OnE0oSmFDdnVYOR8WghvgWsJbl4HY56lFcXj+eH3MJmb2DPT+VzHKlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uN+MaIkb; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TCkVC5006214;
	Wed, 29 May 2024 11:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VV0pT
	DQrgwdpCOA7d2dZGHSBCBhpwInomNh58+m4dRw=; b=uN+MaIkbnbp7cAbFr9xab
	QYWJ7pXRySbzXO7e56I+Zxhu2ckjOxTUDG57MS9u9X8s85QLtzwPucApoI37GrGC
	/mIALhlaOqn7a3UCyNbjbWx43RSq3ZdLmSfByUp0R5Z7cvbvvDWXa38QcabtAEWO
	i50xf5LhYDcnLChNBs8JcGlCQ/Ppxjw/SniY3aRnk/rftrEmtuAuPuwFzqF4V4rv
	0vpfu3zLJeF0WgqtG1ZNsL/7wt+BcgdLGUBD6y7zmjzHtXA4YbyGb64kJTEuMqnG
	KeH/+k5VDmTSfp9hbc525jm2cK+eB9zr0OnaY+SBjK9fPylXOgdl7F1xcA3jHtkH
	A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ybcm3x6d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 11:33:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQbhpEcCuWYYeMh0poXeUSaEBzrsNSnBV08snB93UVN9HgSSsXN6ARunQhyodlHxe6FB8m0k6NdDHjrUhckaKsy5c5/y9jdKerNQXmpVj4XT+PRmVK8QjEJrKwfg0tRIeAkpml5pJ1RU2rcI9I2i4zsa5AI6U8mmreHtL+xTS5hBTN/jemx3izmOX1bbKAeA957Mmu0m7tdbDrpKtY4R7BNWCu0m48KRm6hwARszCPe5Gv3DnW1OHXGucPjJ8/8nrQ3vR+SvQittuzszaMTpU6nfF3E2RKBZUy24y1DiWx3tlYi3ggl+uQYlFcDaFa7hBqQVkkZrroDL3eZxZX2t2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV0pTDQrgwdpCOA7d2dZGHSBCBhpwInomNh58+m4dRw=;
 b=j//29QBdTfule5NAv6kgw2tkr7rQnEyfIPSpVPQItjt+pWllMk9oujkEcHSmqBdUbds1zukagXBPo8DIkttrJLPbJlDgu8mzFv9c0OSB1MMMYQZFpi2TV9QFJwP5AXDQH15hX0y5pXPBK108rD0Fav98Ktv2JLCphiVPn9wg1BNXAjpXnD09Eb7b1wap4F62tK9SiFQOgqhOQvEIdb+PWsWIJ2F5WivM+DVlokE9yVuJzfGjWGcM6GPwQhWoEdYCscmFnW+9+iIQk5qzV96yAq/RM6OWcFTS/Doo+nGWzRSKL7qm7TiN2kzx2HBSnfUqWhtisL7ggHUEfCyeE7IXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by MW4PR03MB6604.namprd03.prod.outlook.com (2603:10b6:303:12b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 15:33:20 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 15:33:20 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Schmitt,
 Marcelo" <Marcelo.Schmitt@analog.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Sahin, Okan"
	<Okan.Sahin@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Liam
 Beguin <liambeguin@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v2] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHasdl0njKMnW13Ik20bQMDc8f+zbGuUcaAgAAFOaA=
Date: Wed, 29 May 2024 15:33:20 +0000
Message-ID: 
 <SN6PR03MB4320ABC76153E33F2EB5B0CDF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240529150322.28018-1-ramona.nechita@analog.com>
 <ZldGD4ByS_QCEFuS@smile.fi.intel.com>
In-Reply-To: <ZldGD4ByS_QCEFuS@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccm5lY2hpdGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1jNTdlMGI5Zi0xZGQwLTExZWYtYmIwYy0wMGUw?=
 =?us-ascii?Q?MjIzZWY3NGRcYW1lLXRlc3RcYzU3ZTBiYTEtMWRkMC0xMWVmLWJiMGMtMDBl?=
 =?us-ascii?Q?MDIyM2VmNzRkYm9keS50eHQiIHN6PSIzNDcwIiB0PSIxMzM2MTQ3MDM5ODU4?=
 =?us-ascii?Q?NDk1OTUiIGg9InJ1UFVEU1FYWnFUVG1RMk9zVWYvYVJIRGh0az0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RDdkTmlIM2JIYUFVMGpvL0haWEtTdVRTT2o4ZGxjcEs0REFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|MW4PR03MB6604:EE_
x-ms-office365-filtering-correlation-id: ef9f5857-39e1-4153-04e9-08dc7ff4ab38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Foe8G27FDjicNEeOEO0J/G7o+VlMu5ZucZaa6iPI5Reb8hCJvbVjFsZoK64n?=
 =?us-ascii?Q?f5FH7qH2qj1LLBKzLZvSdqsTWxU8TM2lCCgaJ+r1Nejpwy+eAZRKE4vPKwNL?=
 =?us-ascii?Q?IEXgLG0l5EfcjUG7vi8D+goKWUHe9tM6P7t8GlwmwGE9hNRuxzF94Yo/qxkW?=
 =?us-ascii?Q?npo3Qg2797wPnFpKAY3QnUNVibqT6nCvBAO9JsOoUdwDHwdFJ0WDGIjHtTqu?=
 =?us-ascii?Q?QeEtDpFQ3I+Dmod4IRpNCWqTEsFQ7NjCcnV+kg7JhMFWB1W/9O0273CQXuMS?=
 =?us-ascii?Q?7dnpWsK1/sHZ85uY6vVqXP+qXOrnrHV1GzWc51bqMIlLKfxcdo04uUAqDRdn?=
 =?us-ascii?Q?M1/X/rxVZAP0CJhLQP2OiMoCiTlt1SQQeUvDPxJsOfDp+eB7nHtKaq+b00ep?=
 =?us-ascii?Q?JQ8SVUQcVue0/RtIUKoetWKHmFrEUX70P9aFqq1FRw8bQaG3RddIjRndWMuJ?=
 =?us-ascii?Q?jt6rjflUmaq/4UtHj176d59XBdDs6XyVAVv/pKyDXmyAnpb+Z6/spLjy2K2L?=
 =?us-ascii?Q?6IZ5o0UNqXerHNa0VKojExCKdoiNoX4fP8So+AmY4jfw4uWkHhWfluWMB3nm?=
 =?us-ascii?Q?VLx5r+A4H1oQz/INgf/5rlJ6g3zfETC4894Kj/r1XhG3EVinG96XyL0EKPVV?=
 =?us-ascii?Q?cNFsBdFbzoO9xdkqXyILNrUOA2IfHu9gSu9PF2KsU4i5xhU/hbj+8J2V8F89?=
 =?us-ascii?Q?xU3PSPRAkPMVZqjra01GeWDu3ftqspXjBNorcd5EHd7fpCrjC/uk11NkESQJ?=
 =?us-ascii?Q?8zhn+ZYcJimdKnWcfjnj1d9VcZ0isLORxJp1fMIBxUBu5f/GpPmJfUHRdL7O?=
 =?us-ascii?Q?BIKl825YhP2rvDSaiSPNNfA1dS1Jm3RHDrgT7hTtEMh9OxXmsc0/sCbyJ1rl?=
 =?us-ascii?Q?wbkjqaI25z4Wxhnx0BmoNaUACcQG/+Nvk+381JkCpwv6kuCqkZLwHDqLlUtg?=
 =?us-ascii?Q?WycLqnuh8jP1refQ2Tdip2k9H4xXOhgtrl/da2ZRNT0cHHZkgMS7tOGj5wQx?=
 =?us-ascii?Q?fhhCMRWXFG33BWFtPIYIwhIC4kTPeKMnLEWw4FPNfBMTrItop3WH4nwYvVAB?=
 =?us-ascii?Q?ZoMwDWKMUE+P4Wa80OS2vjVrTZaZsYKqMomvevUfjNwKBw03OzNRFl9jCT7M?=
 =?us-ascii?Q?R4uB0WL5YUwwt1CO4uyt5voiu+Ib4QtnLOgYAIMbAhhnfqOL3rjW2H2N+sXT?=
 =?us-ascii?Q?5biDtC248kPVjHFVxw1sfAjVFu7pjj0vHLFaD9Yn4FQZYEn8SqweC9stB4TO?=
 =?us-ascii?Q?2i7BD4ZXgTa7OfANqt6GeGATiul6jV6frSlgUecZ6FaRDLXlpatXXGciBRG/?=
 =?us-ascii?Q?/Y63t9AcsBtupBeCVWgWEGhOBt/BE6VjIjhBikFcCNH+hw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?LTszW88pMXDiGdst1YK+eAIrBIy6crv2J36TweMDTnw0gd20WKWxIFz8YdtN?=
 =?us-ascii?Q?4Cl15DxYMEBYk+hMWgvhJ88ZQ6jBnKmlEtSFFoyAmJwPPV8wC+nwYixz73LN?=
 =?us-ascii?Q?CSKua+zznokWnQSXgM+Y4EpoNx4YyERjFXoE3cGIM3na/Ppj1Usykk9nxSu3?=
 =?us-ascii?Q?q2eg6IZ0O788rQ9+Rx5567OPdWsEaBONCBYBF0UB8Sd8Rqch4XAl0+u9omeF?=
 =?us-ascii?Q?pIAoGXxTbb/trXx+ZMpGtPUG3VKxtKIQliaYm4z4lsLYh1HJnKI0ekMEe912?=
 =?us-ascii?Q?oEVhiVssvgT/6wc6QFe1UzhgVTr6NpOkcc/btieqCr+y9tDz6avxgyAw4yTE?=
 =?us-ascii?Q?VchNMIyPYN3jvaSHopmDAHnxgc9JdaccVV45mTEpp/qxaQL1ZJsTNdcR2ksv?=
 =?us-ascii?Q?0YmT7Jx0R5GQtyjykrCPM29V554JiR1Zi+OJQzss3YrBMjRWNuRFBPlsv350?=
 =?us-ascii?Q?kIi4QUQnJJpmKrDZ7TK8zVDTbljXBANJHgbyKm5QGmlBHEl6GQRgBwCHZBkI?=
 =?us-ascii?Q?zbuHH6rJiTiiGviPQ8ELiCGbgpBgOAX/qqL475Kh0X8fRbGM+dzBNa6zf64M?=
 =?us-ascii?Q?+6wsKBzepIljvoSnzYvRh9DLLxsmEwPF19/+hZq8QBlkf1DP8CpJWbx4+u1B?=
 =?us-ascii?Q?taBlZcyN0T6bjNAbQ4dMzZW5Oh2yyWtWr/GC5d+7G0Vwb2DM2mWr9M8KAnRR?=
 =?us-ascii?Q?4LAQuPp+UiWlFNyC/ESndcwMqcwGloFCoC3gRGOiw+WEuGFiinYvaOLOdcKy?=
 =?us-ascii?Q?jZ8xOJ3w1XCTTpMrjM0MFpkVmV4Q1ExQz4BpUNUcMX2OIJicimvn2NrAIuH4?=
 =?us-ascii?Q?x+Ioj6DJIe0U4NOE6fEtEeX48XwwIMJAJvwkIGFID3rVh+VZBWjrjkVxgJg1?=
 =?us-ascii?Q?zt4YKnXErMHMq7mUe9eedgdlJjx+aqsFxtfEeihnW7wiN+x+6sCbcSk1VLOG?=
 =?us-ascii?Q?iDtvVCDwoaz4B4npqsgEsGZR2s1k6VBo7gU/aaIF9zC3GPN9q8rOF1mq/03n?=
 =?us-ascii?Q?GWx+6yeDJRQvi/IElKYZqZxCPkGeyGUT0Dh2h4FsAPcSF0o19MH3mEJvs2hk?=
 =?us-ascii?Q?nHHvJP/dP1qNhcaKoKtNq0E0xmLGsWoY3turExv2IjqWmiYOU7DiDDwefeGJ?=
 =?us-ascii?Q?eKor61I3m9rtjUQqaiiPH4h2DpY3wyb09CJRyR/IlqW7NMNXI9lGEgtQ6NNA?=
 =?us-ascii?Q?3ikQidbqOoh/e0/1jzZCWP9HgtipAffLb3vhnf1XLjUxT2yep5B5qpX39oRH?=
 =?us-ascii?Q?stgn4I4VlYcQbb6dJrKso1aYGdg9mpZfZHGUAV0M0vIapmhdpu0UOGobnRxG?=
 =?us-ascii?Q?Vo7OEIjel/ymuwcvqSk8a//CEay2iSX4NZwpwwaaYlzGcEfen7bqnZ4r3BxF?=
 =?us-ascii?Q?SiF5QxikSjpOWl3tetBaJbKnapGAKGGg6SeLX30Tdr+ELjA6wSyMcZ3Q8+w2?=
 =?us-ascii?Q?HY59rek9j0OVSx6Wzo6N+Odeo3jN+n0bx2uo8qKQWL4Vez+RmfKkv/gKcYkC?=
 =?us-ascii?Q?lDnBzh2Llc+4AZbSeJk+bFTojWRZg7ogLvWch6gng8U9rXIwvKkDoSXjqUI4?=
 =?us-ascii?Q?jphxXD3l1pEOuhFXJhpwNufGK9W6jn6gI02UwZrf?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9f5857-39e1-4153-04e9-08dc7ff4ab38
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:33:20.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWQv5AdNSosJFcERd4WP42KgEmPJ83adWTJYrMSFz2uY29UyNSmC3Xr7DXzK2eqV3INiRCsKXV7jz/2CqJT10pkWafOxRsnj/FvkNLrWsAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6604
X-Proofpoint-GUID: 5P40QXE4LhXldwXa-s6kQln66Yx4Eky2
X-Proofpoint-ORIG-GUID: 5P40QXE4LhXldwXa-s6kQln66Yx4Eky2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=943
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290107

Hello,

It misses a chunk of it because part of the code added there was not meant =
for upstreaming due to the axi interface.

Best Regards,
Ramona

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Wednesday, May 29, 2024 6:13 PM
To: Nechita, Ramona <Ramona.Nechita@analog.com>
Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Lars-Pe=
ter Clausen <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog=
.com>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>=
; Sa, Nuno <Nuno.Sa@analog.com>; Schmitt, Marcelo <Marcelo.Schmitt@analog.c=
om>; Marius Cristea <marius.cristea@microchip.com>; Maksim Kiselev <biguncl=
emax@gmail.com>; Marcus Folkesson <marcus.folkesson@gmail.com>; Sahin, Okan=
 <Okan.Sahin@analog.com>; Mike Looijmans <mike.looijmans@topic.nl>; Liam Be=
guin <liambeguin@gmail.com>; Ivan Mikhaylov <fr0st61te@gmail.com>; linux-ke=
rnel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: iio: adc: add support for ad777x family

[External]

On Wed, May 29, 2024 at 06:03:09PM +0300, ranechita wrote:
> Added support for ad7770,ad7771,ad7779 ADCs. The data is streamed only=20
> on the spi-mode, without using the data lines.

Do not send new version if we have not settled down everything in the previ=
ous review round, hence I even won't bother to look into the code. Will wai=
t your replies in v1 and, when we got into agreement, v3 after that.

> Signed-off-by: ranechita <ramona.nechita@analog.com>
> ---

This misses a lot of information I asked about in the v1 round of review.

--
With Best Regards,
Andy Shevchenko



