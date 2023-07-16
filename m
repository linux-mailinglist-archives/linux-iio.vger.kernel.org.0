Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0638775503A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGPSKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 14:10:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22191B0;
        Sun, 16 Jul 2023 11:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvZQMOzOKFKZfLWvX0QqYBlKCL3/Evsd2Tgt34Ta0ZNG3KeW1DJAttsJs7psLs2MEEE85/i8P5sDlA0vZvzdZG0GyC8fVeISAF7LNWqTsCpvFq5rst14NMQIq5dr4/p+vsEv3t4i0206yOc0gm6Me2Lyq1K+2phUYgUb8SCa4gmJgBgtHJd8hjMJmAyegZvoCNGjIeIactqJtc9hNXchvFBHdf3jbfKoyquElmMXWdQ7WqmIibXql2onbW/BmPhK6TJelvYsv/LnCV7PhlUHP8tkb5QvtWz60nUxw3tgPHPtZAedOHMNZn/Zr6qEKC/NrroUmU07lnW8/TP8N5Z0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE2oGGaTc2nz0CDjNrKOgJcVMA4keSxr7r8BSswlViw=;
 b=j648ep0J0gHMyvhV1YLf2jRXHbV8H1bDl6LM/RMNL2ulogKldPWY6+4eFxlj9FS+u0WhrQlSsxMNaSroHaSouKN4tvI8mTY/UG18S8h1/2hhW760KmeQQUzzVe1syXVjfDGcSbAnoC3diey9tOTZdDHzd+kH0gtFK1TNW2tYYTdZ4BER00GWo0APTai7CnF18wICnCunv0OrURjKlYDFOT3LZ/yqZcYTSanQjZsb1m7OHgxrCbF6MLxzXz/SA5SCGtBfSm/YTqwQkb/5BUr/jk51nr6V8wvFijQn98eEYlGHBKjDbVoZ+w3hTMhrKT/jIjFV1Jr2e6MQTazOlICQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE2oGGaTc2nz0CDjNrKOgJcVMA4keSxr7r8BSswlViw=;
 b=htgANDcGGN/pGLKlbZ3oszGWJHSEuzeKYwJEu/2k/XholeW3TeipSJj/xFdEx/Up8C3NocaM4yeMs2yOjFERpTOEnognA+97zIXWXFLO1XNsEduDBvfl8Jyu2436zMSRdiZRrSPPQymcrRzp7MgppASgqL1vEFBugl8eKRel0N4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYTPR01MB10953.jpnprd01.prod.outlook.com (2603:1096:400:399::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 18:10:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d%4]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 18:10:13 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Thread-Topic: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
Thread-Index: AQHZuA5O9QJBmy9w80alptB0AHKjnK+8sVBA
Date:   Sun, 16 Jul 2023 18:10:13 +0000
Message-ID: <OS0PR01MB592223598B7DECC648947436863AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
 <20230716175218.130557-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230716175218.130557-5-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYTPR01MB10953:EE_
x-ms-office365-filtering-correlation-id: 12e685f4-a9c6-4b25-5d79-08db8627e6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGmXdKZXTVNcM5F5MsvjaWXvSeVQUv62jC5iE1+k37DKAAN4kHluUOR4vNBgfp+SK5AU1ALZCDmy86GBvDtvSDM2ltM7+pd6kQmjJiscAyaAX72b/BH7B1i1fvh4IksvjDdvwMas4UCo2p8SIKk4ekYtn4T2ujxu/tm7Kupamd0J7UVXw1KfWN/ll7wufwpBbqhPoQTctVHYdpH6Zzq9MZxbAvU/hNcl1hTXudA03meXEy4GwZ1d+4kBLtmZNA1rUG4nu+QGyGU+uXUj0/GjfVI6gyh3SiXJlcpyep0n4BbyTAH4tunRppWDmpvRCivXdN3QlrHzs8XRtYsPeJmU4cGQpnDT1R7lZwMJaR9sQfbV7ub3RXkNiIjtTW1UI6n3KumrSSdMu10zCPx0bRf/MydXm2aqGZyeEpVPQuPc0jJs0yChIxHtw/YYmJ91KlbNrHwXcPpplZAnz22cfwwjMsTELOxZ5d/G8YasnqSirXARztlW/SRJPrqpu3O2ZTQQxqnTBfC1nmy6whAA8AOkgTF7YFxd7RZzlrz1iiyHnA0//XgBzxliXawKK9IKTofso/s+6QFeGVNOzORxhiWJRfdqZ6vY6ZNDm1ArsJjouawAlaqHDjVDEWiaSi+Gxayu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(71200400001)(7696005)(110136005)(54906003)(186003)(53546011)(6506007)(26005)(9686003)(2906002)(76116006)(316002)(41300700001)(66446008)(64756008)(4326008)(66946007)(66476007)(52536014)(5660300002)(8936002)(8676002)(66556008)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VOeABj8TgdwVffLhujfU6hqkApFRRAH7mr4myVAoE6oSSSwpwVY0vWcRqiWZ?=
 =?us-ascii?Q?9kAwHQtp5vLQHUsi9S5jJ/V1fjJgBUT5Kfc/7yhs06waK/05W1Pp10FdC0xi?=
 =?us-ascii?Q?kLz4ZtPxAdTaMubOIBAMrSvN45RyOM1/AyuDcJ+ogF4+Xl0VQGc6wKfIYCyf?=
 =?us-ascii?Q?z2JcLe2Sc12UUyJ/8XyeWuWogP4DZpYPCA+lfdAGWZ/YbmGwAk64ku0hc10N?=
 =?us-ascii?Q?HpAXFqK4hWnB9mK2RuKFQ56mPVz2AaxQsiuATfIpzCslAdRU7PjPEx38D/p4?=
 =?us-ascii?Q?lpNdZUSdPws7674p9Q5jZcNOF1JRvXlTnlbUrUiM1ZnOyGP9eV/41U7RVjyq?=
 =?us-ascii?Q?8z7yf3jAW3WbB8XrhZnaOJSSri8la/No3Y0H/R1ZOO86NQaQdHf6LyfaACpO?=
 =?us-ascii?Q?Rt5yylmP3c7qL+mNMALSl+EWvRFtbmYOhb/B5EUTju20b2nLnxIOUOGxLUhu?=
 =?us-ascii?Q?WHU7hOw2ReSEudxy//LUBSlVDzCzh13FvVfQjLAsCPaBF1/P3a8T4Sfcu1Tu?=
 =?us-ascii?Q?eV2z9diEooA5x8WUlCsMsJsIk0nDtPHVFhANZjRuqYwyFPYBLwbYivTVhiqG?=
 =?us-ascii?Q?oDX9cOTjELYEZT6FRVojv9ToqTy+FjdkM6P0xnHTUkUL9HzEe/8hkndoz9IH?=
 =?us-ascii?Q?4MVEwGWAd0ncRsWKxKKXlU/9drnsa9Ukq88tv+FunvkFTQxpCvZOa9lZSKNj?=
 =?us-ascii?Q?zvXI6USLLKbeeeAh0ERZCGjHpb2KYxod7tjLPC0w7jN7YIaHLitjZPucS8Vt?=
 =?us-ascii?Q?YGN2S1BqWxhXMPCvScs+JsJY4EfGGj3MTs9FPcqgQfYNbCpUowTuDq9t4pIl?=
 =?us-ascii?Q?EnkXhdtX7Y7drTj2AZIHmtc2Ngan+RV6n4h1dYHKpOPzs7MoxVzgM6zBiRTc?=
 =?us-ascii?Q?C/oNFgcSCej9T+6i7NRNMkUcq2NDN4//h8kpcnV6cTK2M/gIP7oFmVW9sySw?=
 =?us-ascii?Q?Y6sJLzpgEG/wFsXVEXlBaMwx117jcsm5g2ixJlXU8o5zGEXtPdC/e7pay2CR?=
 =?us-ascii?Q?SgOZ30QPMNsQ76xM9AHeEoz0dqh7bKSHg0jO4iAXrwQWv794/of840sFl9Ou?=
 =?us-ascii?Q?2sirJXl7acnaPYE4tl08Ww+3S5Deni674ATzL3oMwMA7DCmdzrZNPZX4wxjW?=
 =?us-ascii?Q?Gn8phFaJddy/oWdT7BatOqP1dxk1AfaZSyuOX1Ua4PbcaFMmFRFr6/VgqcNu?=
 =?us-ascii?Q?HrRgUR4Ysxl6tvcXdhmg8YisjrbWbMG7YsOjAV0N7VtXzaGO6flb+w27/w5z?=
 =?us-ascii?Q?yv5Hbn2ul+y/rWq9vHnmJdhVKVH/6HStxmkiss6lsw5WSGL+NwfOFiK+E94F?=
 =?us-ascii?Q?IRhz+uqJS7j68eLCD4QCVJVRJnuxh0GNHqmk++Mdv0qqlkONo4qSrHgLWu4m?=
 =?us-ascii?Q?Q3Wi69qlcX7JGGZkqxJC94eQ0Gz0ZigCE8PGN5rnG2E5WLOD+U2NjNA7J/NO?=
 =?us-ascii?Q?nJr4Vx6G1XkBkFp9nchE63i8+rMkT3QInbG8y8XgCj1Q9AzhYnwMz4x+f1xY?=
 =?us-ascii?Q?yLyizQaLW+H98woNB7LITtJGhU1P/PaJ5AxSJCdHSNqqVY7Qp5k0RJbiUi/Q?=
 =?us-ascii?Q?yYw0EaCd21GuFfkTf90AOFIanairA8fLgbxX6PMy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e685f4-a9c6-4b25-5d79-08db8627e6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 18:10:13.7101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi92vQqTkKpRUePjxbYimWDqrSYpJ0/avbol6oErR7AY64668DaIQaz859Wc7LQ/bywRofFwAMg/vdmPIFaup5jMq3Or3Xf8phlc9NSfbLA=
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

Hi All,

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
> Subject: [PATCH 4/4] iio: potentiometer: mcp4018: Use i2c_get_match_data
>=20
> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() as we have similar I2C and DT-based matching table.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/potentiometer/mcp4018.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/potentiometer/mcp4018.c
> b/drivers/iio/potentiometer/mcp4018.c
> index 89daecc90305..a5d902845a1c 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -157,9 +157,9 @@ static int mcp4018_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client =3D client;
>=20
> -	data->cfg =3D device_get_match_data(dev);
> +	data->cfg =3D i2c_get_match_data(dev);
>  	if (!data->cfg)
> -		data->cfg =3D &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-
> >driver_data];
> +		return -ENODEV;
>=20
>  	indio_dev->info =3D &mcp4018_info;
>  	indio_dev->channels =3D &mcp4018_channel;
> --
> 2.25.1

