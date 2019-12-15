Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876CE11FBCD
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 00:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfLOXZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 18:25:39 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44365 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLOXZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 18:25:39 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so4982113iof.11
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2019 15:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEL4itFmihZqlf+pK1DU7DEDt/SepncHaF9ZMAufTQk=;
        b=N+c4HK+qYE45RWqlaHU7AnTEY46OfO0t0kBAN2F+qSebIf6nmrna9JaUNv7TDH9X27
         eCgTN0xBKqFk/ruLZ7CepWQ0jgS9fLOYi7yjsjSN9bKiqaIzJ/+CIrt8kekjVO41P6NN
         d5Eo49hMKI8IYCNwJ9GMtn/oFArpJVH77Ajsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEL4itFmihZqlf+pK1DU7DEDt/SepncHaF9ZMAufTQk=;
        b=GOF4jBVzCwSlXuaJ8BHINqoG1opULa0axWdlkoTvYUdL0RhVcVzB8yI37rLljOmw9J
         aLUgQGVhL94S26WTuMxS7Lw7RiQmBl5LJ1dITfiEPtnizMbY7m1QgSSg7f7XUn+56Zr1
         DwT4B5/UMBGJFl5QOPzmmWTN34wEWX/TDWtZMQ6q1cjI0CQm29pQS+mcUAJ22PL40S4B
         DHGWwwZXETCFBwgRQT4YDPajCgSp/0wqgKbaOwYOFRoU0GvbVy/XAG2gF1XlnaU98tdj
         RYl19uzyOQSlce1BEqt7trj0GwhM/BrZH6wo2PrKnMlfIWOuUSHM/M/LBXXs4tbgMS79
         S15A==
X-Gm-Message-State: APjAAAXbF0JXIp825ZPBU3QGidq4lsq4QIjuPqV9YRv1uSdtgQMt6SiR
        xcEWgfWnjuuJOmNZWglBAC5KW3ioDl/Vo6eXmwxlK6xz5PM=
X-Google-Smtp-Source: APXvYqyxqgqtul5GG7UvGBKwhR/jHF82eADU4suOa7b5QH1cqUuBRY6sCnLgmir+XVDsPtFBuRQBjcI89ud2U+OOQlo=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr9795715jad.136.1576452338679;
 Sun, 15 Dec 2019 15:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20191210210735.9077-1-sashal@kernel.org> <20191210210735.9077-66-sashal@kernel.org>
 <20191215155329.4c71ad53@archlinux>
In-Reply-To: <20191215155329.4c71ad53@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 15 Dec 2019 15:25:27 -0800
Message-ID: <CAJCx=gkM8=WCC6t8bjX-q-mDco7HBMdBmJjOQzRHZr4-nKVvcA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 105/350] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 15, 2019 at 7:53 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Tue, 10 Dec 2019 16:03:30 -0500
> Sasha Levin <sashal@kernel.org> wrote:
>
> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > [ Upstream commit 0c8a6e72f3c04bfe92a64e5e0791bfe006aabe08 ]
> >
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> >
> > The iio_triggered_buffer_predisable() should be called last, to detach the
> > poll func after the devices has been suspended.
> >
> > The position of iio_triggered_buffer_postenable() is correct.
> >
> > Note this is not stable material. It's a fix in the logical
> > model rather fixing an actual bug.  These are being tidied up
> > throughout the subsystem to allow more substantial rework that
> > was blocked by variations in how things were done.
>
> See comment.  This is not what I would consider stable material.
>

Outside of the comment, which really isn't probably enough to avoid
the autoselection script from detecting it (could be "stable" in the
message alone selects it :) ),
is there any way to signal that a patch is "NOT for stable trees"?
Probably don't want to clutter up the commit messages of course.

- Matt

> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> > index 3a20cb5d9bffc..6c175eb1c7a7f 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
> >       struct atlas_data *data = iio_priv(indio_dev);
> >       int ret;
> >
> > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > +     ret = atlas_set_interrupt(data, false);
> >       if (ret)
> >               return ret;
> >
> > -     ret = atlas_set_interrupt(data, false);
> > +     pm_runtime_mark_last_busy(&data->client->dev);
> > +     ret = pm_runtime_put_autosuspend(&data->client->dev);
> >       if (ret)
> >               return ret;
> >
> > -     pm_runtime_mark_last_busy(&data->client->dev);
> > -     return pm_runtime_put_autosuspend(&data->client->dev);
> > +     return iio_triggered_buffer_predisable(indio_dev);
> >  }
> >
> >  static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
>
