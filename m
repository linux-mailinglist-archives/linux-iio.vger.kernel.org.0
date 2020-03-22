Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8AF18E812
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVKpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 06:45:52 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35940 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVKpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 06:45:52 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so4655785pjb.1;
        Sun, 22 Mar 2020 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTXhdL097mlQS8O83uIhN8J/RXoDYEHu/eJEovfEf50=;
        b=j16kbwfvZ6b/h7plszo+4PDUT4dltIeuOjYOotcspckdlvCKYMRoq1dccXM6071Jn1
         x/6WumK330hnk0A8BZFLu7gGS7Q9xq/LfLfTZwiCdC0LbfM8nauaFt7+0iHihlpQtQAS
         FFSoTL0CwhPVXOaPMT8CQsy0mnFm8dJ8Xo4L+zOIdIKC3DDVyUBsCO6UP73PWfuzBIhb
         9i1j4GFTp5mCCTxqz+pVPjB1nnKODUY0a8yDPEL+aNfUZzFIhcak9n8ky6AOHXN4y7eS
         qx5fuqqcluyKB9I7ncy0u24MXXMjklb6aLDdpQdyfGv0C2GVlvlPZsza8fH0Ey5Orw79
         FKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTXhdL097mlQS8O83uIhN8J/RXoDYEHu/eJEovfEf50=;
        b=Fco+LUH6OA/v1yGml9pa66cI0L0IKm5kLj5EMMzekG53sq6JBstahZcWS8pALaMY6b
         SkODBaYQ++pJlU6LtwU9nwLL9y8E0L2RXGVHAOymID0RiQ5mkAIzxdBHu0cZupMm8h8d
         KNNBmPZqDC2mQCbazXdvfyZt3q5aVNarKiLJo+3kBGx8v2Z5tEF7cxkbOQwxb+wjZtJq
         VlMMTzj0wfXazI7gLEqUu+INHCEBhQDfhyURRNMOudfgBHmop9anDs6MH0Te8zqZkSdQ
         uzki6nQXmxUxCXM5tWlhUc3/tFIkvggFSOb1ebRMWsx0DApWrw9/vbC6ZDbtZAt0MKsP
         yGBQ==
X-Gm-Message-State: ANhLgQ0PRiflCOAEoM5+BvmRa6OQSkD2p6MD9mJVaFE0GczZwqDmMsEb
        VG3QTiF0sTn3+dP+KaVmEfUp9KG7Hscg+ntWtSs=
X-Google-Smtp-Source: ADFU+vu/NzJaf+DFmVD2TpaRkf1INuqzH/WyAn2qxOgwW62B7hPcNFfvFj0veIfxEP6emXobsGKYMCdAzXzT7wU9yW8=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr16624130plf.255.1584873951235;
 Sun, 22 Mar 2020 03:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
 <20200321085315.11030-6-alexandru.ardelean@analog.com> <CAHp75VecnornqckmG_WgN-V9A1VSQfRT85TxFzwHgaLw9dAHeA@mail.gmail.com>
 <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
In-Reply-To: <979ef870a4f0935e41e95e7759847eba8bd0407c.camel@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 12:45:39 +0200
Message-ID: <CAHp75Vdna2+txY=w87n+SWE3x3FYJLeMjYbYa6V-co3z0mYx_g@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] iio: adc: adi-axi-adc: add support for AXI ADC IP core
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc Kees (see below about allocation size checks)

On Sun, Mar 22, 2020 at 11:36 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
> On Sat, 2020-03-21 at 23:38 +0200, Andy Shevchenko wrote:
> > On Sat, Mar 21, 2020 at 10:55 AM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:

...

> > > Link: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> >
>
> i can send a v12 for this in a few days;
>
> > Is it tag or simple link? I would suggest not to use Link: if it's not a tag.
>
> simple link
> any suggestions/alternatives?
> i wasn't aware of conventions about this;

Use like [1] ...
...

[1]: https://...

Or maybe introduce is as a tag DocLink:, for example?
Or Datasheet: ?

...

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

In both cases it's pointer arithmetic, right? Even look at the example
of netdev you gave below, they haven't done these (redundant) checks.
The outcome that crashes if any will be more distinct.

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

Good point.

> > > +}

...

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

It seems it lacks of this kind of allocation size checks... Perhaps add one?
Kees, what do you think?

> > > +       cl = kzalloc(alloc_size, GFP_KERNEL);
> > > +       if (!cl)
> > > +               return ERR_PTR(-ENOMEM);

...

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

I think it makes code dirty (too much protective programming). We have
a lot places where we can shoot our feet, but at least not hiding the
issue is a benefit in my opinion.

...



> > > +static struct attribute *adi_axi_adc_attributes[] = {
> > > +       ADI_AXI_ATTR(SCALE_AVAIL, in_voltage_scale_available),
> > > +       NULL,
> >
> > Terminators good w/o comma.
>
> i don't feel strongly pro/against
> sure

There is a rationale behind this. If there is a weird case of adding
entry behind the terminator, you will see it immediately at compile
time (consider automatic rebase).

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

Ditto.

> > > +};

...

> > > +       if (!dev->of_node) {
> > > +               dev_err(dev, "DT node is null\n");
> > > +               return ERR_PTR(-ENODEV);
> > > +       }

I guess this check is redundant since following OF calls will fail anyway.

> > > +
> > > +       id = of_match_node(adi_axi_adc_of_match, dev->of_node);
> >
> > You may use this from struct driver and move the table after this function.
>
>
> right; it didn't occur to me, since i was already using
> of_device_get_match_data() in ad9467

Even better. But see above note.

> > > +       if (!id)
> > > +               return ERR_PTR(-ENODEV);

-- 
With Best Regards,
Andy Shevchenko
