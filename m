Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7A6E8A1B
	for <lists+linux-iio@lfdr.de>; Thu, 20 Apr 2023 08:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjDTGFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Apr 2023 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjDTGE5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2023 02:04:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D965B8;
        Wed, 19 Apr 2023 23:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBo2FioMlXSdhLjF52xtdKqZriOvqOA7IjWGGYOmlyuizoPg2T1zR8ooYX1IFIErwg3s2A3bgWhkld79bVV5k3weY0AE/JY18LOMoe2Tl7XHAyh5HGLDri5HHghxNJCt/37G7fpumKfLSXduXt6rPeEUkODjNuhvrrMmukaJtCR2cM1bfTuYJplEeJnz2Ld5LEc/lDe9TRiPkl/L+c9cJ4aXJynZYJ3rXg6GBJweZqRIBCsNt8/z5m8BwJQNbYG5VQOmJYWJJTtUzzDbqrVJvptpm9FRZIvMIHyRgyHdjX5pqGcMJwff3l1e1wwGmd27TH4NkEROu8DD+9Y7vJQsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xboRbDOIsgWpVZtqsQG3RLgCogurR4GUrIEksEK6zCw=;
 b=MzS7h0TnduNrn7KtiZ+ncfyYPCsB3kQTCmqfRuf/8YSNqsd1OAneyrFne9gQKZeqqi2d8lHkBwudmUoNE49sypTfx6AWi3tUyzbZSIQ+yRmvwMqKXgp+WJb4JpLdCKTOiyoLpRJdkePTXTksLy6gYxMyg5E78BpL9WHWH3EsWf6g1/ss/WyAkNAnz0QRkxqPV44WAMl3XbaYmETPZ9yvAB4eqRlmxx58l7V5p5n84ThOfYgyVP4RCNWAlkocroC+xAkXMvQI6+doUiv+LPWuOCl/gCaf4vB4ZAma9nokbua5Kxaj5yShPt9uUg55l+aJBmiA+KY/wIoitm5c7/Bilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xboRbDOIsgWpVZtqsQG3RLgCogurR4GUrIEksEK6zCw=;
 b=OeKb5DFDdrTgKQTBYSkv2pFMJnAqB9MkYRA+hLMNgqgyWy1u/Mtd2hlKjtCAWBdxbuyGsQjBQMj+d1tl0jLrLkVEm54epbmx4RwAU0/TeIIXd/58EN9SBxymy/YARB1FQJ2+zvp2qtjnDC7qJHQxodM/zbJJciiF++6U56ses/A=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5703.jpnprd01.prod.outlook.com (2603:1096:604:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 06:04:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 06:04:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] counter: rz-mtu3-cnt: Unlock on error in
 rz_mtu3_count_write()
Thread-Topic: [PATCH] counter: rz-mtu3-cnt: Unlock on error in
 rz_mtu3_count_write()
Thread-Index: AQHZcsqXwNOWosjuAkyMeiDHX2sOY68ztf1w
Date:   Thu, 20 Apr 2023 06:04:06 +0000
Message-ID: <OS0PR01MB5922C75ABAE4EBD8A87B9CBF86639@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <93ec19d1-3b74-4644-9f67-b88c08e79752@kili.mountain>
In-Reply-To: <93ec19d1-3b74-4644-9f67-b88c08e79752@kili.mountain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5703:EE_
x-ms-office365-filtering-correlation-id: 8381132d-4ba6-4c82-9e42-08db41650ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6X/2VR3IjNnSDL1OZIEenHBLPfSgmr9iuGMfsdksjs8JMHYH4lzKxEBLjfSiYaJFVGUcFDGTqC38otvrEpApyYtsSZD8lKdlYjxV3GClldBYYbfy7INNrgcLITQzm8vNjIFs6LUom4PpnAdeUuK4OSG3mMXdwZ755+cezmVGm+Zerr3XFUGOgQjqIpC7TOxoM4dvWnvTD5L6J/+r41VLul2+DZEQORAOJ56yAuTOP1KHDsNFAIU4+n2YoL4+a+EIOb3r+gFy3Br0YsyKB1RZyhksQNrmr/cFJLEnmsI9zBo2xN6mlv3r0pphGiQ+OZJc2FlwjBk4qAwVKB/UW+AsVzxIZdAvSIcAi28DucDI1niQepq6OtzkLNcvaSZjvo/SqLi6sBltKhGnnDQxuDh5sJ1MDIm6bhbDhCV1JA04qU5eza2rbyn6O+BP7iRqx2egJu0dmG+NK0Hq6idJWgMoZxed6BTSb8POzzMWo+ACZ3C5c5hWyWdec2c1ysTtfUyWFRxNHtSYFrHTXZNu4NeEhRzNakhPYztzi/Di1srfIJrnhK5p33afIO54WAWKJop8uskeN87lvTYLqRSUQPwJ0NWTGw+XASYuhR/NNVCAkHRmCTQwQtUOt4WuPA0VRXeG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(5660300002)(52536014)(186003)(83380400001)(53546011)(9686003)(26005)(6506007)(86362001)(122000001)(38100700002)(38070700005)(71200400001)(8676002)(316002)(8936002)(54906003)(33656002)(478600001)(7696005)(55016003)(41300700001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O54mcSOfbSH9pv2lO0maKtifHQ8n8a7x2I5Y2Ltc4of4oHy34Drcv3AXYUCw?=
 =?us-ascii?Q?skTG1xwCr8Ve41EMyhSrmwA98glDvVgPDdJBuBnGJoxTP2wheKd6vFSBCvIL?=
 =?us-ascii?Q?lYJzhHmaQiC8WB47BejgpAj8txPK5ItzaoHzjwLhtkfY1QVhAli4C4ZLv6Bg?=
 =?us-ascii?Q?R5tHlNHW9GiNOuhEbF/GFy10XOvKA5eZL7uWsW+pzrcqEN8qNYtjRidYnQCg?=
 =?us-ascii?Q?7dVSp1zJNfCVHHvO3W4oEoC7LTFkiAmWxaxHNQ+uUzoRKEiwOM3mO5i/4ivF?=
 =?us-ascii?Q?tsQKE4fnwL9kDwZdrbNuVi+rrsM5y/hY7waIw76zjTQHNJmgLjvtUJ8lEUd4?=
 =?us-ascii?Q?0aNhJ3HvgRppXYq9clByw0cw0j+EeYW6BJ+OKCCnxdDxcHTw9awGNOkHBGlr?=
 =?us-ascii?Q?h5LTZYzteDvXwdI8xw4idS3OrHT4Yd1eJhhYm7AnbtaH3gywERHX7NTiZlSy?=
 =?us-ascii?Q?ssXeNEvVd6n3rad+2AcnqhPjYfb8bZ11r7cpjUKq4vzK0aoBGZrwFSHf9Hbt?=
 =?us-ascii?Q?bPCSp+Mp+eYrXgxkKt1do41AMxqpXXoFBErUlUToSfuwTQ0iMnK3c8NIIu0x?=
 =?us-ascii?Q?5G680inwT6e9LlKH/WOzkbtnEBMoT+74kozszXaC+WySm7hQM5XZauC17dt5?=
 =?us-ascii?Q?r888gi+t/LftWhn4kHcSHWr6bVVE4xXKX/UlVypAk0IG/eCEY2v17h6R2mnX?=
 =?us-ascii?Q?hUizaFI2LB3mLAbjuAC/3iQHFVxWISij79H51L1CF3vSfBnJRljregXUItI6?=
 =?us-ascii?Q?RoUJsSe+Ynxz6xsjNG6IOG9l8C0cH/kg44QjzqIIFz8xPTxk/w5bgUeXuW5m?=
 =?us-ascii?Q?mPqb/Nwksy26NPj9hmmLH15/hFQ01is5n47zt9MtEOdkIOCzKEv281WAHVGd?=
 =?us-ascii?Q?0gmUrd3L/rrfZh2geF/xLefiyqAoUhoNWx4R0aejE6P0sKBjUEI73HIfzmfw?=
 =?us-ascii?Q?1rhJy3ccwltRdAwXm+KuxxSfALvTFsOejAe1c9ulW7XrFVFpWAGOC68a0Zmc?=
 =?us-ascii?Q?cURfFB5V3l2V12fzVqs+Jf035y0e0LD0NxMg2rUGAz/HFygjtE/1qEYc/k0a?=
 =?us-ascii?Q?WFit3k3IO+YBdswfb3Exf1aUJs+zEBxuFzOmdJkKemVTI8soTZXUlr6mg3xA?=
 =?us-ascii?Q?cHlp/x5IhQwrNHxlwgIGe2WsM8O3NqHJdnxPn0HNZydSJyFhq5+xjbHGcGTh?=
 =?us-ascii?Q?TixDbi2wZOQKG0f1CKlAoOFXqCUyg7D90zXxb16xxokjtloEbnOT4vRrJqZB?=
 =?us-ascii?Q?DGuUoB/gWesAQEcs+D0BeJsiIXFgezzuvgJXM5b4YUvy6pt8ivqwSNxi+rlC?=
 =?us-ascii?Q?nhmsRvTW+qyimbW89524jFLCZnhKGQEl6CtMnem9qkxI3p29YaWLVt46yo63?=
 =?us-ascii?Q?IfvE0+2nwb79mcEOmFW+xvnwOlK+idu4KFp71+y5k/kpzctFQGzCuxAwLRFs?=
 =?us-ascii?Q?apxtfLUyjs048L9fwlmkw2e+DabyYWJhRcRQgJUXItDqYsarn4miW3DMxTtO?=
 =?us-ascii?Q?IvLW0g9XkajDaGD7Fj1oJhu6ww0vjBtPLVg+ygX+oHukXR14S2uaa+zaF6sb?=
 =?us-ascii?Q?luWf/eu9Cw85zvbjFgVE7B8tJrhBnJG+oyKLGwoD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8381132d-4ba6-4c82-9e42-08db41650ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 06:04:06.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeXhqqSd/sxET8oJrqLOUry5QrOSQVN9ZF3bizzxMaE5nYctJxRz6T4zr7jJ1eBk0JbE1KhrxfNhjrfg/8x2HrFAzTwZUoVsmtyq1FyrtYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5703
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan Carpenter,

Thanks for the patch.

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, April 19, 2023 3:24 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: William Breathitt Gray <william.gray@linaro.org>; Lee Jones
> <lee@kernel.org>; linux-iio@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] counter: rz-mtu3-cnt: Unlock on error in
> rz_mtu3_count_write()
>=20
> The return -ERANGE error paths need to call mutex_unlock(&priv->lock);
> before returning.
>=20
> Fixes: 25d21447d896 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/counter/rz-mtu3-cnt.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c
> index a371bab68499..aeadce5e2853 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -358,19 +358,23 @@ static int rz_mtu3_count_ceiling_write(struct
> counter_device *counter,
>  	switch (count->id) {
>  	case RZ_MTU3_16_BIT_MTU1_CH:
>  	case RZ_MTU3_16_BIT_MTU2_CH:
> -		if (ceiling > U16_MAX)
> -			return -ERANGE;
> +		if (ceiling > U16_MAX) {
> +			ret =3D -ERANGE;
> +			goto unlock;
> +		}
>  		priv->mtu_16bit_max[ch_id] =3D ceiling;
>  		break;
>  	case RZ_MTU3_32_BIT_CH:
> -		if (ceiling > U32_MAX)
> -			return -ERANGE;
> +		if (ceiling > U32_MAX) {
> +			ret =3D -ERANGE;
> +			goto unlock;
> +		}
>  		priv->mtu_32bit_max =3D ceiling;
>  		break;
>  	default:
>  		/* should never reach this path */
> -		mutex_unlock(&priv->lock);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto unlock;
>  	}
>=20
>  	pm_runtime_get_sync(ch->dev);
> @@ -381,9 +385,9 @@ static int rz_mtu3_count_ceiling_write(struct
> counter_device *counter,
>=20
>  	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
>  	pm_runtime_put(ch->dev);
> +unlock:
>  	mutex_unlock(&priv->lock);
> -
> -	return 0;
> +	return ret;
>  }
>=20
>  static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
> --
> 2.39.2

