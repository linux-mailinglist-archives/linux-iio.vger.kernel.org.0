Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941C22B5DEE
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 12:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKQLFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 06:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgKQLFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 06:05:20 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9DC0613CF;
        Tue, 17 Nov 2020 03:05:20 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so15873858pgg.12;
        Tue, 17 Nov 2020 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+Gvwy/fVcc4cI9UDXN25/HNa0h/y9qTShVXqIhVxo0=;
        b=qV+UWjXJF2RgbvGcjzWENyf++xA8QpuO/XMyppU73AUcuQTaRn7LHupiz2WlSwgqS5
         thOU9PGbLOHsHapP0vfdkx4PNlkXq+AFNdlJo9eZ2koLfm5lSOms1op3ipjqwK5X+NCg
         BYcs8BQne8GjdgdNub2osFxSb1zASxhiOdtpiSY3XioPXzuHguWYNIZv3aCWUu80paXw
         axUV8/pq83SrDgxj0RgJWR9yEN2Jw1vJQIBy/uiH+67A+7l4cQx6nLmTyjPggsogYWrU
         GlfZjyhpZjXlwByyp1ZWtMSHBGrPZh2y31e1J0cboLuYAkmfIe/DzyunYUN1TldeQlyr
         mxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+Gvwy/fVcc4cI9UDXN25/HNa0h/y9qTShVXqIhVxo0=;
        b=ruSI/OBt0o4VU9B7bw44ZQvVJDBjE5PWztwiD4tLcAKvlNlsjQe7TaAlorhjT7dGAW
         uukih6WSNOLVkqCCmcfNWjysJrSlHUaL04j0LAeXSHQQ58UEeLiSSh59ZOQIMVxGmSzS
         vXHH8u/aK5YSht5xQ2xjZ81CH/LvKEGnyCCNWSp7oPUL2OutduaeBJ5FSd5vEBoaSGqc
         DZ+xDtCXnBX/tnUf9iFILq/bS91OBJ6uDumgwyrqW2QrxD5otViYS2sEplV61SJEAo3L
         cEh89xd9oo75RVgx2HLLqPRCMn7umvvRWoHxnPjaIVWVWp0Uhl8crlXCHE5UsS2Sj8xW
         fo4g==
X-Gm-Message-State: AOAM530t6Y5PSvS0zU6zXP/PUNA8jEK/agOpUdA8QGtx/M/IRTXABOx3
        bUzH8mfsmq1PBervapzoqANK79xI5kDDn0IOz3c=
X-Google-Smtp-Source: ABdhPJw1KuJKVfATx3aB32L9dyWwi9V7zJPKMAFvfbcUAfxYFibBIHBD7SnRy7C7cdP+d9Fsc4xqhkwGIeG6pQ5T4D8=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr954490pfc.7.1605611120281; Tue, 17 Nov
 2020 03:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
 <20201117075254.4861-2-alexandru.ardelean@analog.com> <20201117110111.0000468a@Huawei.com>
In-Reply-To: <20201117110111.0000468a@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Nov 2020 13:05:04 +0200
Message-ID: <CAHp75VcXNGb5Poo8iKBJen52=FhNHUHqYc6Vz0mV7gwcETOHgw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7887: convert driver to full DT probing
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vaishnav M A <vaishnav@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 17, 2020 at 1:01 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 17 Nov 2020 09:52:53 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change removes the SPI device table, adds an OF device table instead.
> > This should also be usable for ACPI via PRP0001.
> >
> > This device is usually probed via device-tree, so it makes more sense to
> > use the OF device table.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> So, we've had a few cases of having to put the device_id table
> back again recently.
> https://lore.kernel.org/linux-iio/20201101152613.2c37581a@archlinux/
>
> They tend to be due to greybus doing it's probing in yet another fashion.
> So far they've been all i2c devices, but I kind of assume it does the same for spi.
> https://elixir.bootlin.com/linux/latest/source/drivers/staging/greybus/spilib.c#L437
>
> How device_get_match_data() plays with that I'm not sure. It probably
> doesn't right now given swnode doesn't have a device_get_match_data() callback.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/base/swnode.c#L539
>
> So after all that I think I've argued myself around to thinking what you have
> here is fine.  If someone wants to support this via a swnode then they can
> figure out how to make that work.
>
> +CC Vaishnav and Andy for their input.

device_get_match_data() doesn't know about bus type specifics. One may
introduce a helper like

const void *spi_device_get_match_data(dev)
{
  const void *match = device_get_match_data(dev);
  if (match)
    return match;
  return spi_dev_id....;
}

And use it with the SPI ID table.

-- 
With Best Regards,
Andy Shevchenko
