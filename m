Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56D78C29
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfG2NCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 09:02:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46573 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfG2NCV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 09:02:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so59279228edr.13;
        Mon, 29 Jul 2019 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tt8+c7Qc6AbuRWIfhDVP2GsR6IhoFI9cbqdXPL+msrE=;
        b=iN1oOiDKJr1UPZKyfaQkFB3Tptf5t39BmoTz4Ohsna/AXtU62D5zdT1z+iW1R19aRN
         uM4C4DqJzyOTPya3o2D2baJpFk7uchbkR3ODkjBvL3oYlRARnftFcjlfzQHRv+UQplkM
         s6kuR7d0jHcyzJFzUCSvmaN03Aw/EZXrGpGX4Qc4co+xg3W3kSojm9AUw9js0sBz/mbr
         3X+bxm4k4MQ31qc7J6wrIpYI6Xi5buUO0R7rgyrP2ChZl5SLPD13X0kmNb36513bD/Gg
         nM96BvJ+4OVMRgcyLACG3f5taSG/18kBP17KCR1SPjNv4o2r5GxnWf184im6SLd2z62d
         moNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tt8+c7Qc6AbuRWIfhDVP2GsR6IhoFI9cbqdXPL+msrE=;
        b=HNNyCOPX7BsyAHq+7RTKBmkT/6PP2nCrCqJdKQRAtzSGXjD+0cXetk1MSrr2oEslPd
         3wDbGZ2TqISOuidq32zKlYzNbVXRF7SAU1TUbAsSzol7u5yVOQDz8AYxsgDcuVvPlWS3
         40h5HfDWLx/47HMUIbSpsTEN7QF/c7Zq5iccBAg6mMIniEKfnZ2tz4xJF8YPxc7IWRGM
         kGEyy4ykTp62CJC07aOeKqj7IegvjJv3egnw6xfNZ/nS8sYrCM2P7b7iBftEr8HoXds2
         fghBSuPgp6z08KB/JdJXQ5Gve5OwnpWIfbHWN7+FGYPWy8+9KcqZAc8kcLYbeQDVFwQs
         k7wQ==
X-Gm-Message-State: APjAAAWKVcEk9jfX1AhKZ1XaTZ6sJq6qtWXwzEb+Ci01/c5i6UuNOonK
        clzscuTuXXlAbWvw2x3mJ519eTI0wcSmlFTk6kk=
X-Google-Smtp-Source: APXvYqxP/bCKnoGlVp0xkAUKDHstli7ATjKpxnxVBHH/99YUGZIKyFTn+mQc+Rle+3AJ/qFcmg5TASvvKs3N90q/38I=
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr92099589edy.202.1564405339822;
 Mon, 29 Jul 2019 06:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190726123058.22915-1-hslester96@gmail.com> <20190727125749.63297c28@archlinux>
 <20190728083141.GA14194@onstation.org> <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
 <20190729080307.GA360@onstation.org> <20190729120802.000025e8@huawei.com>
In-Reply-To: <20190729120802.000025e8@huawei.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 29 Jul 2019 21:02:09 +0800
Message-ID: <CANhBUQ0eBs5ExByztvsKf9eRbKKLXkLkhduQ59VqcGTU0kDOvQ@mail.gmail.com>
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Brian Masney <masneyb@onstation.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jonathan.cameron@huawei.com> =E4=BA=8E2019=E5=B9=B47=E6=
=9C=8829=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:09=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On Mon, 29 Jul 2019 04:03:07 -0400
> Brian Masney <masneyb@onstation.org> wrote:
>
> > On Mon, Jul 29, 2019 at 11:03:00AM +0800, Chuhong Yuan wrote:
> > > Brian Masney <masneyb@onstation.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=88=
28=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > devm_add_action() could be used in the probe function to schedule t=
he call
> > > > to tsl2772_chip_off(). That would eliminate the need for
> > > > tsl2772_remove(). See tsl2772_disable_regulators_action() for an ex=
ample in
> > > > that driver.
> > > >
> > >
> > > I find that we can use devm_add_action_or_reset() for
> > > tsl2772_disable_regulators_action() to eliminate the fault handling c=
ode.
> > >
> > > I am not sure whether devm_add_action() can be used for
> > > tsl2772_chip_off() because it returns an integer, not void.
> > > And the return value is used in several functions.
> >
> > I would add a wrapper function (tsl2772_chip_off_action?) with the
> > expected declaration that calls tsl2772_chip_off().
> >
> > > > Chuhong: Another potential cleanup to shrink the size of this drive=
r is
> > > > to move it over to the regulator_bulk_() API. I didn't realize that=
 API
> > > > existed at the time I introduced the regulator support. If you're
> > > > interested in taking on that cleanup as well, I can test those chan=
ges
> > > > for you if you don't have the hardware.
> > > >
> > > > Brian
> > > >
> > >
> > > Does that mean merging vdd_supply and vddio_supply to an array of
> > > regulator_bulk_data and utilize regulator_bulk_() API to operate them
> > > together?
> >
> > Yes.
> >
> > > I have an additional question that I find regulator_disable() is used=
 in the
> > > end of many .remove functions of drivers, which hinders us to use dev=
m
> > > functions.
> > > One example is drivers/iio/light/gp2ap020a00f.c.
> > > Is there any solution to this problem?
> >
> > There are devm_regulator_*() variants of the regulator API available
> > that you can use. Lots of other APIs in the kernel have devm variants
> > to simply drivers.
> I don't think there are any devm_ versions of regulator disable.
>
> IIRC the argument made when this last came up was that it was rarely corr=
ect
> to be as course grained as a lot of IIO drivers are.   We should probably
> do runtime pm and turn these regulators off a lot more frequently.
>
> The reality is that it is an optimization that doesn't get done in
> IIO drivers that often as we mostly just want them to work and many
> usecases aren't actually power constrained,
>
> So we end up doing a lot of devm_add_action_or_reset to power down the
> regulators.
>

I think I can add devm_ versions of regulator_enable and disable.

Chuhong

> Jonathan
> >
> > Brian
>
>
