Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB51577F66
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiGRKPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiGRKPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 06:15:03 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D2DFB0
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 03:14:59 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31e0d4ad6caso41048997b3.10
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5KwktVv3RFL8SvJnKxvvF07FLwtYMwS3N1+L6Y6twI=;
        b=VxUr0i4AgK4AqB/AkIDTuz3Mom0UZR6cTL7Za5HZXVrCh2kjTBuE7DOww4hgN+plzA
         0RhWjNepQ+BNwbVe6a8LPFhpivI4ju3ScK4x6vPh2PR18vttOr1LmhXx/UggOoVBYFYA
         Ww6aivDflFphXgJHN+2+7up7walDyeiyDQ1ehAMGchDTfAToxKF7DmVGfnJ8liuYIqRO
         vE4iMbN/FF5u+Lk+HNHG7BqdYsc0Qeu//Qd+Z9W923mLfOajjKZ8Mr1JTfm6VutX/7H7
         Qe7sw51X1JG3vIGdJn+BJMhlrapi0Ox5ciiaKoQvwkqBcZ9tJS2ec0svljh2vDQo7qpc
         tNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5KwktVv3RFL8SvJnKxvvF07FLwtYMwS3N1+L6Y6twI=;
        b=oAcwZ3bG2pYh3SbiS/cdf+ipkIRG1K4jdefSl/UfsY4c5d08T0iq/SBkADikP3ez5F
         wfJhgmZpccrJG7GYCA5yf3rFjKjC6q+OHR5DEu8YZAUmmy3vvo6DdbGUj2ObzFnxyEZa
         n72Hg4N12AwaMCJL0U44gT9VjlxxNyMiH5/3qvjnUgzibNEWke+CVZdUp0wHGTQl29Qu
         MDCcGzpQLYXDU6h8yAnSZdWO79WieSeFzWUuqgEc9uNuUxN6xcBIxiGr9EczX3gvjLoN
         UQBkegPSf3dzppoAStibYho+mcrd+DKJgbqwE7bRAlUMpbl17WXivYitnffXqp48iamd
         ml0g==
X-Gm-Message-State: AJIora/o9pUNstclIjiuNJH6OgJFOCpAzuVwHjC8QVup7FCMxVzUM7nF
        o1bSoH/XqSK/veg0u/H/mZjVywop91DDcp3Jc1RXRg==
X-Google-Smtp-Source: AGRyM1uOuoAerB8jJOdawVpcTGE/+3sigO6/Bx9Lr96RDPqYwf6FwBKPcVktuh+Nb0TZYaahpwnIAQJKgAapYXEotvA=
X-Received: by 2002:a81:1913:0:b0:31c:fe21:6d68 with SMTP id
 19-20020a811913000000b0031cfe216d68mr29895225ywz.59.1658139299059; Mon, 18
 Jul 2022 03:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei> <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
 <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
 <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
 <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com> <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
 <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
 <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com> <20220713165854.27828d0c@jic23-huawei>
In-Reply-To: <20220713165854.27828d0c@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:14:47 +0200
Message-ID: <CACRpkdYRtSTYdJ8LscE18XYb_gYRjhB9Q2H4H6sZ6h6=MrLWGg@mail.gmail.com>
Subject: Re: [PATCH] iio/hid: Add mount_matrix
To:     Jonathan Cameron <jic23@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, wpsmith@google.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 13, 2022 at 5:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 28 Jun 2022 14:33:09 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:

> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1838
> > > An implementor might consider that for a hand-held device, a
> > > 'natural' orientation would be 'front facing camera at the top'.
> > > The main hardware reference frame could then be described as :
> > > * Y is in the plane of the screen and is positive towards the
> > >   top of the screen ;
> > > * X is in the plane of the screen, perpendicular to Y axis, and
> > >   positive towards the right hand side of the screen ;
> > > * Z is perpendicular to the screen plane and positive out of the
> > >   screen.
> >
> > Note though that this does not clearly define what
> > e.g. "positive towards the top of the screen" means if
> > you look at the axis illustrations in both the Windows,
> > Android and W3C docs they all have an arrow pointing
> > towards the top of the screen for the Y axis, which
> > matches the "positive towards the top of the screen"
> > wording.
> >
> > Yet Android / W3C expect a positive reading when
> > the G force vector is pointing down. Which I still
> > find confusing.
> >
> > This means that we to add a text similar to the Windows
> > docs here, say something like (made up by me not copy
> > pasted from Windows docs):
> >
> > "The Z-axis reading will be -1G when a device is laying
> > flat on a table with its display facing up"
> >
> > To fix the are we measuring gravity or force countering
> > gravity confusion.
> >
> > Jonathan, shall I submit a patch to add this, maybe with
> > some extra text that we are following the Windows/HID
> > convention and that Android/W3C do things differently?
>
> I'm not going to rush this through late in a cycle.
> So propose a text update and let's carry on the discussion
> around that. (you may already have done so - I'm way behind!)
>
> Given we have a bunch of mount matrices that aren't rotation
> matrices out in the wild, we probably want to cover that as
> well, potentially by relaxing the definition to allow
> rotoinversions, or at least state they are out there even if
> we actively discourage them going forwards.
>
> Also, I just remembered Linus w wrote the docs in the first
> place and there was a long discussion at the time so +CC

I recently discussed the mount matrix bindings WRT magnetometers
with Jakob Hauser who has made a deep analysis of that
subject.

The TL;DR is that it turns out that also magnetometers are
device-oriented, and thus breaking most of the paradigms
used by people like geophysicists.

However for the "sensor fusion" usecase for a phone/tablet
device is makes perfect sense since e.g. projecting the magnetic
line onto the plane of the screen so you can create a compass
application the linear algebra becomes more intuitive with
everything expressed in device-relative terms.
(Some rambiling here: https://wiki.postmarketos.org/wiki/Magnetometer)

This is a bit unlucky given that IIO as a whole is probably
more ambitious and not just appealing to consumer devices...
but now we are stuck with this and the geophysicists will
perpetually shake their head as they align their new Linux-driven
magnetometer, encapsulated in concrete and mounted in the
bedrock to be perfectly perpendicular to earths surface.

Maybe when the physicists come around we can add some
isometric-mount-matrix = ... as alternative?

Please include Jakob on subsequent patches I am sure we can
hash this out for all sensors.

Yours,
Linus Walleij
