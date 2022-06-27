Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7144255D5B4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiF0Wl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbiF0Wlp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:41:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2043.outbound.protection.outlook.com [40.92.23.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E26193FB;
        Mon, 27 Jun 2022 15:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSFNMpz5ppA5RmPZ6EvQVeO2uay8FZY2EDmdKOb94vFCIMYVZIfvENMdR6tPXssXtrbBLywhLckat0BsqSMB0Kw3a9m3/oYVJyxWXzM3vOqxXcaFffpZbMmUPz3GVbMLkfH2/I20oCME2IOr1CS5ZBK3s2FEqhfLwHXGvgDVzdtV0K+4l1yRAzk+HrLa4qvLrkTr52bjxo68M5q0cSOHXJgYCOnSAgqb1dHKk2I6BzhgzIPT3ADI7vjjBUEV6KudR9CzJiHMyS99+y2PcRsfCHPTEx8dDcVYr+d1caW1vVMMX/LNXkneeKv2D8UGh0KXQMq46y2ypyqXslyNhuim7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwGViOBREdeVNPUrkc1tkZ7iN0AbwVQUrxsdH1tFfSE=;
 b=ipZU123My3NKYGtmn0XzwxabC3Pc9Yjc4KST2WLsdyWyZDcy/alMkQuvKPIKDFKKV+uBjyvMtIoj586V1a1xzyaTOD6sAfPHc4jOUH1PAP5boHxDsUUBiPYukAJ2QKxHIMkqWTeUU8CjqtatvljDlhJyM+PUQQYptayMCYigiZ0MXwCdncIH7e3TvJVR9FtOXDffsf3wknOIN+Bfjp85yKCHOH+/zm8YJUn0r8Y5/rq4qf8KhQ30H1Y5oQ2FmR20Z2jW7HpNx1qz9xf66aEtoQwYOKBDuLZkQ0iADZnjpMxn9dnkBQkvpvCWcCUVINSWAnkcKjY42YM+p3TsZNanJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwGViOBREdeVNPUrkc1tkZ7iN0AbwVQUrxsdH1tFfSE=;
 b=VNn3WIwA6hbbLrLoYAQsRQWhLREsRvcBkW2rDnDdplLhGxVaBEXSphIpRCkYWAbI1RflC4Fx2ARCkBwaFNKC/9Im8H37ltiOcoT5CICY8W44NqK9acTjUvPVTh/mcCDPisQvDOyC8LbtPJSuS23L0wn+WtIdmmwJyfovcTKI7JfD4w6t3TZeaeZpFVCWMqXYQk0QXNstappthggxDbcD8SUu2vJHq+/3HfPktfVLvoxTNSqcxN6MmcpoTWTYCH7VTLPPdTe3UPZnVqgkcfwSnRoklfTv/nG6FYPe3QotzEvgekkp+zEnYqsjbxgZ+evzw77zkchGByMX+lVcDOp0fg==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by MWHPR06MB3086.namprd06.prod.outlook.com (2603:10b6:301:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 22:41:41 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c0e4:f1d:b373:4360]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c0e4:f1d:b373:4360%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 22:41:41 +0000
Date:   Mon, 27 Jun 2022 17:41:37 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
Message-ID: <SN6PR06MB5342127A5A94A0DB3507E27AA5B99@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
 <20220627221444.3638-2-macroalpha82@gmail.com>
 <SNQ5ER.4MEKNEQLW6H11@crapouillou.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SNQ5ER.4MEKNEQLW6H11@crapouillou.net>
X-TMN:  [59DmpWjQJhXH9E3LWJMl324kJIIu7DyPyIbxiZcOn62rDKcZoc6FYl6rl1mNhlaC6HkmXwt0be4=]
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <YroyIal+0eA3vdjD@Dixie>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a7339a4-2e2f-4283-c758-08da588e33ea
X-MS-TrafficTypeDiagnostic: MWHPR06MB3086:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUvxnwsP47gsSb7IO5GuwJTKH4/J03bmQ2m5QkwABoujBQU7Yf439gBdm9Kj6J3w8XPnx/RcugtacOvNZfiiKFTbzW85QZ1YolvASnFnh7p3M0M4n5kEu1pXg95RHh/v95H8O2RhPbxc1dkCxHYy+HvI9E9RXg0bI/u7i4sgKTaPdnVBtLg+tHgDc6lUQIgMWbeFilWN4S8dhVdLwfbjwHz/EKKOOQZULqc0KWGrVKDv9Hv5DzhcdlkC6EwvY0xStdtW+NuwG/cRbonVt69go7PQ/slBre3FeJ7vE2/M/T6rWEX1Okz6V8fJQ6zQj+se2CXFcSha3QorgHWdZ66JHD4Jo1et16wBo4T2mJjJQm1NncHMWApfiVVy1WMLbynR+rj49M7pyb7x0ua0fenCBdu8v5i9exuw1MmoQQGdrfnglCmL/khPK3V3GzwWIq3MJfhj0+t80pi+kX5gF69PoY9sv/zxZJ4dbx+3MhoD5P9GSspeJeEkMnwjLQh0fWEw0R5LAI82YuuUqYq9TP/WwG042NcaBKj7L0jj0yBglXV5ZLY6iI6zKTUTcsG3IK9WFHozecgTwzX8c4/+9v9tewHun1kIZRJmQGocv8A7WWM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+mMaF0Lvh9JoekQ6mSs2A5wDHWapqksIn6OzUM49O1ltMCTOAo8LXL+iI4?=
 =?iso-8859-1?Q?kj4LxNASNveRwCE/UeFV44Y+/wpTup46mkRKxnjo6teFb96vj8EWRN9NzF?=
 =?iso-8859-1?Q?IPX+P0seBtAfHgQSrPIuLAN32MZfYng5bcvU4H4uLiIhlaTBLzCVnxSTNb?=
 =?iso-8859-1?Q?F+bb+nPUKfpircSiYFVPkn9u4DybmXAmcwQKmEeruM7fVNi5ZVuZyZMlJP?=
 =?iso-8859-1?Q?2LMiIcoI6VaUPpzgJ+LUqlBCfkJkCIa5MifBsV8TUCVWGhl/yEP+sRaZLa?=
 =?iso-8859-1?Q?73Tm87FzRC1sA3AvCtqLc0Bl+AraHSlg1eXqoNacCCXeylfcgkVo4PctVo?=
 =?iso-8859-1?Q?y3X2S7NkHLs0urkaLoC+H6joh6h5t5zNvRgkIRRczxZEC64z5jEoxvupPy?=
 =?iso-8859-1?Q?wP8Bo2LA3UEHuDi9kHR8Tw1tLNZ40spkdrNVysj9+WtOzc+pKck1SVTz+S?=
 =?iso-8859-1?Q?7AN8p9mSH+z4WrXZLMAAFWlV52pLxGjeOY7SP+YzpL/BOCOw5C3ZsP3kye?=
 =?iso-8859-1?Q?6UXjQYklrIdSoZMTl/gTpdEh6TLT736R+yl6BqLmExasVaON+YPTBp4h0p?=
 =?iso-8859-1?Q?OJSS8FY/467q7mUYIK3VAZ4EsyUDLp7d0xNoYVNaZDjp6XFzLU1MoFquVJ?=
 =?iso-8859-1?Q?F7x3HMcLq4++buwn96Fk/Srcgqza5vlSZcQRylp/FetS4EmBAwIEdJzgHd?=
 =?iso-8859-1?Q?v+jx00kwsMdc6fc/0LWOR3H6OCEM51F+B2giOXMRji4XwTiFxFfej+VRij?=
 =?iso-8859-1?Q?ZfsndtHQ1PhdXUie7wBynQ+F8RLqPZaT4C+clU/SLQj/DUAfE1VmCLIZCf?=
 =?iso-8859-1?Q?8McMXbfxrz9noTb9I5iPI3ZRaCuIZq6wmYAzCuvmb/uJnx6RMefbWPqiOL?=
 =?iso-8859-1?Q?UK44ZJtrA7wirkSGD9Y9PnxExKu1gENSWX3PhuR0gxEMFmklV/mPHUAHJ1?=
 =?iso-8859-1?Q?+hMikqaeksMAV/Xg1PjLnKuf0UefoiqByhpnIuzXc3c5RU9W46WyURAt/P?=
 =?iso-8859-1?Q?YDxX3Tj1OUDg/nJcXv2xJo0Bfp57vDQu8IN5TfZJoY4rSBDnt7PhDXmVvU?=
 =?iso-8859-1?Q?cLCo/Ex3l1Rs3oqyv+2MaGE6eGqazekNde09XscaAFk7hR9X5yWAey+YIC?=
 =?iso-8859-1?Q?Pj06AnziYANbyycWG2eHlQZFJ66SeyZb0RgfXqzLl06DNjvBO58dQ7yO3X?=
 =?iso-8859-1?Q?xPmB372IesQVoXzw53q2LDaXzgCULqiYoIviBEsYLjaEn7FJEGwV7MpkE4?=
 =?iso-8859-1?Q?5A+VfhFgBFHe6cssExP6f4CfauOLKkmEsFUWAdRzQtYhwRXERFXz0/+kVD?=
 =?iso-8859-1?Q?d0sAzjqQWt0/fFeeNtBobZ8cl80IshyeyYdUSrmtBaWBt78K0q3u0MrQVR?=
 =?iso-8859-1?Q?SFK7UE5WJKfFVL8XjVi6eG7bIzFzEQ5A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7339a4-2e2f-4283-c758-08da588e33ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 22:41:41.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3086
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 27, 2022 at 11:33:28PM +0100, Paul Cercueil wrote:
> Hi Chris,
> 
> Le lun., juin 27 2022 at 17:14:42 -0500, Chris Morgan
> <macroalpha82@gmail.com> a écrit :
> > Add poll-interval support for the adc-joystick documentation. This is
> > an optional value and if not provided the adc-joystick works as it
> > does today (with triggered buffers). If this value is provided, the
> > adc-joystick driver is polled at the specified interval.
> > 
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> > b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> > index 2ee04e03bc22..2d755091e46d 100644
> > --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> > +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> > @@ -18,6 +18,12 @@ properties:
> >    compatible:
> >      const: adc-joystick
> > 
> > +  poll-interval:
> > +    description:
> > +      Poll interval time in milliseconds. If not specified, device will
> > use
> > +      triggered buffer.
> 
> It doesn't have to use *triggered* buffer - it can use regular buffer as
> well.
> 
> The property should use a unit suffix, as explained here:
> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-units.yaml&amp;data=05%7C01%7C%7Cf6306210eda84b58f7f408da588d1627%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637919660856597552%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=NVqhWKdycQsv0ksiILD8aH%2BnZ6aji%2BhNxSEwBkQlZC0%3D&amp;reserved=0
> 
> So it should be named poll-interval-ms.
> 
> Cheers,
> -Paul

Understood, though the logic here was to be consistent with existing
implementations (such as adc-keys and gpio-keys-polled) which all
use poll-interval (no ms). Honest question, would it be better to be
right (poll-interval-ms) or consistent (poll-interval) in this case?

Thank you.

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >    io-channels:
> >      minItems: 1
> >      maxItems: 1024
> > --
> > 2.34.1
> > 
> 
> 
