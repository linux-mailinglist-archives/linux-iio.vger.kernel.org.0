Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66F25A979
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBKbu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 06:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBKbt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 06:31:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C33C061244;
        Wed,  2 Sep 2020 03:31:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so2075530plb.12;
        Wed, 02 Sep 2020 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXyoYPlaGWNehGt1iU1AjjtO78K2/p8F/lqdKmDy5Tc=;
        b=NASSHG0qFiIcpXyfhW556HWzsnWY/lm44eCucBfMFz5oslRyq2NhrAywO5t1PGpiLu
         SyWQd45919/qWmQ7hDZhM6tJmniE5gLFql6q0Cf1/5bQHrrQ6nVokv/aN8D7vUCnIJJt
         I7Gbzhq4Vch5+aoUiUOGCdC4zcJCFhuWuxVHOlfAxLPuGg+/Ik3R42eBHlN/xnTlZzTi
         6R53o1WUdlb0p/0+iV1zrmFRP4yrNiMwVE3cbKat1Me9CiJSM+vA8VmAt2L9irl9TfGo
         AAfaiV6JUYdrtL62vnzeZlN4Omx+nEA0HWAmpiY/0IfntHPKrsip35wJfs3odTWfhXfl
         xESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXyoYPlaGWNehGt1iU1AjjtO78K2/p8F/lqdKmDy5Tc=;
        b=F+OUCrBEoE4q9W1T8W/uUUf051RBkHC3YaDJVb7YoO/Ljp8E7cXxuTW/XhywWybSc2
         yYux7uSl3R9DlSd/YXCfhFV4/zWkVAhbq/xxLoq383H66sLlSmwXc8i7o7tqpXyIdCgA
         KPqeE7MxyAcl+PLsrhKyimYj9UpGTPEePaVdf8LSJfYvBimZNV0sEYkhV9VHkUaVB/oK
         HrdUabIywaxHsCm2ugz/9lNo7kS16Oc/n+dkyenU86EK6RnyEirE97Dq9fVzUylvp6Sa
         FXLyEtTSkxVcjhaBkG/X0BgGSIdReyo4hoHwGG1FQvZMEaGRM6qtqdNV+QMpDF3HiZ2N
         gCzA==
X-Gm-Message-State: AOAM5321wtI7Kfe4RyT98bIMrTh0cpsgJerR5Rcm+JApFgNCPQm9XDSp
        IZQxdatLDLNHPKVQ92dYmfLWr6LCPPU=
X-Google-Smtp-Source: ABdhPJwLLN5ku9hCMGjzK9ZtajjPdgrskU/2upsAidBkIrYEIBaojEnyL4KmkG5KyN+vcnHvIdl+fw==
X-Received: by 2002:a17:90b:4d10:: with SMTP id mw16mr1719994pjb.100.1599042705858;
        Wed, 02 Sep 2020 03:31:45 -0700 (PDT)
Received: from ?IPv6:2409:4072:e94:80d0:a526:a3b6:4686:f6fb? ([2409:4072:e94:80d0:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id e12sm4221261pjl.9.2020.09.02.03.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 03:31:44 -0700 (PDT)
Subject: Re: [PATCH 1/3] iio: gyro: adxrs290: Add triggered buffer support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
 <20200825124711.11455-2-nish.malpani25@gmail.com>
 <CAHp75VfHFo41S=Bhs2MB6Te6VAn+yCteys6XcYgciNZu9VppJg@mail.gmail.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <d103b760-5871-de55-af3a-b6b7e5378666@gmail.com>
Date:   Wed, 2 Sep 2020 16:01:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfHFo41S=Bhs2MB6Te6VAn+yCteys6XcYgciNZu9VppJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Thanks for the review, Andy. Comments inline...

On 26/08/20 9:40 pm, Andy Shevchenko wrote:
> On Tue, Aug 25, 2020 at 4:11 PM Nishant Malpani
> <nish.malpani25@gmail.com> wrote:
>>
>> Provide a way for continuous data capture by setting up buffer support. The
>> data ready signal exposed at the SYNC pin of the ADXRS290 is exploited as
>> a hardware interrupt which triggers to fill the buffer.
>>
>> Triggered buffer setup was tested with both hardware trigger (DATA_RDY) and
>> software triggers (sysfs-trig & hrtimer).
> 
> ...
> 
>> +static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
>> +{
>> +       struct adxrs290_state *st = iio_priv(indio_dev);
>> +       int val, ret;
>> +
>> +       mutex_lock(&st->lock);
>> +
>> +       if (st->mode == mode) {
> 
>> +               ret = 0;
> 
> Can be done outside of mutex.
> 
Yep, makes sense.
>> +               goto done;
>> +       }
>> +
> 
>> +       val = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
>> +       if (val < 0) {
>> +               ret = val;
>> +               goto done;
>> +       }
> 
> Consider other way around
>   ret = ...
>   ...
>   val = ret;
> 
I suppose that does make things consistent; will do so in v2.

>> +       switch (mode) {
>> +       case ADXRS290_MODE_STANDBY:
>> +               val &= ~ADXRS290_MEASUREMENT;
>> +               break;
>> +       case ADXRS290_MODE_MEASUREMENT:
>> +               val |= ADXRS290_MEASUREMENT;
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               goto done;
>> +       }
>> +
>> +       ret = adxrs290_spi_write_reg(st->spi,
>> +                                    ADXRS290_REG_POWER_CTL,
>> +                                    val);
>> +       if (ret < 0) {
>> +               dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
>> +               goto done;
>> +       }
>> +
>> +       /* update cached mode */
>> +       st->mode = mode;
>> +
>> +done:
>> +       mutex_unlock(&st->lock);
>> +       return ret;
>> +}
> 
> ...
> 
>> +                               goto err_release;
>>
>> -                       return IIO_VAL_INT;
>> +                       ret = IIO_VAL_INT;
>> +                       break;
>>                  default:
>> -                       return -EINVAL;
>> +                       ret = -EINVAL;
>> +                       break;
>>                  }
> 
>> +err_release:
> 
> I didn't get the purpose of this. Wasn't the break statement enough?
> 
It is indeed; I just thought the labeling was a preferred way to jump to 
error handling paths. Will use just the 'break' in v2.

>> +               iio_device_release_direct_mode(indio_dev);
>> +               return ret;
>>          case IIO_CHAN_INFO_SCALE:
>>                  switch (chan->type) {
>>                  case IIO_ANGL_VEL:
> 
> ...
> 
>> +                       goto err_release;
> 
> Ditto.
> 
Got it.

>> +               }
>> +
>>                  /* caching the updated state of the high-pass filter */
>>                  st->hpf_3db_freq_idx = hpf_idx;
>>                  /* retrieving the current state of the low-pass filter */
>>                  lpf_idx = st->lpf_3db_freq_idx;
>> -               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
>> +               ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
>> +               break;
>> +
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>>          }
>>
>> -       return -EINVAL;
>> +err_release:
>> +       iio_device_release_direct_mode(indio_dev);
>> +       return ret;
>>   }
> 
> ...
> 
>> +       val = (state ? ADXRS290_SYNC(ADXRS290_DATA_RDY_OUT) : 0);
> 
> Purpose of outer parentheses?
> I personally find that more readable but I think I'm violating the 
coding style in the kernel; will remove the parentheses in v2.

> ...
> 
>> +static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> +       struct adxrs290_state *st = iio_priv(indio_dev);
>> +       int ret;
>> +
>> +       if (!st->spi->irq) {
>> +               dev_info(&st->spi->dev, "no irq, using polling\n");
>> +               return 0;
>> +       }
>> +
>> +       st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
>> +                                                "%s-dev%d",
>> +                                                indio_dev->name,
>> +                                                indio_dev->id);
>> +       if (!st->dready_trig)
>> +               return -ENOMEM;
>> +
>> +       st->dready_trig->dev.parent = &st->spi->dev;
>> +       st->dready_trig->ops = &adxrs290_trigger_ops;
>> +       iio_trigger_set_drvdata(st->dready_trig, indio_dev);
>> +
>> +       ret = devm_request_irq(&st->spi->dev, st->spi->irq,
>> +                              &iio_trigger_generic_data_rdy_poll,
>> +                              IRQF_ONESHOT,
>> +                              "adxrs290_irq", st->dready_trig);
>> +       if (ret < 0) {
> 
>> +               dev_err(&st->spi->dev, "request irq %d failed\n", st->spi->irq);
>> +               return ret;
> 
> return dev_err_probe(...);
> 
Nice, wasn't aware of this. Thanks. Will use 'dev_err_probe()' in v2 
wherever pointed.

With regards,
Nishant Malpani

>> +       }
>> +
>> +       ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
>> +       if (ret) {
> 
>> +               dev_err(&st->spi->dev, "iio trigger register failed\n");
>> +               return ret;
> 
> return dev_err_probe(...);
> 
>> +       }
>> +
>> +       indio_dev->trig = iio_trigger_get(st->dready_trig);
>> +
>> +       return 0;
>> +}
> 
> ...
> 
>> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>> +                                             &iio_pollfunc_store_time,
>> +                                             &adxrs290_trigger_handler, NULL);
>> +       if (ret < 0) {
> 
>> +               dev_err(&spi->dev, "iio triggered buffer setup failed\n");
>> +               return ret;
> 
> return dev_err_probe(...);
> 
>> +       }
> 
