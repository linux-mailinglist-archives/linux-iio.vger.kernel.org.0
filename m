Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E355CDBC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiF0WsH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiF0WsF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:48:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9651178;
        Mon, 27 Jun 2022 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656370083; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xknAKzgfYNpXnYc+9+SUOkimvItPUBqAGTB2HGXSU5A=;
        b=BGgeaq19W1NDn8qeFhzGAlv/jtBXfWAX6YXqdVWU7Sx5gmJtGAWeUQqFjQmMJbZvLL9+1E
        yMwpkH5xuCRmJS37mbQetzTaLoOwod2bVmsP1sdsFhOo/HL2qLpiTDNG+4Q21nlnXmy7JJ
        VwXX/8+4esBkBEGueuMxrAMWVScRYSA=
Date:   Mon, 27 Jun 2022 23:47:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/3] dt-bindings: adc-joystick: add poll-interval
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Message-Id: <SBR5ER.1Q6Y9XTXJWIK2@crapouillou.net>
In-Reply-To: <SN6PR06MB5342127A5A94A0DB3507E27AA5B99@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
        <20220627221444.3638-2-macroalpha82@gmail.com>
        <SNQ5ER.4MEKNEQLW6H11@crapouillou.net>
        <SN6PR06MB5342127A5A94A0DB3507E27AA5B99@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le lun., juin 27 2022 at 17:41:37 -0500, Chris Morgan=20
<macromorgan@hotmail.com> a =E9crit :
> On Mon, Jun 27, 2022 at 11:33:28PM +0100, Paul Cercueil wrote:
>>  Hi Chris,
>>=20
>>  Le lun., juin 27 2022 at 17:14:42 -0500, Chris Morgan
>>  <macroalpha82@gmail.com> a =E9crit :
>>  > Add poll-interval support for the adc-joystick documentation.=20
>> This is
>>  > an optional value and if not provided the adc-joystick works as it
>>  > does today (with triggered buffers). If this value is provided,=20
>> the
>>  > adc-joystick driver is polled at the specified interval.
>>  >
>>  > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>>  > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>  > ---
>>  >  Documentation/devicetree/bindings/input/adc-joystick.yaml | 6=20
>> ++++++
>>  >  1 file changed, 6 insertions(+)
>>  >
>>  > diff --git=20
>> a/Documentation/devicetree/bindings/input/adc-joystick.yaml
>>  > b/Documentation/devicetree/bindings/input/adc-joystick.yaml
>>  > index 2ee04e03bc22..2d755091e46d 100644
>>  > --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
>>  > +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
>>  > @@ -18,6 +18,12 @@ properties:
>>  >    compatible:
>>  >      const: adc-joystick
>>  >
>>  > +  poll-interval:
>>  > +    description:
>>  > +      Poll interval time in milliseconds. If not specified,=20
>> device will
>>  > use
>>  > +      triggered buffer.
>>=20
>>  It doesn't have to use *triggered* buffer - it can use regular=20
>> buffer as
>>  well.
>>=20
>>  The property should use a unit suffix, as explained here:
>> =20
>> https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fpr=
operty-units.yaml&data=3D05%7C01%7C%7Cf6306210eda84b58f7f408da588d1627%7C84=
df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637919660856597552%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C3000%7C%7C%7C&sdata=3DNVqhWKdycQsv0ksiILD8aH%2BnZ6aji%2BhNxSEwBkQlZC0%3D=
&reserved=3D0
>>=20
>>  So it should be named poll-interval-ms.
>>=20
>>  Cheers,
>>  -Paul
>=20
> Understood, though the logic here was to be consistent with existing
> implementations (such as adc-keys and gpio-keys-polled) which all
> use poll-interval (no ms). Honest question, would it be better to be
> right (poll-interval-ms) or consistent (poll-interval) in this case?

I guess those don't have a suffix for legacy reasons, and newly=20
introduced properties should follow the standard.

But I guess that's a question for DT maintainers.

Cheers,
-Paul

>=20
> Thank you.
>=20
>>=20
>>  > +    $ref: /schemas/types.yaml#/definitions/uint32
>>  > +
>>  >    io-channels:
>>  >      minItems: 1
>>  >      maxItems: 1024
>>  > --
>>  > 2.34.1
>>  >
>>=20
>>=20


