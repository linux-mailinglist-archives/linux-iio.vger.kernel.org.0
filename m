Return-Path: <linux-iio+bounces-10391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956CA998A39
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79921C23652
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092651CC88D;
	Thu, 10 Oct 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SOSHDrhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7801FCC6F;
	Thu, 10 Oct 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570810; cv=fail; b=nh04aI2CLONioigQfYCOB2+jS5H6jZEkp0FpDAu/9Yk39xVJ+iZZee2dwTsR57dZFzUJHiP0dcjUdITHivNhOIHqwY7saIWm77HQ5eOewZjPm7mobCB3cGLKzrgg/IB67W2SYRLbNaJGhyUwE1p/skKndkFe2TRy34St4OOXFgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570810; c=relaxed/simple;
	bh=LmhMrqC/6J2W0vATp6NuK0LXefAW3bwJxrinr60qIaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPQCfSGaIUWhUUBuIMsfKvKE39fYiXpBOF8V0e4CqFoJC4/JrK+foWlY+epP1p5otoy5WWh7eFNa7BoCDt+9HYtXGX1AAiscJS8YAyXNQ0gODXlHYPSajr0QwbS4B1v2kYjGwA/9Tj17YtbK9bC5/dgv/JAMuZ1DGNIuFiJIo4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SOSHDrhu; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AE1ogA027440;
	Thu, 10 Oct 2024 10:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=++yLa
	xPF8AUe6oklgfcRq2syjg/IGi4owZ3ISEMQbO8=; b=SOSHDrhuDCLdDvbIviQ02
	36ZH3QZC3ZeTFK/CKJdIbMN5iCUVwJoElRzFMEbLn6PT1M3Xh2B9HDk1hwCI+nsx
	JEOi3COG69ACJGqgKQeQTpyexnwxmqWDOdAlIZirmj7Ys+DWp7mN2hX45rhr/tMH
	dad9rak1suqNFZShdosSGheAhwM7tTYJAYJJqlq+GFciJzqEwddb+dHPhg5VuDRW
	MkSegtG1HPjSCT5L9DyodK6FJo/ppTOQj5mibkeiCqB6x9RNewpBK74QzNyuz42m
	mlhsVcz7U+FZ62MM3qsdrWkaInhUWkmft0oA3sTwtCtpafQn2/WUH73F0oQXc1mB
	A==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 426452tsv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 10:32:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkTb7YIxSI6I4YCTtfHOw74Vv2DO4VGDt2DejVydNq2v30ASwd1E2Uw56po4OeJsd8puz5Ml5SaUQOLGo83lqQNPtnEJmNEBX1lwnZCrgNfws0UADP+L6/p6DtZnQCwRyr6p1CTU/epifQableRSo5LNPfnmvVZ3Uve+JF1j+P6RlEHCJM/AOqmsVNHlpra229hHH942w2+Yjb/JUu0DAdHylUF9pIWZlS+Ex6t8+Vccz3DHg8r0Nxpfph/GIQAW2xeru+TsyF5ieroBIgVrqY6ZyvXMyM4/mTsgMsX2uhVaVuu4ndUlOvOme2+POECVqdcO/eyQMSWSJSbIcRWA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++yLaxPF8AUe6oklgfcRq2syjg/IGi4owZ3ISEMQbO8=;
 b=SXmkQ3SfvhEESGTLC/tr72QuGb60JJ058k/g47sfnefjmcu6/azM8L7pbRoJ7WkoYs08bc+xgUnRRu8epDCqu1T3KelMb3it0JbrNAVGETDwG5mi7Lncxu5ejeql0QdwYEZUGVe5svSeRoJ3RqOH7YO4EKjBemROf4gaKALNgwf2r+fPtgzMYutxzwjDKJ6gsl0uIu+fmTCYiJL1lZvnf7oPX+pEDAZ52E/GBWCULxnf5YVvAqJ984ZUcRa+1lixWrdNdMxLTaT0PhqZmSJ8sJHC9T3qC+E65NHyUmZmwI8LKo5M+EerYJeZM8u07Vx/QTHeLY0oj+jxZqCddHrn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM6PR03MB4315.namprd03.prod.outlook.com (2603:10b6:5:101::16)
 by CH4PR03MB8018.namprd03.prod.outlook.com (2603:10b6:610:236::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 14:32:49 +0000
Received: from DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00]) by DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00%3]) with mapi id 15.20.8005.020; Thu, 10 Oct 2024
 14:32:49 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHbEBvI0bztriL/okSu34t3FCBrJrJqKOMAgBX5E4A=
Date: Thu, 10 Oct 2024 14:32:49 +0000
Message-ID:
 <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-4-ramona.nechita@analog.com>
 <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
In-Reply-To: <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?iso-8859-1?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXH?=
 =?iso-8859-1?Q?JuZWNoaXRhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAt?=
 =?iso-8859-1?Q?ODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODM1YjVjMTItODcxNC0xMW?=
 =?iso-8859-1?Q?VmLWJiNTUtM2NlOWY3NDc1YjhlXGFtZS10ZXN0XDgzNWI1YzE0LTg3MTQt?=
 =?iso-8859-1?Q?MTFlZi1iYjU1LTNjZTlmNzQ3NWI4ZWJvZHkudHh0IiBzej0iNDUxNCIgdD?=
 =?iso-8859-1?Q?0iMTMzNzMwNDQzNjU5Nzg2ODAyIiBoPSJleVZuTkE1MlZYbzlkMHo4YXVO?=
 =?iso-8859-1?Q?MjUrYXgyTFE9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSF?=
 =?iso-8859-1?Q?UxUlNSVUZOQ2dVQUFEZ0RBQUF5T3Y5RklSdmJBYkFBVmRYWUxkL2hzQUJW?=
 =?iso-8859-1?Q?MWRndDMrRURBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQU?=
 =?iso-8859-1?Q?FTZ0lBQU80QUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQWZweWNXZ0FBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRj?=
 =?iso-8859-1?Q?hBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpn?=
 =?iso-8859-1?Q?QnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQU?=
 =?iso-8859-1?Q?FBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElB?=
 =?iso-8859-1?Q?YndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?iso-8859-1?Q?QUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWl?=
 =?iso-8859-1?Q?FCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRBQUFBQUFBQU?=
 =?iso-8859-1?Q?FDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFBQU1BQUFC?=
 =?iso-8859-1?Q?T0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB4315:EE_|CH4PR03MB8018:EE_
x-ms-office365-filtering-correlation-id: 06dcc14c-448b-4237-c962-08dce9386a62
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hv38v1DA14IoOT2maZG5VsKnBUWYQMdXTi1/vvKGn+ze3bz5hGWbuepQVD?=
 =?iso-8859-1?Q?CnkeKPbhKBlyOQrbf5OWpR4+4oufjaXI0qpMTETMETRrrT7h1QO54ssBpq?=
 =?iso-8859-1?Q?dNnzwCRXJvHL6PEA2zryZipEcVcU/B4op5pgYwd4nuByp6ujMLnbY8x9SJ?=
 =?iso-8859-1?Q?tE/zL90PQdeRdvRgCatrI0dS6U8HoWaEpj0efmeOGoiOlgtjfr+ixabGX+?=
 =?iso-8859-1?Q?rZTavx+6Cb+MGAjiGWKAhyu0tSCFHJu08GBwxxCXodBc5dNANLGSMq6yBM?=
 =?iso-8859-1?Q?ZBzqzpsMZ8gghgV+V92cs35mC8XyZKwfVUhGbEL6hSYCs8THzyImH9QDNm?=
 =?iso-8859-1?Q?921hFHH8gM5An5Qh5SgTXMiFS9yOnEB3hPTDweULF3M0NNAD+NACYmYHwl?=
 =?iso-8859-1?Q?owH4qIi9Y/0VtnZ8N7gZSACoIAPhZjZ+MviSzfPDOgDMkwSjc7WZUKh0r0?=
 =?iso-8859-1?Q?IoLXqIrZd4WrGZkBqv6llPLHy+/X5DNbBp5li4b5fg6plQv3wRAJTP6wS/?=
 =?iso-8859-1?Q?+7MtGEgy65SdNLZ1Dv6+BbH/egLxWCPdNEYr+8IMLVXbj3IzIbvPCLCBig?=
 =?iso-8859-1?Q?NUSyQb4Kk+tNhPqRmGIrvgC8MJHVDxMY6qFFnZcennqUvLJVtSfDYa6bN2?=
 =?iso-8859-1?Q?9dVPWE6oJQLEOMOqLawROS6AUJs32cCAjRf+VZMte74SWs4O/dcdr/j6zb?=
 =?iso-8859-1?Q?os/YDVKPVJSzzNtviB+FIWdS3xxDXGUBETcNcuwO6JWpkpo9S9xw0QI0U2?=
 =?iso-8859-1?Q?ESbBMT9SqvLFv34bYBg0cMmW6TLfInICkaCdaf9WTwQviFidK7MIeg1YUb?=
 =?iso-8859-1?Q?gu2Vinpa02Rv+sL94PEQpPL+9XcqZiW3Rrfh3KbAYK2HCyvboVtn9gUINJ?=
 =?iso-8859-1?Q?jYex9voFCNI2xZjhlrfPtVWRtmAlGCwmdG6pRlPvPCxO/YgvtiluiU2p5b?=
 =?iso-8859-1?Q?jL++6+SRda8vT8ebCZTT/Ltf8R4aNIg4xsnnn712kabI/JcleTUCD/6H0A?=
 =?iso-8859-1?Q?hEFeUCabXcee29sSRQYMc4H+RRqpxS7SdHKEwyCa6akBcCq1KehlLvpBTT?=
 =?iso-8859-1?Q?azSPNqpyMUx8O2SDGDlMu6KnTkUi6V2zx0gvfCz01PpGjtHpwQVKlhAZsK?=
 =?iso-8859-1?Q?7V4fFuUS0b9CMkNyaXBgt5qhwWpDuvqwhrN2qp3b77qY4LgKNHwgI6E42W?=
 =?iso-8859-1?Q?HgxyRx9BE1CRxOMB11qM8Aj/TOqoElHV0Pga2hUDvHqdhyE9A2RkvCiY0S?=
 =?iso-8859-1?Q?tHGzQBCSdhr+/vYQE+7+EUKg08cXYhwoNq/lKJvtCrvshkkwJ5LpGVUYao?=
 =?iso-8859-1?Q?kX6HF04tH6vJlV/uTEeN7XK1mco2NkOxnV9dN/itEhL6+U8QzqmYqUAJS8?=
 =?iso-8859-1?Q?cKC6Z1dVB5my7AFwFYrP02IblhTNPgtQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4315.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8b47pAMsTYBttwL5hjF2B5dZ2btPb44KLO3B5XDC3MWxoS40Zg32lX/H9R?=
 =?iso-8859-1?Q?Dbc2ps7fDaMWMTmok3mT3NnqN06xcbzbscA9mVsmCMVks1BxLRInreeyWB?=
 =?iso-8859-1?Q?5UdcNJdVyCNiFUf37q+mxNqaT9Bhba1tKPczull4QLj9+Z293DSvdVDAWV?=
 =?iso-8859-1?Q?spns8VpuNL5tGrNBLLep3M9y5jqPv1WGyI+2f0oWOokZ6hfBAQ2zIrtSDQ?=
 =?iso-8859-1?Q?6BYUcgZZBryEikh6TBwtw+guW3O84RvWDXKx5UIXe1LIL/hV5tFyxeYhxW?=
 =?iso-8859-1?Q?ITDni6nhUu27J7Fu1eyadx7JxNM3oLr0QqBlhKrOWHxZ0yh0FzV4ntlCOW?=
 =?iso-8859-1?Q?QfCMpA6tGSi17ZZpLLswFGUbnuNUVRC8bi3o3TQYduvDY2pZbRmQropfx8?=
 =?iso-8859-1?Q?wxmkgpeFuHddvH/X4PprisssZhtK895mdPPx0XBE1V2pfFJkILMbHSom85?=
 =?iso-8859-1?Q?DqIfr1hDhKS2EhFfC7MCyawa2DybjXKdP/8dGdf7DOyjN1yPaThhl6MdJ2?=
 =?iso-8859-1?Q?hwLNEpnx0akGgxPU74964+F+f9OIl3SHQZi4qNUiicU5yWpZ/eGC/1EcMx?=
 =?iso-8859-1?Q?els6eCgtumYLHY7Yk5BEVwWNhe/ZILvbQghfe1GTOcVy2FSK0/d2iye0fw?=
 =?iso-8859-1?Q?4GTv69gMKG5jiWfOY38R6GD4qQph19AM0ysjYuKx5nsJ165AQ0bYpzNuHK?=
 =?iso-8859-1?Q?04PkCc6T//bMBK//Bw3sSDLiRRddS83FNSEInrC1WE8uJxBMiGw70PyfbO?=
 =?iso-8859-1?Q?cfyEdym9HjNkUZ5X3QFFF/Zzv00bkhG+UGlr5y3rNjMLGEPLBKVM9Dn1k+?=
 =?iso-8859-1?Q?82zM1XXGeyOB9IZAM3oV33MqNeyp9MD7Z3MRWlYxyTRvc191WAdwDjdupU?=
 =?iso-8859-1?Q?ZK63CsngJ/3OQjUUyHGCyGCXonv4NGN2vj7JS4rKvlINFskoHCYsrvsf4x?=
 =?iso-8859-1?Q?FUIDDtgQR4z8q2S8xFnJze2GcmzZ0Ik6Y0uT1a/MHm8RmQiiMffvCUqud8?=
 =?iso-8859-1?Q?6UzGKHTalvYitCraoiE7wiGizIYK5Gkep13ztYfmySxQXtcycXOLxAMriX?=
 =?iso-8859-1?Q?LVsGTq2zEP34E1QbtTlzjzFqWi/x+8T00tPu8HxKZ5si9ukBxsJ5c2XBex?=
 =?iso-8859-1?Q?oyDSaWO3WGW2IrdlST5cRbViYjjUUOVv1EihlTQ/zfx3FrjoB+/bz+WSOv?=
 =?iso-8859-1?Q?h6sec2HcGs12z9i43dSK6PWTA+FUqsGiyX9hR0iVdR00zvLqra2Z4jDrl3?=
 =?iso-8859-1?Q?OR0yN68KBzLk1OczjBOd+g/RVZeBiTZQGJBplZBr0TjXqd3+6jzEmpyLbt?=
 =?iso-8859-1?Q?A1htu9koWdB8zrW2jBdKDU2lLAB1sDvczquIYhoDCUHwhu7kzmoQaiRTda?=
 =?iso-8859-1?Q?CqAYJYyGUzGcy65kcIZjBrfyiudB8QRRr8Tn+UvLHQXpD4/Sj6ALfkjaGO?=
 =?iso-8859-1?Q?YRhrH9vmgz/yP4ZVfLdnXd2HrBEVE9u16pqco33/lkpEtiIDw9Nai8iNF2?=
 =?iso-8859-1?Q?uz90U4zitOBgtDf2c+bpN/8xqP7fdyadq3zXgmlPyjVnflfubcKq4avSrT?=
 =?iso-8859-1?Q?n3hADI3coe4UOiWpQuRLjC89fG4UdXjqXV950/sIp4d0S9fd/O7pvoc6E6?=
 =?iso-8859-1?Q?BSGumZn0eH1yl/xtCERGfv+uIgRlL+MMQI?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dcc14c-448b-4237-c962-08dce9386a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 14:32:49.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wt6/ZcLGFNNl0PtJcOThNlm8TYcGX9EFaJEBndOguWj9W6RmOUwOYN454jvItdlAOFiqjiKMqB69Oleg1Lg7QHYa5BwJWs0yMhp+YDOuW6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB8018
X-Proofpoint-GUID: yoM9NvL6bNV2VCr8F3KcxGN6vjbJ8IP9
X-Proofpoint-ORIG-GUID: yoM9NvL6bNV2VCr8F3KcxGN6vjbJ8IP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100096

Hello,

I have some questions inline before sending out a new patch.


....
>> +struct ad7779_state {
>> +	struct spi_device *spi;
>> +	const struct ad7779_chip_info *chip_info;
>> +	struct clk *mclk;
>> +	struct iio_trigger *trig;
>> +	struct completion completion;
>> +	unsigned int sampling_freq;
>> +	enum ad7779_filter filter_enabled;
>> +	/*
>> +	 * DMA (thus cache coherency maintenance) requires the
>> +	 * transfer buffers to live in their own cache lines.
>> +	 */
>> +	struct {
>> +		u32 chans[8];
>> +		s64 timestamp;
>
>	aligned_s64 timestamp;
>
>while it makes no difference in this case, this makes code aligned inside =
the IIO subsystem.

I might be missing something but I can't find the aligned_s64 data type, sh=
ould I define it myself
in the driver?

>
>> +	} data __aligned(IIO_DMA_MINALIGN);
>
>Note, this is different alignment to the above. And isn't the buffer below=
 should have it instead?
>
>> +	u32			spidata_tx[8];
>> +	u8			reg_rx_buf[3];
>> +	u8			reg_tx_buf[3];
>> +	u8			reset_buf[8];
>> +};
>
>....
>
>> +static int ad7779_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int val, int val2,
>> +			    long mask)
>
>long? Not unsigned long?

I copied the function header directly from iio.h, shouldn't it be left as s=
uch?

>
>> +{
>> +	struct ad7779_state *st =3D iio_priv(indio_dev);
>> +
>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>> +		switch (mask) {
>> +		case IIO_CHAN_INFO_CALIBSCALE:
>> +			return ad7779_set_calibscale(st, chan->channel, val2);
>> +		case IIO_CHAN_INFO_CALIBBIAS:
>> +			return ad7779_set_calibbias(st, chan->channel, val);
>> +		case IIO_CHAN_INFO_SAMP_FREQ:
>> +			return ad7779_set_sampling_frequency(st, val);
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	unreachable();
>> +}
>
>...
>
>> +static irqreturn_t ad7779_trigger_handler(int irq, void *p) {
>> +	struct iio_poll_func *pf =3D p;
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> +	struct ad7779_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>
>...
>

Thank you!

Best Regards,
Ramona


