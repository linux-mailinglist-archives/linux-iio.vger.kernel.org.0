Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF25D0224
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiIUR5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUR5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 13:57:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F06CD0F
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 10:57:29 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d8so5665331iof.11
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lWz9vmTktmlnF8P5ct/IitkPDKwxx7s+v31tQx0NTfE=;
        b=hPwgMa4Vzn+dr/R9yowxrWVRYm8GRaOYX2QoyN8KqjKAruRAR8nNeUXwTE8lnoP0Ri
         UDKRiMuYU5L6x/cudqgLDdfD0EH/YL4CBP0B+PQHMz1Rbhy633LVkXBMEBO+nks+xWeP
         WzDL/YlaWVONcpKPFD5/SY7FFqH99eKHZw8X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lWz9vmTktmlnF8P5ct/IitkPDKwxx7s+v31tQx0NTfE=;
        b=ecTviMfXwgv/qB5K2XoHJANpgQi5kPSNghnsMqez8Ldi7ulxGRopys0N3aXT5LjMz4
         1rMcfhFuHjkg2Xx6nUVAak4RXadHR/zMRHCd1cZCX0Bk2ulo6qYJH/icx2lELymDyg1U
         apR+x5VCzZafl7JpkKwAfC8oW8xZHU8BaVVrEinHbehFhOYtUYX9MUL9MXqBQafdYvye
         PKYukhZSrhXOjQLIH1sCWuNzRjuDnh4NJdPifkm87238KEHeSgfjTlklFM0FbWDmAsDM
         C9fcXOjwNuSVWMcj5YrPN7pKIW31oL3N+sosmDiy5nxddw2LSpLuPwXac+EwXX+nSx0I
         affw==
X-Gm-Message-State: ACrzQf1IKRsyXX1Fxpo/ugw0R5OQiQxkIBMzAR6APWjtIF1NyxaFxxMH
        mydo0B9XElS5+95u6NXeyXz1olSI6FRsfnJDEK1Qkw==
X-Google-Smtp-Source: AMsMyM57bNVpIjGiIB5AzUj9jqWSl+gKbWzjqH3/K8KuyS1WQHhDHUSCV967QoGMG6sBH4ZRz7Psmf7S6Nv8biJzb6I=
X-Received: by 2002:a05:6638:3818:b0:35a:8cf5:e007 with SMTP id
 i24-20020a056638381800b0035a8cf5e007mr12843820jav.227.1663783049239; Wed, 21
 Sep 2022 10:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220921063026.89619-1-matt.ranostay@konsulko.com>
 <20220921063026.89619-5-matt.ranostay@konsulko.com> <20220921080458.3uue5ooc3svcbmxp@mail.corp.redhat.com>
In-Reply-To: <20220921080458.3uue5ooc3svcbmxp@mail.corp.redhat.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 21 Sep 2022 10:57:18 -0700
Message-ID: <CAJCx=gn0bZp3fToF+LZE+evR2m4nWMueusjysxcrvimH0wRhaA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] HID: mcp2221: switch i2c registration to devm functions
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     gupt21@gmail.com, jic23@kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 21, 2022 at 1:05 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> [foreword: please keep Jiri and myself (the HID maintainers) CC-ed to
> the series, as you will need ack from us and we don't necessarily monitor
> every single message on linux-input]
>
> On Sep 20 2022, Matt Ranostay wrote:
> > Switch from i2c_add_adapter() to resource managed devm_i2c_add_adapter()
> > for matching rest of driver initialization, and more concise code.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/hid/hid-mcp2221.c | 45 +++++++++++++++++----------------------
> >  1 file changed, 19 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> > index de52e9f7bb8c..7ba63bcd66de 100644
> > --- a/drivers/hid/hid-mcp2221.c
> > +++ b/drivers/hid/hid-mcp2221.c
> > @@ -824,6 +824,14 @@ static int mcp2221_raw_event(struct hid_device *hdev,
> >       return 1;
> >  }
> >
> > +static void mcp2221_hid_remove(void *ptr)
> > +{
> > +     struct hid_device *hdev = ptr;
> > +
> > +     hid_hw_close(hdev);
> > +     hid_hw_stop(hdev);
>
> By default, if you remove the .remove() callback, hid_hw_stop() will get
> automatically called by hid-core.c. So we are now calling it twice,
> which, in a way is not a big deal but it might be an issue in the long
> run.
>
> Generally speaking, in the HID subsystem, that situation doesn't happen
> a lot because hid_hw_start() is usually the last command of probe, and
> we don't need to open the device in the driver itself.
>
> Here, I guess as soon as you add the i2c adapter, you might want to have
> the communication channels ready, and thus you need to have it open
> *before* i2c_add_adapter.
>
> I would suggest the following if you want to keep the devm release of
> stop and close: please put a big fat warning before mcp2221_hid_remove()
> explaining that this is called in devm management, *and* add a function
> that would just return 0 as the .remove() callback with another big fat
> warning explaining that we don't want hid-core.c to call hid_hw_stop()
> because we are doing it ourself through devres.
>

Yeah maybe best to keep the non-devres if it isn't going to affect how the last
change in this series is trying to implement with iio.

I'll wait for Jonathan to chime in on this thread.

> Last, in the HID subsystem, we often interleave non devres with devres
> for resource allocation, given that .remove() will be called before any
> devres release. But that is assuming this ordering is OK, which doesn't
> seem to be the case here. We first need to unregister the i2c adapter
> and then close/stop the HID device.

Noted.

-  Matt

>
> > +}
> > +
> >  static int mcp2221_probe(struct hid_device *hdev,
> >                                       const struct hid_device_id *id)
> >  {
> > @@ -849,7 +857,8 @@ static int mcp2221_probe(struct hid_device *hdev,
> >       ret = hid_hw_open(hdev);
> >       if (ret) {
> >               hid_err(hdev, "can't open device\n");
> > -             goto err_hstop;
> > +             hid_hw_stop(hdev);
> > +             return ret;
> >       }
> >
> >       mutex_init(&mcp->lock);
> > @@ -857,6 +866,10 @@ static int mcp2221_probe(struct hid_device *hdev,
> >       hid_set_drvdata(hdev, mcp);
> >       mcp->hdev = hdev;
> >
> > +     ret = devm_add_action_or_reset(&hdev->dev, mcp2221_hid_remove, hdev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Set I2C bus clock diviser */
> >       if (i2c_clk_freq > 400)
> >               i2c_clk_freq = 400;
> > @@ -873,19 +886,17 @@ static int mcp2221_probe(struct hid_device *hdev,
> >                       "MCP2221 usb-i2c bridge on hidraw%d",
> >                       ((struct hidraw *)hdev->hidraw)->minor);
> >
> > -     ret = i2c_add_adapter(&mcp->adapter);
> > +     ret = devm_i2c_add_adapter(&hdev->dev, &mcp->adapter);
> >       if (ret) {
> >               hid_err(hdev, "can't add usb-i2c adapter: %d\n", ret);
> > -             goto err_i2c;
> > +             return ret;
> >       }
> >       i2c_set_adapdata(&mcp->adapter, mcp);
> >
> >       /* Setup GPIO chip */
> >       mcp->gc = devm_kzalloc(&hdev->dev, sizeof(*mcp->gc), GFP_KERNEL);
> > -     if (!mcp->gc) {
> > -             ret = -ENOMEM;
> > -             goto err_gc;
> > -     }
> > +     if (!mcp->gc)
> > +             return -ENOMEM;
> >
> >       mcp->gc->label = "mcp2221_gpio";
> >       mcp->gc->direction_input = mcp_gpio_direction_input;
> > @@ -900,26 +911,9 @@ static int mcp2221_probe(struct hid_device *hdev,
> >
> >       ret = devm_gpiochip_add_data(&hdev->dev, mcp->gc, mcp);
> >       if (ret)
> > -             goto err_gc;
> > +             return ret;
> >
> >       return 0;
> > -
> > -err_gc:
> > -     i2c_del_adapter(&mcp->adapter);
> > -err_i2c:
> > -     hid_hw_close(mcp->hdev);
> > -err_hstop:
> > -     hid_hw_stop(mcp->hdev);
> > -     return ret;
> > -}
> > -
> > -static void mcp2221_remove(struct hid_device *hdev)
> > -{
> > -     struct mcp2221 *mcp = hid_get_drvdata(hdev);
> > -
> > -     i2c_del_adapter(&mcp->adapter);
> > -     hid_hw_close(mcp->hdev);
> > -     hid_hw_stop(mcp->hdev);
> >  }
> >
> >  static const struct hid_device_id mcp2221_devices[] = {
> > @@ -932,7 +926,6 @@ static struct hid_driver mcp2221_driver = {
> >       .name           = "mcp2221",
> >       .id_table       = mcp2221_devices,
> >       .probe          = mcp2221_probe,
> > -     .remove         = mcp2221_remove,
> >       .raw_event      = mcp2221_raw_event,
> >  };
> >
> > --
> > 2.37.2
> >
>
> Cheers,
> Benjamin
>
