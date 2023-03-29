Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9146CF555
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 23:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC2VY3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC2VY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 17:24:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8996765BE
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 14:24:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s8so11205282pfk.5
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680125047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRTBimcc0VGL7apQmWjlZBuMYB1iX02WzAIimHOuWHA=;
        b=jlHplgokrNiiGXvd33h2Dg5l/QGJW4hM05amG0ij42d7eL+YaVxnwmx+f96ymd14br
         oxryOl9oKLF+Ebl4aTdulop7XOi/f2C2/0bZUccrdZ7b+BqSIHMQDmS9IIXXHy/jTYHF
         KZIvFZmug/VahV0hZnghBlzw3zqpAULWQNxTDOSa7vks+GMQkzsM9v2GrenI2SBYTwKP
         3IiRCx4ziM1Raa1zcNhVxjLsXaFXeSBBBCX4l/+FzdnkryKy80cxpUJn6CoJ32zu4qeC
         OkgHmYcKuaSNwligNXBquDzIXfCcsyabgrHuCnbTQEEC/WHUMnUXsxLB0G8ldXz2FErH
         MYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRTBimcc0VGL7apQmWjlZBuMYB1iX02WzAIimHOuWHA=;
        b=YnzcUE6YwWPWRF/NJRb0A8FiyLGJqk90K7RMCKnEH6M0L+4ArLWqmzZM0uQQC0Q7er
         6Rnv85gYGlnVcdRv16DFLHPBeFSvezSfWC0MEkGjBV3fPe0DEid+TiRgkZesKyWkT7Qf
         TJiWRnEEdnC9E/A+f56K10pxmZytBipeuca4X2VBqfchwO9YY2Rfz+hfRNLH1cQdPRfu
         3pjRTEQtKFx8Ob7cwUjuWemYamGqfzSGrwZUc5rhp12Z/kc7+dW5ymEb08UbsMfWnEtJ
         caeyf0yKklUp+yPiPDoSjnl/LwQS6yfjA0ltWIeEmfhlF5HUH6jO+q+RHqhfqMxPL5zT
         Jmgg==
X-Gm-Message-State: AAQBX9elN2rIVzaeg7mrYkOwRcLpgm7rJeq0jqLhnhajY2d71To9rpz+
        ilAe97fM6gKGB6ilFCr0fR4V8Xv3CIpcbu7pwS998O+zpPM=
X-Google-Smtp-Source: AKy350YrVVH6h6MNvFhXnHXI2YfK+xh9/qQgSDQZBhRDBtp4MkXd4eQIMuD7J2YbzOTmHqNqoOcvDhH+R6LX9Jd0kFk=
X-Received: by 2002:a63:d657:0:b0:50b:189d:d1a with SMTP id
 d23-20020a63d657000000b0050b189d0d1amr5640462pgj.10.1680125046869; Wed, 29
 Mar 2023 14:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
 <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
In-Reply-To: <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 29 Mar 2023 23:23:55 +0200
Message-ID: <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 29, 2023 at 5:15=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote:
> > Allow the use of external clock when mclk clock is defined.
> > When defining a mclk clock source in device tree with adi,clock-xtal
> > property, the external crystal oscillator is not turned on.
> > Without the change, the driver always uses the internal clock even
> > when mclk clock is defined.
> >
> > Current implementation seems to contain a typo, since it expected
> > st->mclk to be NULL within ad7192_of_clock_select() in order to
> > select
> > the external clock, but, if null, external clock cannot loaded
> > correctly (out of bounds due to invalid mclk) in ad7192_probe().
> >
> > I believe this patch follows the author's intended behavior.
> >  After applying this patch, the external oscillator is started as
> > expected.
> >
>
> Yes, looks like a valid fix... Just missing a Fixes tag.

Thank you for having this patch reviewed.
Here is a backwards compatibility note I believe you should be aware of.

Without this patch, the DT node shall contain (any) clock property
for the driver to be loaded properly.
The clock frequency is ignored, as it is ignored adi,clock-xtal property.
In case clock property is not set, the initialization always fails.
There is no way to use an external clock source.
As you already verified from source code, this was not intentional.

While the proposed patch should make the DT config load as intended,
there is a possible side effect on existing implementations relying on
internal clock source only, that would be deactivated when clock property
is defined in DT. In addition, bindings documentation states clock
property is mandatory.

I tend to dislike any solution that keeps the existing flow (and do not
break compatibility). Nothing that comes to my mind would be as simple
as this logical flow correction.
In addition, I checked the driver history and it looks like the minor bugs =
we
found in corrent implementation (see previous patch about NULL pointer
dereference) have been there for several years.

In case backwards compatibility is a real issue, I could rewrite the patch
so that an explicit external clock source property could be used instead.
If so, I kindly ask you to suggest an acceptable property name.

> > I kindly ask your feedback, I may adjust the patch according to your
> > suggestions. I could also follow up with another patch on
> > documentation, containing the following (related) issues:
> >
> > - adi,int-clock-output-enable is undocumented
> > - adi,clock-xtal is undocumented
> > - regulator name avdd and its description is quite misleading, since
> > this is unrelated to the AVdd pin (#20) of AD7192; it is used instead
> > as reference voltage (REFIN1 on #15/#16 or REFIN2 on #7/#8). See
> > int_vref_mv variable within driver implementation.
> >
>
> Don't think the above text belongs to this commit message. That said,
> it would be great if you could follow up with a couple of patches to
> document the undocumented properties. As for the regular name, I think
> it's not so trivial to change it's name because there could be already
> users using the property like this. So, I guess we have two ways:
>
> 1) Just add some description in the property to state what's this
> regulator really is about.
> 2) This one is more complex but might be the right one... Deprecrate
> the current property (you can mark a property as deprecated in the
> bindings) and add the new one with a proper name. Then, you need to
> change the driver accordingly keeping in mind that it must still work
> with the old, deprecrated property.
>
> Was lazy to ckeck but I'm assuming the bindings are already in yaml...

I can confirm bindings are already documented in yaml.
I will try to submit a patch with the missing documentation and the
proposed solution 2 in the next days.

>
> > Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> > --- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42=
.646239506
>
> Anyways, for this patch and with a proper fixes tag (and with the
> unrelated text removed from the commit message):
>
> Reviewed-by: nuno.sa@analog.com
>
>
