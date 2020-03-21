Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214A618E4CC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCUVib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:38:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgCUVib (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:38:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so4992011pgb.10;
        Sat, 21 Mar 2020 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP9gNftn68k8KEneAEHnnLL7x9DjCTXbgaWXzgB7NRQ=;
        b=iPY62OdHGcl69irjQuhZQHzsdC4lMzG350mqdgfg9RWGEYhkMjfR/y3jaPEKngDO0q
         b1F7qssvyS9kIDre9wGnNMa+oHkRYOa5WY8ixwyc3/u2MFxXkw/7p2YWxSQAIpZq5YkX
         Pt8AJqkzsXtCYhiD6obz1FPGuffN+nnK3ydgRPKQD8gWSBD5ACg6ZlFljlHkkHKhG1ME
         6XFLQcb0FmoPkKBsVw5B5bT6zdZV1t3AXG96+oGyATQX8HPtO/XgMSHAUXxE1sIq9YEU
         XWvtdaHC0lM0rnXU2E81xOOLolh8liPdld174zylhbSpjox6qXmDa1I9kS6f5IAUMLf0
         3Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP9gNftn68k8KEneAEHnnLL7x9DjCTXbgaWXzgB7NRQ=;
        b=CJSfjS5J2LC57z+sniRkZYK88PgelgECoxyzNLzUDx+xtZuOr9POiQgm5iHGVgaJlX
         GQhBESvzNyfP0NR1pCJp/fLLdhpoYXmrqGicy8LFWqatsOsg4NCyXYVnLYRlotCo6PZk
         GW0TchmF/qqQeaM9G0jQ6DVrUGUtRH9YxvAwudjArQbmHvC7v7Mp4IGjW3RkguayWvf5
         sHRkpqFkVZMqOodFTJK+kBx2gcM/Is38x0xe46voWgXIIYbZz6yLb63SKGA0lknOTJRG
         ApP8VbFGB4jtr8WYLu67dcV/ds2jndUizdiYHgJg513dv27QKIaBA+HXrCzFPya++SQp
         1Ccw==
X-Gm-Message-State: ANhLgQ0iWhQ+31idVUfm5NUOLXEfHrTDIXgsqgth3H5eYtBPvFiFL0V3
        jQOCZLjt40mI2QO/oM2CtjRATnfpMDmumAEI7DI=
X-Google-Smtp-Source: ADFU+vv4zfV/kxLZ50ZKTXo4M31wJ24sgQXWLfKYTgQz01VtaltMNNO5Yy/ZfhjRgwNmLqPs0j+Arzb19m4V/Z0NovE=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr16367872pfj.130.1584826710374;
 Sat, 21 Mar 2020 14:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200321085315.11030-1-alexandru.ardelean@analog.com> <20200321085315.11030-6-alexandru.ardelean@analog.com>
In-Reply-To: <20200321085315.11030-6-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Mar 2020 23:38:18 +0200
Message-ID: <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP core
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Laszlo.Nagy@analog.com,
        Andrei.Grozav@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Istvan.Csomortani@analog.com, Adrian.Costina@analog.com,
        Dragos.Bogdan@analog.com, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 10:55 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> This change adds support for the Analog Devices Generic AXI ADC IP core.
> The IP core is used for interfacing with analog-to-digital (ADC) converters
> that require either a high-speed serial interface (JESD204B/C) or a source
> synchronous parallel interface (LVDS/CMOS).
>
> Usually, some other interface type (i.e SPI) is used as a control interface
> for the actual ADC, while the IP core (controlled via this driver), will
> interface to the data-lines of the ADC and handle  the streaming of data
> into memory via DMA.
>
> Because of this, the AXI ADC driver needs the other SPI-ADC driver to
> register with it. The SPI-ADC needs to be register via the SPI framework,
> while the AXI ADC registers as a platform driver. The two cannot be ordered
> in a hierarchy as both drivers have their own registers, and trying to
> organize this [in a hierarchy becomes] problematic when trying to map
> memory/registers.
>
> There are some modes where the AXI ADC can operate as standalone ADC, but
> those will be implemented at a later point in time.
>

> Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip

Is it tag or simple link? I would suggest not to use Link: if it's not a tag.

...

> +static struct adi_axi_adc_client *conv_to_client(struct adi_axi_adc_conv *conv)
> +{

> +       if (!conv)
> +               return NULL;

This is so unusual. Why do you need it?

> +       return container_of(conv, struct adi_axi_adc_client, conv);
> +}

> +
> +void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
> +{
> +       struct adi_axi_adc_client *cl = conv_to_client(conv);
> +

> +       if (!cl)
> +               return NULL;

So about this.

> +
> +       return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client), IIO_ALIGN);

This all looks a bit confusing. Is it invention of offsetof() ?

> +}

...

> +static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device *dev,
> +                                                         int sizeof_priv)
> +{
> +       struct adi_axi_adc_client *cl;
> +       size_t alloc_size;
> +
> +       alloc_size = sizeof(struct adi_axi_adc_client);
> +       if (sizeof_priv) {
> +               alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> +               alloc_size += sizeof_priv;
> +       }
> +       alloc_size += IIO_ALIGN - 1;

Have you looked at linux/overflow.h?

> +       cl = kzalloc(alloc_size, GFP_KERNEL);
> +       if (!cl)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_lock(&registered_clients_lock);
> +

> +       get_device(dev);
> +       cl->dev = dev;

cl->dev = get_device(dev);

> +       list_add_tail(&cl->entry, &registered_clients);
> +
> +       mutex_unlock(&registered_clients_lock);
> +
> +       return &cl->conv;
> +}
> +
> +static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
> +{
> +       struct adi_axi_adc_client *cl = conv_to_client(conv);
> +

> +       if (!cl)
> +               return;

When is this possible?

> +
> +       mutex_lock(&registered_clients_lock);
> +
> +       list_del(&cl->entry);
> +       put_device(cl->dev);
> +
> +       mutex_unlock(&registered_clients_lock);
> +
> +       kfree(cl);
> +}

...

> +static ssize_t in_voltage_scale_available_show(struct device *dev,
> +                                              struct device_attribute *attr,
> +                                              char *buf)
> +{

> +       for (i = 0; i < conv->chip_info->num_scales; i++) {
> +               const unsigned int *s = conv->chip_info->scale_table[i];
> +
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
> +                                "%u.%06u ", s[0], s[1]);
> +       }

> +       buf[len - 1] = '\n';

Is num_scales guaranteed to be great than 0 whe we call this?

> +
> +       return len;
> +}

...

> +static struct attribute *adi_axi_adc_attributes[] = {
> +       ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),

> +       NULL,

Terminators good w/o comma.

> +};

...

> +/* Match table for of_platform binding */
> +static const struct of_device_id adi_axi_adc_of_match[] = {
> +       { .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },

> +       { /* end of list */ },

Ditto.

> +};

...

> +struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
> +{
> +       const struct of_device_id *id;
> +       struct adi_axi_adc_client *cl;
> +       struct device_node *cln;
> +
> +       if (!dev->of_node) {
> +               dev_err(dev, "DT node is null\n");
> +               return ERR_PTR(-ENODEV);
> +       }
> +

> +       id = of_match_node(adi_axi_adc_of_match, dev->of_node);

You may use this from struct driver and move the table after this function.

> +       if (!id)
> +               return ERR_PTR(-ENODEV);
> +
> +       cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
> +       if (!cln) {
> +               dev_err(dev, "No 'adi,adc-dev' node defined\n");
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       mutex_lock(&registered_clients_lock);
> +
> +       list_for_each_entry(cl, &registered_clients, entry) {
> +               if (!cl->dev)
> +                       continue;

> +               if (cl->dev->of_node == cln) {

So, why not to be consistent with above, i.e.
  if (of_node != cln)
    continue;
?

> +                       if (!try_module_get(dev->driver->owner)) {
> +                               mutex_unlock(&registered_clients_lock);
> +                               return ERR_PTR(-ENODEV);
> +                       }
> +                       get_device(dev);
> +                       cl->info = id->data;
> +                       mutex_unlock(&registered_clients_lock);
> +                       return cl;
> +               }
> +       }
> +
> +       mutex_unlock(&registered_clients_lock);
> +
> +       return ERR_PTR(-EPROBE_DEFER);
> +}


-- 
With Best Regards,
Andy Shevchenko
