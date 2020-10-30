Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1292A034C
	for <lists+linux-iio@lfdr.de>; Fri, 30 Oct 2020 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJ3Kww (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Oct 2020 06:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJ3Kwv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2020 06:52:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D85C0613D2
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2020 03:52:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so6992740ioo.7
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2020 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZ3jKEDXZlqXtXgXWZosWZYuBzB1jkXYoNWcA+wZdxc=;
        b=TnAq0JDV19kWvbxA92eLES19ttE/Y4+2XhGiV0zhyUlwcuVbhprQpPq0ZQV+p1JqHI
         O4cvJJEB5wliVeYPxTumc9aXaH530u/UX9HqP/vNCI2+H9UjMgPnrn2PfWTkkX8aFZal
         zuRzHXhdUZjRSOIFCg/VRtay2lIk7B1PQRFeSCDJQrwZZa5KqF3n09xpbqqx2YWe6XPn
         YieuBV9edXHvcpbEi9BfDxyajn3f/0X5zH+EHF/Eg9a7WaoFklq5CpC36ppf/mLpYWHZ
         EP3rncmS93asi48WYZwo415QvqRG7Z7gHz/FuXK/z6XKFsVazoUn+9wFizdM5QLF0p/0
         sCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZ3jKEDXZlqXtXgXWZosWZYuBzB1jkXYoNWcA+wZdxc=;
        b=aXrOTq9ydjadComg/Hoyrt71/fMj689w1buUe0yQDCjrVpCEHkHY8cWkKcL6GjxKwd
         QvfxWwPdtm2jJf2kPZGvFjKMFnUs+ai01up0UipTYqcm67pX0Bqkj9yePxrY/1sHfNH9
         UrCxhHMc2berp85kL8EjNjermwS1jnmlH87qsAcFrMF9bAtmCI+pasZTYSD1zFXvetYX
         D49Sml/oeWBUVMGMHDNfTRdlWnLie6V0LF7GbMhY2HF17TFRgX8l/2Si54HpSXFd9wzz
         qekdmOLlvt2XnTfDLM5JpRlnhhy9mKuVBLoq2bBZMgepRysaX0msQDnb4UlYLeP+ekMt
         chlA==
X-Gm-Message-State: AOAM5332qG9XEsLOFsQY789qk4bU+YXqiWwM80D2Q1M91fWPqD65RIqr
        5gO4c/OkDpizVNRDrl2EtZbtMKW5ZS9iENfS5TkDkg==
X-Google-Smtp-Source: ABdhPJxOZMCH6oMWFYGWOJLLt7kcLu7C1LC8cEzfORXLn1CTUwczkRvHrR55P3QXjffP+L+Eq2o9yphjTp27lAvj+Oo=
X-Received: by 2002:a05:6602:2b90:: with SMTP id r16mr1276394iov.31.1604055130752;
 Fri, 30 Oct 2020 03:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201026133609.24262-1-brgl@bgdev.pl> <20201026133609.24262-5-brgl@bgdev.pl>
 <20201029154118.12fd6c23@archlinux>
In-Reply-To: <20201029154118.12fd6c23@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Oct 2020 11:52:00 +0100
Message-ID: <CAMRc=Mfun85W+ZfJqaXohCQ8tNGDxjxmvdFuwsQ07jMhG+vU7w@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: adc: xilinx: use devres for irq handling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 4:41 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 26 Oct 2020 14:36:08 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Further simplify the remove() callback and error paths in probe() by
> > using the managed variant of request_irq() as well as using a devm action
> > for cancelling the delayed work at driver detach.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Again, this is potentially fine but I'd rather you cleaned up the ordering first
> rather than doing things in this order.
>
> The end result of the whole series looks like it will be correct, but that isn't
> so obvious for the intermediate patches on their own.
>
> Also, you end up with a lot of noise renaming gotos that then go away at the
> end.
>
> Jonathan
>

Hi Jonathan,

My two priorities for the ordering of this series were: correct
end-result and not breaking anything on the way. The latter
unfortunately gets in the way of cleaner looking intermediate patches.

I tried to not alter the ordering in which the resources are freed at
any step. As devres release callbacks are called *after* remove() and
in a reverse order to how they were registered, I needed to start from
the bottom of the remove() callback and convert the last operation,
then go upwards from there.

If I tried to do it from the top - I probably could remove labels
earlier and in a cleaner manner but it wouldn't guarantee
bisectability.

Bartosz
