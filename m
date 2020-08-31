Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6627625799E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgHaMqC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 08:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaMqA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 08:46:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F6C061573;
        Mon, 31 Aug 2020 05:45:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so3082616pjb.3;
        Mon, 31 Aug 2020 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pa6JcLul+a6lE0D1xdaF9TYM4EfgCjAor7g5z7fUwhk=;
        b=B8RMICeUUT2UI+437Vp/yRQTeZCUVfXHdJOIZIuWk0sy8oxdgge4Ozr3ka8okAg74m
         hr1G0wYveXi0hQlsQB+qz9N0Suj1KdKavvHUDnMpud/P0SW2Z6aXcXhdnPCSX4TN5b6p
         aM/MfBCJ1LvhVPYJzjmeL5nddpOdiuwDvKmS33zODu8eFo7CNUPLTfD9WJFla7tEjbwr
         dkbA8ngHAFKIEPd3pGaWK0DAo3d6r3HfdmDuC4PFKzoFmwIyAgmZ6KvsL/rfyULCSdFl
         bXvO0gLiQuhnW6IR43V/UTh4P6mYRkIGR+8kmNRMmhgwg/wVqOU1q2sfhsn4rjO7Jrsv
         fJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pa6JcLul+a6lE0D1xdaF9TYM4EfgCjAor7g5z7fUwhk=;
        b=bSwU/oHze+itdWnKXHmVeKZSEDBmeYEOU65LWKjbufV8IDn7si6fhvc0b35kTxqfK8
         EJDzIAEw9EUqFU8NlmVbYv5Go9Lnoi+RNgv0ocBIhIhRmq1vj8w3OV8dfJQ0CBx+AaOA
         47z/nyk+vHMOaq2tAQN963jNBeHbi2EP2nj8ti7aM68mMQvQLSy7dt+K8iVldKkRNrMp
         UO6dKpphY9DB5lL9JSan2oSWL3HgWFoO+6+43JcQ2xv9NqsfmJFDGtXziD3hVWxyjOeO
         +ZkdJA2F7VIjshe5C83a++xYnxwlEH1pWO4FXlKAtPC9SPiy4nLRfl5jhQEaHR8VUXLG
         lKNg==
X-Gm-Message-State: AOAM532VQu4RJdsldhye7Eb3jxHzMaj5+E7IcU5Wb/3+2fEQBUUTpdIm
        YxeijUCDgf0D7gaAiLhuJpw3rholHffj4S7RJj4=
X-Google-Smtp-Source: ABdhPJywKdmDfUuf9QY9ZvDBz7C0v4U1PQVaeuyyFA0xhSBtfgBnIYIFptTzhuSUt68hsPxDIkvTrWz1D9H4SkNQ1wE=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr1261475pjd.129.1598877959382;
 Mon, 31 Aug 2020 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com> <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
In-Reply-To: <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Aug 2020 15:45:42 +0300
Message-ID: <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
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

On Mon, Aug 31, 2020 at 2:28 PM AceLan Kao <acelan.kao@canonical.com> wrote:
> This patch is mainly for Advantech's UNO-420[1] which is a x86-based platform.
> This platform is more like a development platform for customers to
> customize their products,
> so, specify the channel modes in ACPI table is not generic enough,
> that's why William submit this patch.
>
> Are there other ways to specify or pass values to the module without
> using module parameters?
> It's good if we can leverage sysfs, but I don't know if there is one
> for this scenario.

Can we provide DT bindings for that and use then in ACPI? ACPI has a
possibility to reuse DT properties and compatible strings [1]. As far
as I can see the driver uses fwnode API, so it supports ACPI case
already [2]. So, what prevents you to utilize 'adi,mode' property?

Also, we accept examples of ASL excerpt in meta-acpi project [3]. It
has already plenty of examples [4] how to use PRP0001 for DIY /
development boards.

So, take all together I think this patch is simple redundant.

[1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi/enumeration.html#device-tree-namespace-link-device-id
[2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
[3]: https://github.com/westeri/meta-acpi
[4]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-tables/samples

P.S. Jonathan, it seems this driver has artificial ACPI HID. We
probably have to remove it. However, ADS is indeed reserved for Analog
Devices in PNP registry. Can we have AD's official answer on this?
Cc'ing additional AD people.

> 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c


-- 
With Best Regards,
Andy Shevchenko
