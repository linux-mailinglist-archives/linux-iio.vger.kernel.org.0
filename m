Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23362648ABA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Dec 2022 23:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLIWYK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Dec 2022 17:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLIWYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2022 17:24:09 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8813F60
        for <linux-iio@vger.kernel.org>; Fri,  9 Dec 2022 14:24:07 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id f184-20020a4a58c1000000b004a3c01646a0so269777oob.12
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2022 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0niFOJtseZKpNqdp7Vx1SkJWAbHvAgltgpslEU1rios=;
        b=ZthfjG8mjewWB9eae366IW4b62xtMBDXTGmfIMRwYZeVDo9XwCKj3gbixD0w95mX7d
         mHgExb1PF8V8wqmwB5OwisI4eDrmRc5fu0ptzV/55nCqzQNi1SCtxvLWW3MmC7NSJrMe
         cXnW4IwbeKdBWO6R0lqa6uD77PsBY+ifPZxykrPR5yDyq6KeMPKR2ojHSUaeINq1AzKT
         KidqCJkTyn1ANnE7cgACv665rsc6ktCRCBxlO8mEUBjlOs3oxSbfhXd/CxEoazW1H6M3
         v8y1U8nE4ZJcsGx3Dtf/mm1kk7Dea6nO1LF6bXf12OdhSrVV397bXq4IuwbDWkKwPm5n
         aoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0niFOJtseZKpNqdp7Vx1SkJWAbHvAgltgpslEU1rios=;
        b=gr3J8xyC+7TTZtS/6ly5HX/KDKD+2n/b+QVSHn/xXYB0bIudgn2oZQq/aRPh3ldJ1m
         NPltxc+M5O0I/VuJe8RPyitQLfzEYB9iQdlAvhtwP5eoottP63VNKid4yB6MAWSrUElE
         IYtHhYt06+OXzttIyjnhGu2E45ATgJ+weRJQZixQiojBW/fJfnTRRf80lHaLypJsmRvF
         M7X2YVekCsOY2ceG8UrKmEEDxSsSasym5HngNmI2/iEjJMIY/oz9ZKsrkBl7Lc9+sCTX
         3AnzHYzuE0GP0zz5A7yefvkMoA1/eaCkpurbSMBBvc8imdDZRZD6/P8JyHmMJzKdoT+G
         O4LQ==
X-Gm-Message-State: ANoB5plIQjou8bripLVtlxQunDPqoKCEDTddaDPsik3DmCvk08oyjU9g
        Bp0+C4kyLjiCLXIx+gidX0w7mw==
X-Google-Smtp-Source: AA0mqf6YezcedWqO5/DfQ5Hh5KjmW+9LYC+dlAS/gPvAELaB4jrAICD5YQomLLQmCgeSgLlXx2Ehtg==
X-Received: by 2002:a4a:dc8c:0:b0:4a0:c270:2f3f with SMTP id g12-20020a4adc8c000000b004a0c2702f3fmr4138546oou.3.1670624647102;
        Fri, 09 Dec 2022 14:24:07 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c127-20020a4a4f85000000b004a0ad937ccdsm882932oob.1.2022.12.09.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 14:24:06 -0800 (PST)
Date:   Fri, 9 Dec 2022 17:24:03 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Message-ID: <Y5O1g8/69tCfmdW6@fedora>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <878rjjfprw.ffs@tglx>
 <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87sfhrdure.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YkhtusH7Lbb0s/D9"
Content-Disposition: inline
In-Reply-To: <87sfhrdure.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--YkhtusH7Lbb0s/D9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 05:49:09PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 07 2022 at 11:35, Biju Das wrote:
> > Counter, It can be used as measuring the processing time of DRP-AI.
>=20
> Sigh. You can do that with the architected timer too, especially when
> you are going to do the measurement in user space.
>=20
> clock_gettime(), which uses the VDSO with the architected timer is fast
> to access and accurate.
>=20
> Thanks,
>=20
>         tglx

Hi Biju,

It's true that you could implement a Counter driver to achieve what you
want here, but I don't think that's the most apt interface for this
device. Your device is used to measure the processing time of DRP-AI, so
modeling this as a clocksource seems like the right approach to take.

Of course, if there is something missing from clocksource/clockevent
that you need, then it should be added to the subsystem. So let's try to
narrow down exactly what functionality you need.

You gave a Counter use-case example earlier where you can configure the
ceiling value of the timer (e.g. to 1usec or 10000000usec) and push
Counter events on the interrupts that trigger off that that
configuration; the Counter subsystem can logs the current system time
everytime a Counter event is pushed.

Could the same thing be achieved using clockevents framework instead?
With this approach you would register an event to fire in the future
(e.g. 1usec or 10000000usec) and then call clock_gettime() to get the
current system when you're notified of the event. Would this approach
work for your use-case, or is something else missing here?

William Breathitt Gray

--YkhtusH7Lbb0s/D9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5O1gwAKCRC1SFbKvhIj
K8zuAP4uMkkxnrQ9VzRVJNsRxxSLOWknl898zSxxh2gIpvALaQD8DStd05P+6buF
P9QDJciknANFclFf6QmJ5Pg8Sh6nCgs=
=/qcp
-----END PGP SIGNATURE-----

--YkhtusH7Lbb0s/D9--
