Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBF75CA70
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jul 2023 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGUOpK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jul 2023 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGUOpA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jul 2023 10:45:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB6F0;
        Fri, 21 Jul 2023 07:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv7EZ45nOLz7nX59+8KjUZMyJG9fCagD1GcPKmchJV/8BnwfBhsQ5IJeyYb83IBz6s/MfML/5aqvbMxx01YVUfZ+sYCCkPqK/TqrBjdUCrc+PUTWcJkoly3DGoEKvfYjFOsqoltSJG5aOp89hStAn9ID6VaSfRg9dPVqTZ6afzLDrL67D79ooykQ2jl1goXQ6Jn9OfyZhXSAPPEiV2IXfBSrF1rzUWnbQbcBj2ojHwq3p5aRj06fZVl/OM945lyJs8TORNnlfB8N6VfzQqvmzDtJaaFQSBdZnuKXm4bomQtE3PlEn/92tQEUMtMXerov06gg42oPlS/FFZRhJ+bkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdfYAg91of1OUnCLN1qQ4r7/ZiMzl2kb1zMLNAti2DY=;
 b=Dhl9Ief653OgHJzhHV0bpd5RfP4gYNz+5fufP3vp9Eu6zW2isBVLAFI0dTGyeevas7fGBmn7xqFUlB0GDk4B6oRvSxtGvm7/1vq4+KtflnN3e1U+ySDDQ5QMCKcQBmIllByNPjdjQfTuo1Pyqb2BADV16ZA+zwt+p8JqgnWMAS9cMeoiPkNFifIl6XArcVZzPLab2IlhPz+ElwBuPrW1dGxJRYJj9V2O6RXafWtVd+W5kqd0G9KMi3V3nbP0RmxP8fzDHYJzPXKBus0StPkLSL7V4kvV+jCUiFrP0WmzCYSSCv562oeP1hqpR9J4uPSCjz088hWZZcAjhlA1YrMYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdfYAg91of1OUnCLN1qQ4r7/ZiMzl2kb1zMLNAti2DY=;
 b=hJ39K9rQM9SoYjjdY8Nf78/dm5WkcvXq/SR836bGIF/x7WxfOObaRo/Bx4fLYZ4W6flfZSeHXup+zORislp99BiplVxf1GL433PfBnhMgo1/rXzwJgNzJXloSiD6Rmi1QKRWPkHRgAHrIds2l0uFQmgUfQse6yU27JRZzhxQ5NY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10841.jpnprd01.prod.outlook.com (2603:1096:400:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 14:44:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:44:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <wbg@kernel.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] counter: rz-mtu3-cnt: Fix locking order
Thread-Topic: [PATCH] counter: rz-mtu3-cnt: Fix locking order
Thread-Index: AQHZuKdLsOyvrSBT7Uy0alNIhZZsEK/EPfoAgAAUA7A=
Date:   Fri, 21 Jul 2023 14:44:55 +0000
Message-ID: <OS0PR01MB592276888F828289DD0CB967863FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230717120738.165765-1-biju.das.jz@bp.renesas.com>
 <ZLqIrNbygFC7Ay+m@ishi>
In-Reply-To: <ZLqIrNbygFC7Ay+m@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10841:EE_
x-ms-office365-filtering-correlation-id: c600bfa2-e523-43da-261c-08db89f90c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eo1iyrN2kpl/taHZE38nQ+nnLZCY8kvPGoA4d9kNQSm1Dqbts5c57BEJAQfDcCm+Vr5lOsYMqvL2XD5BuANdHF6f3qRzSTGXAY6pLNBoLwx45zyMLU9movDaz8PaFXAmL4vRABOoX3B+h+IXaJ3OuDyrTefsZjnwzsnMnNbTaSKbg2M261taKnsQ2IQNywgShhdBTbhL7Icfq8SjeHcv17u2h9Bh92RGfVZFW74jyCoDXFq4kJ1I2vH8jq8P4ir2sIm8xWgF8y76KYLVkgYU8wvcFihT4fyiXAic8H0Hr92I2xdT1rcxFAS0O77VtY6bNuTfY5LTCbQI3X5pyH4D2egFznfECBqH/HWLsUcfq+9N9z7x1xt+O/2oyh/iBOuF8DFBDLwPUAZ6s3iBvVx8izxaW+AenRG95sA9r5TE3hInajbrgbtEfumyX/4tOssr0sb7p/v1JUIYPgWD7KFfz3cStMHSB6QtANNwRZ/jVQTALt2QVcMLDOLCluXxV/efec0WwsCK+6n6YCKDTYtkBI0b+pXIqUXVDhFApzjZRsGeRUs+byvRynnVR4wKIqHSspMWfcKYZTUzR7cg/MFUx+WfA+cOlRN8bO3tChRH96s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(966005)(478600001)(7696005)(9686003)(83380400001)(33656002)(55016003)(38070700005)(86362001)(2906002)(66446008)(66476007)(66556008)(107886003)(186003)(26005)(6506007)(71200400001)(64756008)(38100700002)(122000001)(76116006)(4326008)(316002)(6916009)(66946007)(52536014)(41300700001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hOsamDX3YizRZCAN44YlxEoN5LTD7a2gDUZXSbqog+X+dYA+umeI02Hd7xeu?=
 =?us-ascii?Q?lazOtwVWJdogNzlteTWazAayUcy9SSGPkP+3WttGrw5wWwbszRAu39EvOY8j?=
 =?us-ascii?Q?fZLueq+Cc5bIRfxJiMhvD6YuQTnYTEIj5mimdBSCK+q3NsXBl/sSRJd2HpLL?=
 =?us-ascii?Q?M+O50YZe+y49SlyJpu5KMYlcEBxP8+X/e5b/075jWm0mmfh3rTYKGd8YFO7Z?=
 =?us-ascii?Q?CBYPERmtBJGiRmWXszhmV0DYbQIQP88zOba0lOricPkkoLjDsA2Uwc/62KwM?=
 =?us-ascii?Q?pac89KdHD9Prd1LOsXImIcTxrnyRlgqqcEJGXUvz8GbCLmDFkFhS3ATiRyYq?=
 =?us-ascii?Q?TYo/fqwLUc+wK1pvxe4jMz6ywj2jWiO53gK4HpnUjRscG6BlUhWxhuGGMTgr?=
 =?us-ascii?Q?dUhMzLb6/ww5Xx2odCEOPJISaY+qQe7HKYQAy/8CWYbiRXgXZofUAxX0ur8+?=
 =?us-ascii?Q?7CBqgTY66Y/ATY/Ir08O6qKvrLdOfiorMj6QruJUVpRFXrgqXbQoG0/OE4Pp?=
 =?us-ascii?Q?nQvFKVR0wu6xXPWZxzbnCJAuYZ1tq/rqnWZXXnG8/r4p65nVd5kzOJ8LTlpi?=
 =?us-ascii?Q?sekfQYlZh66JRYyNF8+3ontEO7Tr0dV0ntnT0i3gBxb3VnI8XpLNmbfp70e1?=
 =?us-ascii?Q?afVnB4sHLwe3KqoAHb2crfIVQPHbVrCRTOHI2U892sNdcKQ9/AsZPNpXLe7q?=
 =?us-ascii?Q?MOdwSwL0KKinUOuXPDNIqGEEEQxdV5bk9fBmnlwR7o9BF1GRkg7xqJk6gemg?=
 =?us-ascii?Q?JlX3KKYmvnTyVqn6famH8MTsZuQkTy04V4Jzm+sbPrvlU0/6rXLo4VR+kOGS?=
 =?us-ascii?Q?861rkXIJZbvFhxnPpGEJu14a3KetgeFnZ930HUyp8fTuVYmW3Mijq+JChm5T?=
 =?us-ascii?Q?1+TL5J+GlF/CT5/ocDZoZVF5UsQpnR/8DG7K5+G7gDEmU8N0Txgq9lKsJ7oC?=
 =?us-ascii?Q?FI994H/oinqLMUxL9rO1aRMV80C7LnJ2taC/3XbB981izsX5gqsEdpZhzNZc?=
 =?us-ascii?Q?dtwSUzw0lilJSFTPSlVkNIOjYg1KWdCHT5lCiL6oqWT1+hqvEE9Seqxgq0Z0?=
 =?us-ascii?Q?D09Mz7zomGystLepVLJ8VM0ovRm5KEGxqSzrlBtx8xA4hgZYorvwsqcocRSg?=
 =?us-ascii?Q?pUK/VPjjaTpkrYPqPcsNhD4zkkivGQE//OG7lVvGPcnNawBFD2zkVk3dsXD8?=
 =?us-ascii?Q?DeAGCJtG4BI9AZCeHHKDfayORSXZhUxNHipxro6/9CuuiUrlV5l5Ac8/S93Y?=
 =?us-ascii?Q?8LQ41l7qPx4RubvFPPuVGr56Fm6XMqIolBD0hE8xuK9pwc7fy1oo5UrsV0+n?=
 =?us-ascii?Q?7H+NezwixbH00z4ZuhKKnetI0ejCmAWI3av07MnNqMRYrMKhuRy7PSyH/1n3?=
 =?us-ascii?Q?JCe0BC2f7x07PdCaPB1Vm9VgzwNm2BLfvsIP5Gr2Oi4V4npe1wsSLZEI2v27?=
 =?us-ascii?Q?b2ZjEsRlykHhYu7fH24ltByFNNAX2Gpq9Tp5tSRekRwDaGt4y1p9kYrmA9Cy?=
 =?us-ascii?Q?j1f699JjT8l1USVI+45QpVZ3Z0VW0EiIluBG1aKjs7uzhL7ccDVY8K1Hd9XI?=
 =?us-ascii?Q?1GhSh2yvwnvwIq14PvVPBl4rIQBsD6L1oyrEN9ON?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c600bfa2-e523-43da-261c-08db89f90c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:44:55.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ip9wJzF16Zwl2jBDkDfoODc+Z6QgQOgmB3UWKd6oyILBs4/2z4QI49SRcv+ItXGPsGQ32c9Uyv9mpDRY2xjEKFnU+TL8Bk0gBTsj7NX9Z28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10841
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH] counter: rz-mtu3-cnt: Fix locking order
>=20
> On Mon, Jul 17, 2023 at 01:07:38PM +0100, Biju Das wrote:
> > All functions except rz_mtu3_count_enable_write(), calls
> > pm_runtime_{get,put} inside the lock. For consistency do the same
> here.
> >
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Closes:
> > https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.1831
> > 32-6-biju.das.jz@bp.renesas.com/
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Is this just a code cleanup for consistency with the rest of the driver,
> or does it fix an existing bug? If it's just cleanup, would you resend
> with a different title (e.g. "Reorder locking sequence for consistency")
> to make it clear this is not addressing a bug.

It is just cleanup. Will send v2 with title as you suggested.

Cheers,
Biju

>=20
> Thanks,
>=20
> William Breathitt Gray
>=20
> > ---
> >  drivers/counter/rz-mtu3-cnt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/counter/rz-mtu3-cnt.c
> > b/drivers/counter/rz-mtu3-cnt.c index 48c83933aa2f..ee821493b166
> > 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -500,8 +500,8 @@ static int rz_mtu3_count_enable_write(struct
> counter_device *counter,
> >  	int ret =3D 0;
> >
> >  	if (enable) {
> > -		pm_runtime_get_sync(ch->dev);
> >  		mutex_lock(&priv->lock);
> > +		pm_runtime_get_sync(ch->dev);
> >  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> >  		if (ret =3D=3D 0)
> >  			priv->count_is_enabled[count->id] =3D true; @@ -510,8
> +510,8 @@
> > static int rz_mtu3_count_enable_write(struct counter_device *counter,
> >  		mutex_lock(&priv->lock);
> >  		rz_mtu3_terminate_counter(counter, count->id);
> >  		priv->count_is_enabled[count->id] =3D false;
> > -		mutex_unlock(&priv->lock);
> >  		pm_runtime_put(ch->dev);
> > +		mutex_unlock(&priv->lock);
> >  	}
> >
> >  	return ret;
> > --
> > 2.25.1
> >
