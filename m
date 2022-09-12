Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6C5B54F6
	for <lists+linux-iio@lfdr.de>; Mon, 12 Sep 2022 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiILHD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Sep 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiILHD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2022 03:03:26 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6124965;
        Mon, 12 Sep 2022 00:03:22 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id k10-20020a4ad10a000000b004756ab911f8so359349oor.2;
        Mon, 12 Sep 2022 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=ZjMf67jo/QZIHrKGou8gdD+3vb4igcY1foOhJ2pOmAk=;
        b=clbA+6MiReyVGEURI/GTysFG+L/r+zT0Tnbp/hYqRYMDo6dCeIEaXiwazwPMHJwAbB
         WdTj73+o0w55jBsNeac5kuWdoVSLfZ6n1fx6WVSMnfQhozUyutHn/5fiMHxaaTm5t486
         /WXFlyk32HrUaNiVIZeiZYud8+o8OJH20Ss1OGSLx1I3IfXjMEh4qpOBbywbuYKo4heu
         3gbfQAfsx511iQTm6rw2t4tCA7IJt/JOHCKwkLOnjFvErGRDYhEzCzCHmY9K1nbG6Ltw
         j5MhI5C196sxMnRDR47SbtH+Sy9goQvgUfD3grJYRfq7fxr4sW/iq8lAfJGciTr0yVIC
         8ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZjMf67jo/QZIHrKGou8gdD+3vb4igcY1foOhJ2pOmAk=;
        b=j7QFLh1f8ypb9D2MX2zX1FEK2wkVYvxCUG9NY2scxgBqnpgchy4MDhYtqSshR8R2dZ
         HSMEw/4zgHZtc32syvXYVsGnXVALJMq7spIvIJMjAi2Zn/HfLo/NEK/9kCZHS1i2r1y5
         A3lFaR9k4K7FVCGjiGITEaWLGkV2UfX6tuTKNxzOqIfvIwjcQSoeem4iP/LntU0GAfd4
         Gf2cf+Sp6hP7/1S122idbsIvqDuWqrMIJvVO46nWiTuvh/8AsCMCnjtUptH3psPGXfnP
         cwyBzCiHm0yOHX670rCOarbOnTlSsBlzg2ss2Lmc6OmSBOGXZTLpZ45rtZCfreO08+GY
         Almw==
X-Gm-Message-State: ACgBeo2hlS8CfjJysn4Wp0lpG7YvuUQCWhed0Z5evxgA1ivXTex3MZD1
        NoiZCLLMT0QJcVFm16F7Vrw=
X-Google-Smtp-Source: AA6agR7px5WNS/7fq2Mn519x1104BSdYvjczwBwqVpHVYKumzAeSEBpraexJ6+gFcOJj634Q0WAREA==
X-Received: by 2002:a05:6820:1610:b0:44a:8ed8:58a4 with SMTP id bb16-20020a056820161000b0044a8ed858a4mr8803463oob.43.1662966201799;
        Mon, 12 Sep 2022 00:03:21 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d6e94000000b00636e9a0cce5sm4139771otr.60.2022.09.12.00.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:03:21 -0700 (PDT)
Message-ID: <ae55b3083389b977e946a6e79ee3faf2c62a79c3.camel@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adi,ad7923: add range-select
 property
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Mon, 12 Sep 2022 09:04:35 +0200
In-Reply-To: <20220911122800.7af5224c@jic23-huawei>
References: <20220909151413.1164754-1-nuno.sa@analog.com>
         <20220909151413.1164754-4-nuno.sa@analog.com>
         <20220911122800.7af5224c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2022-09-11 at 12:28 +0100, Jonathan Cameron wrote:
> On Fri, 9 Sep 2022 17:14:13 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > Document the new property to select the desired analog input range.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml | 8
> > ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > index 40b0a887db57..9041020bdb81 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> > @@ -36,6 +36,14 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description: |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The regulator supply for ADC refer=
ence voltage.
> > =C2=A0
> > +=C2=A0 adi,range-select:
> > +=C2=A0=C2=A0=C2=A0 description: Selects the analog input range.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - 0 to 2xVREF
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 - 0 to VREF
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > +=C2=A0=C2=A0=C2=A0 enum: [0, 1]
> > +=C2=A0=C2=A0=C2=A0 default: 1
> > +
>=20
> Would this be better as a flag / boolean called something like
> adi,range-double?
>=20

In my first draft I actually had something like 'adi,range-disable' but
that felt strange and hacky... Your boolean suggestion is much better
and I have no problems in changing (as the code will also be simpler).
>=20

- Nuno S=C3=A1
