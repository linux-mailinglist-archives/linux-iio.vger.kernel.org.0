Return-Path: <linux-iio+bounces-20586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23522AD8B38
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 13:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658753BDB1C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA72D5C88;
	Fri, 13 Jun 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Jv8B1YW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBB275B16;
	Fri, 13 Jun 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815018; cv=fail; b=oFNGiJptqLB4MlEGb4BLRKAcHmSf2h/DN+rfjsP7eih/rg3qH1vH0YaJSnFJPWkTSH4AoZe+GxhuTG3gnDQUU+Nl1Kn2kekEqyzz8fDVKJKBYy8Q+FmuobsxbVJeFkcCjZl99fb/PSd74/Zmu2wQwlMRQZ4KrjP1uUxMG474kpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815018; c=relaxed/simple;
	bh=aru/dlEdD76M9Jua/7LjmTPDNg7lqx6t2Ya1zdPek68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMHTsu7w410gJuIJyrXcDVa0YXq9QIKQIDnstsVt4E9Qoc1NfW12Th+/6/kvEpebGL2+8nmXCsWCcg0nE2AEaUETY1atRtgz8REDqVCb3sZpsfvDOSvvX28MQJEOACBT7iuH5/Y1nnzvy4TB2s8p2yPN01nf35jjYJXNp957WHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Jv8B1YW2; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CMNqZY002415;
	Fri, 13 Jun 2025 11:43:04 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010023.outbound.protection.outlook.com [52.101.169.23])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474bt34wmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 11:43:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNbiuSPFenKpliJEBlFqsrETVP6AF1O9P50iAx6ee+HllzYi69Bz0rV/WIWis4ZsJGVParq9RGio+VJWTtfnxlIeKpiNrVSBY5ycAu8T8+bM6Kf1EQUtlePoc5oSQZybwvLVdEtJy0CGrAJTur8O7XC5OemXHu12cbyz4W0Vfiv2gMs1tJp/UaTATQojgZexat1ik1NFQ+jH5s4nTbFW6mwEYSJ2bI1amnRwX5/Qoo3r/quUCeO8CzCPw4FVHhmRabVAkXgIbq2zKlIseAPmCCJNICxfWsorkj6Wg0Mv8RQtmmkhYRghVCJe73NtFRch2OfmlFA0eXV0IdaHMNcpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OLwnC/arTvBmau9X2hAh/Y1cBzuGAvdbmQtXNKO8R4=;
 b=maSe0sSdMu+0ML2Q5msrgQF0wevOIg1W0NKegQo+eY50PMwYefFR/52EjVCk7AouakmYl7zbj7QK9RcYm0hZo3ySb61ychvYCO1zTYQWu+/O5FWGyii7VsT4dgF1CRYFpFf0ttlD8p+Y1g38rI/dMdy4vMauyHA84LRtOpftnHp+IUip0O40Z+QM0GcXoSGh3Cosli61W9rQvLng6cUJ86OoBfEV1N38IZ0SsPDeFCZDTXnHFLsONc79x9WGBsWAHVsKIR94HdRoGUWZUUCBjnSvSos22nFqUbfcXnktnMAScPVoMETt78xZPoY/wLenKSfI2VUKmPsEy4XcVRBqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OLwnC/arTvBmau9X2hAh/Y1cBzuGAvdbmQtXNKO8R4=;
 b=Jv8B1YW2gxCMcCqUSfAzHNXT8MiqPQA+aefkDMX+8VYu3O6DwdlNmecBClUsmcKYus8YQRMe+JtRGixK2sB79vM8iLyms/G4doXWKcyE6z8EGPQtfy9ZMHQJT+sJSKcU3Dbrsn6wH6a+eVX8vI8F5/Fag7yvoaE5Xasa97zK4w1YQcVWa17IkGFkz034lChLQFUY90PQlmnAtL7xX/NNo6c5UCJHbM+YVIyD5qocrPGgLb/duYjbqwOrP9embAzMmJVfma7g7U8AOrMH54cKraqbAOhjaoKLYOyqZnMMGzs/91aSIyqwBSe7YBM/HooFG477KTrZPDq8Nug4I1ZwhA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB2643.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:72::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 11:42:58 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 11:42:57 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Thread-Topic: [PATCH v4 2/2] iio: imu: inv_icm42600: add wakeup functionality
 for Wake-on-Motion
Thread-Index: AQHb3DWhBLWb+8kRKUSVrXddNTem17QAwqgAgAA1S3A=
Date: Fri, 13 Jun 2025 11:42:57 +0000
Message-ID:
 <FR3P281MB1757C7DAF6FCF90E117AF45DCE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-2-7e5f554201bf@tdk.com>
 <aEvh2My32K9us0Tc@smile.fi.intel.com>
In-Reply-To: <aEvh2My32K9us0Tc@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB2643:EE_
x-ms-office365-filtering-correlation-id: 740b8487-c22c-46fd-0523-08ddaa6f7163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JWuGlEopxVNoRXGG8SR9copyz/kutFtlQoBtKgERLGzSmO75mt6ZnsA4mC?=
 =?iso-8859-1?Q?xN0fY+lykZZmrI1wyc73o8SR6lMFQNWdw5U8rucowc2QfZLLdSLTpwQjrs?=
 =?iso-8859-1?Q?ldjq6SuqVXe7JNswYEtmnLdpI2P0JGNBmGifnpJ8bFZ/L4m+D5J5zdxAyU?=
 =?iso-8859-1?Q?QssDQitEeeb2w3z4xoKVBbvFAEm0ilTLaBF8tTUUW3+BWWLVWJO6Nd5MLd?=
 =?iso-8859-1?Q?aGuHscvyk2N1uxCI6UVoU6CXbDHTNi2mqo57xv+/8xeRZL+3M9qe5Yrc2r?=
 =?iso-8859-1?Q?Vxe+EGwunE2IjfBHSO+OgQDEXtrJ8GhuT8j3bBK3vMlea1Fmf3Fsgqwqn7?=
 =?iso-8859-1?Q?kEGzQ5SLEdV8HKEwHl9O5qVlo5u2OwaZMNbiOTdlNu9X4xIxauAZdbO3wF?=
 =?iso-8859-1?Q?uBBWhhIjQ931Fp6J6bwnKmd/DCSUjOraDMwtNt5Qbtt2eki3NnmXeKl4M6?=
 =?iso-8859-1?Q?UsXDYY6TWOZwJNuPxDINHoYUlePxXoCyEI6koVPOb0AbDZ0exwwGg4wHDr?=
 =?iso-8859-1?Q?oTssEoBNwhMjrHk16wEkQDQQnl+UtT7IliaZuUdYiJJafEIhGeZw1St1y5?=
 =?iso-8859-1?Q?UwXGSu6lcNiSGrOkXPNf5B/3NrqS2FNZUDQkhlzEM9WdB94Iy6VfSYW8Xh?=
 =?iso-8859-1?Q?YfPCdC53zHtJTdpKp2XkFWQNM99yiiVrWVHPT9rBIn9sOk5+co0C3TtEuF?=
 =?iso-8859-1?Q?mgxuCRjYfVCRk1QFem1m/lOoedwAtTEziMklQyX3ttO01xf7OByLs/nv1n?=
 =?iso-8859-1?Q?A2TwEHtn3Be3THpaS85xCVUXQ2PmhSdIaCd6Ijhb2vlhCM/U5Oyw5ULHI+?=
 =?iso-8859-1?Q?XiC083DnqaHSkTCEkGxIL8rTeaziLiSIPjmqtIRaOB8PkbXJlkJHvpkYuA?=
 =?iso-8859-1?Q?mgS90k5ARjQc6g5xQ/NUEZBiG4WqCO8wV6I8u7CTe7x3HSW23Yzz3AsLek?=
 =?iso-8859-1?Q?bDiXNje76yN9yY/dD7mIutffn6bpa5Fcl9QI1NlNcezwEe/9C7RlgA+IPy?=
 =?iso-8859-1?Q?GyXSkc39Eh3vrmNxRgddiWDO5AL+mndQ7hkFW7F18SjTsUXubTDzvaNbso?=
 =?iso-8859-1?Q?bASRqAGBTDP++h7lRkfnp3ahEYmqdlQ7N4BKALXY3P+vyY+47Ipcb2QTlg?=
 =?iso-8859-1?Q?Nlj2RaScHOZi59vk/dF0Pwar2ySiX1rS0LyL/7oYQr7NLyJ1vcm5vxrmyq?=
 =?iso-8859-1?Q?GziXmOKpUD8NnJoJwwzJWzlhh78B3QwcvJ2HbAbncfLTZY+0jcGUqgFTKA?=
 =?iso-8859-1?Q?p1Fwrq2K6xoBZG99cPq0r/MmdHqqbWXHKhrFuFnvn1xUnWRC9ASOJR+Ta6?=
 =?iso-8859-1?Q?dl9qXwY1SCOBVrYx7VUrshPTW5NmO3RcO/lqczVE3Ra/0UT+wZcoHjPc9w?=
 =?iso-8859-1?Q?k/0o2wrjZ+mTkLIeOAX1NkhQGvhJfZC26r7BiwvXNr4tFa2JRqYdlJWohK?=
 =?iso-8859-1?Q?m3WMK0l3oCBYKMuuwhcwZmyfnPpHWuI7S/eg6IvL7cI0h2IxPd7FYgv57a?=
 =?iso-8859-1?Q?QoxOAPQfllKUkMFRuVuYI6/q3O0cZKnRR9jEvEGKz9/uhp8fM5te3d4PNU?=
 =?iso-8859-1?Q?zZ1JiDWJMyliBdmW+eind6OOF3CK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CP8eSKzKKu4LrNKGKrelPudMqpqn6/69z+NUkvPMQE75P2QMZonuSDJEPt?=
 =?iso-8859-1?Q?7KYNC4TGJDYZ6SAzzEI9/pAMNu1qCBdCcBsuCi0m7ucWqB7ME4C2ARlZGx?=
 =?iso-8859-1?Q?/mxj98fNNdP8iqQHaBP4cln1xGSNaLy+pmI7AHEKtoxsWGENl56u/mdDbs?=
 =?iso-8859-1?Q?c3mD643T05ueDFhZAVOc44yyCgkhupta2KmXyU9M3NP/ObHF8vA5vzkENQ?=
 =?iso-8859-1?Q?r42pdYlgDVeRsIFofs8yiIC5l2QREontkReQaoENITn9XXkpiYWYNRGvn4?=
 =?iso-8859-1?Q?DvF8V5u1pILv4AJmJLoh4TfjkdQB/g3xjq5J4FRueCH/K1vNuXqG/1NRV3?=
 =?iso-8859-1?Q?OwnuRF0biQGxFUv4FWm/PySw4Pzn2n0ZNJpprGCfXxrbZHZY+QN7ocbhU5?=
 =?iso-8859-1?Q?lofdqFWjrFKFhfo4VCgW/6UKR819A+jdUIGE4E2L2Kc6IbIN8GavIScFVv?=
 =?iso-8859-1?Q?w0n/n/54DxIH3OqsN/wLmny34mnny+NnisIU4XpHnqGq+1ahjPR+gqSvBB?=
 =?iso-8859-1?Q?v39q+BpPkUgwPuNUKQ/q8MSfB1uEibNZks/2/8xMne8Bz5Oyh1IzWH2Iby?=
 =?iso-8859-1?Q?zp2BmfMlRhKhWVAVD/B1X7EGnIvn160wGQqWmj0oPEytuv21k09ZvhLW/D?=
 =?iso-8859-1?Q?prdomnTpCVzyN89HP7sroBJ2JUdhndaMydr1wdIuiFgZ6ngN33hWsy+EI0?=
 =?iso-8859-1?Q?46U50UCZHQ+bGpBF1bNH5J0wEIskpUKRzM2Dx8eOG5h7+87AQRwBckTEQW?=
 =?iso-8859-1?Q?xLSTDvMoln2tkjZTwRoWi4nwbZxULY6QmZ0m0gW1TC0y+qzW2azu3EW50J?=
 =?iso-8859-1?Q?wRhTVnf0tYfSw+AVAZ9lZg/1rAMbF4Cy/dHOGa+4C4I7J4z9NlEG9e+mR4?=
 =?iso-8859-1?Q?mjXIJuF0ANvnO1rbmY6F2iK91b7JqW05hcqQyYe/JMQNHhQaP9IVliNIlN?=
 =?iso-8859-1?Q?NyKJ/QxyPaD2eNednEHp1ykOA8mpkE4TE+byurPK+cWz3yka9fA6uSaXT5?=
 =?iso-8859-1?Q?h5nxa13ZLWUC2sMBJQGVIlBm5ev99EkoRL7meiP4HS3yJCkrm+l0d+1Mvh?=
 =?iso-8859-1?Q?thvuOylBF+RZK7caac4DZVusjfwVOu+W7qAiCjDmIn4djmq87vaG76zwup?=
 =?iso-8859-1?Q?kI2tUkp0ltr+eFAllqT11Oyd+SjWEv24SYqcXhzFxxueTND7gymwL8Rle8?=
 =?iso-8859-1?Q?Jz4CvTRSulkyZzaD+9WbNkBWbfdhyZxWdjwlKJEBcMwieLswR8nSShybtF?=
 =?iso-8859-1?Q?IA8DpXTYxPXR7YyQRvQuonnamfQykZsgSIDBdVqYeU4EDtdbZ9j+Ibyb4f?=
 =?iso-8859-1?Q?XerYrpuHZYPXNPPKDNfzCl5BUVsk2aW9Y0G9vx9rVPWHmGc7YqAI2E6NcG?=
 =?iso-8859-1?Q?Teb/TxLC/a0vvnyZcPjcTo1DeESyi2Vkijw81KivQ+zaTjP2ATh/GtJGxU?=
 =?iso-8859-1?Q?XW5WsxhjDYOeFD7Yt2Z6b8hta6UpLBNWT0G09HNCMlOEFgaxZKJ2BlKGRY?=
 =?iso-8859-1?Q?TqVtHJd22lQs02V3St4iR5ontVmeOYo6nOSBwAD25VtSvXM6VDKHJSVjyg?=
 =?iso-8859-1?Q?2YHhxrlNUrr9qf9x4UZ9Rp7W++fquqHBEpXnMSaVaxXyPjlwO+X1t4P72J?=
 =?iso-8859-1?Q?Syf5yT2nSoSj1+29nqdJSKJk24LklJTdML8l0ScGbu+ypHYEv0/9mqQo/R?=
 =?iso-8859-1?Q?JfHiTSaC374nTtizSFIkbKo+dlgUmwHHVLU385MHVzr58VMWDwLqm8LG9h?=
 =?iso-8859-1?Q?N4sA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 740b8487-c22c-46fd-0523-08ddaa6f7163
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 11:42:57.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tqkcTzqrnlQ5+UyHBXchZnu0KuBS0kEBkzoLzCiD+4aPEL47N6oB5iUhRDpGJwV/355RXVW8DXSvjcDuoUqaydokglymgcE1IhVmF6W9Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2643
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA4NSBTYWx0ZWRfX5u6Ug9N2YeGP
 5VFmLsIc3pu80yBSu9hOeRFTgAS9WtecihwOeBKachEJJEkPbFrBhwxQWowMYqEv26j9Bo5dK0p
 hRO8oD7LUPtYqzRQPCMZEjrEeaWG17WQM9YbdUiz8Vw1f6zfviSpgpnW98chipvi9azHfeMOYrh
 092tWtweWxi8N1uijMAXoqULWzgfZQXOq1e3uk5yyZ6qU2GywH3nRTtkIYUEwH5wvPjVAJI45qF
 c5LJzXv7AuFiIMHWgKGJFY5dpNfE0wiX7PGzPuQ/tQPZ7Wozzz6O0juWZ+605RSAVh7fTdfGI/3
 GuUk8YTLlN5F6XqRWH9+V1QZxZBNU07phH2RUP2jPI47XGGJ2M8a6XColBltO3JAoAkJO23imJg
 qZ6ZCc2kZrCdzsBNXQqLG3byPLSg6iNltV1MFc6o65Rz4DJU9oRPtPH3Wi5Dz8CJM/LGanzC
X-Proofpoint-GUID: w3NwGgKJURbHlKfBoGheq0QLBkpiu_Ec
X-Authority-Analysis: v=2.4 cv=Fas3xI+6 c=1 sm=1 tr=0 ts=684c0ec7 cx=c_pps
 a=6MffHZHjCM9XE9olRgKZ0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=6yoErSXb8f44zbpSRBEA:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: w3NwGgKJURbHlKfBoGheq0QLBkpiu_Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130085

>=0A=
>________________________________________=0A=
>From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>Sent:=A0Friday, June 13, 2025 10:31=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafo=
o.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com=
>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org <linux-iio@=
vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.or=
g>=0A=
>Subject:=A0Re: [PATCH v4 2/2] iio: imu: inv_icm42600: add wakeup functiona=
lity for Wake-on-Motion=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, Jun 13, 2025 at 09:34:27AM +0200, Jean-Baptiste Maneyrol via B4 Re=
lay wrote:=0A=
>> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
>> =0A=
>> When Wake-on-Motion is on, enable system wakeup and keep the chip on=0A=
>> for waking up the system with an interrupt.=0A=
>=0A=
>...=0A=
>=0A=
>> +	/* accel events are wakeup capable */=0A=
>> +	devm_device_init_wakeup(&indio_dev->dev);=0A=
>=0A=
>No checking for return code? Why is it okay? This needs a really good comm=
ent,=0A=
>and even better a (info / debug) message when it fails if it's not a fatal=
=0A=
>error.=0A=
=0A=
Sorry, just forgot. I will add it in v5.=0A=
=0A=
>=0A=
>-- =0A=
>With Best Regards,=0A=
>Andy Shevchenko=0A=
>=0A=
>=0A=
>=

