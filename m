Return-Path: <linux-iio+bounces-5008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4C8C4353
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7999B1F21A0E
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1E17F8;
	Mon, 13 May 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="HjlWpRHw";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="HjlWpRHw"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021011.outbound.protection.outlook.com [52.101.186.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7AEC0;
	Mon, 13 May 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610953; cv=fail; b=nVwOrXLJFFZbAGXGEOPDOkC8PjO+baXoZT6nppMOdu3x5dlxOgSHSuU9j7Or4BIleM/AUt7eKU8EU4awnHOC7rHUJe1/dzoizvYOLEHPN+KJ+hYGnpLU5GGPoY2rEAwxD5BWpU1wpKx6+/MfsoL3kovONoZ/rlVEgN3GA4oENSw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610953; c=relaxed/simple;
	bh=By439guJC7dQuCwOZew8tDlYCZ73ZSjsO6c4TD0lTwE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=scOWk52AkPg24/NDFBiij1kXeSYOZgirBgNCpyAouzLYqfcE/AST/6bi8BoyqxoJj837cdMGs4rfLw3N06t6QicbnnVpYrsutEMZOB459gEEzIIVgIFllFI+VbXusOI89wQlHKncRgjzcunUa6IuFj1omxB/GrqkB2CqzKDCFF8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=HjlWpRHw; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=HjlWpRHw; arc=fail smtp.client-ip=52.101.186.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bplyfaFbDjv3VrbSzsbKDY1o8wCDgJ1lRffydy8IGdu8QgWS3yhjgWg8hsl3yBSdraq4TncaJTGM1YpEjRUMt3XF9z5T2znCE3+aPBkJUDlxS33d0rVOHFl2WP/CYwd9I0NgSvJ0QPRHrK5B/lBkuldBI29xNSwo+c8iNhS7+N4RsXNinBLhGFDcalP+QGbIa6pUXMbpM1TCzaOb+8dALGApB3PcFa0zUsNGqNsW2VBMPIETn+GbUZ8tpnp1rzBtuo+fK/9BvejFzN1wMEkQnBL4tpGzv3isT7v1sqr/OYBkN2AdvyM7EIetZW8+KqzY7PhKk46/X71kVwqoQzl7oA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkZkxroNjQwdD0jOoYRSSetuXU2oM7ZV7oZ/pQv/Zh4=;
 b=XUty+plYHRCxCItrBHXG33pBIrLmPm3kWY8QKcRmKDP0dKLVVsRc/vuu3XNSGIh2JMuj7AgZkTRGgFeWI0/C4hlT3MY2PUDrLbYHqj8ZrkqBOE1GrSxd69LKSNk4Jz1UR/mBALVjOFtJTZXAK88dEjW4aRGHO5/iYKOoQGS0xe9tqTjtirhXNUl9O31WWxOVE0PgpSHm2NPk03JaN1ZX2k66ufjBsf/ZpmNRlhH1QFQ7Q/YnuwhmyLP3X4jxhEpEF78tu7W7fb59sb+vcxcxgm01ZGaaz0oKLcrptxYLpD+s9VGLSGdzIvyjddVGkjgTxT04jU9xatZDJvZP5viR/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkZkxroNjQwdD0jOoYRSSetuXU2oM7ZV7oZ/pQv/Zh4=;
 b=HjlWpRHwt5rVSlmLFPLD1KEP/llF/HOX7mwjcrKZgHHWZt83INP9N4nuvEjJSsVf53N779KrdR8lWWfCgiGPArgDYxZMrg3wWNQVK/92HH/eLuy4Lrn3tNSVqsRz4BapYkylnMaDYUcoXxF1J1d7LbfKnnGWsZl3DpRKs1aT3qA=
Received: from DB9PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:1da::24)
 by ZRAP278MB0948.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:35:48 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::69) by DB9PR05CA0019.outlook.office365.com
 (2603:10a6:10:1da::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 14:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 13.74.137.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.74.137.176; helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 14:35:47 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.8) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 13 May 2024 14:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig7ncGPQnEYLTeISLZwJipbqzPPFJ8s2zW+XbhyykGwwPu9e7RSGUNv/6bv8yBINo7YC/y4QL9xpR7yeYp1476R05HZuCqH7Dyg85AFSckwnT683VHCdMh5OhddfRXnx4ei8QsxuTuW8Ncea7ft17XTzWy+zHbBpaOFTyIe76kCLNAQMLT1dpfZQdK9/EH8pEYUutQZRYAGSt7ytjXVF3iDSwrDXbimwEHwU+jBiLYsXxdCk6GlJUqeLvp+rLGIZ4XrnUQ/jGIQzXGXKNPNNMXO7xNPdrNBjtMeNri2vOZIOwlw1OasyNrEd0TnB3b+ZTMfImwLHFyPb6zoQLOdTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkZkxroNjQwdD0jOoYRSSetuXU2oM7ZV7oZ/pQv/Zh4=;
 b=Nf0hLysaJwlaWopasBur8WuS5PslMjiBg8T3PCUvWNGNIsHW018BmQXhmC6ojIy75qc4BB5bXy3B+ZXPtCzdkeM61XFKZhGrF7Ndk2rwQ/LvHbXXkZlQ8mHDVsXUTL/Of2ahwCmNaWlv9/0AS8FKUkOkE35mmz6Bh0h2fDPnMltDo39d+v+Z/Zjq3LZelGOVg4ykuO2lW0JAPCWFRj5YU4aWv+Ank04MKbIx53RE6/S4DQrVLhRAq27UgcFKetwiUr2OsjOSqJWSWEJ0MCQfd7aY8asx9YnjZnlxYK8VljOFCvAYgXFqiTObqHmCGQ9EBytMA4OyoMctkb9wg6zTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkZkxroNjQwdD0jOoYRSSetuXU2oM7ZV7oZ/pQv/Zh4=;
 b=HjlWpRHwt5rVSlmLFPLD1KEP/llF/HOX7mwjcrKZgHHWZt83INP9N4nuvEjJSsVf53N779KrdR8lWWfCgiGPArgDYxZMrg3wWNQVK/92HH/eLuy4Lrn3tNSVqsRz4BapYkylnMaDYUcoXxF1J1d7LbfKnnGWsZl3DpRKs1aT3qA=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:35:45 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:35:44 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Thread-Topic: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Thread-Index: AQHapUD/qXOQj6UcTUyeoO1DhxreHg==
Date: Mon, 13 May 2024 14:35:44 +0000
Message-ID: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|GV0P278MB0083:EE_|DB1PEPF000509E5:EE_|ZRAP278MB0948:EE_
X-MS-Office365-Filtering-Correlation-Id: 140c2db5-562c-4886-c9d4-08dc7359faf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?573tmU2s66PwEhjqkxWLVZggiWEyLhuvRNY2wR/rjxrQ4ZaCrdbgnjJI6K?=
 =?iso-8859-1?Q?j5XUzOgG2mrJmOyPRsaPkiChg2ket+y+fwZvSPR89LxB1TYU8YuoC7oiTf?=
 =?iso-8859-1?Q?DE7IeYBfxVZAKcTejQO8P0XFax7dVU6eGul86ddHyH99rkXLkUPKnwOrHZ?=
 =?iso-8859-1?Q?a3S0mUJUnimwFeJaklMU390nl2rm8tPoewTZqyfzm/1TeyAitHaJ9+pmLJ?=
 =?iso-8859-1?Q?hMppLTJ+iE7e2Ts5BRx4od7WRneOrMgT03JUcTH726VDoIz97CYgG+W48p?=
 =?iso-8859-1?Q?9Uc5aIeEiS+IzOhyJ8+kPpW/h/rigkq7B48/zCqjwauA7ZOufmkV64yYRZ?=
 =?iso-8859-1?Q?uYVTD3GZGuNuWNY3imWvXAm1Z9UVmH5veu8qHdoy+EFdijpIJXGhM8ULUk?=
 =?iso-8859-1?Q?KpvxM3K/hVKXQenoxaiWY59gs+tT+70Hl7ud3y3NrvOo4yXbAt12+suGs0?=
 =?iso-8859-1?Q?+7Vj0CrgGCcDmeNXfh2fIyqYskauc2eRD9mvrNrOJlFXocVFTfB6+Gpmj1?=
 =?iso-8859-1?Q?UKBrUMV0FlUvdZ9N5qlqw0D6HsBSvco+lyOJi+DnEi0FWFp8ptg4Ma+5AQ?=
 =?iso-8859-1?Q?SdtTjAAWm9VmQ3SMbHEwkwoq6gI+vTI1p7uOqJURHcupbtfg4rcbXQyTxZ?=
 =?iso-8859-1?Q?p9npldKAGvy5Nk4NCfmtTldAZSxnYGErFC5Eo/jFAlgU++RJPDqRjUNTsA?=
 =?iso-8859-1?Q?oqCpRQPfI6ap88Gnshft+YQDnVJwsdxMpyGztaohAB5BQDg+fn5O7KWjaO?=
 =?iso-8859-1?Q?XA9E3FPBHsbPVog98jAitHJkpZjs+VLuAkzrgx8j1SaQj4R1gPWu37AAy0?=
 =?iso-8859-1?Q?Izjl/JJMPs7BRqYbSYdqNz5PVU1lSl2S3I6C+w/TkoWFqencqW167ay2/7?=
 =?iso-8859-1?Q?hJqhbaTvlS2EKEMycv+JRoUD73ySmimCMYQN85BSGVU0ERGLpewUEQlJQb?=
 =?iso-8859-1?Q?gjMo0b0Qzc4aSeoB0rsGDzfk5jqO6DoGcqbpKdPprdlqZ8NNqGE7GEt9qp?=
 =?iso-8859-1?Q?In7dA1z5KkXIqkekcOT5UQUSEcLZ7zYcJBUpAKFtQ1U6nBtBNYuymA19L9?=
 =?iso-8859-1?Q?cV/NDSIYZ9jJTaNpMIEor+Zzt0YgE4vUQJxEvMSJejNcjPZ1GImP+38hQX?=
 =?iso-8859-1?Q?Q/NGIGq/WJ1BEubh3PrQ9Spe2gxbafb8xbDD/GFjt5yw/G0S/YpzypAR3n?=
 =?iso-8859-1?Q?6nMuUcDbQoGf+dVJcNKoLSm/KeKOUdQ6Zzoc4KXwKzQDkrT/9iN5oMQ9+C?=
 =?iso-8859-1?Q?400icA8xRiL/8F13a2euQE0KFLX+I7iSiEIgqfhCKooZ1y9W4rCajihx5x?=
 =?iso-8859-1?Q?rwzvqgonNJnPHRX2XW6lq8tZow=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0083
X-CodeTwo-MessageID: 742f5ba3-96ca-49fe-81ba-be737e7b438d.20240513143547@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c01ade8d-b7d4-41f1-eec7-08dc7359f92a
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|35042699013|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?nuk+zx/ejNVLvhAxluS2EhP8nCxyryzBhtWWaFDHo0l35D/99tdbFmBo/G?=
 =?iso-8859-1?Q?22/Vz+uAC/y/h5PhNIkiILeEcZCofSDx4bUyCTqYtmJ1i4hJs3JFkT3cFP?=
 =?iso-8859-1?Q?DmqdJ/MM3MNnhusFA4iNbur5legtLkYYuTngmI4E3D70QNbmHLXrc6GAHd?=
 =?iso-8859-1?Q?y6plTYDZ0kvSB5EOzCVvgtBI9+acKFFIywGurjlTYVJFbqbVZICPoqHEzd?=
 =?iso-8859-1?Q?o2HpebVxjc6RbtD+tvVjHb/qVVAB8AWJu2O2CCPe/X6hLTnVPcSGcvIRVm?=
 =?iso-8859-1?Q?TWzslmLGMkMVRhzLxWZn+reAewnNFYt4th0qD9UHehUUKpMXvg1Tj5UDsi?=
 =?iso-8859-1?Q?DO1owj+ktGKViH1+CbG5s17syPHOc7hCvR6OBido7xKjhdsWkZ6H7ZvjK6?=
 =?iso-8859-1?Q?wO0tvaDVnKM32msrwh3uqQkaggJleewrrVYI+1R7ERMkIP+uQ2PYBn04cl?=
 =?iso-8859-1?Q?vQhdXEOv6byCDVwjEqJpjsiH9ePNL4KSJDQspicMcPh7Ak5zQRMkLauJ3e?=
 =?iso-8859-1?Q?moeb+JTXSnlcFPaIGlyXI1eEWJ4Aojc8EXFuXfjnObQocB4p1Q1OHY1hzn?=
 =?iso-8859-1?Q?o5it/NrfffPhO9rqE1wztR15a0A4X3xbW/u1yvugcHwiXPBFknlsMmknF8?=
 =?iso-8859-1?Q?LSSVkSMQ0xjMUcdoOvKyAHGKJTt+b10eJ7Lh/Y83Fs2q0Ev8xIBKpIecxq?=
 =?iso-8859-1?Q?e/kGKMirx87HwHN8Nt6k+I6X8nNqhcoJXmDmSQ0a8ayOYoG1vw0tS2OFeI?=
 =?iso-8859-1?Q?de51olTcYsqlHLpmGUK1Yj4w1WxdKWAVF0shNyx08CkrGrLpeInVT+wyxQ?=
 =?iso-8859-1?Q?Dcml1TaNpuVhPhEXzRTGPj1WtzGSZLhn0cSzPpy4mBazhdwgZyb4l1/5oS?=
 =?iso-8859-1?Q?K7PTg5jc0t04rtxhp+qcG5Bx5q/v20X1xCiYPHgzlFIj2G9zNJmrhYmT4r?=
 =?iso-8859-1?Q?x1d6Bt5yG9rnE0ZJnXT0H1D23Bkaw2+yoVdNmgN9ccIeCu2jXlqpWoMBhT?=
 =?iso-8859-1?Q?dP+SO926Tipdi9lAz/sLUaroJa6xWZQYL+CPVmZARSocEiZBdmkkzsRbLM?=
 =?iso-8859-1?Q?0n+/td7o4mIHBL3rtXDWUFYUiQYWtii+A2QBoVo40YSPzHOrV5AjawYO31?=
 =?iso-8859-1?Q?f8sLghL9S8N2fllC+875FJ3kMUazNF26KOpQvxNNh+0WwYW7xeq5ThIetl?=
 =?iso-8859-1?Q?z/cEblPazI6n3UH3RczC2vudHHF7KRlgn48uEsT0/dzzvyX2l1fWBK4PPg?=
 =?iso-8859-1?Q?JJ/B0v0Genhnb+8iDv11bVgh1xpgRvZft4C87EQbyOZRsE3HNqHpLaD//z?=
 =?iso-8859-1?Q?NSJqEYBlZcxPoL55i5PueKFEgUoCPLY4wt0S3NZ7mEcGvpfrzay4dQQD21?=
 =?iso-8859-1?Q?qrQVtrlLrT?=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400017)(35042699013)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:35:47.9412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c2db5-562c-4886-c9d4-08dc7359faf9
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0948

This commit adds device tree bindings for the veml6040 RGBW Light Sensor=0A=
=0A=
signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
---=0A=
=0A=
 .../bindings/iio/light/veml6040.yaml          | 43 +++++++++++++++++++=0A=
 1 file changed, 43 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6040.ya=
ml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/light/veml6040.yaml b/Do=
cumentation/devicetree/bindings/iio/light/veml6040.yaml=0A=
new file mode 100644=0A=
index 000000000000..796c22f75575=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/iio/light/veml6040.yaml=0A=
@@ -0,0 +1,43 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/iio/light/veml6040.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: VEML6040 RGBW Light Sensor=0A=
+=0A=
+maintainers:=0A=
+  - Arthur Becker <arthur.becker@sentec.com>=0A=
+=0A=
+description: |=0A=
+  Datasheet at https://www.vishay.com/docs/84276/veml6040.pdf=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - vishay,veml6040=0A=
+=0A=
+  reg:=0A=
+    description:=0A=
+      I2C address of the device.=0A=
+    enum:=0A=
+      - 0x10=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+additionalProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        light-sensor@10 {=0A=
+                compatible =3D "vishay,veml6040";=0A=
+                reg =3D <0x10>;=0A=
+        };=0A=
+    };=0A=
+...=0A=
-- =0A=
2.34.1=0A=
=0A=

