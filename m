Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217C5565D43
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGDSAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGDSAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 14:00:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9203E6150
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 11:00:45 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-317a66d62dfso88382977b3.7
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nPsSa/LAgsx4Z/tWZ+a1i/lR7QodoPPSduMaqCdlfG8=;
        b=X18TVpiStnQFQv0iWZrRIQUDEtwuI9xf0VAdWqRWyTgAMejvQXwnkUt0B7D3I89d3m
         LLZxGyfKskOfjcOQxuqcv0PlivljumJA82PwwvtLCn8nYCg+7J1cyA0SC5URQG/jz0Mn
         rW1TWfJw0ngCS2v2GwyEzr7fbjt3CyRvhJz0QBP2dzDPt+2G2pKnFdyC/LQ48Ss7MrZ2
         ezKjUEs5OYhgClSQ+hfiZThrXIvQqTNSJSD08RSE470/7txrhsb5zB4ktMc0iIAtn4MG
         ei1MSKVpTLIMdhoY+LT8vJn5IaZKIxpU/l1/ZfJhkGYKu5VYRG15ZH4/V2xTxj/o1eJP
         +osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nPsSa/LAgsx4Z/tWZ+a1i/lR7QodoPPSduMaqCdlfG8=;
        b=FyXa/2DTK4D0AdPZs6ZuDCUrslMSjmObYvCs3QWZkoA8eonHV18VcQxEhp9dhKvWZC
         P2mPH/Zjrjut0VWl40RLC6qldGi2A8+8qS2rVPDuXJVDNoBJSPLFNZNidaCa7SpM+jbj
         njvohgucJeoHrH8Rf5JbOTD/KCBNA+Kl42E/oOk181nBLNV0HTLzKYo7N/nPieBL4OG1
         Tn7wfIx4UhbjfenVpnP6Sx+86Hc5tDewyUYEl6klsLXjSeRjc92TMFgZg2Sdn9N4Ire7
         kVboS7e6qXNSisYAjAVntS55c3Z/UmX+xS2rfEdDpdpjyKgf40f8cRjCX21RvGKnOvT2
         PV6Q==
X-Gm-Message-State: AJIora99iRsdY2QidKCNV5lJ6XmWlmw9rvIQfhEr0u54Q67pQOx5PWI7
        UWiPWbzTakuhKC9RXuI6Hj0bQJlHsN8402vbzv7RlWvJjtry4g==
X-Google-Smtp-Source: AGRyM1to/ro/rmAx3EVprlxFYwuwgK/ATBBLg/9cB0ghSP9jSiiFF1x/275fz3aVl/zAIuk1smgMNNDqt45K3tbZqio=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr33405916ywa.277.1656957644638; Mon, 04
 Jul 2022 11:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <ee3d70ac-a9b3-9b91-df92-81fb73c0f93f@gmail.com>
In-Reply-To: <ee3d70ac-a9b3-9b91-df92-81fb73c0f93f@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 20:00:07 +0200
Message-ID: <CAHp75VdGJKsdcY_ntd4-xy0xPb=J195yOyJM7d7vC_mPj+dm0w@mail.gmail.com>
Subject: Re: fast spi driver development
To:     Patricio Moreno <pm.pato@gmail.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 3, 2022 at 3:09 PM Patricio Moreno <pm.pato@gmail.com> wrote:
>
> Hello,
>
> I'm writing a driver for the TI ADS127x family of ADCs. The ads127x is a
> 24 bit samples, 4/8 channels, ADC, which can be clocked, using SPI, with
> up to 25 MHz. For what I've seen, I've followed a common approach within
> the IIO ADC drivers, but I can't get it to work at high frequencies.
>
> I'm using the triggered buffers interface, with a RDY interrupt pin. The
> problem I have is with timings. When the ADC sends the data ready
> signal, my handler is called approximately 7=C2=B5s later. This handler t=
hen
> calls spi_read to get 24 bytes (8 3 bytes samples) and the kernel takes
> a lot of time to read the SPI bus, actually, to *start* reading.
>
> I would really appreciate some guidance on how to deal with this issue.

+Cc: maintainers and AD guys. I remember there was a discussion about
supporting HiFreq ADCs in IIO and AFAIR there are some issues (and you
probably need to use DMA in cyclic mode or so).

...

>                  st->data.samples[i] =3D (b[3 * i] << 16) | (b[3 * i + 1]
> << 8) | (b[3 * i + 2] << 0);

JFYI: get_unaligned_be24() is what you need here.

--=20
With Best Regards,
Andy Shevchenko
