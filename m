Return-Path: <linux-iio+bounces-5337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603758D0533
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8951C212D5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDB16D9BD;
	Mon, 27 May 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="UwT77Ymn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D5179665
	for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820799; cv=fail; b=An6kIJc007JMrEC59yKdpOnXxLwhRAxdHmeFqgMcdz3hxVXj2fijEfGyCkMo2nxR5bLKd/hCH1e+xkjzYoLLaWAfxn3Sj+c5P5lQkYNf1ioMKnRg/S1yudqlQCFaHsGEtHpiwgRXuZJTnOCbEA/JDWdrEfsqgQ8gckX3A+Cgg8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820799; c=relaxed/simple;
	bh=SdMv3dVoiV84J7cpsYDQmxpK+vzxLyrdsHVsBrJIBns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xwqd05XacR4mVF1+o16x5Fzlp4fZA7vcA2E6KUrGhjeCju67zD1SuO577g+JygGADdlM9w9IWDAlGAEbZ+s9Tb+/G4l1iAxrnfRktqogEofYR9nLKU/KjHUbP+RfbDtyua8SH+nXUaoDL4AU/f2r8ovKN07orP7/YKzg5vxax7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=UwT77Ymn; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44REK7vx014588;
	Mon, 27 May 2024 14:39:29 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yba4x99ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 14:39:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEL7i/JHVsvRDowIYI+MFX5lleNIjalXWxIz0By2UTopFtI0AUZ1tkILyXI7zZE8incKT1KB8kF2yFXxypnb+SOeOsDM9Nfi1E3lrcBqosy40HuINvQnkF9HEl9BQroqJdsXDxcpTQNpKpPtlwWKji81SQR1F+qVKQH78qoui2jOwVW0KmptQCR3Gb8TZMaO+wBXXsI87ZV2Si+hLdQncbyZuRPo8DuwmqkdO5AwRte51ASiftnrWQLII2g19YKQuXVvimtWRhOB6JpAapQriTH4dwbpi5bN1zJfVkJVrx99qCHyYjrGedSvoF+b5RDqNcxDZz5fzpV0tbOjAIEJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIISJHKly0+Af8UU/jkQeOWNgl0rFwIXmUmKW5nraGM=;
 b=BZSKPFy9qGEaSTZjmC9md5Ph+7E8wlocEPHdkROMuuTIIYZ3yX0bAMZmdPuWFxn1fzLuJOmZ8z40BlWb4DFKm4t5+zc7OeZLRsRuZCKE2Nl/UmVW9gI7I7V7lMIoC+7dmiqe+GN+rgM/r5OWPC6MB+6govruMZs9BfYMlEL9o+XhxoAxv4885QBVY0n9jTj4wobnsttnkZxHl+ewFs54gnoI9xenRT5m0X6Z6nc6LJU0fV0R33RFgqda/sKfDHn7anrILT83iOxA41O18ozfmBgRkH2+BHh3NKaqjq1e08IHOkqmLA0xP7HD5rv2Q8J1IgsYdPbokERVzr7E6kPYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIISJHKly0+Af8UU/jkQeOWNgl0rFwIXmUmKW5nraGM=;
 b=UwT77YmneinNyHm8vCb7Us0bn1SsJBnPEtq9EhPQqbgmav46NgYh5Ad9N35KFSzUODCcDUkt4oYrUTgZQwYqZLYaA6E1/6Gz2XbeF62SevB2IKQUeEOYIw9NhvVLrSTyYcvjMdgrj708Myjp/wNRtL4+ZGLvgd7fX0L4/KJOy6HTgKBO1bsjgZbjek7H9eDppi7bjV0jwxGpgNFg6ANKdyz/0y4KsELZd96KNWyqGIT2WJ/5brVfoQJq/rJnl4bXEmFR2SeyPEMpmqdPGnMAG+WRQw+98fS77sxUq6n36tr1ZmO73CvhkwXm6pqf7sQSc2pNbPvJoxd2+tLkAXHbmQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB2297.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Mon, 27 May
 2024 14:39:23 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7633.001; Mon, 27 May 2024
 14:39:23 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in
 interrupt
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in
 interrupt
Thread-Index: AQHarRiLPrxln6yPhUeHHlOK3IQu67GoNhOAgAL2xZg=
Date: Mon, 27 May 2024 14:39:23 +0000
Message-ID: 
 <FR3P281MB1757975E9DDC2814AA8BD80ECEF02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240523135245.552999-1-inv.git-commit@tdk.com>
 <20240525182235.52c47260@jic23-huawei>
In-Reply-To: <20240525182235.52c47260@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB2297:EE_
x-ms-office365-filtering-correlation-id: bf9d1a63-fd5d-4f9a-341d-08dc7e5acd5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|1800799015|3613699003|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?iT/NOcqnHfs4xUkbg1MAFL3G0eZfrj2DMh3ffK6mJgYkvfuj7Drx8Nv2Zs?=
 =?iso-8859-1?Q?nRv6ojP/FEBuIUpb7l4tUchon4w+wIPcQ6H2932DWFY25kBJTFaNZcE40W?=
 =?iso-8859-1?Q?/i8Hx+SM0pl0mmVwk77LAq8kUW02K7iim3VUBHKNkpbcrSSF2h5+oRF+Ha?=
 =?iso-8859-1?Q?MhFej/vqrFSEwKbSCaEfrB9zGFJ1umlThTGaJqzP3NxZOFifJdg3GsDoo9?=
 =?iso-8859-1?Q?SLS7cnLmpssGc6gmMJddOkwdFynpCUJlMLCxH2IyDsUIEAjJUJ6/5LjrHL?=
 =?iso-8859-1?Q?nRl7nibNBPN2354eP+htDJcjNaOcu8/LIVXTOsLbG25s0Qg42zwDwRGfOq?=
 =?iso-8859-1?Q?rnHFB7lgn6/AnCsAc1Md49OCoUHFeYCTh9gV/T9EFk7j0xVEd57Tzc7p6J?=
 =?iso-8859-1?Q?dbZ5tHQ7ezKRQ6usUHpP9c0NgKlW7f8njKlQnRdvxv/brIRvXy3FfitLW0?=
 =?iso-8859-1?Q?IxxgJXiUMvQqcPQgOPblbJKIfCVOAEYviu0jgKe9guAX04UickvOwUPa0j?=
 =?iso-8859-1?Q?bJHftjz5y+8pXmga1E9tbVEfaKLs21XXY8CDhEmho5WxeiyL/ZR7TZLev5?=
 =?iso-8859-1?Q?nnt22bm5BBDAzsFxTsWHyjwEQ+X5dbj9gABNauJPSAPEERdidgdoJyImbQ?=
 =?iso-8859-1?Q?7ZC4h0bWDe+jVTrciUAOjj1KtohsiE0UrA617+Gy3CKELibLVu83SVvxAs?=
 =?iso-8859-1?Q?F77Und3F5DU6ErrsxIIUnivtahAiQ5eD1WEOnoDthKQAdb1FKFzD8yYaNo?=
 =?iso-8859-1?Q?JW1OvHOrlfEjxMp63HhL/y5gqVJPOpsFl1YN7HIswJMC4lPOW0jHDoW/cz?=
 =?iso-8859-1?Q?DWTQ+d0a5LFPM2rSYeVnCm6b8doa7Rt5pJ5DhxWXAta7OnksZKZ3iIwwMm?=
 =?iso-8859-1?Q?jk/SML1qn125kwV7PkyYp5bTXiH+xiUj2gyLF8Ko3qQYt9xuVJvMswdtqd?=
 =?iso-8859-1?Q?WRsrHxwERfOgyGpTsgVkmuYw+mdhdzjYrna7qRkpEGrWcPV046SdZDSYj/?=
 =?iso-8859-1?Q?pH0x8olhQeescS1ctFN5m9Lklp0nZ9BWpyhAR3A41mzBJHnrGptkTFzvpA?=
 =?iso-8859-1?Q?oe1puJgz/SBXuxZPQ4iCDa9Xfgia8myiTcbRxWNujtfQs/Em0GWPS0+F/Y?=
 =?iso-8859-1?Q?+yEG0S4bZm4g/eEhpz5+ZYcs1o/FV/yQ9C28p7zx81CD3SROHjn9mQhWAN?=
 =?iso-8859-1?Q?8rj39IFsATezBn//rzmG/8OCoSD1SWJln9HKr036PzNGBiDW3Pywn1olaN?=
 =?iso-8859-1?Q?pvQOfa7SKJQzDqSHAJuIxmuuU+TUvf6Ngw9fo8F4CcmwDL6vs2dXHDr3rB?=
 =?iso-8859-1?Q?eDbz3TXErVpd3NeJTvM7hTGXs3a9Skm5H/s1UabvgZmoehBRWdJFJWKlTY?=
 =?iso-8859-1?Q?OwM576oB2/gM99SVCYo4Ix0owy+OKo+xxkZw5SVJAI855PFsXI/UM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(3613699003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ur3HDv8u7tMLDa2kMtnsCGfmlvKplsqSQUMUSnAkj7/2hvs2R1RDXKnCS9?=
 =?iso-8859-1?Q?uOCBgKeur/Y6zrV3ZzqHXOmTvaxO492k0rDjOLB9/nr/CIMd8whB4rHFxN?=
 =?iso-8859-1?Q?MWeUO6yiq+G5tH3hm1weWzJTTpKI5yBJFKhBTqaxY5DrzopAQR1pa6Q+2t?=
 =?iso-8859-1?Q?i0VNFk6wYSzJ0xQaRJFC3MsPt7QCB+/5iGd+B8f84hPNh6OfsivdNo366Q?=
 =?iso-8859-1?Q?a7M4LqdXwnnChOy8PpNhiG2sw5wr733OLpYmg72/sNBFCiwGneIukr6jyQ?=
 =?iso-8859-1?Q?CoMAWIzoVetGNklfvjVIWeAx1IB2uXeGwhqQUsv0WZGwWKaxj+ht0pit26?=
 =?iso-8859-1?Q?4+CaPnY5feOs6kF8VgaRoWBnByulLrZEC2lOJUoycbi9Qq1LMd6RuPQrb0?=
 =?iso-8859-1?Q?B1QIR4sxb52SYDsrh96ixcwwK6FIGWXjTNlL8scsvMYFN2Rgt1YfQBN3X0?=
 =?iso-8859-1?Q?fMWe62qwDt+iejUcCud1gMnmyMQ8gS2SQc+jTF0Ni/oRqDqjnwmP8wlMOI?=
 =?iso-8859-1?Q?Mt005wOO+50Aw58e5j1OSNboEzOhMkP8d+VXCESjVbbmSI9XE2n7OU2Pfw?=
 =?iso-8859-1?Q?PfwnZvbODIvPycVy3qM4QkqWw124xTL1FYYn7w53NazwutTHOfEpXOtF6+?=
 =?iso-8859-1?Q?oMEBkMfCmCizFeOi4ZPH4PQexlnNeGE0Dwsrsh23LhJJg/b0I9HAsdMCpo?=
 =?iso-8859-1?Q?Q2U6PEr38wlG+224KJ0xg24qPZzjhmZXI/MXxK+LYuB2MHCXgKyFT+Q7Vp?=
 =?iso-8859-1?Q?d79Xi+zFyWWZWMKplXA7l0w4LWNKINzwOm1l66cxR679PoglNB3RinmK29?=
 =?iso-8859-1?Q?SPu2xzy8M7lgDBjOxVO8J1d+BCHmHhyGMTpBZXbBwiaVyL0JibjGZRb0uS?=
 =?iso-8859-1?Q?fOxpz5d1rDjcf2W7FgP/iLCdZYfcf9G0Glv/HMbBMFIF2b2yZKS79uB5kp?=
 =?iso-8859-1?Q?HA4FgsXLHDxoRf0XXY2TanRCAZ+w9RXaltjTVjiZf80lMBKVsvV6frlK0t?=
 =?iso-8859-1?Q?lKWzKdyN84RdRptjdV+R1zi1Se0wGLIHMjMYWw/dQ4cYSPEw4V8qAAsuhG?=
 =?iso-8859-1?Q?jhr6JQgxCuDQe4Ue2+8atOij2h/oVqsnsvd3eaTIk72gnjLN8Z02tvsz1B?=
 =?iso-8859-1?Q?kSBTeDWBfOTuBBs4G0i9yfUu/OFjW4R9xJ2WtLu1bwYpo3o0zM72cRfN+Y?=
 =?iso-8859-1?Q?7w7ss/RkgbPnmbEa9hOJbgyS/yq/NxfV3yV6aNQoHrUVkbcBINDxx4G3cM?=
 =?iso-8859-1?Q?NjhWWJRHKS1sPcUYJy88ohGxh5gMf4DysMCX7G2Nlanf81XlNrK2PvYxjM?=
 =?iso-8859-1?Q?7MX4dP+mw1Wcn2FBvHyE441dZ6SxSlKEM6QYiW1kgtYC8IkP/i08HbSssM?=
 =?iso-8859-1?Q?JQeWFw4fWEW5ZK9tNLor7YnuOERelsPDMDRJKsehIdGGLVOyebBTLlmrYz?=
 =?iso-8859-1?Q?Mtx4kktMNlqEJBG1WxTqKws1fdrSyggsVGI6ar21OfGJ8IVpqN6Gp/4Z5s?=
 =?iso-8859-1?Q?5xWDDgsa4uHFoxr0qYQ88uvZc8iYAqIeGrhkg1Q9m6MGvpBMdrBXpmWtPf?=
 =?iso-8859-1?Q?wTK8CsX8jihsTFNg2D6VSLq3B0SPIdslGhBXpzew57ApEdzRKuXnWevj4b?=
 =?iso-8859-1?Q?LytqnwM94Xwzs/8sKV9N7RPO7doMz7G6FURT1czNuqPVGVij+hmkbbAx/s?=
 =?iso-8859-1?Q?JOAJIEwfyaIpTFlQzb9nJmsYcspknGXJYMSfl54/DU0WgWljO1stB8qLxe?=
 =?iso-8859-1?Q?1tbg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d1a63-fd5d-4f9a-341d-08dc7e5acd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 14:39:23.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQMqyMTufLpka4z6ytZWII2NVh96uhvLrzHDoW0VYzueK7QGnu+PPvbIG2eJIzol+FRD7MHZjcIdmiazyxxCLf5NgbNBXlSKvK3lmj5dxEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2297
X-Proofpoint-ORIG-GUID: 2ZwZib0mrz33cTsJLsaKzPhJ5QvBlAcp
X-Proofpoint-GUID: 2ZwZib0mrz33cTsJLsaKzPhJ5QvBlAcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405270120

Hi Jonathan,=0A=
=0A=
I wasn't expecting first to do a Fixes tag, but you're right it would be be=
tter to backport this fix and it is quite small.=0A=
=0A=
I will send a V2 with the appropriate Fixes tag.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, May 25, 2024 19:22=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in in=
terrupt=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Thu, 23 May 2024 13:52:45 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Use IRQ ONESHOT flag to ensure the timestamp is not updated in the=0A=
> hard handler during the thread handler. And use a fixed value of 1=0A=
> sample that correspond to this first timestamp.=0A=
> =0A=
> This way we can ensure the timestamp is always corresponding to the=0A=
> value used by the timestamping mechanism. Otherwise, it is possible=0A=
> that between FIFO count read and FIFO processing the timestamp is=0A=
> overwritten in the hard handler.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Fixes tag appropriate?=0A=
=0A=
Otherwise LGTM=0A=
> ---=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 4 ++--=0A=
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 1 +=0A=
>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c=0A=
> index 0dc0f22a5582..3d3b27f28c9d 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> @@ -100,8 +100,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>  		goto end_session;=0A=
>  	/* Each FIFO data contains all sensors, so same number for FIFO and sen=
sor data */=0A=
>  	fifo_period =3D NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chi=
p_config.divider);=0A=
> -	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);=0A=
> -	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);=0A=
> +	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);=0A=
> +	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);=0A=
>  =0A=
>  	/* clear internal data buffer for avoiding kernel data leak */=0A=
>  	memset(data, 0, sizeof(data));=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> index 1b603567ccc8..84273660ca2e 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> @@ -300,6 +300,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_d=
ev, int irq_type)=0A=
>  	if (!st->trig)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> +	irq_type |=3D IRQF_ONESHOT;=0A=
>  	ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,=0A=
>  					&inv_mpu6050_interrupt_timestamp,=0A=
>  					&inv_mpu6050_interrupt_handle,=0A=
=0A=

