Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CD3273B1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 18:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhB1Rro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 12:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhB1Rrn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 12:47:43 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E34C06174A;
        Sun, 28 Feb 2021 09:47:03 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id c10so12650655ilo.8;
        Sun, 28 Feb 2021 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6OXSfkU2qK5xePiGbnM2gczF9Z8FwxWE7VO3mRICM8=;
        b=sl6QcBrQU9mYzEYJD9qnsQp3q5UrEqLuGzoDh4EAEbUTvc2Rx8aFjyJNorSvpQq2s8
         jqTnNKGchZPcv7AJc3ryfh3DgrLBuKVdpqVkkTMvSf8YOD3PtadVf2XyJjX09heyqiPl
         G+9HKs9LsJsMDlsQXxhU0v1So/mQPKS7XvdXRiZ19zR/glvF2O0hY2dVA/842zIxuxds
         dtc2cfxqm7Ag/CO6CP+MZkIly7i7jQ8El8wUjHyutHbAxQWq/wGq+X6Xh2qCU3NBYNeZ
         RtblPAq1NkA0ShodBI7rObZxleZ1/hJ4WZQe/wKR9c/mOMarDWHpcyd/8tTBqBSnqhGq
         d1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6OXSfkU2qK5xePiGbnM2gczF9Z8FwxWE7VO3mRICM8=;
        b=SzuhhSeiZzy2vxOXaFZKehlCoA+BN0Be3nz1zCKgTvjg21FmHjSZPQrXSVTuVN5/Lc
         i74cD3fX4539upABadcwAcnmE3Dp/Ce8um4nj1QuiZFTK2IdPiUiY5I2mZc59DOuqsDn
         oAPY5+iqgZEda70mVgzfBCpmPuCstOB8Z8fq7eOY9zJWRr9GnvKxd5scUf6CMkQq4yfj
         D1GeYOFA2vdjin0AXEFvPU+y5cI6w4Itt3HSMnad0q1SyHr6w2jC43QpHyWf9BEFCjg7
         3QpORKWRHSpcZagpwwL+MwD/7r1g6LHwpVuom4GngobewD8HPQH5r3IgW6C7LY+hpPrM
         m69Q==
X-Gm-Message-State: AOAM530e5Pg4dTsFooi6AmzCh4NTFPTRISqZJQeCZ30CzHA0r0SGF4Eb
        gcBQoDFWoKqPAzr+kA2pNiBjRRTRirw0enqF//o=
X-Google-Smtp-Source: ABdhPJz9GyuSHR8GJSrILgrqKMGNPAKwi4A/JxsF5OUmPJNe/ztFcAzA2oAc5m8lG1A1TCoQ8szZtvf3uOYQ8vx0p34=
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr10222075ilo.217.1614534422599;
 Sun, 28 Feb 2021 09:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-20-alexandru.ardelean@analog.com> <d616ffac-9747-55f8-0478-dd747dba381a@metafoo.de>
In-Reply-To: <d616ffac-9747-55f8-0478-dd747dba381a@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 28 Feb 2021 19:46:51 +0200
Message-ID: <CA+U=DsrhojhamxY6da7CSu79pkAnF=nHPk3H=xAbkZmtLozx2g@mail.gmail.com>
Subject: Re: [PATCH v6 19/24] iio: buffer: introduce support for attaching
 more IIO buffers
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 28, 2021 at 10:31 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> >   static ssize_t iio_show_scan_index(struct device *dev,
> >                                  struct device_attribute *attr,
> >                                  char *buf)
> > @@ -1451,11 +1465,13 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >       iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> >   }
> >
> > -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > +int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >   {
> > [...]
> > +error_unwind_sysfs_and_mask:
> > +     for (; unwind_idx >= 0; unwind_idx--) {
> > +             buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +     kfree(iio_dev_opaque->attached_buffers);
> > +     return ret;
> >   }
> >
> > -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > +void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >   {
> > [...]
> > +     for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +
> > +     kfree(iio_dev_opaque->attached_buffers);
> >   }
> > [...]
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 1d500ea246af..f7f785431106 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1583,7 +1583,7 @@ static void iio_dev_release(struct device *device)
> >       iio_device_unregister_eventset(indio_dev);
> >       iio_device_unregister_sysfs(indio_dev);
> >
> > -     iio_buffer_put(indio_dev->buffer);
> > +     iio_buffers_put(indio_dev);
> We do call kfree(iio_dev_opaque->attached_buffers) before we get here. I
> think we need to keep the array around, otherwise we end of up with a
> use after free.
>

Good catch.
Will send an update here.
