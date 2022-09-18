Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246955BBFBA
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIRUMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIRUMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 16:12:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D613D54
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 13:12:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h194so19631091iof.4
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uwwi92DRkzziP5G3a3vC0eP80gJHoxLlFlUaVUv3Y4A=;
        b=eX9zpejPmg2yUIo2EeXY0P9k6yVrB7s2K2a5UUyr8LNbD/keMKOt2iZYGBioC7jgHo
         ZYeuOPwAuQsJ+TOEysRZTCyPS8QSYC6tWvM/btm5mfpLptYex7qhPLvh/ue9w551oTjA
         w0vYQDfXoaEaYn50kA7bGFjmgj3Bgk9x6Xe6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uwwi92DRkzziP5G3a3vC0eP80gJHoxLlFlUaVUv3Y4A=;
        b=Nm404Y/E/MS6+N4zsu5NotxAai5FUVoxnBvgFGNNw5ntgta+eN6sSM2l+touslpkMa
         22pt8ZhBytlXqMqbE0afNw+02F+O0ivZWBfhkl3zbeIVgmj8v1Nn4/+oQ5A5uuHwRL+M
         QR3sdFwGAhcHEEPbnI/AeGXREoidLK46NC+s/Avi/jKzw41HcmncNnn3hZhVQdFcDGKW
         SslLHyvfYPqeA1LYgx9hQOVOgt0y+ZDdGNSeM5EkUEO17Ej5UkmKSOFq9ALN0o2IEW/p
         DhkA52xjWIpGwhViLde9zOI//FrkAw2plferc6GxoeMI22oKYog7ukO62O5G271eXRbi
         zQ3Q==
X-Gm-Message-State: ACrzQf1qT47/r1yRWSFY4QYB+fl/bcd2bMI0QGYjhldjqmrNvfR7ctB4
        RvtL8VvZx1YV6v8iubpnKsLXfUaCyXhbNmp2S5pgYw==
X-Google-Smtp-Source: AMsMyM6x44E44imJOG600gCWyQhF+SRbbBEL1BFLiw5eUyFTdnVkdknogBUWXMEMPKnEu0PG5hjx5gD/G/vjIWK8It8=
X-Received: by 2002:a5d:9ac1:0:b0:6a3:1938:e6b0 with SMTP id
 x1-20020a5d9ac1000000b006a31938e6b0mr1114144ion.186.1663531940006; Sun, 18
 Sep 2022 13:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220912173202.16723-1-matt.ranostay@konsulko.com>
 <20220912173202.16723-6-matt.ranostay@konsulko.com> <20220918164920.5bc2bc87@jic23-huawei>
In-Reply-To: <20220918164920.5bc2bc87@jic23-huawei>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 18 Sep 2022 13:12:08 -0700
Message-ID: <CAJCx=g=JPRTm-Qjy233BfOfzFiSVonM5GbS2BrRrzp8aNZA4MQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     gupt21@gmail.com, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 18, 2022 at 8:49 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 12 Sep 2022 10:32:02 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Add support for 3x 10-bit ADC and 1x DAC channels registered via the iio
> > subsystem.
> >
> > To prevent breakage and unexpected dependencies this support only is
> > only built if CONFIG_IIO is enabled, and is only weakly referenced by
> > 'imply IIO' within the respective Kconfig.
> >
> > Additionally the iio device only gets registered if at least one channel
> > is enabled in the power-on configuration read from SRAM.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>
> Hi Matt,
>
> Can we not provide a _scale?
> Whilst not technically required in all IIO Drivers, a bare _raw interface
> is rarely that much use and here the ADC and DAC clearly have very different
> scales.

I will check into that. The sampling voltage range is configurable
though and will need
to see

>
> Otherwise, as seen below, I'd like a comment on why the registration
> is kicked off in a delayed work item. Right now that looks like a hack
> to ensure something else has happened first.  That's fine, but there
> doesn't seem to be rescheduling if whatever that 'thing' is hasn't happened yet.
> To use this sort of delayed trick, I'd definitely expect a backoff again
> to be implemented...

Ok a retry here maybe would make sense to be sure the SRAM
configuration is read.
This hack is just because we have to be sure the MCP2221 is up and
running before
attempting to read the SRAM via a USB message, and is less ugly/wrong to pop a
msleep in a probe function.

Also in this case we can back down the half second delay since that is
the worst case.

- Matt

>
> > ---
> >  drivers/hid/Kconfig       |   1 +
> >  drivers/hid/hid-mcp2221.c | 187 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 188 insertions(+)
>
>
> ...
>
> >  static int mcp2221_probe(struct hid_device *hdev,
> >                                       const struct hid_device_id *id)
> >  {
> > @@ -902,6 +1084,11 @@ static int mcp2221_probe(struct hid_device *hdev,
> >       if (ret)
> >               goto err_i2c;
> >
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +     INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
> > +     schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(500));
>
> Good to have a comment here to say why you are kicking the registration of the
> IIO device onto a delayed work path.
>
> > +#endif
> > +
> >       return 0;
> >
> >  err_i2c:
>
