Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1E3F2DA1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHTOE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 10:04:57 -0400
Received: from mail-eopbgr1400101.outbound.protection.outlook.com ([40.107.140.101]:34001
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235032AbhHTOE5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Aug 2021 10:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+6+Juqs+FW5QoC+lj/A+1H8JmOtbKGkqMTijpd9SgYKAwAoWtC+KgfWhp+MgHj0B6jZ0sUWpmM0hOQ0nUqwmnvS/XD3yf0A/v1wXjglb852GrYSkOsJ4XqkBLSKZrQZYxQOVSBi1qafhaUiAtkNyM+tgEF1sKH3skRSqfPcPhljSPcckFTyLOy9gNxxrbvDuMIxBUk25/3Lbb7LgSQgKAy5wXlX0NY3GdAOT3kFYc/vog/cZWWIm40E6yBjNba8GUNwrpmdv5fwasio9hTqhypocKiTHmulvjPnJsLkHt/as2jpk3X2FrC4NAv9XCSvqSocwrCJIrsCjWvYGKIm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj7qzPXE80jWqhBP/uROsdYirQQErFFTRSzAMtxmYfk=;
 b=YRQajsAwikozwJfbZ0aysXvTKiGn9kwWyYQ9e4hDgulw4iFH5+Fp88LGZurl4pqzJI6KoapBm95ZPr4Smb+y6QU3C3gKHDafLsE2bQLKQnFPqluJkfxUZecjKb9TVquONq2YjedbcwO6dMylraDY7RipNIL4Em1NPt0/MDX3omJY5dSCsGEITdjJibj+wfz3vjADoc/Nkziyt9x3cmwPNXfx0GrbmAq/h0V66IDYwme1c6eXTNhRpfEorajgq7e/XQCgs5vPDBJmVMIyCHsId375hLQr9LdMPl4EtdT7HosV2xD93Qjy49DMuYc+yDB6ft7J0hA0JtbiM8/U1xczmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj7qzPXE80jWqhBP/uROsdYirQQErFFTRSzAMtxmYfk=;
 b=plShR1IKwr3GNfTnLfsiUHocJMKJWSnXTX+dW23Mh0yaXWMtk0iTvHSvQYqDnqj6UV2ks2djf4Ga/9t7le1s7zVIItTRa4dTpvBS0NHCIFlp86WNFsDKa11WsorB0M+bTmmzgshT6aIhgdPe4ZeASnjgir+EOZaOhyidzV5jdJM=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2546.jpnprd01.prod.outlook.com (2603:1096:603:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 14:04:15 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::dd31:23ef:4263:e86b]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::dd31:23ef:4263:e86b%6]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 14:04:15 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: RE: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Thread-Topic: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Thread-Index: AQHXlPy2YbhEf+HCwkmd/oSp43xT+Kt8bbDQ
Date:   Fri, 20 Aug 2021 14:04:15 +0000
Message-ID: <OSZPR01MB7019F9AF40E5E8626DD0E168AAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20210819132416.175644-1-yangyingliang@huawei.com>
In-Reply-To: <20210819132416.175644-1-yangyingliang@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d674edad-aeb0-4fc7-ebdb-08d963e36531
x-ms-traffictypediagnostic: OSAPR01MB2546:
x-microsoft-antispam-prvs: <OSAPR01MB254673CA5716D4A9030E4186AAC19@OSAPR01MB2546.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3r6GDgVwSHD8WZWlvNFRvPZxlqoviAxZ3rtVWa+53hG9LZr4omY/6jiecGEe7TcWDwIDYUH7c0rlidkI8Cq4QWKedRFcKPXuB8SUOfA8DPaUJDkcLaQYXm4Hg1ctDgiA4Nj7FO9inuHTBchrOEoPBwWBBoSZAp/Gc/eC4tHm5bBUKVB8GMuIyp/Yu6P4KJ8eApkYrhDpsw48R4YPRELGMNobI1dMfQtTQHGhJ0HzUR2tL8z+helV8E9uFCgB3XN1KmQVs5HwtkMCb4Owsb4BJy92X8q2+O3YLZ0813WWkXx11YlXsANkEwBiRJarNVYnil8pJ/BoIGh6soMctfXCDH748mhZ1f+a72khVsK2RTHYGKF2xfZeDTnlrYQZmsgoPPbJb4BytnlOrooPWmlRLtXcco7bD5xJMIVi3jVKsTI5WbZbvG8n4drxZmDLDH3i2rlk07BjoJBcWnZd6rzO9d3lj9LbLCCjFltY0EPv5LUIWdCIUmngyhFFSO3+lvIl92FCMIr7VGbki1gVNP/117/JHfwu7IUdudUfbydt+IhUpJa59GLJenbn9OYxWkYQ+Dw+ElAcRqAU/1KiRTtREkl8s/Pood1A7oxeu8rovUQEaZkR4JJYZuk3OuEKdFI/S+8YrJ7iYhVkWuYaztumOcqin0VnVVbu38gYBvlohvCTZQgd96bK5C3YLtlboBBv+ScCGGfN4Gxbpym7mMV7gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(52536014)(38100700002)(9686003)(66446008)(66556008)(66476007)(64756008)(66946007)(122000001)(38070700005)(478600001)(8936002)(186003)(76116006)(71200400001)(5660300002)(55016002)(8676002)(33656002)(83380400001)(7696005)(4326008)(6506007)(86362001)(316002)(2906002)(53546011)(110136005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kPFm7TYjTblNoVH5uPGoF2JxOld0QlV0Pv2/GGcA6T0R4sdytuSlSWnBvbLM?=
 =?us-ascii?Q?AkUBlfYiC+Vg+SCbHOpZdOpSUkHA6V7E9ikI2tfXzWYlO8v9NoCgqfI60Itc?=
 =?us-ascii?Q?0N+JFS+XdGivCABpcEv6CpyRBemO5rnkW7eHWCCVhfU9c4ZagtA8W+KaGWBB?=
 =?us-ascii?Q?9dPgpJySAXkqt5TW+yhGp5tfcDOc501+jTrQO1RJ1VDgCe176SPBC+0/7I+C?=
 =?us-ascii?Q?LDYmZDpIRyTamgB+FhXkmYmyTwHF4gj1psA7cyGn+vNIGW9ewmgugJNorgoR?=
 =?us-ascii?Q?4so6s6PznQGzdScTo6Hx61IXlWuNTbGAJ+qpMn3XD8j6vkm/MO2qQJ4ef9Od?=
 =?us-ascii?Q?PWVzIVq1JrTzLaRBPHasiBQJ7M2jJ0DT/hEyfliroCzpf3T2aOHQU3MJsmHb?=
 =?us-ascii?Q?8KPBgFwFpRQx1u5G192/V0N0ivF3lroUVgi3PIXuo6NJTk8L1/LOzlbeEW+r?=
 =?us-ascii?Q?aRKS1pgDBWC+3GwvIbL6RBlmW1HpdNEXi8le6yco4D1KxJm//EJF2uhGOvsO?=
 =?us-ascii?Q?lCd/c3bDyp1lTbnvffJTEf1hy3LoC6FXCTYprKVy1pZtlYjMHHMpdYaVIAbU?=
 =?us-ascii?Q?wdlDnMdV9oaSkDQvwCp4yxkj7tyWnymaHdqnxwdoOouDuao6gPQMfiiaDNO1?=
 =?us-ascii?Q?mMmUEwX/tQ+TBXKvjunhNCkNBod3HX0sKLstVN4ySjxc/SaQ+0XjaBdLpg3O?=
 =?us-ascii?Q?3lMOMitxRBsHxKLhmUa71s+SZ2LvsnkXCh+US1cQdLy83fdwnRHl65JNJ92e?=
 =?us-ascii?Q?w6V5UhpPeKOiuDZTKydkaK7diUMwforXN8eats9F//49ZZWFlUYUSTODKoeo?=
 =?us-ascii?Q?0oxlAyuUllOdzWaejs8tgqUBUsXZDDrV+1xd8papTKh1hVWOcdkkkIkG3sEX?=
 =?us-ascii?Q?NLy9utMRYWF+sVOJF8fEU8LJOqQxny70UnjzkecLRinp/GBU1/4Zv32+2/9y?=
 =?us-ascii?Q?h380hNaVqXm+t98AuQdSr3GweDI/FjV4IsKLKIRghPVvHdcH5gOeTmVFeAKu?=
 =?us-ascii?Q?BqVlP8y/SynQdcfPRgY+RrBrw3+neU/rDsBkqCu0aLw4IuLI6lJjeuCeZIEu?=
 =?us-ascii?Q?/ObwWtNZR14xoAEdZg/8+YiKCqHN8W7BuCJB6gCJroOtJjVZY8VlfJZJT3re?=
 =?us-ascii?Q?XfxtxGMr47i5V1D2c2BT2TSL2Iq1q3h1M0hWSMqzv/V7cQRyWTucJA2jFLLE?=
 =?us-ascii?Q?nPGy58roPRU9z7oPegS5WG7VKQgwzyvjkSHJ8Q3IU10ghuyzzeeXovgmYpAq?=
 =?us-ascii?Q?nTtJAScWC6D+ElUMtl51r9bvfHjjDZPxlL19o1kryX02xX6zWVkR9virwHnh?=
 =?us-ascii?Q?Sp6dCyJJ706cHNpkHBJo8Er4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d674edad-aeb0-4fc7-ebdb-08d963e36531
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 14:04:15.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KidVLBihJ1l9+WibFXIadmMDYnsY5whhrdkpRgFKvVyEq7NR48JPXB70DI3o2JVC3TyDXBCuI41kGSHtIgC9nRvFODaSd28whoDk+ZqDfnW1PXNiOiCqVQwLgavhENxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2546
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Yang,

Thank you for the patch.

> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: 19 August 2021 14:24
> To: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; jic2=
3@kernel.org
> Subject: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in r=
zg2l_adc_pm_runtime_resume()
>=20
> Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume(=
).
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
With subject line changed to, iio: adc: rzg2l_adc: add missing clk_disable_=
unprepare() in rzg2l_adc_pm_runtime_resume()

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c in=
dex
> 9996d5eef289..c38f43ea624f 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -570,8 +570,10 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resum=
e(struct device *dev)
>  		return ret;
>=20
>  	ret =3D clk_prepare_enable(adc->adclk);
> -	if (ret)
> +	if (ret) {
> +		clk_disable_unprepare(adc->pclk);
>  		return ret;
> +	}
>=20
>  	rzg2l_adc_pwr(adc, true);
>=20
> --
> 2.25.1

