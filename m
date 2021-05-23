Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC938DC8B
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhEWTKm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhEWTKm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 15:10:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0BC061574
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 12:09:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9218534pjx.1
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FKla85xuumYLoXrDQb7lCH5KkqAg/YfMPErEisPyMU=;
        b=p6iHkkICO/qCmFyLz+2YY01cAaEgnM4/mdz9L7nEMfDRMcjXcoPdM2u6LzqORi/0/L
         bXCKKCWz8SlTsJnjAiK0SFiM5chzTtG49gjBgrJWn9/W06TtzwYYYP2w0JZxU4f4Pc3p
         VWo8HPhRMcydxbzUlc69Lvn3/1d+PI3MqJqew0vL9+/zDf7H79DuVEAkXHyxRer1DPhq
         Y9y9VFsU+kBWvinujLWh+T5slXXOuIVM0Rbthpj04k/a8bpRMSOjC8+mwLUJ+PrqenVi
         p/jydQqGal32m5AhwPy51E4Qf12GA03iAbxP24DNe+bExkeLfoa8lLFqGARjyG8BDFtP
         haRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FKla85xuumYLoXrDQb7lCH5KkqAg/YfMPErEisPyMU=;
        b=LEQQcLQxWZt0gjy2ceUkKNTVJLtauZm3qDIIKLJpanwA6iBNiu1v9aAdbsv/71HEt3
         gIpmYboE6xXQhIaCsI3AjDUTUKufvDda22nnuD2lZG91fx/TuurkgrhEPaduTFbz3K07
         ElfchtJai7DQqk9xu8vwO9IAhDGaUSRXA1sGZgMfTh8qynjFfb6ZVWCiKBlmF9TQj18Q
         IU5q+A9T5PgJ5JAd9tQk2QJyQR+4wbWd95XgPv1DctojBXBY58ciCNXiBkFbdig91pNM
         pBihogY/+oq2F4RbMsat3wY9dP7Trc2LXwqmxx+YXpHRxFryWC/PYwE6WYP8qIIJOOKs
         QrTg==
X-Gm-Message-State: AOAM531qIrpGJZ3lFUZwf6CFM6/VX3bF0ZnR/kkKd9v1E2h+J+1+kciP
        FyeOzWtCHiL0qqyxhJ46m1FaLikXB1xdDQPX/hg=
X-Google-Smtp-Source: ABdhPJzNxgMIR/4Bo5myrfpVZnXQI3IqwKdOi6dPYKURR4BOdZKQfXLiC4ejwd8tM9JkN0QgcFhBWWuausUNep71vR4=
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr21129407pjq.228.1621796953339;
 Sun, 23 May 2021 12:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210523170103.176958-1-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 23 May 2021 22:08:57 +0300
Message-ID: <CAHp75Vc=3VH=Mj-jZAYWjgp-bRU46CGtqw90b_2QYfoLurEeQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] iio: accel: bmc150: Add support for yoga's with
 dual accelerometers with an ACPI HID of DUAL250E
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 23, 2021 at 8:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi all,
>
> Here is v2 of this series, addressing Andy's review remarks and
> rewrap some comments at 80 chars limit.
>
> For more info here is the v1 cover-letter:
>
> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> to allow the OS to determine the angle between the display and the base
> of the device, so that the OS can determine if the 2-in-1 is in laptop
> or in tablet-mode.
>
> We already support this setup on devices using a single ACPI node
> with a HID of "BOSC0200" to describe both accelerometers. This patch
> set extends this support to also support the same setup but then
> using a HID of "DUAL250E".
>
> While testing this I found some crashes on rmmod, patches 1-2
> fix those patches, patch 3 does some refactoring and patch 4
> adds support for the "DUAL250E" HID.
>
> Unfortunately we need some more special handling though, which the
> rest of the patches are for.
>
> On Windows both accelerometers are read (polled) by a special service
> and this service calls a DSM (Device Specific Method), which in turn
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
> DSM to re-enable it (similar to how we also need to call a special
> DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).
>
> Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
> 2 accelerometers specifying which one is which.

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Regards,
>
> Hans
>
>
> Hans de Goede (9):
>   iio: accel: bmc150: Fix dereferencing the wrong pointer in
>     bmc150_get/set_second_device
>   iio: accel: bmc150: Don't make the remove function of the second
>     accelerometer unregister itself
>   iio: accel: bmc150: Move check for second ACPI device into a separate
>     function
>   iio: accel: bmc150: Add support for dual-accelerometers with a
>     DUAL250E HID
>   iio: accel: bmc150: Move struct bmc150_accel_data definition to
>     bmc150-accel.h
>   iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor
>     functions
>   iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the
>     hinge angle
>   iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
>   iio: accel: bmc150: Set label based on accel-location for ACPI
>     DUAL250E fwnodes
>
>  drivers/iio/accel/bmc150-accel-core.c | 110 +++++----------
>  drivers/iio/accel/bmc150-accel-i2c.c  | 193 ++++++++++++++++++++++----
>  drivers/iio/accel/bmc150-accel.h      |  66 ++++++++-
>  3 files changed, 260 insertions(+), 109 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
