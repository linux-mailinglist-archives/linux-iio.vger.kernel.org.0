Return-Path: <linux-iio+bounces-22092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF873B13A45
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E570417C279
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16B263F36;
	Mon, 28 Jul 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="bonVeyM2"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78692522BA;
	Mon, 28 Jul 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704906; cv=fail; b=N23n+BEDsWqekVA3/P8qfekKOpEjLCeWzif6XKhBaLFtD2gCz0QxWv8ZjSn6VGE0dx1mQ4zw02eNGfurvR9K8mNiBQetojv6FUS+8kN/B99rnC5Pg249CkRLscA1snSWlLAb/7vJEI7UK5lFD7ri/6ZqgQ0j9xPCcTEde4H26Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704906; c=relaxed/simple;
	bh=62QWmrkZlukYhSWD5aWmBqQ6PfZ8Weo3wPxAOCdXqtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXWKsF+RFcEJl99/eztb5pWIbxPZtDa5e+OxqGz5eh2qxfUbWaBLzP3hHNSq9TdXK+xqb8WNdOMBYmfxrTeeGJ7CghjuIQIlT16sdxmr9rWw29/99s2Uq4ZKn1/ZHAmC69CdYCYvj50JxltTs/J49PowkQhwZWwZunC9sliyjRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=bonVeyM2; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyyG3X8U1mUNkP8hIgl5Z8FMcj+YgoHYtUOaFaZWTvZe3bEIih84VCgwXmPBx2Qz7KoTmIUKNn8FJ2b7qpjJ7tUaNDAN+3oBnNk7svL3pT1DA6E5iDnBibqyIBy4ExyAvGzMv2Nb0ftytnnFbX2YviNkuT6C3bk5oOcVayvVF80FbX1X0P5ll5PEFvEIksCSzkB7d0nrvjDeHAZhE36j1r3p0DxEW9O5IAzIWYOeWCD2kSNEeM8WCVWYrc+yzFVDzdH3GNVMXnsz9sjpd1PifGIEjHM9BznwngQaGfFBU/Hb1ApK2cQyW9zbZ3NKdOiK9rA1DYbHSoRVwiVJ0rQmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paNOZBCDqWc5RQckYxv+MEFf30yCt8AdpHWRzAc/k9M=;
 b=Wlcd4POTLEoRSUuqEN3GzNc65zrLDrxhhyo8mwAmK/Ap12WD4W+j79QLsQMBJ0kSQHS1oWeS2LniGbmK9WYhPPvjRG150M976AEUMcZ0WLS7zEZR6Z76DqqPD8a/FY7gul6dSmzriLXGQEXEtzTeMns2OOlSRk5ypZ7HfnbmUabl8ydrRMfDbxzlTAZo20sVSD/k9KT9NT6oMHOlD9Y972O6+p1TtGyikkfyHyKTQmCPpvdjkpaymtNK/46fOdkv4GF2PMx+9qE4Cyfsavbt1UAi+yWkSCFUaU9rCWppubvI4jy5RrC9A+F3JR8UtHtm6kT9io7Bl6QamV3D1LTPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paNOZBCDqWc5RQckYxv+MEFf30yCt8AdpHWRzAc/k9M=;
 b=bonVeyM2Wm10ilTgHK1elxiOBp0Md/rNsCPfz6vhmRVZrq3wRMLKJ09f/YTxOCOSWs2Ead9t4T53ZWh4+1jzpZDGrXct5ztN88D/Iu5tpmrs38vAnNASgWbyVYNaNmCuVLJj/umTUeVoF2NpgFpW6Kk2kKojrJio059KO0voaBnJdeEjgvtH31vzf7souC8/+W9/oXt6F4wieTPeFBc2/nGSETftbYxBTAx6NiTu7xwb0/UsWY1ZYLUVFI2E7BwaFAmxIYJW8mC7Pk51l7BpV3VjKOk4EMVUBw+ZUm17ZKaH/yEw7DXDETo6ZjlFvOMV/av4dmwJQDJW9rlEq2yTqw==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DB9PR10MB5883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:397::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:14:56 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c75f:604a:ce59:8114%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 12:14:55 +0000
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
Subject: AW: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Topic: [PATCH v3 2/2] iio: imu: smi330: Add driver
Thread-Index:
 AQHb7DCnxFfdguezA0CMBsJ2vkpDJrQlVJwAgATVpeCABfU/AIADa+ZQgALjsgCACRRNsIAB/bWAgAYWTeA=
Date: Mon, 28 Jul 2025 12:14:55 +0000
Message-ID:
 <AM8PR10MB472198ADD6F85F71D91DE1F1CD5AA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250713144214.6ee02f59@jic23-huawei>
	<AM8PR10MB4721BAD5BD78B8FD0F5C9798CD57A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20250717150440.5067862b@jic23-huawei>
	<AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20250724160759.44d67e88@jic23-huawei>
In-Reply-To: <20250724160759.44d67e88@jic23-huawei>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DB9PR10MB5883:EE_
x-ms-office365-filtering-correlation-id: e43b9b05-5491-4765-0f21-08ddcdd05d44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WQI7yHhLxWfzCNpj2aD9GyQG9hNroojigIzbmHANOOHNdw8O319vQfFHf4N0?=
 =?us-ascii?Q?oUBQbST+vu14MlzRITrDsOkGQQi4wthP3OZ1X7IitaPoVVy1vDaOyaVLw1Bu?=
 =?us-ascii?Q?eChXs6KK2psHwkGDM38WFDpm+CbpOTAVoh0VZzSeo0R+xWGyx1xacBgfyhZX?=
 =?us-ascii?Q?Md70xyYivRQsyIWnkgkc+VbdDBmPQNxxPecxDigGgujx8iLMgVa4vHnRdZ7S?=
 =?us-ascii?Q?GKmRIsvxiHsWWuZ798RmnfZ26X9wz4TSFtsYmf9jR1WTbwIBd7XfYfkKysyP?=
 =?us-ascii?Q?dPFz7g+igPRdC7IvB0ZHrEmsEUlfRDlTzKm9uJMT40ziQhSLQOu3XJ9iZtFz?=
 =?us-ascii?Q?EhWRQnm1JLZWG8bEkyFhJoL5Oj5Avqf8rrICDtTD0b1LuTzkREETRrtOUOmK?=
 =?us-ascii?Q?8cY6Oxwc0Xqon/JiTklr9cqnYPE8IJpeQrdizaz0SZitEZv9lCVpIj56QSTh?=
 =?us-ascii?Q?MiEAvahgO/9UuQkg8F+fdWdGC8Ql2IPwmc0UifmfDBm6HPVpbTET0QEzXHIx?=
 =?us-ascii?Q?8U9vkJaEgFwQ65KGeqRXq6Ard0/7IJgMooJAplCtX+3LzlqNgPmraYU8/82W?=
 =?us-ascii?Q?qlXPHub1/OTmbr7tgiBfJhLrdP8EYRNiIBe5Fvw1HuY8WZrVa8ffiivliYD5?=
 =?us-ascii?Q?QL6N0JqEUlPybH7TTKh5jLWrcLJtKxau0l+UAbWE7VC76MPtTpWiV4sFDBa1?=
 =?us-ascii?Q?+29vzIRHWY4W3bynmcZCGnF04aKEmU9M7otDfVsQggaOshtOF7lUmLoH0Pfe?=
 =?us-ascii?Q?+HF32HpP2R84nPFzplHchE9qyjNrDl5VQcuxps4Vg+YhmSRSfBxzb94ce1Fh?=
 =?us-ascii?Q?gHH7usjgSCDE5JrgKpk97RFn4oVyvFsr3mGtkqKTB4VrQGld0e3Vv5SuME/o?=
 =?us-ascii?Q?0Top3slWcKXS7FCI6i8B9F/cOJahVh8e9xNiOLs+EegisJgvqLCqI8gaSj7e?=
 =?us-ascii?Q?sqNKL4N0b/Qo0AuBeuRR0RFbQSZf0BFQ8U8MP8qeDMlfC80o1h6AFYPE0xUF?=
 =?us-ascii?Q?+rj+4sADp3Cf0V5wxTkM55f3hf9BZ0LZUL5Swh+YIJ/HJVa6f3UVVzppitDS?=
 =?us-ascii?Q?5xSljBoVpqCBd0VkRR3mSk7buE/HHPB3GDcgh5fedXEZwZEFITk3vavaGrIZ?=
 =?us-ascii?Q?vP7f269z4K/jxQjJ9+/9Lne1He5fEksSOUhdBEwstEo33cAwWzgyTCtBmfxZ?=
 =?us-ascii?Q?B4gzp6rbHcHxDjNHnZ5TbuvyH0Uym14cEcNZS6pFJvOVEe0M8tERYCe3IGri?=
 =?us-ascii?Q?kwnH8xG8nfNM1B8MkbTOrCb6UKhvhIS2qirp7uIXqyMCa+Z0gg1CUIhZ9HH1?=
 =?us-ascii?Q?EFmNIcWpyp/cP7cGJ+UHRrfpMS9u1qGxQCrlZrRs/zIpOAr4XOcM30LqBB6c?=
 =?us-ascii?Q?NfXFU/Qj4Fg1EwQSiDYtIIYUVtT5X2Y8SsVPZ90kQESkYbHsvJqs/malYwdk?=
 =?us-ascii?Q?ZsMWbwobiE0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B1niL0mNxmWRScSDXc0hl0OvxJG1GZifVPUU1lFlw4wfCG993OMH/Xs4hfR6?=
 =?us-ascii?Q?xBZ4rqCZddrPS5xOr0Ig2cIS4it5Uv6nsK0ePU1ion8txG7SF7UFHdOz8tLr?=
 =?us-ascii?Q?9FkU0j9J+3TZKV36lyCufQx+TCjlz7HeHHOyzs220ADkxOJ964qpGXk22EzC?=
 =?us-ascii?Q?6OFmYu1AtL6zcUY/ARep9mmULuZlQUijYhh35Sdsf1eZtc/VESgAYhD4OV1w?=
 =?us-ascii?Q?yCcF4OFyfDmJeJe5bUcXF3mn7KGpZbX5tWErCvoB0QxfSswdEX3GFNhnfWBO?=
 =?us-ascii?Q?yDpyeDJNNuVHxtnRrtsUrxU3wt27fw0c7uJ4hdLMwj/0JvizLTw24sj9DEi+?=
 =?us-ascii?Q?yQxjjMm7YiF1udvH+LOK4a85cF6deeZB+rUXU7w5SXe/4R1JXmzIpYHWoU+R?=
 =?us-ascii?Q?rEdZK1jc4xxOpAsCNSpL4sZP06PTEjXWdULe5Kw6agZS9uhQU6HBdN/Gl0WV?=
 =?us-ascii?Q?lnwR1XXxp5tCM0VHWLxjiAUqcuYqJyIgaK1QVXp7CHJUbU6IVSNIOWwzKxmL?=
 =?us-ascii?Q?pW9mFM2JjYjvEpH8Us5ye8fZis0gEWeVmnReG3V96e2A6v9wkufAjqGWOVzu?=
 =?us-ascii?Q?6rQP3VGkDUkGsw62FuYl55ofW8pvI+5bYD+zixOphOXXOCAWCzQhc7Q+Wz92?=
 =?us-ascii?Q?vmilDUGFt5GeINyoJyKINolIOOQ3YYewUDBZ838BWs7DGmL2fGF9VNhi+wv/?=
 =?us-ascii?Q?rOx/Fpf9fWz/11Knr00yKizAjCNxKyDU1Dex2HF3pln39Pi2bN8mFy50TXqZ?=
 =?us-ascii?Q?MHZlc9ZqQF8mcD0mVj2TVkyEzAaffEdL1TaLxslgyLounKMrjXjlUEOv+REl?=
 =?us-ascii?Q?aZwe7ppKd5EC0e772SwYD8JqBDbWXPj0L8j1BhIiuKEz8PuyAQF+j6jf3tyO?=
 =?us-ascii?Q?2HwJ+8LXyEQe+0Jy4e0K2OdSG32WBxDrq/eR5zgSLPwE2Mgga2ASpujWtr6W?=
 =?us-ascii?Q?KX4xsN2q6rVhswm8YbyOro4yrrnJRLqTYXINYxQ4S+IFGFKp2rMjcrMT97uw?=
 =?us-ascii?Q?6RLKEyeP9urjwJCwlLPsNOeqFRNALe0icdZ+6IbvCMdv/tSwlgU7xsyv6J8P?=
 =?us-ascii?Q?omURN+NoBRzLD4fnW1NHEwyp46JqcILF+Sh1zpHyKEKWVUZv9sXNPQcCIvpc?=
 =?us-ascii?Q?/fAy+OGx/4dK3XZ1niSijjPmzmbV1e0PzsAMLbgjTuJMDnqSsHJW9D6jERV3?=
 =?us-ascii?Q?x+u0v5x9BhQgIPaxC+jDykua/H6naGZrQVSU4v0DmfECbTNvAdOOgGsYWvPj?=
 =?us-ascii?Q?QBib95+gNnHa4f782zLxe2NXuC0oNiSMl+AGhXaG66MuZ/Tp1WYFFtJxE52L?=
 =?us-ascii?Q?kqLf66fhT5U8WvdMiPTa95cpBREnwdY8F7xQBNMVcyrdrPZze9ywHQTyi8/p?=
 =?us-ascii?Q?8wseh7iRivfY/0766aBl6YfkZSXqJh7fBMCHIyCbBeYY7KLvB0OUojrBCz83?=
 =?us-ascii?Q?ib5NiH3gz/ZwcwIfTiJwGUOX7G2grxJD4WM6ODvu8461n3g2rgyTMcgWV4VT?=
 =?us-ascii?Q?d8qxt3DikhcNn1Pb6r5efPlvFh7W5AzinBK4YyhBFAqjmeZiUBDNZlotFI7Y?=
 =?us-ascii?Q?C5cOi/0xw3wjhPe0rws=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b9b05-5491-4765-0f21-08ddcdd05d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 12:14:55.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKUM+j32TqFVwMMUDFLmlab7XhbeUD6nUt2wh/l4LzjbI73e+KYJ6Ih4yGukCD/Hz9tuF06WGYAKRdlHEgFUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5883


Hi Jonathan,

let's think about a typical IMU, which has 6 2-byte channels (acc x,y,z  gy=
ro x,y,z)=09

3 2-byte channel we want, 3 2-byte channels we don't a 4-byte gap and an 8-=
byte timestamp struct scan {
	u16 wanted[3];
	u16 notwanted[3];
	... gap...
	aligned_s64 timestamp;
=09
Hint: indio_dev->scan_bytes is 24, if we use available_scan_mask with all c=
hannels set (ref. https://elixir.bootlin.com/linux/v6.15.1/source/drivers/i=
io/industrialio-buffer.c#L975)

Cutting down to the parts that change in_loc only.

	for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
		in_ind =3D find_next_bit(indio_dev->active_scan_mask,
				       masklength, in_ind + 1);
		while (in_ind !=3D out_ind) {
... length is the length of current channel .. We never enter here in the e=
xample.
			/* Make sure we are aligned */
			in_loc =3D roundup(in_loc, length) + length;

			in_ind =3D find_next_bit(indio_dev->active_scan_mask,
					       masklength, in_ind + 1);
		}

... length is the length of the current channel.  Get here on first hit.

		in_loc =3D roundup(in_loc, length);

		in_loc +=3D length;
.. in loc =3D 2 + 2 + 2 =3D 6
	}
	/* Relies on scan_timestamp being last */
	if (buffer->scan_timestamp) {

... length is 8=20

		in_loc =3D roundup(in_loc, length);
.. in_loc =3D 8 (should be 16 to match timestamp offset: https://elixir.boo=
tlin.com/linux/v6.15.1/source/include/linux/iio/buffer.h#L37)
		ret =3D iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);

	}

Best Regards

Jianping Shen

>
>> Hi Jonathan,
>>
>> we find out the reason why the timestamp is invalid in the iio buffer.
>>
>> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felix
>> ir.bootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrial
>> io-
>buffer.c%23L1093&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cd
>84c
>>
>234178ee4bae6a2a08ddcac3e80a%7C0ae51e1907c84e4bbb6d648ee58410f
>4%7C0%7C
>>
>0%7C638889664948004786%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1
>hcGkiOnRydWU
>>
>sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3
>D%
>>
>7C0%7C%7C%7C&sdata=3DDAYIrdjPq4RrrvH7tudEjOlAavn%2B2qlpGiRp2UXTh2
>c%3D&re
>> served=3D0
>>
>> In "iio_buffer_update_demux" to copy the timestamp, the address calculat=
ion
>is the root causes.
>>
>> 1083  in_loc +=3D length;
>> ....
>> 1093  in_loc =3D roundup(in_loc, length);
>>
>> When finish to copy the channel data, in_loc is just incremented and use=
d as
>address of timestamp. This is correct only when the channel direct before
>timestamp is enabled.
>>
>> If there is a gap between the last enabled channel and timestamp, then i=
io
>core will copy the wrong data.
>>
>> We have a fix to this issue,
>>
>> 1093 in_loc =3D (indio_dev->scan_bytes / sizeof(int64_t) - 1) * length;
>
>That looks correct, but I'm not seeing why the roundup above doesn't land =
us
>in the same place.  I'm not that keen on handling the timestamp even more
>differently to other channels.
>
>
>If we imagine an active scan with
>2-byte chanel we want, 2 2-byte channels we don't a 2-byte gap and an 8-by=
te
>timestamp struct scan {
>	u16 wanted;
>	u16 notwanted[2];
>	... gap...
>	aligned_s64 timestamp;
>
>
>
>Cutting down to the parts that change in_loc only.
>
>	for_each_set_bit(out_ind, buffer->scan_mask, masklength) {
>		in_ind =3D find_next_bit(indio_dev->active_scan_mask,
>				       masklength, in_ind + 1);
>		while (in_ind !=3D out_ind) {
>... length is the length of current channel .. We never enter here in the =
example.
>			/* Make sure we are aligned */
>			in_loc =3D roundup(in_loc, length) + length;
>
>			in_ind =3D find_next_bit(indio_dev->active_scan_mask,
>					       masklength, in_ind + 1);
>		}
>
>... length is the length of the current channel.  Get here on first hit.
>
>		in_loc =3D roundup(in_loc, length);
>
>		in_loc +=3D length;
>.. in loc =3D 2
>	}
>	/* Relies on scan_timestamp being last */
>	if (buffer->scan_timestamp) {
>
>... length is 8 ...
>
>		in_loc =3D roundup(in_loc, length);
>.. I think in_lock =3D 8?
>		ret =3D iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
>
>	}
>
>Perhaps you can talk through the example that is failing?
>
>>
>> just not sure, if there will be any side-effects with this fix.
>>
>> Are you going to fix this finding, or shall we create a new patch for th=
at?
>
>Fine to send the proposed fix but first we need to step through why the cu=
rrent
>code isn't working.
>
>
>Thanks,
>
>Jonathan
>
>>
>> Best regards
>> Jianping Shen
>>
>>
>> >>
>> >> >>
>> >> >> >> +
>> >> >> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
>> >> >> >> +      struct iio_poll_func *pf =3D p;
>> >> >> >> +      struct iio_dev *indio_dev =3D pf->indio_dev;
>> >> >> >> +      struct smi330_data *data =3D iio_priv(indio_dev);
>> >> >> >> +      int ret, chan;
>> >> >> >> +      int i =3D 0;
>> >> >> >> +
>> >> >> >> +      ret =3D regmap_bulk_read(data->regmap,
>> >SMI330_ACCEL_X_REG, data-
>> >> >> >>buf,
>> >> >> >> +                             ARRAY_SIZE(smi330_channels));
>> >> >> >> +      if (ret)
>> >> >> >> +              goto out;
>> >> >> >> +
>> >> >> >> +      if (*indio_dev->active_scan_mask !=3D
>> >> >> >> + SMI330_ALL_CHAN_MSK)
>> >{
>> >> >> >> +              iio_for_each_active_channel(indio_dev, chan)
>> >> >> >> +                      data->buf[i++] =3D data->buf[chan];
>> >> >> >
>> >> >> >If I follow this correctly you are reading all the channels and
>> >> >> >just copying out the ones you want.  Just let the IIO core do
>> >> >> >that for you by setting iio_dev-
>> >> >> >>available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 }; and push
>> >> >> >>the whole
>> >> >> >buffer every time.
>> >> >>
>> >> >> For the most frequent use cases, we define available_scan_masks
>> >> >> =3D {
>> >> >SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK,
>> >SMI330_GYRO_XYZ_MSK,
>> >> >0 }; and push the whole buffer every time.
>> >> >> From the user space we just enable 3 channels gyro_x, gyro_y, and
>gyro_z.
>> >> >Then we enable buffer and expect that only the gyro values and
>> >> >timestamp in iio_buffer. Nevertheless, we have 3 accelerometer
>> >> >values and the timestamp in iio_buffer.
>> >> >
>> >> >> It seems that the iio core does not take care which channel is
>> >> >> enabled,  just
>> >> >copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver
>> >> >code still needs to take care and just copy the enabled channel valu=
e to
>buffer.
>> >> >
>> >> >Look again at how it works.  If you provide ACC_XYZ_MSK, then your
>> >> >driver has to handle it.
>> >> >available_scan_masks is saying what your driver supports. The
>> >> >driver can check active_scan_mask to find out what is enabled.  So
>> >> >right option here is only { SMI330_ALL_CHAN_MSK, 0, }  In that
>> >> >case the driver never needs to check as there is only one option.
>> >> >
>> >> >Then if any subset of channels is enabled the IIO core copy out
>> >> >just the data that is relevant.
>> >> >
>> >> >
>> >> >>
>> >> >> Another side effect after using available_scan_masks is that the
>> >> >active_scan_masks sometimes does not reflect current channel
>> >> >activation status.
>> >> >>
>> >> >> Is some step missing to properly use available_scan_masks ?  How
>> >> >> can a user
>> >> >find out from user space which channel combination is defined in
>> >> >available_scan_masks ?
>> >> >
>> >> >Why would userspace want to?  Userspace requested a subset of
>> >> >channels and it gets that subset.  So it if asks for the channels
>> >> >that make up SMI330_ACC_XYZ_MSK, if available_scan_mask =3D=3D {
>> >> >SMI330_ALL_CHAN_MSK,
>> >> >0 } then the IIO core handling selects SMI330_ALL_CHAN_MSK
>> >> >(smallest available mask that is superset of what we asked for)
>> >> >and sets active_scan_mask to that.  The driver follows what
>> >> >active_scan_mask specifies and passes all channel data via the
>> >> >iio_push_to_buffers*() call. The demux in the IIO core than takes
>> >> >that 'scan' and repacks it so that userspace receives just the
>> >> >data it asked for formatting exactly as the driver would have done
>> >> >it if you had handled each channels
>> >separately in the driver.
>> >> >
>> >>
>> >> Set available_scan_masks =3D {  SMI330_ALL_CHAN_MSK, 0 } and push the
>> >>whole buffer. iio_push_to_buffers_with_timestamp (indio_dev,
>> >>data->buf, pf- timestamp); We enable the accX, accY, and accZ from
>> >>userspace. And expect 3
>> >acc values and the timestamp in iio buffer.
>> >>
>> >> Raw iio buffer data:
>> >> 00000000: 3c00 d6ff 7510 0000 6100 f3ff 0000 0000  <...u...a.......
>> >            ACCX ACCY ACCZ PAD_ TIMESTAMP__________
>> >                               4093587712
>> >> 00000010: 3f00 d2ff 8910 0000 0300 f6ff 0000 0000  ?...............
>> >                               4143907584
>> >> 00000020: 4900 dcff 7a10 0000 caff 0100 0000 0000  I...z...........
>> >                               So this one looks bad.
>> >
>> >> 00000030: 4c00 d9ff 7910 0000 2f00 f8ff 0000 0000  L...y.../.......
>> >                               4177473280
>> >
>> >> 00000040: 4b00 d9ff 8410 0000 1f00 0800 0000 0000  K...............
>> >                               also bad.
>> >> 00000050: 4700 daff 7f10 0000 3b00 eeff 0000 0000  G.......;.......
>> >> 00000060: 3f00 d8ff 8410 0000 0c00 0900 0000 0000  ?...............
>> >> 00000070: 4600 d9ff 8010 0000 0e00 0800 0000 0000  F...............
>> >> 00000080: 4700 d7ff 7d10 0000 3400 feff 0000 0000  G...}...4.......
>> >> 00000090: 4b00 d4ff 8010 0000 3e00 1200 0000 0000  K.......>.......
>> >> 000000a0: 4600 d6ff 8d10 0000 4300 0000 0000 0000  F.......C.......
>> >> 000000b0: 4900 d6ff 7710 0000 2500 f0ff 0000 0000  I...w...%.......
>> >>
>> >> Converted value
>> >I guess this is different data as doesn't seem to line up with the abov=
e?
>> >
>> >> 0.015625 -0.009277 1.024411 589929
>> >> 0.015869 -0.009521 1.040769 4294901719
>> >> 0.020508 -0.008301 1.025632 458712
>> >> 0.018799 -0.006836 1.032956 851960
>> >> 0.019287 -0.009521 1.033201 4294836275
>> >> 0.015625 -0.010498 1.031003 4293328982
>> >> 0.015137 -0.010498 1.031980 4293853176
>> >> 0.015869 -0.009521 1.031492 4293722141
>> >> 0.018555 -0.011475 1.033445 4294311886
>> >>
>> >> The 3 acc values is correct in buffer.  Nevertheless, invalid
>> >> timestamp. The
>> >timestamp is actually the value of the gyroscope, which directly
>> >followed by acc values.
>> >> If we enable the gyroX, gyroY, and gyroZ from userspace, then all
>> >> the data is
>> >correct. Since the gyro values are the last 3 values and flowed by time=
stamp.
>> >
>> >Ok. That's odd and we should debug that.  This code is used in a lot
>> >of drivers so if it is not working correctly we need to figure out why =
asap and
>fix it.
>> >
>>
>>
>>
>>
>> >However, I'm not seeing what looks to be gyro data in bytes 8-15 etc
>> >It isn't the stable sequence we'd expect for a timestamp though some
>> >specific values might be plausible.
>> >
>> >Looking again at the code, the IIO_DECLARE_BUFFER_WITH_TS() is the
>> >wrong size.  That should not include channel space for the timestamp.
>> >That should make it too big though which shouldn't be a problem.
>> >Also wrong type - should be using __le16 not s16 for the buffer
>> >elements given your channel declarations.
>> >
>> >Please could you add a print to your code alongside the
>> >iio_push_buffer_with_timestamp() to verify that the value in the pf-
>> >>timestamp is reasonable looking for a timestamp.
>> >
>> >For reference this is the code that handles the timestamp entry
>> >creation in the demux tables.
>> >https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli
>>
>>xir.b%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cd84c2341
>78ee4b
>>
>>ae6a2a08ddcac3e80a%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C
>0%7C63888
>>
>>9664948038159%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
>dWUsIlYiOiI
>>
>>wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7
>C0%7C%
>>
>>7C%7C&sdata=3D7kNAXwi9fkp5XocdJ2K5W2Cp9%2BQW4Wq6GLr5reGqies%3
>D&reserved
>> >=3D0
>>
>>ootlin.com%2Flinux%2Fv6.15.1%2Fsource%2Fdrivers%2Fiio%2Findustrialio-
>>
>>buffer.c%23L1086&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cf
>0
>>
>>9eaf03f8e44dd1e6fe08ddc53ae596%7C0ae51e1907c84e4bbb6d648ee584
>1
>>
>>0f4%7C0%7C0%7C638883578931715207%7CUnknown%7CTWFpbGZsb3d
>8
>>
>>eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
>j
>>
>>oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Ds53tTw6o%2F2gu
>A
>> >iH3J9jBRd0%2Bj6UmcmgyhtBCuKK1HE0%3D&reserved=3D0
>> >
>> >Jonathan
>> >
>> >
>> >>
>> >> Conclusion: Setting available_scan_masks =3D {  SMI330_ALL_CHAN_MSK,
>> >> 0 },
>> >the iio core is able to correct handle the enabled channel data, but
>> >not the timestamp.
>> >> The working solution for now is that our driver takes care and just
>> >> copys the
>> >enabled channel value to buffer without using available_scan_masks.
>> >>
>> >> >So the aim is that userspace never knows anything about this.
>> >> >Just set what channels you want and get that data.
>> >> >
>> >> >Jonathan
>> >> >
>> >> >
>> >> >>
>> >> >> >
>> >> >> >The handling the core code is reasonably sophisticated and will
>> >> >> >use bulk copying where appropriate.
>> >> >> >
>> >> >> >If there is a strong reason to not use that, add a comment here
>> >> >> >so we don't have anyone 'fix' this code in future.
>> >> >> >
>> >> >> >> +      }
>> >> >> >> +
>> >> >> >> +      iio_push_to_buffers_with_timestamp(indio_dev,
>> >> >> >> + data->buf,
>> >> >> >> +pf->timestamp);
>> >> >> >> +
>> >> >> >> +out:
>> >> >> >> +      iio_trigger_notify_done(indio_dev->trig);
>> >> >> >> +
>> >> >> >> +      return IRQ_HANDLED;
>> >> >> >> +}
>> >> >>
>> >>
>>
>>


