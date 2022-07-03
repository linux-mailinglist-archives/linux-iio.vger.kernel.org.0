Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3211564756
	for <lists+linux-iio@lfdr.de>; Sun,  3 Jul 2022 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiGCNFB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiGCNFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 09:05:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B156267
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 06:05:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w193so9826604oie.5
        for <linux-iio@vger.kernel.org>; Sun, 03 Jul 2022 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=Uf5UhlFJ0nTnnXuqLWDOnKulOYvDaPwB6BOp3TLTdkc=;
        b=Dwwi9VidExTLFl4cLC3vj8vxIMs8SffVy7jpvkev7lcCiO9LkxLtX+ZcZNU5VtdKxv
         0eH419Y7hJQlz54c3msUPJru/S0E4hQngnZ2xVBote+c2+x/Eag9vVTfyBF3363IVQH6
         +B01YmrMW/FMhaFyblhnKeiKULFjFl6O+1HsWdaDgSyR8GoRsvKiJufLLJlGHSv2RXvW
         U9CVDLVcY48T8Dobp69JvozaLTWRmPra1Eoesms2tsw721UyGmSFmWWRP8scMXIuMFhN
         dPpHfTrUCeYypNiTzgTycIWDnvV5xzt3Rfrw7VnsoIIp1ar4a/Qq3xnrz45B+AAcgWDD
         CN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=Uf5UhlFJ0nTnnXuqLWDOnKulOYvDaPwB6BOp3TLTdkc=;
        b=fD+Uplvs42wSBiwKvX3Y54tBkZPRfYK8b4N0b2GX8s2YI5wL59qZqrXDfp5DmEaIv1
         /Xj6mppDw/RTF5soPDogn8a9uXzAo2inCBnxri2BBe5GLIlVloRLk24t47OVgH2YPo3u
         e8488ZL6z/sr9GM5bZtBo/CFR1uUeEUjnOs7EVCECBe1VI5axEwApGVvojQ+k7bYQT+U
         9KkZfpdZkHha5Xgw66W8H1yZVuNgYB+Ol3O6gIabIWs7uZAuVLuNixcTcV3H/Jajsm3M
         sWUteQOyJwyLomDaMeitrrjiMgr+FBT43YrwSIJvqJLQ1q44L1RJb1eWQ39UXpzO0SuX
         bHgQ==
X-Gm-Message-State: AJIora8L1lcsMN4euMlZo3/i/HYjcDuvrQKIBNRaqHIej/Qdf188JPDm
        XmR4aTgSUWPttLl70S7IjwDYtHBgZ25wWw==
X-Google-Smtp-Source: AGRyM1saoYUvqn2fc+/IASSrUNhTy9O76dFvgZwIVxwy2NNF27bel3BBUqckFhuFZnO/OxOYGI/jDw==
X-Received: by 2002:a05:6808:dc2:b0:335:60d9:14a6 with SMTP id g2-20020a0568080dc200b0033560d914a6mr14654203oic.280.1656853499323;
        Sun, 03 Jul 2022 06:04:59 -0700 (PDT)
Received: from [192.168.0.240] ([181.169.111.86])
        by smtp.gmail.com with ESMTPSA id cm8-20020a056870b60800b00101d05c2245sm17407540oab.37.2022.07.03.06.04.58
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:04:58 -0700 (PDT)
Message-ID: <ee3d70ac-a9b3-9b91-df92-81fb73c0f93f@gmail.com>
Date:   Sun, 3 Jul 2022 10:05:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
From:   Patricio Moreno <pm.pato@gmail.com>
To:     linux-iio@vger.kernel.org
Subject: fast spi driver development
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I'm writing a driver for the TI ADS127x family of ADCs. The ads127x is a 
24 bit samples, 4/8 channels, ADC, which can be clocked, using SPI, with 
up to 25 MHz. For what I've seen, I've followed a common approach within 
the IIO ADC drivers, but I can't get it to work at high frequencies.

I'm using the triggered buffers interface, with a RDY interrupt pin. The 
problem I have is with timings. When the ADC sends the data ready 
signal, my handler is called approximately 7µs later. This handler then 
calls spi_read to get 24 bytes (8 3 bytes samples) and the kernel takes 
a lot of time to read the SPI bus, actually, to *start* reading.

I would really appreciate some guidance on how to deal with this issue.
I can gladly send the code if someone wish to comment on it, I'm 
planning to free it once it's working anyway.

Below I've copied part of the code, which I think could be useful now.
The first function is passed to devm_request_irq, and the second one to 
iio_triggered_buffer_setup.


irqreturn_t ti_ads1x7x_interrupt(int irq, void *dev_id)
{
         struct iio_dev *indio_dev = dev_id;
         struct ti_ads1x7x_state *st = iio_priv(indio_dev);

         if (iio_buffer_enabled(indio_dev)) {
                 iio_trigger_poll(st->trig);
         } else {
                 complete(&st->completion);
         }

         return IRQ_HANDLED;
};


irqreturn_t ti_ads127x_trigger_handler(int irq, void *p)
{
         struct iio_poll_func *pf = p;
         struct iio_dev *indio_dev = pf->indio_dev;
         struct ti_ads1x7x_state *st = iio_priv(indio_dev);
         int ret;
         int i;
         u8 b[24];

         ret = spi_read(st->spi, b, sizeof b);
         for_each_set_bit(i,
                          indio_dev->active_scan_mask,
                          indio_dev->masklength) {
                 st->data.samples[i] = (b[3 * i] << 16) | (b[3 * i + 1] 
<< 8) | (b[3 * i + 2] << 0);
                 if (ret)
                         goto ads127x_error_notify_done;
         }

         iio_push_to_buffers_with_timestamp(indio_dev,
                                            &st->data,
                                            pf->timestamp);

ads127x_error_notify_done:
         iio_trigger_notify_done(indio_dev->trig);
         return IRQ_HANDLED;
}

Thank you!
