Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9226F92F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRJZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRJZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 05:25:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4880C06174A;
        Fri, 18 Sep 2020 02:25:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o6so4799361ota.2;
        Fri, 18 Sep 2020 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVFRxeNLYf6L8EcunJ8pjid4VzkzkBkIL4g7gPwuFYA=;
        b=Y9/zVImEnOWiJc+AM8C1K/HdaQ5nzPS++qqHRkRelfoJzDhfYcapvW08+9YJGDzbUu
         ej92kxaaSf7INCMCdgp/9l7GSAr1oEhbQj6cnvD9TXRa4NeSdTaWVVffGzYw52dd1wNi
         GHyfS8T7/PBOSi27Xkza5yfMY2v9Qb5Ee3nduFFTUX1qIq29gBPoAEoa+9AKA/kV45ZP
         7oxoSPA8wCdy+skRHhtAxQQ/U6B+j+9H3NAJw1FOOUK70MfYUikic4AqhDzOVvWGsmbY
         a5ZH0cc4m84skuJJqpl6siYPhdrH1KPEdQPhsMT62AjGtCRbQNPgMRPa5UijDAwhxiMg
         vieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVFRxeNLYf6L8EcunJ8pjid4VzkzkBkIL4g7gPwuFYA=;
        b=WemxEZWbz78j2Kxq0xa2oGFCNkd874aIlJKr02IcDJkHAgcIojYArOlMz/UjmCodTv
         Yi+DlhAHjgy7tfoGf+VK4eoWWODKJu8DYCByuQQM/0GH2rDNXOCFiapG9d2ebytilrQK
         aUVQTTpdPdfL8liTQuJ2wFQmfdoFy8mrQastWbfNZcFmmMCkgERX9EnkFFNyeYwv1VDC
         AjrusVetfEedhgvjU5ELFe+ujB29nsx65wRiguNeqBGEn7vWtRwuB4x9FNcbxBGD4ZNi
         nPGdGMMEBN60AH77PswLAehhgl50i1VEANir7VLf1Amcg8zj8IhpCLWStjamO1+Y452d
         aWUQ==
X-Gm-Message-State: AOAM530HVXWCqNFrD8C0nMGTh59E/5+XmrZrqV4Kg/D5GqL0GnQ1ImFv
        tpXiDLQGrDIJjKHrt9rVAdL8UkXVPCs/pQpmdKThBTWm/Ps=
X-Google-Smtp-Source: ABdhPJwsMau6u9U382UKAUKP8YnNcmvuEP86sjd2GoXlSIKXrGb0qNiGxaDcaY2Sk+as6Q/Sb1E2S3xQGEP0giPDAUw=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr22995177otj.224.1600421124085;
 Fri, 18 Sep 2020 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200917125951.861-1-alexandru.ardelean@analog.com>
 <20200917181626.59eb84c8@archlinux> <CA+U=DspN3WYX5_1MZpRPzUcC5NV4=iSekQ9jNSehad1jfi2bQw@mail.gmail.com>
 <20200917185559.7d6971e3@archlinux>
In-Reply-To: <20200917185559.7d6971e3@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 18 Sep 2020 12:25:13 +0300
Message-ID: <CA+U=Dsp8Y+t=YM9KM2At7-PhqomXZ1W=QwHx=7rHxwyb74b2Ng@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: split buffer sysfs creation to take buffer
 as primary arg
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 17, 2020 at 8:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 17 Sep 2020 20:41:08 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Thu, Sep 17, 2020 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Thu, 17 Sep 2020 15:59:51 +0300
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >
> > > > Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
> > > > primary argument. This change splits the main logic into a private function
> > > > that takes an IIO buffer as primary argument.
> > > >
> > > > That way, the functions can be extended to configure the sysfs for multiple
> > > > buffers.
> > > >
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > >
> > > One comment inline.  Whilst I think it is safe as you have it, I'd
> > > rather avoid the minor change in logic if we don't need to make it.
> > >
> > > Thanks,
> > >
> > > Jonathan
> Applied to the togreg branch of iio.git.
>
> See below for my pathetic Diff confused me excuse :)
>
> Jonathan
>
> > >
> > >
> > > > ---
> > > >  drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
> > > >  1 file changed, 30 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > > index a7d7e5143ed2..a4f6bb96d4f4 100644
> > > > --- a/drivers/iio/industrialio-buffer.c
> > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > @@ -1264,26 +1264,14 @@ static struct attribute *iio_buffer_attrs[] = {
> > > >       &dev_attr_data_available.attr,
> > > >  };
> > > >
> > > > -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > > > +static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > > > +                                          struct iio_dev *indio_dev)
> > > >  {
> > > >       struct iio_dev_attr *p;
> > > >       struct attribute **attr;
> > > > -     struct iio_buffer *buffer = indio_dev->buffer;
> > > >       int ret, i, attrn, attrcount;
> > > >       const struct iio_chan_spec *channels;
> > > >
> > > > -     channels = indio_dev->channels;
> > > > -     if (channels) {
> > > > -             int ml = indio_dev->masklength;
> > > > -
> > > > -             for (i = 0; i < indio_dev->num_channels; i++)
> > > > -                     ml = max(ml, channels[i].scan_index + 1);
> > > > -             indio_dev->masklength = ml;
> > > > -     }
> > > > -
> > > > -     if (!buffer)
> > > > -             return 0;
> > > > -
> > > >       attrcount = 0;
> > > >       if (buffer->attrs) {
> > > >               while (buffer->attrs[attrcount] != NULL)
> > > > @@ -1367,19 +1355,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > > >       return ret;
> > > >  }
> > > >
> > > > -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > > +int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > > >  {
> > > >       struct iio_buffer *buffer = indio_dev->buffer;
> > > > +     const struct iio_chan_spec *channels;
> > > > +     int i;
> > > > +
> > > > +     channels = indio_dev->channels;
> > > > +     if (channels) {
> > > > +             int ml = indio_dev->masklength;
> > > > +
> > > > +             for (i = 0; i < indio_dev->num_channels; i++)
> > > > +                     ml = max(ml, channels[i].scan_index + 1);
> > > > +             indio_dev->masklength = ml;
> > > > +     }
> > >
> > > I've not really figured out if it matters, but this is a logic change.
> > > Previously we didn't compute masklength if there was no buffer provided.
> > > Now we do.  It's probably better to move the if (!buffer) check above
> > > this block or at least mention this change in the patch description.
> > >
> >
> > Umm, are you referring that this patch is a logic change or you are
> > suggesting a logic change?
> > The "if (!buffer)" check was positioned after the masklength
> > computation even in the old code.
> >
> Got you.  Diff confused me :)

Yeah.
Happens to me to with some git diffs.

>
>
> > >
> > > >
> > > >       if (!buffer)
> > > > -             return;
> > > > +             return 0;
> > > > +
> > > > +     return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
> > > > +}
> > > >
> > > > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > > > +{
> > > >       bitmap_free(buffer->scan_mask);
> > > >       kfree(buffer->buffer_group.attrs);
> > > >       kfree(buffer->scan_el_group.attrs);
> > > >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > > >  }
> > > >
> > > > +void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > > +{
> > > > +     struct iio_buffer *buffer = indio_dev->buffer;
> > > > +
> > > > +     if (!buffer)
> > > > +             return;
> > > > +
> > > > +     __iio_buffer_free_sysfs_and_mask(buffer);
> > > > +}
> > > > +
> > > >  /**
> > > >   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
> > > >   * @indio_dev: the iio device
> > >
>
