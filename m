Return-Path: <linux-iio+bounces-4771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B88BA757
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 09:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2831F21855
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F401465AE;
	Fri,  3 May 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="IbB68EE9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15211465B0;
	Fri,  3 May 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719879; cv=fail; b=kbMINUxqlV6ddfSDGhOeoHvYRehpOPZuMlZTWPe3qP74A6jGn0S7ri9ULx7H1nFLHG6Z39jwpAb2/ioOEWfWrmB6d9SbOJRzvwNNCfRe0p/ZV5Y4qWdd4STu/iC88fbGn7UPH1PETzXfitNtUepouAW5FC2T/wnb7Hs5ZJY+PUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719879; c=relaxed/simple;
	bh=xNgAOyLFzvgkvyGU8fkPEfff0jg8KPOz91ihEpXU+3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXwhgsD5Ni6t7EFjq0NX5o4IRcWvHZpUhR/logHRTjL/gdOycxHE1AKM+1fZD4Rvov7Acm+kvMoKhcwLyvmf15xMM0s+eCKzJcvqYlq5JEO5uAMdcS+8Wy1amnbHWcp4IAaxrG2k5x5HZVHCI+WpT0Lvtk7Z8ylqIWq9uh+BNfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=IbB68EE9; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4434Wc8Z002997;
	Fri, 3 May 2024 07:04:20 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrqr03jmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:04:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgatdNpTVa4j8t2SugCrLG0+3ddr/kLyaRQOrDRU+uiCSC6td2yb2u/eS2RozWqxoBqDXe5YctmurXTnd1dETnPZrVjbn872VhMR8myU0MFsb6CTznu+D4LW3e8VpcDbPclQm6vZ6uBBVKtsM8VyLGxCVf8x0lJHa8DCITNPH+xjrVOYEJXw+cV/VeD1usA2CnRRfZRVOqEpSWafibpyjVygKY+Y3iNTsNlvwzPZh0X8aK9e4hz0St3pNm7UFhiN5dQo3mqUPAhxq4pfu1Y79iL8dwUy138NCjfnbpcqVTGeFZ5lL3YfiEMR8ldsTOGzELnJsO5SFseMH36ycoc+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSqdbM8kxNy0W7b6U9k+RZirqU28DFEwjJChXP+Wt+Y=;
 b=MLCmyNVzJBalvdHyr8/TY7hU9T7s5h/9lxu+ruh2UMi2us2SyLihfahpHTN0tEIn8kiHqx0OKGyp9Itu6bQKC0sPOf9ocuef7PC5NrdvosOjrYL88JWraHN5ICT1xscGaOqjnbZp+emNAT2WAGp8BFQHarE1jLjIsJkojTN/AHopl4u1TFDlmT9M4lFhhv4z0SjEUyCRyZKPzgdAw0EKWBTVA7F8dorLuFczHu08z6tsOeCof5HDvxWG1Nba+sJBGIm6SUW85YJ6y7H9lywJ53Bl0YMBODZL6bp4CJ10kDBpK3aEBRnT2j9TY9GRM35x9U3j3IwnsNS2f9n2hQnjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSqdbM8kxNy0W7b6U9k+RZirqU28DFEwjJChXP+Wt+Y=;
 b=IbB68EE94FuXe3FLVMyb7nVuLeri2ijCrutAQfngIdNEfCtUCAQGIcUFm6dREUk2UUirRrJ7AoW2Ke1zS8pJMgu99yO0TvVhbpSzS8HUiSup/1DJuE2hS6IN2Sm8NKBYpyPLTIUpx1Ipdrq5Z5Br3t2F/W7Pl9vbrlQ1PnzF0Vaju6+PuVQz4SMkDgpMrAtnrrk+lyBbEVm9eN1Lm2gp5XaLnLP3CHmeUAA2MVmZ5qZdaC4m3zWfLDqNiBziZStHlLX9Dv02lLKhMyzOifND+nbb8OfRn3mRIxFieDYqpIzuh4WkiVpgEr/OZ/gyhPonHAQZTV4PTMFKZROtd5Vr/A==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2357.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32; Fri, 3 May
 2024 07:04:15 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 07:04:15 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency
Thread-Topic: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency
Thread-Index: AQHal774Jv/S3801zESb+l1qZEmMLbF9rFKAgARZC4CAAa2MlYABbPBu
Date: Fri, 3 May 2024 07:04:14 +0000
Message-ID: 
 <FR3P281MB1757C8536898C39A30BEFD96CE1F2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240426094835.138389-1-inv.git-commit@tdk.com>
	<20240428141349.116ad03c@jic23-huawei> <20240501083733.207c27a5@jic23-huawei>
 <FR3P281MB175720998BDD67CC2A157A82CE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: 
 <FR3P281MB175720998BDD67CC2A157A82CE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2357:EE_
x-ms-office365-filtering-correlation-id: 843d1f39-4f18-449c-4dab-08dc6b3f3e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?l8wdH06b4Z0B5n3Jr9iWDwjxkHD/d3Q/Rz9Hd8bvo6UYef/acD5SMy0omd?=
 =?iso-8859-1?Q?Dwr4gNTWgFc0JZfLojV3ZMj1eNjPbZQFB3Ana9tNg1gJ0e2V88/DGOoXrk?=
 =?iso-8859-1?Q?f4S247tL9+ZsfQADMhsWed3v/6aAQN1fYvf0r0iBIUMgPtOPsl1i7Nz5tC?=
 =?iso-8859-1?Q?CIl1kKfszzaSJ1/3OIb2SR0BNkK57PW/VZNCLf130L4xjsZwcDdHjLsu2E?=
 =?iso-8859-1?Q?c/r2FtUcbyStXpK+j36VqqdON3iG1jEHpQDp63OSfWytNxF1y5gsRMNH/K?=
 =?iso-8859-1?Q?1DfxEl3dqtYSee6dfSrpQSDrdygMjpa1FqxgA5aEjMhnoC1V/rcmTG+Dtw?=
 =?iso-8859-1?Q?iDwGIUWTVtKhRq7gEb5wBO0F39hsbP+meHohA0ooo3Mm2mPRnL0wNgZrvG?=
 =?iso-8859-1?Q?DF6bfa7/+k5XYrQBP1GuZoFct2SA8o62W5VgDY1XQNW4AwbmYGld0e1u/7?=
 =?iso-8859-1?Q?hrlnzASS1+kxiBKz21QMaHX3d/AzOuwU1T2S2I/DGhN1OV88gyh3BNzfPd?=
 =?iso-8859-1?Q?vIcRZEZAcdM2YWg6UaQxYpHibDfon1dZSX1COz+RlXF2tTANzRLWOmMnF7?=
 =?iso-8859-1?Q?ZwNvPYAX15an3Flm3dzDRGlQUShu4sqO1Ao6KZTtrqOhNFuVbfsCpMrVgV?=
 =?iso-8859-1?Q?VaTT9Ok5HJD/OncKjpc29FN0slNkLiNzlU+OgHeGNHBwZgQAaJap5fyX72?=
 =?iso-8859-1?Q?WpAhPBMdG80e9IHxatxCKpi7nMx1s/qHROILVIFciClfVkGbhhoZ5IYsKM?=
 =?iso-8859-1?Q?VDg1QJoj2c0iDKSYC5tRuEkYkb5YtN29Cj9HI+SHOC9IEtz1UII9KnvD+V?=
 =?iso-8859-1?Q?nYpapfT5a5BDfr0UTWuUasIZhwCSpJ2pPEVEfi1EdR6a8vwMspldj3vb7V?=
 =?iso-8859-1?Q?R8vPHCYY11AH4Ve7xc7sqqQtGPDdHEk5uhIUV8Ii2xEYg//k3aCxlmHKpy?=
 =?iso-8859-1?Q?HI3TiWcu6+F4oVzOVbJ8dfR9n/1KLLLgA88MIEsKXGZnhC/jIOKppfJK9+?=
 =?iso-8859-1?Q?PmvCTTSiWV8fz+bvDUfEfjil2c6Uw7tJA+Fr+apNfVmSXS+12RqGE2HTPO?=
 =?iso-8859-1?Q?8ikfbLsYNIuAGAP26JEpo/o/8PpDNHFgqBwSyb5MR+FyjyBHKck7CPDMpv?=
 =?iso-8859-1?Q?BoxfUxOmMW/QSATXmtdHxfjQGbkLtNVUOc6YQzSGPqQFN/miBX4mtB28Ep?=
 =?iso-8859-1?Q?JOvJsmdLGCYIv94vN4+Mylkt3fIbEoVBnThFQXM55SlP4CcDBJjmeYjELv?=
 =?iso-8859-1?Q?2T66tuBCU7pQ0xz+c4pXxKSzgTCmaB2WC/+PyopzTmuYDpdVKhfgZcjeQC?=
 =?iso-8859-1?Q?n8FERTid6aTciL1qiPzt0rhbC9WFiyeyx2FjCTRMAD5L8c4iMMtnXFuft/?=
 =?iso-8859-1?Q?M3BtJ59yDzJezJxx0Aa3baIGSxtezdSg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?eQm0BeD2uEjkKR+mxrbU10KssLe10o/9aDzZCTxxCgyBnbX7SOoYYeikmh?=
 =?iso-8859-1?Q?Rl3VVDHXS4UH0wkQrHaZeRftW4WCp925DrCis35x9ookCs+KN/Ml7BkQ6Z?=
 =?iso-8859-1?Q?SrmylSwmryCPGqwMPgvqlZ4i+ip99fNsMNsehXxQB0CfSZWDX28QYQSUHE?=
 =?iso-8859-1?Q?JBK4V/i2LDQ79jumm1KODLlmN5/McAvyGl2Y+fgpUKlwDRUYQ/Z83l35Vm?=
 =?iso-8859-1?Q?ghIUcrxqOfYgMdZxv8//zqQaLInjp01uF5jG7buHlPBUneXVWOxjNuWCww?=
 =?iso-8859-1?Q?b1UMH9MulRVbSFcXbyxYVXuofS3An3mT1qIMOHDG2R3ao29m7ho24J9W2g?=
 =?iso-8859-1?Q?Be4L5eumohIeEFtGDOMsbFgQEgepLYHbxyWvCqUsD7XmMdyIvVmutu/9Nj?=
 =?iso-8859-1?Q?QQfBtu16dQJt7No2oqdmx53qAoDjAi17bHw75KiWfhJCJwNDbvyuSElHEL?=
 =?iso-8859-1?Q?PzF/QReIAJwZUeTdgKIthc+gUDkOOz5phscz+PoSNmHMumRq0kgjcLVeTG?=
 =?iso-8859-1?Q?96xnRZgoTSWstjmpiE3sBzE3wIut77giic2PFhdogoBtPs4/rTemhpw5sY?=
 =?iso-8859-1?Q?1PMcwFpMt+tDMNdchD41gcWloZADSoGxl9H9Yh/NwpoQQKds3Er5tASIH5?=
 =?iso-8859-1?Q?8rWpNDXRgHUWMnmheIqpqTln6MIE4dmEabAz2ISK6jIQKTZI2Jv6fnVca2?=
 =?iso-8859-1?Q?yiQs12+WYw3unscLbQtR0sBgkFGw2n54bJ9ESwWPBM9XvrXBcGS0dZUWzW?=
 =?iso-8859-1?Q?Mg/4kmhU2Np+AYQEYtlvs7cBoOaPsX4MmNUOzFOzF8ldr5gFloRciwbk+M?=
 =?iso-8859-1?Q?Lu7woPzi98dihBgNRS/3KNpPi1EdKzYLmQ9ZvwdahmKjgHPMz/jwPOSy8D?=
 =?iso-8859-1?Q?kDgcl0iZNpMxC100JqppEarFRWFu7zSeIlf2r5P9itGapR1+pgrZyC3mah?=
 =?iso-8859-1?Q?bg8u1B/qY/KhwhnYD3/9fLdwPtTjk3jHXxkMXTw4MfyloFeI10W8r4/egi?=
 =?iso-8859-1?Q?cXw333W8LyeyY0BHL0Bi8ew2i2aoRA8OfDilOwOz6ZR+S2c0ubHndP9mwS?=
 =?iso-8859-1?Q?qfN7mvqb69TglmloxlG96BIQ+s7WhMcDKV3Agt8+a9Z1j4+5kGv5fV3nrF?=
 =?iso-8859-1?Q?DKxEOXvwCJ6wvgHipbySkVF+VTVPID1Xk+/J7N9yCLvQ5BB5HhKajy8A2p?=
 =?iso-8859-1?Q?0JR8vNImKdlRDsXtWmkfYMBieOy7LBu45lwGqYMcZgPvTfcwuiwISpQvNp?=
 =?iso-8859-1?Q?tNI6zRckXL2vrgLYk2vm9kBqy5GxE0d9c9OXuio429KQP7sIyazq6HJlvS?=
 =?iso-8859-1?Q?D83aluAOAtFz0OF28zO9819ZBPdIER8QSJiCIOgXSe27FwdBocoU8DCNHV?=
 =?iso-8859-1?Q?8b57SUVdtbWGCe33UyExw6Qm7/Dz+/u2rtnSx2VY/49DKhvywVYe1ujE6w?=
 =?iso-8859-1?Q?bG3Bg0i/k7KRjvQbsq3tPPBnnnVl1ukIbmbekeaLqGqD58GGZfd12CGWh1?=
 =?iso-8859-1?Q?kByPIm6oOvnfn4YF0TSuAoCcu7yG3KEMjioxLjEZsWJ1bFOoOdUvQqCWA3?=
 =?iso-8859-1?Q?kBRGdrJeaMrEOVP0w3SZdMNNJaCUfPFXJlVmRRcSObkO2liAJ4gXMciogQ?=
 =?iso-8859-1?Q?9R9DD0gSbRB9CxlSn6NsmPL72aiFaQg8iSghD/4b1hYqSqGxVBT8bb23mV?=
 =?iso-8859-1?Q?sV6/xrek8ztZe0h8sk2zqe0rkIu3ldsNv0r8y548FOxTnSF30ne9W2j85D?=
 =?iso-8859-1?Q?RutA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 843d1f39-4f18-449c-4dab-08dc6b3f3e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 07:04:14.8264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9d+ybC7NkzLDxLOrp0JN+H7hnZzcKw/deAtQuG40d+TcboH37aV+yC/qBdi27gUXTDl18JNJFAqD656RtjDpCpIR5ShXXjZhoxC3yI/4i/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2357
X-Proofpoint-ORIG-GUID: IMk2uoArExTtMmKn_biSpGMSBu0jPcVw
X-Proofpoint-GUID: IMk2uoArExTtMmKn_biSpGMSBu0jPcVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405030049

Hello Jonathan,=0A=
=0A=
I see that this fix has now been pulled.=0A=
=0A=
Do I need to create a new fixes patch that fix this patch porting? inv_icm4=
2600 is currently broken now inside the current IIO tree.=0A=
=0A=
Thanks for your help.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Sent:=A0Thursday, May 2, 2024 11:15=0A=
To:=A0Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit@t=
dk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] iio: invensense: fix timestamp glitches when switchi=
ng frequency=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
Hello Jonathan,=0A=
=0A=
beware that your porting of the patch "iio: invensense: fix timestamp glitc=
hes..." is not correct inside togreg and testing branches.=0A=
=0A=
Inside file drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c, you must ke=
ep the sensor_state structures declaration and use them to get the iio_priv=
 structure.=0A=
=0A=
You need to keep the following declarations in inv_icm42600_buffer fifo_par=
se and hwfifo_flush functions:=0A=
struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro);=0A=
struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel);=
=0A=
=0A=
And you need to replace =0A=
ts =3D iio_priv(st->indio_gyro) by ts =3D &gyro_st->ts;=0A=
ts =3D iio_priv(st->indio_accel) by ts =3D &accel_st->ts;=0A=
=0A=
Correct diff should be something like:=0A=
 =0A=
@@ -512,20 +510,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm4260=
0_state *st)=0A=
                return 0;=0A=
 =0A=
        /* handle gyroscope timestamp and FIFO data parsing */=0A=
-       ts =3D &gyro_st->ts;=0A=
-       inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.to=
tal,=0A=
-                                       st->fifo.nb.gyro, st->timestamp.gyr=
o);=0A=
        if (st->fifo.nb.gyro > 0) {=0A=
+               ts =3D &gyro_st->ts;=0A=
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,=0A=
+                                               st->timestamp.gyro);=0A=
                ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
                if (ret)=0A=
                        return ret;=0A=
        }=0A=
 =0A=
        /* handle accelerometer timestamp and FIFO data parsing */=0A=
-       ts =3D &accel_st->ts;=0A=
-       inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.to=
tal,=0A=
-                                       st->fifo.nb.accel, st->timestamp.ac=
cel);=0A=
        if (st->fifo.nb.accel > 0) {=0A=
+               ts =3D iio_priv(st->indio_accel);=0A=
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,=0A=
+                                               st->timestamp.accel);=0A=
                ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
                if (ret)=0A=
                        return ret;=0A=
=0A=
@@ -554,20 +550,16 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42=
600_state *st,=0A=
                return 0;=0A=
 =0A=
        if (st->fifo.nb.gyro > 0) {=0A=
-               ts =3D &gyro_st->ts;=0A=
-               inv_sensors_timestamp_interrupt(ts, st->fifo.period,=0A=
-                                               st->fifo.nb.total, st->fifo=
.nb.gyro,=0A=
-                                               gyro_ts);=0A=
+               ts =3D &gyro_st->ts;=0A=
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_=
ts);=0A=
                ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
                if (ret)=0A=
                        return ret;=0A=
        }=0A=
 =0A=
        if (st->fifo.nb.accel > 0) {=0A=
-               ts =3D &accel_st->ts;=0A=
-               inv_sensors_timestamp_interrupt(ts, st->fifo.period,=0A=
-                                               st->fifo.nb.total, st->fifo=
.nb.accel,=0A=
-                                               accel_ts);=0A=
+               ts =3D &accel_st->ts;=0A=
+               inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, acce=
l_ts);=0A=
                ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
                if (ret)=0A=
                        return ret;=0A=
=0A=
=0A=
Thanks for fixing this,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Wednesday, May 1, 2024 09:37=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Jean-=
Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0Re: [PATCH] iio: invensense: fix timestamp glitches when switchi=
ng frequency=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Sun, 28 Apr 2024 14:13:49 +0100=0A=
Jonathan Cameron <jic23@kernel.org> wrote:=0A=
=0A=
> On Fri, 26 Apr 2024 09:48:35 +0000=0A=
> inv.git-commit@tdk.com wrote:=0A=
> =0A=
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> > =0A=
> > When a sensor is running and there is a FIFO frequency change due to=0A=
> > another sensor turned on/off, there are glitches on timestamp. Fix that=
=0A=
> > by using only interrupt timestamp when there is the corresponding senso=
r=0A=
> > data in the FIFO.=0A=
> > =0A=
> > Delete FIFO period handling and simplify internal functions.=0A=
> > =0A=
> > Update integration inside inv_mpu6050 and inv_icm42600 drivers.=0A=
> > =0A=
> > Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)=0A=
> > CC: stable@vger.kernel.org=0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
 =0A=
> =0A=
> Whilst I don't fully follow the logic here, the new code is simpler=0A=
> and seems reasonable.  Getting my head around this will probably take=0A=
> longer than it's worth :(=0A=
> =0A=
> Hence applied to the fixes-togreg branch of iio.git.=0A=
This made a bit of a mess wrt to some new part additions that went in=0A=
via the togreg tree.=0A=
=0A=
Given timing I'm going to pull the fixes on top of that tree so this=0A=
will need a manual backport. Please take a look at iio.git togreg=0A=
to check I didn't mess anything up.=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Jonathan=0A=
> =0A=
> > ---=0A=
> >  .../inv_sensors/inv_sensors_timestamp.c       | 24 +++++++++----------=
=0A=
> >  .../imu/inv_icm42600/inv_icm42600_buffer.c    | 20 +++++++---------=0A=
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 +-=0A=
> >  .../linux/iio/common/inv_sensors_timestamp.h  |  3 +--=0A=
> >  4 files changed, 21 insertions(+), 28 deletions(-)=0A=
> > =0A=
> > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/d=
rivers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> > index 3b0f9598a7c7..5f3ba77da740 100644=0A=
> > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> > @@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct inv_sen=
sors_timestamp *ts,=0A=
> >  }=0A=
> >  EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS=
_TIMESTAMP);=0A=
> > =0A=
> > -static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint=
32_t period, uint32_t mult)=0A=
> > +static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint=
32_t period)=0A=
> >  {=0A=
> >  	uint32_t period_min, period_max;=0A=
> > =0A=
> >  	/* check that period is acceptable */=0A=
> > -	period_min =3D ts->min_period * mult;=0A=
> > -	period_max =3D ts->max_period * mult;=0A=
> > +	period_min =3D ts->min_period * ts->mult;=0A=
> > +	period_max =3D ts->max_period * ts->mult;=0A=
> >  	if (period > period_min && period < period_max)=0A=
> >  		return true;=0A=
> >  	else=0A=
> > @@ -84,15 +84,15 @@ static bool inv_validate_period(struct inv_sensors_=
timestamp *ts, uint32_t perio=0A=
> >  }=0A=
> > =0A=
> >  static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,=
=0A=
> > -				    uint32_t mult, uint32_t period)=0A=
> > +				   uint32_t period)=0A=
> >  {=0A=
> >  	uint32_t new_chip_period;=0A=
> > =0A=
> > -	if (!inv_validate_period(ts, period, mult))=0A=
> > +	if (!inv_validate_period(ts, period))=0A=
> >  		return false;=0A=
> > =0A=
> >  	/* update chip internal period estimation */=0A=
> > -	new_chip_period =3D period / mult;=0A=
> > +	new_chip_period =3D period / ts->mult;=0A=
> >  	inv_update_acc(&ts->chip_period, new_chip_period);=0A=
> >  	ts->period =3D ts->mult * ts->chip_period.val;=0A=
> > =0A=
> > @@ -120,16 +120,14 @@ static void inv_align_timestamp_it(struct inv_sen=
sors_timestamp *ts)=0A=
> >  }=0A=
> > =0A=
> >  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,=
=0A=
> > -				      uint32_t fifo_period, size_t fifo_nb,=0A=
> > -				      size_t sensor_nb, int64_t timestamp)=0A=
> > +				     size_t sample_nb, int64_t timestamp)=0A=
> >  {=0A=
> >  	struct inv_sensors_timestamp_interval *it;=0A=
> >  	int64_t delta, interval;=0A=
> > -	const uint32_t fifo_mult =3D fifo_period / ts->chip.clock_period;=0A=
> >  	uint32_t period;=0A=
> >  	bool valid =3D false;=0A=
> > =0A=
> > -	if (fifo_nb =3D=3D 0)=0A=
> > +	if (sample_nb =3D=3D 0)=0A=
> >  		return;=0A=
> > =0A=
> >  	/* update interrupt timestamp and compute chip and sensor periods */=
=0A=
> > @@ -139,14 +137,14 @@ void inv_sensors_timestamp_interrupt(struct inv_s=
ensors_timestamp *ts,=0A=
> >  	delta =3D it->up - it->lo;=0A=
> >  	if (it->lo !=3D 0) {=0A=
> >  		/* compute period: delta time divided by number of samples */=0A=
> > -		period =3D div_s64(delta, fifo_nb);=0A=
> > -		valid =3D inv_update_chip_period(ts, fifo_mult, period);=0A=
> > +		period =3D div_s64(delta, sample_nb);=0A=
> > +		valid =3D inv_update_chip_period(ts, period);=0A=
> >  	}=0A=
> > =0A=
> >  	/* no previous data, compute theoritical value from interrupt */=0A=
> >  	if (ts->timestamp =3D=3D 0) {=0A=
> >  		/* elapsed time: sensor period * sensor samples number */=0A=
> > -		interval =3D (int64_t)ts->period * (int64_t)sensor_nb;=0A=
> > +		interval =3D (int64_t)ts->period * (int64_t)sample_nb;=0A=
> >  		ts->timestamp =3D it->up - interval;=0A=
> >  		return;=0A=
> >  	}=0A=
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> > index b52f328fd26c..9cde9a9337ad 100644=0A=
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> > @@ -509,20 +509,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm=
42600_state *st)=0A=
> >  		return 0;=0A=
> > =0A=
> >  	/* handle gyroscope timestamp and FIFO data parsing */=0A=
> > -	ts =3D iio_priv(st->indio_gyro);=0A=
> > -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.tota=
l,=0A=
> > -					st->fifo.nb.gyro, st->timestamp.gyro);=0A=
> >  	if (st->fifo.nb.gyro > 0) {=0A=
> > +		ts =3D iio_priv(st->indio_gyro);=0A=
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,=0A=
> > +						st->timestamp.gyro);=0A=
> >  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
> >  		if (ret)=0A=
> >  			return ret;=0A=
> >  	}=0A=
> > =0A=
> >  	/* handle accelerometer timestamp and FIFO data parsing */=0A=
> > -	ts =3D iio_priv(st->indio_accel);=0A=
> > -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.tota=
l,=0A=
> > -					st->fifo.nb.accel, st->timestamp.accel);=0A=
> >  	if (st->fifo.nb.accel > 0) {=0A=
> > +		ts =3D iio_priv(st->indio_accel);=0A=
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,=0A=
> > +						st->timestamp.accel);=0A=
> >  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
> >  		if (ret)=0A=
> >  			return ret;=0A=
> > @@ -550,9 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm=
42600_state *st,=0A=
> > =0A=
> >  	if (st->fifo.nb.gyro > 0) {=0A=
> >  		ts =3D iio_priv(st->indio_gyro);=0A=
> > -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,=0A=
> > -						st->fifo.nb.total, st->fifo.nb.gyro,=0A=
> > -						gyro_ts);=0A=
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);=0A=
> >  		ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);=0A=
> >  		if (ret)=0A=
> >  			return ret;=0A=
> > @@ -560,9 +558,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm=
42600_state *st,=0A=
> > =0A=
> >  	if (st->fifo.nb.accel > 0) {=0A=
> >  		ts =3D iio_priv(st->indio_accel);=0A=
> > -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,=0A=
> > -						st->fifo.nb.total, st->fifo.nb.accel,=0A=
> > -						accel_ts);=0A=
> > +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);=0A=
> >  		ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);=0A=
> >  		if (ret)=0A=
> >  			return ret;=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c=0A=
> > index 86465226f7e1..0dc0f22a5582 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> > @@ -100,7 +100,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
> >  		goto end_session;=0A=
> >  	/* Each FIFO data contains all sensors, so same number for FIFO and s=
ensor data */=0A=
> >  	fifo_period =3D NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->c=
hip_config.divider);=0A=
> > -	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, =
pf->timestamp);=0A=
> > +	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);=
=0A=
> >  	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);=
=0A=
> > =0A=
> >  	/* clear internal data buffer for avoiding kernel data leak */=0A=
> > diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include=
/linux/iio/common/inv_sensors_timestamp.h=0A=
> > index a47d304d1ba7..8d506f1e9df2 100644=0A=
> > --- a/include/linux/iio/common/inv_sensors_timestamp.h=0A=
> > +++ b/include/linux/iio/common/inv_sensors_timestamp.h=0A=
> > @@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_senso=
rs_timestamp *ts,=0A=
> >  				     uint32_t period, bool fifo);=0A=
> > =0A=
> >  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,=
=0A=
> > -				     uint32_t fifo_period, size_t fifo_nb,=0A=
> > -				     size_t sensor_nb, int64_t timestamp);=0A=
> > +				     size_t sample_nb, int64_t timestamp);=0A=
> > =0A=
> >  static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_tim=
estamp *ts)=0A=
> >  {=0A=
> > --=0A=
> > 2.34.1=0A=
> >   =0A=
> =0A=
> =0A=
=0A=
=0A=

