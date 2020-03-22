Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E915218E996
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCVPUk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCVPUk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:20:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B1520724;
        Sun, 22 Mar 2020 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584890439;
        bh=yn8D5eI3HGMn3u2AltrMrKFgz8JKNLqK+ddrDMifGLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E6FnCahXBBHLeBVGjntp+BdW8VUJ571OUZAB1h2nAZlhfOrNcHzZWo/gr6zeakC6P
         pkoU5IlHUdxTq8pZWQSaZex4APgnjyjK3ZqCAcI8RLHhBkaQDIvJ12lQED9yNyHCy4
         wHbFj2Iff6BjxEFXcUVzQjOR3Uaw6xaZJgYyEF0M=
Date:   Sun, 22 Mar 2020 15:20:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Message-ID: <20200322152033.0351547c@archlinux>
In-Reply-To: <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-6-alexandru.ardelean@analog.com>
        <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
        <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 09:35:57 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2020-03-21 at 23:38 +0200, Andy Shevchenko wrote:
> > [External]
> > 
> > On Sat, Mar 21, 2020 at 10:55 AM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:  
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > 
> > > This change adds support for the Analog Devices Generic AXI ADC IP core.
> > > The IP core is used for interfacing with analog-to-digital (ADC) converters
> > > that require either a high-speed serial interface (JESD204B/C) or a source
> > > synchronous parallel interface (LVDS/CMOS).
> > > 
> > > Usually, some other interface type (i.e SPI) is used as a control interface
> > > for the actual ADC, while the IP core (controlled via this driver), will
> > > interface to the data-lines of the ADC and handle  the streaming of data
> > > into memory via DMA.
> > > 
> > > Because of this, the AXI ADC driver needs the other SPI-ADC driver to
> > > register with it. The SPI-ADC needs to be register via the SPI framework,
> > > while the AXI ADC registers as a platform driver. The two cannot be ordered
> > > in a hierarchy as both drivers have their own registers, and trying to
> > > organize this [in a hierarchy becomes] problematic when trying to map
> > > memory/registers.
> > > 
> > > There are some modes where the AXI ADC can operate as standalone ADC, but
> > > those will be implemented at a later point in time.
> > > 
> > > Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip  
> >   
> 
> i can send a v12 for this in a few days;
I'll drop v11 of the series then.

Jonathan


> 
> > Is it tag or simple link? I would suggest not to use Link: if it's not a tag.  
> 
> simple link
> any suggestions/alternatives?
> i wasn't aware of conventions about this;
> 
> > 
> > ...
> >   
> > > +static struct adi_axi_adc_client *conv_to_client(struct adi_axi_adc_conv
> > > *conv)
> > > +{
> > > +       if (!conv)
> > > +               return NULL;  
> > 
> > This is so unusual. Why do you need it?  
> 
> see [1]
> 
> >   
> > > +       return container_of(conv, struct adi_axi_adc_client, conv);
> > > +}
> > > +
> > > +void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
> > > +{
> > > +       struct adi_axi_adc_client *cl = conv_to_client(conv);
> > > +
> > > +       if (!cl)
> > > +               return NULL;  
> > 
> > So about this.  
> 
> [1]
> because 'adi_axi_adc_conv_priv()' (and implicitly conv_to_client()) gets called
> from other drivers; we can't expect to be sure that conv & cl aren't NULL;
> 
> >   
> > > +
> > > +       return (char *)cl + ALIGN(sizeof(struct adi_axi_adc_client),
> > > IIO_ALIGN);  
> > 
> > This all looks a bit confusing. Is it invention of offsetof() ?  
> 
> umm; tbh, it's more of a copy/clone of iio_priv() 
> 
> it's not un-common though;
> see [and this one has more exposure]:
> --------------------------------------------------------
> static inline void *netdev_priv(const struct net_device *dev)
> {       
>         return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> }
> --------------------------------------------------------
> 
> 
> >   
> > > +}  
> > 
> > ...
> >   
> > > +static struct adi_axi_adc_conv *adi_axi_adc_conv_register(struct device
> > > *dev,
> > > +                                                         int sizeof_priv)
> > > +{
> > > +       struct adi_axi_adc_client *cl;
> > > +       size_t alloc_size;
> > > +
> > > +       alloc_size = sizeof(struct adi_axi_adc_client);
> > > +       if (sizeof_priv) {
> > > +               alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> > > +               alloc_size += sizeof_priv;
> > > +       }
> > > +       alloc_size += IIO_ALIGN - 1;  
> > 
> > Have you looked at linux/overflow.h?  
> 
> i did now;
> any hints where i should look closer?
> 
> >   
> > > +       cl = kzalloc(alloc_size, GFP_KERNEL);
> > > +       if (!cl)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       mutex_lock(&registered_clients_lock);
> > > +
> > > +       get_device(dev);
> > > +       cl->dev = dev;  
> > 
> > cl->dev = get_device(dev);  
> 
> sure
> 
> >   
> > > +       list_add_tail(&cl->entry, &registered_clients);
> > > +
> > > +       mutex_unlock(&registered_clients_lock);
> > > +
> > > +       return &cl->conv;
> > > +}
> > > +
> > > +static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
> > > +{
> > > +       struct adi_axi_adc_client *cl = conv_to_client(conv);
> > > +
> > > +       if (!cl)
> > > +               return;  
> > 
> > When is this possible?  
> 
> good point; it isn't;
> it's a left-over from when adi_axi_adc_conv_unregister() was exported
> still, i wouldn't mind leaving it [for paranoia], if there isn't a strong
> opinion to remove it;
> 
> >   
> > > +
> > > +       mutex_lock(&registered_clients_lock);
> > > +
> > > +       list_del(&cl->entry);
> > > +       put_device(cl->dev);
> > > +
> > > +       mutex_unlock(&registered_clients_lock);
> > > +
> > > +       kfree(cl);
> > > +}  
> > 
> > ...
> >   
> > > +static ssize_t in_voltage_scale_available_show(struct device *dev,
> > > +                                              struct device_attribute
> > > *attr,
> > > +                                              char *buf)
> > > +{
> > > +       for (i = 0; i < conv->chip_info->num_scales; i++) {
> > > +               const unsigned int *s = conv->chip_info->scale_table[i];
> > > +
> > > +               len += scnprintf(buf + len, PAGE_SIZE - len,
> > > +                                "%u.%06u ", s[0], s[1]);
> > > +       }
> > > +       buf[len - 1] = '\n';  
> > 
> > Is num_scales guaranteed to be great than 0 whe we call this?  
> 
> yes
> see axi_adc_attr_is_visible()
> 
> >   
> > > +
> > > +       return len;
> > > +}  
> > 
> > ...
> >   
> > > +static struct attribute *adi_axi_adc_attributes[] = {
> > > +       ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),
> > > +       NULL,  
> > 
> > Terminators good w/o comma.  
> 
> i don't feel strongly pro/against
> sure
> 
> >   
> > > +};  
> > 
> > ...
> >   
> > > +/* Match table for of_platform binding */
> > > +static const struct of_device_id adi_axi_adc_of_match[] = {
> > > +       { .compatible = "adi,axi-adc-10.0.a", .data =
> > > &adi_axi_adc_10_0_a_info },
> > > +       { /* end of list */ },  
> > 
> > Ditto.
> >   
> > > +};  
> > 
> > ...
> >   
> > > +struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
> > > +{
> > > +       const struct of_device_id *id;
> > > +       struct adi_axi_adc_client *cl;
> > > +       struct device_node *cln;
> > > +
> > > +       if (!dev->of_node) {
> > > +               dev_err(dev, "DT node is null\n");
> > > +               return ERR_PTR(-ENODEV);
> > > +       }
> > > +
> > > +       id = of_match_node(adi_axi_adc_of_match, dev->of_node);  
> > 
> > You may use this from struct driver and move the table after this function.  
> 
> 
> right; it didn't occur to me, since i was already using
> of_device_get_match_data() in ad9467
> 
> >   
> > > +       if (!id)
> > > +               return ERR_PTR(-ENODEV);
> > > +
> > > +       cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
> > > +       if (!cln) {
> > > +               dev_err(dev, "No 'adi,adc-dev' node defined\n");
> > > +               return ERR_PTR(-ENODEV);
> > > +       }
> > > +
> > > +       mutex_lock(&registered_clients_lock);
> > > +
> > > +       list_for_each_entry(cl, &registered_clients, entry) {
> > > +               if (!cl->dev)
> > > +                       continue;
> > > +               if (cl->dev->of_node == cln) {  
> > 
> > So, why not to be consistent with above, i.e.
> >   if (of_node != cln)
> >     continue;  
> 
> sure
> 
> > ?
> >   
> > > +                       if (!try_module_get(dev->driver->owner)) {
> > > +                               mutex_unlock(&registered_clients_lock);
> > > +                               return ERR_PTR(-ENODEV);
> > > +                       }
> > > +                       get_device(dev);
> > > +                       cl->info = id->data;
> > > +                       mutex_unlock(&registered_clients_lock);
> > > +                       return cl;
> > > +               }
> > > +       }
> > > +
> > > +       mutex_unlock(&registered_clients_lock);
> > > +
> > > +       return ERR_PTR(-EPROBE_DEFER);
> > > +}  
> > 
> >   

