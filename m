Return-Path: <linux-iio+bounces-27044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBCCB8A3B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96198300A704
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38617315D5A;
	Fri, 12 Dec 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SD2RJAiI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1E2D979F;
	Fri, 12 Dec 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536093; cv=fail; b=HlIYjluEfA8wFtLC60zgMHB2C61wgwGoVCZF2T4hXSFSAWPbIVPaeR9zTuoxGuByaoBjYgRT0jTTdbwlpYvaMWZgGFvZVOJiWHQvlLCSV1euw5j1xmDCA1X7LQF3lAWPn0cpj/n/fpzeSA3MIZ4VG+e1DMH8KUnewXrm7Kj7wqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536093; c=relaxed/simple;
	bh=ubNSxGuVb7UCnYMnLAZ0WTE8575acgNIc08Y+baVgyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GdKHzNDHU1cnkvaWoglr2YeykD3Rq50Hka0IppRsZRxgXwRsQUYRz6tFLEA9kd7Wnumw4RT1KhwgpnBi4bZZVMz4fFOQSJ3SuxgMGobHf4fyf3JxTnM3GJjXLAwMDFy3PmrkPhWFifza3xFJOjo0HNzA91I60J8wvG+nYBwxAhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SD2RJAiI; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC76E7h3384516;
	Fri, 12 Dec 2025 05:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lmbDA
	J1MAuP410SxjRzjkd/+GAg9rG76WNup6ZUw2Qc=; b=SD2RJAiIVwbiQTqkQyWdO
	tgGV7kYyWkUkv4H1a3p0qYWEVCPQix1+ZSDGT4aAwsM1OZjPDUEKgThcb4RQPq/l
	N3aQRPjD0XeowA32fm4VpBCrAyqihszF9EXnWcBZGyPO/uK50vvCaLo5XV9dIF+a
	oUuPUZ1U/MZlavf3LPfHJtvXvnkgzhn8OzzVysl7mDru5kEvh3Byh/bLPR55FIkA
	qiwWn5vft63WK9qBUFsVyf2xCs1j0Zn6ukVsACyB9eh23RwZZ8YB3/1QRmmHpK2v
	/y5OGHZayPWaW645X7kzkduC0pMlCJke4OWoQMiTYzkabeBZP5NGG5JX8aiRd2Ai
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b0ec8rnt7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 05:41:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbpeNAhJX6gqpPAYtyNB4AB+/CXTL8yi0xC/iNEJI3/t3W4y30BTJb450nxEaVuckRxWfMzGtQVAtqIdraac+TGcuYnC1Qvioeku4keCUknmtvkfvH+agvUIhZyXj0/yjEABCvS5IzO4quB3JKqO1Lm2Sh8FPbwmhO+r9Q4/TXmvLaTTMWh2J0jhjbqIogyuWiS5Wi1swfA984/bUCaU7ryogT7TICLeHEBdUOYjTpZhztXzM6eHnZ+OIz6nZcynAtk+sIu9uj34qOr+u5Hv0h+rK5KrYi8AA/wtUrVRmZVYDwh5IXz8qtDwymHRFSVOi60qVppVaFJyrVQQVkVn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmbDAJ1MAuP410SxjRzjkd/+GAg9rG76WNup6ZUw2Qc=;
 b=TwdNweHYEZaDS5juUTNiKEuvMd4eG1VrLcVaR76dfeZYx6oT4VJyIwKsYlzGq2W1e3IfaB1cs7KivjnAHo4qrwZpskV10fBOD1911qPGvYGlcBme0NfivUczHdD1o0AZJVVai44nAPBJrTlyVbnPopu8ARg1c8Teo4HEPN1tSVVr8+/U7z3UtCkTey7pUhtQwXK3d6VjVXRumrZM86pWRqOQ93aFPG9lPlMtLumyPlH2Hst8BHC3nOANlWPuTzkbu15ZwJJkZd0uRuZ+WZPUbJCTXMEQstx++gfQMfnwdzRBGwPBSemLa0eTzmbzu8gZwH3bLrpeCodzJ4T1xltKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BLAPR03MB5441.namprd03.prod.outlook.com (2603:10b6:208:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 10:41:07 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 10:41:07 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Thread-Topic: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Thread-Index: AQHcZfX1QEN8JgivpUeQ//unjStBibUU+hsAgAjgA4A=
Date: Fri, 12 Dec 2025 10:41:07 +0000
Message-ID:
 <CY4PR03MB3399DB00FCF85E28132833199BAEA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
	<20251205144058.1918-3-antoniu.miclaus@analog.com>
 <20251206190332.53874d41@jic23-huawei>
In-Reply-To: <20251206190332.53874d41@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BLAPR03MB5441:EE_
x-ms-office365-filtering-correlation-id: c15504a6-d77d-4126-efee-08de396af535
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nkOMokd3Ke2h9Huif7iac/8jzL7yKCs/CF990f7mruLPLI/tZNRJQ1nwm/cW?=
 =?us-ascii?Q?zRP+efrN5yNMt/gGzX6GQPtgDWuT8G1EAt4yZdNJsQSFrSUhpv7qRvFY3Ppl?=
 =?us-ascii?Q?4EDltDbcjBqc0bNdFGF9rbI7YtSua/Jbt/p1efUyj4Cbmgve8Ied444VykbV?=
 =?us-ascii?Q?hSNAKu9fqaCBH8uXtB2DuXlD6h7+anfhwC4M2a4uraZ8Y3AuUqStKnWr6V7E?=
 =?us-ascii?Q?3BW2uAuNw/iVpBrJ5sAYbeYgXERBwArJEsD02VUvbXjLL9qQSgba8l1zGHrb?=
 =?us-ascii?Q?/5SCzscm1TKzSuuxOycOHOXsErpSLwrgUeyc8EFiFr1bAx4jjjqurmXcqPM5?=
 =?us-ascii?Q?sst4AnE9q8UlDtGutK0id3o6uQoIx5r0LjUWjcDIbZN7HqSj17yLyeGP1bcG?=
 =?us-ascii?Q?9BU5V4hPMeYzRW+hE6N1J0ADEQdxeVjg4LcD4t/9ZvM8jyuEgMdPT4VYszkj?=
 =?us-ascii?Q?a8j0KJIGKkWZN3mrWUaY3FDTwwgflzghlD38Iw1u2FNtR8M0iGPfYMsi6gOu?=
 =?us-ascii?Q?+xCwA3lCLenXW0elQ7C6hBaQFeZFOToC9isS0CQVXZHGCQJ9ORiwxRMC8LXa?=
 =?us-ascii?Q?3IH/+vx8zrdZD3yPKsMZYRYa0/PrJWRC6j1p5LMFrUjEQ3iy1MmhNMfQNz2L?=
 =?us-ascii?Q?uXCDld1tfLKo7Y+It+BPyh9u3h0SMQ2sRETIZZ/CZMcGooRbYKWRipWiipK0?=
 =?us-ascii?Q?/TDQGWXhUp2elc/dpeIaob0jcfXcCEoL+C7O0cfQfm3wrbcT3v643NHkqfHa?=
 =?us-ascii?Q?bTWR+cO04hYMSjoR3+pU4Jf/gUue+BJh2wUhfaB5eqmOddgqPWaq/HqNKCDG?=
 =?us-ascii?Q?d5oES3KX6lX/iJCDcmA0tMYVgjDuUraXIa/4a5MviFbASkMPIFv+0hgGJd2V?=
 =?us-ascii?Q?t/o9cy3xlsaEiSgfh3IP7o9YitgDP//pQxwlL8Z3lsrHeCdzt3R+q7KTG2vr?=
 =?us-ascii?Q?ZryF4lsJqi4mKiYQb4W3rNqxyaH35VfifqnMXvDvpmnmjdiACmfxaSqCB0JA?=
 =?us-ascii?Q?xSv1PDwGz7L3tBslk1H9rWzsUmgCPoDMnb0O0zg2Jm9Z16K7yGGw1Bau+olM?=
 =?us-ascii?Q?asxVFLp6plGl/6GRuqlrEOPMLp04EoyOtEKTc1qTK4s7td9DqvsD32sdcOYv?=
 =?us-ascii?Q?AV5+5CTtigh11yY0OTWsT+nb5+wz+SIpcdATk2wU7UeA7O2RkcX/12d356/W?=
 =?us-ascii?Q?lb2L8aIVfyfWJQSOhSAgsNDdzZF1oRROIzEx/oOhLn16KNL/uY+E1q2sHzxT?=
 =?us-ascii?Q?EMtSvjufGLTLA6KCFyA7+/Izjptvi8G4DgU4xU3fGohZN9gy+czdSh7+4IJ+?=
 =?us-ascii?Q?VHUVs8G2UN6Rof2UgAv9dPd731vcavY1b1j0axUbOdxy3FpvPph8TtHto0ch?=
 =?us-ascii?Q?YapSXxSVJeNw2OmLyVVFCqm/r3/r2L7kagfi3qrZq0rlPHEZo7BLLmyuSa16?=
 =?us-ascii?Q?Yab1kNVPl4tOsdxGpIWLdjMM0jCk2FMht/4PxOY+UpC4WkRIObncP1JgejLI?=
 =?us-ascii?Q?C/U3n4nGkTrtmMiCEIQcWGYlKDJT6xdLt6PL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gk3YTp3S/ocbPxiOzODLQEUPbLF3XO1XtjuCuwJLd9h/UETwszmAtP2q8j75?=
 =?us-ascii?Q?4ZIewdyqmisbBjnpQanlHJ4ejexMI7I1rKTO6O2t2jT3RKrxz2wOyZ8nK7NJ?=
 =?us-ascii?Q?HmNcR7X9aBPfhN4MThiFPlYdmCQS3CDP0Qf6mnzQD+/fzWxcVsiWeWwsEJ8d?=
 =?us-ascii?Q?9PxkJkXpxq0ca+TukQS0N7bbarBVAcQ5L8vQChEBYfeNrS3Tv3mpBlbZoZhi?=
 =?us-ascii?Q?9vd3QuoMjcmuCnqfyoKqkchjIIycW0R25aHENdY7drYz5yRRVa5ehOuR/1IN?=
 =?us-ascii?Q?H864q7fTSaNjJYlXxuZB5/XpfdYzfGauWVoFRcdDnjkghmjqdNMPmjcXY3Li?=
 =?us-ascii?Q?TkjqOsRk3e/fAdZWlnk+MMIm0Dk2+F4Sovb1tjSoZcIbb0BN4UmaKQ/eeqIr?=
 =?us-ascii?Q?8jlKCQ7NfyaqoL7hAzBb9OPa9XjLfdXORuPAkRnz4tULKxH+02VD2LlW29Pz?=
 =?us-ascii?Q?aYU3Z5YW/YBYfw9W6FlX+3DSu8ja1uUYWlrMs+z1O7NHVqnHguB0emOs3HFV?=
 =?us-ascii?Q?PnKzWJulsvvSAqzdoADMZdAGi7QYRLILqv6wdzMyCuIhfJikC3zpAC0H291i?=
 =?us-ascii?Q?oDKS1JoEiH1h0GuhctfOes7hDP7mv55dnrA/xwA4cv4EQQNhLb4mktRNy3YP?=
 =?us-ascii?Q?CFPxdlLYeEc1NdMB2JjdONxhBHkOXsxEEyJ1kF4932rNRiqiXQthoSrth/68?=
 =?us-ascii?Q?KupHzBr1+Ny8UAkFyP7Sit5oaleEQ90imxOUstkV7MO2JzJOtnvEWW6GCIzD?=
 =?us-ascii?Q?2AU/8inOzgFRr/KsUbeo94ddBvmGPSnP88cRTwAl1foxmsFal+uNs0RGsZuL?=
 =?us-ascii?Q?/ASkTTjCHj4+uqvcEnl58Bw15TLrHqOujFD/NRTAfuWKKHB5jz8kSmbwTKOI?=
 =?us-ascii?Q?tFHGvQFGqALny2TCxz+BHt6Q4USjaUDVNEipFMn/SGqI6ux+3pTqNBxQ1d7M?=
 =?us-ascii?Q?g5km9pIIglDImxYXiS8Vde4kv12bTKvr7cGJiz5STrqRBWkfrXtWQcsgOoss?=
 =?us-ascii?Q?ecdM/tv+HLZJYqQBRQc38co02rmknyDiHzbaPrmZ52lKIs8ExPFdO2R5SVhl?=
 =?us-ascii?Q?IvccA+de4GGNbLKhJsqak0EPi++W/dQmjQQh/xfzBwps30V3PLKO4MmaQ1jU?=
 =?us-ascii?Q?rol1Ye5MQY1N+Vy22KIDZbv1WzR7yEIzrcn+tcJZd/atxA8SYenAoyNY+8Fd?=
 =?us-ascii?Q?GHHQPWwPLm7bPYmdZivJO9qYS2UgS/i2xLPXf5BP7UJfFU1mqhVtuviOgKaM?=
 =?us-ascii?Q?7fdr5FdFkHvvwOeBlTMvfhgWQs70KBlFNDtejKuFUgNEbxGTWUW0FVklTzjQ?=
 =?us-ascii?Q?V7RJqq+8jYCUHIKIWrW2AO1KEm7Pa+XUFFgbcDVXqeMfKXE8+7FMZdAd4Cws?=
 =?us-ascii?Q?vVlqpA55RSESG4ln4AICtHumkDJFxdw6pgf3xhJjg2jya9fohb+fJRsz20rx?=
 =?us-ascii?Q?39WnIqdeNuF9T8bDelLKWB+3CQzUAi5lr6/pSpscNBvVGHq8P4/4PKl47uWx?=
 =?us-ascii?Q?8RwELgajNo6bPKiKgMu9ot6s4ppuKpLN/fT9BaN0MZvk3CFikzMZdjoUoIyZ?=
 =?us-ascii?Q?8WzTsRXpVSgDRedtPaF9LKhODWLUb39Bpss5yej6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15504a6-d77d-4126-efee-08de396af535
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 10:41:07.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mT3xRUMu7FlZOndRA4w670GimrHjNbZeQFAuVUOBDZj0XtxiCKuvo6Z7LjpE+02mU3HaGV5E6sfoCV8vdJNQ5mjT/rOmkcQTqfdI5e565/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5441
X-Authority-Analysis: v=2.4 cv=MuVfKmae c=1 sm=1 tr=0 ts=693bf146 cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=1mA3O9KYgNTPXQfYGVMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: guzYO6eovEXk--oUdVxVg2GDlf8CdkEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA4MSBTYWx0ZWRfX48PbQ/N9Q5dX
 t/LQwU0d1HUNtKJJ5u0Sd4QSUINRtYsXWFbyP2QJgXNAikFAl4GLWHmFsE4L1684TRZvc83IAv6
 Tu43m5q13pMWOYKYXAnmHi5vToiP990dosi995zIeTbbJG55quziJv2I49Qe0GC7cDJTmV0RdIx
 31OepL8nc8Tir5w3H9FBCNLJtPnJMEoyBYbMPb1CiJffRalk4whao/qLqy+uhrHghFaZozVkLoS
 ScXpJlY/qGHBBML0MOgj8YFf5RziuWL0GzEFVWlHwLtzE8CFiStF1SHDhJz8wD7qnl/A4pWFyfa
 Ic2LVaJJtx7t6Mcgz4MYEFScp7mQOSTvCPZDgMqAW2mjPqvopytNUD4JYNYC8ZcRS0Z/gFyX3v2
 lDDxNj0lfF0AxwI+/3bMDgcQGbf+Ww==
X-Proofpoint-GUID: guzYO6eovEXk--oUdVxVg2GDlf8CdkEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120081

Hi,
>=20
> Could do this as something like:
>=20
> 	st->gain_configs[i++] =3D (struct adl8113_gain_config) {
> 		.path =3D ADL8113_INTERNAL_AMP,
> 		.gain_db =3D 14,
> 	};
>=20
> 	st->gain_configs[i++] =3D (struct adl8113_gain_config) {
> 		.path =3D ADL8113_INTERNAL_BYPASS,
> 		.gain_db =3D -2,
> 	};
>=20
> etc.
>=20
> > +	i++;
> > +
> > +	/* Always include internal bypass (-2dB insertion loss) */
> > +	st->gain_configs[i].path =3D ADL8113_INTERNAL_BYPASS;
> > +	st->gain_configs[i].gain_db =3D -2;
> > +	i++;
> > +
> > +	/* Add external bypass A if configured */
> > +	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
> > +				      &external_a_gain)) {
> > +		st->gain_configs[i].path =3D ADL8113_EXTERNAL_A;
> > +		st->gain_configs[i].gain_db =3D external_a_gain;
> > +		i++;
> > +	}
> > +
> > +	/* Add external bypass B if configured */
> > +	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
> > +				      &external_b_gain)) {
> > +		st->gain_configs[i].path =3D ADL8113_EXTERNAL_B;
> > +		st->gain_configs[i].gain_db =3D external_b_gain;
> > +		i++;
> > +	}
> > +
> > +	/*
> > +	 * If there's a free external bypass path, add one with INT_MIN gain
> > +	 * to represent "nothing connected" for testing purposes
>=20
> I don't follow this one.  What sort of testing purpose?  Something we wan=
t
> in a real system?
This addition was suggested by David in v4. But I can revert it in the next=
 series.

Regards,
Antoniu

