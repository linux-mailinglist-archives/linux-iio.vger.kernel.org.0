Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB024DBF56
	for <lists+linux-iio@lfdr.de>; Thu, 17 Mar 2022 07:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiCQGWb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Mar 2022 02:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiCQGWW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2022 02:22:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36945ECC40
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 23:14:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e6so1910148pgn.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Mar 2022 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQkmael1dK8NhSggE9PJyITyaAthnHMdPCxyIh0lhYM=;
        b=FtyMSB59Rxdc1Ejf+DRBDaafWpIpTV9M1lTFr96A+7PDZZEx9b4j9MsC6FAA4mQsuf
         BEZQ/lHNMPd5mQldjQYYqb+vv03tvs5/NGLtcC+PQsVr55AtF018PpjU5FjvN8vjrE7p
         BB5LhY+Jjf4AOrL/+WBo0MEWWpJN0kuF4/MiFNZglP16n/INx6fuonupbuK1PhiK+MtH
         abXfxOSXRTELYzQeZC4+pMiNPqoW+/BcjKLy4iBA5ykRh90DLfVCHLUxPo2311MEjRlJ
         aLH0o+fAZKO4mzbFYJkR9xDEqN7sWOwKBWWEmZ1flZbAyQLNGVnZyNyf+AvN3VjRE2aP
         fhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQkmael1dK8NhSggE9PJyITyaAthnHMdPCxyIh0lhYM=;
        b=pxphDsNhpNSYjSfseSdly/o5EFOz5dSvqEpk1w1JrX8GX8JhTurVW5txWco6klf5eO
         eKsIULvo5Czu9qdkgBBDJbSXwmxfsm98g2iwybpxM5uwRuDQi55IcoTlF9q6ipMam2lp
         jUWWdIvhnc6+PBOpzBsuEM9M2g3uKDFfGPFGswsl18bBVMj2l24HYJeeXRYIUHmxrqK/
         gNCyba6cfW8fjKPoeCeFMsWsJOGD/1eKko43p8q1jTAFshvwWZUUGBezArelmDcpqaP5
         r1kOY9ZS53zs1AjOhJlXXqlUhkUYZWU6TraoD6GwmnyO/7s3ba5spxdbOvu+7lq2wQZf
         ISJQ==
X-Gm-Message-State: AOAM5325e/xDl0sx13ownxvOkwGH84Icx/X/RcWC84KypdpbhoXmWqAY
        g9VZaWRFdIWqOhwoLGufBEjqw+7pDRV96d/cHVmsLzgYltE=
X-Google-Smtp-Source: ABdhPJxhBTD8PRYi7bJjZLiA4zNeqYRbFc6d7fHRLWz6ywLefslHFPZanIBGOu1n7Fbs2Vq7fWMmf0m8npFWP/vPznE=
X-Received: by 2002:a63:6c01:0:b0:37c:73a0:a175 with SMTP id
 h1-20020a636c01000000b0037c73a0a175mr2383425pgc.415.1647497642618; Wed, 16
 Mar 2022 23:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <cfc53292-35cf-28bb-3764-65a681eaedd9@deathstar2.nl>
In-Reply-To: <cfc53292-35cf-28bb-3764-65a681eaedd9@deathstar2.nl>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 17 Mar 2022 08:13:50 +0200
Message-ID: <CA+U=DsoOhra_KTT4ZcF_V66mEjwM7mdOBCHUPA95OZNA2YR8Yg@mail.gmail.com>
Subject: Re: multiple dma engines/ ring buffers
To:     Henk Medenblik <yoda@deathstar2.nl>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 16, 2022 at 10:47 PM Henk Medenblik <yoda@deathstar2.nl> wrote:
>
> Hi,
>

Hey

> I am struggling with the concept of using two different DMA engines and
> therefore two ring buffer definitions in a single driver.
> My purpose is to have two different data paths which I want to select in
> my iio device driver. One of them has the purpose to stream plain ADC 16
> bit data to my backend while the second selection would be a hardware
> FFT core output (complex 32 bit). So which one I stream to the backend
> should be selectable.
>
> Because both paths originate from different parts in my HW design I
> implemented two different DMA engines and therefore I have two different
> dma names. However, how to deal with that in my single driver? Has
> anyone done that?

This used to be doable only by registering 2 IIO devices, one for each
data path.
One example is in drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
Around line 2273, you will see:

        for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
                if (!hw->iio_devs[i])
                        continue;

                err = devm_iio_device_register(hw->dev, hw->iio_devs[i]);
                if (err)
                        return err;
        }

The idea there, is that the driver seems to be a wrapper for multiple
IIO devices.
I believe this was done because some channels have different sample-rates.
But in userspace, you end up having to manage multiple IIO devices,
which go to the same driver.
This isn't necessarily too bad; it depends on who you ask.
So, the idea there is: 1 IIO device,each with 1 IIO DMA buffer.
ADI has also been using this for RF transceivers (one on TX path and
1-2 on RX paths).

A newer method now (and this isn't used much yet), is to register more
than one IIO buffer per IIO device.
So, taking as an example the drivers/iio/adc/adi-axi-adc.c driver.
If you look at  adi_axi_adc_config_dma_buffer() .

The idea there, would be that if you call
devm_iio_dmaengine_buffer_setup() more than once (with different DMA
names), is that you would end up with more than 1 buffer.
There aren't many examples in userspace on how to access the buffers.
There is one in in the kernel in tools/iio/iio_generic_buffer.c .
Basically, you need to do an "ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &buf_fd);".
If you initialize buf_fd to 0, it will give an FD for the first
buffer, and buf_fd = 1 will give an FD to the second buffer.

After getting an FD to the IIO buffer, working with that FD is
business as usual (read / write).

libiio doesn't yet have support for this multi-buffer mechanism; some
more work is required for that.

In any case, what's not clear to me, is whether you want to expose
both datapaths to userpsace, or somehow mux them in the driver.
Either way, the above details should be some good starting hints
(given that I am not aware of the entire context).

Thanks
Alex

>
> Regards
>
> Henk
>
