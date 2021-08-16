Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B683ED790
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhHPNhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbhHPNhM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 09:37:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E6C03402C;
        Mon, 16 Aug 2021 06:13:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so11875538pjz.0;
        Mon, 16 Aug 2021 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pA1pAvAiNe/l0P1Vz8nn+khgB1MLduCxo2hSicfh7Q=;
        b=CZTJ9/tr6sTzcdg62crIK6nxhx5RjmcKkPytcvB4Ebqx9DZ7zpMU38A777/0mvBOdI
         AOEKtBayrZRUO8zegV04pY36A1zgUU/EipY1j7kps9R296PLf/TwigOqAGYiH8xu5WsP
         24RgNmlhHIWeFpAs0+pI4deYlBHhRmrG8ObIXI6CfyWgYVi8EpDmaVFjfdNJBCQwBMmL
         C+tf6vxmK/4HbkMd048VVMhB5NtbYguSuVVFjEuNWEHuzgYVKkC6nmfNzD25Mccvsuby
         I4mRKOu1L3QDiUFWdvPP6yuimmEmMnxt3wZTu1QbnplbpMy/liJ2e6S8nzXqJnggp2xV
         NyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pA1pAvAiNe/l0P1Vz8nn+khgB1MLduCxo2hSicfh7Q=;
        b=fu69OhiiO0SkZyJYMVs8VeMap9BTwv8uvStndUOYlx2JQm0fOiTAeuHnaKj1iAPvce
         zRN1QzpF8Keuk4gku9UXjISu2sJ7lit00HZmrA0XaVCn12xKgjagoliAoFA3mF+r6QZd
         t7jk/f7q0FGyGkgvAjisXFuRdxFiDrm/mGIk7v4WRjevo2ClZ7jpLDhdHep70oli32TR
         /VZj7NPOIEIiEDjnqy9AcHeP97Yk4EuuaSP99zTzrccsDPxFllAzdlpts/1l2erRetTk
         Yfj7guORgzQg+RAWMLprsU8o4odM4SrlQ7lKIrTPwv85FfieGdsCuFkmgYgNtJVpjIhd
         v4YQ==
X-Gm-Message-State: AOAM531QNMNfvb4M/27QhC/El+EyGYmy2AeimpV2xmh8VqF2QnO0BDO2
        Oh7MQJq2Fv20QFO7NSXBi9JlP/r/tcHJaxdv8v4=
X-Google-Smtp-Source: ABdhPJzrrvGuRDtlnqguqb2PrJrbfQYk6NHpdJItrUVBfSO7Q5bRj/jQzca8pvwZ4l3G7jI0m+BOSlPdEe/am7/vGkc=
X-Received: by 2002:a65:5ccd:: with SMTP id b13mr16007694pgt.203.1629119618351;
 Mon, 16 Aug 2021 06:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-4-liambeguin@gmail.com> <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
 <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak> <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
 <CDKYL1RFEMBA.2VURZKBX9F3S@shaak>
In-Reply-To: <CDKYL1RFEMBA.2VURZKBX9F3S@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 16:12:58 +0300
Message-ID: <CAHp75VcUhgpxUE4h3YgYaGAsvHstBzSo9QDwe+D4t264uj_21A@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 16, 2021 at 4:07 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Mon Aug 16, 2021 at 8:48 AM EDT, Andy Shevchenko wrote:
> > On Mon, Aug 16, 2021 at 3:39 PM Liam Beguin <liambeguin@gmail.com>
> > wrote:
> > > On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:
> > > > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > > > wrote:

...

> > > > > +       tmp = 4096000;
> > > > > +       ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
> > > >
> > > > > +       if (ret < 0 && ret != -EINVAL) {
> > >
> > > Hi Andy,
> > >
> > > >
> > > > What does this check (second part) is supposed to mean?
> > > > The first part will make it mandatory, is it the goal?
> > > >
> > >
> > > device_property_read_u32() will return -EINVAL if the property isn't
> > > found in the devicetree.
> > >
> > > This checks for errors when the property is defined while keeping it
> > > optional.
> >
> > Don't assign and don't check the error code of the API. As simply as
> > that.
>
> I'm not against getting rid of it, but I was asked to check for these
> errors in earlier revisions of the patch.

Okay, I leave it to you, guys, to decide, just note that the usual
pattern for optional stuff
a) either check for (!ret);
b) or ignore the returned value completely.

> > > > > +               dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
> > > > > +               return ret;
> > > > > +       }


-- 
With Best Regards,
Andy Shevchenko
