Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC46552404
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbiFTSgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244052AbiFTSgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:36:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C31EEE5
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:36:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e40so3749947eda.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kG4pk4qMiSjIkCUrviSj7SrIFLKc2G83JxeFowy+F9c=;
        b=C2wk3tjYdnifV6rhO801M9V9puiGwWkdAr1tE8w4yWX5v9iMumkj9ke174taI95isJ
         xcjSh3ViOeT2nmtPktHpyfItMkxWfwZhQU+SwFrCHS2MqE18BJEuCzBkGVCPmAyK7T+Z
         dfEbm0tuZQzqAspciWPkVOvV9EUMoXFaoxSF1IqXx0hl/CIT32R7Wx+blOpMe+4Smi50
         u8rHSrcNLrq+B84WhVB1LiqJ25Gvgyv2Tz/lHqa6dTuQaSgCu07qxGLftytMtaiH0WWQ
         OpntZQmO85/gmox2D1pV0hIPZ3zcESapnQyebe8XmJnoqP/UJoTb0FQOr/yIyfUEiSLG
         3BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kG4pk4qMiSjIkCUrviSj7SrIFLKc2G83JxeFowy+F9c=;
        b=STFeBAJunf8er0Ie9zqs6fvMlBZ+gkNFQZ+u4G8vWBohgGpgCQuDNikDSbww7fd/oj
         KCYfly8pYJeRRSGVrlGYPIummQumT94lTedGgJsodlhty1581Z9EFbx1uHRRquEGv8yB
         /+dU7AE5Rwq6vKDAq3abqA+EfP3QQBkv5qUEoDGM0Se6n5SQSl0oSzNba1807GDgW/ED
         AIz0VcvkuzlAqZeN/evnbO1QIa9uUzqrj++lrFaO5dRc5kUaVPHrLbWPHidJ54tCRRoJ
         FNv/lvtcfMhFRoYWzgDh/Q5jBP+kM99cYpr0m9ocBVu6k+vwE9NdvtOfU3SbQS1rleuc
         4MiQ==
X-Gm-Message-State: AJIora8Qf0FdBamH+a7fw6zUfLHGSB+z9IBfnHGPWFRdDkj4Kw/m5qYc
        zN15WQg4xgoTeQyanktbm6TTSmEhpZWY7Ot/Z3QZi4T41lccMg==
X-Google-Smtp-Source: AGRyM1ti3rOYfMdqRhV/pZiVm9g8vvU9b7HA3u/xROGtf4khmPZ0K/A7gnszUMn6/4N/Y/rf8GpNfnzGtVxXHMXXr+M=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr30448134eda.141.1655750194196; Mon, 20
 Jun 2022 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-12-jic23@kernel.org>
 <CAHp75Vdf3aWaeT17cxsm=a7LUSpc1LnoMGkRQS8O_3ftufprLg@mail.gmail.com> <20220620191307.7f8fefa7@jic23-huawei>
In-Reply-To: <20220620191307.7f8fefa7@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 20:35:57 +0200
Message-ID: <CAHp75VfCydyRKzbzS5Wpsqcm+fiNrz7EWm=+buct=Fe4m9X8bQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] iio: core: Introduce _inputoffset for
 differential channels
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 20, 2022 at 8:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 20 Jun 2022 01:20:08 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> So to try and explain what this is doing in more depth.
>
> This is basically applying a negative offset X to both the P(ostitive) an=
d
> N(egative) lines. Hence
>
> measured capacitance =3D (P - X) - (N - X)
>                      =3D P - N
>
> the aim of X being to keep the signal hitting some internal point on
> the device within a range that is measurable.
>
> The relevant text on the datasheet is:
>
> "The CAPDAC can be understood as a negative capacitance
> connected internally to the CIN pin."
>
> "Each of the two input capacitances CX and CY between the EXC
> and CIN pins must be less than 4 pF (without using the
> CAPDACs) or must be less than 21 pF and balanced by the
> CAPDACs. Balancing by the CAPDACs means that both
> CX=E2=80=93CAPDAC(+) and CY=E2=80=93CAPDAC(=E2=80=93) are less than 4 pF.=
"
>
> So basically if you have both sides of the differential pair
> that are too large (>4 pF) then you can drag them together
> down to that range by adding negative capacitance.

Ah, in a long wording it's "measurement window offset". Dunno how to
make it shorter.
Also, 0-point on the axis in math.

--=20
With Best Regards,
Andy Shevchenko
