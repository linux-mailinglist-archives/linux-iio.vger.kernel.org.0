Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36F3BB740
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGEGlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEGlL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 02:41:11 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974AEC061760
        for <linux-iio@vger.kernel.org>; Sun,  4 Jul 2021 23:38:33 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id p13so6611291uao.5
        for <linux-iio@vger.kernel.org>; Sun, 04 Jul 2021 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LOfRMnkDXcKW+MBvyXL+fw+fgJSD67ELnS1x+u7s+Y=;
        b=OMkEwopl0pWWhz1/8xqkZ6ZdwwEtJIQ+eSgP8VDSSZkgEURGVO0UIIZ4VWtXkGZ2sq
         1QjXMTA5ZFnwHa+y26ld7UjnDeEjkAaU1+XNbvJF7DELrIcs4YST6/7nR+T8QJZYNYS+
         8vOd+IR/DKZXnmpYmvt7TQAdSvMELWkyy5XDg+ta6mFhWlCToclITNoQEP9dbiTXfVmZ
         rLGEaEbU29JSMVr6FL8kSsY11iY+Fj+T+M0mFh5OKO/podACxSSG3LNbM2rTMlSTh5VP
         PbBoAE2ayXRXfNwDyjklS/Wg0XbKQ5B5Jjnq9YHLmsidkQwNFHNiNjIRghCU5spQaG1i
         sUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LOfRMnkDXcKW+MBvyXL+fw+fgJSD67ELnS1x+u7s+Y=;
        b=aBb+oA2XUXsTaRCTh5zKSktmUZCdHvYKN+tEXKbCZq/kSM4HjuTfg8msiejHpyej7s
         5egz7dKjwjSaPJWblcZir89aFm3dFrGuQwLr2fY+utlnTO3h8Hbx3S6dkEFJunHjucxM
         sOLbBCwbKey9d3EcDk6Hr5qXsjhAYJr1gRXGofs/U2PV2sZsNZPE2iDtetxm7Pd4+mNM
         K/bubZ3AV6IOrgG3JkLV1xnyBFfjb1CPCjAzTT6m5YM4Bc11Y7lBzI/fkGzi4FTq3jWt
         2PRYrHOqoVy9YU37jluq1ooMBycaO9WHSHuRqjp+gdVId90ia2YXjgDGim1jghTay7Y+
         0gTQ==
X-Gm-Message-State: AOAM532k1fQuo7s1FUjCZDox5sBE7YYo/XQvo3wP+dN2k4NqXEDic0f5
        O5NCsUFfYXMVQhDZ/Ar0UHEqhsjCTSBvW1UxJOux5ZsIf7iJPw==
X-Google-Smtp-Source: ABdhPJxD+vA6iPu+fUxzp/X+K3IsPKpbEpw9RPR3c1tbqqRkdxyae9oOe1AfbnzW7YwLnY9RDrfVL5Ts2pYS0EhtbD8=
X-Received: by 2002:ab0:7399:: with SMTP id l25mr9097692uap.67.1625467112660;
 Sun, 04 Jul 2021 23:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210628135132.73682-1-aardelean@deviqon.com> <20210703185007.2c2283f4@jic23-huawei>
In-Reply-To: <20210703185007.2c2283f4@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 5 Jul 2021 09:38:21 +0300
Message-ID: <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed functions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pmeerw@pmeerw.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 3 Jul 2021 at 20:47, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 28 Jun 2021 16:51:32 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > This one is a little easier to convert to device-managed, now with the
> > devm_krealloc() function.
> >
> > The other iio_triggered_buffer_setup() and iio_device_register() can be
> > converted to their devm_ variants. And devm_krealloc() can be used to
> > (re)alloc the buffer. When the driver unloads, this will also be free'd.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >  drivers/iio/light/adjd_s311.c | 34 +++++-----------------------------
> >  1 file changed, 5 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> > index 17dac8d0e11d..19d60d6986a1 100644
> > --- a/drivers/iio/light/adjd_s311.c
> > +++ b/drivers/iio/light/adjd_s311.c
> > @@ -230,8 +230,8 @@ static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> >  {
> >       struct adjd_s311_data *data = iio_priv(indio_dev);
> >
> > -     kfree(data->buffer);
> > -     data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > +     data->buffer = devm_krealloc(indio_dev->dev.parent, data->buffer,
> > +                                  indio_dev->scan_bytes, GFP_KERNEL);
> I got some complaints about exactly this trick in a review recently so I'll
> pass them on.
>
> Whilst devm_krealloc() usage like this won't lose the original reference, its
> not what people expect from a realloc() case, so to not confuse people it is
> better to do a dance where you use a local variable, then only set data->buffer
> to it once we know the realloc succeeded.
>
> That avoids this looking like the anti-pattern it would be if that were a normal
> realloc in which case you would just have leaked the original allocation.
>
> More interestingly, why are we bothering with resizing the buffer dependent on what
> is enabled?  Can't we just allocate a 128 byte buffer and not bother changing it
> as we really aren't wasting that much space?  Just embed it in the adjd_s311_data
> structure directly and don't worry about the allocations.  Will need to be
> aligned(8) though to avoid the push_to_buffer_with_timestamp() issue.
> Using something like
>
> struct {
>         s16 chans[4];
>         s64 ts __aligned(8); /* I hate x86 32 bit */

do you want to me t also add this comment? :p
[just kidding]

> } scan;
>
> Inside the priv structure should work nicely.

i agree; will do it like this;
i hesitated a bit due to the inertia of converting things to devm_

>
>
> >       if (data->buffer == NULL)
> >               return -ENOMEM;
> >
> > @@ -256,7 +256,6 @@ static int adjd_s311_probe(struct i2c_client *client,
> >               return -ENOMEM;
> >
> >       data = iio_priv(indio_dev);
> > -     i2c_set_clientdata(client, indio_dev);
> >       data->client = client;
> >
> >       indio_dev->info = &adjd_s311_info;
> > @@ -265,34 +264,12 @@ static int adjd_s311_probe(struct i2c_client *client,
> >       indio_dev->num_channels = ARRAY_SIZE(adjd_s311_channels);
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> > -     err = iio_triggered_buffer_setup(indio_dev, NULL,
> > -             adjd_s311_trigger_handler, NULL);
> > +     err = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> > +                                           adjd_s311_trigger_handler, NULL);
> >       if (err < 0)
> >               return err;
> >
> > -     err = iio_device_register(indio_dev);
> > -     if (err)
> > -             goto exit_unreg_buffer;
> > -
> > -     dev_info(&client->dev, "ADJD-S311 color sensor registered\n");
> > -
> > -     return 0;
> > -
> > -exit_unreg_buffer:
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -     return err;
> > -}
> > -
> > -static int adjd_s311_remove(struct i2c_client *client)
> > -{
> > -     struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > -     struct adjd_s311_data *data = iio_priv(indio_dev);
> > -
> > -     iio_device_unregister(indio_dev);
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -     kfree(data->buffer);
> > -
> > -     return 0;
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> >
> >  static const struct i2c_device_id adjd_s311_id[] = {
> > @@ -306,7 +283,6 @@ static struct i2c_driver adjd_s311_driver = {
> >               .name   = ADJD_S311_DRV_NAME,
> >       },
> >       .probe          = adjd_s311_probe,
> > -     .remove         = adjd_s311_remove,
> >       .id_table       = adjd_s311_id,
> >  };
> >  module_i2c_driver(adjd_s311_driver);
>
