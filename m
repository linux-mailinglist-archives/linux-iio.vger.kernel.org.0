Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABC3517F69
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiECIJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiECIJZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 04:09:25 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86DE1EAC8;
        Tue,  3 May 2022 01:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr54fTXaOB3XSbd9LfAgzsQTdpy+TvofH49gOvI4PX1biNIsISY/16gBp7NdSv3SAsJ+BHum/ZDctrx9nPMoVH+TBTAAvilsJ5UB1zF17WePWfAUyMTWQWuRLet7t8ZHP+tHtiz8JHteBjBdppfuhUdZ4ywUFguOI11F/x/1rZpZWB1Yrd+qMpts2mw3oLxlfdD1xCF7YslXRibiAYlUvqtuSIujsIJBy/nYKchCDw/9EU+JKGvBV2BUuZuyHStXgRH+e3enKkTpGDOMvWTXo54iSZipFkJ58ye3twuMV5bYmqTS3GQOG8GMvev/kRwKmDM7rnREQMRKTB7dET98ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/6Vy0Y16R28aRwrxyjk92IkhRgu9RrRWE2BzHVBURo=;
 b=BV2uUOoQtLJOMNx2S7B6ZFJs1sB7YgpaYmda2UduT9ZX7hldTRog07WbRry3qmFOQTFKIfjSMYEyRhBCG5KMjafsMPKZ7EJ1GvLDQBNnmD5gbeC01YJgvIL9I6X0I5YShxqwZ7kcBFlBUmf/tZHufw8Z2Z3Gg38QNwPPwzAD4ibFHlQlKPx6rBYiVhcTcng3mIJrs775nm/Ag71PJqLspqB4pFiELVbcdELnUKSll3kdr14RsUHL3j0b0qZ8+yxlEbpK0T1QmDDFUIEG4pKCN+OPqZMaMvYVXxt1cprzVbn866PH3Q65g+DtDChJCwv/pSwL1df3amR7jEvVMrmIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/6Vy0Y16R28aRwrxyjk92IkhRgu9RrRWE2BzHVBURo=;
 b=BIN5t7uI9rMXFY4/8nfYTrK3zm6ftvUUBjNToNzH1LXZ6X9Z8vhK9ITJW6Jz10V0GnS3huoXfTpBzaBp4b7/lVKqgoQl00KIC+kS7iT01ECgBIS1toWQmWc3KgncOagBOxyM4PzCrj2UsZFwoAOYCUaq22EKF8LSkhOeaIOvk4k=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9497.jpnprd01.prod.outlook.com (2603:1096:604:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 08:05:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 08:05:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIABDTkAgAAC7gCAAArkAIAAAkrQgAAGegCAAAEegA==
Date:   Tue, 3 May 2022 08:05:49 +0000
Message-ID: <OS0PR01MB5922EE8A730DB8A97C9CEF5086C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
 <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com>
In-Reply-To: <CAMuHMdWy9-68EUdjZOVDU-DTAYgijeUZ1u+_nGE0pVBZSX=e1w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a8c9177-0aae-491c-7618-08da2cdbbc8d
x-ms-traffictypediagnostic: OS3PR01MB9497:EE_
x-microsoft-antispam-prvs: <OS3PR01MB94978F9B1101150577C7BC4686C09@OS3PR01MB9497.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhJ6ujZNm5aIuTqUp+cEAAchs3Ls3BG++rZNXoL+GpXa1PDXlcoHzKzU7Mq1uE437WHidr0iXt/sPlKD8letPEnJy9LjcXNr1EOw/0Usu2euE5xzG9z4VOU8mJz7oTwK2dzJp20hkUg86EsLa9Y7dDEakACMOTclE4e0ofZP8RYdX4T692rtqj4Zg14WbW43LWBh39w3XXEF/b9vOO5YEqRVmtVJHUQuB+Mpit4RSJc0SiFxANYRgPwPE631u2yZDQm2EZpXGZg79X0MI2oGaKChx6h1PtnsyerTDGOBm/VrdPwp96sEc5AOXdYJzTgo3F5McevRHGjU0qLbSOMTzBoEanQNhAZ2sl5PvM94BiO+OUcxuxsG3AcsNB+j/mpIEo/wJj1EwxaAIFOWZ0kpL7UlraqfbC5ARyWEYZuVTRjNEokg8yHXQtvOBBE+pCORfLgudUe3hX75HwTI43Nn2RRNAxXCQtZbndY3U1O8OKc1CagTcBjX3Viuct0QssxvKpOkEzt8EaVsqqAKBaDPmJmSHM/9BuiyQqgQuivFD46Zui78KyyR80bClLDs26D+S0wpFEHAz6PlihD9s9kXapW7TUUDZeiCpOrcOUPB1p9e5is7SvOSg4qP7nzKWZM8YdXoUfvbgJbWI3NtMLKdzcg2upiHSvZHAGLzAONDf9of4IsazJkC4rdA7coTFXqZjD2JSZxeobL+LvSz5hxhzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52536014)(508600001)(33656002)(53546011)(66446008)(66476007)(66556008)(76116006)(54906003)(71200400001)(4326008)(8676002)(7696005)(6916009)(66946007)(64756008)(8936002)(5660300002)(4744005)(316002)(186003)(26005)(107886003)(6506007)(9686003)(2906002)(86362001)(55016003)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4GMV6TCJ5B86ZvF7+Cw66eisGDrkh+IJPkWfjAIVzEUGvcXhvIi6oxuDqPm2?=
 =?us-ascii?Q?5Et1rdowmlXHvyaOJtTx6nR8wbFQDUICDO6QcDZVOBEdIBiW5NiXLXevGXX3?=
 =?us-ascii?Q?ji+QU4yzcbFyINm4v504+/LQkVBl1j6KBI3hjBywb4lcLjVlTLyInCusdWo0?=
 =?us-ascii?Q?P/G6HMkJMLqA7MCRtngujagRGrPGmXlpTUWK8rZ7J19iL5UT/sOM7eweIYqR?=
 =?us-ascii?Q?2y+P/8uuWFr6ETh0J6sMHnZzehmdBVNsdSMzt7w6c2wv0npmZNqDp30tJgAg?=
 =?us-ascii?Q?niRs8sznDJWIa8MgiJsA6FrX35zEdGlTZEB4kFPA1BVHiMGb0gUKNlUo5b9P?=
 =?us-ascii?Q?2Vyyv8S4vFWBwxckHi/ARjViTqdW+NvYFAfMB4VzhId08mPxRO4kMlNL1d0J?=
 =?us-ascii?Q?eLCtw6lDZVo1OQM3fsiNXotdoM5ynKB6qubJlKvOKiydJc2CGj/PFyld+24A?=
 =?us-ascii?Q?GH4Xy6j9BoruTPU9v79CowMfkEXqD7vLJquihiTFUNzFYFYx50+QHO5b8R6K?=
 =?us-ascii?Q?mcapGKCmuvnoP7XW9JbQhmmwUlnWNI17keIrLXoDrtf/NLz7xwnccFuIIMqb?=
 =?us-ascii?Q?mjo/NCov+I+q1k7kTxKY5RMDbvgcXJ2IMLAVySQIWdFVToh5ilMVEgTyNT75?=
 =?us-ascii?Q?KpzE5xEBNMlSz9RnBN0LoVmjAW8NUlq/eH1iU4ivITnmTX2SSu+MiScM0SR8?=
 =?us-ascii?Q?VWm0Olbjp2gaWTTBBVq94lk8l5Iy0umeZzcPKHgD7ej3WJr2FdpcofXpbBxm?=
 =?us-ascii?Q?76sMALhMXDA/DP1R7KF5jQyTIQiaFg1a5aOfaVygQbKCAYa3xetWS7SKheX+?=
 =?us-ascii?Q?+wrRGb/ZMP59b+95s+FZNdZfaT04ElWTuLKq6YNcHRCBAKMEHatQhdsgNWLN?=
 =?us-ascii?Q?vOTzxUHqHTH41io2IVKa+KPAuBzCOnACh3+su4FgCMR50tfJPyzXWS9GPwcE?=
 =?us-ascii?Q?CX3rSbrHWJsBHJLCTCVs/l4RY1fQu+kk7ONGmMwx+pPsejeSbGOR9ZbW2h7X?=
 =?us-ascii?Q?CsZhZ9xDai7RIJHzlzOtPKlg801J68CxjUO0JjohnliWE0OQe1s5TbhDKfzq?=
 =?us-ascii?Q?jPXsCJjo5IQT4Fw/UWeGbCSA5ebKgLTBq/qlwC/GO48jf+KN9bWSAKgamcsK?=
 =?us-ascii?Q?M90E14LRTTMFl2JnPxexGqk3v+qSUkVHDKwSmajLLJg1WwO7jgkmoLLfzoHB?=
 =?us-ascii?Q?8Yb+sVsJilYu5BTC3UXbJEZ9UD+lb1Bh3nTBLc5fxnlxZL+UK+khdJID65D8?=
 =?us-ascii?Q?1gTjqr5g+6LmWDafacSk/aysC1335Lh9Eay/sSUGVkyOcl1cx9Ho5czYjD5T?=
 =?us-ascii?Q?kjUjKwuVzVWin8JhvRE8Do4FM6spUQAon6H7dFxPQP+imS4ut/Q10bvqSE7A?=
 =?us-ascii?Q?bAz9AJOoZqDTRhr0WZmiVlz/aIJsyks+Kbi+yISwAIJi6PPSo0Nn4nMJ5Fvu?=
 =?us-ascii?Q?T3B3luQgNTHCHXFv95Lr2Y0bJqoDH/86e5CCq2ZNGrrMWVNZvUX5NCdWdcpu?=
 =?us-ascii?Q?T8d3YTJpR4axHCa5Iwm/13xn5bLQZ/R/uClZvWZKQus/jtGD3XkpeWhczpVc?=
 =?us-ascii?Q?nof3L2yERVkPqPlB+omtatQJRz8q+0nfyp5gBsqZIHu/j8Vp7MC6CirOMZ0V?=
 =?us-ascii?Q?oXUAhN16BAfqcLGI8FpsR+kwmGMFqLpNLwYXkofH3XDSQ3m1vSwT2ojAGnVp?=
 =?us-ascii?Q?3Eswx1P/h5yoSm4o3XHmpni0NeIRpoWmZ7BgNk41IrQsj002dPtdO1ORQ+fP?=
 =?us-ascii?Q?OkNDWxYJda7wITrAVrcIaTkpuwlgUBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c9177-0aae-491c-7618-08da2cdbbc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 08:05:49.8569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s33v9NCWYrL1gKVsaZJ4hLbFefFQVmbweKtfU0FMtpPqeul12OtJDeGlN/hSlfOKRI5u/y+TySukpa492DWdQPhnOoyIN/EhqLli9jJ2ekA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9497
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
>=20
> Hi Biju,
>=20
> On Tue, May 3, 2022 at 9:47 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > >ADC  On Tue, May 3, 2022 at 8:54 AM Biju Das
> > > These can be dropped, as dtbs_check should take care of that.
> >
> > OK, Will remove this.
>=20
> Actually it's OK to keep them, as they are the upper limits supported by
> the hardware block.

You mean use upper limit of 2 for RZ/G2UL and 8 for RZ/G2L, right?

For eg:-=20
 If we use, Channel0 and channel 2 :- this will be caught in dtbs as

/home/biju/rzg2l-linux/Documentation/devicetree/bindings/iio/adc/renesas,rz=
g2l-adc.example.dtb: adc@10059000: channel@2:reg:0:0: 2 is greater than the=
 maximum of 1

But for run time, we don't want to this to happen for RZ/G2UL??

So if replace (channel >=3D RZG2L_ADC_MAX_CHANNELS) -> (channel >=3D adc->m=
ax_channel) will take of this.

Cheers,
Biju


