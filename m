Return-Path: <linux-iio+bounces-27898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE3D38D85
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 036623015AA7
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AA31A04D;
	Sat, 17 Jan 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pL7TyZe8"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10329BDBF;
	Sat, 17 Jan 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643810; cv=fail; b=cUYJf8UJ7+tcXyy2debtjyqYEXdII+2w8PqMKJFuxb2Zt/t+XJoSKq8EAlWobyjrKeO1//hwo9sBcaE4v6YHRjLe5b5AEDqWZ7EXjl0/RPB09Bzx3gLY67zHT5P9sZbtX3KNwlQrMOZkfS3ghwTmXZNqcFPjTrwJVgI1be+Cmlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643810; c=relaxed/simple;
	bh=sXCTcDs9sqxIbpJbMoFiwZXCwvA4BzRaMjHPvChRChI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XipSR7zbk37jBAIckz2e1BFOYuY8z4O3TzzHLyisheUub2hPNuZePGkUaD2QThPRveXlPObNdDVqO6zuCOBFgOq3I3blDlW9ZC9Mwg7s4w90xwuBT/3PildgKOLTiGi3Wep0pNKhi1itCdphsIU6GiW0LlcreHfxHqsZuUkLTxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pL7TyZe8; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPlWjm27yW/ZByBZIDYOAogBQS2VvhsuM9mulrQmqM56naiq9q2wkb0YlMeg1gwC/p/CPCo3lruD90u3qLrazbNfB9VyeQWqD9y+ddeaiU4R94VHB7IQoxMJ3ML3p15vE4RAgxHPH05cyCK2IpEw5VPocmuTgKxyaHlA+TgLc7YVWeZVqeQzzV4IZR9hpIKX8+6XtmVYYxfr4It/lixTI1cZ4rNlBJhBpQspjPq/w771fab/vnAYZinPdiF56UGPlJdzJPl6KNeDY4bvo6vEzTxeWqGKcYda8dLhxCpqO8KUuQJeTPZ6A6oIKu48Y+dorOY59upbgvB4V/9a9w5GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UBm8N7HVpUtS1RUJnFK3ajlM7U/drQSQt0Tv3zGesM=;
 b=OpsxdTBpjwg1dZiHHqQjqCfDUVRTlUPkZA/IGhZxO366wenbRt5CzhKviT8481f/7vqr4ye3SVxmluIyyCYa2pWefu7ZsZEJBrwHNA/N82QjIOkfYX7mEZIKEE4wLu6Y1xzDPHb+1cQEcfG3kipBKFPNQxmJxmPvsnnR9WFppJ/M5qxi0ANYET7OCsKMwWOv/Wf0g3exX4QgKj8TN6kzj3/zCzz8alrTksDOe5sJyTpnvbv834GjiA3fe557ZF5oiicfCKBb+OvspAQ2yy/nuzQxUvbVLfDp/St+XiCjTVP22C6EfK5l08W5gJg3WTmrXjnSDI2CCmOoETJIpFCd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UBm8N7HVpUtS1RUJnFK3ajlM7U/drQSQt0Tv3zGesM=;
 b=pL7TyZe8RH+LARg8B8MnZ2WSqqqgkcpWT2osPtNq6av36gMEEOJ84DKLJZwDEu1Vp55K0wscctz1+PewTR2NgVOP6OmPQEu1+x9wC9ymxnZow2M/5n0VhtnxlS9pisjogShjmmZlksyzCIYvxUY8qwofcK0SHp2xJXONs0O8Bh4j/DQQOB4roZ/c0O4oCKz2BFNNCyp2PftDkewMYO7zdYH41GwTXdcqeAkzUDOwU/u5e+Y2hUm4HtPZNpaS52cRaUXYTMJ3gNhMcY+cqpH7NT2PXFEl/JApIuRGHZzvLyBI0/uj1QRnX9OhG8e+WPK4v4/MDZ9AUoLLc1Lq+AF2nQ==
Received: from DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cd::18)
 by DB8PR10MB3847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sat, 17 Jan
 2026 09:56:43 +0000
Received: from DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc30:f38a:9957:db0e]) by DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc30:f38a:9957:db0e%5]) with mapi id 15.20.9520.005; Sat, 17 Jan 2026
 09:56:43 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v7] iio: imu: smi330: Convert to common field_{get,prep}()
 helpers
Thread-Topic: [PATCH v7] iio: imu: smi330: Convert to common
 field_{get,prep}() helpers
Thread-Index: AQHchiqoJSXq7OSL1UuxNSECKsqKVLVWH3+A
Date: Sat, 17 Jan 2026 09:56:43 +0000
Message-ID:
 <DB9PR10MB502041D68C1301A227B40CD7CD8AA@DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM>
References:
 <275b806d25a57cb538b3db2a7490e1570175f6a1.1768486991.git.geert+renesas@glider.be>
In-Reply-To:
 <275b806d25a57cb538b3db2a7490e1570175f6a1.1768486991.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5020:EE_|DB8PR10MB3847:EE_
x-ms-office365-filtering-correlation-id: 99b5e1ac-e30f-45bc-db28-08de55aeb7fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kWfRFbqA0q0RW0fQTV/zuxPe8ODb+IwyWnrx0GQvRlhtsnHnfmOaitsefC?=
 =?iso-8859-1?Q?9nt4wIh4wLzL86lFzTNqao3DppgG2M3urmN/WQ+HC/ar9tY/zKlsp/0uq1?=
 =?iso-8859-1?Q?3+aSI1A69Pu/gNROSkD1efwyVCTqWFDh6fZSXtVVpmPlUu5hv1jmzjK9CQ?=
 =?iso-8859-1?Q?j2+477/ztbREpWM0uLBO3XOVgIN/wcrFjL0In6dq8mAV0GakoCegsVwi/i?=
 =?iso-8859-1?Q?+ZITdVR8exikFVCsViyiUNgwVFUwzZsTCnSbguekHvUKH9E9KZJ5TxBa1I?=
 =?iso-8859-1?Q?TogxSKN7ShqyYlrDorCEADb44pRWOaE1GN8cliXbtDQlz730s622mf2WHM?=
 =?iso-8859-1?Q?d0cETWHeTnS4cEbg8n3DZyEMiC0TZEj8A4aOpMyqubyG6aPWSUFeP3Ih3z?=
 =?iso-8859-1?Q?55l8aYaTKo+Cwm3ig2sgLVazZdGgxM0KNM1VkZbx01sqjfg34IFJKByhG3?=
 =?iso-8859-1?Q?GlTfCwK5WGwLUuge4waUW7tGOYeQWrHGLCG7c4MQNj8E5+u49Bl2sZEeyB?=
 =?iso-8859-1?Q?ubt1Tv9UZYzt+Yt6uDBwV7M+8j7rdP/cg4+gK1g/AmkXcBhdd1YS2eOJxX?=
 =?iso-8859-1?Q?P+ltY4yQhb7raanC0fQHo18g9ayHb4h+DE9GJ38bUnjRc8you6OtI3BSRg?=
 =?iso-8859-1?Q?e7XEdoM8JCLwHhVLcpwWGogdZB3PtLIHqFIMClRNxBezFDFvfck9IcVPSK?=
 =?iso-8859-1?Q?ZW/T0RLpEHDNXf/KGAA0afk5zoh0P7WuMfCdpD3h28P0hrGLB6v8Z6nE3i?=
 =?iso-8859-1?Q?Qouccf+i/1a3unR59qDH6ahdZOGI9aAWcp/FZCJFuIHrXu1TS5hUFi6I3j?=
 =?iso-8859-1?Q?H1Blw4aJEbpY4REJo5QAMWcLNr56wWZXHhG108LZpdIMdCGenf84gMaP2c?=
 =?iso-8859-1?Q?N1RMverC+ZUWbjcu65nkSWP2b36Hdgu4YftTbBV9ZAfR6KGUsqHC3/OzgV?=
 =?iso-8859-1?Q?8aTTFQmQv0TA5DWwM403M8f4nDA65zlxiaiL+GeCJuaLq48CFcCbnvdjBn?=
 =?iso-8859-1?Q?UTgwxPS7sQM83bfDpRnunwF4956l2F5mFjAo3Hn2/GLyrQbILXDuCKMhyO?=
 =?iso-8859-1?Q?0wnkYmXKWCTBaKSveFWwbQ5IEMh1/3rRn2IfaYNXlaI1aOBqFpLV0C1MYN?=
 =?iso-8859-1?Q?5QI6Vz0uw/TJWbOvRy42TPDTpgdzy8j6ILNJfBI/5Ppxh/9LesWyDXAcbJ?=
 =?iso-8859-1?Q?KZYlCSp0bTiBx1bi1RrfGOHJuVZzlwtP37qwOl4sQHQDt4l/6+an2b3ClZ?=
 =?iso-8859-1?Q?qsmfLPQV2GeplzQrj6tGKy1DBeRHPtfxZ2m2Gc/sidYi+qUT915XS4xto0?=
 =?iso-8859-1?Q?QI9URmf/vVIx1tgZnYBmbNBtMAo7sMw0+gffsCjJ8J4/E/eFH8hM0pN1Tr?=
 =?iso-8859-1?Q?4kTOQ/WACPW3ZhaArCv6qYq9bxwulwO/eeR3m+cFToPIrtEHm5bBdOhBzd?=
 =?iso-8859-1?Q?cP0VB+yGz1R7AlcBOnl7IfRS6uzbuTTXBhijVPUF+2K/1YDvms3qZDzpxL?=
 =?iso-8859-1?Q?FEmSqTFpudcvLaJl3qMJBTHxQpPpt95rZlpmVobDzXiPsGrHS8ZjNKWtaS?=
 =?iso-8859-1?Q?HiaZlXl2p1BzavVsVOrYsaPOCVg8UVwLR04rhFfXPQO0J7Ir9P6xhTLGu5?=
 =?iso-8859-1?Q?PI4LnbzyLiqpa4ivfV1oYw44Gm445x99Ng51j2EL3mOf2GuA51MDD6JCXf?=
 =?iso-8859-1?Q?B8McPTzUnbUpsm1KDDI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7/JeAIYmaSEk/08JEJ35Pc/juaUhuKt3evjA/t+Lieb9ERh0QcFeCv27cA?=
 =?iso-8859-1?Q?pbamcETiDhWFPo2mvyp8RiZLwSrf0VMXiT3piIGBHQGL9u1hmOh6QCQRTd?=
 =?iso-8859-1?Q?Ov4q0GQ0SAoNJsbFk7LLGhyFfpSsIz+CoChhS8cqBp+klSOmcN5JDhdXIC?=
 =?iso-8859-1?Q?4GUVNgywt9yHW+fmZtnPWxiHj+yf6GrFRrAtN6HI3a8omyudYoTK65VucA?=
 =?iso-8859-1?Q?HVrjQlC7C6Zrwtek6fy/+GKHCSbByDM73Zm9vqw0Um2a3b/AQ/9csTSapb?=
 =?iso-8859-1?Q?mXIBy+ZcLcOtq21hkGIW9QHHBIVWAWZXPBsp/9XOpYFNMua+50PZ38TOyX?=
 =?iso-8859-1?Q?cTX+0LWeIhs31ujt1JB5JvdtyIR3H3aw9eGPq5OctZP+xXy86hSPIQLNOA?=
 =?iso-8859-1?Q?7IJvY3u0ekTaR4fKiMlJzhZxTUtS//tkkvPpcoHRTtKyX27UdbiKTlXtZK?=
 =?iso-8859-1?Q?/WjDvCk3f5UJ9JUbJcq53+9GMsY2t9ufRQZcf30ppnPG5lkGQeDc+BO/oB?=
 =?iso-8859-1?Q?aRP1mLD03uLtUfaZOGTfLtFkS8PPl72SBehV142oQ6wIzH+LAiWN99thLs?=
 =?iso-8859-1?Q?6/wTywVBvhu6hFCGCkS5yPBxXCU4Hm40SgHPTUEMm4f0Dgjs1PUzTuIZ6q?=
 =?iso-8859-1?Q?vbe7crS5XrYNbhM6l9zO0QTexTo4ScZ11cnuUdZoDQKWZZDoG7ASjQG0bz?=
 =?iso-8859-1?Q?EYX1tdPPy4XonMT4QO3VLVtYQFQ7WyOSHFKtDAzN/GTXcWXioyWTLURQU6?=
 =?iso-8859-1?Q?zZsWq4U6/B9/f3XOWfC8UF9AU/SrVMFhgHx+D2m+1+6WbjFxyrQy0EFJ2q?=
 =?iso-8859-1?Q?HzgjAVJfLQ1i1bx/zABqhwnEkBTnrC/htS8L0u4qdlVhBxGYA8VszbU3R0?=
 =?iso-8859-1?Q?L+m8sozQ1P0WQcNDIaTRd0/nRsLZP4ZGBdLpesb+TwoRtq1lK+/aU/SCRH?=
 =?iso-8859-1?Q?KHVEXJ8bVeY71+aU52ZbFY6rkosKrKPTL3xR2pQDNIN5K36x/QzcBST4Dg?=
 =?iso-8859-1?Q?uUgb4YXnIsIaw8Tgw6AthlQ6JiyCRYodlRdIMnozbQGRaYnlND2QZZyDwi?=
 =?iso-8859-1?Q?Km/KhZ/Bwiz7xzHJbKUhRjGTJPNMWzV6DwQc/p4w/fwBuMsBx2CkmPNY6A?=
 =?iso-8859-1?Q?5hZ9pC3EeSdFUbU5wmmMhguJe2iBGjj6eOqLChOyL5Nu2FXcOPS0k6rkYD?=
 =?iso-8859-1?Q?F0H0uvI0yqXGvYNLLbFnKbr1KXieECU5CcNp2WKXb7Ia96YIERhfvmM9Pc?=
 =?iso-8859-1?Q?HX1rpdtBth8Ki/rUgfl5NCJJIPcaEMNC188vq8rBqC9RELTDsqTQiC/30x?=
 =?iso-8859-1?Q?x39PVj28aAwuvStP5NBgceorKIp7kcdWKsLUWD+3oYVl4H1MTDjcmX24o3?=
 =?iso-8859-1?Q?bfXbJD94HAvbvc0UII+S8a4l60ztB+XN9V2TQdE3rnaNR2hp4d5+Ah4f5u?=
 =?iso-8859-1?Q?4KqNmdsVRJRiQ3L1HwAU7J3lcWCGL1YaiSg4ibYMtqZE4rJ6PhpAYLwqSa?=
 =?iso-8859-1?Q?QJyLCuVCs/l1CYcL3DDil4YzwGoci0g+Yo+YSkjsdKvdb+2MLolE/9PK12?=
 =?iso-8859-1?Q?aZzLOQYWrcYCUUBUXigJDVQ7HO8JrqaHNZpItm+oh7E+zcp6fUN1OVfjhL?=
 =?iso-8859-1?Q?8EDjZRPoLj6cM5ZMGhKwOUwb8XgnSVLh/YLbNTR891TOsz9iXGxIx6dgeu?=
 =?iso-8859-1?Q?g/lUjIFUFLo2Gr0jFjdukK5JOrCT6OTwEpt7yUxb5PgEWvUBXDy+FlnUuu?=
 =?iso-8859-1?Q?MHCoZxhxJYy+xOh0chbPuGa55V4VrHPbR01s3oZSa72cb5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b5e1ac-e30f-45bc-db28-08de55aeb7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2026 09:56:43.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EB9kVTiyCCU3/214/2PYjCCRpUhRtgsfu1UMzzcuTfWJ06Dcj1kRPDozcWDxfAfF+dQ8HpL8G9gT7zJQqYedyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3847


>Betreff: [PATCH v7] iio: imu: smi330: Convert to common field_{get,prep}()=
 helpers
>
>Drop the driver-specific smi330_field_get() and smi330_field_prep() macros=
, in
>favor of the globally available variants from <linux/bitfield.h>.
>
>Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>---
>v7:
>  - Update for the renamed smi330_field_{get,prep}() helpers,
>
>v6:
>  - No changes,
>
>v5:
>  - New.
>---
> drivers/iio/imu/smi330/smi330_core.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/iio/imu/smi330/smi330_core.c
>b/drivers/iio/imu/smi330/smi330_core.c
>index 7564f12543e0ca04..83e0dff5d973d046 100644
>--- a/drivers/iio/imu/smi330/smi330_core.c
>+++ b/drivers/iio/imu/smi330/smi330_core.c
>@@ -67,10 +67,6 @@
> #define SMI330_CHIP_ID 0x42
> #define SMI330_SOFT_RESET_DELAY 2000
>
>-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */ -#define
>smi330_field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1)) -#d=
efine
>smi330_field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>-
> #define SMI330_ACCEL_CHANNEL(_axis) {					\
> 	.type =3D IIO_ACCEL,						\
> 	.modified =3D 1,							\
>@@ -361,7 +357,7 @@ static int smi330_get_sensor_config(struct smi330_data
>*data,
> 	if (ret)
> 		return ret;
>
>-	reg_val =3D smi330_field_get(attr->mask, reg_val);
>+	reg_val =3D field_get(attr->mask, reg_val);
>
> 	if (attr->type =3D=3D IIO_VAL_INT) {
> 		for (i =3D 0; i < attr->len; i++) {
>@@ -410,7 +406,7 @@ static int smi330_set_sensor_config(struct smi330_data
>*data,
> 	if (ret)
> 		return ret;
>
>-	reg_val =3D smi330_field_prep(attr->mask, reg_val);
>+	reg_val =3D field_prep(attr->mask, reg_val);
> 	ret =3D regmap_update_bits(data->regmap, reg, attr->mask, reg_val);
> 	if (ret)
> 		return ret;
>--
>2.43.0

Hi Geert

Thanks for using the standard kernel implementation.
Reviewed-by: Jianping Shen <Jianping.Shen@de.bosch.com>



