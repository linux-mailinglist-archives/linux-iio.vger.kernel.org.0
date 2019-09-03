Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58EDA69F3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICNgV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 09:36:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34655 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICNgV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 09:36:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so16086749ljh.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Sep 2019 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06Xnj1CFYQESYr2DPKIDqoHFKfcQbApxXON8Vk7bdMI=;
        b=yNhC2X8eSsroS543isWD99B7F3tv7xlUf0n/K6uL9vzl9Et3dTtHlO8mZaQ5jej8a+
         Lger+bvdpXTCKLqxJDUQON1kTiZaRQV60F0ZrilEej5zYfrgwowizcFuWL1eLL3CDush
         9uthX7pbfOF87ZroYzs61Svw3bRQr9cBPdSFM3v5swq49FZ2+eiPg4KnYviXEw5Dewwu
         Xv5guOyJSkIaeoqtmPF2qAhdpg3+1a2kkz+9OpFTbwTZurtihiJnB0SpyBwQ45Im9XHC
         9kSkILf/mzIjk5sE8t1R0P8VH9c8B+cXoJBDjpyagpei7WgL5PmcxJWesDQbK+u4VCnY
         x4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06Xnj1CFYQESYr2DPKIDqoHFKfcQbApxXON8Vk7bdMI=;
        b=CVy5D8VYxoQbxypTntYGkHN0u0XhTIO+II09PIFsGA1wv5MYlOXjgEY9Xo/cBZpQE5
         ADx0oLc/v3Cc3S/HJMMd9opIGRZ3t9SVwAY0tgKkCKvbqvcnh64ZZQ6yTifn7EDAkzTr
         hw95Vtt7/b/CsN6uG8BGqHqVPAqYAgSSSofO+pIyBFxBjDZsJOnU6vuYKBNNFCOzFSV7
         HHcL4OOyzpaGtFajldPrSAF0WSwiQEfnBSjtt0+k8aKvqaXELVIA0KzEt0tOHif+uoZ/
         XWsbnAJYAei2bfDDpko06wXopq7Uq04v0Y5cadmlpWCuJxM5nJCUSxH7Xsee3QcITVHf
         9xCw==
X-Gm-Message-State: APjAAAWq/OIkHU9qpp1LccGUVadvBw7xW7mh7bH+sRWuh8NbHUcRfhkL
        ShyELW2sTRbi8rPHy5df9CO/el20Qh7G6Inr8Tj3mg==
X-Google-Smtp-Source: APXvYqx4KWiDixSjuPfzb4hqn6iN0DzFv4m1Z1o8bbYE92ILPvPhli4ujGnjluUfuUfULZDDB2OHECWbhhnFV/C3AaI=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr20161098ljm.108.1567517779625;
 Tue, 03 Sep 2019 06:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190822145233.18222-1-linus.walleij@linaro.org>
 <20190822145233.18222-9-linus.walleij@linaro.org> <20190826095133.0e21c55b@archlinux>
In-Reply-To: <20190826095133.0e21c55b@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Sep 2019 15:36:08 +0200
Message-ID: <CACRpkdaTY-+Z8qnA5QXxd+KyvWHnJOt_shfFe8gYL0tT57r_xg@mail.gmail.com>
Subject: Re: [PATCH 8/8 v2] ARM: dts: ux500: declare GPADC IIO ADC channels
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 26, 2019 at 10:51 AM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 22 Aug 2019 16:52:33 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > This adds the IIO channels for the GPADC after converting it
> > to using the standard IIO ADC bindings and moving the driver
> > over to the IIO subsystem. We also add IIO hwmon standard
> > driver node to support reading channels in a standard manner.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'll ask the 'stupid' question. Doesn't this break compatibility
> with old DTs?

No we just add stuff, if the kernel *want* to, it can implement fallbacks
for old device trees (which I guess is to hardcode all the channels into the
drivers and not use IIO ADC, like we did before in Linux). I do not do that
however, but "some operating system" could very well do it, and that
is the DT design ambition.

> One comment inline to do with IIO standardization that occurred in
> the meantime.
(...)
> > +                                     /* GPADC channels */
> > +                                     bat_ctrl: adc-channel@01 {
> > +                                             reg = <0x01>;
>
> We standardised recently on just channel@01 etc

OK I fix this when applying.

Thanks!
Linus Walleij
