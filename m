Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC23A54777A
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 22:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiFKUX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiFKUXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 16:23:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25066FA4;
        Sat, 11 Jun 2022 13:23:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o7so4122556eja.1;
        Sat, 11 Jun 2022 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR6Bba/jjTivbjKb53X32y+cnbJ2EBiELomjvizb5u0=;
        b=NV6kDJOviUf/iKrLCMsA6nz/uDeXz0gJRutt9NLRueYhtkqt7POhYsEKZzOHWfQ+HM
         v1Atw4Y4hKUfbXGOiuHohNAPFzA3460O417GDrYHURJYYFIiN2Pkj3T+xTnNnlffshJw
         XJqfDjqn7SqtaH84cA2gOAdAlsHc63/ASiQYOK0xjZwDn4X71rN/rzE9WUjrURUBILrQ
         c413d1hjw6rmsdGNF4up7EuOFGxK/cqVmlCk2O3M+pjZeY2Gr1WJ235QyEodR8Q7xP6i
         MnSWzRXOoem/V3lMyYfDbyaXi37U7bjudP9g32vZHgb1Xlo1ivuaGBIkftbAIV+xTi96
         Gm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR6Bba/jjTivbjKb53X32y+cnbJ2EBiELomjvizb5u0=;
        b=uW0wEo+ZAuJHYKDqa/w611zsY2n1fzlQlGUouttdLGj1xUEaybaJDUnlikHQPtseLK
         j2ccYrtAUGxsPMmflCYgHG4Rw+G9V5C5+6mBIavozzSMRL90A3lKNrDB8Gf8nvjais9z
         F00RQY4uwvIVSIfk2PCfaOqSoR7c5O/RsBPzJP5kUQ0x8T/FepDEWVfodJ1W0Xf3ld7O
         SETOQC4/x6xXtavLXhUl8eU3eoUT1ehlcj981moXGKu0tyTR0hmowF9lrF0cG5a1xg1Z
         WXlSU7eyNYzNUvZFGK5jzyjpQF8sZ/EWM7TskCqcU95IwaLcHagkDH9xMBjOHD2OZqLZ
         r/UQ==
X-Gm-Message-State: AOAM532m8Wr++FQlGkrSB5GcRffK/gVKM6g9TrOUQIXGqVKBzqhrbE2c
        F/vLOp9R7Fz71ay1Qs9Kg8XlJduilANhc8dGUV9AcADfZW1EmQ==
X-Google-Smtp-Source: ABdhPJxNfGO9LtoN7rgf0NT4NTB1VD80LfBvAigjAKBNUOkT87t54TId5mqZj/pcimLQaaVmRDG51bt5Kst0BdMFuPI=
X-Received: by 2002:a17:907:9721:b0:70c:65e7:2aa5 with SMTP id
 jg33-20020a170907972100b0070c65e72aa5mr42664594ejc.132.1654979001053; Sat, 11
 Jun 2022 13:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
 <CAHp75Vdg2i8NjrFn5gtKBKNbYrWd49nq31Exy=4K2RsxHeQ1hw@mail.gmail.com>
 <6ac31983-698c-5333-da4b-4f562c47afc7@rocketmail.com> <CAHp75VeprMCdP_HqcVUhQow_OStKDMF4c2k5s1gs7RwOTzO=FQ@mail.gmail.com>
 <7265c507-b32d-c2e3-d9ca-876d9382a8e8@rocketmail.com>
In-Reply-To: <7265c507-b32d-c2e3-d9ca-876d9382a8e8@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jun 2022 22:22:44 +0200
Message-ID: <CAHp75VfV1E1WaLVDG3V9460AsVxahb9Epod-63T35eDV+h8Ubg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 11, 2022 at 4:00 PM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Hi Andy,
>
> (Side note: There is something wrong with the Cc list in your e-mail,
> the list of addresses isn't handled correctly.)

The list is the same as in your mail. Dunno what exactly is the
problem you are referring to?

> On 11.06.22 12:56, Andy Shevchenko wrote:
> > On Sat, Jun 11, 2022 at 1:57 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> >> Ok, I'll remove those direct regmap reads in yas537_dump_calibration().
> >
> > I'm not sure I understand what you are going to drop. I was talking
> > about debug messages, the regmap reads are fine. Or you are talking
> > about them as they are tightened together and one makes no sense
> > without the other?
>
> Yes on your question. In the new function yas537_dump_calibration() I
> added some regmap reads that are performed only because of debug
> messages. I'll remove those regmap reads incl. the corresponding debug
> messages. However, I'd like to keep the "other" debug messages.
>
> I'll explain more detailed.
>
> Generally speaking on YAS530/532:
> At driver probe, calibration "raw" data is read from the calibration
> register (currently YAS5XX_CAL). Within the driver, this data gets
> processed into several calibration coefficients like e.g. c->a2. These
> are later on applied on the measure data.
>
> Calibration debug on YAS530/532:
> After reading the calibration "raw" data from the register (for further
> processing), we dump that "raw" data to debug. After having "calculated"
> the calibration coefficients like c->a2 within the driver, we dump them
> to debug too.
>
> Generally speaking on YAS537 version 0:
> There are two versions of YAS537. Version 0 reads calibration data from
> the register (YAS537_CAL) and writes it directly back into some other
> registers. The driver doesn't touch anything. This is done in new
> function yas537_get_calibration_data() after "case YAS537_VERSION_0:".
>
> Generally speaking on YAS537 version 1:
> Version 1 of YAS537 is a mixture. Some of the data being read from the
> calibration register (YAS537_CAL) is directly written back to some other
> registers. But additionally, some calibration coefficients like c->a2
> need to be "calculated". This happens in new function
> yas537_get_calibration_data() after "case YAS537_VERSION_1:". The
> calibration coefficients will be applied on the measure data later on.
>
> Calibration debug on YAS537:
> In the new function yas537_dump_calibration(), I implemented that
> mixture also. Firstly, I added some regmap reads and debug dumps of the
> registers where some of the calibration data was written into. Secondly,
> for YAS537 version 1, I dumped the "calculated" calibration coefficients
> like c->a2.
>
> What I intend to change for patchset v2:
> In the new function yas537_dump_calibration(), I'll remove the two "for
> loops" (they contain the "unnecessary" regmap reads and debug dumps).
> But I'd like to keep the debug dump of the "calculated" calibration
> coefficients after the "for loops".

Sounds reasonable to me.

> >> However, I'd like to keep the others. The calibration data is dumped
> >> before [1] and after [2] being processed by the driver. This is helpful
> >> to check if it was processed correctly. Dumping the data is done only
> >> once at probing.
> >
> > Then it should be probably dev_info() in such cases.
>
> To my understanding, in this case it's rather debug. If at some point it
> turns out that the driver doesn't work correctly, it allows a deeper
> insight on the intermediate steps the driver is doing internally.

OK!

> >> In yas537_dump_calibration(), I'd also like to keep dumping the
> >> "hard_offsets". Currently there is no linearization formula known for
> >> YAS537. Providing the "hard_offsets" may help to find a way.
> >
> > I understand that, but per se this is not for production esp. taking
> > into account that regmap has a tracepoint mechanism.
>
> Well, ok, I'll drop the "hard_offsets" debug dump.

-- 
With Best Regards,
Andy Shevchenko
