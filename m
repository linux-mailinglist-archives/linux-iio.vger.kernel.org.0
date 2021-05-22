Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26C38D6EE
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEVSXP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhEVSXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:23:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0FC061574
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:21:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x188so17409613pfd.7
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PXWQ1t29E0XjRw9NAMyNH5iQX/P2MVw0kTd+DcmsirM=;
        b=dPBSZfFfoyzIji1byaqF0iozfCg6aXGPro8s9ClOMQMyLQFB8nZsykbY6wpqzp6KnW
         25rR3InG3vjpjIxuj3mm8Aa5Q7/hn7F8ZztgRQaopLAFNS/hMKMN0X6EPdjHRaWYyDTT
         Y9uuwpvLoh8MvHd60c4o5Y4OncLfXznw9/tWQhSjxbNSKCIz/ybCH3zrWP559jqzBRfb
         Z9LGp98zDe5xdgVQB2xQah6BOIBFUcmoWRmiKyUqg3OxbnPTIwlo8114D1kKmwJ2wyrb
         vTgC1W1h0OB6kQWdohoKt9SYuwf2QxWMbhZvzwWKJ2xl9K9TVYv4o/Y8BXXWiL+Lhvwn
         8ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PXWQ1t29E0XjRw9NAMyNH5iQX/P2MVw0kTd+DcmsirM=;
        b=jGB3CiSy4ImKqMBMsW0kXLthlJa3pqx9DWDb2VL28Rr542Fq3PDRNaTUlGiaFWtJ9D
         vQ5gNyCkTjgP7PHAh1otYP8BxfbYIp4jv8W9N1t8u0Ivi+mcW+4C6j/mMmE9B36iLe9B
         a4aCsKj4kJHgxboZC3uALAVImZku7y7vkdUxy9o/EvEDVb4rmHCoQ+7bsxDoM8T5fIlR
         eHkjDGYWceKx0Iuz4kaXtjoKE4ttnN3plI787w8ig9Zqlbzb1sI0ZKw7h504JqfgQy8r
         XsrtawLHxT/Dg+SbcKsUjM9OqZphLdJectopszypt9sV9EDzW4ixzaRa9tLjVmX6iHEM
         FYNA==
X-Gm-Message-State: AOAM5319iOfyi2ew25L/13F3QJ2TzLbLU25gyRI5t4iYfGeSIkIt9G0P
        Bi7y65fGAEWGf5GVCV3mojPuc/gqt0nUbDTiHfE=
X-Google-Smtp-Source: ABdhPJz/Hh0xprFoUQCAqWbFVzG5h5EFiU/D7hqUW8HfFPexcmPlnXFkBDHwoF/yaXN+sRCDCCbUonK0IQ8cM1idOV0=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr14623858pfh.73.1621707708151; Sat, 22
 May 2021 11:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210521171418.393871-8-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-8-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:21:31 +0300
Message-ID: <CAHp75VdAC9nP5EyCCMZ41vmSsZoV8gPOMxOkY=U4gVm5dQAXCg@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: accel: bmc150: Add support for DUAL250E ACPI DSM
 for setting the hinge angle
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 11:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> to allow the OS to determine the angle between the display and the base
> of the device, so that the OS can determine if the 2-in-1 is in laptop
> or in tablet-mode.
>
> On Windows both accelerometers are read (polled) by a special service
> and this service calls the DSM (Device Specific Method), which in turn
> translates the angles to one of laptop/tablet/tent/stand mode and then
> notifies the EC about the new mode and the EC then enables or disables
> the builtin keyboard and touchpad based in the mode.
>
> When the 2-in-1 is powered-on or resumed folded in tablet mode the
> EC senses this independent of the DSM by using a HALL effect sensor
> which senses that the keyboard has been folded away behind the display.
>
> At power-on or resume the EC disables the keyboard based on this and
> the only way to get the keyboard to work after this is to call the
> DSM to re-enable it.
>
> Call the DSM on probe() and resume() to fix the keyboard not working
> when powered-on / resumed in tablet-mode.
>
> This patch was developed and tested on a Lenovo Yoga 300-IBR.

...

> +       if (strcmp(acpi_device_hid(adev), "DUAL250E"))

Can we use like in the other case in this series the acpi_dev_hid_uid_match=
() ?

Because it's actually what you are doing here and it may be better to
see the same approach for this HID done in different places in the
code to recognize what it is about.

> +               return false;

...

> +       /*
> +        * The EC must see a change for it to re-enable the kbd, so first=
 set the
> +        * angle to 270=C2=B0 (tent/stand mode) and then change it to 90=
=C2=B0 (laptop mode).
> +        */
> +       if (!bmc150_acpi_set_angle_dsm(client, 0, 270))
> +               return false;

> +       /* The EC needs some time to notice the angle being changed */
> +       msleep(100);

I feel that you conducted a research and answer to the following will
be no, but...

Do we have any means of polling something (embedded controller / ASL /
etc) to actually see the ACK for the action?

> +       return bmc150_acpi_set_angle_dsm(client, 0, 90);

...

> +       schedule_delayed_work(&data->resume_work, msecs_to_jiffies(1000))=
;

Isn't it the same as 1 * HZ ?

--=20
With Best Regards,
Andy Shevchenko
