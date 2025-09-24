Return-Path: <linux-iio+bounces-24401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB1B9997D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C782320E1E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191C2FDC4B;
	Wed, 24 Sep 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jeHpkvGl"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010018.outbound.protection.outlook.com [52.101.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981592FDC49;
	Wed, 24 Sep 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713627; cv=fail; b=exZDkKR6047mUcdPOH3tcGdBqRDdtGaY0AL0koHwtB/MdNWR5H0MO/r0XeGF6u0d2MSHRaD3wiQeQpc5qCKbgh/kCKFGDE3IYmd7IrsD2a0FlbdQ6E17YPVstOdNgAzKoNfBHyw/mmi8knH6Mo656b859oBwD94JxHcSeSWvTnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713627; c=relaxed/simple;
	bh=9XuSkl7YHra9+nwRWSs8PjfbKkKNbahIrcKrx8WC4rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tlpixl0DDyPJJUxLsyrwtACmGfWJUnP7cXR+JosGdIlv2aL5taJ/dAJMbbSLsLhapoWIrr39qhyIRn2eNczJ0jEsHOrm5VW7NtDHVtYT/AxB4ZmeziHSSgNvvjB+qHYwqDNCCzpB0TkO+i1gAOhqe4YQ9xKPOWAybGehkVdvYI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jeHpkvGl; arc=fail smtp.client-ip=52.101.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/QlMOKNuCodQlrT2Dlj7EX2BFqoA9SB6nlw9sN57APAukBtn+lg8X3uMduux/k+76dDDaoJl3K+kyrAYQiPDf0vCNgPc3y6WpwLKqFVbnuWxxOwzOgCUmZNWSFyIc2hN4TdunEVeb1k3ClxyxOonqvvVpbhPm7AHWpJgg7yO5JptNv/uJecTzhXpzt4waJJY7RBaqDGKXW2DgC4OK7PMgGd/iQQ/ZpLdUK7Ld8CoqubXt+p7q73xZ+FNAnpW4hrikk7mNwwR9TxQOAZBCBGoKpTph4BDEYf0aExP62eJX9W4P7VdTEQe8ygjeckzsqb4Ce2n2JIKAza+CGi9+a5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0GEbAikADw/iIvnk9GfRaSwCP5DCxRat2xpJAixwzw=;
 b=vRu7THb24IwvSq75IRgRHHmrSDv3B/sAzWAP1rxpYXEUlkkiy5nGySMOyAAnL5bL+LHxwjzFYOsbia50H5TRjgKWb52DNAWBKhnvMmL6PknaFbemqRUqFQZ5zwDKfmHTtspdEVqtFa9AXEk2QvhBTivjNlPr5M0fhwMHMoXdHgPlyTwB0j7F9Bck8MmjNk6k6EefFMa9Z5v7tt5oZtRzqIWg3SXw3OLRe/BsuprbamWzK/KxPnAmtiHPYwn/lChN9WgrwYx/hMTbwP+Nl9sPeVT1Bzv6vHpcl952eRUElxROly4BDVPc0jZi+Q8jdZy3EbAUMXPBI2f/UpplnBRSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0GEbAikADw/iIvnk9GfRaSwCP5DCxRat2xpJAixwzw=;
 b=jeHpkvGl6ZzbebQPdPn+PM7CnF98UN0wUzJT40Wip0REeofe6ngA2fjXKRdhVNCSzF2XfIFwKQ4kpImaa3JJ106nTrfCTq/SGsmaxwRFY3le4+iB1p5rf0JrnxEmY++jYKDoYTC+VFwJw578WK99KfC0EAqEn42hxhNSdX6ktZY=
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10)
 by TYVPR01MB10893.jpnprd01.prod.outlook.com (2603:1096:400:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 11:33:35 +0000
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b]) by TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:33:35 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
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
Thread-Index: AQHcLKP9NsNhN/CVKUaGUfMNrBDa6rSh9ryAgAA1ukA=
Date: Wed, 24 Sep 2025 11:33:34 +0000
Message-ID:
 <TYWPR01MB88052A16F01666B693EE28E3851CA@TYWPR01MB8805.jpnprd01.prod.outlook.com>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8805:EE_|TYVPR01MB10893:EE_
x-ms-office365-filtering-correlation-id: 42bbb16b-558a-4b49-eb22-08ddfb5e3271
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6YXFi8aayvFo70bXLSqdPidWMONoAQNAV/JCHgT2xUvL4ugIwB//iWkY21?=
 =?iso-8859-1?Q?5HXVREtdx0osR02W6vzvgDci50xLowP8Y9HOze25AIoTJUOuNm3D5wh/65?=
 =?iso-8859-1?Q?0K79n6rgrj8WQd78qRa3kRYgnwa0tip0hMGEDTMLAShU9r+PRRE4bLHGxl?=
 =?iso-8859-1?Q?QADUMEZbHZh7r9T4AM9Z7AbWRHJrjRMN+2nx8ryd7C3ELcHp2uRM9RIRgL?=
 =?iso-8859-1?Q?1zMUteTlok1yAxbGLG72UMGU+Sn1nbQjW9BExeFSUlKk1+GuH8Px8KKOP3?=
 =?iso-8859-1?Q?4bgMJMI2k/5ktkDIoggUWAn5slWe/eIOfFMc51TquoTr+89ZXPsJP6cpo8?=
 =?iso-8859-1?Q?1VQJnAAI22GefzZ0qgxOt9g95DHGbBKvLYOmKjsa3CX4813SUZaRPJZ8g6?=
 =?iso-8859-1?Q?LTadf6LQr1EyPeK5Cw+ifipyWAaRqT64ULwmr3YkcxuVaTWrfSqjTNDJCK?=
 =?iso-8859-1?Q?452XAEkBj5WHPNYNoefvuDsM1mq2NFls2cL9yMH4qa/3/RXKyIXIFTfXly?=
 =?iso-8859-1?Q?z1AECN9ai3PZnI6+cQTz+8RdJ8ayAtAoUdaXsez+13f7bvUl7JpGa44ucZ?=
 =?iso-8859-1?Q?OOZPkp/TIxwm5YUrcY6MDHs8uM4Zh2eUlNTDAjghDZeGRPBK47ylfuR/2b?=
 =?iso-8859-1?Q?UZkO4adhT3IY+VR8JeNVkGjI1tByzVG5wyFK1kAjmM862PtJT3jOtDPpgC?=
 =?iso-8859-1?Q?TlrWjCelyMCKufrICQnpLVDyME7itiNt+yKDtGCVYnJy4HjrJfw/WjmdOi?=
 =?iso-8859-1?Q?hFXVu6oGAHuVy7YSkaQZffD8DvCdM9k60gs+HS4Sklk2LplQiNU4WcaxJq?=
 =?iso-8859-1?Q?G2ey3fHvVDT1sWgoUpUNn/7whWRCT5ydtHCknUqYovRYdDu0R14hhqrNSZ?=
 =?iso-8859-1?Q?8y1WRP92vKF5h0sMDzDoHNk2hB1KEDAbFGkIzPuzVA5d8DVlAjjH/SdcKn?=
 =?iso-8859-1?Q?t/gp1IcnR6M/8A/Q3N2zgsG6sN0B129iJLdsl82Y9zIAucbGp9TzsqIbjo?=
 =?iso-8859-1?Q?S03xwaz8NMpOUp/EX2OLzej5HSjE696JfdL4eiIzjdcVvszIsCw7enMUlc?=
 =?iso-8859-1?Q?/QP9PQrB5Q3xHCvY+yKGl5imN1WEPm5B3jBXk8/BqT+juW7Yd8KW6Go46F?=
 =?iso-8859-1?Q?TjQoEk3+9ssKpKxv5FXnrWdxycT+/Op6rLg/zKvZK9RcyreeNsWi+4f9ry?=
 =?iso-8859-1?Q?BGc8/oIRvUlKxE93OuiEVcHiQdmKb2DddVyGM6lOlGRypT5A8Z5o6Gt3CH?=
 =?iso-8859-1?Q?FoH14kJi1fwhh1q5AbiX+KnTJr9/kcFsJa3zsyJRUhgkhPzFv4iHDr72SY?=
 =?iso-8859-1?Q?t3IFcEudSw4JugC6cdg7/jsqF0aipgjcD4l9e0DvUGBqX40Va1HSiSkqbe?=
 =?iso-8859-1?Q?AnaSG1xnIPRBTVL0KepKw5f8KEx3PE7y6fK81uLnkEAPG8dNntPEX185R7?=
 =?iso-8859-1?Q?UaDOu2zhjp2SaksPc/tCBmds+nsDWBWsF07GnL5ShvnZarQHZmP1TvkMef?=
 =?iso-8859-1?Q?E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8805.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BgGmZCP6mlXbJd2LjPiDgGmG9hMtixoSed32hcOiVQmOEIVdz9k0p8gLYO?=
 =?iso-8859-1?Q?Z5762rI4uSFc7w27nioSut/phgn+kkek62PyD8XkV37/fnkpBwYjd1xA+H?=
 =?iso-8859-1?Q?k7oVayDqYMEfeDx1VvMJ4uLqnfp2Bv9HbYrARHii/T6ZofWQGge07a3RJd?=
 =?iso-8859-1?Q?3bFhmwyN4zFFLbvmCMBwZTPJGn/sMw+8qPqB4KcOfSfR32QiWqHoQzWKNw?=
 =?iso-8859-1?Q?IgWzYMnLdG/O5IhfmHDH31dr8Vj9FBYMbYYbIHHuCXFjX/RlZz0fgKGkOF?=
 =?iso-8859-1?Q?Rudkq7A1r84PEesfZaH/goJ4lpR+g7MF1ZNb3n38U31dzfE/sOexMKo7s5?=
 =?iso-8859-1?Q?H2JZqGoJj67yrcVAUuIrZsL2K64f0uimqWWDyBRFZylYrHJ/BwiwL7rAKR?=
 =?iso-8859-1?Q?mFHgDzuCd9oANVmscbJ/hpmp4OjnznOaSarycLXXKzsACG67vpBf4RiWlM?=
 =?iso-8859-1?Q?rWOM/BQrZk+jRhQHfTeLSyPAVStSbkWqdcMJt0wlrTz9msT+tyNSmnd9J4?=
 =?iso-8859-1?Q?9txLn3BgZ1FsbYpnW2HpRrbLrhjhui6svjEndIUPPk1+yGhRLtrRa2rAic?=
 =?iso-8859-1?Q?Ll7t0ljneLvVKIsLH8thYWfXtOFkMbBzxzICBJXATWdmkWuKY42W+67sPx?=
 =?iso-8859-1?Q?OzSYaheycunTOhGh2TTqXM39a3vuLoA2AaoerBKgBYgoLgGwHrowUC+Z9B?=
 =?iso-8859-1?Q?41u0bxC+b/j/GavC4KcJhtSSZsN8Pr1QWlvAKGpAlzjD1MX7MHAL/Z02RF?=
 =?iso-8859-1?Q?qEJHmcBzESS6mYGfHKumOXRPft4Rqpd97WyJBjzDT+oUjnib8LhWWUMqb5?=
 =?iso-8859-1?Q?ofFBOcHYdOiLJW/5jzL8yTKQXqUjEBsQ2nSYOvOhCFv2EMjo1mcT3CkEj8?=
 =?iso-8859-1?Q?gXGkKRLukUbjlUtsO+yTkeZLPxr9+6wZsXkOEhwr0XkPsMkCJYZHFGiPVH?=
 =?iso-8859-1?Q?A08BUpgOTlsR+TK/QcQ5x/r1OgHYnk+UrcuYEfGk0SkWlwQ3dvCSQtmuhO?=
 =?iso-8859-1?Q?m3ghMkczIldj32qz7l2VQHatR9zec1eGkH1GsIPYcxOLKMQ3YxttI4y+GS?=
 =?iso-8859-1?Q?kITmv6QmpGaBdRkkLNbe9tSKHbPNQJRr0c99XnYcE73RO/EAuKtVmxLNvL?=
 =?iso-8859-1?Q?+UvNDJIS/ftwXBeUpgPlVPm/f6Ph+FD0tNJc8svUbpfpUdzBt+w9NOoWlG?=
 =?iso-8859-1?Q?qQN5WlepCgU4RcBloXO9/OaiHVYndbJxbdqGVRTa8PRdezRR5nrm6199w0?=
 =?iso-8859-1?Q?sMC5tXqtaMYa6L6U4TNLfkSBk3ZBLYjhoC3GaXKHtj16UDZg8YzpB5kgQS?=
 =?iso-8859-1?Q?NUDxRbLt/ZYsX+j2L5kJEHrje/N9iIXx12FWUSTp5aCndCuv9asAFKB+fX?=
 =?iso-8859-1?Q?s97LppvqpDO9+xJugnST3Z++LrmfyYWiagUEUNRCYhbR5/aqoBAMQV4AaB?=
 =?iso-8859-1?Q?2ACUcBaNkPnGRIx4Pqqo3ERP7qK6MOMzl21U4EwHiOhZR4Nju+LU34RQsH?=
 =?iso-8859-1?Q?kotg55hwy+3dXKR7V0ROm1UcA4u638Hr2q7eG+Wm6aDBPJn/9YR8FgKRn/?=
 =?iso-8859-1?Q?pra6nLnnDfVcZIY1SeFPofO4aySP65uAZFub5ozR9TJvWHF7leJS1xq37y?=
 =?iso-8859-1?Q?t/UxRvKFoN8YM6CtjyxcGdkjRkCPYszgWL1ds6NxsjP3SlP//1SbSgejz1?=
 =?iso-8859-1?Q?gGJlWgeAjFAX84iV51M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bbb16b-558a-4b49-eb22-08ddfb5e3271
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 11:33:34.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zff12XXF/agNcez0AishFNNZ8O4XC8baP3EutsIxelWkqjZlWhvUT4A2USCubof1toLedhnB/FkeUIVhgxZGlCdUcEKxiR8nPzvVVrxI51bOORdz1WmbhLEOs5hykW61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10893



> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Wednesday, September 24, 2025 10:51 AM
> To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner <dlechner@baylibre=
.com>; Nuno S=E1
> <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Rob Herring <rob=
h@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Geert=
 Uytterhoeven
> <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.com>; Michael T=
urquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Prabhakar Mah=
adev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-iio@vger.kernel.org; linux-renesas-soc@vger=
.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-clk@vger.=
kernel.org
> Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2=
H ADC
>
> Hi Cosmin,
>
> On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
> <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > Document the A/D 12-Bit successive approximation converters found in th=
e
> > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H has two ADCs with 4 channels and one with 6.
> > RZ/N2H has two ADCs with 4 channels and one with 15.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.y=
aml
> > @@ -0,0 +1,170 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> http://devicetree.org/schemas/iio/adc%252
> Frenesas%2Cr9a09g077-adc.yaml%23&data=3D05%7C02%7Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7C8c536bc422b9440a018708ddfb401335%7C53=
d82571da1947e49cb4625a166a4a2a
> %7C0%7C0%7C638942974801495945%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR=
ydWUsIlYiOiIwLjAuMDAwMCIsIlAiO
> iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D0zAY5VAR=
xHP%2FN0wV7Gv1%2B9DZi%2Bg8JzBbi%
> 2BkzCDdN59M%3D&reserved=3D0
> > +$schema: http://devicetree.org/meta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7C8c536bc422b9440a018708ddfb401335%7C53=
d82571da1947e49cb4625a166a4a2a
> %7C0%7C0%7C638942974801538982%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR=
ydWUsIlYiOiIwLjAuMDAwMCIsIlAiO
> iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DVlYwNJVc=
7W%2BnLFKHf%2FG2Gk0HfWSsQ58cR0a8
> fQpckwE%3D&reserved=3D0
> > +
> > +title: Renesas RZ/T2H / RZ/N2H ADC12
> > +
> > +maintainers:
> > +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > +
> > +description: |
> > +  A/D Converter block is a successive approximation analog-to-digital =
converter
> > +  with a 12-bit accuracy. Up to 15 analog input channels can be select=
ed.
>
> The documentation for several registers talks about bitmasks for ch0-ch15=
,
> so the actual hardware block supports up to 16 channels.
>

Maybe the hardware block can support up to 16 channels, but on T2H,
which uses a 729-pin FCBGA pacakge, ADC2 only exposes 6 channels,
and on N2H, which uses a 576-pin FCBGA package, ADC2 only exposes 15
channels. On both of them, only 4 channels are exposed for ADC0 and
ADC1. As of this moment, this binding describes the ADC hardware blocks
of T2H and N2H, why would we use 16 here?

> > +  Conversions can be performed in single or continuous mode. Result of=
 the ADC
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
>
> Converter
>

Ack.

> > +      - description: peripheral clock
>
> Peripheral
>

Ack.

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
> According to the documentation, both SoCs have three instances?
>

Yes, both SoCs have three instances and (obviously) we've tested all
of them, as they're exposed on the evaluation board, as defined in
the dts patches in this series.

T2H: ADC0 - 4, ADC1 - 4, ADC2 - 6
N2H: ADC0 - 4, ADC1 - 4, ADC2 - 15

> I agree with Connor that this should be dropped: the same information
> is available from the channel@N subnodes, and future SoCs could have
> gaps in the numbering.
>

Ack.

> FTR, from a quick glance, it looks like this module is very similar
> to the ADC on RZ/A2M, so I hope we can reuse the driver for that SoC.
>
> > +patternProperties:
> > +  "^channel@[0-9a-e]$":
>
> 0-9a-f
>

15 channels max for N2H, which is where 0-9a-e comes from. f is not valid.
Do you want to document 16 channels on the presumption that the hardware
block has 16 channels, even though only up to 15 are ever exposed out of
any SoC currently supported? This can be amended when/if we add support
for an SoC with 16 channels using the same ADC IP.

> > +    $ref: adc.yaml
> > +    type: object
> > +    description: The external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number.
> > +        maximum: 14
>
> 15
> But I don't think it is needed, as the dtc check for non-matching unit
> addresses and reg properties should already enforce this.
>

Other bindings have it like this. Is it not worth matching the address?

Can't ever have enough checks.

> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
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
>
> 6-9a-f
>

Same as above.

> > +        "^channel@[0-5]$":
> > +          properties:
> > +            reg:
> > +              maximum: 5
>
> Not needed as per above.
>

Same as above.

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
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

