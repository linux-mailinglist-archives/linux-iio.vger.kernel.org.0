Return-Path: <linux-iio+bounces-10393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F0998C5E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42C5B369D9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05511CDA05;
	Thu, 10 Oct 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ru4Haolm"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A254658;
	Thu, 10 Oct 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572546; cv=fail; b=AdFPjzqHdMbHUXp5tbOcTLcuAJyXiLqLpbyx2r3uFkAnc5x7WW//vxW7OqOZAMgegrW1DcV91xKry2ZH6XkPy/0+HlSkia+/025fFkLHxSoubbB6tdRUcRSnEN6vsLBvJeS5XiV9FD9efupZYIlrc1oh59o3aZn5u5pgGJo4tSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572546; c=relaxed/simple;
	bh=FUv5xAdEhVeR/uIPf3qFB7SoaLaJY/EaaohwyRF0dYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXbC7a+00B/dOreLq8mPRpjIhfqpwO9oZ0cW+1ac1/RtGFjpCCcN37Mcf7mRqebRYnOqB6snDFc+jld+ojGw/ad9gC5/kqvbXeS7ujraTxkUFTRT/OG6UABeFNgw1m+2XZWFV/eNIRNLQjV5OPEDX/EKEGd1uL9fZBo35gB8Xt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ru4Haolm; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ6bhVr8CmnnNuPH7byn9PNCGScpyTIGjoJWlXdtZusHTHAFmqF9+6G828AjoXsXYFsRYAkBxpgnQ+n7hre6XgyMyDs6mNWkNsPN+SiDFmYaLHu9l5AxnrvmKFfO/+aCosj1KzcmhtYgEFy+9gUdNIjFkTvmKlhz56cQtQ7B6S/pAd85RF3pWl+RMIaP8WQmNOJlRarv5MzQA4FB6EvMKYPba16a1fbuOQ7Bw6x7ljXBVDadZRNqJx5b+x7vxHi8BrHha9yYYtuDy3MXXA6D8whGdodZCu8Y800J6Zk4WnFL75aJ1bFeOPlJ9fLur5TU3KGE4u42K/ZnzwTsBZKh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IEIBB4VOqewIu5ELbHfhzhXTx+DCl9JQEOJ+x4h7Bg=;
 b=IrgJJffJDaZDBuIrTVCTI3vhUtKgROvvFk61pdYXybQzWXaj9/qG0BjazcuOScq1xw860Y4zMppszq1hD697Faq/HBQn7bn3lU4yyMPReCjo3dEVJ4ISSfXAE02pL/4sSjXclhCP6X0Cd2pmNHKsUdrFuKFjMOhgyy4ZsDj6IZMOLR20hOp2Gb1oga5r/EtCADjl9AOr3KoJ9k1wrUakdsu+FvV6CtfwktnGUHSpNib5GHqgx5wnaMYnqZxtE2rrJRkS8/PIOczdvjvM2pJ6D+9bkaVe5d5FYm6w2+OynITn59Pe3hvdUA580CvjfjBDXujVyjNyjH9fpJAcdrtwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IEIBB4VOqewIu5ELbHfhzhXTx+DCl9JQEOJ+x4h7Bg=;
 b=Ru4HaolmAjf52GRAPdb+MUJbEv3lSZlCTBCZsjscTBqsTkqAcKav7mU14xo9akKcJVRleZpz5fhn0r84b8IDSKWibY29j9zBnsxBqf7XAPUOoUATm9KJWDIlDDQE2dOF0ZuqUieDeQ5zQbssIAAO9pFQToDA5nUlsOXXZJD6S7C1T7ujqjvOVjJc1FXwOm4tXcB9+hjiKz9a7meDMmOc1LXoiFCBla3FmdrWn+BkUdJ9t1hovE1+CGP8wDqyqbOS2RVd2H4BAlto9qk4/Z9k0zXjulXP8H0y9aV404yJmBAn4ueC/kxhlu1+GrTC7S1d5RSY0z8ELWwkM+r/ntLbmQ==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DU0PR10MB6058.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Thu, 10 Oct
 2024 15:02:18 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:02:18 +0000
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
Subject: RE: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Topic: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Index: AQHbDbXQJyb1UEtvh02vtlWF5Bgo7rJtd3WAgAf1bqCABDhggIAGe/cw
Date: Thu, 10 Oct 2024 15:02:18 +0000
Message-ID:
 <AM8PR10MB47213230C6E43976AF244587CD782@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
	<20240928181121.0e62f0ad@jic23-huawei>
	<AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20241006121025.50802061@jic23-huawei>
In-Reply-To: <20241006121025.50802061@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DU0PR10MB6058:EE_
x-ms-office365-filtering-correlation-id: ddef6787-fa3b-4967-74c1-08dce93c8929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dPVWt6fpFagcyaE6818ePMrZp336Ef63XWVNI34zqR4JGBeD33P9W3xS9jUi?=
 =?us-ascii?Q?UucLFhkDQeS7jsJBpuI7a1xPExyu5irfNARCQNoZg0qnFbk05QIEk+OLzXPC?=
 =?us-ascii?Q?OBtGQpg3Y1KfuSevHCCLWR/wDOqWGjPUx4aHv+R7XcRjlStbKvhVaJjFOYqI?=
 =?us-ascii?Q?TQht52TOR+g7mPQbQ4fXRLFgg1IgdCP+IX5K4W7NvrtDIf65Br6ziS0L5Pi1?=
 =?us-ascii?Q?9kZulyLdJZAZqiVPzRXZXKyMkptuRoBcyM9qvby5j/GwXVIzM/8F77htgHx3?=
 =?us-ascii?Q?LWFjFvJ2WB8nR+WrOo5wlkBhQ+Xan1cDyFbzh9hSVy3ba2jRUxqMEH4GuV9V?=
 =?us-ascii?Q?nd5WQlBGOdEch7Ho/fddE121aJY1iFTuRqck2ioNmL++jTBLcjxIGLBBMmAD?=
 =?us-ascii?Q?3a8+VoxprvjOc9brjKObYwpfDVFMWdIhltQYVeS0OBI7ZjxwiQbund6/m6SX?=
 =?us-ascii?Q?Po9WJFz5l18XNOzRbFJK23am7lFlcOyrOF/sem73H793NfBCk8d5esb4lU/7?=
 =?us-ascii?Q?GEbt4M7jeketFdQT/5wW88bV3ozTENwS/CQPQactpWr5qzJsFxdOXbmIyu7I?=
 =?us-ascii?Q?DSD5ppC3kKRt6+lxMAxeY3qbJaqj9TNbWVArdlOu7aK6KNccZz+wVkPRlTZr?=
 =?us-ascii?Q?yqQ069zFGwWaAVfhSiHvMJ8u3WHWtFXFztFqMaVmWq/s8sANwLuoHsu0xB24?=
 =?us-ascii?Q?/BRxAWm2x/2ASWjuwNMQlZs/wAY4rc6bTyOwkYDIOjClyWm+E6aFg02pHzCk?=
 =?us-ascii?Q?9zcbJouV0aRp5TBT4zHtfu1e+HSEIvBB0H1AJFaaOSmtfrzfsGW09cTL/iPm?=
 =?us-ascii?Q?hPfIN92Kyn3ZUniDYNevOvgo/k6rRql58N+j1E0FnTZV7phZrWDyrwn3Eesl?=
 =?us-ascii?Q?V7Tt/+SEad1d8Y9s2OBW5FU3xkcQLnMdK5S42oniCRisdx/lpkj9HJLcdSb+?=
 =?us-ascii?Q?No9PQKhmoVKGKysa/ZQRIYg+2zV+eCl+M+mANnDYfytuR7QLgZDYb3Wbgfp7?=
 =?us-ascii?Q?i8JQdgYkYoXtM0pQFRJvdSEZnj3z1ORiyi/3QJuzd4NUxwd1J4X2DK8dLr1F?=
 =?us-ascii?Q?aH6oeOL1lNf03Ze6kQOjG4jmWTHwqLjAanI+G06eEGTY2X/QiGoOD7krVDz7?=
 =?us-ascii?Q?szXQuEDTWXIWX/ldUPlQ77U1p1NT33rDHXbjvSNNrLrv4QUdnAy7wkDvNXLI?=
 =?us-ascii?Q?Fe6NPjDPUbaNlp6LwBfRvR+K7x77ek/UpiqRH40TxAPLGRfiS4N3wtYCb162?=
 =?us-ascii?Q?a/YnCCmtLfDrLOjz5gRp3gJnd437KwkgXCtO6TPRodUt2GcEk+ovMO6tKVou?=
 =?us-ascii?Q?umUGAu3N+LDk9/bkKUHbgpgWdZTclPbSNJBIsVvM9f3FtA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oqlgNDH0gmtse6oTwG3IXda2Fks6SKyBInZGBxUqFGStI96DjWbhq2W0Kupx?=
 =?us-ascii?Q?TWvSyij9bU2ots6L4PAfEWTreAs2ly/RLhWORyh1gsFkmxIAmiw7os6o6cmC?=
 =?us-ascii?Q?K8YD2/bd6L+KEL8lp1D8v/S1vL6r0T+kVrn+kV6A24val2nlYZ2e0KmqM4Bm?=
 =?us-ascii?Q?Oc3ztnHln7zRHzQ/qqJBeh3F5/o2HuPgRA7bx15ycO0S8AnEN7mdLcLkQZDj?=
 =?us-ascii?Q?6n5ZJYjFM9OOVSxVVpXRXQ5UTjCcY2jFL67sRAOnwKr1GajEF3+EeUzLRBhR?=
 =?us-ascii?Q?wQka/UG5l9fCw0u4kGriT84zqz0J6/5Umv0LNRRMkXNYK3/N2QB8GOC9YZ3n?=
 =?us-ascii?Q?DT8Xks1HHoGbZ7Dq/ArWFEqpNEZOulp7HHSZ4JtfHrMGRxZAL9yRgz12XNiT?=
 =?us-ascii?Q?22A0WnrnjamJrOS5isrM4jKx50u1/aPHvGl2vGLbeDryXEom2aUoVTokUz8u?=
 =?us-ascii?Q?O40Z0yMxD4sxuv+h/p4YBw03w/2d3vP6XyaZ+5rXfXx7lJAQE/kI+hyn20hT?=
 =?us-ascii?Q?hv0loibIsd0QMKAxeKjZbrpyL58xuC5eOxARiOFjihnMzdMGFdEDb+mOinSJ?=
 =?us-ascii?Q?eu+6X5d3ijkVUG9fGtc5Nbe2lrykTSOwdKqk5nrruMq9cUv7d21n3PQkEzTR?=
 =?us-ascii?Q?FKAH7sF7eWX8au3rOFZt9WY3Znb5Y3g/VED6zfftI0968LNynDh2aLr7MyS3?=
 =?us-ascii?Q?FS7fJeacPgxaup0+7ClL3njJ1kWd0WdA0vLAGwkyUIAdFod1h6sb+Tc/tUvr?=
 =?us-ascii?Q?MuQ1trZqJrNad1y64owSLtn7t/2QEHgQc/xf/TqCuhbudOEFGY+RMHKkzN38?=
 =?us-ascii?Q?9j+Awg1JJ4LD/xjhw1Wqg8+VDqrp/mzMr2dENMAX5Yq6gPO+x3bLw562M7i4?=
 =?us-ascii?Q?t2G4iIdoZpAOUaG0HpwtDqTVuguZkofSuHP7VGZjZWJ8EEDQvuK5Lq0TP5Vq?=
 =?us-ascii?Q?yf2SwZqwtySMATVEWpHkxBofEHG19CbUt+Sg1ySoK5VjfDwyXPYsw1FoLE4l?=
 =?us-ascii?Q?VQlgYUltONPPZSU9nzkjdBUVK2Qgxr0mzU1LcfcN786kqSKnBHVBp/kf+/9A?=
 =?us-ascii?Q?o6Jx4iWvkkKN6pEOCAYb0SRRceYki8ujD3njeScca1dMS9YCX+k20xNZlQMi?=
 =?us-ascii?Q?FEEQXngvnKNhbop8D7IY4kioIMbdpG8ib0MJgAPQ2KN+MkAYXEnKql11skRT?=
 =?us-ascii?Q?QqL/Cc+en8UIMnBjIxgGfa6J40KDm0IC9qAXMkfA8lMVV1Z/P2cdso8jaUzi?=
 =?us-ascii?Q?Hkl/rOt1fBOOikShz0Z6jbNQAMrGdH4jIsI5G3+DuvB5EQjGe+CHhblzUeZE?=
 =?us-ascii?Q?DeKgFE7/Sg8DIvb7kUyPdisprVdiO6yoMX6Azd/v1OYCD30Ex6GmIyma6tUN?=
 =?us-ascii?Q?n+2PT6g5x7b3kJ2g9ICzW6bDLhuJh2OAz8wd2CJMtxiw0/zofVv5XDkJaLUf?=
 =?us-ascii?Q?42dBmGfPUTUZde4wtVQiryLYrQCMEzJFJe6NbxnouyCBpVd9Ip/0NrDlT8nZ?=
 =?us-ascii?Q?q/1EEIKk2mpUFlwDsljmREaw4jQnxk/M/Stij/5sOZ91eMrHsezlM8g8er3q?=
 =?us-ascii?Q?f1GjpvvWiszZNbczctQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ddef6787-fa3b-4967-74c1-08dce93c8929
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:02:18.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IWlZvo7uf6rCNIAQ6nCRr6BkdPe60iXV+G88TZX8Xc9KyCnoJ4WuBgcuf0NSyOq2sgGr31s8iZL0bSOrX0Eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6058

>> >> +static int smi240_regmap_spi_read(void *context, const void *reg_buf=
,
>> >> +				  size_t reg_size, void *val_buf,
>> >> +				  size_t val_size)
>> >> +{
>> >> +	int ret;
>> >> +	u32 request, response;
>> >> +	u16 *val =3D val_buf;
>> >> +	struct spi_device *spi =3D context;
>> >> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
>> >> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
>> >> +
>> >> +	if (reg_size !=3D 1 || val_size !=3D 2)
>> >> +		return -EINVAL;
>> >> +
>> >> +	request =3D FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
>> >> +	request |=3D FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data-
>> >>capture);
>> >> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
>> >> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT,
>> >> +SMI240_CRC_POLY);
>> >> +
>> >> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
>> >> +
>> >> +	/*
>> >> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
>> >> +	 * SPI protocol, where the slave interface responds to
>> >> +	 * the Master request in the next frame.
>> >> +	 * CS signal must toggle (> 700 ns) between the frames.
>> >> +	 */
>> >> +	ret =3D spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	ret =3D spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	response =3D be32_to_cpu(iio_priv_data->spi_buf);
>> >> +
>> >> +	if (!smi240_sensor_data_is_valid(response))
>> >> +		return -EIO;
>> >> +
>> >> +	*val =3D cpu_to_le16(FIELD_GET(SMI240_READ_DATA_MASK, response));
>> >So this is line sparse doesn't like which is reasonable given you are
>> >forcing an le16 value into a u16.
>> >Minimal fix is just to change type of val to __le16 *
>> >
>> >I still find the endian handling in here mess and am not convinced
>> >the complexity is strictly necessary or correct.
>> >
>> >I'd expect the requirements of reordering to be same in read and
>> >write directions (unless device is really crazy), so why do we need a
>> >conversion to le16 here but not one from le16 in the write?
>>
>> Hello Jonathan,
>>
>> yes, you are right. The "cpu_to_le16" is not required at all.  SMI240 do=
es not use
>the standard SPI protocol, on the other side the regmap is designed to use
>standard SPI protocol (by default) and may flip the register value depende=
nt on
>"val_format_endian".
>
>It should still need to place the two bytes of that 16 bit value in the co=
rrect order to send to hardware.  That may be handled via a 32 bit word len=
gth on SPI though.


This is the most confusing part.  During the request preparation, we focus =
on the bit order not the byte order. We need to bring the 16 bit value in t=
he correct bit order, to the correct bit position in the 32 bit request. Th=
is is automatically guarantied using FIELD_PREP. FIELD_PREP shifts the data=
 15-0 to request 18-3. We shall never manually change the byte order of the=
 16 bit value. The byte order (of the whole request) becomes important when=
 we send it over spi, which will be explained later.


>>When the both work together, it may lead to confusing.  Let me make it cl=
ear.
>>
>> In the SMI240, the register address is 8 bit and each register is 16 bit=
. We do not have any register value, which is bigger than 16 bit and need t=
o be stored in multiple registers.  Therefore the device does not need endi=
an. Neither big endian nor Little Endian.   To access the register, it is i=
mportant to prepare the request frame according to the specification.
>>
>> A request is 32 bit
>>
>> 	ID	ADR	W	CAP	*	WDATA	CRC
>> 	31-30	29-22	21	20	19	18-3		2-0
>>
>> ID: device id (if more than 1 device)
>> ADR: reg address
>> W: write/read
>> CAP: capture mode on/off
>> *: reserved
>> WDATA : reg value bit 15-0=20
>> CRC: check sum
>>
>> To prepare the request properly, the bit order is here critical. We need=
 to put each part in its bit position. The request is created as a local u3=
2, with help of FIELD_PREP, we put the value of each part to its bit positi=
on. FIELD_PREP will take care of the cpu endian and always put the value to=
 the correct bit position. Before we send the request via SPI, a cpu endian=
 to big endian conversion is required.
>
>So there are two possibilities here.  Either the byte order is just revers=
ed for the device in which case fine as you describe or perhaps the SPI tra=
nsfers should be using a 32 bit word?  You'd do that by overriding the bits=
_per_word in the individual SPI transfers.
>
>
>> Since the spi bus transfers data using big endian. When we get the respo=
nse from spi, the response is big endian and need to be converted in cpu en=
dian.  Any other manually endian conversion is not required.
>
>The SPI bus itself has no real concept of endian as such. It just sends bi=
ts in the order it is fed them.  The device may require a particular orderi=
ng of course if we assume it makes sense to break the transfers up into byt=
e size chnunks.


Yes, the device expect that the 32 bit request will be sent from MSBit to L=
SBit. Which means the ID shall be sent firstly, followed by ADR, W, CAP, *,=
 WDATA, CRC.  If we consider the 32 bit as 4 bytes , then the MSB need to s=
ent firstly, and followed by the LSBs. From this perspective we can say tha=
t the SMI240 SPI protocol requires big endian. On the host side the request=
 is a local u32 (4 bytes). To make sure that the MSB will be sent firstly w=
e need to convert the request to big endian before sending it over spi.

Best regards
Jianping Shen


>See if setting the word size to 32 bits solves your issues without the nee=
d for any endian conversions.
>
>Jonathan
>
>


