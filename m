Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534BF629612
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiKOKij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKOKii (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 05:38:38 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF76563;
        Tue, 15 Nov 2022 02:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/7YrVNyqbpQRcOQd4k71dcPUaInrUX9BI2TThEKjyEzvXTTGRymZYxTrrpom0RLQOrHhKuTATarr4belF++kdEfZzL8CqlUk/JKhikB10b9G6cs2SGA5Y7uVfGD+mKEsB2jLLymd3jMaaBdXj9xvhicbRu3q1PGnVwoSGjjX4f9RW3sEypgg7OiZg8qEldZxfj8pfBgOi8JuyCLAKUr7IWtX3Ba/0gxnSjmW6/TdFhN386jiqPJX5K0OK6Z/LgwNbhoFPHhTSljTfnErXqilcioJJbkgmURt+VhkVTBOo1scxTAQIPn93V/n2udUriaMK43reCae8k6H18WRg7w8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQkeCFOKBx7bOOHKIJKPOboJRt2apNWeTINDglPtnVo=;
 b=cjZfO0Of8scuXkw8okvYZwA1eZQ6rNiiWpUfIujIZEN0H+PW0hR9k9CRwNlNogEsWDKbwk5E6ogFaaFTixXTNfhIWDBCXJn3jVRfzRSuzfyyYaEHmTdQVRL5vRFTAvCAhilZYS8N5hqROkCcOQdpMi+cVSskvs99DtAPpZaCbnus7P5c6xDQL1sJFZNJdUlORlFLY5DR+k6znqXO/LtmpYvmo4tGAtsBNRto2/yQHx7Fr1UVkGPsixT5+hOXNo7abUMwg9V3ZZ8jyulkhlhZ7y7yhNguDcYIZgKbk6eh7IzayRRpHA59gHNPsh+TsdVL+l35WF7mbPTGAk/cT1Os0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQkeCFOKBx7bOOHKIJKPOboJRt2apNWeTINDglPtnVo=;
 b=fMAyLfHUrEn8wuyCMUa5QHGeVr3gzMSwiVGZ++w7bWkjiZU3r0zrxcVi+ZWZP9HlTyAelaevh6GBnBhd6iIzKANn6q0oLJjunTjJkvzKuqXZ5oMgN7kxSHrCW4pgOulS39En7dRh9c5uplxVygKPIKnxks7ADMg3RX4GaEP/dQI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8728.jpnprd01.prod.outlook.com (2603:1096:400:16d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 10:38:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 10:38:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHY94Oe/bXNEYoN9kCntehmCzyhdK49yIiAgABAWdCAAKsZ0IAAuUyAgABft8A=
Date:   Tue, 15 Nov 2022 10:38:32 +0000
Message-ID: <OS0PR01MB59228EEA7D3ECFCA83B0679386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
 <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59337BB8E20273468F38560E86059@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <Y3MbM0RtaAKUIyWM@fedora>
In-Reply-To: <Y3MbM0RtaAKUIyWM@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8728:EE_
x-ms-office365-filtering-correlation-id: 5cf7f422-b1e6-4bb6-a36c-08dac6f58ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0LMh5/xziS32zbBrGpXUH9myakX9vSHzhNhvgBj5fFFhKqEqa/9cAFQjcQVu9hzzq5vRys2Vj75ABePhnxjwvr7pf9aWcba8xZlUVMRJ29AU7iGua38/MNCTQ9I60tyEfLp3ghwkbgezVkhIFfeGeL7N9FwB2AhfXpnE37j3jYaQNFzSJrCHnwhCoVAQBWMLLNvnrADERzu2yJnJdgIZH/0SOku61AlU2EX3hvtkGVwIG94KePcVjZv8QIc3k+PDhBsfORbEMGiZjiCl+6LcO4IIeQPTw9E3vIMgSJQD8o1/FCNF8ZGaNlNWukcUff3uyrc2Ha1a3iBMcLplVgUTzv/xpBsnuTO6E6eQCRCFtIL4oFVkFiN4HB/kOj3V9vqre33QWUdT2Xuy1gg4BMoQgye/7XCmIozFl9AVsApiw20/PUrOt9xQyEU54yK/l5gHIoXPQWFQbQq222WifregM5frAv9MnzqQZDC6TZhNwwgkp3VWgBKqxF7WFUhCb5JcFk+Zccs1duqaGsj9E/NWcjeTPjdSROQViF1x/j1kr7Y5lFH9hb7RbkPdP5+nfBWg7kUFVQ90nfJ0sViAFks8+0mWseP58RaexSQBhR9baHInRWCJOLZK3cLIIHBCg6OYZXdecQlgy9WtImS1swncDo26Qe5wgOmBe7TBgTHZStw9kfaTKAAclWFzwFQfP94qkwCTbsRJwj2pY+FtLIPH6D9bjZRY8UioWjtQq4Rdi5k1B0jkghxlPvkoJlVtKAnWSufLen+946F6SsXEDZiyWk4/VCJSkV3DraDE+fUzLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(53546011)(316002)(7696005)(6506007)(6916009)(54906003)(55016003)(86362001)(41300700001)(33656002)(5660300002)(2906002)(8936002)(52536014)(186003)(38070700005)(8676002)(4326008)(66446008)(122000001)(38100700002)(66476007)(83380400001)(66946007)(64756008)(26005)(66556008)(76116006)(9686003)(71200400001)(478600001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Bp37ektthquSgKyEMYxt6YgQYJ2JDZ+RVTjpcXm/oEmuM9NNbAh16aAC1Ma?=
 =?us-ascii?Q?Po5Vhv2ofG36+CP6q/qx/e7Cw34ZwqkJJ1d0JADi2heqBmXWCMy9B07q7prK?=
 =?us-ascii?Q?j1+8+UyAb3XwWX0Pb86KIKOuE3kFADRITalI1CDl7Y2o5CF8iBg1Qs1AmUHW?=
 =?us-ascii?Q?mcaDOtJTdPxa8Cu3c2XhhSAmYikUvKwmcpF0P9fA3gsy7MbyFL9dWSM1kuzl?=
 =?us-ascii?Q?+MojkMABz/fy5V/l9nivGlEoevI5KNIr4HlsqQ5qyNnCg8SkpQaU+SvQoOAI?=
 =?us-ascii?Q?hDkze45G49YHYudEufMcS7EoiJB+GPWecOGXAPJitQOTG1yLzMxxEHpVa4/V?=
 =?us-ascii?Q?66mP6uappm+Bn0K7pWQmHlFydj4yXtNxOfFmkXhwmXbDDRBy6f4NXTw4sZz8?=
 =?us-ascii?Q?4D7vd8xLoArBOBAUhrzWlFUShWlSKK0FaIFvj+2WFhR8pXDfEPH5A4sKKC+l?=
 =?us-ascii?Q?rhgnvkj9xDO5biX1XoK3+5zAmkLWyRHjHgY/Uk+KWx2tU5ly9zQ9ccWHzzTg?=
 =?us-ascii?Q?ueac9mX7k/cAXYtVMFnIZWJ4QKHBkawmUblBk1PtH1gxwSmtgktNksbjH0MJ?=
 =?us-ascii?Q?M16rkDXB+2yG2UcfZRo5NRH3+q2KwEl6dZ/nb5hMB7wDPXN38dy1TgzEDOo9?=
 =?us-ascii?Q?qegoKCpQ6HWnokoEm0/LRBXSwTpSWvRDHxBW+Sf6naAir85Vvoegit20ZstG?=
 =?us-ascii?Q?JenXssX0WDwxQCA1UISJ8oIDSIHNXf4qGU8b5SCY58CvaDN5qHlJmIvFE1pB?=
 =?us-ascii?Q?WJststaS9FE/2X5cVwA7gtdIDRHB3DhxpoqWV75vK2zRagQdKW/eTbYUBmic?=
 =?us-ascii?Q?zXHyBjjUVKI0CmiNIehI70nEDnYmSoucsrNZQj831y6Z6QloQJuM8h/NP/Ma?=
 =?us-ascii?Q?WVZX2sjiuNCNGgAk0IgGGcjQQCN2SlD0oP5ufRGy+V3gcvTOuAKIFw7iYu8m?=
 =?us-ascii?Q?Xg6I9mJQOc2bQoFGt/Ty9yithit5uJtM4j9FoFVt5ETVfuJyk9hQWrfgGXXV?=
 =?us-ascii?Q?UK83hbs+WWDecAn51za2SKmixHoovwmd8mzEGERuOS2dOooORi8INK3flM9K?=
 =?us-ascii?Q?1ztx/PFAbN98Byf7KH/6vNc9fI7O9snHLiWdTrSv75hYnPuWkCZwWoZdHIol?=
 =?us-ascii?Q?i12abhEu3bCuGUmsnUHxaswi7+IElQIAxMSI6i9TpB7q4XXJ0dl6BO5fg9bE?=
 =?us-ascii?Q?VDBuMd7T/RthypvxocJuCzPGKdFCWKrah0jK4wE3MK4E0RFg8EaczoqNY3sp?=
 =?us-ascii?Q?mRiDBLbqrD6nWyWZVX/WHA/yuCPC5NQxLhKo2QpE6J6fyR3RPwvLuDWOWgFI?=
 =?us-ascii?Q?VP8Ln+lrKyAmXZKRL5ugJM0NLwy2jYXU53uAk6nY6WE9JakyBBoEYAnRyDZE?=
 =?us-ascii?Q?MskzZA4uHS9Ac2iQbBhI3OdE6ipBjsLo8eXR2Jinu4f7/uMXbaiZY/ubFssz?=
 =?us-ascii?Q?6YjNmxWcsFoR8+EtwblBUgD2anULA3TFiZq5SsL6Dt0uuzWeT0/kxs2YapVR?=
 =?us-ascii?Q?60tHr0YnC/tv1WrHN9rsCfBTApZxUaVujMpcUjEwHPjqamAPFdaw3LQYLj1N?=
 =?us-ascii?Q?aFS4xlVQKbrARhrRqeVp8wjVWRLMDXqQlNICPxJsr1EP0P20mJO/9rHlxKj7?=
 =?us-ascii?Q?AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf7f422-b1e6-4bb6-a36c-08dac6f58ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 10:38:32.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18k+924Cyp6SpjTcVLekiGcVrWSAhzqpcHlaQv7I8pCpbtpnE8fHv2/CpCvRqZiZ5bxnEHJfBC532sbHlopozvtXM6zzuQaS1bi5g7jWYf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8728
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> -----Original Message-----
> From: William Breathitt Gray <william.gray@linaro.org>
> Sent: 15 November 2022 04:53
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: linux-iio@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-
> soc@vger.kernel.org
> Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter
> driver
>=20
> On Mon, Nov 14, 2022 at 05:52:11PM +0000, Biju Das wrote:
> > > > > +static int rz_mtu3_initialize_counter(struct counter_device
> > > > > +*counter, int id) {
> > > > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > > > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > > > > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > > >
> > > > No need to complicate this, just use priv->ch[0], priv->ch[1],
> and
> > > > priv->ch[id]. Same advice applies to the other functions as
> well.
> > >
> > > I get below error when I use array susbscripts. "*ch1 =3D priv-
> >ch[0];"
> >
> > > drivers/counter/rz-mtu3-cnt.c:291:32: error: incompatible types
> when
> > > initialising type 'struct rz_mtu3_channel *' using type 'struct
> > > rz_mtu3_channel'
> > >   291 |  struct rz_mtu3_channel *ch1 =3D priv->ch[0];
> > >
> >
> > I could use "*ch1 =3D &priv->ch[0];" please let me know is it ok?
> >
> > Cheers,
> > Biju
>=20
> Hi Biju,
>=20
> I meant to use the array subscripts inline (e.g. priv-
> >ch[id].function).
> However, I can see the benefit of using the ch1 and ch2 local
> variables, so perhaps something like this would be clearer to read:
>=20
>     struct rz_mtu3_chanel *const ch =3D priv->ch;
>     struct rz_mtu3_chanel *const ch1 =3D &ch[0];
>     struct rz_mtu3_chanel *const ch2 =3D &ch[1];
>     ...
>     case RZ_MTU3_16_BIT_MTU1_CH:
>     case RZ_MTU3_16_BIT_MTU2_CH:
>             if (ch[id].function !=3D RZ_MTU3_NORMAL) {
>     ...


OK, I have added below inline function which simplifies the code
in each function. Is it ok?

For eg:

+static inline struct rz_mtu3_channel *
+rz_mtu3_get_ch(struct counter_device *counter, int id)
+{
+       struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
+       const size_t ch_id =3D RZ_MTU3_GET_HW_CH(id);
+
+       return &priv->ch[ch_id];
+}


@@ -154,11 +163,10 @@ static int rz_mtu3_count_function_read(struct counter=
_device *counter,
                                       struct counter_count *count,
                                       enum counter_function *function)
 {
-       struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
-       const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
+       struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count-=
>id);


Cheers,
Biju
