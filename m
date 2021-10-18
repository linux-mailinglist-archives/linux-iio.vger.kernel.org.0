Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0B4322C0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhJRPZW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJRPZV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 11:25:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48352C06161C;
        Mon, 18 Oct 2021 08:23:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t16so577218eds.9;
        Mon, 18 Oct 2021 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0Ncgi3C4vvyo62bqyzoeIINzEezmjR19f3DCyndJAk=;
        b=bUDbbwuXtqIZLSEY2+IaC8sdm4wZ96EtDAqV5GG1gmuK7l/aUpbUMgqsIl1G1Y1g0t
         YC+XSh012WckOYJnq1A7PdPCAJfCcduGGShyMUQ3ysn2mvJUZj0IPX5rhw/RKNwommL7
         SwpQLULZ/zcpT5Ba8g0aEQ58KtY+7SoJ7Gk1J/hy37enXbQEkH9+IEL2A5Dxw3LDFkca
         gGhVadjRvOHWn89e/8WP2tD8vDejoH6VY7gxEwhXpn5k3dFUUe6ed1BtjHjihF8uqQtj
         1EVO5o0ol6RYHgZdIvBAresdGPGsaoyOYlEWKHNeHFIGc0yW2fs8s/BdUeLniqlqf1zR
         iPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0Ncgi3C4vvyo62bqyzoeIINzEezmjR19f3DCyndJAk=;
        b=NMe65+lsTTcVJTCgpMmt+m37OixKSJkwEwLbFNrAKOSgLJSuOHjKaVnGdQPcIFCVkw
         5v/qTJNJfRzfA6Y4eFWEIFsqPfwHdQDmJad1Sj0ixsF8mMhN8fm8z7nadss6CDbuIG0z
         10r3OtcUk91j0oMs57mcLSBmVwTniZxvYb3t+jW57vcqGzVWwCeezGyciNwbcpCBRBmP
         LKJGBnEbw0ePZKkcDTASpOhP2G0KrF5ygVs5whp7g9xfTFPNeqcFQHLOt3L9f+0W8vpT
         L0irOwKrMnKxLAP/BmjI1ybZf0ebdPmT+GYiLbpj2I9lFNZ194m32weMNytwniYnfGmK
         aXhg==
X-Gm-Message-State: AOAM5314Hi87lTJ65WYFwS8YK4/gV3AEhGnAGfxjxZGimhzbESHiiJVD
        r1JIkZi0UeNA8g3zvmPRAQq+jm+WGSmxwsZJJbU=
X-Google-Smtp-Source: ABdhPJzUllD8AnO0cA8jHgXz5zFwgVBweERovXOsKEYs05ANFqRHrFNosSZ0r5N3ABX+shKkxSgHDUACeogTTDjBHc4=
X-Received: by 2002:a50:ef10:: with SMTP id m16mr42074952eds.224.1634570576562;
 Mon, 18 Oct 2021 08:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <20211017115843.2a872fbe@jic23-huawei> <CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com>
 <20211018161732.0000565f@Huawei.com>
In-Reply-To: <20211018161732.0000565f@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Oct 2021 18:22:04 +0300
Message-ID: <CAHp75VdoNV5MOixvaFLs9xBkrJH+Rc0dVVWmnZA6nyOMVS6k8Q@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 6:17 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 18 Oct 2021 10:40:33 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 18, 2021 at 6:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Sat, 16 Oct 2021 19:27:50 +0300
> > > Maxim Levitsky <maximlevitsky@gmail.com> wrote:

...

> > I hardly believe that Realtek has issued a special ID from the range

Slight correction: ID --> PCI ID

> > where mostly PCIe ports or so are allocated, although it's possible.
> > We need proof.
> >
> > What I believe is the case here is that OEMs are just quite diletants
> > in ACPI and firmware and they messed up with BIOS somehow that it
> > issued the ID for the device.
> > There are also two other possibilities: OEM stole the ID (deliberately
> > or accidentally), or the device is not just gyro, but something which
> > contains gyro.
> >
> > As to the last paragraph, see above, we must see DSDT. Without it I
> > have a strong NAK.
> >
> > P.S. Jonathan, please do not be so fast next time with ACPI IDs.
>
> No problem.  Will pull this one once I'm back on correct PC.

Thank you!

-- 
With Best Regards,
Andy Shevchenko
