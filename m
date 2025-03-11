Return-Path: <linux-iio+bounces-16735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DDA5C8E2
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4677A5B87
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88825EF88;
	Tue, 11 Mar 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="qxmMcgkv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07214232792;
	Tue, 11 Mar 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708380; cv=fail; b=RzSiNc3f5qaTd+AF/0z9eVr4NltCATei+d7D8dm4hHKacKeNz76yPsM4JXw5PIGy5h18RmuoApdrZ5vxy52jQbM+oqpQZJ4EUjJTjZlZ5CUdzIogDv1Wac0nZgcMh6Mn9MVM5saa3pCobSK5th5KZdaqvl1g6IjTu7t3jAwahGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708380; c=relaxed/simple;
	bh=kb0vG8SEHNtMtOdPjH+6VC4YctlDYSoRCa5SIr7im/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s1QBR/ABzEMFNPfyd31jw9W153ksM/mhD+vmrNVdC03LJjt/i8jsWASbEQQLtPBMPhGqDu7k8cIDQhltt5We/kk2+miROC2ySJAG82O8Oh+4YneYK3+bulCBcM8+XfrFgHvFN7zdGJJd1oU72OtNQdMBj2hAUvKkkwmxX6XAXIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=qxmMcgkv; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AMbj2R019769;
	Tue, 11 Mar 2025 15:28:22 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012049.outbound.protection.outlook.com [40.93.78.49])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 458f0gjjep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:28:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXiUx73BE2m39MLnkokG/l1E4MjXw0fD61S3sJwTC4+tNUsCunpeEKif/3szwzb/xwj9jkhH2rdwY7eg/6dHe2DcPOTyy6zFZeL8PoHTjCNVoSFw1vR6umyW1EjR2Qz7nXrBXCJJXVR95xXqeltwJnwpsoEQc39Qgu3tmLHqs/BN5WsphLVmraORxD02bx3epj+yDUtgXPilut3NVOTeuq+RCsrAoiFZWX2TshiAxaEFlBZ1g0/VI2cnO3C3DWkFrJ11Wa+0G8WmOLz7YpSZS+W7k1n/4ZgdboXkdMvUJwHT7w7+houI75nHJF7RZCGi5bAa+nUok8+M2bn2u5Q7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw427F/37I17/ckDZyUqAM4EOWLLLE4IiqGPTtnuuJ4=;
 b=ciMHUJWod+T07vhpN3DsgrkCpjgIbFM7+iYBhZiRijqDNqhPBxbPelj+pKn940blgTS6ZqiRH0frUIhTykurrqC4sidueLoqOuwYjIj2XgCgmdOQVSCyi5B4zafe0kgfLZtnyyuTK6IY7Pjz0/9Rk9Gjxjdha/Yw20tzRtI2liU6QkhaeCAHL246QTZ6CTMRwO9dTxJVHPxTPHoxfHM4IZwTY8ZQ7EEwceIcb+uTfTj2hasv9WsyUuImw9k+BDSnOJ/DDQTn3ZyOSZaQ5bF4J0ArDZNF90nk6gFwvg5ajeiP/INNwWfWMcGblD+kSpnmShYnsOs5ROcFszSgLucDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw427F/37I17/ckDZyUqAM4EOWLLLE4IiqGPTtnuuJ4=;
 b=qxmMcgkvcVdQXx3wBOLKZWk+K7zEUTRVN50zRz/SfWSe+G0yo+bQg7GlzpSNEdUq91HlNyS/pPhrkNurNhZmoVOkh+GxD5eRUiX38oy3N7nKztKqhAWWxibwtPwyUheWDKvNkR1s9pXhA7jXYgWKgg/9HVbqtiFRFbvGaxkLTReXLJX1BWP7olBjuhb3wDCWmbfjeA5oD1g36Ul7mNmB/OYK4NC6tlUJ4wNJP7IN2ygNnnsbY1aibQXVS3UMsDeS6OvQud0orzaJkCiVaUtjki6ylwK6k/cZYv6zEAKI4QL11/sVnbGliO9PIQ0B2/gNAjL0X/5BKxRjbjLOd1g73Q==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4478.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:28:03 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:28:02 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHbg9ladKe+nWGHJkK1EZNyG8x7ErNTgeQAgBqokdE=
Date: Tue, 11 Mar 2025 15:28:02 +0000
Message-ID:
 <FR3P281MB17570CCC482B970EC07F043ACED12@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-1-9b937f986954@tdk.com>
 <20250222161406.54b2d348@jic23-huawei>
In-Reply-To: <20250222161406.54b2d348@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4478:EE_
x-ms-office365-filtering-correlation-id: 82ebe1c1-443d-4e3f-6754-08dd60b14fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?F/CWJYRVgoRZpOx+0kF+aKt0dSZ6pA/kvJRPPZGV9rNKmzWczIszbQnNe0?=
 =?iso-8859-1?Q?qJtqkJ0HlS/gDGPtz3cywQr/LYZ9e7HX6PYYki+g7mv95Udm2qXyFivPCb?=
 =?iso-8859-1?Q?a3pS5FxZGr2+xaaEJ+n4EvypoazPZADhpGQjgnOXZE+4r97dNARb5S30hP?=
 =?iso-8859-1?Q?BDDaYzkjzGHAXgKVhxmYQJC6DgF5pl6FU9CY+9dEk/y9GQ0DlA+g3WjD+K?=
 =?iso-8859-1?Q?sL+TllTF2EcYir8SGJMeKuOdGofL6JIU0QmpTBun2as8Dmnl6XvFApsSm5?=
 =?iso-8859-1?Q?mVxzhrAQGgzy0sjsj4iXoECCpd9j9O9b/AEz43Jon2OmdyoiXRMtSpmb/l?=
 =?iso-8859-1?Q?q6Yr0891EaZuaTgPU5uN8lqgZXPy8u827yC5eYfjSUTrnjsacU7NA8SdoO?=
 =?iso-8859-1?Q?z8iV+D4BFWMX0I8WQuqmjU8BXDSa8aJVbsD0bNgD6MspQv7WwmXT2wY/FI?=
 =?iso-8859-1?Q?FDjVCfFJzMlmyPA8mxyWVar6THRMyQeAxvbC3Kd2SwNgn2TRjn3a3CghjE?=
 =?iso-8859-1?Q?US9n90upNPSO6glagiBjoI2yMcn4eNeCtIObendyyZddeAP5FngQw5bJDk?=
 =?iso-8859-1?Q?lbBbEm4/Ud6Av6J7oaTSr1dcKi2zdMHQewKolAhd4KjNIYBGIE/CqDSbeF?=
 =?iso-8859-1?Q?B7X0zHGesJrh7d2esXmcgn22YBFg74/SvrUqKL2lq5aecHVFrnGwMlCGdd?=
 =?iso-8859-1?Q?VODs53n47an534W6QrL5Y36eYAbgRGFopvAxEGqtap+xw6EG2dBx2GH/bj?=
 =?iso-8859-1?Q?eG74DfUr1d8NfmCtpf3pfS0sE6eCvbLi1LOsQZ7e3LHsCymt+jv6TfCFMj?=
 =?iso-8859-1?Q?DH6pzywLcuxLpX3hNdL+ORxilJI2vkSVoxxnT9tFUISoKXkXTdCsaReCMz?=
 =?iso-8859-1?Q?xfZShqqsqgHLrZhl8MPXz8Ah7Od+CqtCDffMN8dRzYFR/PPoArdsAy7Ucq?=
 =?iso-8859-1?Q?Pig+8esHOJXCyMxww09eiF3OvuOmzM+r0cKoW/hgUHmANRY1mod2Ma9EQ2?=
 =?iso-8859-1?Q?VJmIwJ32JkmrHTJGxxcSKuc63P4Wf3mnlI0RrYYDDtNhcinURMbI+4Bk0d?=
 =?iso-8859-1?Q?1BwPhJTPQzmaLlkmoRjDyLLxp+op+RBdszyXygq+Gd0YX0zGV7E8OZy7ok?=
 =?iso-8859-1?Q?zuPr49EBJumwym/5oQx+HKQkRVoSDxeVBthqMQKpClzKWnY8gFCAasoxk+?=
 =?iso-8859-1?Q?eWKQSchiiIQkhkq06Xr3+b2jY9SQw4sYuhHhf8CZjpWVKCzQbtlbcSdhTC?=
 =?iso-8859-1?Q?taxcIKMRzI1pDugfTC/8BfKP31FHF9c0fYK3Kmpgm5oncqd7vuLWJe3iD9?=
 =?iso-8859-1?Q?H4KMZVigSXROCf+O72A7msQvka38evIxJ99QzQwNPnY6xvYYbxlMHrODfI?=
 =?iso-8859-1?Q?x/yGfJWfLO/MyySQ/narrNEwTLN6LAFbqyukeeOOgLe1RZTZE586JJTUkQ?=
 =?iso-8859-1?Q?G9wpGt5jTGd0ZRWXELT+/Iwa8nux2gFttVGDtSlYWno6b81HDir5bxPvJe?=
 =?iso-8859-1?Q?ZDsF7R/JtZxskwl2Y0boP5m5ntX8KJ/WPIgtsEf6UkKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+ez66XiW3oL1BlA4leSRhi0S2hYQCn0zGqSKfIWft+OQhsJdAtDFxpXIE2?=
 =?iso-8859-1?Q?TkEYBbFV8+rQJ1QoP4R2KsWhckyqZXRvUvLYLd38JNdF7qrQvEgm/wcQty?=
 =?iso-8859-1?Q?xgBVAU94AJEwhx4LtbslAWyU7V1IF/wUSYb+hHtFYe36dNfdR6vSsvol6x?=
 =?iso-8859-1?Q?WvTd8jjrwqopRz4mRj+XghUUF3nHHjTQ/7i7bzMa6twj6ZPffdgC5qy+7U?=
 =?iso-8859-1?Q?yyXMrASVzz5aEGoNfl/E5TtIziQ24n5QbrEF1z8aFFPl3HhHUxS+hRDY7l?=
 =?iso-8859-1?Q?p0u0Rw5kWIHoaBQfTD3ibVFg6ICMR3cKUnQ+d+GpW6tJxqHoqGNywjkxyE?=
 =?iso-8859-1?Q?FYPpxc8vAEsSOlty5g6QqDcJautIpmIcJpy6aPDMW1gsBjEVdVWK0Mj1+u?=
 =?iso-8859-1?Q?vT0nn/jNS65zAp73EIy10rNPJ6ZcPz7LSrJxHJ9Li0//0N2VMpylZNHw9C?=
 =?iso-8859-1?Q?BkJf4a/KfSs9t8f5bS57jIZhTCIRvCOUJdjoVtknhu4DnzcOSyBLBf30A0?=
 =?iso-8859-1?Q?1pyOsqPDnmWvnAqsBjKQtU3jqGpLXfLtpH5Xu+ZvLzAZeW1d+DLyoY1Puv?=
 =?iso-8859-1?Q?w+maN6Cr9l4TIJvOOP6aBqcqnQYQ1CrARfWT7XcGes2nhNJGmHdrf8SoQP?=
 =?iso-8859-1?Q?F/3XaC8zuuqzsLfTRYoxAk23TuA8U6QfWv8tO1/e8pno3Zp/A01gEzEIRT?=
 =?iso-8859-1?Q?SaxOin/rvhHpV4qlqqJBINk+Z8XGBc46vp0yqlEVSx6Dy6fTIA+mLn8YDN?=
 =?iso-8859-1?Q?mIb6A4jV9sHY2eIcq+kNW12ElP/Vbd0WNF5Tnpr5XFUGkeko1S6CUeLiMN?=
 =?iso-8859-1?Q?c/Yp+/guISQf6U5OxUJhSaAnAlly/JX7OUjNEIdbJAdZEsXM6R23HgIDsk?=
 =?iso-8859-1?Q?x9ACdEMpCf6lddZhzbpHwd3nP+q6KBDttenjQxn4AQy9+HVf/oanBrGpma?=
 =?iso-8859-1?Q?uayBV3WWvSxLEmW3ho+p3lr9l/wOmQ4T0asIwok2AhxPEX00SMA6Uej7zg?=
 =?iso-8859-1?Q?sdmDVC3K/fFklTiYmQMPi10TCrdLbOp5xZCl4OCpp53gLutejLNc+UwCey?=
 =?iso-8859-1?Q?aHJETF2kWQrrMONvZhvtF8NwuXwJ9BbnfbjF+JvZSeK5ycPZO7C58Xij+J?=
 =?iso-8859-1?Q?AZavIX1PI7CwvKsh1g9DlXIAqlgWwU30AvvwBpbNpiSHvUXSdI0Rmmt7Ac?=
 =?iso-8859-1?Q?9QHLGnTCElCunhXI3Ncinu14yMp7WZrAm4nHHyM3FL5IR5DYH/wKPTYiSW?=
 =?iso-8859-1?Q?l5n5YfX0AKGIDNtIZShVX78Y3rTnQaGAHa/zSPYHm+a+xFaepLKLOx0pRD?=
 =?iso-8859-1?Q?VLbr+JJrjfHqb5KqCXhKLwAo5fJB4Gfl0CVqOoTtPrIdh4jQ9xw/YioRYK?=
 =?iso-8859-1?Q?FXv+0pSrFdgoC7EXFXo+ocW250gjJDNt7EEzrIxW072XDZWHB/N0M9m7u6?=
 =?iso-8859-1?Q?NTeEmd49e7bpp4TWwcYoA8ocypK7pYelOlI5L7pt1t2l8X+mo2PqGg5mBU?=
 =?iso-8859-1?Q?o87dFsaAMN8E5ncwOqpJd+OLUh3FI4f6CkebKA4kbO0+icMRvsjoHDwZXr?=
 =?iso-8859-1?Q?GnhdVLWYINJXjWiNGYVwqID2gcshcZYfaxM3oSWzVQorbIncB0OlK+HELW?=
 =?iso-8859-1?Q?1U464oujkZfQs6wx7swy0Vss2L53SHFvKCuco0uNf98aPunEZ21FR+c5ov?=
 =?iso-8859-1?Q?L+AIITMJVGHfeNr2+wFtgbuwko50c+Vc8ECOI/gJPi39GthwUm0IjNjJVh?=
 =?iso-8859-1?Q?ntQQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ebe1c1-443d-4e3f-6754-08dd60b14fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 15:28:02.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNmwlfbvUdYX5HV1D8+mVZFP2+noUkhYiRLoG+4anQKbJCuQLO31o9r/RG7tbfcDdH1mYndqwoxO7PRIhnFBzc3lxSUtrM+/rMd3ttoIwnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4478
X-Proofpoint-ORIG-GUID: dSiqug63U-JE0z319BubsZ3V7IuIZKq7
X-Authority-Analysis: v=2.4 cv=GYXtnRXL c=1 sm=1 tr=0 ts=67d05696 cx=c_pps a=kbKyS8rizmOnFcp7qPeTiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=gvy1_uUhXv-25QhIcU8A:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: dSiqug63U-JE0z319BubsZ3V7IuIZKq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110097

Hello Jonathan,=0A=
=0A=
first I want to apologize for not being able to reply in-line properly, rea=
lly sorry about that.=0A=
=0A=
No problem for all your requests, except for flipping the logic of read/wri=
te event since we are planning to add very soon support for other events li=
ke steps and tilt.=0A=
=0A=
I will send a V2 with all the changes.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Saturday, February 22, 2025 17:14=0A=
To:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.t=
dk.com@kernel.org>=0A=
Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter C=
lausen <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.=
org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH 1/2] iio: imu: inv_icm42600: add WoM support=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Thu, 20 Feb 2025 21:52:06 +0100=0A=
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Add WoM as accel roc rising x|y|z event.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
Some comments on unrelated bug (that this duplicates) inline.=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  47 +++-=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 264 +++++++++++++++=
+++++-=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-=0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  56 ++++-=0A=
>  4 files changed, 363 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
> index 18787a43477b89db12caee597ab040af5c8f52d5..8dfbeaf1c768d7d25cb58ecf9=
804446f3cbbd465 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {=0A=
>  	bool temp;=0A=
>  };=0A=
>  =0A=
> +struct inv_icm42600_apex {=0A=
> +	unsigned int on;=0A=
> +	struct {=0A=
> +		bool enable;=0A=
> +		uint64_t value;=0A=
> +	} wom;=0A=
> +};=0A=
> +=0A=
>  /**=0A=
>   *  struct inv_icm42600_state - driver state variables=0A=
>   *  @lock:		lock for serializing multiple registers access.=0A=
> @@ -151,6 +159,7 @@ struct inv_icm42600_suspended {=0A=
>   *  @buffer:		data transfer buffer aligned for DMA.=0A=
>   *  @fifo:		FIFO management structure.=0A=
>   *  @timestamp:		interrupt timestamps.=0A=
> + *  @apex:		APEX features management.=0A=
>   */=0A=
>  struct inv_icm42600_state {=0A=
>  	struct mutex lock;=0A=
> @@ -164,12 +173,13 @@ struct inv_icm42600_state {=0A=
>  	struct inv_icm42600_suspended suspended;=0A=
>  	struct iio_dev *indio_gyro;=0A=
>  	struct iio_dev *indio_accel;=0A=
> -	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);=0A=
> +	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);=0A=
>  	struct inv_icm42600_fifo fifo;=0A=
This being after buffer also looks like a problem (see below)=0A=
This needs fixing.  Just  move it before buffer in a separate patch=0A=
and all should be fine.=0A=
>  	struct {=0A=
>  		int64_t gyro;=0A=
>  		int64_t accel;=0A=
>  	} timestamp;=0A=
Maybe this as well.=0A=
> +	struct inv_icm42600_apex apex;=0A=
=0A=
That seems unwise. It's in the region that DMA transactions may=0A=
scribble all over.  Move this before buffer or you'll get some=0A=
weird and wonderful bug reports sometime in the future!=0A=
=0A=
>  };=0A=
>  =0A=
>  =0A=
> @@ -253,6 +263,18 @@ struct inv_icm42600_sensor_state {=0A=
>  #define INV_ICM42600_REG_FIFO_COUNT			0x002E=0A=
>  #define INV_ICM42600_REG_FIFO_DATA			0x0030=0A=
>  =0A=
> +#define INV_ICM42600_REG_INT_STATUS2			0x0037=0A=
> +#define INV_ICM42600_INT_STATUS2_SMD_INT		BIT(3)=0A=
> +#define INV_ICM42600_INT_STATUS2_WOM_INT		GENMASK(2, 0)=0A=
> +=0A=
> +#define INV_ICM42600_REG_INT_STATUS3			0x0038=0A=
> +#define INV_ICM42600_INT_STATUS3_STEP_DET_INT		BIT(5)=0A=
> +#define INV_ICM42600_INT_STATUS3_STEP_CNT_OVF_INT	BIT(4)=0A=
> +#define INV_ICM42600_INT_STATUS3_TILT_DET_INT		BIT(3)=0A=
> +#define INV_ICM42600_INT_STATUS3_WAKE_INT		BIT(2)=0A=
> +#define INV_ICM42600_INT_STATUS3_SLEEP_INT		BIT(1)=0A=
> +#define INV_ICM42600_INT_STATUS3_TAP_DET_INT		BIT(0)=0A=
> +=0A=
>  #define INV_ICM42600_REG_SIGNAL_PATH_RESET		0x004B=0A=
>  #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN	BIT(6)=0A=
>  #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET	BIT(5)=0A=
> @@ -309,6 +331,14 @@ struct inv_icm42600_sensor_state {=0A=
>  #define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN		BIT(1)=0A=
>  #define INV_ICM42600_TMST_CONFIG_TMST_EN		BIT(0)=0A=
>  =0A=
> +#define INV_ICM42600_REG_SMD_CONFIG			0x0057=0A=
> +#define INV_ICM42600_SMD_CONFIG_WOM_INT_MODE		BIT(3)=0A=
> +#define INV_ICM42600_SMD_CONFIG_WOM_MODE		BIT(2)=0A=
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF		0x00=0A=
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM		0x01=0A=
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_SHORT		0x02=0A=
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_LONG		0x03=0A=
> +=0A=
>  #define INV_ICM42600_REG_FIFO_CONFIG1			0x005F=0A=
>  #define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD	BIT(6)=0A=
>  #define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH		BIT(5)=0A=
> @@ -338,6 +368,11 @@ struct inv_icm42600_sensor_state {=0A=
>  #define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)=0A=
>  #define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN	BIT(0)=0A=
>  =0A=
> +#define INV_ICM42600_REG_INT_SOURCE1			0x0066=0A=
> +#define INV_ICM42600_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)=0A=
> +#define INV_ICM42600_INT_SOURCE1_SMD_INT1_EN		BIT(3)=0A=
> +#define INV_ICM42600_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)=0A=
> +=0A=
>  #define INV_ICM42600_REG_WHOAMI				0x0075=0A=
>  #define INV_ICM42600_WHOAMI_ICM42600			0x40=0A=
>  #define INV_ICM42600_WHOAMI_ICM42602			0x41=0A=
> @@ -373,6 +408,10 @@ struct inv_icm42600_sensor_state {=0A=
>  #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)=0A=
>  =0A=
>  /* User bank 4 (MSB 0x40) */=0A=
> +#define INV_ICM42600_REG_ACCEL_WOM_X_THR		0x404A=0A=
> +#define INV_ICM42600_REG_ACCEL_WOM_Y_THR		0x404B=0A=
> +#define INV_ICM42600_REG_ACCEL_WOM_Z_THR		0x404C=0A=
> +=0A=
>  #define INV_ICM42600_REG_INT_SOURCE8			0x404F=0A=
>  #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)=0A=
>  #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)=0A=
> @@ -423,6 +462,8 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_st=
ate *st,=0A=
>  int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enabl=
e,=0A=
>  			       unsigned int *sleep_ms);=0A=
>  =0A=
> +int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable);=0A=
> +=0A=
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg=
,=0A=
>  			     unsigned int writeval, unsigned int *readval);=0A=
>  =0A=
> @@ -437,4 +478,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_ic=
m42600_state *st);=0A=
>  =0A=
>  int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);=0A=
>  =0A=
> +void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,=0A=
> +				      unsigned int status2, unsigned int status3,=0A=
> +				      int64_t timestamp);=0A=
> +=0A=
>  #endif=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> index 388520ec60b5c5d21b16717978ebf330e38aa1fe..8ce2276b3edc61cc1ea268101=
98dd0057054ec48 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
=0A=
> +=0A=
> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev, bool=
 enable)=0A=
> +{=0A=
> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
> +	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(indio_dev);=0A=
> +	struct device *pdev =3D regmap_get_device(st->map);=0A=
> +	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_INIT;=
=0A=
> +	unsigned int sleep_ms =3D 0;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (enable) {=0A=
=0A=
Not a lot of shared logic. Maybe split into enable and siable functions.=0A=
=0A=
> +		ret =3D pm_runtime_resume_and_get(pdev);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +		scoped_guard(mutex, &st->lock) {=0A=
> +			/* turn on accel sensor */=0A=
> +			conf.mode =3D accel_st->power_mode;=0A=
> +			conf.filter =3D accel_st->filter;=0A=
> +			ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);=0A=
> +			if (ret)=0A=
> +				goto error_suspend;=0A=
> +		}=0A=
> +		if (sleep_ms)=0A=
> +			msleep(sleep_ms);=0A=
> +		scoped_guard(mutex, &st->lock) {=0A=
> +			ret =3D inv_icm42600_set_wom(st, true);=0A=
> +			if (ret)=0A=
> +				goto error_suspend;=0A=
> +			st->apex.on++;=0A=
> +			st->apex.wom.enable =3D true;=0A=
> +		}=0A=
	return 0;=0A=
=0A=
> +	} else {=0A=
> +		scoped_guard(mutex, &st->lock) {=0A=
> +			st->apex.wom.enable =3D false;=0A=
> +			st->apex.on--;=0A=
> +			ret =3D inv_icm42600_set_wom(st, false);=0A=
> +			if (ret)=0A=
> +				goto error_suspend;=0A=
> +			/* turn off accel sensor if not used */=0A=
> +			if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {=0A=
> +				conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
> +				ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);=0A=
> +				if (ret)=0A=
> +					goto error_suspend;=0A=
> +			}=0A=
> +		}=0A=
> +		if (sleep_ms)=0A=
> +			msleep(sleep_ms);=0A=
=0A=
With return above, you could share this with the error handling.=0A=
=0A=
> +		pm_runtime_mark_last_busy(pdev);=0A=
> +		pm_runtime_put_autosuspend(pdev);=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +=0A=
> +error_suspend:=0A=
> +	pm_runtime_mark_last_busy(pdev);=0A=
> +	pm_runtime_put_autosuspend(pdev);=0A=
> +	return ret;=0A=
> +}=0A=
=0A=
> +static int inv_icm42600_accel_read_event_value(struct iio_dev *indio_dev=
,=0A=
> +					       const struct iio_chan_spec *chan,=0A=
> +					       enum iio_event_type type,=0A=
> +					       enum iio_event_direction dir,=0A=
> +					       enum iio_event_info info,=0A=
> +					       int *val, int *val2)=0A=
> +{=0A=
> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
> +	u32 rem;=0A=
> +=0A=
> +	guard(mutex)(&st->lock);=0A=
> +=0A=
> +	/* handle WoM (roc rising) event value */=0A=
> +	if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING) {=0A=
=0A=
Similar to below. Consider flipping logic.=0A=
=0A=
> +		/* return value in micro */=0A=
> +		*val =3D div_u64_rem(st->apex.wom.value, 1000000U, &rem);=0A=
> +		*val2 =3D rem;=0A=
> +		return IIO_VAL_INT_PLUS_MICRO;=0A=
> +	}=0A=
> +=0A=
> +	return -EINVAL;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_de=
v,=0A=
> +						const struct iio_chan_spec *chan,=0A=
> +						enum iio_event_type type,=0A=
> +						enum iio_event_direction dir,=0A=
> +						enum iio_event_info info,=0A=
> +						int val, int val2)=0A=
> +{=0A=
> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
> +	struct device *dev =3D regmap_get_device(st->map);=0A=
> +	uint64_t value;=0A=
> +	unsigned int accel_hz, accel_uhz;=0A=
> +	int ret;=0A=
> +=0A=
> +	/* handle WoM (roc rising) event value */=0A=
> +	if (type =3D=3D IIO_EV_TYPE_ROC && dir =3D=3D IIO_EV_DIR_RISING) {=0A=
=0A=
If you don't plan to add other event types soon I'd be tempted to flip=0A=
the logic of this to save in indent and exit early in the error case.=0A=
=0A=
> +		if (val < 0 || val2 < 0)=0A=
> +			return -EINVAL;=0A=
> +		value =3D (uint64_t)val * 1000000ULL + (uint64_t)val2;=0A=
> +		pm_runtime_get_sync(dev);=0A=
> +		scoped_guard(mutex, &st->lock) {=0A=
> +			ret =3D inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);=0A=
> +			if (ret >=3D 0)=0A=
> +				ret =3D inv_icm42600_accel_set_wom_threshold(st, value,=0A=
> +									   accel_hz, accel_uhz);=0A=
> +		}=0A=
> +		pm_runtime_mark_last_busy(dev);=0A=
> +		pm_runtime_put_autosuspend(dev);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	return -EINVAL;=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index ef9875d3b79db116f9fb4f6d881a7979292c1792..c0fd2770d66f02d1965fa07f8=
19fd2db9a1d6bd2 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -404,6 +404,35 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_s=
tate *st, bool enable,=0A=
>  					  sleep_ms);=0A=
>  }=0A=
>  =0A=
> +int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable)=0A=
> +{=0A=
> +	unsigned int val;=0A=
> +	int ret;=0A=
=0A=
Given the set and disable code paths have no shared code, maybe split into=
=0A=
two functions?=0A=
=0A=
> +=0A=
> +	if (enable) {=0A=
> +		/* enable WoM hardware */=0A=
> +		val =3D INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |=0A=
> +		      INV_ICM42600_SMD_CONFIG_WOM_MODE;=0A=
> +		ret =3D regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);=0A=
		ret =3D regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG,=0A=
				   INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |=0A=
				   INV_ICM42600_SMD_CONFIG_WOM_MODE);=0A=
Seems not to loose any readabilty and avoids need for local variable.=0A=
=0A=
=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +		/* enable WoM interrupt */=0A=
> +		ret =3D regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,=0A=
> +				      INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);=0A=
return regmap_write()=0A=
> +	} else {=0A=
> +		/* disable WoM interrupt */=0A=
> +		ret =3D regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,=0A=
> +					INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +		/* disable WoM hardware */=0A=
> +		val =3D INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF;=0A=
> +		ret =3D regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);=0A=
return regmap_write()=0A=
and no need for val as I don't think that adds any readability advantages h=
ere.=0A=
=0A=
> +	}=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg=
,=0A=
>  			     unsigned int writeval, unsigned int *readval)=0A=
>  {=0A=
> @@ -543,11 +572,22 @@ static irqreturn_t inv_icm42600_irq_handler(int irq=
, void *_data)=0A=
>  {=0A=
>  	struct inv_icm42600_state *st =3D _data;=0A=
>  	struct device *dev =3D regmap_get_device(st->map);=0A=
> -	unsigned int status;=0A=
> +	unsigned int status, status2, status3;=0A=
>  	int ret;=0A=
>  =0A=
>  	mutex_lock(&st->lock);=0A=
>  =0A=
> +	if (st->apex.on) {=0A=
=0A=
I'd drag the declaration of additional local variables in here.=0A=
=0A=
> +		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */=0A=
> +		ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_INT_STATUS2, st->bu=
ffer, 2);=0A=
> +		if (ret)=0A=
> +			goto out_unlock;=0A=
> +		status2 =3D st->buffer[0];=0A=
> +		status3 =3D st->buffer[1];=0A=
> +		inv_icm42600_accel_handle_events(st->indio_accel, status2, status3,=0A=
> +						 st->timestamp.accel);=0A=
> +	}=0A=
> +=0A=
=0A=
=0A=

