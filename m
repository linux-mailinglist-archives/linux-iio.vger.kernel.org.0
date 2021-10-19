Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3A43418F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSWrK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJSWrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 18:47:10 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C8C06161C
        for <linux-iio@vger.kernel.org>; Tue, 19 Oct 2021 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vwQEiZupVHzjmkcqTqKaN9zmsflv1I6BA2tOaHJ/DXY=; b=DEjuYICmyH4IRv6zqV1lwRO4nk
        Ednyyo5OYjavztqr5u0zr83EPyN5nfsjuF50KvYMS7h+WIrAA78YajPyRkVN4EhrjpbWoxaUgn8tD
        1SpUh9OYHnDIUgS0Atsu13ByvF8lOwuAOdyHcp02rHf6CWTu7Ce6a6qXJiWMzgb0DNNvHBU/45scQ
        rzTOLbBN0q/xuAD36B9+7AkWmExMqXkj6+Uym0OUj+N8hWgyWxZI38yRwZaH23p2AkjfmvERFws4L
        RF6LzAnsWbvuqlN/uIzRv9qC7Xt2Laj3tgRHe5QbDNqsxvgor28hXkWbxBxDVTZLQvtaxLZ2jIcdn
        carnzWFA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56469 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mcxqn-00084f-Ld; Wed, 20 Oct 2021 00:44:53 +0200
Subject: Re: [PATCH] iio: dln2-adc: Fix lockdep complaint
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        Jack Andersen <jackoalan@gmail.com>
References: <20211018113731.25723-1-noralf@tronnes.org>
 <CAHp75VdAxnMHkEmLbTKidvAaZWSXQFqGmJ034MW_k3wquCiJWw@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <37ed2d67-0296-c126-1255-03e649d62080@tronnes.org>
Date:   Wed, 20 Oct 2021 00:44:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdAxnMHkEmLbTKidvAaZWSXQFqGmJ034MW_k3wquCiJWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Den 20.10.2021 00.07, skrev Andy Shevchenko:
> 
> 
> On Monday, October 18, 2021, Noralf Trønnes <noralf@tronnes.org
> <mailto:noralf@tronnes.org>> wrote:
> 
>     When reading the voltage:
> 
>     $ cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw
> 
>     Lockdep complains:
> 
>     [  153.910616] ======================================================
>     [  153.916918] WARNING: possible circular locking dependency detected
>     [  153.923221] 5.14.0+ #5 Not tainted
>     [  153.926692] ------------------------------------------------------
>     [  153.932992] cat/717 is trying to acquire lock:
>     [  153.937525] c2585358 (&indio_dev->mlock){+.+.}-{3:3}, at:
>     iio_device_claim_direct_mode+0x28/0x44
>     [  153.946541]
>                    but task is already holding lock:
>     [  153.952487] c2585860 (&dln2->mutex){+.+.}-{3:3}, at:
>     dln2_adc_read_raw+0x94/0x2bc [dln2_adc]
>     [  153.961152]
>                    which lock already depends on the new lock.
> 
>     Fix this by not calling into the iio core underneath the dln2->mutex
>     lock.
> 
> 
> Side question: have you noticed any race condition when you connect and
> disconnect DLN2 module many times in a row? (okay, I have a board where
> uB and type A connectors are for the same DR port, and it has a switch
> for ID pin, that user may toggle, when I do this, sometimes race happens
> and usb doesn’t really switches the role and dln2 drivers crashes with
> rcu splat)
>  

No I haven't seen that, but I haven't got an actual DLN2 adapter if that
matters, I've implemented the protocol on a Raspberry Pi Pico:
https://github.com/notro/pico-usb-io-board

Noralf.

> 
>     Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")
>     Cc: Jack Andersen <jackoalan@gmail.com <mailto:jackoalan@gmail.com>>
>     Signed-off-by: Noralf Trønnes <noralf@tronnes.org
>     <mailto:noralf@tronnes.org>>
>     ---
> 
>     Note that this patch is needed for the driver to be usable:
> 
>     mfd: dln2: Add cell for initializing DLN2 ADC
>     https://lore.kernel.org/lkml/20211018112541.25466-1-noralf@tronnes.org/T/#u
>     <https://lore.kernel.org/lkml/20211018112541.25466-1-noralf@tronnes.org/T/#u>
> 
> 
>      drivers/iio/adc/dln2-adc.c | 15 +++++++--------
>      1 file changed, 7 insertions(+), 8 deletions(-)
> 
>     diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
>     index 16407664182c..6c67192946aa 100644
>     --- a/drivers/iio/adc/dln2-adc.c
>     +++ b/drivers/iio/adc/dln2-adc.c
>     @@ -248,7 +248,6 @@ static int dln2_adc_set_chan_period(struct
>     dln2_adc *dln2,
>      static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
>      {
>             int ret, i;
>     -       struct iio_dev *indio_dev = platform_get_drvdata(dln2->pdev);
>             u16 conflict;
>             __le16 value;
>             int olen = sizeof(value);
>     @@ -257,13 +256,9 @@ static int dln2_adc_read(struct dln2_adc *dln2,
>     unsigned int channel)
>                     .chan = channel,
>             };
> 
>     -       ret = iio_device_claim_direct_mode(indio_dev);
>     -       if (ret < 0)
>     -               return ret;
>     -
>             ret = dln2_adc_set_chan_enabled(dln2, channel, true);
>             if (ret < 0)
>     -               goto release_direct;
>     +               return ret;
> 
>             ret = dln2_adc_set_port_enabled(dln2, true, &conflict);
>             if (ret < 0) {
>     @@ -300,8 +295,6 @@ static int dln2_adc_read(struct dln2_adc *dln2,
>     unsigned int channel)
>             dln2_adc_set_port_enabled(dln2, false, NULL);
>      disable_chan:
>             dln2_adc_set_chan_enabled(dln2, channel, false);
>     -release_direct:
>     -       iio_device_release_direct_mode(indio_dev);
> 
>             return ret;
>      }
>     @@ -337,10 +330,16 @@ static int dln2_adc_read_raw(struct iio_dev
>     *indio_dev,
> 
>             switch (mask) {
>             case IIO_CHAN_INFO_RAW:
>     +               ret = iio_device_claim_direct_mode(indio_dev);
>     +               if (ret < 0)
>     +                       return ret;
>     +
>                     mutex_lock(&dln2->mutex);
>                     ret = dln2_adc_read(dln2, chan->channel);
>                     mutex_unlock(&dln2->mutex);
> 
>     +               iio_device_release_direct_mode(indio_dev);
>     +
>                     if (ret < 0)
>                             return ret;
>      
>     -- 
>     2.33.0
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
