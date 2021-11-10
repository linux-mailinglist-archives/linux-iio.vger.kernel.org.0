Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE244CD1E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhKJWw5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 17:52:57 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:43509
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233569AbhKJWw4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 17:52:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfVZBWZHIkUYZARVYl2fSFrCQQCqjh/YqJTf+O4ZNrKo10fgoJhMSiSppPh5FPeEuEZijnK23VO1jjnfnX16ASYeiT5J+0UjMOwLly1Yq4AACEYlKag1aTGutZB5+v4dhawPkHTO03rJsXfx+lMHZjcI8scgjzAIe5E4BTDakPUZd6JNfI5XSSDZUmC0eNilJbAXn8b4ZhWKr7g5HU2xhhV4pK8AWuACcNdxWe2d8CY1bUUZa6N/Do8IuvhSZPD7+Xfc5An0zn/On3II6ox+5XNKKUzqxvLWia1THnkNvtIwvFa6D3rEwLIP0Hx0gmY8Q76rNxUiXYBjmFh8NTJueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmKi4jQNj7Hyb7YTiZwPhl7wb/KYBsPvoW+dqrZf1Hg=;
 b=RQUJ8I/fR6ozIJ+LBziuwh65Zyt5yrxutOOjyI0QbJOoP8I6HVxYljq4E56i31asUZwcIHSzndsMEv9yI/oYVrdmQ93reQ8oENPqT9QXMIR80fuD781px9MSjRec2UXmlx0P8mz2KoFomrsbE8JxUSUfBhU5kPr4a4jUwZGv1TWxkQ/kn+AdJwG9HXF9Yp/SBvPcqpdyyY650BJNBqU2EtDnwbqJtXVvUIXpwNodOwmGp2h/LEh3zxRcI0LFq6KPSwvTqUd01RSqH9hAYFns0mBiSJXH7CRFsQlYS7ejpyINnc/xkKFbbOgR9c+vgQrKMwmbpK/p4tva14T2CKz0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmKi4jQNj7Hyb7YTiZwPhl7wb/KYBsPvoW+dqrZf1Hg=;
 b=GDADSN3+ggGeNg4VbI54t2m2m+Ek5M38/V0yl4gUZhyl29l27oxsNE4If+hXRjEVZ5S678xMny1Ndo3q3LHMMC7ktJDywjGseoGj4YLr6Cyy0LW+gqeBIeqaX48uwr019PlspfmJdBQP8o4Xoh74XX1WNXm334oXRS8/0r4/lmY=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB1461.jpnprd01.prod.outlook.com (2603:1096:603:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 22:50:04 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::1d3d:8c79:ad2c:62ae%9]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 22:50:04 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Xu Wang <vulab@iscas.ac.cn>, "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function
 dev_err()
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function
 dev_err()
Thread-Index: AQHX0egr9Ta7f0JlM06cDVlwkp1KDKv9Zldw
Date:   Wed, 10 Nov 2021 22:50:03 +0000
Message-ID: <OSZPR01MB7019A331812449B03157D0C8AA939@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211105015504.39226-1-vulab@iscas.ac.cn>
In-Reply-To: <20211105015504.39226-1-vulab@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1f0cbf-2e69-4813-5209-08d9a49c6f6a
x-ms-traffictypediagnostic: OSBPR01MB1461:
x-microsoft-antispam-prvs: <OSBPR01MB14614EC42C3039FE6F17C699AA939@OSBPR01MB1461.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLUisRMzFP+kYfKT3E2s4h5R1UNqnHEuOoYzzgjpK7a/lQprirWpYzrWEJmBTnkSGvJwaGzwF3IlhH69S43BdV5VRXTxYPojSzZyAUQu6lc/V8mYSV5QfTBv3R0wOFAurvORB4jfSImMOX1GQjoKa+ffGNbatVkrbHCuCGMLX8TvTnfbqGg69hr7onjUyYryyhMYJfxc9fyeo0DY6P5acuyf1jpjohI1qc8+ArtKPi/+SgpK7pUPdUSjc1ZqLYxyIOImFxOgAhmHEHgWMP+hETdxP/k9RdMe1XB9LgRjyRmXWnlRIYaM8XNXjs4Lt08wtXEf2g8trebZUAORfwGKG75zTHTQN3f2HoFxojJYIKHwTmQJ1vcuYxd5W4HJCJ+GFBFcl/v+1+Xs7wYhzptEoVadkyI/FAX2N3Cnlg0XxbUTuHPVlHgefwHU+v4pnvUtP9y7RGkfaTrjVOsg0qoLonX6HcxAP9KIjKgkXyAuv3cExSA4DOa1xHglmY+25Hn0p9u098tQYqeKTJuN9zfPWX3rhHneSIM4ac7GgwKOoIhwaD8cB5tmLv6wDf1KevU8+/2oOzvvj/lyuuLi4jMV1289KxlqVgXN6N6+bwY/drSGgA0Glj2FkI8R2ChW+smWWWcmqppOmPSE21l0fv1stqKb2h2G3JqGaDwIwDdOyB4NrHW4GqdSk2mJLmHJzgZo7xEgNMXV/6ZnMi03POG2Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(508600001)(26005)(38070700005)(33656002)(7696005)(8676002)(52536014)(2906002)(5660300002)(8936002)(4326008)(110136005)(86362001)(9686003)(6506007)(54906003)(55016002)(53546011)(122000001)(64756008)(66556008)(38100700002)(186003)(76116006)(66946007)(66446008)(66476007)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iLsid6JSMdVZFaG/3TZKg3+XAZN3uR5tVheeZIZT65q8VDEU4AxOCpX8+oiu?=
 =?us-ascii?Q?NeJATigRt2QExbPaeV2Hygcq7L1ZuKVyx38g1AuzPfBTvMRZ0MDLmIDhA/Y+?=
 =?us-ascii?Q?FArHG2d7/7G+2cq26xWNDjNmAtlPt5mC0NwcqcWRWhSkPEu+/NpHMBTGkWx5?=
 =?us-ascii?Q?SAU3GpscOVSlWHwCweEmRjI7g+Q9caJ7N8BC+tOXmQccZS0VIQc3rlLUsuYP?=
 =?us-ascii?Q?ZZ1a224C9iHewozVnNkvJU7bRDtSoUYaVEf93Th3R1gBP7aqxV994WIvPIAa?=
 =?us-ascii?Q?2DkoNlCJwTJz9GA8DACgA/nwFsBRDh5cNg2u6uB3EgnN1kpxgnHawmgQT6xc?=
 =?us-ascii?Q?bdKNHWzBaSuaGvVOFDTJ+L9vcTXyowHvQ+BLBiVOUNWRwPC7NrkMsJrbpZQC?=
 =?us-ascii?Q?m33DbST4q3hUj0YkbczA1mZFWhYOJWH7Vvu9ytljTymsMyxVciiluT/5+4TB?=
 =?us-ascii?Q?KDbIe0RNkfKrTMUgDIGynAX/9WXvt8jFxdRAgFNjblq8UHp7RgwGpcsoikom?=
 =?us-ascii?Q?4eYlMU1QJgEYddy2QaEi6/KC+UM+TFedSbiDubJlknn39ueVeewLKCA0xLGg?=
 =?us-ascii?Q?EbLlovHF8VkOr3FysY1Hifv0H5AGvM914PtowxrPh++aIhSwYUdzDa6zNN2d?=
 =?us-ascii?Q?KhETC2Ci1ThMBTApzlIS9hoHGB6xqA3QXxDOBJhEPHFWAHsEpFL9gmDOx8cf?=
 =?us-ascii?Q?CSsjGtuVtNGGeT0M+Y81EDsJMk47sOs4FJpNHWYiLO4KskmWpTUsLGOYcwkR?=
 =?us-ascii?Q?7q41oFURa2DubdVfPMk/4SPCff3u+GzU4Jg6RpcVF9RP8ynZFUD0lsifuxyM?=
 =?us-ascii?Q?eh/tQ1ME6WU+dl6tOKp3Qm84/RpGo8V+wO7pcdRyF+lS14cRAKaj5Ajlns1D?=
 =?us-ascii?Q?iIHWDhiEHiVsUK3KnYhp9xtVFPFxrDEyFFCcxrgkqcGcK7xjF1/9CzA91XTN?=
 =?us-ascii?Q?/6/jiVlP0gm8cwbfNGeLVGphZblsNq/A8DomGHXwC37UMSYi6MneZvrZbjJR?=
 =?us-ascii?Q?fXdUFVhQPBfZ1i9l/9prTUcRIXmTbFsrg9izMptbLr2LGsV98EZFuvDsXXBd?=
 =?us-ascii?Q?Indt9zqRlidHrKWBqo1wsaXCiqrDtf3CEpptY/gduHbzaM0UtyWWoribFX/p?=
 =?us-ascii?Q?YZNjqyrf0TI45Qn9faQDZrSTtrXza9oAANfBmcfnXh+y0Di0hGTr69UE7Nau?=
 =?us-ascii?Q?wWcpUYhOFVF/sSCQ075E6mB3oaXGMwCKXjdQP+ivBFVY1iFi0O5U5D/4jtGJ?=
 =?us-ascii?Q?YpSPwJ6w/asho2xc7LrI1B7TPlPqJNNMXnmnGxpsm35EfmPHN3EdKq73vI5h?=
 =?us-ascii?Q?vbj4XzTKWGnyNb4+Bwx3TtgkiLP9eq3EHa1ATWdzRgCqSHQdoPB4MO9NpKsF?=
 =?us-ascii?Q?Kxd57f1qKHfYscezVGCtrH74vv+YhF+4GTajNp+ZlR0ksnVMenNacvNVjLOy?=
 =?us-ascii?Q?yKqIkZwdrx1WNVvgd3xAEpVGJ9p2DPgjaQEoFtJGONRNjgcHskgAXokwUpRK?=
 =?us-ascii?Q?W7qTTV3Fyp9vxB/en173yRbv7WteVJXp/PDui0YSXrI3x8W4vkIc9dfYJxP8?=
 =?us-ascii?Q?/mBcsX9ydfMTA7KDUv6xHaNam5E+NXh9rMiiX03g4FEKNt7tt5Lzef823fbJ?=
 =?us-ascii?Q?N+DurutmSj2nuPufdXOxCluiLLgs6SvbyRQANYTAJqMvqUjT4zzN3nqyvbN9?=
 =?us-ascii?Q?gZ7TWOm6o/PqnNXGeVn23Ofjt07sA9ZghhFjR31McC9EouC8uyEIFNxHKqjH?=
 =?us-ascii?Q?zS2+/9NUKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1f0cbf-2e69-4813-5209-08d9a49c6f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 22:50:03.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGAIXshc9KEe7pyvWIgB39wroTb7mG6ScvPyeUzibC/yOPzrlV0VjKBO8g+fL3axWSBbhfQ+N2vi0b8chb6uSNxMtliq40eiW4jUZLtw7Bm1iDxNY5jH9uwshuJqEi+t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1461
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Xu,

Thank you for the patch.

> -----Original Message-----
> From: Xu Wang <vulab@iscas.ac.cn>
> Sent: 05 November 2021 01:55
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; jic2=
3@kernel.org; lars@metafoo.de
> Cc: linux-iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-k=
ernel@vger.kernel.org
> Subject: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function d=
ev_err()
>=20
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c in=
dex
> 32fbf57c362f..9d5be52bd948 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -506,10 +506,8 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>  	}
>=20
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "no irq resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>=20
>  	ret =3D devm_request_irq(dev, irq, rzg2l_adc_isr,
>  			       0, dev_name(dev), adc);
> --
> 2.25.1

