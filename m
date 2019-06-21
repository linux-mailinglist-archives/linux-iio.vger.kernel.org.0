Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60BE4DF16
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 04:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFUCZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 22:25:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44652 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfFUCZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 22:25:28 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so813621iob.11
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2019 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mg7oGXJCAj6FFdmzHQTcSzEM3alTCYySY13IsZcgBXo=;
        b=bCy177hm6MGkspKujaBsBUY7rKVKgbYxxOIr7sZWTcjLi9+g3ISleyYYiBfdlGuIUt
         8cftWHwVhB9uOsYNFXViGJrK8613Tv14P8xmDj8NiGoFhYuU2IHQnklXoMUE6ZdKvlvc
         DVQD98YjxAG4UhSjPtmi4BRWMQ9QW8SO9lmnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mg7oGXJCAj6FFdmzHQTcSzEM3alTCYySY13IsZcgBXo=;
        b=OzDcb29FtmBVNZK9KqB8Sp7CN0a+pbIT2E47A++sb+mrPA6GJCIGFO2ZKi0BaSilrH
         usVEl7nnK0n6QDzVVwBdmuQWCNqUFB9sAllQmvKZ5e/eP9RHFMLV35G7A5C3k9qse2d9
         wnpY/CavyoIi7RA5Nuy7J8P3lpbALR2miXEpqihbs1oJ/HTQCHycpvK36/NAbm80uU4o
         HvkhL2YewAtUMoYLTmcqCC8X6tfxPldN30IDvb9GsmKia0PovFGmpV1eHFsW6tjt/6vE
         WPYr3EhnRZhbHD5Z6zF08YZVgkWyOnbVhCGX4QiQb7rykZmus6Mb6iV8M5pi5fiiHazG
         /dCw==
X-Gm-Message-State: APjAAAWzY4BBc4eKkKnMbs+L3BCjUXEJ7F76IEjOL4RqtkZJmhkPOxt7
        Ne5Ge9Ds12MgA+iiCJWN/rd0btDDAhX/D0dP1N+s/Q==
X-Google-Smtp-Source: APXvYqzsblSMSNfJa2OjLLVCvs/q+ylTG1px2/TuD3C3Sn0F74SKDSD/Zx/MUoyF+OPtwFhs1nsm39Z6bvd2FoW4CZA=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr23020507ioo.237.1561083927275;
 Thu, 20 Jun 2019 19:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620185259.142133-1-gwendal@chromium.org> <20190620185259.142133-2-gwendal@chromium.org>
 <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
In-Reply-To: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 20 Jun 2019 19:25:16 -0700
Message-ID: <CAPUE2utxbVPyj6F2uV95CmT7aF0=ZyNN7bS97ynL1quFiDq+FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 20, 2019 at 2:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jun 20, 2019 at 11:53 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > To allow cros_ec iio core library to be used with legacy device, add a
> > vector to rotate sensor data if necessary: legacy devices are not
> > reporting data in HTML5/Android sensor referential.
> >
> > TEST=On veyron minnie, check chrome detect tablet mode and rotate
> > screen in tablet mode.
>
> TEST= doesn't belong in an upstream patch.
>
>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
> >  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 719a0df5aeeb..1b2e7a8242ad 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                 }
> >                 state->type = state->resp->info.type;
> >                 state->loc = state->resp->info.location;
> > -       }
> >
> > +               /* Set sign vector, only used for backward compatibility. */
> > +               memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> > +       }
> >         return 0;
>
> Normally there's a blank line before the "return".  There was before
> your patch.  Why did you remove it?  It'll make your diff cleaner if
> you keep it.
Will fix these issues in next patch.
>
> Also, should you be basing your patch atop +Fabien's series?  I notice
> you got a conflict when you picked this into the Chrome OS tree, but
> maybe you wouldn't have if you had based atop
> <https://lore.kernel.org/patchwork/patch/1090463/> AKA
> <https://lkml.kernel.org/r/ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>
I did not based on top of Fabien's patches because this change is
orthogonal to Fabien's. Moreover a new set of patches is needed as the
attributes added (min_freq, max_freq) do not match the current sysfs
ABI.

Gwendal.
>
>
> -Doug
