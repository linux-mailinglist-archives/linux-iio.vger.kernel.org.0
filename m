Return-Path: <linux-iio+bounces-20590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E6AD8C6B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24927A7CEF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6E4C97;
	Fri, 13 Jun 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="pqjoS+U4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4B125B9;
	Fri, 13 Jun 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818841; cv=fail; b=IZ0J2fimj2/R3RKpanWctCBiIc8gtGr2aeOCl+c2VY00hjDY1BFzbQ/jNRPmk2gBMC0GNkXjcqrh3b49qx6KNxNGCxv1RKVfuXztOP3IGK898GiqIPu6QEHBB/PL50UNrxo9lEm019LfpFEqnfolcOpEkmUUngFEmg6JWzBEVOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818841; c=relaxed/simple;
	bh=zU9yT+Ypkj8YwGlt0CkaDPDNnWBBko8EeW3cLOyAL9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ju9NJim3/C5C9mIeuQaL6/xKDGZYeZOuDCs1YlpYR10jExrLKRV8KmOClYlmxuMdIFTlAZJPUO8AVvqyEi67mZjElMYk3/e6Mi6ak/FfV3N2FKunqa/I9sE33PliiuY6DRQ7uQN4cfneuxFvWZVdsrQ/uaYriYXfDVNwXRe1n4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=pqjoS+U4; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CMNqb7002415;
	Fri, 13 Jun 2025 12:46:54 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012053.outbound.protection.outlook.com [40.107.149.53])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474bt34xmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 12:46:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQu44GDr38r90giON9AMURKuRkwOfVIcYkO/APGXJNE29pf6223hKmGEB5BbkZS8EVOK/a8l/5kJtjdoEe5AgIpZpXFuGYxF5VdPYaCi5thSX1uEmfx86rueHV1AW1FROm2CyBLGClwS58AprpB0NtTk/wPmQClHwXbPTpQX7/BohDa9lnOEzlLpbLRYiFj9I48c3TGf+agaV5s2gdyFoN8LvJlqVas56B+HW8yQAcVhfy+rheiZm4luGp2IdPUADSLsN6T7HGPDhr3nmFgrWc7nOyswhBfh7piPKV0ZUnbRNqElT9uQekKg7tRHBD+oFnldiuy6Q5nh05XpIz+N5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2XxtP5OKEn2HmIXEG426VEaBd6fPuDOrtNXLtrLnVM=;
 b=iaTTkvoORt5+flTkSKfxMooxs29JteYoJOb0wx4HlL0rceBOlj4bwo04KNqLnZdcBnzbXeCnKifuzRlYfLsOiUFpqLCZYay1cNUcjfU4FG66qAectas1kq5rFZpSYDIN9tOID5ZWQpNVGc46euUHa0/zxRHHffcCVN8m87Sear+J1m9KDnaU52C/iliFxx0ys62DeITWwHlH+GM2MN6YqnOTcgVQlhmceej1PXwPRLmU4jw/L72PTKtOHioq5IW6e5j/dNymWZ7gdN3JojUiz/nvr2k5Op+/b6mhMJWA9D9tXp+Xce1GCpocmlcds7wVOOISdoH4/6aVt3f7wthtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2XxtP5OKEn2HmIXEG426VEaBd6fPuDOrtNXLtrLnVM=;
 b=pqjoS+U4yarToXnsOEfsZznaKX/CmBjUc9vX5ULWbt4RjuDgWRGRko+FEULarN/SFHPcHRDEZ3pv85ajHDOW3RNQ8vN7onNoCNNQXcQfjkLXXreqxq97SEHil6opn/2XCHSQkuFIAnoTMa4vJhhlZZFjpEuvvjSPERMejjO/m8OiLjJBDtrBE85lc0ihl69inznovWcs147CmlUMnj78rDvNl61LvBxM2er+nKs9u8kUPoUwqUzxPyFCFmdPYcTWC3lEO7a6qz+5bm2YSh6sLWXzd/ekF8TfcpM6FMQyhuLZWdlsi1tg7qS7WyrEP0kyZOZN0/QYLmzl1W1rX7gsTQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1PPF69B630C7C.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::653) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:46:46 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 12:46:46 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHb3DWiaJg6fqmsLkOWVuHD5p4+yLQAwiAAgAA2IOg=
Date: Fri, 13 Jun 2025 12:46:46 +0000
Message-ID:
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
In-Reply-To: <aEvhZiXHLLIRe41-@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1PPF69B630C7C:EE_
x-ms-office365-filtering-correlation-id: 48619371-0d71-4066-e39a-08ddaa785b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TXTE54+NBGDTZbBO31Xz/5NezG6z4aql45G963JpiGSvRq6Uol+FarbWnk?=
 =?iso-8859-1?Q?NG9AQWAHgQKXD3TQoH0EKXoY8Xpo7lx4Wlew384L4O3lCPcUcCFvzVAu3N?=
 =?iso-8859-1?Q?zYVTNozVnh+ZSx0YrgJ+ahA2JKyt/SD/FJdx0y2vS9SUAbOapoJXTaWJhU?=
 =?iso-8859-1?Q?lIYwSO42Eu96gXQH/C8J6CEgoRfuW4noaevatYiZaq7XtDl5HVrnVrZMZe?=
 =?iso-8859-1?Q?uUUB4RJgAo28nDIcbjgjVkYsc6FQu8fNFB1EPPQIjQsIpzxynZpq94BH+b?=
 =?iso-8859-1?Q?GAPTWUTCE5C0w7zNDnB4yJVaOgtTvY//LqqDALVseDsHSCwG8nWRLwKeMD?=
 =?iso-8859-1?Q?pK7y9g067WfSeLnHsz0hiWAmKUwzZfpoFYAGi5wGQvbcuiw1JUzme4pyby?=
 =?iso-8859-1?Q?DPo46/2PVkM+W0Klvd1Pus+za6GwfflJYBO0/UCOq1oKjbB6q1STSxLsPm?=
 =?iso-8859-1?Q?UI3RWMHNBOYOfT8OM/WcEIn6z31XLsw3/sPCLMKixBwJUANgL5VlRWn9P3?=
 =?iso-8859-1?Q?ue56wEdqIBvT9TaEKkEXMtJmpHmX5ehlu5YFv0euE20gGVmNCIcfw5Vh72?=
 =?iso-8859-1?Q?X7k5wb48GSlISRYhcZuyiPFVX9WxlhhQmGPtInWXAyPmxCmzBqtGTV0B05?=
 =?iso-8859-1?Q?jRzsF8pyYrGjuQBKFiULfmvnLYzsX2iovKo0mS4yGBqpiWX6q2WalTGaAT?=
 =?iso-8859-1?Q?BS4VfeRmPRRNK7mYuYKZuIW72TzFhSEs7sHqzYtzfrNMXdgdx28b/N5PK1?=
 =?iso-8859-1?Q?F6OdLbpCp+Svg61MmR2zU2DwfGo59tWajYs43oaOgCLZT1/bBvbFSt4+4/?=
 =?iso-8859-1?Q?MS+G/g7qKdXCeVb23W7bqTCdU9eajxGZYIoHH4/x5u6SzC/t9/4MI312qQ?=
 =?iso-8859-1?Q?cfaXSA7O0DjpGQAzAScAJXMeHwQWcL5JzWT940NtSh9FvttNlqUqX12wJw?=
 =?iso-8859-1?Q?mjA64QskuF+hWq2qQVK9+XRerratP7NB6cw+5oiewLaSrDYWTY9ev6dUqx?=
 =?iso-8859-1?Q?CQDj8+Jze9wz4SP8cJkDvbRH/glrwmYPjSBT99paZV/tN4KAzRgrfqWLKt?=
 =?iso-8859-1?Q?2kTWHmHozbzOfu52fv0bFOmgQbWDfLE3L7AOSl4c++ebRk11xTZHQnUFZa?=
 =?iso-8859-1?Q?wcNyRT1heRXK8JRSm4d90509/ovdJrb5dZVRGz0N4MpjNwpDLdFVYRjpCv?=
 =?iso-8859-1?Q?LZRlEp1dH6a4TvOhnk7iM5L/FGrYowsiEhppQACjSbvL0yg2yTF6r+vdwa?=
 =?iso-8859-1?Q?LyGgGTLx4exrMCcBCLBfqGV/rm4nvBd0I391QPsmGNW8T/V68lmh+2Odgo?=
 =?iso-8859-1?Q?KfRD4KeJ88CavYF5zmUbLW/o/EMYhrPzwORLNBOd7x1IoLoYfzJWPnz4uo?=
 =?iso-8859-1?Q?pfRSRFf1zdeJE4LDm1Pud5tye1RIKToSKChq/cLTTXQxMW0sfUv4eJ+iQH?=
 =?iso-8859-1?Q?ca+ilubGedajBfY7sKeqw8BV7fDga7HgskoaB9aR1Tdm/FLDhR7m4bmUCQ?=
 =?iso-8859-1?Q?aq+7CamV5m2S/55rJEaTsQV3+lkXT9SlGpgQ6aPHWRyRTnKHfvkLKb6qbP?=
 =?iso-8859-1?Q?CvAykXHw2iZPtaR/HrQtGgHcszsn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cn0jHq/3x0NANp3YF465t+MufTjHjpZ4eJJVdXhXAeO9oIHd2QE3z0zdrk?=
 =?iso-8859-1?Q?6wVhkQb7m6vbV2bvDIsk844NEccO/kCgyOTXOic2HHMfO8NrzrPuL2cU9J?=
 =?iso-8859-1?Q?R2sxqcfpZlTzoEnU2CQm4RaYabimsVvXtGBmQmaD5cEEgZRIlQuc8A6R56?=
 =?iso-8859-1?Q?RfKAobNdZRtJMzpTh4utoGmeT81bb3iL34jWXgOIZanDUYlus9qoWSVSFg?=
 =?iso-8859-1?Q?EdOSAswY4mH6HKZN4pdr3mg8ISlp8xgoByrAM571m8k+Wq18Eb2g4aUiTs?=
 =?iso-8859-1?Q?DBu56Cc9uneTTwVM3jvjR9nOSXgXXHuEiuiny7R7yp2P8v+f/BzniVsLIq?=
 =?iso-8859-1?Q?76c3yu3vCFEPtzIET0cJoOVPyLx+bIl+pMXHTV6M8i0Bqq6OekAWCirKj7?=
 =?iso-8859-1?Q?cFYMKMMgQqeaaH6x8thi3UaWX0zIuCUZ+6iTs87hknheacjhd/JWXwKTQH?=
 =?iso-8859-1?Q?qZk86vuyCtKfhWv8EiIUAhF8rR6QdQPEclfke08LE6AFCnIZzy6L/4fQ6O?=
 =?iso-8859-1?Q?nrkLTc723mhAFbPRoDR1K1mlU6eOO4P7SvWPpz8cU+qtHUDiOMGwmsA43y?=
 =?iso-8859-1?Q?7vVX9PWjPlYitr2kuYwxclmXaAvIuWZYhA/XfWrM1tYjM7EUdCLP+WeaOK?=
 =?iso-8859-1?Q?t1aSXsv9z93OxsV3bLPKpw13yGiFGwvbNZiDBGSPYINiL+Sb0cXI88Lz4Z?=
 =?iso-8859-1?Q?4vkx950B5HxxiDBzzjh59nXhRvFhgNkgqlmp4EsrWMZ+1G+Jr8lA3ITux3?=
 =?iso-8859-1?Q?WShOtCyOAqx+tGK7hxpgvUI2JX9co+Gfk4hHPgK7hhdQyESHGEJr+0kC6o?=
 =?iso-8859-1?Q?xvoEUvosK3+Tv/dWDXpEbouRvjZ8FBHC+WJyRs6QgoBe3W0P0dyIuG7tGH?=
 =?iso-8859-1?Q?TDfbJuZkZPRiSQDKM/DBoCJxP2EXc6Dk9pgvvpTD5DzZu3ha7z24NKSKpy?=
 =?iso-8859-1?Q?M9qpPD0oxVU4Pll61DVQhkrrBH9/GNPsu1+fSPnTZiuxc4qc0EONzqqgWS?=
 =?iso-8859-1?Q?eqm3nLJ9v+yh0DGjwjYPEdQ5UVeT5aQexXHiPpL21slfNW9slrqBZuVRqn?=
 =?iso-8859-1?Q?UZ4tkoMsHPp260hLranLiDLllzBIkFgz1EQ6PhMxOrx/2VgY5ZNszmXKrN?=
 =?iso-8859-1?Q?bILROV3bMPIefcP9UY4TZcXMko9EXd21JGWW9UsxUTuoB0M4Uu6+bfHWmC?=
 =?iso-8859-1?Q?7fXsOlcHfeCw9fY4qpLr+PSetiklX9OJwUCmE41e7CdcMuIB3gJmH6myMW?=
 =?iso-8859-1?Q?pAQ+mL5BSs2yovOdh7P30qgCx8dL5cHoFi+9fE9kxqu9y4V4CYqKmrGcbR?=
 =?iso-8859-1?Q?kUfEnSBwCu7VEKT7Noq/3cGUVATJnnEQ02rbISo2jIc2Ii9MEIY1D5IvJ+?=
 =?iso-8859-1?Q?J/wElbtlxA0tGGkvaNiC7EuTYCkmLKaZDuB1jNuEtSIpRgqtZ2rmQUVLA3?=
 =?iso-8859-1?Q?o4Q9ir6Xpq0dMteUb7CKcK/cyz1jD3jcEo/bANf8qv9qEaN2HkdfBTlumV?=
 =?iso-8859-1?Q?IQB7ySa4GK2u3e+Rxm/u3OmBRMEk8pyHAvOeug+49+jgvzWCNBE11h3nr/?=
 =?iso-8859-1?Q?SdSS+71E/cmPL+B9vJmsE9BuiNt0mUWIO2KxouvcauvMy3iMIVNjR+HY8M?=
 =?iso-8859-1?Q?vSxq85d6Ap1c5qzWbjryF6y7BKN0Ptjiq3FdZxhhsyreSkpnTPY3qwi7Vy?=
 =?iso-8859-1?Q?gYity3Ob3XNn25bNbfKCoX9FHzatEHyb3E0pkbg0VOEGVM1o/jWWs2Nr6S?=
 =?iso-8859-1?Q?stbw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48619371-0d71-4066-e39a-08ddaa785b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 12:46:46.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSPBU8f3bYIphwU9ZoW+oLiEb2xbsHtu8vYh23EiRMzRS57L+5ScKle56iYmtZN+C5CWUT9Rx0kDBM506LnH1puBJ0ukGmMz+vu4XzMU5/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF69B630C7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA5MiBTYWx0ZWRfX7Lp8Bc7Gk4Go
 GIPqLW/JMe9SADy5dql0MFyKDMPAxnhCNhP9u9CvaTzPhfXcn2yM5lVstHob+hgCf0cU6ypSx/a
 wK3rW7dkaApvd0p2bC58V83hfTjHoZjSLgyxm558mV5R5Lfy2vmBXGrA/1q/x36499vo5HsGMVS
 1iGdOLgxDIJNBnueL4tIta776+0wt5g2azO7NyHZHMilr9ukfOQ8P8r0QadExf+HhDq6U5ICh2w
 ppYi0lnPHh48krpaW1BEcM+5O+m4s5vKdp8792c2kB4SYHHiV4LaHeEZQFPzDSJTdLxj9/QgjQZ
 QAUUy2OiIIdO9FDjPcNVy9ZvqrQrz+7UD6HNriuDTrHh8idI7PArtDa3lZH6hUfhzoAr7NjQ8gW
 C624h6ulthwnQNpjNpApr7xq7BTQHP9wEVGEhDa2dtH2WiU00Cc4p+MqKDqn0Jxvzl5gD1Tx
X-Proofpoint-GUID: uidyjL4EGXoYS5MSRi8EJ-5EQ4LZ2fQB
X-Authority-Analysis: v=2.4 cv=Fas3xI+6 c=1 sm=1 tr=0 ts=684c1dbe cx=c_pps
 a=4Vfrg7k9H6golWBcGsrQww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=6yoErSXb8f44zbpSRBEA:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: uidyjL4EGXoYS5MSRi8EJ-5EQ4LZ2fQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130092

>=0A=
>________________________________________=0A=
>From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>Sent:=A0Friday, June 13, 2025 10:29=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafo=
o.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com=
>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org <linux-iio@=
vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.or=
g>=0A=
>Subject:=A0Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Re=
lay wrote:=0A=
>> =0A=
>> Add WoM as accel roc rising x|y|z event.=0A=
>=0A=
>...=0A=
>=0A=
>> +	if (sleep_ms)=0A=
>> +		msleep(sleep_ms);=0A=
>=0A=
>I still wonder if we can get rid of the conditional here.=0A=
>Would the=0A=
>=0A=
>	fsleep(sleep_ms * USEC_PER_MSEC)=0A=
>=0A=
>actually work as expected?=0A=
>=0A=
>Ditto for other case(s) like this.=0A=
=0A=
fsleep(0) would call udelay(0) which is architecture dependent. It seems li=
ke=0A=
it may delay for a very little while, but I'm not able to check that.=0A=
=0A=
>=0A=
>...=0A=
>=0A=
>Overall, looking to this patch again, I think it would be better to prepen=
d it=0A=
>by replacing *int*_t types by the respective uXX ones. Because in this pat=
ch=0A=
>we add dozens of new ones which increases an unneeded churn in the future.=
=0A=
>=0A=
In my opinion, to respect the rule don't mix *int*_t and uXX types, it is b=
etter=0A=
to keep *int*_t types. If it need to be changed, we can change afterward th=
e=0A=
whole driver types with a replace tool and send it in a separate patch.=0A=
=0A=
Jonathan,=0A=
what is your statement on this point?=0A=
=0A=
>-- =0A=
>With Best Regards,=0A=
>Andy Shevchenko=0A=
>=0A=
=0A=
Thanks,=0A=
JB=

