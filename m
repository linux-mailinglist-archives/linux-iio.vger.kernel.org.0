Return-Path: <linux-iio+bounces-4747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A08B98EB
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2191C21E32
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC328E7;
	Thu,  2 May 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="TIHVHnRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F93A8D8;
	Thu,  2 May 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646238; cv=fail; b=QHcgTRKcJPA3lZvzEUO/JBwU6FIhi/JjZ7xcwFtKJsWaUVFeVME9cqNrm7o+q/LQqjgfi2s13IcrDSqcKc83XVGzKTypAeaXf4GkAB7JXQ0rY1ku4h+1so5nnm9xC850f+UOeY3tmuArmhgWV6smYkd+P2RMhk/FYM80rigrWVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646238; c=relaxed/simple;
	bh=5KDfirc1lkWYMsB9BxGELFObx3K/SVhvICmzul4qtQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXzjyaA+piQpU1BzWSPsmhwEzqB8ouR5kmtFXp3g3+4sOeN4D1+wXDo1lAGToQ621u7jxG1Xwo8vIXi2sN2jYNuyl9mIG9sHJ78yz00WW+okeqf9LArsgXJakD16uoB5TDAlgrMQiFmLLdWJ7s8WFAwWheYTKigbdGwYN+6R+T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=TIHVHnRw; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4424p1qn019726;
	Thu, 2 May 2024 08:59:46 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrtqjtwkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 08:59:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSNNi7qRmr+apLVHOKPz8P5vOTxQOfiKpg7RuQbSYVIsIpa0DgBa7c03VVYPqSTlMRnKrCdr1NhxH5o399SK97kGEoSqrxsMujQt5pQYsbQhq4jvBErFN87eiWk2eJ4WiARNYG5tH/r9LuHUy+rCYpw8M0ZjxrOqtFxdURuqGrxPzEm8OTxpdXm3ItCIc+cpvWqhsGYKMCRRqAEh7tJln8joFLEJYaz33VzPlm7ntlpyB2ns5yPvLrDZ4zb+Evz+CyUsfb0mUxH7TNmM5EZhziETyqMAVt6eVTDqwChpErcoc60qbJNRIw9M3DAPqZAfEScaLd4b6xQDQlWiXrjzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHxrLdXe/rl6405w44iYhiHIzI3L5ibTgnHP6hzCrqU=;
 b=N8dXuk6zdeeTmNWAck1Tf3TbXvUa6VtgUnF0rHRYxl1YOdgctomy55647OZoJWvERqqSmXRgB3X6TK2ysXeqX8VQ47+qKgd6+NneZorXuW/EeMOV98zoZ6blyPyi9iYVZeh9LfYuwiH6HqJzeR6P0LpQcSdChXwnkeDzC778VvLy8H6dBT7N5Vtkdcx8/Yn3uF8gF4VrnWXWEypiryFs1C3/DjwcbojAMRYvE5ERGVYVX9f2ltQYVa1kHviZ5m8rlfFX8oXk960DCVeH9E3z2YBtFNEkDIc9VaDNWLx3wmK3dYZliuv/JUUyoqSa2OU35pZHQ4YWNfVw03z5c5ZJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHxrLdXe/rl6405w44iYhiHIzI3L5ibTgnHP6hzCrqU=;
 b=TIHVHnRwEgA0V+6pxfHe7y7VVh95Mci8RHyroJNOZLxRVDv+5Dq/ZCr0iIl9EZGHeQJUflivAIbdzPjNFCITBP1vdWCYW3twPEtxNj63Akc8RZvviemnjm8R63OKUx84pWBhDOHmUm5ozK/W8HR9UqMMcEajUmFT1nGXsvBm9zfs5GX5o94Jd2tYq90Rts+kGYesmkg6zFPyePS7CDowayikCuVWiwtqDSJ3qcGEiaIQU+zb8uBNswWL49Ypb0pQp7i7bTRoEXJ8tt5iFjupIVF7+sbl9h0XyVIQtIr1rClNgfYNQskx7ReUpMlAmZLAGbJcYfbje/ZDpP//1X00Dw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEVP281MB3559.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 08:59:40 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 08:59:40 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: invensense: fix interrupt timestamp alignment
Thread-Topic: [PATCH] iio: invensense: fix interrupt timestamp alignment
Thread-Index: AQHal+HYniOcEaEO6kKeFiLo0JWD7rF9ll8AgAYRq4k=
Date: Thu, 2 May 2024 08:59:40 +0000
Message-ID: 
 <FR3P281MB17571A72717855D8EA67BD23CE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240426135814.141837-1-inv.git-commit@tdk.com>
 <20240428125614.3f8d2b59@jic23-huawei>
In-Reply-To: <20240428125614.3f8d2b59@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEVP281MB3559:EE_
x-ms-office365-filtering-correlation-id: 1c60daf8-69ea-4d7b-1f28-08dc6a8633a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?lgqIEmjTpArp8o6utZ946LHKkz3nnz7GzK6KKj2E9ep0RcHC/YUHzlxzJ4?=
 =?iso-8859-1?Q?P/rEL4wZfF2I4B1ONqVRfJPoKzY2T9GcyDOM7OAzEkRfwIPkP7UcLixQ4G?=
 =?iso-8859-1?Q?xhc7iSYl1gtWuuSYW2BIaqJ0EJ9fwBzANkN4OqewyoLQLQJrySFiDa47Pl?=
 =?iso-8859-1?Q?4SqwHnbAfaFHOfAzIE7PUpwDLQy6Z39lRBUL0Y2/fVveyjjW5sC8WWdNRE?=
 =?iso-8859-1?Q?d2MztFlwc5Drc8GyJFTXkEA2SBBLquDeRWb/9bWi9cY9bN9sfLnn5towib?=
 =?iso-8859-1?Q?9WSiUKhZdDSHP6orqlAQC0D7C6tbyzXIOAIKVoBi1efrb3gCoJhLiJOqqi?=
 =?iso-8859-1?Q?udWmcNxD/yvvUzYqII69ClIgDEqfyL4MwIWNW1ugKLlqRqNCt6j19v9azu?=
 =?iso-8859-1?Q?RaTnKdOjNat8VQGjj5az8mnO23We+WVAoUTWFKjPXZuUwSnmZTwZ6DkcUi?=
 =?iso-8859-1?Q?08ZicDc3QpuWKJuhmfnc8PxVFedAi0atENoX8phSmDOmmD+Fdju2xIpLZd?=
 =?iso-8859-1?Q?+vAKFAVvABDMrzTWaCQL5MEY86OjTGVc/IDhdsg01gmQhPJXj9KBhPn4/u?=
 =?iso-8859-1?Q?L7v3twMmN4Gt5Ii9yqUX1S12GBcstj6WmJoCBSHQAmvfeNQqPhQcGXCKfp?=
 =?iso-8859-1?Q?4Q2mLz0s9aq6a/CSO/r6n884TgwtNgY0yX6fdoUykP7r0WVuHiQlW9aCm+?=
 =?iso-8859-1?Q?2B/YC/bz9bDpc6qExrr628645xsoZb+VH3eL7UrrBoGT3JrGhd2+RaRjRR?=
 =?iso-8859-1?Q?6toUNoDyZjN9vsJ/DM6uKCGJYvsc6lVcg9kWnoQySimQwU779MTLx7UT9j?=
 =?iso-8859-1?Q?a3nklyeSr41/coYUkTS0LBNccYjHloLJ3FLBQn2DR76RuLX35I5ugJHHWB?=
 =?iso-8859-1?Q?3iFQr4KIINHQ1EPUyvSAiXW8Y2rnHOvk0rKiDXXdGlS3D1X7EtgDHQ6zsu?=
 =?iso-8859-1?Q?ZHvZKYn7iud//t0cU1mUzQvCkuJWvy0Lm/kKiYuRDnRydWC9Vjjw5RXjrg?=
 =?iso-8859-1?Q?UgPVlbUe/VOXD/RK1RQhfjEaq1RiiH0nebXawtLJ64aoWUcmkfFl110swI?=
 =?iso-8859-1?Q?5SPvSRc9InHo86MZJYn5bNbX6L9i7JTsLISobjWqIHW9AeyU/csegzDSYd?=
 =?iso-8859-1?Q?vRaDesp7/Y0ODGGApblstF0SF9IVT+nbpTKyay3p6SGInp3Rx3rGJnCI9b?=
 =?iso-8859-1?Q?2P1QPhW+UkArQW8Gr0Vo1aaYAtv0U3rrczwnT3sbFi7iCwBwSR6k2RBG3A?=
 =?iso-8859-1?Q?VTtkwRAH4l1vvOEqPJYV51usgs/e8+N3l0jhg3u5Zj/BYe4Gelp410JvrL?=
 =?iso-8859-1?Q?yI7Z2Y7oQxAuYeKSUNsJA3CKd/V6jy4Mh3sGOcTlQV4uP8T6Fs/XQTZ2fF?=
 =?iso-8859-1?Q?OQqnY0KszX0vrvaKKT92dAXcge9ayGSg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?FGKKd4SQetnTs0x80wWInxBhcqXsDeYJRotegtl1SxZvAJQKdJw9miZ21Z?=
 =?iso-8859-1?Q?8+PmmYm3R2e6QUOYJPTcf76UBl509R3ZmqDeR+savd6umEzHJ9FVtQqPAc?=
 =?iso-8859-1?Q?vFyBUyaD+/m/bXSbPhcf5OyLbx+Aq2M3CtKYQrSoo/xS9q/3b49u3aiKJN?=
 =?iso-8859-1?Q?KGlNMGgU9/4hxyfO2NMmhYaJ6oqhYl3YiR0cWKyFi8XwYE0i/adnhHTo/N?=
 =?iso-8859-1?Q?4BJXkGSruNqGpaNxySxzTlm8zO82kSJSGWvSxZ4a28/ZkXJJimhmXfLj/V?=
 =?iso-8859-1?Q?EvkefhQFp1xztDrHdeWSUAVtJ9kZaRGN9SJEg80qtdAaDVRKZbXb2MXuAV?=
 =?iso-8859-1?Q?Oq9KqIf67mn0kQWXbfxDjq60UDEvNMm6ARPiPwLlYVPfG/Kw1H7xTMKFqJ?=
 =?iso-8859-1?Q?M2WA5dSORrKrE+U9We313X9zChLELYTrXkktrpDP58nT4/o9LvZ7gmNvLJ?=
 =?iso-8859-1?Q?eByWAEbjaWxygGFcTR7cp62+ueByG2fZa0AO/rgD01rbJOHLidP+8YhUUL?=
 =?iso-8859-1?Q?/jBlsWe/2Y5SM4GhDsSe1SEO7Go5qMVsUb3ue7eJAAvxpkeidisuWz+vAC?=
 =?iso-8859-1?Q?O+5LI4r/9Hh+6MyttxN/uSuj3MLJvZBVPunwFRtCgUfNG322uDeFKc8SuG?=
 =?iso-8859-1?Q?2Q0ayBeNqV13BHhiOoQLJPRYeWM2lwxomdC2jeEf559knhntjMYD86fa72?=
 =?iso-8859-1?Q?xDtq0MQmg77G8Tfi1C8gshvwucVFEtgPrs0fWcVkEM5+ERKWDIFqklkWZL?=
 =?iso-8859-1?Q?lVn+26bHKkNH4Sg1khoyw6QrcicReWccf5DlXDibds01FEqMQfj0e8Suoq?=
 =?iso-8859-1?Q?vTc7mmTiPer/7Tq5uVn+DcGA0DlSf7+O8/imAgDKjXsgVrk0LBhG7f36R6?=
 =?iso-8859-1?Q?idV3XjAzDAlCfV+ihKCcz+eX/Uv4mPSrhYZwMIdoswvIieyUS4WVeo3W4o?=
 =?iso-8859-1?Q?6J4KSR3SrmVEXLbLosWhFD4ZxMiLWnb7FxK60SL1uek1vLmwaiC9R/Ta4U?=
 =?iso-8859-1?Q?h/jynoA6kILaG1URNSMTOu0ArGTzndtY4LEPaixcWeDjQFCTC+eZd7C4M+?=
 =?iso-8859-1?Q?C4uByzBQyt5t1DyTueb59nyCnExC2FpOZqHuJdGeMD117B019d/pDVmxoF?=
 =?iso-8859-1?Q?VZGP8c7OISDSOGp67oqIAXrf3RrSofz4RMXlVvCrx3OEt6haCIOsf655+o?=
 =?iso-8859-1?Q?87KyQ+5kJMGZw7sfE4G5e5QzgvT5P0EWVXNJT92jUR/KtJCE/Fby+Q7gB8?=
 =?iso-8859-1?Q?5amD6+gAbQ+/v54zhNbwY+ZaUbDsBhYnIAeWpgFjv2+ZxaseIO0U32J1q1?=
 =?iso-8859-1?Q?6yK93iY8mAs+yGsUeKTzFPtfR7KOOUe3+Oz7Bb7Oofmr1tayQN+L9//n1j?=
 =?iso-8859-1?Q?Sz2oXwUbYZ2dzMaIq4//mqdvs/DeoZyMaPkKcDrLVZz8l9IhahpxGDKR0i?=
 =?iso-8859-1?Q?WSpbYz+HEp6B4mwgnAQwRXdhlKiCphu0v7DtA2LbO8i7lfVIKZNDY+MnAj?=
 =?iso-8859-1?Q?pxGzF/K3HjsBnjRiiJfiGZ7xKvRFRm4HPtMotWfSlU7b1VI0/ZaSudbBhI?=
 =?iso-8859-1?Q?w1c1TilBgwoKA/nIM2gkKKLNF0Gz5AdiXcWP0wPFUn8kyB9xqTzx8K41mf?=
 =?iso-8859-1?Q?ilCg8Mb46S8RdOV82/5gcZ4NNWHZ7fPVp8i2cUu4jyL7GMGVVRA1qQgg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c60daf8-69ea-4d7b-1f28-08dc6a8633a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 08:59:40.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4+T0lmgXgKEsMQCU3wB5JP+nVkwVCH3A72nco2f21k4wDlAiLFYq+oInJdj8kP4oAjQkaupG2a1BB3YKuyscaXTVj9mtBvv2iTzNzOiN+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3559
X-Proofpoint-GUID: oE0U6Hx9XUoH_nwolQWZLZVQjo33OLMr
X-Proofpoint-ORIG-GUID: oE0U6Hx9XUoH_nwolQWZLZVQjo33OLMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020053

Hello Jonathan,=0A=
=0A=
this is a bug that happens in real usage, especially when using high freque=
ncies or low-end system.=0A=
=0A=
The delta timestamps between 2 samples periodically exceeds the configured =
jitter when doing interrupt timestamp alignment, while this timestamping me=
thod should assure it never happens. This is one of the goals of this times=
tamping module.=0A=
=0A=
I will make sure to mention that in future patches.=0A=
=0A=
Thanks for the guidance,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, April 28, 2024 13:56=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Jean-=
Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0Re: [PATCH] iio: invensense: fix interrupt timestamp alignment=
=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Fri, 26 Apr 2024 13:58:14 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Restrict interrupt timestamp alignment for not overflowing max/min=0A=
> period thresholds.=0A=
> =0A=
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Hi Jean-Baptiste,=0A=
=0A=
I'll pick this up, but for future similar cases, please make a clear=0A=
statement in the patch description on whether this is a theoretical=0A=
problem, one found by some tooling, or (the most important bit) something=
=0A=
that actually happens in real usage!=0A=
=0A=
That info helps people decided on how aggressively to backport that change.=
=0A=
=0A=
Applied to the fixes-togreg branch of iio.git.  Given that has a link=0A=
tag to this thread, replying here with the above will make that info=0A=
somewhat available.  We are late in cycle, so I may just move this to the=
=0A=
final pull request for the merge window if I don't have many other fixes=0A=
queued up.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
> ---=0A=
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 9 +++++++--=0A=
>  1 file changed, 7 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/dri=
vers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> index 3b0f9598a7c7..4b8ec16240b5 100644=0A=
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c=0A=
> @@ -101,6 +101,9 @@ static bool inv_update_chip_period(struct inv_sensors=
_timestamp *ts,=0A=
> =0A=
>  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)=0A=
>  {=0A=
> +	const int64_t period_min =3D ts->min_period * ts->mult;=0A=
> +	const int64_t period_max =3D ts->max_period * ts->mult;=0A=
> +	int64_t add_max, sub_max;=0A=
>  	int64_t delta, jitter;=0A=
>  	int64_t adjust;=0A=
> =0A=
> @@ -108,11 +111,13 @@ static void inv_align_timestamp_it(struct inv_senso=
rs_timestamp *ts)=0A=
>  	delta =3D ts->it.lo - ts->timestamp;=0A=
> =0A=
>  	/* adjust timestamp while respecting jitter */=0A=
> +	add_max =3D period_max - (int64_t)ts->period;=0A=
> +	sub_max =3D period_min - (int64_t)ts->period;=0A=
>  	jitter =3D INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.j=
itter);=0A=
>  	if (delta > jitter)=0A=
> -		adjust =3D jitter;=0A=
> +		adjust =3D add_max;=0A=
>  	else if (delta < -jitter)=0A=
> -		adjust =3D -jitter;=0A=
> +		adjust =3D sub_max;=0A=
>  	else=0A=
>  		adjust =3D 0;=0A=
> =0A=
> --=0A=
> 2.34.1=0A=
> =0A=
=0A=

