Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F216E64F058
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLPRYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 12:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiLPRYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 12:24:06 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC48747E8;
        Fri, 16 Dec 2022 09:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgyJny/GzTVyzrOgZPSl7/wbOBVh2/TCleshIRGLMyk/i2Caa7WQbezhmg1j44mt4Z2yYfr2Plrq3LeiyO43k+oShG9DNelKEBBQZMR/Nyz3lCPuqB2wFsA9VbSDqaL3GaM9sbOQq+o5SikuwH4TPTEA7C3XlfOnxzAzIBMUYz37zzcFap1XDMl7iIn9w13V1mAr6c9PVVTPZk0tviTsyNwDXk/IDcUU3OXjAbnZnwdJeKxUyTz3xZVzraQkdciKLPbZjID2OpoHtTzVtZnZplPhA9Ap7+AVPE5ntsUpK2HEYGko3LWFheC5AmxlzBrTU0yGI+oqk4dCD6BxO9HE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OPAsWvfeuZouOCC9Q6wTLQOttPQGkdc4hJPPJPWchI=;
 b=LRLTrlkU+fBiI+Jpix3VanIxWb/VZISbyzsgEadIukvmShdgn9OJbJ7rXPlwI1+vTDxA2QOyp/fP0u1VYxpASGklB1H/JeKWdOj7sD7kx8cd3cPj5zN6OPGHKoFQmMdcZ5vwbZ1+EdYykEh+6pUu0t6WNrL3Y8b3sozwTwZk2UjyNpegZY7E9yav6W5k12mD7gBeTdW+4d0m+YzaeEDp2bxuTk+BWGus94Nl68MzJCLjGJ9iGT7ZNi13aM5/97Wli0myH3h2FkueivDlsIMMXJEwE0F/jfYLfaXFYNWQ10mliO0OUgbFmqys9m5A1soWzJLTV7SUhtpGaov4TlxHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OPAsWvfeuZouOCC9Q6wTLQOttPQGkdc4hJPPJPWchI=;
 b=FhmViujMw358uw6458AeWHkerm+hfoKme7JPqTGkeUrVlnShOEmcnALMROER71Bs8HEeOeeXjJGrENcuhQx/G8mi+gybS1kwPW8IGtQkbrv+Lc0VqbY6w17MGA/8Kri67PIFR2p/utgXPwFSfX9ahvK1A6yfPucL+zJWC+tkB2I=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10186.jpnprd01.prod.outlook.com (2603:1096:604:1e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 16 Dec
 2022 17:24:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::69ad:8673:1ba1:d7]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::69ad:8673:1ba1:d7%4]) with mapi id 15.20.5924.016; Fri, 16 Dec 2022
 17:24:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZD6dL1Ef+NDbgDEq2HK76E2fJf65wsCQAgAAHmtCAAAx8gIAAAHxg
Date:   Fri, 16 Dec 2022 17:24:02 +0000
Message-ID: <OS0PR01MB5922D9A52A0A6D01B73503D686E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221214103136.2493474-1-biju.das.jz@bp.renesas.com>
 <20221214103136.2493474-5-biju.das.jz@bp.renesas.com>
 <Y5yWdiAsMIUn9ehm@fedora>
 <OS0PR01MB5922FB904619669BE9DD85A086E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y5ynT6h/cZwXcMxz@fedora>
In-Reply-To: <Y5ynT6h/cZwXcMxz@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10186:EE_
x-ms-office365-filtering-correlation-id: 51dd2ec7-e306-4ca9-d894-08dadf8a539c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2of/aRDhet8iMHe9MjiIQmhwR1xxoQ5v/2OM0QjAfSDlfbMWw6mNp7iLeRGc5ny9HMt9vDy9o2aNxDHMN0BgWNCsVF1Tbg2mxoyMquZAcCvAlaR9wzv8AhL9DU1ouIj0M1tXiFkvlYJ6wrHzoKUKjNx0MSKwOdH9f0sX+nnE8Zzx6j+tSbm9UxStmTF+/rZjtdVASF8diuJBVOAJa2W2JwseRN/N0uBjbtGl7rl1IKbYT0w7lfMKCjRkJ2PxLGixlk31AscpQvZ5+5WkY5wahJtd63w2Vo91s9QP7fKRLfTKY7zMR3N1WUlcjvAE2o5gdAjhAuGDEseeSdJuJ/L6E3LpXFaN+zI4koihxJFIMdt3Dm3JKSqT7ciUK+PZHepjdSBHHsWL/n4/ASanMgcViqO2aaDYiKLFbXX97NbFV+0I+8nSmH7uxKiIqJKYoWAaZg/PnPm7zNhma/CwAlSl625ylKHWGvrOmB+Xs8AO0FQ6zq2bUOQguZqtd5aCHG9Jaa6Egn94cdH9pk7PHPBewGiJ3rZ1d37p87Oeu7HSQyGp9XgQcW1r/6oPfTTh8wlQ+1Ly9cYSIdcTclkpsHJRvjeFpCGjfmJOsHZ7vNleddzB/VeTonnnbCLgP80i4xNnGUlqlA/n4OkDHxazN54UPG68y4LtTPnPsT0WOCYTgE+SHvcz8z43AUaapKmz4St/L+lGTSYUnE9nsJpognnDeRrFUDuASxU83gxyMrZ2sE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199015)(2906002)(8936002)(5660300002)(316002)(41300700001)(76116006)(64756008)(66556008)(66476007)(8676002)(66446008)(66946007)(4326008)(52536014)(186003)(26005)(6506007)(7696005)(54906003)(6916009)(71200400001)(478600001)(9686003)(33656002)(55016003)(38070700005)(86362001)(122000001)(38100700002)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EKymBYsaOnTK/+RuNM6EcJO9vJ6zSs65A9/FJ9KvAkZmRehoTwFCFy4O7BPo?=
 =?us-ascii?Q?zrBLMW4fQsQeRvSAbK9xQhvWEgSp0oxaOaPHfQr2/cPntiSqRyfVJbHaqMdz?=
 =?us-ascii?Q?QFav13hNW5+aYZ1gqDYQgip882i9L6tITj1lbPoWVwgg6AO4bPi9eUDpddli?=
 =?us-ascii?Q?yE6LBPS/WzNEDyVnDLLgckBvmcAjtV2gB8d2cmO0m/eScIpq25lKYdxsxcib?=
 =?us-ascii?Q?SgSJEvKH22P1ri0ee2BM6qPKPVrpKdqF1RBC6CRNZgwVy645wDnXTfOczzGI?=
 =?us-ascii?Q?JT7yamE79w5bPmTDo5oc7wG8crdxNiwWJrgmK+WXAjm9LTYWdHrK3xBmlrgw?=
 =?us-ascii?Q?jPO172QXMnlkuWOWsYWHOBYNi+7ie7g9puh8oh5oLUsmk2DdAEpx9V2vEuut?=
 =?us-ascii?Q?59sdM29/nh3/PMGe+FzNCkct8GVkkoLStewFrS3MIDGNZvn87sKZd5piJLzy?=
 =?us-ascii?Q?picRPp++BK/4x4nDgcAmJWod4zC23vq0zpc2j6aseHeqrokUDbUtvk4G+fYs?=
 =?us-ascii?Q?XMnhAZyldzIn58lyBwaQSJGW2TTErPZQA8+G4Xxkmhb1Rt7JSfxaUj9rIQup?=
 =?us-ascii?Q?UhZTBYOkfEXSVX2VbqkVFmZRPpXTj+gjOk8sgxXb/rxu/XV8QBlwMiHnUqIx?=
 =?us-ascii?Q?2CEhZk1H/TitnqHD1nZVLLZx8DMXzABDAHdVEI4Xt8Y6bUn5tq2Yqvxehrvm?=
 =?us-ascii?Q?HA6BG7nmoDjb9NPl/CCMqkG1lyJFyUAEjyd4deW6ahGujxC2LeJyQ4c6M7oX?=
 =?us-ascii?Q?PNk7Q4PTzK8Usvj3ERR+GqAYQzDD7QGREMkVf4pIPU8aK+nW2ytBTndi2eju?=
 =?us-ascii?Q?EaVRXbvvaXIDe3KyvElI38PzdQdid3M53Au51KbLU+q04ov9z3MIt1fhev+L?=
 =?us-ascii?Q?0MMil6utQqv5p4VGDSVu5+LexJ+KaYA4oVrLwlUjbFSoV4gguD6kLXxft/wB?=
 =?us-ascii?Q?yYaYe0mD+Mo9L6Rav1gcCr2uL40nLWHxjWbFXgAhOJDdHL9Qx+VNsHLGfw6K?=
 =?us-ascii?Q?/rWLb1z0CLJRuUfQsovnwXA48DhiWhGcqu/qnnVTK06cIjxvkAx4TLnsf8OK?=
 =?us-ascii?Q?1yGi3e0V1HgJNqzKpUHOuwPo8NiiB6arfq3/Lgn0j8Et4rAicsqu6IEayUZq?=
 =?us-ascii?Q?oOChdBaE2dNUdhjidFJiC+FKP6H4Hl9mrKDGn/Ssn7tTHDx2yyaff1c+0UVV?=
 =?us-ascii?Q?540Nx1/G4cBWxJCsJhk1WaaUg/G73wR/PX7ihVATQOu0LTYpR7khko1WVLnl?=
 =?us-ascii?Q?U/EbgGIxrw/zQfWn5qlwyuKm9inY3d5J763+BUzQm7JNE0TBmsuY4HHwLIiQ?=
 =?us-ascii?Q?vn6QB1MLVtokUCdAWgi6ggwMXM/cL/c238gRRYdwmuCof4yxrtDNli7U2PqJ?=
 =?us-ascii?Q?nAgSTuJ2Fm445rx0D/UyCancBvN+33cUOvyWZ6S04HQ63qwpLdfRfE++IyCx?=
 =?us-ascii?Q?dnwM0+goxFCs4L+vI89B/fpwOHrhAYYSg/h8BHw9rIJnB8+kWLUaZM4ow+Rb?=
 =?us-ascii?Q?2v78MjoQ/nb51x/7EF0Ovq6AUOI8fn8Q19Y4Df2cKtOxIRvOyxxHJQ3J1QQZ?=
 =?us-ascii?Q?ETvCHzX30xfKJztIYknL92lhhKy9Pf51rENfHOHQLJaGYI8ijlwLz6n7ZXoF?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dd2ec7-e306-4ca9-d894-08dadf8a539c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 17:24:02.7302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whLcdp9cgyyj/91xh5nFl2ksIWZxHReY8WOGaRIg+u6gW6S3M/D//1OGvYTe2r36svlyrWcLPmDn1KwF9N06wSSNFTo1dJ6pSlR3g25EF68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

> Subject: Re: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter dri=
ver
>=20
> On Fri, Dec 16, 2022 at 05:00:30PM +0000, Biju Das wrote:
> > > Hello Biju,
> > >
> > > Do you need to take the ch->lock before checking ch->is_busy to
> > > ensure it does not change?
> >
> > priv->count_is_enabled[count->id]-> true means channel is held by count=
er.
> > So pwm won't be able to change the state ch->is_busy.
> >
> > priv->count_is_enabled[count->id]-> false and if there is contention
> > priv->for ch->busy
> > whoever is first calling rz_mtu3_request_channel() will get the channel=
.
> > among pwm_request and counter_enable.
> >
> > So I think it is safe here. Please correct me if I am missing something=
.
> >
> > static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> > {
> > 	bool is_idle;
> >
> > 	mutex_lock(&ch->lock);
> > 	is_idle =3D !ch->is_busy;
> > 	if (is_idle)
> > 		ch->is_busy =3D true;
> > 	mutex_unlock(&ch->lock);
> >
> > 	return is_idle;
> > }
>=20
> Okay seems safe then. If the respective count_is_enabled will only be tru=
e
> when the respective channel is held by the counter, is there a need to ch=
eck
> ch->is_busy, or would checking count_is_enabled alone suffice?

We still can configure below properties before enabling the count.
That can be done only when ch->is_busy =3D false or ch->is_busy=3D true and=
 count_is_enabled.
That is channel is used by the counter.

/sys/bus/counter/devices/counterX/external_input_phase_clock_select
/sys/bus/counter/devices/counterX/long_word_access_ctrl_mode
/sys/bus/counter/devices/counterX/count2/count
/sys/bus/counter/devices/counterX/count2/ceiling

Cheers,
Biju
