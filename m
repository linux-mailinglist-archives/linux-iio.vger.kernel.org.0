Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5EF755038
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 20:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGPSJ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSJ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 14:09:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5101B0;
        Sun, 16 Jul 2023 11:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b35H3DyFtGNf3zexhskTDSnwI1sCDfLHy9cyL6euF5At2f0MRtyN4gwckt1+DxXH0XaCp+eUBJoAYX/3D4o+YkCHL6yeJ9yq4sceoPn1Va48f5ZPuBDbcmksEEj1TyP3AGSbQI3ncKErMn02wegZCa55a5oKnBoHG8yTKq4g3+GZ2C6AND54U44qTdJw6wmYDmeI14Cx81buiCkAkRp/gQawc3KYQZBoKVAnxCNFHeKjMBIuTEDc4rtCL/eBM3+0MysRoJgl3dNbkixgiSiFIGFlDlsm6J2rquFJu1/G0ZKqb0bkWXPYopV26rCjF1OFbyGav29Uc1EHjPQ341nm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jS1oOFRchr9mFYnj9kkmgAUAUza0LuqNKrwTRDTrok=;
 b=SNxObK35/mZXEj3TArs70UF+LcUC/AVFhX+Eikfy2A9xJ1v/dZmrUpgswVZdKZyRbk7FAAOGhMyJ0Jq0Fmr8qwLOo/GXHJw+B647SM89593MjoNU8EsPkX0pPZsmGnaeGM9sVxXLVzYFyJhZ6vomVdNhR6aDUJFbTNqgem+cUR7NYAKsJ+YpsTI2zjfDSdgW8Q0keCbDg3S1CHjVXj2oZVuYKLu7WSdPejXZZe9Lkxlk+cr/cW9vkhWInY+S5EqCOJsiFWkn5ESVIC6TNLIC1Xkg6sX2wGrfU2hAejJoQMbwhX3Qyd6xaY4XdgsSeJCneEbFaBlM+ZWnm5rtke+znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jS1oOFRchr9mFYnj9kkmgAUAUza0LuqNKrwTRDTrok=;
 b=Uyf23DBN1fWzCJlAoup6ECF+DHxn8QWmEGhF1rTVBsU5x215HRL/XXimZ1eG4k0evMTWErZQBdilHgubDJL1ti9I6P+o5CiNVnvRi2Uazf29AYHq+BSCtowxR6AfkZH7zKxH1N5R02dJK5guN192h8O3gF1sKaI5nABflrSdU70=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYTPR01MB10953.jpnprd01.prod.outlook.com (2603:1096:400:399::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 18:09:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 18:09:47 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/4] iio: potentiometer: mcp4531: Use i2c_get_match_data
Thread-Topic: [PATCH 3/4] iio: potentiometer: mcp4531: Use i2c_get_match_data
Thread-Index: AQHZuA5MSjw1hMR4LEuu7n2Z1SYYDq+8sO2w
Date:   Sun, 16 Jul 2023 18:09:46 +0000
Message-ID: <OS0PR01MB59225D1764B8CC63F69959C4863AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
 <20230716175218.130557-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230716175218.130557-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYTPR01MB10953:EE_
x-ms-office365-filtering-correlation-id: a0ffa6e2-3d7f-4095-798d-08db8627d6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OI43sYjovbkDvluOjJu7oW1IyH919xdVIzAT/RqZKvhWal2XkeWlfZ2vkrGkpyYBS1rBoxNg4ieP46635tdWguYj84PdXvVL7M82vgl6h0bShOIurFSv1LvPdiryt0eH95PS1DBjNYtVbTGblrX4+a93xvTOdCa9722pnXqAXIEnstOmNlVq8baVnFaIcsDKq5YpsEt+RWWfrX+lp1PAtnQS0LSMnxbopwW1raWaQFyzmBk6/B3ACVzf0O9LQ/HmvIcnM3/pVAW27RQHucESX8/tnNMS6d2fDw2f4j2SLwTzgnrbHOZRbyWF3KIxCEpJIRcE0lHhpZCSjuRoM9Q+ba+xsa62xxeYjajl3gMF1aDfriWBGYzuTCRH1GyXERhMHGmA8rVUyKHbL52G3nRlWH7/+8ClH0Pc4XsWapz52jO2gb4r3Y/TnPuqgAW4QsMfh68cchGsBr4xrduLbbj/aFQE9v+PB4ocbrI2L9M9ZlGxc3SbhE4I6ENM9HvhAdMKtQPoapZyFf6PrPqSp9ArslhP5SZwyf7z/zUC4CvAry90bZzXQZhrVAIfgwKQ3B5D5VQ/GMu9WaBlXA+L+xC/mn2s5Sk1TgwULZ6qM5y2C1cBq7Qz2qRfzfj6dwb2qm9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(71200400001)(7696005)(110136005)(54906003)(186003)(53546011)(6506007)(26005)(9686003)(2906002)(76116006)(316002)(41300700001)(66446008)(64756008)(4326008)(66946007)(66476007)(52536014)(5660300002)(8936002)(8676002)(66556008)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D8KXKKvO3mIy41OSwByfttJt4xJ9wQDB6A5MAFDM0DXMthSbQyQr113DE4I0?=
 =?us-ascii?Q?G55Wg6ArnZFBr/u4PzxM/C00IUkmdiE1J/FLoCodrpLDtuKFo0tY9qL2X0PF?=
 =?us-ascii?Q?yY+ijTlRSWzN1WyVwMnmnjnTtG0kDVV3YCRhEQOLgFmypb5bI0vsy9H9ymJ6?=
 =?us-ascii?Q?ok+YYaSV0n9qX7eRnbsb/g2gfkyzGBgfwVwisG9qgas7dVj0GUxkBDCMey/w?=
 =?us-ascii?Q?bn7q2nS9j0ZHAXDZHA+sl1OtU4g+EjlBUM5lf/mbRZmgB9J5DM40X2oQiNbR?=
 =?us-ascii?Q?tdHTgRrEWzXLsDli/xatefTzCQjzM/dtGp+efi6R/8VKqIfHmLzbc8dZEd46?=
 =?us-ascii?Q?rqHoPjePzAkmFfalnBsqOuT5mBEdOT4PacCYP8PUTlPNcSNnuj6nSJkFQWWe?=
 =?us-ascii?Q?7i1tZM2tAF7r8FOtSuE2iZvJIXCLARxMgMSmSDuF7o4Oj2eRE5gLDxcIEH5y?=
 =?us-ascii?Q?bd9g/gM1K8chi+Fl355P3IpNq3/TDDSJ5ivbYSMfSIBdYR61BuZpsjMunxGP?=
 =?us-ascii?Q?6EqM0KENcpmNVfXLfUew1a2TUMSLXaSrpwxlmK1eyRgqFjNe2Qt+uhTJ6BaR?=
 =?us-ascii?Q?FPJOsrAODoKwpj24LxCxEW/JJmrxOI7j7OVY+5wUsiBD5Olb8cxY5dxH+X3b?=
 =?us-ascii?Q?/U8QnwzQQFIK/VKcqgSg4V1i2p2ZuXnTnhX8zYxO3vPDkC+skcCIaECaUbxO?=
 =?us-ascii?Q?NlpJSkwkuT17jOhhQMVAevHIL89EMSbCOHTbcDzgRTP6UpWlCOtemEJva5XO?=
 =?us-ascii?Q?/lK5KiWE72mcy8uCJ0Ho6RrRaC4vESb6pfiuTTVnqmzhn+XwmNGnlyWMMkRG?=
 =?us-ascii?Q?sXjkRT71k8V+FcMv04xJkB7eH3IYXpbyWfuFtPrUQLDZAhOgZSg/I3PnI/TP?=
 =?us-ascii?Q?5rk3zElj8et+0BhPalHTVPJi3FU+a8qyMtlrIrQLdaIBV9pJlu8/tAegIRHq?=
 =?us-ascii?Q?VpKepu/mG+uGkkxqVr3D953R5N6t9a9NV6ImifW9L6e4MCzu+eACs+p3RyZp?=
 =?us-ascii?Q?XWZkLUFt+/Xey7+e0LgwAOy3LJEaYV0LPD3DAYRUe9nD0WWqiRRhJiOBLqnO?=
 =?us-ascii?Q?hZz0ajW6BCavZ+jBMQxZ6wYzuJTh/Gu7ExP3f2Dn1eAFx/WNbDPUJD0oC4Tp?=
 =?us-ascii?Q?JExkJfAxcHR0oV57i0vYg18t4kdPN1DAMzAlMNgcncJGXC+zdtddaq4E3JFD?=
 =?us-ascii?Q?2NsBO3xszZPs1goKgQGJjxFm8Ly/wHZYga4wGKkDlCXWHFl2e96eXD0d2pO1?=
 =?us-ascii?Q?AXL9ZVUCH3boftSgCv8WgbbCyMAyt9sPGZOGnRsyrbDgVYTXQx4OZRqKjn1O?=
 =?us-ascii?Q?XBdqVyw0vifl0do+FE36n+zdPu7m3PJlXKetUlStdst7TAgNdtZKVa0Sxhr3?=
 =?us-ascii?Q?FCgLent5v/aqElZwNk8iy+gQ28y2hL7WwTQR9kX4PdM8Q4dUP8lppt8FH5P8?=
 =?us-ascii?Q?BVcgHv6pUVysBqQeX8ZZFuB+p6FvhJoDWCLLU5wlZcSlR9T3gFJ9nKgm4hr9?=
 =?us-ascii?Q?VIrrIvonViyV5Yh18wbEsOQPl/clHQKfTpcAOZDLnPslwn25zKmbOG+5VZYX?=
 =?us-ascii?Q?sF7OMfnwOBiIp11fD0TaWfEMJwXCBWAsNDT+Wx7V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ffa6e2-3d7f-4095-798d-08db8627d6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 18:09:46.9091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Lk6F+XYzmfnT7eB2qXg5NyvtF+48MiP6YB0eEuBDRqf3FY55NgkT6c24TXQDSNeA0xxZpJI52xXLI1JrhramkIEDagOnKdelbzHb5+7SO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10953
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

I would like to drop this patch, as this driver does not have similar
I2C and DT-based matching table.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Sunday, July 16, 2023 6:52 PM
> To: Peter Rosin <peda@axentia.se>; Jonathan Cameron <jic23@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH 3/4] iio: potentiometer: mcp4531: Use i2c_get_match_data
>=20
> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() as we have similar I2C and DT-based matching table.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/potentiometer/mcp4531.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/potentiometer/mcp4531.c
> b/drivers/iio/potentiometer/mcp4531.c
> index c513c00c8243..08e7af710e1f 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -368,9 +368,9 @@ static int mcp4531_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client =3D client;
>=20
> -	data->cfg =3D device_get_match_data(dev);
> +	data->cfg =3D i2c_get_match_data(client);
>  	if (!data->cfg)
> -		data->cfg =3D &mcp4531_cfg[i2c_match_id(mcp4531_id, client)-
> >driver_data];
> +		return -ENODEV;
>=20
>  	indio_dev->info =3D &mcp4531_info;
>  	indio_dev->channels =3D mcp4531_channels;
> --
> 2.25.1

