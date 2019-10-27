Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DFE61D1
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfJ0J0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 05:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJ0J0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 05:26:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DD420679;
        Sun, 27 Oct 2019 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572168379;
        bh=Y58ozI0M8tS8McZvd1NKw2OArhiULN5FrkAjEUsss1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QzkIbSgMltyD3VIZoK5YzRHgM5l3ijuj53ofAP7cI6AjHcMGVVVHjzYaumyMUYC2d
         59M28j6aKTpSv2i0dX0Y4nGp3eAl24CWmZ3Q/ux+n67AMZXjyN68sZ1J9sd7u3zgk3
         4IMNwxadH5gFLjL7EKx3o2N4Q37hQzxv3UvAzV30=
Date:   Sun, 27 Oct 2019 09:26:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     rishi gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: light: add driver for veml6030 ambient
 light sensor
Message-ID: <20191027092613.795b1c7c@archlinux>
In-Reply-To: <CALUj-guR0XBGLCx2WnTSGiaVPpKbPcSKNVhbb+N8VfS449_NJg@mail.gmail.com>
References: <1571664496-6392-1-git-send-email-gupt21@gmail.com>
        <1571716635-22830-1-git-send-email-gupt21@gmail.com>
        <20191022110000.28b7d2c5@archlinux>
        <CALUj-guR0XBGLCx2WnTSGiaVPpKbPcSKNVhbb+N8VfS449_NJg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Oct 2019 18:02:51 +0530
rishi gupta <gupt21@gmail.com> wrote:

> Thanks Jonathan, sorry for deep thread, learnt will keep in mind.
> 
> All suggested changes done except re-ordering devm_add_action_or_reset.
> Please see inline and suggest if I missed something.
> 
...
> > > +static int veml6030_probe(struct i2c_client *client,
> > > +                       const struct i2c_device_id *id)
> > > +{
> > > +     int ret;
> > > +     struct veml6030_data *data;
> > > +     struct iio_dev *indio_dev;
> > > +     struct regmap *regmap;
> > > +
> > > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > > +             dev_err(&client->dev, "i2c adapter doesn't support plain i2c\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > > +     regmap = devm_regmap_init_i2c(client, &veml6030_regmap_config);
> > > +     if (IS_ERR(regmap)) {
> > > +             dev_err(&client->dev, "can't setup regmap\n");
> > > +             return PTR_ERR(regmap);
> > > +     }
> > > +
> > > +     indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     data = iio_priv(indio_dev);
> > > +     i2c_set_clientdata(client, indio_dev);
> > > +     data->client = client;
> > > +     data->regmap = regmap;
> > > +
> > > +     indio_dev->dev.parent = &client->dev;
> > > +     indio_dev->name = "veml6030";
> > > +     indio_dev->channels = veml6030_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +     if (client->irq) {
> > > +             ret = devm_request_threaded_irq(&client->dev, client->irq,
> > > +                                             NULL, veml6030_event_handler,
> > > +                                             IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > +                                             "veml6030", indio_dev);
> > > +             if (ret < 0) {
> > > +                     dev_err(&client->dev,
> > > +                                     "irq %d request failed\n", client->irq);
> > > +                     return ret;
> > > +             }
> > > +             indio_dev->info = &veml6030_info;
> > > +     } else {
> > > +             indio_dev->info = &veml6030_info_no_irq;
> > > +     }
> > > +
> > > +     ret = devm_add_action_or_reset(&client->dev,
> > > +                                     veml6030_als_shut_down_action, data);  
> >
> > What is this reversing?  It should be immediately after whatever that is, thus
> > ensuring we only undo whatever we need to on failure and the ordering is correct
> > for remove.  I am guessing it should be after hw_init.
> >  
> This just disables active measurements (this is the only thing we need
> to do when failure happens).
> 
> Suppose hw initialisation succeeds but call to
> devm_add_action_or_reset() fails. In this case sensor will be left
> turned on as veml6030_als_shut_down_action() will never be executed.
> Therefore I kept it before veml6030_hw_init().
> Does this sounds correct to you ?

Nope, that's the point of the _or_reset part of that call. Note that we used
to manually handle the result of devm_add_action, but this little wrapper
does that for us.

In all failure cases it will run the callback provided to it.
https://elixir.bootlin.com/linux/v4.8/source/include/linux/device.h#L688

So it should always be called 'after' the thing it is setting up the
unwinding function for.

Jonathan

> 
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     ret = veml6030_hw_init(indio_dev);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     return devm_iio_device_register(&client->dev, indio_dev);
> > > +}
