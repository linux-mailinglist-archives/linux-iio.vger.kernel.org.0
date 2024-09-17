Return-Path: <linux-iio+bounces-9628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829097B0A2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F7F28394F
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C31173320;
	Tue, 17 Sep 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="CaSjVO9+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87914D444;
	Tue, 17 Sep 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578846; cv=fail; b=kfYZZd3DeilfsVIppVsPopti4pH0AdRGag9uhZ8Lp0K0uz6atBreyOe4abDgKoGaHVCVXPQcQ4zIT/T3y9fKfR5QaUOmsFS4CJHcT1Ey58LciWOGcfYvz7KdBdc1UoGqpJ6K2SxBoof4kiszkMBLwHSz/JwL0dpHbPh1FLZNcJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578846; c=relaxed/simple;
	bh=3KZuEIDQRxXsqC3eSPA3bPZkJaExOWKMmnDjaRWKahQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aftoYbNYig2+tIir0RY2AoxK+8FxP2+EaZ/jD5OQ4PVv7qHPWqJKFeh32MHyBTbWScsz/MauiL2zm5OD9eQ2vMM2u7sewgO2Ra5sb88086CWklD6shzBqqkxSF7IjSjkNh4gI3lh9U8offLLUXia1cDpryekGbKFEDYxGwVCsGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=CaSjVO9+; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUZE0gR/VMT/Vz3E7jvBsA3Fttu04vdtoVh5+LdilYoseA7zRI9F9XU0X4CF/uschuaiNv0M8q7KSANPp12A9WsXWjZQUFon75OfnshwVMrretezZEwrHYNZbN319leRBJeB1YV7q87SeHRQkMhQagLelaA/WJwf26heiWXMvAhpW1In7+FhP6iE8BfEzQg+KIZp4Yl2KBfqI9Dyv2weOOI1JP+TmZvtGcpwFWv+0dNV1sAoo7mwyHdIkJ4S+fsXnG9qdmORzwJ50lUGkgX+XIE1zuFKzf++aTsNLrEePajwpNB9SWO432Dkim59P95wc+Z+MtwT8f8eS9Nz3Db+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqr5Hz464OC4C9+ktTBPcZV7VtW4kWFIqyecEkx6PBA=;
 b=RMzZX2iv9xUvkzABoXMG58lPVgOujqMIfZynczEBCDKc/c3IeN1fbmT84hW0J7OI1BFqVPQrNbLDIGMtERVtB7RdZrkuP/Rz42VjrC+Px0aS9edXBIXa7lHD1OUw+1abapRCLqDa912Ot18muzQ5DbiH81Pqe6i+yuFs/SZgqu54gKZYY1yayJeMod1QVrK+CDUY/hGK3J7RvUnYvVAfwWhzBFWPpve7TfsMThKArnDO4k73tFcodpjkOFWkunGbd4poTplqX086VADtuqnUGL2vySoYPeP72cHsBNrKyL40jt5wmuhsA7WA1CDr4zxVn4yosATktQF+EhBKVhyNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqr5Hz464OC4C9+ktTBPcZV7VtW4kWFIqyecEkx6PBA=;
 b=CaSjVO9+Pd3Srn1xBI1HGMOKqgXXNviCWIiBtEVN92QU6C/DsUb2kAAZd9zuJ55SY6YVcj2vjCAs+c3gQx4AyscOSkyuwB0mBHNeS1b66wcuZhJBeipSiGWHbMBZVxJEdDqZ1FFYvCEwhCVierRllIwacH2QqjK60Wfu3UtQXlrbrgIknMG5Pca6EXtph3MlNgBOt9q04mMvrOPDoPARf4yJx9R7DQiLLHZ/ofD/amZafDjX+tRNO+UpNoS2swkMfnDBkYjR40E5Fy3rcdKrWLSGhPB1C4fhXd0JSRbg7TEizpYwJVkBdld7MUcGoEdmvIIM12EQx7ry6w/0vdHcvQ==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DBAPR10MB4057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 13:13:57 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 13:13:57 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenz
 Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike
 (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v7 2/2] iio: imu: smi240: add driver
Thread-Topic: [PATCH v7 2/2] iio: imu: smi240: add driver
Thread-Index: AQHbBcPr5qpIygQlnEirrZ7fjzK4yLJXe9mAgANiFgCAAPumgIAACMqQ
Date: Tue, 17 Sep 2024 13:13:57 +0000
Message-ID:
 <AM8PR10MB4721D14E9A13F1DE04FA8B68CD612@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
	<20240913100011.4618-3-Jianping.Shen@de.bosch.com>
	<20240914173229.57548005@jic23-huawei>
	<AM8PR10MB4721196E13BCDAD7ABAD8E85CD602@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20240917121301.3864a3f7@jic23-huawei>
In-Reply-To: <20240917121301.3864a3f7@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DBAPR10MB4057:EE_
x-ms-office365-filtering-correlation-id: caa5c372-4efe-4e4e-ceb9-08dcd71a96cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pil8weTitGbC5rcHAxhGjRuPmymOF/LTilVnyfReZjU+CO8MqQQYN3LOn0aM?=
 =?us-ascii?Q?nGZOO4yDJYRV5i9FT0Rd4lppKF6bTbMi13ZGsPe6o6Nher7itHgHCnl0e7ta?=
 =?us-ascii?Q?YqxCifnwG12vqlK8ju8ki4gWtz8+3F8y2rsXLf57TJCR7WuzGFAe9XD0L4Mo?=
 =?us-ascii?Q?lIetrlZ7PJBH/wjdYpphDCgkGkBvox0Mre3ZcmFtWiiRiV2Di8ZLSpqOmZ1u?=
 =?us-ascii?Q?xg3yRgsAXgLz4YQQDyAd2lyLEcYqSjmRUdJDqObgYfZ3WXqPUY/qlx5H5XhO?=
 =?us-ascii?Q?KCaJbxI9fbjcgZ5zO4imJn0f8OxJ4LYwjFVkxdmcIdhC3e7feogYxiT+g2zt?=
 =?us-ascii?Q?haMWkTOIkz8+3G1fyvJBu3cWcdy8RGF3VxRQyUqcJd8okh4JKG9lSxn/SPoC?=
 =?us-ascii?Q?CTE7my47kIFAe5BtLiY4hzOVmenSs/neD2gE4II+B3R/kkBdNm7DP4D/FsVB?=
 =?us-ascii?Q?aB7Ab7IiJpWpsQxu1vQTSFVMhuiKgHV7Fh4mr3O6PLa8nxKBfU++BrF5V1yh?=
 =?us-ascii?Q?U2oxpvRgKAmTcD7U7qHxkwJoC4xMbbd6Rx1591A4MRpbnFQqb4nXu+WID6fM?=
 =?us-ascii?Q?YNTj6xyjMPCVifim2+ijmrl/3Ums8y0un88zk5ipFHO1w2Ott73uwABCVbul?=
 =?us-ascii?Q?FGCYZBbireFy/gB/y8KqX/obrNmjbi9YrXE2ezMnhYoVzblWbnxkLm/DKJU4?=
 =?us-ascii?Q?kFEShAFjC3iC0GsZ/LuoYhw6At1yeuq4BI0YiKB+splmsTCys1n89IXmzK7r?=
 =?us-ascii?Q?N4QIJ8o9sOZEHnARMLOMqGJKTKrB5sGzvoz+HQm5nFQSTNxRpP7Ll2ov39fW?=
 =?us-ascii?Q?2EKZW7jsfxYfk/mIoqDCIs+6XvpdpIST4WCKtHjt9kYxRZBoIlxfT+Q8Kxb+?=
 =?us-ascii?Q?zo1kiD4F/fNEOPLHWKdogTsXq9WZdONg1MavwlJnr04Javz1ZXESyymfFNF6?=
 =?us-ascii?Q?wRdrcuTM6aulb6XX+bRsc2qt8yPwYPp+C1rwENj2QIFBTIqPmtnBydlFXNEw?=
 =?us-ascii?Q?4I2c4Ec+YtgLdzhrhoLtKojhRG8l+QzTdlTp+rUO8UTCz72JLJg+LXuNPKI0?=
 =?us-ascii?Q?mQePPUYfQyW9V1imrtzfNFrfDdTQ0CkizX1pvKzboLoP6RUsHjSGSFxE/vAD?=
 =?us-ascii?Q?+buIw/xzwG/yk914xjCHdcv6JHNcW6m4hD3ragSAJnEkd8BwqbUobctNuXG9?=
 =?us-ascii?Q?JO5rWGmEAHqFNI78YNBoYJtrm5tBDJYou68WaLjX7NTJZ+g2BpBLM46YaMjg?=
 =?us-ascii?Q?zUKvyEFnCRi20kVcvmCslUj24T2vl1Em5yJl0U3NoSktRG3fZoDxQDO4G84P?=
 =?us-ascii?Q?GL/7m3XlyGcGVt91SOi9rUGkpTTJQtm9/AjCpSWB8Vv0iDqCt+uLi78fH9sw?=
 =?us-ascii?Q?dXNRDq8YKuuiOL2Vohd5aNUEBFL1qzcrSmrckWJVZ+gg4NgT+w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KmQxYeiv0bX0D+45wgipkDVy7ODp0BY4LxFnn/X4OeGfwM2TgQKYyrOc5os3?=
 =?us-ascii?Q?u4A8b2Q0y2qFL/xrbDlZUuOD+TD4jG+FRQ0LBuBQBMXFBndYObxpLTjL9B+B?=
 =?us-ascii?Q?4fxEiynrl3i7onFHLzgrIBqd6OWGTNURtuHsqJxqoTCHQtvLH+zWP7Svbm0M?=
 =?us-ascii?Q?tPts5RO196ybh0znDklwm8ot6hG+H339NJMzsyAGQzh/E40vETNuv4XMHj/u?=
 =?us-ascii?Q?1v0gAyPNglj/cerkrVlIxnxXaBF+BWO58z518F92pwD0xkypAsQI/D/Jwzl0?=
 =?us-ascii?Q?KPJD4HMftM1Hu0f+DQ3TGuEfV+1upfXJuASxpXaLhYFJeXt8fTmpsNpPSgRO?=
 =?us-ascii?Q?8zAgtWw6Mx82LrngT7JEu/U7xtOI9ovz3veRV5wuGlXhns2hHjfSIdkcpjwU?=
 =?us-ascii?Q?qvlJup7p5FQhglj9Y8CYYFUDQBFaVAmNP+vquwmIx7auvAiRZpzH9cVBV8Tc?=
 =?us-ascii?Q?ilEDFo5E3QX0qsiqj8wPNGqOmyaGPjYxX5XZQqh9xfvdDqH3cebTGNSaB6IH?=
 =?us-ascii?Q?A04A4P6SUaOZyiMC9qaUVZcza8ga72I3wYxscmL5FzwbEunm15ju633M8p2+?=
 =?us-ascii?Q?7rbhtdG2yHvGtIlpuAsGmKKsVegvaJnxXRGiP1r4HikPMQZs00XPOSLMLMCH?=
 =?us-ascii?Q?rD/e8PBNKe6m4RNHiRO97oPFkQgsEttCczeZXXyZPOUESz6AF2XzUE9yYslv?=
 =?us-ascii?Q?ibLT0FBYpGmlDbgnFmjp2gBF/MoC+O8TN/rBhadMLthNCn/EOQB42HP2E5v6?=
 =?us-ascii?Q?Ix8+IPBPwXau/EznXrpNrneLzk6ooWgovw9ZHJrTSEywYoaBsK/zJJvHgsNX?=
 =?us-ascii?Q?8HG4R5YFsIdfehcrqSURqQakV5sKZB5OVhlIFSRO9BgDkYmQJFYRCSG3jfN3?=
 =?us-ascii?Q?ngjadw5P4bd747UhyaGgrvwhkgveTmR1lJHve/CjOtXPr34zx2YnCDI0LByu?=
 =?us-ascii?Q?go1udPFulSdRo2mOcA3tnbLMVKd0JRaDypiQ+ls/uMBmMfaa0yKJaA97MB6I?=
 =?us-ascii?Q?RjN2vzoU/0MI3hS58KMHxCheQNyYJikL/YfkKR/8Z13YabjMuM9Y525B5Gou?=
 =?us-ascii?Q?y2EYHPbADglSkjqF7/rt2nkiRIypgwoitXk6jXZ3RAR9Qis/6Ri4DXLrXx5C?=
 =?us-ascii?Q?2q2aPqJ4Hq0yc63M1AdubFzidtjW7GIeRrclBA58jTcMvf9omJYj9RuRaWWl?=
 =?us-ascii?Q?nQ8f0WHvXdsgqlOlFDPT2Hi0K8gBqM9if+SXcxvvZ0b9C9aJNoTn2U8vueJO?=
 =?us-ascii?Q?0q9A/XoTcZwdArqulNRZEW5SUtM3AbQSzDrSKgw5eiFGpyMlAhgW8TZBvnYd?=
 =?us-ascii?Q?urw3DOULamCiWSmewaCHQFFADz0qo/fB0OouCWHpGN7s9bqmQlxz9hMhsp0w?=
 =?us-ascii?Q?O+PO8tVpROO+YAa9h/qnZusRRpxeslab6olpYytzD7srIj2YbzgIsJCCIf/e?=
 =?us-ascii?Q?plj3thU3IGLxSBvcCdFhtFAtrjMW5fY5ftSSW8/1y5zQeDeK3WHK7umNX6S2?=
 =?us-ascii?Q?xR1tq2E2M1osGoE9g5bO9IB7UHknSMlO5mM36Ybu+GN1DcanrDfsRakpYu04?=
 =?us-ascii?Q?cxyv5/Tsb8oY31LK0Xk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: caa5c372-4efe-4e4e-ceb9-08dcd71a96cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 13:13:57.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38N2Joe2vprnecHDkgvQR+lwiOT6aYYWpRE28DhRnapN5IrxiebFByfbcpw1VO6d/SZQjm1fu8V13yVqXB3qNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4057

>> >Hi Shen,
>> >
>> >I suspect I led you astray.  regmap core seems unlikely to feed us
>> >little endian buffers on writes (they should be CPU endian I think)
>> >so there should be memcpy() for that not a get_unaligned_le16()
>> >
>> >> +
>> >> +static int smi240_regmap_spi_write(void *context, const void *data,
>> >> +				   size_t count)
>> >> +{
>> >> +	u8 reg_addr;
>> >> +	u16 reg_data;
>> >> +	u32 request;
>> >> +	struct spi_device *spi =3D context;
>> >> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
>> >> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
>> >> +
>> >> +	if (count < 2)
>> >> +		return -EINVAL;
>> >> +
>> >> +	reg_addr =3D ((u8 *)data)[0];
>> >> +	reg_data =3D get_unaligned_le16(&((u8 *)data)[1]);
>> >
>> >Why is the regmap core giving us an le16?
>> >I probably sent you wrong way with this earlier :( memcpy probably
>> >the correct choice here.
>>
>> Yes, you are right. We shall use memcpy to keep the be CPU endian.  Just=
 using
>memcpy may be not enough.
>>
>> Shall we also change regmap_config.val_format_endian  from
>REGMAP_ENDIAN_LITTLE to  REGMAP_ENDIAN_NATIVE ?
>>
>> This is to make sure that regmap_write passes the reg-value to
>smi240_regmap_spi_write without changing the CPU endian.
>>
>Hmm. I'd missed that control.  If the register data needs to be little end=
ian then it is
>correct to leave that set as REGMAP_ENDIAN_LITTLE as then the regmap core =
will
>do the endian swap for you on Big endian systems.
>
>If I follow that bit of regmap correctly it will then have the data in the=
 right order so
>the above still wants to just be a memcpy.
>
>As it stands, on a Big endian host, regmap will use the val_format_endian =
to decide
>to flip the bytes.  This code then flips them back again and the value wri=
tten is big
>endian which is not what you intend!
>
>Easy way to check this will be to set it, on your little endian host, to
>REGMAP_BIG_ENDIAN and see what you get in the value.
>Then consider if you'd had get_unaligned_be16 then it would end up as litt=
le endian
>again.  This should mirror the current situation if this driver runs on a =
big endian host.
>
>Hope that confusing set of comments helps!
>
>Jonathan
>
Hi  Jonathan,

we check the regmap behavior with the following tests

1. host : little endian   val_format_endian =3D=3DREGMAP_BIG_ENDIAN     reg=
map_write(data->regmap, REG_ADDR, 0x12AB) =20
    then  in smi240_regmap_spi_write(void *context, const void *data, size_=
t count)    we have data[0]=3D=3D REG_ADDR, data[1]=3D=3D0xAB , data[2]=3D=
=3D0x12=20

2. host : little endian   val_format_endian =3D=3DREGMAP_BIG_LITTLE     reg=
map_write(data->regmap, REG_ADDR, 0x12AB) =20
    then  in smi240_regmap_spi_write(void *context, const void *data, size_=
t count)    we have data[0]=3D=3D REG_ADDR, data[1]=3D=3D0x12 , data[2]=3D=
=3D0xAB

3. host : little endian   val_format_endian =3D=3DREGMAP_BIG_NATIVE     reg=
map_write(data->regmap, REG_ADDR, 0x12AB) =20
    then  in smi240_regmap_spi_write(void *context, const void *data, size_=
t count)    we have data[0]=3D=3D REG_ADDR, data[1]=3D=3D0x12 , data[2]=3D=
=3D0xAB

when regmap_write passes the reg-value to the underlaying spi-write functio=
n, it flips the bytes if  val_format_endian !=3D cpu_endian

Since we prepare the request and the reg-value (as part of the request) wit=
h cpu_endian, we need to make sure that the cpu_endian keeps untouched unti=
l we pass the whole request to spi buffer using  "iio_priv_data->spi_buf =
=3D cpu_to_be32(request)"
Therefore we need to remove the change of cpu_endian during the request pre=
paration.=20

1. Instead get_unaligned_le16 now we use memcpy to take the reg-value witho=
ut changing the cpu_endian.
2, we use REGMAP_BIG_NATIVE on val_format_endian to make sure when regmap_w=
rite passes the reg-value to the underlaying spi-write function the cpu_end=
ian kept untouched.

This makes our driver be able to work properly on both little endian and bi=
g endian host. We tested the new changes on little endian host it works pro=
perly. Big endian host case is not tested yet, since today the big endian p=
rocessors are almost dead.

The next version will looks like that.

static const struct regmap_config smi240_regmap_config =3D {
	.reg_bits =3D 8,
	.val_bits =3D 16,
	.val_format_endian =3D REGMAP_ENDIAN_NATIVE,

};

static int smi240_regmap_spi_write(void *context, const void *data,size_t c=
ount)
{
	u8 reg_addr;
	u16 reg_data;
	u32 request;
	struct spi_device *spi =3D context;
	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
	if (count < 2)
		return -EINVAL;

	reg_addr =3D ((u8 *)data)[0];
	memcpy(&reg_data, &((u8 *)data)[1], 2);

	request =3D FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
	request |=3D FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
	request |=3D FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);

	iio_priv_data->spi_buf =3D cpu_to_be32(request);
	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
}

Is the new version now correct ?

Best regards

Jianping Shen











