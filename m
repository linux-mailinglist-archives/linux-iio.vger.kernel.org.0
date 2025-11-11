Return-Path: <linux-iio+bounces-26168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13AC4E4EC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A588A3B2405
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFEF30DD04;
	Tue, 11 Nov 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rqgvLme0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440E239E70;
	Tue, 11 Nov 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869976; cv=fail; b=JXNKexHfKYGhWGxy5NLUnhtyiCXVNOlVlsgOrQSmPt0cLh/LaHJ2uvYuXFlxncAPcN6HKa0SNOhCHLLhYRQgx9z6uNVGorrpkj1czCYpJvfXx697SVNI+KcJQBSGUek+gdDY1Au3As8BnY8AWOSW0PYZjcmkF786xzcu0CC8qIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869976; c=relaxed/simple;
	bh=cbDQIhFUv2x0gT/5WajCbo9nygWLGG5wDbZ6H4/zvqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IwbCiEF62gj8KL9RgwXH6jqchTzGAphA+QZaFL/v7kiMHm+4NHDjQswrxo7u74xpmS/C3MmkSo/UjgOHURA/q5q5rR90t9LMlEyxKyLjWZ3R3q+/OataXo2o5W/altysB1up9v3mqdSQxrejdmACOOaDpEUVwJ1Az/ONL1GTXGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rqgvLme0; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBZYYY2216927;
	Tue, 11 Nov 2025 09:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WOEX9
	oJI2mmeSeIyElhxNmnm4vngr7VWn9chx5GjwU0=; b=rqgvLme0bXDNKpZPDhV/d
	u2HY+zvrOHOOZvtr1iMUaX2JkUXJ8CUDZ2DRv6fuVBs9yKgTwGILyxmdlos+oXIY
	uuZDhIK3gZD9RvOkMuVbgtN2eaLdFQ1YtpP/Nlkl1ZZSgkgzxxYU11Wn5vlPrm/s
	vMsTsXdpejaTTQtWcfEV1UbAIBrSKF3kpnATS23WBoMB4/XZmjz67/qbR6UvOZAz
	NS11zCwNjiP00lm6+FSNeDt3twax8/XWwsY0Dt/+OP/0FSlHPdttj4ocm0Yj1NSP
	NUaSsHlUBSG6/omq8l6FFMJ9bcc8RwPyiFu4L3gbuMj+XPc/QgxrGZ2Z04ZwGVN3
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4abp20vye1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 09:06:05 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcuANNqtZTuYlkgSylef77/mdR8Xiq+GYpga0LCal5tdEAjYispJQ3pKP5b+BiuvIl1s08YMgN/x0aBVMEtmarR1gCgaRb7mF7ePbeA/aCQnPz4KkwhbSNWqVD4C+9RvVndIsE83C6GkQFlhz2VG8MZOfNWWQRVQQ37MbH5YYxbT9QNxNsnu5vdspuIGl16vDc89kyw68TjlOL4Wp4SqzS1M+uunF0WYJVuE4pLtJUNQk8ySOuC7Uy2sRc5f2Fu/AwV2u8NqE82oWWoKOaOpNW1pxREdB7zgryzbLGM6qNHD/2A7j41yAHLfl0qs/0n1Keo5929w4GVp4VdkQh/afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOEX9oJI2mmeSeIyElhxNmnm4vngr7VWn9chx5GjwU0=;
 b=oIFTAYMQEawQp6La1sREhjWGVEV8M8kHh/jQT0kig2VsNo/mkkENdcqhIx09lBhtCltoadOOVbjscPlu5q/mLKWAMiMlkvXrG0UNmBFWS5B64KgnNtJNpvMZ6DNSaQ6n+rukvctjxVGoWcW4K2ZTkPD4XZA8a/De80X8qIeOi4fmgU4B6gHlK0jyqNiKFGdHdjR/zjDZKZs/qyvdxK+WDlTGrNi3nV0c/ttOOgFMrzsPWmNN4XWmJ3tfoKOdMHY5Zi0iHd3nPJHntHV75iH86FBTiRKw5dk0KVgX9GfIKzCayTtn/U37DEQrB0trJgvxv/BUqsxNk1fJ8qnyabCkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH5PR03MB7791.namprd03.prod.outlook.com (2603:10b6:610:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:06:03 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%6]) with mapi id 15.20.9253.011; Tue, 11 Nov 2025
 14:06:02 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
Thread-Topic: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
Thread-Index: AQHcUNdQj3XZPqjGvUGLb5IyFqz4crTqmReAgALs0OA=
Date: Tue, 11 Nov 2025 14:06:02 +0000
Message-ID:
 <CY4PR03MB33991FC450F33126532B80C19BCFA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
	<20251108174357.3748-3-antoniu.miclaus@analog.com>
 <20251109172213.69d35297@jic23-huawei>
In-Reply-To: <20251109172213.69d35297@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH5PR03MB7791:EE_
x-ms-office365-filtering-correlation-id: 419f9ba9-0338-4c7a-947f-08de212b72cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gmwj1Ug7adbiw4ztiFKeL+8EaaOU7jnT/dhmnGKwBCGQpZKiay5V1pIyjsMe?=
 =?us-ascii?Q?SkaqDk4/CvxFkPhmMTgWpY2H74a7wMwivOcoXYrEp/F+KaRAfu9q8JRrQ9vW?=
 =?us-ascii?Q?8eHGp0X3daUG6fsY14nTfqvo6KC+nYi9V5sj0jSAXzWOYy3dVrfnR9JQBTt9?=
 =?us-ascii?Q?Mm00U+0GOynbifJYmkPW0+HaeMvxU4n7Ck6159XU7qN5FbBoDfs+LmdfKB+A?=
 =?us-ascii?Q?IBPA6gHjyOZNfLEpPWOaA7wwEWBiDvYI8bvd6oatm0L4N/YVRN0z0PuHcPej?=
 =?us-ascii?Q?/KT/OjenI2CmV9rJC719j8GkSq7GSeSzd/OIk5lc1udh9eHIif6axcZXUcvE?=
 =?us-ascii?Q?5O8tbK8yo8OX9L5F9WOgvBjDU5N6i4NNcOExiS3+yYcRkunGTCgcbu+vMbh1?=
 =?us-ascii?Q?406YHWD+bDKs6U1KtXdL8BwaIdYNopgUDn1J84zYIQgk+CmcFZWPioKVsfYP?=
 =?us-ascii?Q?i0lg5YyeKFbasXrDg34M49Ep1RRJ60ZRTWkQw9k0ulTITSqzaf22F2HKNDxS?=
 =?us-ascii?Q?/xVWS2PU/2/5tU5Cdnvm9qxzwOrXuQovyW+Y/nXhVCNbLEQ55MrVI3wBa28p?=
 =?us-ascii?Q?FtGvyX7v9/jwGoT2dbQqAwVN9j3L8YF2W3rLB6AzgspzrksiRbcyyQoF7Hhd?=
 =?us-ascii?Q?ealy0ZYVVdUTUPPWdPudEuDchTdg+/JedIHjsB9r2hnTduGlzgWm33gXS9nv?=
 =?us-ascii?Q?V0LZ+CFF3RlVwGLjDvHCJA9RSzWropWyBx/p+hiByvBLEOdIo/yMgiB2iD2C?=
 =?us-ascii?Q?eFKjIcdWWmvjAQ8+8PfKdYJjMhkWPHKwDodzqv7jWyY3m/AjDlqhbEw90Q1H?=
 =?us-ascii?Q?x+o+aeNhP3EqQwg6al44FZZlY5GyzEHr7Hp3LTq36VDhO0/6bSsonZEVs4sW?=
 =?us-ascii?Q?d6rInWzqEPArxHyzPM5pMyQ7zMUlCUrUhk+Di3abgl5aTC//z2+O/tSqXJX8?=
 =?us-ascii?Q?dclIV9kVGLS99wJRy5F73hZTvK/zbtwvSgFJtaZ352lA0ZuOFIe7rQt83t23?=
 =?us-ascii?Q?k5rW7cOe4FOLNXBm5TIyT56EivmJjUxA1MB++osdqGYvdpPE+1fb3blsjnKv?=
 =?us-ascii?Q?TrKeYMjz17/4HCovnH+8MyeZB/laN/hY6Zc6Fjjvm712ST3UpLIlIkZuk9T+?=
 =?us-ascii?Q?isfPOvuDR1yPiZjQ0wVJ5eVLCg5CoioXkOMX2Bek8LeuA6e0gQv92J2hGkRM?=
 =?us-ascii?Q?WBmjfVNfA1EqdxDJ3EYmohV8yC7z6OCCBbxstH9a7aGaKi4sqxWh1ZYQ2pWd?=
 =?us-ascii?Q?lwQnFtmyFD0MZTe1f/yEgMlH7+mtygmLm/yyO93LVfXGIohYjZ9izoHQNjX8?=
 =?us-ascii?Q?GRSw0XebRKeXNmbzwmobdVnfNlX1il6Cf7dzDF5ruM9sD/xBrLsKIumByvDk?=
 =?us-ascii?Q?hHw5HQzU7ftUYcYkEXzlrCvOvKM7IqaNvMYJGK1eWbc01HQQ31psgXur9/SI?=
 =?us-ascii?Q?uaFAXd39lRYqoVlOmvg4s/3infpYUM+UNSE410j7YrcZngqQAseUyIIej2H7?=
 =?us-ascii?Q?kInyICN5KTuHeNn1oX4LcV8QsNZJHW05zqxr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vEw5zFCfIEHBZWGg3bw+oDvmnDpQFC9vfmQ4G2MrV9hdxIY1la6ZPsQKIzZ6?=
 =?us-ascii?Q?0Kmvzw4PN0v3g8fbIJ4OPRgFuscIv0fhn59kKOJJuBzyPhd+13GYJLenXCy0?=
 =?us-ascii?Q?XN9PmToWVyxv37oYp1wQs6sxjc2u7k7G4qMx/pNadr6EfLIUrZycpY/WbhNA?=
 =?us-ascii?Q?aog2+3RIejIX3oBCb5eQ72fGomhY7kdCO67NnZzPmlCWpJWx2nPYX4rKMrDM?=
 =?us-ascii?Q?eHqPWuhLPT0rMbN/eQ0a2mjXh2JDcz4UMlIbyoJd+ir74+8ZXTW3xvaYAJRc?=
 =?us-ascii?Q?1mVG3knZ8fEjeYiLx2nSYl4j71uerPFUnn1qaccKHGN/bsgSTbNBGECV8Tsp?=
 =?us-ascii?Q?bHpfIOPwlXR4E79dvOFEtE3iSyxNd5r2L+C2atvCiYb/E0CTIbqTJ6gi5JqO?=
 =?us-ascii?Q?PyaPvcbeCWCGODlpcm26Q+ui4CrUfQ335t6DRJyG6pqtcbicPHlY9ydweRUW?=
 =?us-ascii?Q?TsYwGA+qSfz2sl2PyCK+bQXlxN0vzZmzJdS2hIzAwD9DuajPAWJQ73FsMELu?=
 =?us-ascii?Q?+Ibq1hmAf4GnG/8grmeJ/2Inoi/HzQwQnkYiJizeJ2dc5NY4sIVAImKpdXC9?=
 =?us-ascii?Q?G7mGYepeQQM8vu0TjEpPZ52FO5upVaktpEe5HxyWJgQzhD+9EjkzGIV/sMx9?=
 =?us-ascii?Q?w1SzJGvYazN0P1jgvJIyy2o7D6Sd51DW0V45eLvDlL7c9EtgqPaJIgDpAQL5?=
 =?us-ascii?Q?oXhL2uXF9yZBe0pdA4AFOGnnH5KTJ9ATLCrHN/twtunfxHNtVsmaQ8aZToVS?=
 =?us-ascii?Q?70NrAYvMKxBQVFx1cQzu5613OcEBbIYff/gAiOyLEK4FPt9oG75NBcLUu5IY?=
 =?us-ascii?Q?5FXHvV8+jUaDHSZUsjnuFGWghFlr86tgpEwrwzc71cVpa46a6fGNl4Ysryel?=
 =?us-ascii?Q?JQtescql0wFGyQ64MJepv8y1r0EoCDihDw2g+sot1pigji3dUcYO30s+SCy5?=
 =?us-ascii?Q?osxyi+6fu4bAfoY8yYrUbj+KNpXUIKIml3wd6qErAeEcyf0rXjQNS9OtaM+4?=
 =?us-ascii?Q?EuXvSf1OX9LXLmty90TWAbllKRGW4L4DAaxO6p0NLTY+RVAbF8uUCzybTxU+?=
 =?us-ascii?Q?VSmMnEdACYGcMsPcLaE/IZmZZXhtxUl1r6SvnjZKDbzXwFm0PlYreSqFxLkQ?=
 =?us-ascii?Q?jUT/Z4aR8SKzcHHUrRSQ0HjuCDTmQej82bUxKL69e5zcNmCnDTNZ11V7Hl7z?=
 =?us-ascii?Q?6swxCds+r5xaXZpRMX7TKEit8/9oppfIenXa9/H6SNULhYRcZ2J22N7jhMnI?=
 =?us-ascii?Q?DDaWF8TQzAaL9wx1S993PEZ3fzw5U6rMFzByLVeauPMJDdbxGMdTlCpQ21aS?=
 =?us-ascii?Q?k4s2+984BWsdCAlKZ1MWUUWk9bfufoIIcjiXZ+qDwpZ5F7o4B+GD5LNS8KFq?=
 =?us-ascii?Q?kSD3bFU+TzKJUG3PZYd3PLnXmJvGpwDtfkkNEme3e9PlWPiFLeEuxd4L0DfF?=
 =?us-ascii?Q?561DgWZl6n1sqQae3ZEtNXy2XhK2iMa2m4IPwkGcceP5nYPm5/yYiowBeC8J?=
 =?us-ascii?Q?22+KBuwppxm9UoM9jsqVnANCKQW5l9Tvsp9/QDXIsu/4nlCneVmC4WrShTQo?=
 =?us-ascii?Q?nHE8bpTrYGbJnG9TN7ZLmXLk2iv/IlF2LFxQI3M1utR3C4af7Y+SmW82fJdU?=
 =?us-ascii?Q?bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419f9ba9-0338-4c7a-947f-08de212b72cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:06:02.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhFTnjXKDQQ5M4TUT94fT1/wsIPscJ4pN4FkMMy20ssaQ7QGi5MCL3tlTxYUx6Heoepa8WnAblvdyI4Dvj8m51sAeXG69VMDcGR8VJWxEoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7791
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMyBTYWx0ZWRfXwZ+lkFUvypwE
 pqxkzhMWMXb7BfR/3FZ2hyi+I2LnIj27AI3iSi7voAQBsNh3vtkaXjrgNDcsSxACF0h+4h67jRd
 lPuar4TLzusrEY9YXAoyS7j+Ck9bXpJQciIdHFlU5fiJDg7agTZU08Skxxk7t/f7TUDZIBbDEgD
 wBHAYlmwk2ISMMWqQAd7qHS1v8994aUiffB1Z6tp0gli+PKcgZNMMK5nkCxFQIA2f24T4aDbTiB
 /9XnZ66/TCHlDd7vKpkv+HPT4QR8u+FVyP3Elv22RIoB65i6ywAs+4IaVGRPi6yCDVz2nlonlBo
 Emd+I4Fz318HDaL1witpP+3jPP8CbT2i0Iyj829DYhN5Y2PbKiiebOXMJd+IiFFdeK6gWimX8h5
 N167VIiLqvz3WAQsLXuGbo3Lq3M4HQ==
X-Proofpoint-ORIG-GUID: e8kf-H3Zfg4qCelxHIm_bj0NJQSXEXhe
X-Authority-Analysis: v=2.4 cv=e9oLiKp/ c=1 sm=1 tr=0 ts=691342cd cx=c_pps
 a=7hCjIaGjES2TrnZcIlaVSg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=rk2IJEayB13-zSkHiaMA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: e8kf-H3Zfg4qCelxHIm_bj0NJQSXEXhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511110113



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, November 9, 2025 7:22 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
>=20
> [External]
>=20
> On Sat, 8 Nov 2025 17:43:53 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> > 10MHz to 14GHz bypass switches.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Hi Antoniu
>=20
> I think we need to come up with an innovative solution for the "mode".
> I'm not sure what it is yet though so very much looking for some discussi=
on.
>=20
> thanks,
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/amplifiers/adl8113.c
> b/drivers/iio/amplifiers/adl8113.c
> > new file mode 100644
> > index 000000000000..8c234f0a1b6a
> > --- /dev/null
> > +++ b/drivers/iio/amplifiers/adl8113.c
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ADL8113 Low Noise Amplifier with integrated bypass switches
> > + *
> > + * Copyright 2025 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>=20
> Not sure if this file is being used.  It is rare to see it needed in a mo=
dern drive.
>=20
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
>=20
> > +
> > +static int adl8113_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct adl8113_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > +		switch (st->current_mode) {
> > +		case ADL8113_INTERNAL_AMPLIFIER:
> > +			*val =3D 14;
> > +			*val2 =3D 0;
> > +			ret =3D IIO_VAL_INT_PLUS_MICRO_DB;
> return ...
>=20
> > +			break;
> > +		case ADL8113_INTERNAL_BYPASS:
> > +			*val =3D 0;
> > +			*val2 =3D 0;
> gain of bypass =3D 1.0 rather than 0.0 which is open circuit gain.
Isn't this supposed to be a dB value since I am returning IIO_VAL_INT_PLUS_=
MICRO_DB? Linear gain of 1 =3D 0dB.
>=20
> > +			ret =3D IIO_VAL_INT_PLUS_MICRO_DB;
> return IIO_VAL_INT...
>=20
> > +			break;
> > +		case ADL8113_EXTERNAL_BYPASS_A:
> > +		case ADL8113_EXTERNAL_BYPASS_B:
> > +		default:
> > +			ret =3D -EINVAL;
> return -EINVAL;
>=20
> Early returns save a line of code here and I general think make
> for much more readable code.
>=20
> > +		}
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}


