Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0A3303F4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCGSgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCGSgL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 13:36:11 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA011C06174A;
        Sun,  7 Mar 2021 10:36:10 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id v14so6859825ilj.11;
        Sun, 07 Mar 2021 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbQjv9Mv0xwkm4S3YZaXGvRrT1lLub9Kj3fgmokzjW4=;
        b=a0oAH8gSJAuVdMBJWrQAPcBJBnIpFsqf5RdWDv74K0aeGDFR1fPviY5JkGjDGpIwmV
         X+nSeicvJXEJcqO1GqQY81FhFlKc2iOio11xz7e9EgLLmXD2OER8shUyvzOIHPAKsx4T
         JhKlaGcRk/lndKMUgdsjHQMPYhDk1VuqC64paodEMIaFosHTsVdg0VCMsG3Weh1c+6iv
         wSJbXaa+wlYasUw/PkmMNN4GbpR2MbcFP2oV3U45DFqbNy4uEOD0HlFk2w6Eo8cl24va
         tS94lRcoAPM7/XdPwlE2BcDFdjDoe8PFezRY1EaOIA0K+JXw3YIJ5+GFfEkX4SHBfK7T
         JHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbQjv9Mv0xwkm4S3YZaXGvRrT1lLub9Kj3fgmokzjW4=;
        b=EpLbx94UndqZQmxqSn1gDG62ddzgJTKwZh5XOQwIvnFVZSDqVW4qzp1bTbLxvAoRmc
         DwuAAtZdmTPu+Dcq0a97cv7BPmvRH9v+oowYnOyhiPVNIUiGogzOKFNIEIF/BknIgb8p
         VGmJp/YEurUVy1czLzLNnzp73d6hinvbhqBM4hl/qOCBx8Qb0esBeQsK+TnSBZKXRTx0
         rAAQOmXLPS9e92rZTijwmqyIlxXDWyLUrsIxrsPEe9iyXf0BYzFgFBkhGytveX4ePHT5
         CsvXhCSwJWAdG5OaV8n2UE6nDG0bqYog+/ono0CmdOLcj0pFc8i7k8EvlTfBiVJF6+fo
         xWgQ==
X-Gm-Message-State: AOAM5316ajm8cJtK/YLTS2kUcUUURwzmFIZ+z62jIVxn4ZGHDxYQOWDa
        pNVdlPTjNJ0Tg4eBssZ4Xqg1fXnfEOJHZGZWOcs=
X-Google-Smtp-Source: ABdhPJwAEsmcq0ewvdI+IH1cd+R8gsUz07BxCYXHgt3V13dUuMsVOj1vrXuPFeXOgfCs2AtrQpxPjv6daS1ZnKZ3Xkw=
X-Received: by 2002:a92:194c:: with SMTP id e12mr17228526ilm.292.1615142170260;
 Sun, 07 Mar 2021 10:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20210306164710.9944-1-ardeleanalex@gmail.com> <20210307123658.3bdc0016@archlinux>
 <a1ffef80-2f43-68bc-cb46-4f3bac326671@metafoo.de>
In-Reply-To: <a1ffef80-2f43-68bc-cb46-4f3bac326671@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 7 Mar 2021 20:35:58 +0200
Message-ID: <CA+U=Dsqti6mActFZ_1r4hxF5LqYRO=APriLwWb=fH19HdkirsQ@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: fix use-after-free for attached_buffers array
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 7, 2021 at 2:54 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 3/7/21 1:36 PM, Jonathan Cameron wrote:
> > On Sat,  6 Mar 2021 18:47:10 +0200
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >
> >> Thanks to Lars for finding this.
> >> The free of the 'attached_buffers' array should be done as late as
> >> possible. This change moves it to iio_buffers_put(), which looks like
> >> the best place for it, since it takes place right before the IIO device
> >> data is free'd.
> > It feels a bit wrong to do direct freeing of stuff in a _put() call
> > given that kind of implies nothing will happen without some reference
> > count dropping to 0.  We could think about renaming the function to
> > something like
> >
> > iio_buffers_put_and_free_array() but is a bit long winded.
> >
> > Otherwise, I'm fine with this but want to let it sit on list a tiny bit
> > longer before I take it as it's not totally trivial unlike the previous
> > one.
>
> Maybe to go with naming schema of iio_device_attach_buffer() call this
> function iio_device_detach_buffers(). We grab the reference in attach,
> and drop it in detach.

That actually sounds like it fits beautifully ( the
iio_device_detach_buffers() name ).
Thanks for the hint.

I'll send a V2.
I didn't consider more on the renaming of iio_buffers_put() because I
was a bit stressed by the silliness of the use-after-free bug.

Thanks
Alex

>
> - Lars
>
