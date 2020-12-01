Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0C2CA5F8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 15:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgLAOnM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 09:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgLAOnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 09:43:12 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90630C0613D4
        for <linux-iio@vger.kernel.org>; Tue,  1 Dec 2020 06:42:26 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x15so1901004ilq.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2TuqfkTv0QwrGM79A0LbjfzFFhrvh4RJ/XOm463Zmg=;
        b=VAIfI0vbJf0BsuygIhzEb1Nkslj8HAcWnyJ2YoDjezBIu9tLEAlJ6YYqBrMXz2Q+e2
         U7PXimDeHi1/dfp6pZ4Gm9m9Ofu2WVwEXiWVfdXI3SrmeQ/sVWcq3rhWlyWwrVeirgOO
         kC9IPJoHu7hzsw4rliUkiHA6MrxuDFu9Oi4wFyak6qHW6pUpJ0t6v1cI/wMkfB+z7YwT
         WJ4aNBDppFuttJnqOaeNwW3gIg0nJe59IRQKQCgZWK15t3mVC05OnaTj1G2HkiAAxZbb
         zCL2NtQxfybzAAlMaChkfNgOwmsBaSPNkPy0PbCbuK9UY0HvMeS7A3rv2I1cgC3Lejud
         xqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2TuqfkTv0QwrGM79A0LbjfzFFhrvh4RJ/XOm463Zmg=;
        b=i5LxL/X6ltVKTUY8GvnAcOGNIs1B/EfJRHgHfbQ/cGbsSxprT6gLbxyrZ3zY9c6cMJ
         /vWxrbPOmPsqOgcZqCvPk38kKaBNguGDPPKm86kjtBFISNTKFgTQRod+/Fo0n36HWkij
         v4ODA/80FrylLUPsD5mJ/3UU91EtYvxrJDrQ5GpHtOkcQWJctrtYOHBHKAFhxhrZOIBH
         3Sx8o2PKR0+0p618y98JfyXro6WeuivUuXGtbmaalIFoLkGmB22AgQ1Ujlx5WESkP7os
         d824JjAMKFiFUfZ3KBAq4NkFuxbMzv/ITZaOLqMB4Fg2N1qe8dKEadRgjMYvCxX2I86X
         zryg==
X-Gm-Message-State: AOAM530Ot0UwpHaJoEtT+YZ17Sul33YEkYDFezzw7LEUkjOxGLD9/1vS
        oetTBUombMpICkHxPF1W3CxlPqluJtSDrehuyhY=
X-Google-Smtp-Source: ABdhPJwjLsWMnDV4y5e+CJSmYn/dLI4MEoe3SJ18l8PoqPoo0ZPsIaL+YoRGg7oMHhRaikkBhPr3STkJVrM76Z9uZtA=
X-Received: by 2002:a92:155b:: with SMTP id v88mr2844132ilk.303.1606833745902;
 Tue, 01 Dec 2020 06:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20201125084606.11404-1-hdegoede@redhat.com> <20201125084606.11404-2-hdegoede@redhat.com>
In-Reply-To: <20201125084606.11404-2-hdegoede@redhat.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 1 Dec 2020 16:42:14 +0200
Message-ID: <CA+U=DsoCD=-9RRD2Q1V_j45YjnnPcj0EF+=qaDZfCyyO0aeDyw@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 10:47 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The iio-core extends the attr_group provided by the driver with its
> own attributes. To be able to do this it:
>
> 1. Has its own (non const) io_dev_opaque.chan_attr_group attr_group struct
> 2. It allocates a new attrs array with room for both the drivers and its
>    own attributes
> 3. It copies over the driver provided attributes into the newly allocated
>    attrs array.
>
> But the drivers attr_group may contain more then just the attrs array, it
> may also contain an is_visible callback and at least the adi-axi-adc.c
> is currently defining such a callback.
>
> Change the attr_group copying code to also copy over the is_visible
> callback, so that drivers can define one and have it workins as is
> normal for attr_group-s all over the kernel.
>
> Note that the is_visible callback takes an index into the array as
> argument, so that indices of the driver's attributes must not change,
> this is not a problem as the driver's own attributes are added first
> to the newly allocated attrs array and the attributes handled by the
> core are appended after the driver's attributes.
>

Sorry for missing this earlier.
I'm terrible with tracking emails sometimes.

> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/industrialio-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 261d3b17edc9..7943d0545b61 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1466,11 +1466,14 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>                 goto error_clear_attrs;
>         }
>         /* Copy across original attributes */
> -       if (indio_dev->info->attrs)
> +       if (indio_dev->info->attrs) {
>                 memcpy(iio_dev_opaque->chan_attr_group.attrs,
>                        indio_dev->info->attrs->attrs,
>                        sizeof(iio_dev_opaque->chan_attr_group.attrs[0])
>                        *attrcount_orig);
> +               iio_dev_opaque->chan_attr_group.is_visible =
> +                       indio_dev->info->attrs->is_visible;

So, I think I was pretty silly at the time, and did not fully know how
IIO handles attributes.
But I can see the bug now [in adi-axi-adc].
Thanks for identifying it :)

As an initial handling, this looks good.

I think this also means that we should check and see where else we may
need to do this.
Maybe, we should do a utility that handles this atribute_group copying.

But for this one as-is:

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> +       }
>         attrn = attrcount_orig;
>         /* Add all elements from the list. */
>         list_for_each_entry(p, &iio_dev_opaque->channel_attr_list, l)
> --
> 2.28.0
>
