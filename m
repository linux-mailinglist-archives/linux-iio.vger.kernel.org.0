Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F923AAD67
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jun 2021 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFQHZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Jun 2021 03:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhFQHZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jun 2021 03:25:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CCC06175F;
        Thu, 17 Jun 2021 00:22:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gt18so8064454ejc.11;
        Thu, 17 Jun 2021 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t36bard9BZBLMo3vLEQmVArLM7AwEt1QLlTy2vi0lKc=;
        b=jlB76qkcl0+zpwO3N3ZGq1VI6ZXhVeukaLWzrngdoMWqF+itm33yRlU1W+YhcUO+gn
         V2LSeQvco2/ppPeCTQ56v2yCtNsv6MFX10cJvDbnUt9n1xH211ur/BfBDGBcRiv3YwpT
         AJWl81QJ2wNheMqJzOQ9bSCTkkvPoxXVqiKRyRnhdDqbWkNC14yZ2zYqo1SWUYvdN5ku
         uObpWA46nHBVgotfQf9hAa3yeS4Dj53xf18u/8R2otAqLdKjlvX/VslYRxESKMuIXRtz
         6fYULYOxNlLPZ+WcWMnHMhxVuA0x89PdHFLQZAWHCERhryp+vtp1ND95ue1kYhrFi+mC
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t36bard9BZBLMo3vLEQmVArLM7AwEt1QLlTy2vi0lKc=;
        b=FHOedHx/0VWXWV/+fFCCacVPQpcit0OWyVVy1++/bmd/HZSPehN78uQYHf9gN/2ILg
         64cuqt0Ky2MfCqV6ciTe3BVAVlheBwdyvwXmw0+4wwUqp/PHZGUgYsWf269p/Dk6uAjD
         U43/8p9Fcc/s9xH/VaCXyLhuM4Uwy1r4tcOgldpSGIXTdm9A1mUbNTyz4ALdm+qjg9+N
         bbq85vQ5+hDYzZEP0oMdOodYia6WPBcDP6W00yOwqKrXumggplYs+yH608dclGXG6ff5
         ATilJx4f89HuiHjSFL/nW7L/ech6nv8QK+Z2E5NzjvlwQsaj8YnJv4sDiOyViLrxNTpb
         S83w==
X-Gm-Message-State: AOAM531uawKWMcwZJZD683W6xx2bF6cJZwVVSK9E3F+zfUbvI+4g2xph
        IaCKnE8bec1RB/cZ4LYOxKqnYODRNaARKgbuUEE=
X-Google-Smtp-Source: ABdhPJxpooCz21ghhp1dNN5QR19IXgH5e/N6oFjbkzdwmP20/LxfbExohXmmvcGSNaktXMuG5e4o2oYhnr2p1/PV+MM=
X-Received: by 2002:a17:906:39d7:: with SMTP id i23mr3761029eje.121.1623914569757;
 Thu, 17 Jun 2021 00:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210616155706.17444-1-paul@crapouillou.net> <20210616155706.17444-3-paul@crapouillou.net>
In-Reply-To: <20210616155706.17444-3-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 17 Jun 2021 10:22:35 +0300
Message-ID: <CA+U=DsrP6+Zjnca8Sqd0jAi9a4aDqAV4suJZc95ayqm7K0+mCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: core: Support reading extended name as label
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 7:00 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> The point of this new change is to make the IIO tree actually parsable.
>
> Before, given this attribute as a filename:
> in_voltage0_aux_sample_rate
>
> Userspace had no way to know if the attribute name was
> "aux_sample_rate" with no extended name, or "sample_rate" with "aux" as
> the extended name, or just "rate" with "aux_sample" as the extended
> name.
>
> This was somewhat possible to deduce when there was more than one
> attribute present for a given channel, e.g:
> in_voltage0_aux_sample_rate
> in_voltage0_aux_frequency
>
> There, it was possible to deduce that "aux" was the extended name. But
> even with more than one attribute, this wasn't very robust, as two
> attributes starting with the same prefix (e.g. "sample_rate" and
> "sample_size") would result in the first part of the prefix being
> interpreted as being part of the extended name.
>
> To address the issue, knowing that channels will never have both a label
> and an extended name, set the channel's label to the extended name.
> In this case, the label's attribute will also have the extended name in
> its filename, but we can live with that - userspace can open
> in_voltage0_<prefix>_label and verify that it returns <prefix> to obtain
> the extended name.
>

The best way would have been for all drivers [using extend_name] to
implement their own read_label hook.
But this can work fine as well [as the other method would add some duplication].

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/industrialio-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 81f40dab778a..9b37e96538c2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -717,8 +717,12 @@ static ssize_t iio_read_channel_label(struct device *dev,
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>
> -       if (!indio_dev->info->read_label)
> -               return -EINVAL;
> +       if (!indio_dev->info->read_label) {
> +               if (this_attr->c->extend_name)
> +                       return sprintf(buf, "%s\n", this_attr->c->extend_name);
> +               else

nitpick: else statement has no effect

well, this block could be reworked a bit as:

----------------------------------------------------
if (indio_dev->info->read_label)
   return indio_dev->info->read_label(indio_dev, this_attr->c, buf);

if (this_attr->c->extend_name)
    return sprintf(buf, "%s\n", this_attr->c->extend_name);

return -EINVAL;
----------------------------------------------------


> +                       return -EINVAL;
> +       }
>
>         return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
>  }
> @@ -1160,7 +1164,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>         int ret;
>
> -       if (!indio_dev->info->read_label)
> +       if (!indio_dev->info->read_label && !chan->extend_name)
>                 return 0;
>
>         ret = __iio_add_chan_devattr("label",
> --
> 2.30.2
>
