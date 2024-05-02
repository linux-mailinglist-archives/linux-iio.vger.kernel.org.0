Return-Path: <linux-iio+bounces-4746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC88B975F
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F084B219F8
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DC5337E;
	Thu,  2 May 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MGjiTbow"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F653362;
	Thu,  2 May 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641351; cv=fail; b=Ot6DeFGI4p17I35yAEBnkwv2kAdhfSR3yLE0T0X4rLEawhfFR1UU1kUYtenYo4LNpVvGrhGIK/roeOJOWzksc7cDXqNIc2Q6ms2yjbYUZvhsA6MR8i5GJtm+XlvcMxCH5ixvVbS3K92rnSbkY02VC9QbfAGBXLuzLyoGv4+Wzts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641351; c=relaxed/simple;
	bh=GJQM16b+QJRi1d/kzFyu8iQ8dYHBwXq3zxkOzurZ8m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LTVQZC9gSFSyB2fkSXBdrWeTi6hdomqXoeZAu0E8/JoH5y2WDB0GGkv9DJHUnQwz8xoTKVF8BGUpXOgzyyzIM1/fZcGCYDxtTBc5HEpGFT60AlyHBWTj7uJnaOVkkhh74T/qi6Uab5X9Z9mVdnYSDdiziHAFSezaidXw6cyg23s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MGjiTbow; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4420V7AC018868;
	Thu, 2 May 2024 09:15:33 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xrqr0306j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:15:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+cA8WLHTtJOzTUPATjBYhZmaWn5aRf0e68X0iNiZtXDlkZk808cX2CCRbTZg/gPhjtkf+/Bw3FBetuFjio/PuRJmNHAz+p18Wd8UWx5yehtvdwQHMtGZByIBIhOjYHjq9BTcSt07PRUdD3sGlH+0lqtQk7E6MEtunWU+h+FAmsN/E1VllCnYMqA4+oKF9p7+19Ty6GXbKutzZDrunnW5mL4TBBZdcZDQL6jYkSI1RbyxYbiCdpWeQjYsPU7laUXVrVoCoKN8eURf6GlvdHqVUg2ILvo6llByiFSYDS/tXWYzQuw2vNgql4Oq0DGhNGHqR5Wc7qEzDyZBomMAFB8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKNJBFiBZXtlIBXUFjXgW+mWthKBDC21i5nSWG2ZpOc=;
 b=lZhHOe3lSwdiDC3sjhNDx2XZLiIOd2OXqR5GY+VONlXZnTPtPk58Ebk/Fvh7IjVcKh4qytsGuA5VJZSgnyIdafA0sC87D2wiGZOZNdpqvfMtKkcHW6IgJN+eVdV1jj4N4YpsvY6ic2mruhlx4kQE2GFBsVFAo6GjhZA3u1L2aE64GWg0FTKZHlBGbEBOyAA3RmJxrZFWzK41an5qiHFY0HhMGz3FgBbtuq/+ugLLbk6MAX41FNhTU5al4nroWb1jA+6OCLiJCdck7tL13pjB0BcL77lQpwqB0bCI36Qq5dOVOQNx8Xv1Ze4IDTcOnxkfeXg9DuQMKxobL0tF3flw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKNJBFiBZXtlIBXUFjXgW+mWthKBDC21i5nSWG2ZpOc=;
 b=MGjiTbowhapP57qAun88imSKkv+nIWcQvh9jGH6XIpG5Kos1hdfH1XLTaPGXJuhl2PrJevUVu/Zw4DUQl+UTacavYz3MyIbWCG0QVtUUv74Fc2jPcaG+c12gdt++YiziA77/DnkInYc9loRl8x2BWTY2K79O69Y97mJX16IHrIGHSiVdpdX0btCTGOmSUudPFMr1L403RokmG9Gh3LCbrXjlm4ofnTO7NXrTqUzyeo2GQ0tj4ZFKtbi4MAZXZAAQCzUxinlbmTdJke/wADqhHCgW+sm4xSJ2019R+LzzoKzVFY5JLaH8B5Pp2BgJnIUHTYF4vBO+acIsCdpPgU4JXA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB2508.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 09:15:25 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:15:25 +0000
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
Thread-Index: AQHal774Jv/S3801zESb+l1qZEmMLbF9rFKAgARZC4CAAa2MlQ==
Date: Thu, 2 May 2024 09:15:25 +0000
Message-ID: 
 <FR3P281MB175720998BDD67CC2A157A82CE182@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240426094835.138389-1-inv.git-commit@tdk.com>
	<20240428141349.116ad03c@jic23-huawei> <20240501083733.207c27a5@jic23-huawei>
In-Reply-To: <20240501083733.207c27a5@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB2508:EE_
x-ms-office365-filtering-correlation-id: 87889cbf-54ae-4476-04f7-08dc6a8866b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?Lavj/texCqqq7KhferHR5B3tBcq3lBK+kxehCnKe5N3ewJx3wVnlYQdWZ5?=
 =?iso-8859-1?Q?GuGM8q92qF661tFrtG/9bHupye+gdGIwmZ8ujMrZ1syjDkoX+xrgrcqpTc?=
 =?iso-8859-1?Q?xjLA0OXliz3c3k7gDiGW9qbzQPRFjdYpfMCVkNrdVlD/EIlJBTeRHyy8Lk?=
 =?iso-8859-1?Q?DOu+VOpCIT2f/RP4eUlFP2aKjSvAH6pNAFwWBiZwUd2bx/vkTwRR30H4gI?=
 =?iso-8859-1?Q?5lKLV9DgvMVJNl9h/AC2faAXFE9960j2O4ina8/y/HkmvuZD4OBJyCj4mO?=
 =?iso-8859-1?Q?VejWMgHL6I6q1JcCbAx0OhBVINEgbSVryZgqZeet/NQJ3tTsI1k4p/uhlH?=
 =?iso-8859-1?Q?3+PwLoEWfmzEZplSIzna+/yhCq88QuayXs+AxS42fdjgt3uUdXqxD1aa/9?=
 =?iso-8859-1?Q?Jhs2+6MHLRhPBX1SKv7tcQDDUlQYh93C09oOWy8ImmBPlMi3x0Nj9N+Icv?=
 =?iso-8859-1?Q?Qjot9qPXHVKXbtYLOIPX2nWrgZD1uvR2+t0tjABChljNjIcEtSmVfcb/q6?=
 =?iso-8859-1?Q?fUuGGTe/IpLLQWbLlz/ZbyXdAklDs9wNwKtAKu09F0tKzzIzLs4ocMvI8d?=
 =?iso-8859-1?Q?PdlXamvOj6ieEcfboXrUD90h78tf4xK51T88VozKnIIEYhjwboAtcTjIzI?=
 =?iso-8859-1?Q?yMXjhAtmu+dIZKYbZoXZz6aI5j8yoOGqN/uTqX+Ki3pnI9jl+RX5uv1AzH?=
 =?iso-8859-1?Q?vS2yGD5WhPUI/SncCkyl2BStUCqLyGngjD4lhc6f6BQl7GZ88TfO/xB7DL?=
 =?iso-8859-1?Q?A5wibTVaz/E4xDX8RyvzPrN+JHwnk+yd8W2/1OYhJOqPnsd+R49eKe/T1c?=
 =?iso-8859-1?Q?Tgq7WbUYBgMKV+QZI5QlELxGW1MQpYtfnR4J8wKSMXE4ulWG22zET4NLvf?=
 =?iso-8859-1?Q?rN/FILS2twWCDMciNZVgl0hG8G7UVoidrnqAlx0asUg0QYcMYM8M65/S+M?=
 =?iso-8859-1?Q?+R+qmBrZcfJ/jB6UnWS0EVuriVEgDtqicuutqjaQypAhDrht+zrm5mAjRY?=
 =?iso-8859-1?Q?cPqqV0FQ1i4iNsuCKgW18ApISxcxHA/fUOn+SlMOy7r8ktZlDGU/xeOisk?=
 =?iso-8859-1?Q?PFmJ8938OGHXbh52otlB6ku5oVxGxv6OW9Q0c15ws/wu+pUPH/7wuIiTrs?=
 =?iso-8859-1?Q?eCbJ6wi+CMbRdBDdW4jwnqMbQkS9qy/1bCv+IGyWs5Zy+vPlF/Pmwke8Os?=
 =?iso-8859-1?Q?h0h64/ZaabCjewslFOGgkNSWcQBz2KzygjlNe1dg0d/PUdUN5n39rLwEiR?=
 =?iso-8859-1?Q?9OB89dxGsK0mSX/9SE9GbzRSSC81HyMlROJX99FLjKcnMwl0yZEbfZkVvK?=
 =?iso-8859-1?Q?/gh63OoUUQ3v75TAq7NKYpye1MUIhF6o7qSYkBr5ICXE224lAA6g42kpLd?=
 =?iso-8859-1?Q?7GvWb8Pt4B8XltA+8P+/NZGJCkGC4Tpw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?36/9QwWLOzC4BD7AHNztw4sTJzapy34xWmw2mkbCDM/DYwdRAqA6Kdn+T4?=
 =?iso-8859-1?Q?Z+lfm7HkGq2kqsLK3IkDJ9eBxXbVyCmSfPYWo6jMmnCttObB+EiJ/pugYA?=
 =?iso-8859-1?Q?yIVbtCAIXYvl+zRPxQStS2ig+Lx6mdEL3ukUg+ciBOYzaZno08kmQJZdZR?=
 =?iso-8859-1?Q?9eMBKsKdEM33TZ7lCDFxZNU5wJXkAPpNnm8EBbcqQ7VT+Bsx8AX5/veWGe?=
 =?iso-8859-1?Q?fMcEomD3dqLuXxV9xgjybhm3pgeSnkqplcLMr0lnxy/LHxTTvLTqhcFFN3?=
 =?iso-8859-1?Q?3c3+SJsXVIuit2G2xsmO79KbrrlJwRxBVRVtsq5FGVufaJBS52bKye7m77?=
 =?iso-8859-1?Q?+hMRazW5kKBGUj4M5aZdQsLLoTQD1Po3XvBxLsxbNs6PUWS4dUGR/4Rzki?=
 =?iso-8859-1?Q?JvEqLSblnWT5dWHKcEZAWLVq7SUAnUqpI0ZzwHo3ixChbkK2x6P+o5sBkx?=
 =?iso-8859-1?Q?OY7hT7aW4QkGDPBnUnaxVq7gYcQryGvMRTQpSGhGdZLzxKq85GJf4iF0zj?=
 =?iso-8859-1?Q?rzhH87H22tnTLHP48lb56+4YT+LAMTLiF/RZ2m7pFZivGtSDv9/kG/Ucsa?=
 =?iso-8859-1?Q?t6V6GUHPRbl51b5PWBXcJWu1/Kb5io6lQVhSKlMgjtVGzKSMLa1so5Sk6C?=
 =?iso-8859-1?Q?auWLNwJQX/bWNklzoHgR9wjInMPMh2oieFCI0Z5BHcjFVNu5U1U6h5sTs3?=
 =?iso-8859-1?Q?RFDKR2hVKuq210tuYhL/GOONeHfeSGBecMq3MDFsnZPh7uLQgoNuV4eTRI?=
 =?iso-8859-1?Q?giL0H8ZBPEvy1d5SbXZ0YXQYTDJ9PDIgyj4P8/9azy01qIQMclwYmka7fe?=
 =?iso-8859-1?Q?gaPbyvHCIpq2UpmxKI645sZJchIzLxBXgfCUeuIhEDLMAo06Nkq+74HvYL?=
 =?iso-8859-1?Q?G57/ThcKO32nJzmRftLNQxCgzI8MdxhggucXbqMdAipF/m5yr9tHUiplmK?=
 =?iso-8859-1?Q?SYJnaWNNMFuLMpSqmAFIwwctkou89KPiFXY1sfw1G4/mj7+8rq/wyOLRwp?=
 =?iso-8859-1?Q?VEHerCzbuC2RLBuvCnY79nRnFEamMmWbCs8F+lLldP+yCjz+zMtp+IFReg?=
 =?iso-8859-1?Q?rYijDEIYSNNy92ybG4BQr8bFWI7duq1g+S7pcqsehUAwmwxjQqaFCa3knm?=
 =?iso-8859-1?Q?WwxxQeCzb+7SEcTvac9n1baHDz+YIIHPrXi70d7cxXUGh0BegGwpkzla6p?=
 =?iso-8859-1?Q?IhXHq1grhPeJe+btD1whaHyJUyxSSo4EwMpHy+sj72P5k6l6mK2uQ1HsdL?=
 =?iso-8859-1?Q?e2NZOG3ehCWMV/W+x3UYYR/SKW+ziUBCUgPuJ7IqVDIsqXJUqiHB9JAOic?=
 =?iso-8859-1?Q?05XAHvrsKk0gugQWiln6GK1WqGhFTBOzARxDUDDIFx3eN5PEzmqEkRmSo5?=
 =?iso-8859-1?Q?05XZVHJwhpMORU4uMpvp+Q/qXh7Kjix7VygaLd+eJdfJsVzLcYp0k82Hn8?=
 =?iso-8859-1?Q?frgd/U8o8j5LTV0brfAmg+1LqrNvXYRXkRR1isQ8Cn0DkkA9giR8pNQDtS?=
 =?iso-8859-1?Q?D1xdrF3W96fOCFe9SCd99PMbiBrxkI4o9kcAYswuVP9vGUFwdbWRgp+QB6?=
 =?iso-8859-1?Q?bYaBLKSfIhdr3Elz+ZdIjet5+elKENr3LOI1l31GWD96QZv3pW3hqY7ba4?=
 =?iso-8859-1?Q?9Fyga4qZaL4diPpPo5aXTwxDEkSXdYs6/pKFzeAqI292Mrs5/9AfG+lA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87889cbf-54ae-4476-04f7-08dc6a8866b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 09:15:25.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uc9AUREJdtH7jjdNfdBFROlKC6Lmj9ZGt1pV6erUlmGHM5uCgZGBeBAHuhZReMjBLXKe9ECTPR6JFXQeu3ZPYW14e0GYLX8D1h2MsfTfJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2508
X-Proofpoint-ORIG-GUID: JcvTVGypZ7IlY2Q-Vkf4dg1x7STesrw9
X-Proofpoint-GUID: JcvTVGypZ7IlY2Q-Vkf4dg1x7STesrw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020056

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

