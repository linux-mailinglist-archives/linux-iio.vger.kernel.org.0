Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961416CFD6A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Mar 2023 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjC3Hxl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Mar 2023 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjC3Hxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2023 03:53:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931E133
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 00:53:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so72971861edb.11
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680162811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o7yvdbKzy0WkmXHywiAzLR6FDroxyETUOdt+5J6dXog=;
        b=oEDChhEgZiXuXP8+K1eGL66cEuL1Yj9gz99OQHsVxohz7jqgHmBJ0pKvLhEF00zrQ/
         VjoO6DQ5aeE+PLEjXEVSTc43ALr+ziTXlKpWj8HnDF982ix5zlM5ZRjozHm7y1Sforf+
         nMV2C6ePkZi0RF5KX6xt9aCh8jNREEPbdrRh7qV1iElpwfSG91zG0jiI92rx+0omwaSb
         +zj2ePYsu1SAih1KEfnMktC0r6icF5panrqajOchzEs5Ulron+3aWeQutkgScieKkQ4k
         MgVTDCXG8vo5+ly2OTcCVWIZCtO+FlH5o5U2oL5ApTkYKiZ28HfwDMy7tBbWWrkm3RAU
         GUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7yvdbKzy0WkmXHywiAzLR6FDroxyETUOdt+5J6dXog=;
        b=Nh3zPYHgVdNFA4w058W4yfQsM59jE4/rUZxXMiCoeEfatgOWqI8QpINRDJH+sTCWmw
         ruzLEWI2iZmQvomos53aNi/U+Hk7Ui4bv6VD6pzsc4m6SlFxsGg4gQLEVEeVrNhEVzMU
         n7yNNPj7W8hQ3fkvAg5ptnbFEGumILl7Ih5jP8JPkrasQKuMp+ZWCVj80ZbK/BAo1Kfh
         lnZQUE3UhWX6ibi0g5KJfermBjJaw+OyJb2XdFqjSDLt8umU+R0ZgCjsr276SHaGK2lA
         iJNbN1DOyPIGASq5edg2ciaZPL9L1pWY1v13xedL6LTFlkY12X6jGP56ZAuIgcGnBPL/
         DiRA==
X-Gm-Message-State: AAQBX9dfpP7hFub1ulb8UhK2QSI3I2pHbZv+PxrFMa4bvjXT9MZQFeNN
        IanxUPDbTJgpWz+bIjVBn2w=
X-Google-Smtp-Source: AKy350bP8E+yFfGpYGR/z4wnnRTORQRS4baUGvhl8lbNGHX7cz2niLH2lk7TEXh1lRrp13wi3Vd6UA==
X-Received: by 2002:a17:907:7784:b0:930:e2c:ddc3 with SMTP id ky4-20020a170907778400b009300e2cddc3mr22352522ejc.72.1680162810727;
        Thu, 30 Mar 2023 00:53:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id sc36-20020a1709078a2400b0093e39b921c8sm7875297ejc.164.2023.03.30.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:53:30 -0700 (PDT)
Message-ID: <11450376865596c3c1ef6cf54a71fc63924e7d90.camel@gmail.com>
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Date:   Thu, 30 Mar 2023 09:53:29 +0200
In-Reply-To: <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
         <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
         <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2023-03-29 at 23:23 +0200, Fabrizio Lamarque wrote:
> On Wed, Mar 29, 2023 at 5:15=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om>
> wrote:
> >=20
> > On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote:
> > > Allow the use of external clock when mclk clock is defined.
> > > When defining a mclk clock source in device tree with adi,clock-
> > > xtal
> > > property, the external crystal oscillator is not turned on.
> > > Without the change, the driver always uses the internal clock
> > > even
> > > when mclk clock is defined.
> > >=20
> > > Current implementation seems to contain a typo, since it expected
> > > st->mclk to be NULL within ad7192_of_clock_select() in order to
> > > select
> > > the external clock, but, if null, external clock cannot loaded
> > > correctly (out of bounds due to invalid mclk) in ad7192_probe().
> > >=20
> > > I believe this patch follows the author's intended behavior.
> > > =C2=A0After applying this patch, the external oscillator is started a=
s
> > > expected.
> > >=20
> >=20
> > Yes, looks like a valid fix... Just missing a Fixes tag.
>=20
> Thank you for having this patch reviewed.
> Here is a backwards compatibility note I believe you should be aware
> of.
>=20
> Without this patch, the DT node shall contain (any) clock property
> for the driver to be loaded properly.
> The clock frequency is ignored, as it is ignored adi,clock-xtal
> property.
> In case clock property is not set, the initialization always fails.
> There is no way to use an external clock source.
> As you already verified from source code, this was not intentional.
>=20
> While the proposed patch should make the DT config load as intended,
> there is a possible side effect on existing implementations relying
> on
> internal clock source only, that would be deactivated when clock
> property
> is defined in DT.=C2=A0

Hmm, I see. I would argue anyone relying on that should have just
stepped forward and fix the real issue as you did :). So, maybe there's
no one actually relying on this but that's a big __maybe__... Not
really sure how to handle this. I'm not sure we want to keep
compatibility with something that's clearly wrong but often we need to
"live" with past messes.

Jonathan I guess your input will be valuable here :)?

> In addition, bindings documentation states clock
> property is mandatory.
>=20

This looks at least suspicious to me given the fact we have an internal
alternative. Clearly looks wrong to me...

- Nuno S=C3=A1
>=20
