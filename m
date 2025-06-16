Return-Path: <linux-iio+bounces-20716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66613ADB39E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3523AFE22
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F1218AB4;
	Mon, 16 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="U/Pvd7cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31138186E2E;
	Mon, 16 Jun 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083431; cv=fail; b=hQlQmlFsVssPdhRaXQRy+UZPERwUNX/OSAvjEk0inRhOR502kPLtj2ufC92s7rJUPz2fvWhgcwSh2iMGje9jybL40NCwQqp5Y8C5m6aW/IrKaNVYmiEHgFVpEky8fIpObLKwciUiv+YoI7+RRleWRE6eqfcO3VakjSv6Qua2ekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083431; c=relaxed/simple;
	bh=pciiqRUEi5xr4hhaRl3jKCswdscTDtrtdM3S767Vs78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOGF/nH6j5EN8O/O++aLz4DLVGwGsF3JPUvQDHNjBsm+2ef0h5u5mzR4xelxerbUTYzisFobIyXSBcjJTr5Xz0/5UPTtflU0rZuGhq47648rfYRnvTTcWhtygNg6oysSHkeUusZx6YkyNnrkNB/ZwaGqRjGSDz/csBjas7O9tLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=U/Pvd7cp; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNpDKX032558;
	Mon, 16 Jun 2025 14:16:37 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012019.outbound.protection.outlook.com [40.107.149.19])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4792eks940-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 14:16:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjZhrjJBONBNjH/Bhf4hJKsSoNAh+IxTZKoGXW5r8tn0vTXOPv/gIk6f40Lgj3hBbeQ4UyD7DU4RFkWfxqw2M62AO2K7d/Q58nYsKj1JcKyoH4h9v2uVsK5Rc2OjjVF4KyZZE74wWwlQjQJUaEP0DS4LPFhIn752EkHSS3o8YrEtFLSrVa5mA2U1d0eD+XuhWwpUUny98TAA1l/1HYyBbYz+FlYT0L4sFSKUzaPyPe/7pQqo4EnFtkRM/K3jJULrYrSrLzhEvr4OT60oRNGSyxsj4RNYOCRyz1O3dvQ//EfbkfWlEqyudngaZC7tg/Bh3iT0iYyjJHvDS6jS+Hun+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3RAdzriZmTfc3bprE18GzvhAFQQreAKXPuY/TeNDFg=;
 b=XbtQgsN/9JlsyW9CU3fYKEPXmc+lfheQcNEoxrG03cja1Orvu6PKpR19HEB4wYFexc4O/SXsa2kX1xBDjjL6trALWj8irhkm2x9MMocimzRpu1f85gPfmyVZuycZuBefFzUnI0igJII5Tqrl5+UdsexSeiqnFaM8iwlByjyx5eyzNtxEFaDlHzWlTnq+IsJ0X3NDwvURkF2/Ob9Og4knK00FhrQ0yvmVq6MEAPAsHvw8GyiS9cDaqUsearRDn9I8q95qTBfATAC4cDTzs1FxhZLb6eC2ZGbL1x4uUvHF4bPLVBBMOMGT5u3f8/O+KvfQqvNiP4ukIs9ui7QisCezsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3RAdzriZmTfc3bprE18GzvhAFQQreAKXPuY/TeNDFg=;
 b=U/Pvd7cp44vD+mbWguhcj+dXdcDbxTQcVAqoyX0uoFmmqO0AcvXVOorrt3IDIK03CvzRn4W5FtZfHcBAruYtXGg1Z5up/iZ5bCiVI2iPTwKDZ8Jh8IaGYJ5YTeUuJBIQLovwoMP9Ra00SZUInlVlsIq2txXbfjgy98S9wbY2XrV0dEnwo9h7tArPapMiNrMG0QSgq606pli830GYQuY9RB48XD6Zk1nwOA7oyQkyYttVlQsYD23krUSesi6EE01A1XuU9pZnKL4XseABf1KSz35Skm5EQ8qzwb4rJcxKuVxtCt90jLtPmHBD9uF2wX1QcrlsEcHGfguR/4T0NcVh+w==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB0299.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:16:31 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:16:30 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Thread-Topic: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Thread-Index: AQHb3p2yhsQhO66i3kSQkmuPrSQlU7QF0zjF
Date: Mon, 16 Jun 2025 14:16:30 +0000
Message-ID:
 <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB0299:EE_
x-ms-office365-filtering-correlation-id: 5a3e150d-94c6-4828-bee2-08ddace06403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?up+teBsA8WkPKLAfKra/NHPvKdBgh92Dt0O73Rj0ARdmucrsMcy6+dSUzk?=
 =?iso-8859-1?Q?KMrOrGJYuqcX8seDeUcAMwnuZoa1PwCazo13Fpzw6uT1lvAiad/njsCdHV?=
 =?iso-8859-1?Q?rnAQ6w9LdaKDNmbATmDPwoVglEFLtgtW/lKZQG/UyNt7wz4Q1ZR4OuTNGc?=
 =?iso-8859-1?Q?drkPYqPSriLV1SOMT3BxXCWbyRz710SVfnXv8KcpXsJALnMF6CJCkQIZTa?=
 =?iso-8859-1?Q?9UyxZQMt7DFvHmr3xYfMuY2M8Da4VndX6KY7PRbA6bjV672MKBLFH6jX72?=
 =?iso-8859-1?Q?EIaQShGmuaVBZuNRfyFaOv8O59zyLt8CeAmiO8EXlErHqr1iJ3eSn5jIlD?=
 =?iso-8859-1?Q?hj0oKfgx8OrDQOEtQ8ayc79CVpZWtaZgNTDHo6nUHF+lctjCUacL0I/ub5?=
 =?iso-8859-1?Q?NnglEuJgs1chNW4P1Xk7m+MBnNEDSujSWR9AEKHxYaFFJdz71OgHkWZW4k?=
 =?iso-8859-1?Q?QaMqQFjsIvH9kwbFTjjujtYiTYDE1r6Y5w3nKONQDhLLNsgC9IwWWsIRYn?=
 =?iso-8859-1?Q?lQXP3aYhV0Sdnlkau7I5tbX8n+tBCVS9VJOvILzJ9WWtDsOn+a3cOQIN49?=
 =?iso-8859-1?Q?ekW/oti6TM3t1hKedC4wVSyxvt7ReU/b2pg8TunC92NWnPfYEv8sdvXn3m?=
 =?iso-8859-1?Q?w+dFJlyYp4EXq+Tey6v/485FZ+g2vhpzWx+cNXhKYmvMmNLOvrSf8j3/EP?=
 =?iso-8859-1?Q?Ym0NW6qUZu867jQc9r7YryE7IuJVL+FkIOWwBnkDYau4tedxXQbl9bUwt0?=
 =?iso-8859-1?Q?3tZbirjllDU4ohThvfclIGpnNtD76gas86EvfH1bZFaG7k2OwpK2I4xolf?=
 =?iso-8859-1?Q?YVdoFe9MXg4uPshrCAWgmPUHaBIo/jinb6uNLLh5z1I6VNYf4+WKd1zSxk?=
 =?iso-8859-1?Q?NdOqmjECMbZFcCjwqIpif+QIU2hcbV2DkyKzt3Y87h8u8KxR+pj/RRqvSr?=
 =?iso-8859-1?Q?aU01NMnNE6wWD1m6DpM1Y/rtl/j9wQFkHYBf1rf/KWkQzpIH9Mz1of935W?=
 =?iso-8859-1?Q?NXf9Jq3KbCoALOF9S60qyjx0uEhLyeJCY/oa/8r3GC1+wvRJ8TFkz/ZZ+O?=
 =?iso-8859-1?Q?hmf57VUuV6DgCdRgo0pohTeubfKcdovtLTUYH/Y2CXM1qEmXPKAPt3XKLd?=
 =?iso-8859-1?Q?lrScPA5caJh5zbF/jXTdlPUiErx4b0Lb76UEwCskUZRzifrVL4nxoA/mUR?=
 =?iso-8859-1?Q?qwMtdlSpQCCLO9KO1M29+gqDiPg7eHiSvkt25rWPW+4Fs/Ew4BsOkP/W9R?=
 =?iso-8859-1?Q?nKjJA4+uYOKzKQVvtmogotbnFycbSBKXYwbaQjieQV+v59rzkIYUDZbC2J?=
 =?iso-8859-1?Q?QR/RgT6+VDbB816JwmnlZWaIwnwf8lOS09OpB4ewmUvZu7SVg+Eyo3c8QB?=
 =?iso-8859-1?Q?IIgtewwPIqWD2c4oBx7m7hUwJ6RAEjqGJrMJ8AENBHZmnjdPTpHlBiNW6X?=
 =?iso-8859-1?Q?qxcmZnLTpIbJxZYclpP1bk8HOX1+eCooZIjjJL484A3VHIFy7ohNAd/AQx?=
 =?iso-8859-1?Q?goOgOWXjByLbC6YpRv5yjnWx5rOM1WRab84g8JHphAfDdqb/iPDxtaptBM?=
 =?iso-8859-1?Q?v2HTs+sLhHcWjdM4UjieopC9RaC5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1g6+QmIQd8fpMwfYY5zJRg+IlfysiNJeCMPFlnP4PRsXVm7OEkKNUOCtU5?=
 =?iso-8859-1?Q?oUVet2RMLf6kfvWTOL9hrfNwz5blOW/D9RqN2a4v5qcMcHFif48fMgEhL9?=
 =?iso-8859-1?Q?3greVxtxOh/JyYszw0p8tG77RZsZ4dGE1hrFIqv27/D2Ej9SmMk3Mgm4op?=
 =?iso-8859-1?Q?Ary3Z5dr1oFbEWFfrVuJhAsKnKuG2UoMsJDWtmfMH+5VSy5IQa1NfzyiNT?=
 =?iso-8859-1?Q?6C6293Yj/W+Oz4DlSH8EU//AhAz37m6/wfQVg082yKx8/1W6bT6tiHkp/u?=
 =?iso-8859-1?Q?182wKjPowGVY40C2DVexNelK1m/d/pWM7nB6uv5khWjkDOWRfczgMKMtYR?=
 =?iso-8859-1?Q?4uCWNHKGh8rzlA7IF6UxB1AJOYgIpReyHxE9nUylOfU9e0vu6Vm8alnw+J?=
 =?iso-8859-1?Q?YzBtMivvFIzDTVY1xnlBaIOwiS+pQmiPM/GroValUe5WcMu8jcTQ5TZPvg?=
 =?iso-8859-1?Q?Uf7hVTI3LkGL4EoJUVnqCY7AufxlALFXOBTLKHA7HliZpt4TYaeBIyiiu0?=
 =?iso-8859-1?Q?yVXkqTgsMdtnpw58Jck8uRzVclOZFqMYJeQ1w2INnl4bpDKsjDPzjx8zmj?=
 =?iso-8859-1?Q?Dlda9v40/y5N45D6pv9Cgt55nqAN84T8aeJRZepsiy/kahtq6AC6bTvuOw?=
 =?iso-8859-1?Q?qOXU3pshwj+WH8e9sVfBFGglxmnh+Z0vYFrntUfcsf1o/eZPGz50rYQ5Dd?=
 =?iso-8859-1?Q?DrMDcXDLtxfKXHNDLfz2InNZPjk23ZMftkwE1nGRy+vqL8xLnk35qn8mN3?=
 =?iso-8859-1?Q?TF69wZ1Tv2qA7YOtn00q1Rcv3Ubel6qjktfPhE+x+6d1c8wvt6Kr/+Kqgv?=
 =?iso-8859-1?Q?6TAMy9vrJ0XTfl4tAcWRfgjk1uS0Apkf/rJwJhWSAs/YPJlsux6x+hsy4N?=
 =?iso-8859-1?Q?AVjcNrykTT1EOq/wW6l4cWzc/PL28FB5Kf2/dyQkBwc5WP2bASgUX+tO88?=
 =?iso-8859-1?Q?VqaGqBrC9vmJuAmLQLpGmAH3mAwTdVAaoRzEHUvvVtPAPQPdz6nHhfKI5/?=
 =?iso-8859-1?Q?IEKQHhqZleYHOUSmt0vMihlHR3IZ70x6n8O6m+/18yYSUz62ahzGaDxTnr?=
 =?iso-8859-1?Q?UZjc5lsNkxFg6hhdRav4cRv7l3LAE1moD7Kpmvyxya7sYyGEHtoSxF4nwE?=
 =?iso-8859-1?Q?YH84btRgMlgXt1uO3QIiqnMumVW6L+1cImRq/QOWask5t73ZBGMeJuQU/L?=
 =?iso-8859-1?Q?dKi5dFkxBuR+YHlZfD1BdxM5mH6U+SOQTzuVKBxolWvV1z37YD9Tdetz3/?=
 =?iso-8859-1?Q?oRLw+QviR39Qf2WSO6yPFk9L0GN7eLEa4oeUsiHpb3rPea9gf5RbUaRqXN?=
 =?iso-8859-1?Q?K+foTLa5229QlqYHH2cpzQylG0hjv/RMQll+a/bhBN5ZdJCPi1+KL2F3PP?=
 =?iso-8859-1?Q?583Lfuj9D4KPEt9K3fCgE/pqFfIaZXqZmPQIALSKZ7L14Rrib6Li7JIACR?=
 =?iso-8859-1?Q?j4/U1iUkAMAtkzbVgIBzREF6Ln9I7bIk5Gg7XH5b6PC86V0yeL2qYR23fI?=
 =?iso-8859-1?Q?cv+KwdgQHMXb2qpqF43sFOHoa+QY39qtOo1/PrYCU798FUjH45fPKobb3U?=
 =?iso-8859-1?Q?G7FnPp0FlskwjWo9sTWbsRr+pyXYTJqUeGF/nKpIDQP3n8BDXECObRd0LS?=
 =?iso-8859-1?Q?h4VQLPHy9AA/E2Z14+SPsQzDeY7s2s3hE5LfyAFvXbE/+5Tm0JIIsxzQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3e150d-94c6-4828-bee2-08ddace06403
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 14:16:30.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXpt61J97mEVxK5otmefRNOb7nLrXwoxanl9TJWfgSytrnSsNBF0wvycISKkF9QfG9+HMGYGKt67FfZisK5criIrPDBDjLMfD3Lwbkx1Itc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0299
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA5MCBTYWx0ZWRfX7Mtxb7kO6izz
 I94KI+47RcP+PET2yJ+ndA5oJUdjYvu6+G73DV4pDp2JRJ/mf6A17b/L5clqA9UrwKSuWb6OB31
 alBMzLJLUBEjT+UB4L3hdSjLIUQLFn7Kry4KELYMDpeedS/dTQIdRQJcwtnvpUeStgolyTkrMX1
 /rOk+KvH/Cl5N1PDsBH+T71/PCg6Ypw4nOwsodTlaVQ51UlFiB1kIdh7TM/dDvduVjg4SApQiSc
 N3fvEQdStgU0mzduUYqvsTyWzmTy/MI65b2C8c+RICKVcVI4ygzMgKk+HptMnIIyAnofOo4T/c/
 RwCRIrq1Zc6MCehVciYLvnxF0LgI7ioXmKPDqG7PEBCygoumpbrLMQ4Db4flrS2Om8Afzijher3
 p/dEgVRwF2W/HQ+25cU9Piixz9V+uPnhUzRLQv+SB+9Wb2Cl+/QREY3QZzTImaFnRmnyZYV6
X-Authority-Analysis: v=2.4 cv=BdnY0qt2 c=1 sm=1 tr=0 ts=68502744 cx=c_pps
 a=/BeNyiip3t3JC1UeaBVfzg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=4Jw4_Y53luBK_McDZBIA:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: lTPDXD8VB5mz7jQubgBVXWBVvle3atD1
X-Proofpoint-GUID: lTPDXD8VB5mz7jQubgBVXWBVvle3atD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160090

Hello Andy,=0A=
=0A=
thanks a lot for having done all the work.=0A=
=0A=
Do you think it is possible to add a fixes tag so it can be backported to e=
ase automatic backport of further patches?=0A=
Otherwise for sure all further fixes will have to be backported manually.=
=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
Sent:=A0Monday, June 16, 2025 11:03=0A=
To:=A0Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Jonathan Cameron=
 <Jonathan.Cameron@huawei.com>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maney=
rol@tdk.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-=
kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Cc:=A0Jonathan Cameron <jic23@kernel.org>; David Lechner <dlechner@baylibre=
.com>; Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; J=
ean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0[PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX in=
teger types=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
The driver code is full of intXX_t and uintXX_t types which is=0A=
not the pattern we use in the IIO subsystem. Switch the driver=0A=
to use kernel internal types for that. No functional changes.=0A=
=0A=
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
---=0A=
=0A=
As noted before the pattern is used in less than 10% files in IIO,=0A=
So it's safe to assume that IIO prefers uXX/sXX types over C99 ones.=0A=
=0A=
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  8 ++---=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 30 ++++++++--------=0A=
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 22 ++++++------=0A=
 .../imu/inv_icm42600/inv_icm42600_buffer.h    | 10 +++---=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  6 ++--=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 36 +++++++++----------=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  6 ++--=0A=
 7 files changed, 59 insertions(+), 59 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/=
inv_icm42600/inv_icm42600.h=0A=
index f893dbe69965..55ed1ddaa8cb 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
@@ -164,11 +164,11 @@ struct inv_icm42600_state {=0A=
 	struct inv_icm42600_suspended suspended;=0A=
 	struct iio_dev *indio_gyro;=0A=
 	struct iio_dev *indio_accel;=0A=
-	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);=0A=
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);=0A=
 	struct inv_icm42600_fifo fifo;=0A=
 	struct {=0A=
-		int64_t gyro;=0A=
-		int64_t accel;=0A=
+		s64 gyro;=0A=
+		s64 accel;=0A=
 	} timestamp;=0A=
 };=0A=
 =0A=
@@ -410,7 +410,7 @@ const struct iio_mount_matrix *=0A=
 inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,=0A=
 			      const struct iio_chan_spec *chan);=0A=
 =0A=
-uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);=0A=
+u32 inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);=0A=
 =0A=
 int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,=0A=
 				struct inv_icm42600_sensor_conf *conf,=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_accel.c=0A=
index e6cd9dcb0687..550eaa5a2ea7 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
@@ -177,7 +177,7 @@ static const struct iio_chan_spec inv_icm42600_accel_ch=
annels[] =3D {=0A=
  */=0A=
 struct inv_icm42600_accel_buffer {=0A=
 	struct inv_icm42600_fifo_sensor_data accel;=0A=
-	int16_t temp;=0A=
+	s16 temp;=0A=
 	aligned_s64 timestamp;=0A=
 };=0A=
 =0A=
@@ -241,7 +241,7 @@ static int inv_icm42600_accel_update_scan_mode(struct i=
io_dev *indio_dev,=0A=
 =0A=
 static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,=0A=
 					  struct iio_chan_spec const *chan,=0A=
-					  int16_t *val)=0A=
+					  s16 *val)=0A=
 {=0A=
 	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
 	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(indio_dev);=0A=
@@ -284,7 +284,7 @@ static int inv_icm42600_accel_read_sensor(struct iio_de=
v *indio_dev,=0A=
 	if (ret)=0A=
 		goto exit;=0A=
 =0A=
-	*val =3D (int16_t)be16_to_cpup(data);=0A=
+	*val =3D (s16)be16_to_cpup(data);=0A=
 	if (*val =3D=3D INV_ICM42600_DATA_INVALID)=0A=
 		ret =3D -EINVAL;=0A=
 exit:=0A=
@@ -492,11 +492,11 @@ static int inv_icm42600_accel_read_offset(struct inv_=
icm42600_state *st,=0A=
 					  int *val, int *val2)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
-	int64_t val64;=0A=
-	int32_t bias;=0A=
+	s64 val64;=0A=
+	s32 bias;=0A=
 	unsigned int reg;=0A=
-	int16_t offset;=0A=
-	uint8_t data[2];=0A=
+	s16 offset;=0A=
+	u8 data[2];=0A=
 	int ret;=0A=
 =0A=
 	if (chan->type !=3D IIO_ACCEL)=0A=
@@ -550,7 +550,7 @@ static int inv_icm42600_accel_read_offset(struct inv_ic=
m42600_state *st,=0A=
 	 * result in micro (1000000)=0A=
 	 * (offset * 5 * 9.806650 * 1000000) / 10000=0A=
 	 */=0A=
-	val64 =3D (int64_t)offset * 5LL * 9806650LL;=0A=
+	val64 =3D (s64)offset * 5LL * 9806650LL;=0A=
 	/* for rounding, add + or - divisor (10000) divided by 2 */=0A=
 	if (val64 >=3D 0)=0A=
 		val64 +=3D 10000LL / 2LL;=0A=
@@ -568,10 +568,10 @@ static int inv_icm42600_accel_write_offset(struct inv=
_icm42600_state *st,=0A=
 					   int val, int val2)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
-	int64_t val64;=0A=
-	int32_t min, max;=0A=
+	s64 val64;=0A=
+	s32 min, max;=0A=
 	unsigned int reg, regval;=0A=
-	int16_t offset;=0A=
+	s16 offset;=0A=
 	int ret;=0A=
 =0A=
 	if (chan->type !=3D IIO_ACCEL)=0A=
@@ -596,7 +596,7 @@ static int inv_icm42600_accel_write_offset(struct inv_i=
cm42600_state *st,=0A=
 	      inv_icm42600_accel_calibbias[1];=0A=
 	max =3D inv_icm42600_accel_calibbias[4] * 1000000L +=0A=
 	      inv_icm42600_accel_calibbias[5];=0A=
-	val64 =3D (int64_t)val * 1000000LL + (int64_t)val2;=0A=
+	val64 =3D (s64)val * 1000000LL + (s64)val2;=0A=
 	if (val64 < min || val64 > max)=0A=
 		return -EINVAL;=0A=
 =0A=
@@ -671,7 +671,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *=
indio_dev,=0A=
 				       int *val, int *val2, long mask)=0A=
 {=0A=
 	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
-	int16_t data;=0A=
+	s16 data;=0A=
 	int ret;=0A=
 =0A=
 	switch (chan->type) {=0A=
@@ -899,9 +899,9 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio=
_dev)=0A=
 	ssize_t i, size;=0A=
 	unsigned int no;=0A=
 	const void *accel, *gyro, *timestamp;=0A=
-	const int8_t *temp;=0A=
+	const s8 *temp;=0A=
 	unsigned int odr;=0A=
-	int64_t ts_val;=0A=
+	s64 ts_val;=0A=
 	struct inv_icm42600_accel_buffer buffer;=0A=
 =0A=
 	/* parse all fifo packets */=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
index aae7c56481a3..00b9db52ca78 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
@@ -26,28 +26,28 @@=0A=
 #define INV_ICM42600_FIFO_HEADER_ODR_GYRO	BIT(0)=0A=
 =0A=
 struct inv_icm42600_fifo_1sensor_packet {=0A=
-	uint8_t header;=0A=
+	u8 header;=0A=
 	struct inv_icm42600_fifo_sensor_data data;=0A=
-	int8_t temp;=0A=
+	s8 temp;=0A=
 } __packed;=0A=
 #define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE		8=0A=
 =0A=
 struct inv_icm42600_fifo_2sensors_packet {=0A=
-	uint8_t header;=0A=
+	u8 header;=0A=
 	struct inv_icm42600_fifo_sensor_data accel;=0A=
 	struct inv_icm42600_fifo_sensor_data gyro;=0A=
-	int8_t temp;=0A=
+	s8 temp;=0A=
 	__be16 timestamp;=0A=
 } __packed;=0A=
 #define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE		16=0A=
 =0A=
 ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **a=
ccel,=0A=
-					const void **gyro, const int8_t **temp,=0A=
+					const void **gyro, const s8 **temp,=0A=
 					const void **timestamp, unsigned int *odr)=0A=
 {=0A=
 	const struct inv_icm42600_fifo_1sensor_packet *pack1 =3D packet;=0A=
 	const struct inv_icm42600_fifo_2sensors_packet *pack2 =3D packet;=0A=
-	uint8_t header =3D *((const uint8_t *)packet);=0A=
+	u8 header =3D *((const u8 *)packet);=0A=
 =0A=
 	/* FIFO empty */=0A=
 	if (header & INV_ICM42600_FIFO_HEADER_MSG) {=0A=
@@ -100,7 +100,7 @@ ssize_t inv_icm42600_fifo_decode_packet(const void *pac=
ket, const void **accel,=0A=
 =0A=
 void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)=
=0A=
 {=0A=
-	uint32_t period_gyro, period_accel, period;=0A=
+	u32 period_gyro, period_accel, period;=0A=
 =0A=
 	if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)=0A=
 		period_gyro =3D inv_icm42600_odr_to_period(st->conf.gyro.odr);=0A=
@@ -204,8 +204,8 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm=
42600_state *st)=0A=
 {=0A=
 	size_t packet_size, wm_size;=0A=
 	unsigned int wm_gyro, wm_accel, watermark;=0A=
-	uint32_t period_gyro, period_accel, period;=0A=
-	uint32_t latency_gyro, latency_accel, latency;=0A=
+	u32 period_gyro, period_accel, period;=0A=
+	u32 latency_gyro, latency_accel, latency;=0A=
 	bool restore;=0A=
 	__le16 raw_wm;=0A=
 	int ret;=0A=
@@ -459,7 +459,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_s=
tate *st,=0A=
 	__be16 *raw_fifo_count;=0A=
 	ssize_t i, size;=0A=
 	const void *accel, *gyro, *timestamp;=0A=
-	const int8_t *temp;=0A=
+	const s8 *temp;=0A=
 	unsigned int odr;=0A=
 	int ret;=0A=
 =0A=
@@ -550,7 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm4260=
0_state *st,=0A=
 	struct inv_icm42600_sensor_state *gyro_st =3D iio_priv(st->indio_gyro);=
=0A=
 	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(st->indio_accel);=
=0A=
 	struct inv_sensors_timestamp *ts;=0A=
-	int64_t gyro_ts, accel_ts;=0A=
+	s64 gyro_ts, accel_ts;=0A=
 	int ret;=0A=
 =0A=
 	gyro_ts =3D iio_get_time_ns(st->indio_gyro);=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
index f6c85daf42b0..ffca4da1e249 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
@@ -28,7 +28,7 @@ struct inv_icm42600_state;=0A=
 struct inv_icm42600_fifo {=0A=
 	unsigned int on;=0A=
 	unsigned int en;=0A=
-	uint32_t period;=0A=
+	u32 period;=0A=
 	struct {=0A=
 		unsigned int gyro;=0A=
 		unsigned int accel;=0A=
@@ -41,7 +41,7 @@ struct inv_icm42600_fifo {=0A=
 		size_t accel;=0A=
 		size_t total;=0A=
 	} nb;=0A=
-	uint8_t data[2080] __aligned(IIO_DMA_MINALIGN);=0A=
+	u8 data[2080] __aligned(IIO_DMA_MINALIGN);=0A=
 };=0A=
 =0A=
 /* FIFO data packet */=0A=
@@ -52,7 +52,7 @@ struct inv_icm42600_fifo_sensor_data {=0A=
 } __packed;=0A=
 #define INV_ICM42600_FIFO_DATA_INVALID		-32768=0A=
 =0A=
-static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)=0A=
+static inline s16 inv_icm42600_fifo_get_sensor_data(__be16 d)=0A=
 {=0A=
 	return be16_to_cpu(d);=0A=
 }=0A=
@@ -60,7 +60,7 @@ static inline int16_t inv_icm42600_fifo_get_sensor_data(_=
_be16 d)=0A=
 static inline bool=0A=
 inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_data=
 *s)=0A=
 {=0A=
-	int16_t x, y, z;=0A=
+	s16 x, y, z;=0A=
 =0A=
 	x =3D inv_icm42600_fifo_get_sensor_data(s->x);=0A=
 	y =3D inv_icm42600_fifo_get_sensor_data(s->y);=0A=
@@ -75,7 +75,7 @@ inv_icm42600_fifo_is_data_valid(const struct inv_icm42600=
_fifo_sensor_data *s)=0A=
 }=0A=
 =0A=
 ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **a=
ccel,=0A=
-					const void **gyro, const int8_t **temp,=0A=
+					const void **gyro, const s8 **temp,=0A=
 					const void **timestamp, unsigned int *odr);=0A=
 =0A=
 extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_core.c=0A=
index 63d46619ebfa..0bf696ba35ed 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
@@ -103,7 +103,7 @@ const struct regmap_config inv_icm42600_spi_regmap_conf=
ig =3D {=0A=
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");=0A=
 =0A=
 struct inv_icm42600_hw {=0A=
-	uint8_t whoami;=0A=
+	u8 whoami;=0A=
 	const char *name;=0A=
 	const struct inv_icm42600_conf *conf;=0A=
 };=0A=
@@ -188,9 +188,9 @@ inv_icm42600_get_mount_matrix(const struct iio_dev *ind=
io_dev,=0A=
 	return &st->orientation;=0A=
 }=0A=
 =0A=
-uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)=0A=
+u32 inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)=0A=
 {=0A=
-	static uint32_t odr_periods[INV_ICM42600_ODR_NB] =3D {=0A=
+	static u32 odr_periods[INV_ICM42600_ODR_NB] =3D {=0A=
 		/* reserved values */=0A=
 		0, 0, 0,=0A=
 		/* 8kHz */=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
index b4d7ce1432a4..6ad15866c201 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
@@ -77,7 +77,7 @@ static const struct iio_chan_spec inv_icm42600_gyro_chann=
els[] =3D {=0A=
  */=0A=
 struct inv_icm42600_gyro_buffer {=0A=
 	struct inv_icm42600_fifo_sensor_data gyro;=0A=
-	int16_t temp;=0A=
+	s16 temp;=0A=
 	aligned_s64 timestamp;=0A=
 };=0A=
 =0A=
@@ -139,7 +139,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct ii=
o_dev *indio_dev,=0A=
 =0A=
 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,=0A=
 					 struct iio_chan_spec const *chan,=0A=
-					 int16_t *val)=0A=
+					 s16 *val)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
 	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_INIT;=
=0A=
@@ -179,7 +179,7 @@ static int inv_icm42600_gyro_read_sensor(struct inv_icm=
42600_state *st,=0A=
 	if (ret)=0A=
 		goto exit;=0A=
 =0A=
-	*val =3D (int16_t)be16_to_cpup(data);=0A=
+	*val =3D (s16)be16_to_cpup(data);=0A=
 	if (*val =3D=3D INV_ICM42600_DATA_INVALID)=0A=
 		ret =3D -EINVAL;=0A=
 exit:=0A=
@@ -399,11 +399,11 @@ static int inv_icm42600_gyro_read_offset(struct inv_i=
cm42600_state *st,=0A=
 					 int *val, int *val2)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
-	int64_t val64;=0A=
-	int32_t bias;=0A=
+	s64 val64;=0A=
+	s32 bias;=0A=
 	unsigned int reg;=0A=
-	int16_t offset;=0A=
-	uint8_t data[2];=0A=
+	s16 offset;=0A=
+	u8 data[2];=0A=
 	int ret;=0A=
 =0A=
 	if (chan->type !=3D IIO_ANGL_VEL)=0A=
@@ -457,7 +457,7 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm=
42600_state *st,=0A=
 	 * result in nano (1000000000)=0A=
 	 * (offset * 64 * Pi * 1000000000) / (2048 * 180)=0A=
 	 */=0A=
-	val64 =3D (int64_t)offset * 64LL * 3141592653LL;=0A=
+	val64 =3D (s64)offset * 64LL * 3141592653LL;=0A=
 	/* for rounding, add + or - divisor (2048 * 180) divided by 2 */=0A=
 	if (val64 >=3D 0)=0A=
 		val64 +=3D 2048 * 180 / 2;=0A=
@@ -475,9 +475,9 @@ static int inv_icm42600_gyro_write_offset(struct inv_ic=
m42600_state *st,=0A=
 					  int val, int val2)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
-	int64_t val64, min, max;=0A=
+	s64 val64, min, max;=0A=
 	unsigned int reg, regval;=0A=
-	int16_t offset;=0A=
+	s16 offset;=0A=
 	int ret;=0A=
 =0A=
 	if (chan->type !=3D IIO_ANGL_VEL)=0A=
@@ -498,11 +498,11 @@ static int inv_icm42600_gyro_write_offset(struct inv_=
icm42600_state *st,=0A=
 	}=0A=
 =0A=
 	/* inv_icm42600_gyro_calibbias: min - step - max in nano */=0A=
-	min =3D (int64_t)inv_icm42600_gyro_calibbias[0] * 1000000000LL +=0A=
-	      (int64_t)inv_icm42600_gyro_calibbias[1];=0A=
-	max =3D (int64_t)inv_icm42600_gyro_calibbias[4] * 1000000000LL +=0A=
-	      (int64_t)inv_icm42600_gyro_calibbias[5];=0A=
-	val64 =3D (int64_t)val * 1000000000LL + (int64_t)val2;=0A=
+	min =3D (s64)inv_icm42600_gyro_calibbias[0] * 1000000000LL +=0A=
+	      (s64)inv_icm42600_gyro_calibbias[1];=0A=
+	max =3D (s64)inv_icm42600_gyro_calibbias[4] * 1000000000LL +=0A=
+	      (s64)inv_icm42600_gyro_calibbias[5];=0A=
+	val64 =3D (s64)val * 1000000000LL + (s64)val2;=0A=
 	if (val64 < min || val64 > max)=0A=
 		return -EINVAL;=0A=
 =0A=
@@ -577,7 +577,7 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *i=
ndio_dev,=0A=
 				      int *val, int *val2, long mask)=0A=
 {=0A=
 	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
-	int16_t data;=0A=
+	s16 data;=0A=
 	int ret;=0A=
 =0A=
 	switch (chan->type) {=0A=
@@ -803,9 +803,9 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_=
dev)=0A=
 	ssize_t i, size;=0A=
 	unsigned int no;=0A=
 	const void *accel, *gyro, *timestamp;=0A=
-	const int8_t *temp;=0A=
+	const s8 *temp;=0A=
 	unsigned int odr;=0A=
-	int64_t ts_val;=0A=
+	s64 ts_val;=0A=
 	struct inv_icm42600_gyro_buffer buffer;=0A=
 =0A=
 	/* parse all fifo packets */=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_temp.c=0A=
index 988f227f6563..8b15afca498c 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
@@ -13,7 +13,7 @@=0A=
 #include "inv_icm42600.h"=0A=
 #include "inv_icm42600_temp.h"=0A=
 =0A=
-static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *=
temp)=0A=
+static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp=
)=0A=
 {=0A=
 	struct device *dev =3D regmap_get_device(st->map);=0A=
 	__be16 *raw;=0A=
@@ -31,7 +31,7 @@ static int inv_icm42600_temp_read(struct inv_icm42600_sta=
te *st, int16_t *temp)=0A=
 	if (ret)=0A=
 		goto exit;=0A=
 =0A=
-	*temp =3D (int16_t)be16_to_cpup(raw);=0A=
+	*temp =3D (s16)be16_to_cpup(raw);=0A=
 	if (*temp =3D=3D INV_ICM42600_DATA_INVALID)=0A=
 		ret =3D -EINVAL;=0A=
 =0A=
@@ -48,7 +48,7 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,=
=0A=
 			       int *val, int *val2, long mask)=0A=
 {=0A=
 	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=0A=
-	int16_t temp;=0A=
+	s16 temp;=0A=
 	int ret;=0A=
 =0A=
 	if (chan->type !=3D IIO_TEMP)=0A=
-- =0A=
2.47.2=0A=
=0A=

