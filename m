Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4B553441
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiFUOOF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347175AbiFUOOE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 10:14:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568B201A8
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 07:14:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ej4so15618176edb.7
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrdadyNM+rH/nASJkQ6xk+HmCF3gH88WSS6oJfVNH+M=;
        b=Cyr7RAe2IcU1tHbVf0sNdPnL/v62hppsqakmzeSfT/FcZTYf3eojmzB38xypbU/rmQ
         F4OMegNGQrlyewByQarlAhoNK2do6NyVlWIzdvQgTTlLXg1TwMjSxlRDSe0NB1QuJ/kk
         8J5q3uxy4nHqiOLpw2QPI3Mr8SbiQuCscuVcbA6dc/oYJb7WPrb1WrWtADEhIN8HpvxC
         oImNEaE2cPlhTTcV/QR117v33a5lXkRPAlxBHxZKAq+riVqIZ6528tBMLUTDagfEwswu
         BOivpWzMFAzyBHs+zVTAHaqF112u4p8IBnofFgwCo3Cql5JY1IfZGTyPweSzjeZfp+sQ
         pKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrdadyNM+rH/nASJkQ6xk+HmCF3gH88WSS6oJfVNH+M=;
        b=RpTgDAjDXHrUtkFgBaL5SaNmr+qwBHeBgeiDt2janykZ1XrqGMr+VljrDepunpSjgF
         dbQf2OEgDvwvIIkifhdSOnDBMCxUuPRqwzvUiMxR0kB8MWJWhkXahQGUgr/VG0GuRHJ+
         ABTJMQE+HPFbaGZOrBlxwbtpH1K+uAUlt+OgTneZksdWk5j3aS4nVEzGemRkN65jSrNd
         NZMufOHasoA88fGFOeKa+8Em6qOLWqCgukl4xzRuTm2nVXb736DX99kTItkM7SduqONJ
         TD6Iqw5HgPX1i/q7ePV+n/CDEbZor/KQYwE0wm1worWvIwfEAzGu5LfIqMXK5yHHbOoi
         ctMA==
X-Gm-Message-State: AJIora8aUyyTY5eXk9Rsk117hXhUPo3VVRuawZ3kPkOjqLNZqyT9lkCd
        GyWxv8Jva1xSQR4OSFmFyDPWEjoPy1JMYbhugi8HGX8k+SI9aw==
X-Google-Smtp-Source: AGRyM1u8/fczqpEqHys4lMdBD42hzPx+oBktPXrUqOpZkITLTxaC34KDOPwfS27dhSKZ2/rGZRl9swFcnaNWEji+6jY=
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id
 b97-20020a509f6a000000b0043558040e07mr30890715edf.178.1655820842034; Tue, 21
 Jun 2022 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220621121855.ynnv5ckymbmmvjcm@gmail.com> <20220621132909.00005439@Huawei.com>
In-Reply-To: <20220621132909.00005439@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 16:13:25 +0200
Message-ID: <CAHp75VeN=C7Uy+a9fBMX8NBO2nFLeAFjjpTdZX-y8K2enxMdiw@mail.gmail.com>
Subject: Re: Questions: IIO type for absorbance and float values in channels?
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Stefan Lengfeld <stefan.lengfeld@inovex.de>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Tue, Jun 21, 2022 at 2:29 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Tue, 21 Jun 2022 14:18:55 +0200
> Stefan Lengfeld <stefan.lengfeld@inovex.de> wrote:

...

> > Question 1:
> >
> > The sensor measures the absorbance[1] of a material. It's the negative
> > logarithmic quotient of the received and emitted light. It's a unit-less value.
> >
> > As far as I can see there is currently no predefined IIO type in the kernel for
> > this.  I have search the list [2], but nothing matches.
> >
> > Do I overlook something or what channel type should I use for this sensor
> > measurement value?
>
> So the closest we've seen to this is some of the health sensors (pulse oximeter
> targeting devices) but in that case the processing is done with a custom userspace
> library so we just pass values on in fixed point.
>
> So probably needs a new channel type.

Wouldn't this be a particular case of ambient (light) sensor?

-- 
With Best Regards,
Andy Shevchenko
