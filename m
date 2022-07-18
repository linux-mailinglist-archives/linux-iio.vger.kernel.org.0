Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD31578BC6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiGRUaf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiGRUae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 16:30:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C42CDD2
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:30:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id j22so23463511ejs.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K1hSSBlOTtPtcSfpCRVcUhp+y+jXopeVWkjrPjQTwQY=;
        b=er6djZJSBpTZVnpQZJsMjLOXyI4r/Co+GZFQ94BZBDRQSio3RLYqz4V6i5pIZ5Uw+0
         UBZ9ust7clgRl1Qmv1v5AtWbLNThR9AKi9oND2pFK7mdSily9VBbAWq7j/dNUrKJmJyF
         Ysc7Kgz8+7nI5wylz/YlDzcceVR67xXn9H5PR8kkxKM/OmaQNclgTkspEsYecW1Jb4hn
         dz7Q/6Byj0mTpObbxxSc/p7+ljx7qntlU0IBW+8p1BxAYDd2/7X9rSK7/rKEM57v9pEL
         +wOU+S8l8hEa/qOhuwtgDxKtZ7kfpEZGWvhSsQcgDcU6nSVuktUcoX1TKtkd1O7MpBQs
         FehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K1hSSBlOTtPtcSfpCRVcUhp+y+jXopeVWkjrPjQTwQY=;
        b=pa4IDffL8mK7G67g2SRHmOIlgPu3agcstVP2V+Y4lT5vqzmL7aKEfQHIf5+L3JMpHr
         6+8wjnT+nos98bBXvIIoJxtdGqYdwmfOZEIByjcm3o3JX421C++z8kbbjM+7nzMpPPkY
         J63oQvRzCOwntjp46zgVPF3LlUDX9JMlWxKJ3JbHPA/7bVPsU6f3/3rNo8tWCyr0bYPT
         pJd9EU/34GD+CHKLq+egkfHgmVgh7S1GzwhVvrTvrDl3Bt9aU7xAG2niU0iAK7ivg5Me
         XsCZ3V/jQkVWnA8CsoC2nScLAr3Nt6RIrjrmGX7xJYkHii9tRyxGRaxcMVsv41ngr3Y3
         qoeQ==
X-Gm-Message-State: AJIora92T7tcea1cKQhPMTDO+HZMKo/6BRALzQnRc6m+1/B2yEAr/3nf
        gKpq9j9pCkTqh6hN/UbApfEXWaA6xsCL3pHw5QU=
X-Google-Smtp-Source: AGRyM1uWhoo83wt8T5EctLaAhRcaiguRX4UjKzmIa5piVtlV4e9T1gxw6TfdTQUMGEtNMsiMBAdcnJZfFd1NkNkZp+o=
X-Received: by 2002:a17:906:9b09:b0:72b:9612:d373 with SMTP id
 eo9-20020a1709069b0900b0072b9612d373mr26262125ejc.606.1658176231653; Mon, 18
 Jul 2022 13:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220718194258.181738-1-ukleinek@debian.org> <20220718194258.181738-3-ukleinek@debian.org>
In-Reply-To: <20220718194258.181738-3-ukleinek@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 22:29:54 +0200
Message-ID: <CAHp75Vd983XT=03HMAdJmaHTR4YK-=XmZnYd+gF0SY90ywR2ug@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: humidity: dht11: Use dev_err_probe consistently
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 18, 2022 at 9:51 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>=
 wrote:
>
> All but one error path use dev_err_probe() to emit a message. Use the sam=
e
> incarnation for the remaining exit point for consistency.

...

> +       if (dht11->irq < 0)
> +               return dev_err_probe(dev, -EINVAL, "GPIO %d has no interr=
upt\n",
> +                                    desc_to_gpio(dht11->gpiod));

Oh, what I missed is the error code shadowing. Can't we propagate the
real error code?
-EINVAL --> dht11->irq

And to be honest I don't like this desc_to_gpio() usage. It's not for
board files, it will bring confusing information to the user. What is
important is the name of GPIO, i.o.w. "connection id".

--=20
With Best Regards,
Andy Shevchenko
