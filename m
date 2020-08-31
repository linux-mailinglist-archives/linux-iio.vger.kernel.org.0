Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A822579A6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHaMsB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaMsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 08:48:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40BC061573;
        Mon, 31 Aug 2020 05:48:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c142so511952pfb.7;
        Mon, 31 Aug 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lnF3FH7UL4wF4BRElMAjQs3z46mN3BrzdHf7XHwbb0=;
        b=lxiiZNEZBN77i9jF612V/wsNkgtzXI8os/Z1/spgkCv9GhgyPOseJ0o2v5kCRovjcH
         rhHjD839ICtZfkLe1vmV7E05EQFctJMrEaaM4cedBDoPzXyQuDUj9lb5Sj6cP+Km5wP7
         CoTUha8o34TJ1nohOcf3JmBTC4QDKF3WXsZQwvceo6hUDEVgD48e494+AFLL5t9EwvjT
         a4dTnljGfvVR1xsiMGKBOaAovhbSN64u3bitgSbbUZpSyvvPRBoHgnNAf+2kKGk43FoG
         WIs0rbPK+vjgWYj1ZJlRoRmlFsjqJOS17dxXwR6mDqMcsoAEEGyA98P7EEHl9/TtnmcY
         cz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lnF3FH7UL4wF4BRElMAjQs3z46mN3BrzdHf7XHwbb0=;
        b=FMZAo+u+ZPlb5+gfN+XtYP1Vtr+rbrqX3HKa1ft2ejBG2PK0SCtQY65yYrIVNfzHbx
         3NZu8sUPs4+jLgUw+YR/mGjCOYpjyDiPtFSXQMSAE4vdWB0NBhk9HIPHEMsriA2kf1DG
         9tHE9YK6iGiHOMoULgcXInYekmRnmr3q5r27drvfUyiBl/tvFEOETyZmRtZ+VMMjMgdv
         U0pRtCHAM2ZwEkCXkWTMccR9PWXYCy04mIi8mgn1+edcLZ8+6v3J0UYnL/jbaVoCz6dK
         z8KqvBugM0JqAuvBm//eSne6ob6a4yzZWdDhPSHGSC3laF3YbziTraq+1mJRsN599qb1
         0CHA==
X-Gm-Message-State: AOAM530dynHIfO8eRfzYJoNFr+APqAPeMz94LPdkltkrnEHL6rl8JCey
        cgbBd520TM2clhIC+UOO71vr/2dkO141azofbAk=
X-Google-Smtp-Source: ABdhPJwvVB5+jWXAed+BHoow7XAbXyW5d5F3Rdv0+tf7W8gSK4IjVHvuVk4tJsXWMOB1wLPVf0qjpnxyQv8QF6jydOk=
X-Received: by 2002:a63:d648:: with SMTP id d8mr30153pgj.4.1598878079489; Mon,
 31 Aug 2020 05:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com> <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
In-Reply-To: <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Aug 2020 15:47:42 +0300
Message-ID: <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     AceLan Kao <acelan.kao@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 31, 2020 at 3:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao <acelan.kao@canonical.com> wrote:
> > This patch is mainly for Advantech's UNO-420[1] which is a x86-based platform.
> > This platform is more like a development platform for customers to
> > customize their products,
> > so, specify the channel modes in ACPI table is not generic enough,
> > that's why William submit this patch.
> >
> > Are there other ways to specify or pass values to the module without
> > using module parameters?
> > It's good if we can leverage sysfs, but I don't know if there is one
> > for this scenario.
>
> Can we provide DT bindings for that and use then in ACPI? ACPI has a
> possibility to reuse DT properties and compatible strings [1]. As far
> as I can see the driver uses fwnode API, so it supports ACPI case
> already [2]. So, what prevents you to utilize 'adi,mode' property?
>
> Also, we accept examples of ASL excerpt in meta-acpi project [3]. It
> has already plenty of examples [4] how to use PRP0001 for DIY /
> development boards.
>
> So, take all together I think this patch is simple redundant.

One more useful link is SO answers on the topic:
https://stackoverflow.com/search?tab=newest&q=prp0001

> [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html#device-tree-namespace-link-device-id
> [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> [3]: https://github.com/westeri/meta-acpi
> [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-tables/samples
>
> P.S. Jonathan, it seems this driver has artificial ACPI HID. We
> probably have to remove it. However, ADS is indeed reserved for Analog
> Devices in PNP registry. Can we have AD's official answer on this?
> Cc'ing additional AD people.
>
> > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c

-- 
With Best Regards,
Andy Shevchenko
