Return-Path: <linux-iio+bounces-26481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A4C8922C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB484E3CD7
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425D2BEC31;
	Wed, 26 Nov 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="E3l9X6dx"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBB28DB76;
	Wed, 26 Nov 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150991; cv=fail; b=Jz94hJiS1HwIdavRlo9a5HrZnNwHLeyj/u04NULsybX6r2eddCbCDHbVkytHBElSyIN+ZJ/waNOgrF6SmMQ2LoB2/V2JP7t+1/4tYDBvM3M2gXCck913+taqlvwVJBKt8+RF6MxbYrbGsZ31KwoyVJX2p4/6x0/IhtfLZJZcwK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150991; c=relaxed/simple;
	bh=WlpHs/Dz0DV1/brgXbFeI1fhbNNBxO0BM3SGMRcdxHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZE/2TMhR9A5CAiIHmd0xZ1XHMRCOdvvAawiSnvHXcG2rT5VaWazeXlLg7J2Ijf30tUg2RbMNfFU6TPJGkmPIf14CV8m7PNp4qPF0ctqK3e+IL/23ay8NepHm/AwlAw2Te8+yUA/R0dSDkRmaaki4lm2QS5/yL4VjN1KTqRIUJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=E3l9X6dx; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz8qNV06QTM0d2qx4BasjVD38Bp4nEtLVo8+YBpiLWRf6BvYgT7y0rVPcpAtF0XMoNiTKeKdMFrJ2mkNQNNaWB96qteZp43zf4LTIWV/3On94cC/axrjrWPiA4HWnDop219GHPpGT6m6xGNPv+BJcfgXdm0lhYNMr0ICCTMdFWe+l//n/DWWL52D8b85HjJobo+8blwzAt+TWfE0fGcMH+62FnOmqgU9woLxgQY+AxyZw41rwq36d89+UEXb/FXOfsiRwwjLR6xhIIlkvjhnnAgTcJ6iWITM/oWkcVWPzf6dNoWX2lRLG5ZShN45DcpeymxepFYY7Bp4a/11zBr8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8hGg7s97CaTjFhrszBOQ6X7iaW4BAfqQnNUifdRdlg=;
 b=ibXduBw/P3BPQBWCSCD33+vt4lNmMh4G2zTdGlIzo3+3clZh3M1aYP8MfrzIJodQ85+duqgZPIbTZxEh+jV1Lt9Q1ZXqLTGaq4j4xuT8iFkDMW6xt3HB42Z1S9KgxrMVhPTsWzWtZVEWDJ+mnptx24tJGf7SnqK5zQ0fsiPP6kbH7nqA0aY6XLYA7LAYoUl5M6LjFxne0Il+xt2f3uGzCgqiSPjh34cpEUA7XBFkYyCfOEQRE+ygDYDQmvLskI2V/0/cxWfu5Yd/+OxDHSqgfuROPGVkCm/GdhZ9uxGeqzOSjo2rimT8y9kLZN2oPgdJ1vj2wrAj/zn1I58yPgpaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8hGg7s97CaTjFhrszBOQ6X7iaW4BAfqQnNUifdRdlg=;
 b=E3l9X6dxAu3iOXd2T+wBSjS1CQuMVSPMHl2YTo0JTVpHZ1okubKkyU1iRdNeRmAx8o0zMfUVZQyCe+P9GARBGLXb560K89t5I47FyKkpnDvEr946Q65iwDAy7wleej2qFn3QLou9NcD26z/fsNfdaZhKBXIMv/+k4Z8ZNNfUUNARqVnsjpMMpM8WQ0Ba4sG8H8hH45KXWwgL346tUZLjvTMLwfJtzB7zuFBqyCvxh1iGUSf+fucxF0vH6zttzJm9dERuSH/gvXflMhlzKIbAId34tg0Fjkk/aETS3gSJvUQU74kWTgl92DuLki2XgEjBTC0MnJyTr137Y9CTYxLl5A==
Received: from DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cd::18)
 by AS4PR10MB5545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Wed, 26 Nov
 2025 09:56:24 +0000
Received: from DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d474:3117:a043:79da]) by DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d474:3117:a043:79da%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 09:56:23 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
	<andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] iio: imu: smi330: remove redundant assignment in
 smi330_read_avail
Thread-Topic: [PATCH] iio: imu: smi330: remove redundant assignment in
 smi330_read_avail
Thread-Index: AQHcXi+JFWZiC43GrkOq33M+LeXL7rUEuM/A
Date: Wed, 26 Nov 2025 09:56:23 +0000
Message-ID:
 <DB9PR10MB50208862E82581853CDCCD54CDDEA@DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM>
References: <20251125171816.63790-1-mpellizzer.dev@gmail.com>
In-Reply-To: <20251125171816.63790-1-mpellizzer.dev@gmail.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5020:EE_|AS4PR10MB5545:EE_
x-ms-office365-filtering-correlation-id: 871d449c-0627-41dc-7325-08de2cd20efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lw42yCa8inTHxnhn63/u0T2QcGqh3Vfi1iP8KDJR2cBI6XFXmyR007ITVtgV?=
 =?us-ascii?Q?ODbRxqPPotoRnsrQV8iAKR5XJsBXEFm/gWEDo+2HXwQYpdnVmJ7DN3FX31VO?=
 =?us-ascii?Q?0Vh+GVX5jkX1PnrDN5NPPOW6CPsBJ0q4GLKql7M8ajTvqROA1qT+lUdJrEnH?=
 =?us-ascii?Q?WgW5XeDH9Q75DHEO1V9InjFhK3PayJyfb9scF1K8s+uLbNeM1E6UEeoOVdoL?=
 =?us-ascii?Q?D21OngwWOLIiR9H5tTNCfC0TCuoArlrHbcRBw/7YQGt283D2ZDx19dgs5Ixi?=
 =?us-ascii?Q?V399cYP8K9YxTQtHITkw0z5JJdDIVxPTERCsJN9pFWe0lo5fOhq5BAwl0S31?=
 =?us-ascii?Q?RGhNcn/IvYnnqR9jBZ2d6mZhw7cSC/W3FItRXY7zRXLyy03sf5S+n+O1nRWg?=
 =?us-ascii?Q?S15Iq434hBYYeGT0d0JmoLqMnIhEXixV9U/axJmzQ+naBw6wDNt3ct+FFnmX?=
 =?us-ascii?Q?DI3VJxbrlt8/MM6kQLhEyzV1ycT+1B72SZ6s9Z99hL9ILD+ajpeNqTXowxwd?=
 =?us-ascii?Q?qJda0TdVxAjf/YgkM1LXKYc8B89c+RGEwbK1dIN6V7nMVPnNdX1eHd+9yQzO?=
 =?us-ascii?Q?tNDZ9o0Dg7WfFJWrwEL5qQzHYs7u3b6N2G7LZrUbl+2X1NYLhotjvh/Q9a/Y?=
 =?us-ascii?Q?m3MmQ74NLlun1wVvs2BMe+pd9wdfZYLeJ54nbA8qtA+WV3SkeC7Slx4Xtim9?=
 =?us-ascii?Q?hDR8QUj1+vCboxB9v0scojNQICqJxkY7jLCicbdLsCXd2AZL2xM4Xw04WR7z?=
 =?us-ascii?Q?42c/wQnLSOJZZCx3ySp2NEqtjelbNK/yPAQqDmcdQWwcBknA9LFH/yEzzSly?=
 =?us-ascii?Q?lNZwK/Rk0t2+o3fAm3O9eseQVs+mvwnmEhaSBzhSoSq7EvEl4JHpzbqfWh2y?=
 =?us-ascii?Q?VDVV65bXY+QtOxkqBYo9DnM1RJIars5veLwnN3JK9Cl0zIjaEpEg8t9Kowty?=
 =?us-ascii?Q?DdoE3THabcvzUE+DHrbaMrphUNnGMN2bW65upJoWb1S0ZHe8EkUYFN4u+PAw?=
 =?us-ascii?Q?Tdtl8/k5hWboDHihkkhfnEqxRiCp2QKtAreSMN4YSP43g6XXpYweWPJJj+ao?=
 =?us-ascii?Q?MPF+9WgOMJOj1CHvz3bFYh499SsorqLAU2iwcgQsmISq+0TUZTV8l982oYa5?=
 =?us-ascii?Q?nOCldSBOgAVnBdDx+MOie3gXEsmTsAwHKAKgq8ZJi1HV9sTlKiwnynP46eWM?=
 =?us-ascii?Q?jYQePuVzeQjSCAxwzkiOR8k8tYB+EdU7EFLX51USFYcoaDBmBsDyQmb8724w?=
 =?us-ascii?Q?gGD7LvG3wcZcKt2fla3qBNVPA1qJj+vwcS/zWjpwLppt1JJR9NZxNKUlvXQ9?=
 =?us-ascii?Q?l2JqRNvw8jtbgIXaV5GMeVnNlFNZ9577Zz/26cGMrzCOPF8sjUQQUA8DqmY5?=
 =?us-ascii?Q?o9EWWhoXWtsIFIoRG7btYxTTkJYfamoO2H720wGxD9yE2CatRRVeLTmC+uDo?=
 =?us-ascii?Q?wYzWsHwJ8KRYaiGePMHZzbJtXkA4e90YqIWP0A/JulRTBVx19wBKJgG+YE4t?=
 =?us-ascii?Q?o9nZ/uQs+8nKTWlFyxEYMt9FzAnpGefAQchX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H9NL+k93+QAaZe8oj1E/OVLPKdceCulenaXdyG3ted4gqFddwkWtPFh+4u0Z?=
 =?us-ascii?Q?z5tvxpYstfrnbhYvUI1vII+edQWFjEHwX00pfGegducTck4+hg1PNEAQNKgM?=
 =?us-ascii?Q?89sY5nqSRCZiIikBtouiojxC6pmLkQqeJzsxYIvcZZrGqgGVm7uOgXY6tySk?=
 =?us-ascii?Q?0fZO+C3xhVZN3Au1Ixzr0rr98g5LWgznA6L4c5Xvzql45S5XUOgP+OH/OLyr?=
 =?us-ascii?Q?2VQ18mLfPAlIiJ8XY47ZBgG412AzxgOTsQ1VUSn1Hpc4+SBQLU4QHmpZa5ZK?=
 =?us-ascii?Q?Hfi3psGnih448h0lYDKBlNqARaodNhNwKn/4GDzj9igg74/VGfXUd83lrh5Z?=
 =?us-ascii?Q?jedC43baq++xaLXXixVAM7FlchbH99ISI8Xi6zYKOLfnrNG79/qxYOMhJ/Wd?=
 =?us-ascii?Q?ykk4fBiAJa68VPx4k5LZ8FOEAWgAazuSz4/9uV2YI8lwlLLO06avnmf6JRTA?=
 =?us-ascii?Q?OaqMj4Dma6DzNGA/obH4MIF8RXI8azsv2xUs00l5E6hWt1Tkpn2uPHajA+Pg?=
 =?us-ascii?Q?RfmvayIFOGhCyGOButSoTvDbYgL2HbKYYFBaN0dzRTdD7OA3oAfuYuD/C2kP?=
 =?us-ascii?Q?GLNY7fag8Tm/GJCwsPhmuRU7BoZinCZLStNJ0KC4r+wgG1fpjrQHsRhsw04L?=
 =?us-ascii?Q?HX3rOBdZqWAY0e06w5n3FRmiIpvcWEVZceYe1Jgbe/cLTSApTwCy3W4qNzei?=
 =?us-ascii?Q?6iDpGpWhdMiWkDbtWQQET5Jj1AkeDByskCFlKzWT1vfBgJkCvo9+Dck74ac3?=
 =?us-ascii?Q?TggM2dTGQZKUkH6iBI8ehGX0UqFehhdigugfWrV7FMX09vx6vsOPRB8yu/C7?=
 =?us-ascii?Q?RTKvCYRtmOcjk2mmezFYLrbEcdBNtP5oF4RSYhhrpMJ0Hr0GN/rYylG7mPn1?=
 =?us-ascii?Q?8RV9jH2hKbaUqITW8qsp7SFDnQrdgp2KJVUBftPoIGc3dAm7+5UblcKrgoKC?=
 =?us-ascii?Q?oq3UXwRVzxpd8IublfqlNTpfpRwx/w98STrT/iPkZSOpYw4bNISTpNW+DoDS?=
 =?us-ascii?Q?Ff6UoC0+Yx9HSpQFuRpUYy+x1QM1kJCfGVtcKX+UezbY6gvT3RxtrQE0lUM/?=
 =?us-ascii?Q?gO6z5+4N3AQ6MAf5eQSY6KJQtfSuw4KRNExfQydsSDzxqrxfX1emwcYIyAt2?=
 =?us-ascii?Q?nl6QrZobcGQ58fTc0lV9Buqhg3uMcQKWGWZ1h+XG9KzY7gmB7RVXVb5Tcqw3?=
 =?us-ascii?Q?Twv50tp0zdRW9Iuh9hOYxN7IgRlUX85Ih1iVJ4LrCjT1Hx/QrXSqibLRH8JT?=
 =?us-ascii?Q?llCh0ajtjf4e3aWL1M/GYJj/8L56ZB/ns01p2n3mWKhYMDa188ZFE173atdQ?=
 =?us-ascii?Q?HQVUCIZ+JWDqnzGQJLe6S+mEm2sTzHamat48CgTaHTSfmJeBKiQI0rvVvzNy?=
 =?us-ascii?Q?bbFZVajvfmJsOMt9rnofjGulcG9r3bedUOE7aB6vPqFwNBlccNi0ckoc08Eo?=
 =?us-ascii?Q?3Y7ysd+BaS/5K4Q/RC0Lvb6TdaN/f8omCu86H1Y/RHa/7UaKOF6CtYeBcDeh?=
 =?us-ascii?Q?9Ca7BohVdPpk5fXC1kMsOd3zD1JK54dIXUHz9jp8J+QNubO12GNzrSEpKtX3?=
 =?us-ascii?Q?pFGHcYool7wPyjVChk4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 871d449c-0627-41dc-7325-08de2cd20efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 09:56:23.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRL7nJ0mY62QesI5KOk2pm/x2rEhoDyskkmG2Zvulj0qoUyFN1AEIUR3Ih1PFd2Ao+O62HbyldNqy2GaQM2Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5545

>Von: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
>Gesendet: Dienstag, 25. November 2025 18:18
>An: jic23@kernel.org; dlechner@baylibre.com; nuno.sa@analog.com;
>andy@kernel.org; Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
>Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Massimiliano =
Pellizzer
><mpellizzer.dev@gmail.com>
>Betreff: [PATCH] iio: imu: smi330: remove redundant assignment in
>smi330_read_avail
>
>In the IIO_CHAN_INFO_OVERSAMPLING_RATIO case, the type parameter is
>assigned from smi330_average_attr.type and then immediately overwritten wi=
th
>IIO_VAL_INT on the next line.
>
>Since smi330_average_attr.type is already initialized to IIO_VAL_INT, the =
second
>assignment is redundant. Remove the hardcoded assignment to maintain
>consistency in the code.

Looks good to me. Thank you.

Reviewed-by: Jianping Shen <Jianping.Shen@de.bosch.com>

>
>Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
>Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
>---
> drivers/iio/imu/smi330/smi330_core.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/iio/imu/smi330/smi330_core.c
>b/drivers/iio/imu/smi330/smi330_core.c
>index 7564f12543e0..0cf673b44b62 100644
>--- a/drivers/iio/imu/smi330/smi330_core.c
>+++ b/drivers/iio/imu/smi330/smi330_core.c
>@@ -475,7 +475,6 @@ static int smi330_read_avail(struct iio_dev *indio_dev=
,
> 		*vals =3D smi330_average_attr.vals;
> 		*length =3D smi330_average_attr.len;
> 		*type =3D smi330_average_attr.type;
>-		*type =3D IIO_VAL_INT;
> 		return IIO_AVAIL_LIST;
> 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> 		*vals =3D smi330_bandwidth_attr.vals;
>--
>2.52.0


