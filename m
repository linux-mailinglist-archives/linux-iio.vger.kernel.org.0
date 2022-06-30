Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C70B561EC7
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiF3PI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiF3PIZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 11:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64F1A067;
        Thu, 30 Jun 2022 08:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECF560E33;
        Thu, 30 Jun 2022 15:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44315C341CC;
        Thu, 30 Jun 2022 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601703;
        bh=q/9rqixvnwRfQ+EtvQPTfLn8uq6KAFmVqNubicMDw2Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJ9FbAuY6n1FY4kSD3Wq6b5wjgQ1ao2bBpo5btiivo5BYTeNtDEcZewVnp5RX/uOB
         y92yLxXIEgOFOdasuGFWmXyXoFqXRabsdFun2feiC90zZh7PTJYXDpuPB6N47B8Zbx
         FteJ0zJBtXNryg5wT1sYHIu8FcnfQsBdWNwaVF53eEzg691OB9lfrPo90UnnODPmna
         4GfjiqJA9pWFA/oyurMPdj5Wjqk1AtYkAZVaPMSyMQBu4cNWHSTUF+4zfGI7vUV7zN
         79IXH0lqhTCvBSXkjEV8cZzhnSKCub1ngWNgkxS1sRWqDktMS0J4HgR3UcpiyFG73o
         ht/FSR2aN0O0Q==
Received: by mail-ua1-f54.google.com with SMTP id l7so6772451ual.9;
        Thu, 30 Jun 2022 08:08:23 -0700 (PDT)
X-Gm-Message-State: AJIora9p4dow6OZFQ1+HIBon56vFqURHJk/B7tFcvUh/cLSHEWoMi535
        JKJqL6wuuOvDcML8u7ceSacLQDk7s+IbMvMayg==
X-Google-Smtp-Source: AGRyM1sObcxAalT9017M3dq2ezwigOfKmKEr3S6EfKkABDgf8dX2vE9oCJRR/0n38M/vuhBZoig9hREkdFfyvRxclJY=
X-Received: by 2002:ab0:6857:0:b0:37f:15c2:b949 with SMTP id
 a23-20020ab06857000000b0037f15c2b949mr5133541uas.86.1656601702251; Thu, 30
 Jun 2022 08:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221444.3638-1-macroalpha82@gmail.com> <20220627221444.3638-2-macroalpha82@gmail.com>
 <SNQ5ER.4MEKNEQLW6H11@crapouillou.net> <SN6PR06MB5342127A5A94A0DB3507E27AA5B99@SN6PR06MB5342.namprd06.prod.outlook.com>
 <SBR5ER.1Q6Y9XTXJWIK2@crapouillou.net>
In-Reply-To: <SBR5ER.1Q6Y9XTXJWIK2@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 30 Jun 2022 09:08:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKN-NHv21kmuZ10Yw_Yxm6Qw17khqyKDCgXnFaecJsgXw@mail.gmail.com>
Message-ID: <CAL_JsqKN-NHv21kmuZ10Yw_Yxm6Qw17khqyKDCgXnFaecJsgXw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        jic23@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 27, 2022 at 4:48 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le lun., juin 27 2022 at 17:41:37 -0500, Chris Morgan
> <macromorgan@hotmail.com> a =C3=A9crit :
> > On Mon, Jun 27, 2022 at 11:33:28PM +0100, Paul Cercueil wrote:
> >>  Hi Chris,
> >>
> >>  Le lun., juin 27 2022 at 17:14:42 -0500, Chris Morgan
> >>  <macroalpha82@gmail.com> a =C3=A9crit :
> >>  > Add poll-interval support for the adc-joystick documentation.
> >> This is
> >>  > an optional value and if not provided the adc-joystick works as it
> >>  > does today (with triggered buffers). If this value is provided,
> >> the
> >>  > adc-joystick driver is polled at the specified interval.
> >>  >
> >>  > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> >>  > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>  > ---
> >>  >  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6
> >> ++++++
> >>  >  1 file changed, 6 insertions(+)
> >>  >
> >>  > diff --git
> >> a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> >>  > b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> >>  > index 2ee04e03bc22..2d755091e46d 100644
> >>  > --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> >>  > +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> >>  > @@ -18,6 +18,12 @@ properties:
> >>  >    compatible:
> >>  >      const: adc-joystick
> >>  >
> >>  > +  poll-interval:
> >>  > +    description:
> >>  > +      Poll interval time in milliseconds. If not specified,
> >> device will
> >>  > use
> >>  > +      triggered buffer.
> >>
> >>  It doesn't have to use *triggered* buffer - it can use regular
> >> buffer as
> >>  well.
> >>
> >>  The property should use a unit suffix, as explained here:
> >>
> >> https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2F=
property-units.yaml&data=3D05%7C01%7C%7Cf6306210eda84b58f7f408da588d1627%7C=
84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637919660856597552%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C3000%7C%7C%7C&sdata=3DNVqhWKdycQsv0ksiILD8aH%2BnZ6aji%2BhNxSEwBkQlZC0%=
3D&reserved=3D0
> >>
> >>  So it should be named poll-interval-ms.
> >>
> >>  Cheers,
> >>  -Paul
> >
> > Understood, though the logic here was to be consistent with existing
> > implementations (such as adc-keys and gpio-keys-polled) which all
> > use poll-interval (no ms). Honest question, would it be better to be
> > right (poll-interval-ms) or consistent (poll-interval) in this case?
>
> I guess those don't have a suffix for legacy reasons, and newly
> introduced properties should follow the standard.
>
> But I guess that's a question for DT maintainers.

It should be consistent with the rest of the input bindings.

Rob
