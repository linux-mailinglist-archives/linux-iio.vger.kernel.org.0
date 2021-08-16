Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2602B3ED5B2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhHPNNY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbhHPNLu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 09:11:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E99C035436;
        Mon, 16 Aug 2021 06:07:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d9so14097558qty.12;
        Mon, 16 Aug 2021 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=xfxVTufOpmHkg6GHY87ySGvsV3ZLRddJrxsikZzhp6g=;
        b=gasm5GElvgx3RRzmWXq52VybAz4g5Vnh3CxewUsprhDCHopi7Zdpq3HtKXOGhfm53Z
         39GL7URg+UP78AiVfyJRseh4Xp9OLOCs/fjmyGyCPYWpiSLbuvHfBxICjBc+1RoxmeYP
         6v+4SEtpCP3czylhQt1O2J3B9BxYILD1klMRYjiI1d6FEorvaDhglAW9W0QoiCjbu0TG
         66woKs62QnSuoK0TkgjXHb483+R3M2itoia4zHkP2XjWQlbmqHam/ZlrcOJXHbH0GksX
         vm7onNcxeM6usPSHPClBRmcp1foJF87cpQx11Jyc8BWGYdZ1hldIGct7EauECGdWotq4
         Aduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=xfxVTufOpmHkg6GHY87ySGvsV3ZLRddJrxsikZzhp6g=;
        b=j02SpZFgdx5i5qyCRr4HlinrTT0hDGuajIOo1bOeaFbH71Wkd37fyMoqlTieV+7NVO
         6pqmvMrb1WHTaJ8xntk9VF1rUG44B8CbcPnKWiak1J5506mHyecHJv9EnW2B7jKQ5xsR
         W/N1smfj4ami/00MJUrvE6JYGr1/aIbLq2A+hWaptkyydZqaqT/W3JLmA7zGRaSbTpQi
         5yuZwqP5KZUXjrKJiTgMecqXwzbkqjuMQYtYzz0I1+D9lAxXyUvQQN//3HtWdBcp2k/L
         EsJImpJad821JQd+EIOJ6zSwBxL95PMv2EGEbA2/LpUz+GGjz0DGyHrKwhPmXyL8x+ts
         vbYQ==
X-Gm-Message-State: AOAM530XTUlbGlqlfIYrbQIzH7JCSIeGxlxG8GIxHvYSUS+mpZTSLb4i
        zvoCkWXiwepXoNYx2RQqJU0=
X-Google-Smtp-Source: ABdhPJyUMDRqAP6WB58hfo5+GxTozFXW06KqPhTG9PbuW4H4x7KT6X+j7e0So4OByLKuhr7iF4149A==
X-Received: by 2002:ac8:5202:: with SMTP id r2mr5465739qtn.106.1629119273650;
        Mon, 16 Aug 2021 06:07:53 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id bi3sm6027372qkb.133.2021.08.16.06.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 06:07:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 16 Aug 2021 09:07:52 -0400
Message-Id: <CDKYL1RFEMBA.2VURZKBX9F3S@shaak>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Lars-Peter Clausen" <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Charles-Antoine Couret" <charles-antoine.couret@essensium.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <Nuno.Sa@analog.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-iio" <linux-iio@vger.kernel.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-4-liambeguin@gmail.com>
 <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
 <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
 <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
In-Reply-To: <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 16, 2021 at 8:48 AM EDT, Andy Shevchenko wrote:
> On Mon, Aug 16, 2021 at 3:39 PM Liam Beguin <liambeguin@gmail.com>
> wrote:
> > On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:
> > > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > > wrote:
>
> ...
>
> > > > +       tmp =3D 4096000;
> > > > +       ret =3D device_property_read_u32(dev, "adi,internal-ref-mic=
rovolt", &tmp);
> > >
> > > > +       if (ret < 0 && ret !=3D -EINVAL) {
> >
> > Hi Andy,
> >
> > >
> > > What does this check (second part) is supposed to mean?
> > > The first part will make it mandatory, is it the goal?
> > >
> >
> > device_property_read_u32() will return -EINVAL if the property isn't
> > found in the devicetree.
> >
> > This checks for errors when the property is defined while keeping it
> > optional.
>
> Don't assign and don't check the error code of the API. As simply as
> that.

I'm not against getting rid of it, but I was asked to check for these
errors in earlier revisions of the patch.

Liam

>
> > > > +               dev_err(dev, "invalid value for adi,internal-ref-mi=
crovolt\n");
> > > > +               return ret;
> > > > +       }
>
>
> --
> With Best Regards,
> Andy Shevchenko

