Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6E3D48B0
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGXQUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 12:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhGXQUS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 12:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29DC660C51;
        Sat, 24 Jul 2021 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627146050;
        bh=U7ErnqKddTl3+stSZEu0MbjJIM+dNM8lp22tD0zMf/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZG+vTkGSCmHMp2j43cG+mNNhWzaQDsdIYLOOCkVEYQJZMq3HZvq/tRLJZWeRyelS5
         Rkgaj5aHtmxAJNYHBfWwFgUV1QNvy7gJnRQlfaeE2q63pC4p7BIOFLSxaly+e0JYW2
         UJNkaBtfA2iiTs6WkN6mDCrCTE1oSjbX2iyiTtErLNqLHigZ4CVxAJ16q2l6UeA4Ty
         vw7dC9wLdoFXGD3IFiKGQcEArdJYjhGKzVgKokEuddTmCxQlLn/wmmTOWYfrGH13wt
         3LoEVgkVLXbwdAaxjS5ae20CbTmrtW29z4ewYdMp/dmY+iyqREFckesaMbdE8X3qpC
         KKlieNZ2ZffjA==
Received: by mail-wr1-f41.google.com with SMTP id y8so5706632wrt.10;
        Sat, 24 Jul 2021 10:00:50 -0700 (PDT)
X-Gm-Message-State: AOAM531WWxn3MJH8Sy6mOQz9n2DUbhIM/quFnKHRqXcBMtJBAoHrvsvj
        Fm9JuAHa2SYXNCBNN8CjcIdF5Z5jXz1VrbnlKCg=
X-Google-Smtp-Source: ABdhPJzpglz8S2nrBERfhhEwaUccRqGlAfPlsrzXUqY1/gWJcDj8nrzbegAKRKxnfxES9gcgoWIq9LL5CdSq6prVY5I=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr11085586wrw.105.1627146048693;
 Sat, 24 Jul 2021 10:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151330.2176653-1-arnd@kernel.org> <CAHp75VeWSfBek+m6hQoc6G7wP+JNN-V3S0kfcGBESZLR+6QAxg@mail.gmail.com>
 <CAK8P3a0wU+yAm0X_URFVuM=GragqQnvz2Reto5e09fzqCVrUqQ@mail.gmail.com>
 <CAHp75VfQLGX4ir8XxMZBMkPaK2SoazJwr3axsk-5p1ok6uf6jg@mail.gmail.com>
 <CAK8P3a3SMGHvj2cywrPVQchJTmhvwq9ERsPDmV0E0K6zC0St5w@mail.gmail.com> <20210724161635.479e5238@jic23-huawei>
In-Reply-To: <20210724161635.479e5238@jic23-huawei>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Jul 2021 19:00:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zPwH6rzMJZQa0_37UoU9LAnR36jMEJfxYpwjNsXCfVA@mail.gmail.com>
Message-ID: <CAK8P3a0zPwH6rzMJZQa0_37UoU9LAnR36jMEJfxYpwjNsXCfVA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: fix i2c dependency
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 24, 2021 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 21 Jul 2021 20:40:30 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> I didn't think of this particularly combination when we dealt with
> last build issue the workaround brought in.  I've applied this to the
> fixes-togreg branch of iio.git as an immediately solution, but longer
> term we should think about just using a function pointer to allow us
> to move this into the i2c specific module.  If we do that we can
> drop this complex build logic later.

Ok, that sounds good to me, thanks!

       Arnd
