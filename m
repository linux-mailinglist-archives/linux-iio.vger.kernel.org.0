Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3578389
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 05:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfG2DDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 23:03:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40247 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jul 2019 23:03:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so57934494eds.7;
        Sun, 28 Jul 2019 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fXVvE8jAIC1NNZIfikHDR/1QE5dXSm7MFMLRP9/brXQ=;
        b=P1CWbXcBwor5hFfN6eM0+AZeIpRuigARlpWFs0jelf9IA36v5ICoIlMCwgXaWmDvR3
         /QiTkrYUa1MEMIP8Q0hsBw9fZDe5/zr1BkIhoMXo+tLCEBSgTPqlT9jRmInlLb1z4RZ/
         slc8QwWFz4/T7l4QyY9jTsP19d/g7cRQ+Eh9aT8PsEEQYIKyXAEZKJ8KBlSCUOdkfryn
         FpxQ+HkX/qhvxC67cK9Z6n8LC7ebtmVP9ZxHcra2IziDVfBLEit6D+hPX9KmGOA7VeCQ
         rxKfQQIAyhmHk8S1iR7dSCNhUkCemuGkg0f3njn5YR0+7yUTPZ4nVRRsxNCZNjt6v445
         FDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fXVvE8jAIC1NNZIfikHDR/1QE5dXSm7MFMLRP9/brXQ=;
        b=HK26qDV1Vjikk3M8Cjokwf5tLFwyQJt9EFhWAcv5bXjJ+aW96fZXpdZyrCke1tN0Gu
         wNx3gBWiT6NL6tp5TzwdSTQPFGdOXpP7gMZbzEO8EfjyJQTZO5bwikJL/MBmrpCRti43
         obK6p6bTDUiEds0IeKj3AahQhftjiw/+oT80r8f9c1nTH4gXV1e77tmtJzRW6lPKLg3y
         nErSYQBOL2oLDpNis65h5CCQY7rQoKe+4EUTPQYYb+fKFLYRfeHi1bxxh9FP/9mfUYaT
         efQAGiQWCITpFG3foiouHU2lj0Nmrfd2i4Ss8xs97GbyA+hounfP1V1rqiRlVDLcnoy6
         n5dw==
X-Gm-Message-State: APjAAAXCTCeOsSLzd9xcqgj+spVH73R0emIBemHgudT28XcSBkS7K81s
        ZzwyD+V0S+cEMLpVzEv9LfponBdnU9ByguMuGfE=
X-Google-Smtp-Source: APXvYqztZbNHWBjSUVnHMw4zUWMdTxfXHtkbV4nwpJQsA4Cbwma358T7+XXK91et5uMJwGA2a51svvZGHt8E4wrdLtA=
X-Received: by 2002:a17:906:8317:: with SMTP id j23mr69799975ejx.51.1564369391203;
 Sun, 28 Jul 2019 20:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190726123058.22915-1-hslester96@gmail.com> <20190727125749.63297c28@archlinux>
 <20190728083141.GA14194@onstation.org>
In-Reply-To: <20190728083141.GA14194@onstation.org>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 29 Jul 2019 11:03:00 +0800
Message-ID: <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Brian Masney <masneyb@onstation.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8828=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jul 27, 2019 at 12:57:49PM +0100, Jonathan Cameron wrote:
> > On Fri, 26 Jul 2019 20:30:58 +0800
> > Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > > Use devm_iio_device_register to simplify
> > > the code.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> >
> > Please try to pick up on likely reviewers in your cc list.  In this cas=
e
> > Brian did a lot of work cleaning these drivers up so I've added him.
> > Not everyone keeps up with the linux-iio list for some reason ;)
> >
> > Immediate thought was that you had broken the ordering but turns out
> > it is already buggy.
> >
> > As things stand, we remove the userspace interfaces (iio_device_unregis=
ter)
> > after turning off the power.   This is obviously a bad idea and also
> > form a purely "obviously correct" stand point, we aren't doing the reve=
rse
> > of probe.
> >
> > So, I 'think' the right option is to reorder remove so that the power l=
eft
> > on until after the iio_device_unregister call. At that point, we can't
> > use devm_iio_device_register as we'll have the same incorrect ordering
> > we currently have.
> >
> > Brian, you looked at this driver most recently.  Thoughts?
>
> devm_add_action() could be used in the probe function to schedule the cal=
l
> to tsl2772_chip_off(). That would eliminate the need for
> tsl2772_remove(). See tsl2772_disable_regulators_action() for an example =
in
> that driver.
>

I find that we can use devm_add_action_or_reset() for
tsl2772_disable_regulators_action() to eliminate the fault handling code.

I am not sure whether devm_add_action() can be used for
tsl2772_chip_off() because it returns an integer, not void.
And the return value is used in several functions.

> Chuhong: Another potential cleanup to shrink the size of this driver is
> to move it over to the regulator_bulk_() API. I didn't realize that API
> existed at the time I introduced the regulator support. If you're
> interested in taking on that cleanup as well, I can test those changes
> for you if you don't have the hardware.
>
> Brian
>

Does that mean merging vdd_supply and vddio_supply to an array of
regulator_bulk_data and utilize regulator_bulk_() API to operate them
together?
If so, I can do that cleanup in next version.

I have an additional question that I find regulator_disable() is used in th=
e
end of many .remove functions of drivers, which hinders us to use devm
functions.
One example is drivers/iio/light/gp2ap020a00f.c.
Is there any solution to this problem?

Regards,
Chuhong

>
> > > ---
> > >  drivers/iio/light/tsl2772.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.=
c
> > > index 83cece921843..aa5891d105e8 100644
> > > --- a/drivers/iio/light/tsl2772.c
> > > +++ b/drivers/iio/light/tsl2772.c
> > > @@ -1877,7 +1877,7 @@ static int tsl2772_probe(struct i2c_client *cli=
entp,
> > >     if (ret < 0)
> > >             return ret;
> > >
> > > -   ret =3D iio_device_register(indio_dev);
> > > +   ret =3D devm_iio_device_register(&clientp->dev, indio_dev);
> > >     if (ret) {
> > >             tsl2772_chip_off(indio_dev);
> > >             dev_err(&clientp->dev,
> > > @@ -1928,8 +1928,6 @@ static int tsl2772_remove(struct i2c_client *cl=
ient)
> > >
> > >     tsl2772_chip_off(indio_dev);
> > >
> > > -   iio_device_unregister(indio_dev);
> > > -
> > >     return 0;
> > >  }
> > >
