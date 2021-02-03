Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAC30D6F9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Feb 2021 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhBCKC7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Feb 2021 05:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhBCKC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2021 05:02:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D1C061573;
        Wed,  3 Feb 2021 02:02:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s23so15712772pgh.11;
        Wed, 03 Feb 2021 02:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2oISiYeGVu9ZpGUGgNNH2LGtwu+nmXL1dEBI84TFMM=;
        b=W+1GldZsRoSu3m/0ipd3CCiVm4f8is+x3pSwGQwqTXOG0nRj0cLxX2xW4EbF6qJrfd
         CAZdVXqimcETYd0G5B1J3IqfqENiCQsxGU/NdovEJX2rr5881ffBLMRy3grwkLnjMlwg
         1SZnp4oC/GGmhU4KDvA8sYzapKZPC4XeBTzRbq5C9CVzeuyaeMRYPkXdKaN19pEIzAz0
         Oax4tmJ9475sK1JLvaCcgyTu70CuExP7CP1IT1L+2BSQeaYxZ9QvrUwSwgY6WB6N6g58
         Pe0er4Jbdv08inotyKuuUXJf0XclpttapQvN0GdUqdkrPAmihgRw4VqQl4K8MiatyepO
         cXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2oISiYeGVu9ZpGUGgNNH2LGtwu+nmXL1dEBI84TFMM=;
        b=pbvyFTI0WxqX3zAmZm/GDSBMTsalg4pcS9gFeW0eWqLuBv0+QYjcQao/0UqOOfT9Ul
         X1VnPmSP7O+/CvmRgfeUWqKM5goOsnsuQaaph4ZVaKqbzCg7x1J7W+frv5phxjbUXAVt
         OTKXyukht6f6liFIiiXAENLA7ag0P7zjoTUXQwKO1lfVdWBwC8i4BnCSz/LPuXsW8L3q
         6QcUhqrHWHhfX7ZfrSdHBuz+TjLiHN6ZBlET7HeGlkZoaeyrtRmkRlThnuDLwXTVtkIk
         KjzGcLbDJeGQsasN5EY6P2XxzX+KwyWOCYoD2OElKxza4f7WcATDQbiKVSdhRPaFE+VY
         UKOw==
X-Gm-Message-State: AOAM531E7V5I65rFEoJle2t+pV+MGZI3DNHDipInMgQ3z3tJiNy6vHZD
        Xgx3tvE75jB/5JwcuJlJjcJZrqRE/Uheu0iUDlw0Q1N600FAYw==
X-Google-Smtp-Source: ABdhPJwC/eP0avRMXCOsyF4LK/8HSFs7KIop3/ije5w4NAmsjniRFoSe6/SVwmUgDLLqkwGBR1Tn/MbEb6Qn2X1rmjg=
X-Received: by 2002:a65:644b:: with SMTP id s11mr2839544pgv.4.1612346537161;
 Wed, 03 Feb 2021 02:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com> <20210201145105.20459-7-alexandru.ardelean@analog.com>
In-Reply-To: <20210201145105.20459-7-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Feb 2021 12:02:00 +0200
Message-ID: <CAHp75VcTk-Lv_Hr0VHnd-r2XoVeRHEocwVyg6kKdWYrkHnf0gg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] iio: core: merge buffer/ & scan_elements/ attributes
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 1, 2021 at 5:28 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> With this change, we create a new directory for the IIO device called
> buffer0, under which both the old buffer/ and scan_elements/ are stored.
>
> This is done to simplify the addition of multiple IIO buffers per IIO
> device. Otherwise we would need to add a bufferX/ and scan_elementsX/
> directory for each IIO buffer.
> With the current way of storing attribute groups, we can't have directories
> stored under each other (i.e. scan_elements/ under buffer/), so the best
> approach moving forward is to merge their attributes.
>
> The old/legacy buffer/ & scan_elements/ groups are not stored on the opaque
> IIO device object. This way the IIO buffer can have just a single
> attribute_group object, saving a bit of memory when adding multiple IIO
> buffers.

...

> +static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
> +                                                  struct attribute **buffer_attrs,
> +                                                  int buffer_attrcount,
> +                                                  int scan_el_attrcount)
> +{
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +       struct attribute_group *group;
> +       int ret;
> +
> +       group = &iio_dev_opaque->legacy_buffer_group;

> +       group->attrs = kcalloc(buffer_attrcount + 1,
> +                              sizeof(struct attribute *), GFP_KERNEL);
> +       if (!group->attrs)
> +               return -ENOMEM;
> +
> +       memcpy(group->attrs, buffer_attrs,
> +              buffer_attrcount * sizeof(struct attribute *));

kmemdup() ?
Perhaps introduce kmemdup_array().

> +       group->name = "buffer";
> +
> +       ret = iio_device_register_sysfs_group(indio_dev, group);
> +       if (ret)
> +               goto error_free_buffer_attrs;
> +
> +       group = &iio_dev_opaque->legacy_scan_el_group;

> +       group->attrs = kcalloc(scan_el_attrcount + 1,
> +                              sizeof(struct attribute *), GFP_KERNEL);
> +       if (!group->attrs) {
> +               ret = -ENOMEM;
> +               goto error_free_buffer_attrs;
> +       }
> +
> +       memcpy(group->attrs, &buffer_attrs[buffer_attrcount],
> +              scan_el_attrcount * sizeof(struct attribute *));

Ditto.

> +       group->name = "scan_elements";
> +
> +       ret = iio_device_register_sysfs_group(indio_dev, group);
> +       if (ret)
> +               goto error_free_scan_el_attrs;
> +
> +       return 0;
> +
> +error_free_buffer_attrs:
> +       kfree(iio_dev_opaque->legacy_buffer_group.attrs);
> +error_free_scan_el_attrs:
> +       kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> +
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
