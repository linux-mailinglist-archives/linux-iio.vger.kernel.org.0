Return-Path: <linux-iio+bounces-24381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CEB97785
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0F7428598
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DF30B515;
	Tue, 23 Sep 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ee1R0HlR"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011035.outbound.protection.outlook.com [52.101.125.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33F30AD10;
	Tue, 23 Sep 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658461; cv=fail; b=lmulWofSsi6gUqoAsiAgNJwr0ZgMqjEXgxH2bwDILUfP0hW7Lg/OVaCqivo+TrCQQVjwrO1dpERVvMhiWLW2s7Lm1mKCEcC1sMoN+9wfP7sx8cRTEUN7AVzcadB2z3YDrpxyUMBSZVFbZy0wlvKHjaqaAySAb+U+TwbVdk0HLps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658461; c=relaxed/simple;
	bh=UxabywQ3YNHDtO6eWWDEckeeJZ/dHxxUoWDC/BmBuiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GDuimlQd/DS/9ASSOqCe7CL0b/h071KEc2RtWpuxSd4B9vbuglisald20efbQacl76N8ZTpCqOwTYV9Fqo0/OTEz8K7u91qcSfJeo+vGDrzq5BYImySW+pLZkOJw24MztcP77xUiV4RtufDYO8C32TGrCcBLcPIkJbWtASlMEBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ee1R0HlR; arc=fail smtp.client-ip=52.101.125.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExU/4Agzfyvqcvy4UOCce0t8y4Fftzvfcee21cgIRuXqtR7OqUB1Av3+4tOMKmGe4pe9DH9VUTmf9iZWUSvKMTsPvTuC/d1+x0hhvmaow/ViYS8YpOtYufCDMq9hnSNbBa5aDRi02PNztUkTRTdQWTyXOb63I9xAslIvIdwsV9BBGJqMolohT4sxSYiIQDz/PSWEfQSpFetXlbldCb2/ZMZ/S5o3zu/FrZZE9DX15gMQMmabNtJQk0dD9+Ig3zpaytkE+kls1kuMmbsW4UZP1wZRgWb2BikgFUgf0K+c8KtyP616RaIku/FpFKgSowUmnvaEX0xLxXxwDgzD5ZuzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMVZ1HdFJtqtIMF62aFNzFFNQJLuhUSPnTBNh0HiUlo=;
 b=y9iBkxNcpIGR6IiTJPMQk8XC1unviDXc+IZkPEvTnY8TeM7O5VlEbZrJiabqvtsH8L8EXGjmg2zKPKYTCBN9oLSnP6f2uFosW8vOnVLD/FliiRYNOHZDaD4wL8hshhDx3keQaYqgEtKUQfv6AYDLtP0QSWUuqTxa5Z4x/Z14rbn5bpjL87EzNKesW+D3VOCCREDt7oOcY4ckgQ1X7TH3JPuv2RUGmGeJdtXgYkkPGUbn8Fl2Mz7N9Cf4izhjtsFts0BRr6aFF/UBvYCiIFi9aWZaRaFQXJ/kuvhTXH4EkXWfCvHwhd4aIo2LHWQFYmyDq0h30gEVOZqFp+bCJtE2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMVZ1HdFJtqtIMF62aFNzFFNQJLuhUSPnTBNh0HiUlo=;
 b=ee1R0HlRiqqNZfv9VzZJSyqtfAE38+yX7z5O61AcS8pLXsuVSSIHRHIMoYi8AHXUXQDI0ajJ+TeKP60ogsIbkJc5+esp297OWzkv/OzTNa7xi25iO5Jk9SMQzdWxBtDdsZU+hiZZ39WI7h7JmS0lKhsfOCsgHwq5liERAlb1bSI=
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10)
 by OSRPR01MB11437.jpnprd01.prod.outlook.com (2603:1096:604:234::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:14:09 +0000
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b]) by TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:14:09 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Thread-Topic: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H
 ADC
Thread-Index: AQHcLKP9NsNhN/CVKUaGUfMNrBDa6rShGiGAgAAR8wA=
Date: Tue, 23 Sep 2025 20:14:09 +0000
Message-ID:
 <TYWPR01MB88052B9ACC279F3C00AEAC21851DA@TYWPR01MB8805.jpnprd01.prod.outlook.com>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923-walmart-shale-359fb66133f8@spud>
In-Reply-To: <20250923-walmart-shale-359fb66133f8@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8805:EE_|OSRPR01MB11437:EE_
x-ms-office365-filtering-correlation-id: 60f5554b-5828-4621-855e-08ddfaddc14c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4t5j7f2PFwKRFhTvq6FSaBmF0lrnl8frP+LfOkM60bX0RjpGLOtVFzKLPb?=
 =?iso-8859-1?Q?YrAWAGJHeNx4lDApaLRDVm6fptI9Yex0u0z5uHjJemAW1WBF3cvuqHb4sk?=
 =?iso-8859-1?Q?dx0MXbOfJyxwC0FxmEMOsiOspnYENAlmqk5PR9U8S7E0ryT3KSx4qjB7Ux?=
 =?iso-8859-1?Q?m3vbCOC1v7AvVE4kL5B0XwHcixynWUQ9V5en7zLsruNTFO1oX7pCOvJgE3?=
 =?iso-8859-1?Q?hs7cYK5qC+5d6H4VgLwi1HNS1K0e6OYd8clAKFwu4OEE/CrMcuN+2Pmz6a?=
 =?iso-8859-1?Q?m07CULBYSwC0wN24Y24ULozi0axmBOv6vQR3AMKjjakunSn+uNbA2XUhJW?=
 =?iso-8859-1?Q?2wyqekS+uZaKwPIK/xcyVBuwml7uZ1MPnpBkB+gg4vfNPGUt8MhKO9kViK?=
 =?iso-8859-1?Q?lyU0nDfwrR+4XfbpNqkrqmfMAHM7acOOBfUrNif0W3ETnyY1/RX3o8C4fd?=
 =?iso-8859-1?Q?+G/1QRcb7blDwb/PgkUt6BHl/xsKvS8HEsJ8SzidqIln+HjEbbp08HqTuL?=
 =?iso-8859-1?Q?x90tVycTFN0m5zWhwWSS32bPLwnw0Cfoc7FVGgl8JkyrHiqsR/JAiP2YoS?=
 =?iso-8859-1?Q?IYLoEBGqOzf4vde+2oyrtjgZXTIYc4ypMk9cZtwpoiqlDni1NvWTzjzFoq?=
 =?iso-8859-1?Q?/QHau683IW6mpJ0srNO0/qGIsIIcFVs1EolsLwFckRrfbCT7nrh3MKTc5Z?=
 =?iso-8859-1?Q?KEoNEneTkLnibuC5e+rV2I0FmICIetXvv1BgYsHF0OsbMGwktI1kjAmSW/?=
 =?iso-8859-1?Q?JU04bf5B244a9WIYGrD5fbLvZSRaJ/K1svQ9J3quEEalcuUv/KTfHq3ZNx?=
 =?iso-8859-1?Q?yZhCRqWr0I9aQnWNNiZ94IpjdgG6oCP74eixvFwwhj11A/qYZ0n0t4y1ki?=
 =?iso-8859-1?Q?94DV7gidMUvNIwjTlbSbdaacr+nBsxY8NHbPdJoMLD1ED+2rR65SsHiTk0?=
 =?iso-8859-1?Q?m7VIIdwbyjr1ekmtVRk/VUoF9VEOx+gxRCyqCp7EEyJLzOYaPd/SW2oIDh?=
 =?iso-8859-1?Q?/jGpgf3he1KOZJHuqlwYAEaPn3ZzKiYP37G3e6QGMJjBSJtvi9CrSHL21x?=
 =?iso-8859-1?Q?xVtg4/UPOKI0Yuv8qeYCbFhGgtjXII/mQwgklsnORFZ06zZ+3QbmnH9T78?=
 =?iso-8859-1?Q?1C6HDCEq413QUOhEDagEmogVRzvZNCXGgWiVC4deErGZfHI1IE5jxkqgc1?=
 =?iso-8859-1?Q?0UhGPnzbRNwofj0jnTz/+mdwpFshxgT3PbmkZe6iliBNfgHQwgzGgnh/BA?=
 =?iso-8859-1?Q?yZ/woFhs/8PoXOsAR8Xq75Gogjq3gKr2Qk8nH5Dt+Df1BeM9TT+Bky5Vhi?=
 =?iso-8859-1?Q?yTflWweT0Pnu8odEe4UiscdQRPsWj0LiQ7AjNuBjlSAz9vHMiCzGgNfvn7?=
 =?iso-8859-1?Q?yk6vVM6CWtfwxuB5Umgfn2MjCP1Ry//0KK1X4ptjmp9dyoshiNLfGAJ7HL?=
 =?iso-8859-1?Q?nBG5cyA9eWslyhMZYTSPPeBgy3oC3AhZH7XI/ozhukPNh5gVnRU7id88eM?=
 =?iso-8859-1?Q?4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8805.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dtVZkFFFhiUMqe6gxYzTCdPseR858tRTeEoL+BEtQLTV+atxkxfWv33YyR?=
 =?iso-8859-1?Q?qNh1bUJk3C7TDnSqC1ST2xeg6CzJ2Rb7QY9IejAtmteG9dCYrpJJZ6uDfz?=
 =?iso-8859-1?Q?lxvrtEb0XpxwaJEHHRivByLpTAAjcW5AHSQB55kfMwoEWXFBp6wDPOCJ0D?=
 =?iso-8859-1?Q?GzqA1ghNkN9rFjMqLFGzThkVFGT6UgoGJYJnArQW3ysefeqIMqFLLLDVFQ?=
 =?iso-8859-1?Q?7Hh2OSSyhOoHbH7/+JIrpX8s5EcCQ6Z43ePs2yk9Y4caxWlxjOll1AeE84?=
 =?iso-8859-1?Q?40zsf520fMSH89hH37DRQVn7Xj9kTOd0C8NqXNDzh9vmavJWWIStihXF5q?=
 =?iso-8859-1?Q?kolEdu22AHGz9iIaaONCeatCYpBTZhTjZI1aPA5tOVqYzTSuXtJPMNeLrS?=
 =?iso-8859-1?Q?ESQYP/cWvtZBP5JD4vssohyIou64F+1jO/dHM8Twu4Ysqgw1toGxgnmt7B?=
 =?iso-8859-1?Q?XE5iHfp7Ryw5rXZ6aBwE7X2Tm1dQsZSehxYvHQZqkVrMcmFLawuDSeCYIZ?=
 =?iso-8859-1?Q?VMykYHN70KD56tIr5gRgvRp4EWmuQKsNWgnvw4ifUXhgaoyb0sDpPPEXW3?=
 =?iso-8859-1?Q?ohsuf/gIwQOrg2qFvBr1s8WiZ9Th6eZlWIDNNQ8JaMBq90naxKd3E7DR1H?=
 =?iso-8859-1?Q?Oca8YSbnAmsMs0vuHgo4V4VbVRk2nxxjGFz5sW3oU05x61OCGqWV6Jk5KR?=
 =?iso-8859-1?Q?KtZmdZhHu7rDdwwNrxsiLwhQo3aMjDSPSKBPwZucgI4GDwprDUt4uGOEaa?=
 =?iso-8859-1?Q?/e2W7tzu/cXHyS2H7Hy38hOdwml4IrnHYHd7pFCAiH+/dbuQJRe8x+tj15?=
 =?iso-8859-1?Q?6nrIqMCaAAVNlCmJFErTBBcwV51SfryhESsUtI+pgAHeZe4UJ+/yDFoGkW?=
 =?iso-8859-1?Q?9vRXHqZxKxLoaKlrTKqOe7jsd5jwbWtObjcjUJF/zPpuNlYF0I2IOG84Op?=
 =?iso-8859-1?Q?5Wnp0rrpEm4O8v3teCjSewG40JjnT0boPQ2TMhJExL+AqgrgLaya8A9ywj?=
 =?iso-8859-1?Q?zMl3sPXRhTaecc668ig0wy/vzEphV+M2b2ni7dbAEZcOGR/pXN7UP23o8E?=
 =?iso-8859-1?Q?NFy4ah/+TjEAVe62oemxLu18AkIAn0BMmPYh4KlCGGP0oAU+AcM6MKTnpV?=
 =?iso-8859-1?Q?5D3IbP6timcTZCv5eIo1JgrEgHT3rVZaXRX1AbhzWBl3YwE4Sx0k51muse?=
 =?iso-8859-1?Q?WmeoSUYX3wMdIuvTC/Q6mLnBvF1WCORSABOUhQ8hJzVhXcr6LwJRSAHBUI?=
 =?iso-8859-1?Q?HCEYX18jipB4lCnl7nakgyGajpk7C93a0khRbmDp/q8FYGM2GV/CtISJje?=
 =?iso-8859-1?Q?TKtPcWRDK9B1MXLCna5LE9FiWPTRebsa8yF+N+jqIMFROZd2Ju35hiW4zH?=
 =?iso-8859-1?Q?ZN8jlqkqQd5jswCbacrAAJJ3Yqmty5bkrvBpDiG6DxeQ05BicyiRF3EES9?=
 =?iso-8859-1?Q?Pmj1F79sLNxWoJ1nMZrzWTZn2Gy9LPr8wXqD1Y4X6/WMBGVjGH7w5+0w94?=
 =?iso-8859-1?Q?51kC8ebMa4M3qNMMlMA12OwMsY9mfoc1KUG3eJh8C6qmi1DL2fO8OEh6Jh?=
 =?iso-8859-1?Q?zM/IyBrPNxJyxlwh7vSE4gcS3MPrS9WrSHUF6gSFPmU3kLyqArV4TWb63p?=
 =?iso-8859-1?Q?4+/sUy4jIzmaMXK2FjFS21cl7fi2EL952Lx1O9cVD1nau3GtbJ+sr4SQC6?=
 =?iso-8859-1?Q?1IdNZ3YCW/rlc4/V6PQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8805.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f5554b-5828-4621-855e-08ddfaddc14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 20:14:09.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wEm7deHKy5J1lf6IGyFYmyWsY2vsHVhklq/l2goOVBxh6I9zTG9d0OyYsJa2VHDfwF1Hvjp7n+H63n2nYbLlcvIXwEIQB0lgGcElP47OvQLUhWl63HNZnXXd9BK+imE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11437



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, September 23, 2025 9:42 PM
> To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko
> <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm
> <magnus.damm@gmail.com>; Michael Turquette <mturquette@baylibre.com>;
> Stephen Boyd <sboyd@kernel.org>; Prabhakar Mahadev Lad <prabhakar.mahadev=
-
> lad.rj@bp.renesas.com>; linux-iio@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org
> Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2=
H
> ADC
>
> On Tue, Sep 23, 2025 at 07:05:16PM +0300, Cosmin Tanislav wrote:
> > Document the A/D 12-Bit successive approximation converters found in th=
e
> > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H has two ADCs with 4 channels and one with 6.
> > RZ/N2H has two ADCs with 4 channels and one with 15.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >  .../iio/adc/renesas,r9a09g077-adc.yaml        | 170 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 177 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g07=
7-
> adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-
> adc.yaml
> > new file mode 100644
> > index 000000000000..840108cd317e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-
> adc.yaml
> > @@ -0,0 +1,170 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/T2H / RZ/N2H ADC12
> > +
> > +maintainers:
> > +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > +
> > +description: |
> > +  A/D Converter block is a successive approximation analog-to-digital
> converter
> > +  with a 12-bit accuracy. Up to 15 analog input channels can be
> selected.
> > +  Conversions can be performed in single or continuous mode. Result of
> the ADC
> > +  is stored in a 16-bit data register corresponding to each channel.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,r9a09g077-adc # RZ/T2H
> > +      - renesas,r9a09g087-adc # RZ/N2H
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: A/D scan end interrupt
> > +      - description: A/D scan end interrupt for Group B
> > +      - description: A/D scan end interrupt for Group C
> > +      - description: Window A compare match
> > +      - description: Window B compare match
> > +      - description: Compare match
> > +      - description: Compare mismatch
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: adi
> > +      - const: gbadi
> > +      - const: gcadi
> > +      - const: cmpai
> > +      - const: cmpbi
> > +      - const: wcmpm
> > +      - const: wcmpum
> > +
> > +  clocks:
> > +    items:
> > +      - description: converter clock
> > +      - description: peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: adclk
> > +      - const: pclk
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  renesas,max-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Maximum number of channels supported by the ADC.
> > +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> > +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.
>
> What is the point of this? Why do you need to know how many channels
> there can be in the driver, isn't it enough to just figure out how many
> child nodes you have?
>

The idea here was that the SoC dtsi file would define the number of
channels supported by each instance of the ADC peripheral, while the
board dtsi (which includes the SoC dtsi) would define the number of
channels actually wired up on the.

Alternatively, we could have multiple compatibles for each SoC, like
renesas,r9a09g077-adc-4, which would only have 4 channels, while
the main renesas,r9a09g077-adc compatible would be the one with the
most channels, 6.

There might exist instances where knowing how many channels the chip
has might be useful inside the driver, but the bindings themselves
shouldn't really be addressing driver requirements, they should be
describing the hardware properties.

The maximum number of supported channels of each ADC instance is a
property of the hardware, which is fine to have in the bindings.

Also, it is useful to know the maximum number of channels,
otherwise, we would have to iterate over the iio_chan_spec
populated by devm_iio_adc_device_alloc_chaninfo_se() to figure out
what is the maximum used channel. We will surely need this
information when implementing buffered mode, to know up to which
register to read data from, and we already need it when iterating
over the enabled channels for the same reason.

All things considered, I think it is useful to have this property
here, considering the separation between SoC capabilities and board
implementation.

> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - renesas,max-channels
>
> This should be after patternProperties.
>

Ack.

> > +
> > +patternProperties:
> > +  "^channel@[0-9a-e]$":
> > +    $ref: adc.yaml
> > +    type: object
> > +    description: The external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number.
> > +        maximum: 14
> > +
> > +    required:
> > +      - reg
> > +
>
> > +    additionalProperties: false
>
> You don't include any properties other than reg from adc.yaml, and using
> additionalProperties: false blocks their use. Is that intentional or
> should this be unevaluatedProperties: false?
>

I don't think we need any other properties besides reg at this point,
and reg is the only property actually handled by the driver, via
devm_iio_adc_device_alloc_chaninfo_se().

> Cheers,
> Conor.
>
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g077-adc
> > +    then:
> > +      properties:
> > +        renesas,max-channels:
> > +          enum: [4, 6]
> > +
> > +      patternProperties:
> > +        "^channel@[6-9a-e]$": false
> > +        "^channel@[0-5]$":
> > +          properties:
> > +            reg:
> > +              maximum: 5
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,r9a09g087-adc
> > +    then:
> > +      properties:
> > +        renesas,max-channels:
> > +          enum: [4, 15]
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    adc@80008000 {
> > +      compatible =3D "renesas,r9a09g077-adc";
> > +      reg =3D <0x80008000 0x400>;
> > +      interrupts =3D <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
> > +                   <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
> > +                   <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
> > +      interrupt-names =3D "adi", "gbadi", "gcadi",
> > +                        "cmpai", "cmpbi", "wcmpm", "wcmpum";
> > +      clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
> > +               <&cpg CPG_MOD 225>;
> > +      clock-names =3D "adclk", "pclk";
> > +      power-domains =3D <&cpg>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      #io-channel-cells =3D <1>;
> > +      renesas,max-channels =3D <6>;
> > +
> > +      channel@0 {
> > +        reg =3D <0x0>;
> > +      };
> > +      channel@1 {
> > +        reg =3D <0x1>;
> > +      };
> > +      channel@2 {
> > +        reg =3D <0x2>;
> > +      };
> > +      channel@3 {
> > +        reg =3D <0x3>;
> > +      };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9f4b48801879..07e0d37cf468 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21822,6 +21822,13 @@ S: Supported
> >  F: Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> >  F: drivers/counter/rz-mtu3-cnt.c
> >
> > +RENESAS RZ/T2H / RZ/N2H A/D DRIVER
> > +M: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > +L: linux-iio@vger.kernel.org
> > +L: linux-renesas-soc@vger.kernel.org
> > +S: Supported
> > +F: Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yam=
l
> > +
> >  RENESAS RTCA-3 RTC DRIVER
> >  M: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >  L: linux-rtc@vger.kernel.org
> > --
> > 2.51.0
> >
________________________________

Renesas Electronics Europe GmbH
Registered Office: Arcadiastrasse 10
DE-40472 Duesseldorf
Commercial Registry: Duesseldorf, HRB 3708
Managing Director: Carsten Jauch
VAT-No.: DE 14978647
Tax-ID-No: 105/5839/1793

Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.

