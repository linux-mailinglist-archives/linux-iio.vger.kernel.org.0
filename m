Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C392C3EBC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgKYLGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgKYLGY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:06:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C7C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:06:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x15so949223pll.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW6s696QTyvwNP7WKOVsehs2i+r6Vdi7Fi/2pXdD7Zo=;
        b=jev8F89TMH55mqgfT0nVPbHlDuImpVFZRSCYr7jCjAwkbczCHLf7JvJQAKu93HL5LI
         yYIjzpjxoHQSIbhZ9wncPVsbiwliw2/A0iRIkJ0T2N5DSXsOksBe3J8i2h50aI2gA/JE
         +XhAZe03LEmNnVnegoIGxzkgQdh83o6ABgiODfmqxgy4/pk/ixx1yzniBJx0iNkJ0Fof
         iID3MYzDUxgRYOSxL9L9Scc8wp3v07aFumlpfGgBbE3wgu0Y5V3T2S00FQ8CL8b1sVqT
         BGo2lhyrTsgTC7J4WnnTYM08rmh3GVmr9L27c8IMjuVMeRiut86ab6ze0svXn493rbgY
         oGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW6s696QTyvwNP7WKOVsehs2i+r6Vdi7Fi/2pXdD7Zo=;
        b=ucwaUplMcXIzyKCekoPKaGxzIuBCwLsZ4dZR0tAhQMDQOZhwRyM3rQhcKZg0WIjFxk
         R5iU5kghKZoSdGxnEeb1VoeHz91gbAadsls5qsnUpKIkkyQ9htOwrzgglSXq8pnfm36A
         q6stCy+9ikYi+KbuQa3B7l5y5AU1lhQYgKw/vTLC/GzDBs5o1qShuWf2Al3X2bVCbc2G
         7YasHhtkQ2wYqt7787RZLttRmugVQD0xFZpo/CR6F4kLttDESBWp6inOBPgZFaQjMQ+7
         rid5I1FAcyPuanhoG0e3kJvbWO3qw9pY2OQMd5gQEdI1zHNTD4GODZmp/jK/IN4XUVZE
         gPiA==
X-Gm-Message-State: AOAM531RJPe4bBp3YvcLxYCC++MZqwddd0gzE5htYdAUJQEwJE6JK5T/
        UW/X6QJQjzfzRBBgpVNTH5pH89dI4ghIB/NzUNM=
X-Google-Smtp-Source: ABdhPJxkcYNJwff0Or/uYUYWSevyV6CYm/YHf8ztx8bzfRsApRtL0KR3bTguerUPQZSaWj9h6bxFri00N984/AGM99k=
X-Received: by 2002:a17:902:ec01:b029:da:13f5:1aaa with SMTP id
 l1-20020a170902ec01b02900da13f51aaamr2583149pld.0.1606302384402; Wed, 25 Nov
 2020 03:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com> <20201125083618.10989-4-hdegoede@redhat.com>
In-Reply-To: <20201125083618.10989-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 13:07:13 +0200
Message-ID: <CAHp75Vd5i7aErbRN9RVeH9H+OdKSqc_OKPnUtWR+cs7iP-Us2g@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: accel: bmc150: Get mount-matrix from ACPI
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> bmc150 accelerometers with an ACPI hardware-id of BOSC0200 have an ACPI
> method providing their mount-matrix, add support for retrieving this.

...

> +       if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0)
> +               alt_name = "ROMK";
> +       else
> +               alt_name = "ROMS";
> +
> +       if (acpi_has_method(adev->handle, "ROTM"))
> +               name = "ROTM";

My gosh, it's a third method of this...

...

> +       elements = obj->package.elements;
> +       for (i = 0; i < 3; i++) {
> +               if (elements[i].type != ACPI_TYPE_STRING)
> +                       goto unknown_format;
> +
> +               str = elements[i].string.pointer;
> +               if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
> +                       goto unknown_format;
> +
> +               for (j = 0; j < 3; j++) {
> +                       switch (val[j]) {
> +                       case -1: str = "-1"; break;
> +                       case 0:  str = "0";  break;
> +                       case 1:  str = "1";  break;
> +                       default: goto unknown_format;
> +                       }
> +                       orientation->rotation[i * 3 + j] = str;
> +               }
> +       }

I'm wondering if we can come up with some common code out of this and
existing apply_acpi_orientation().

-- 
With Best Regards,
Andy Shevchenko
