Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB7126FD4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 22:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSVld (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 16:41:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46871 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLSVlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 16:41:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so5400689ljc.13
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2019 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASudMKT9RvM8+uOEJ+om2HEpPLO01yunBeLwD2PFAJc=;
        b=UXcQVrIGeuZxPW+wBt70BmOeFM34wTHIaDD0QSufDB+hpWy60xAnbwPJzGMxZPXXTh
         Bvo8xVwa12ZkQ98lNPHyUhNhqkyPhh0MIfsaBBppOcWPWZTk2unZdTF49txMzJY3pHCD
         YxHDMEoyLpEkPOpdFmf/K3MonB5D7tmCbAN8kHT74gEBRwDcUB8IFxHMaMXJw7WUtcz3
         +XHy8aT9jY6xESdx5KtiAOTv1zlbyPbECB2s9vvieBjnb2sKKBAWjoVIOiF0jHW9D+FO
         hbJU/6H/5NVBmZHwpJjIPmmCajp+Vkm1VSI5ttRddK13sa9OsU5HRyIcUFtY30Eo5+Tf
         ZKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASudMKT9RvM8+uOEJ+om2HEpPLO01yunBeLwD2PFAJc=;
        b=kiqZHE5mPaZ2EqCzK+wM5z6gMjjkVkTqFLlGHzj5Fu+fCHavPFc5R4hICbkx92E/W5
         wjJXEHW4amPW8fOFIZPqot+2KVQRbgoITCzQeJjJFEvzA1/U1zubrOSP8CNaN9aVIGvH
         /dT/VHuYMNBiYHpdabQczfOWROfH9EEPpzX4tWtgou3SRuPOQaRZCPvuqHIlm0G/03lD
         NHh3TLf4933xEpzw7bak9P4VvLVCVtBQS4YbuBRIalEOZ60GCKFOcHKdBFXFllGJscWd
         v+4iu66K2173iDdYE2IuhSBcQnug57wgBHAOeTPSuLvaIQBNlqGYnZLHzgBcM8bPeB6A
         Sj5w==
X-Gm-Message-State: APjAAAUwuEiGYjt7bJLOuGwTQF3foXqQN2ES7UJyPXoZaAw/bi6Liwtf
        AtA5QF1FAaVMp6j5mdy7NL+CHLoj7HGbjX5oLoNv8g==
X-Google-Smtp-Source: APXvYqy9XFc6i9Ei1l8/pgiZ7fRlyEwn/IPd/gtw9jl+Fsj13MvpzMQ1Czzx4p0iNxwBYpWYIGIEHFQfXkyLyoBw2Kg=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr7762896ljk.77.1576791690711;
 Thu, 19 Dec 2019 13:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-4-dan@dlrobertson.com>
 <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
In-Reply-To: <CAHp75VeU07TsV2NC5Myvmi7Q6tARbmt9=wQDRnXFqaX2G2Luiw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 22:41:19 +0100
Message-ID: <CACRpkdbTissSRyJ5uh8X6RFTM+VSSML-JmtOC_i8_UY0VTVRAA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: (bma400) basic regulator support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 12:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Dec 19, 2019 at 6:28 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> > Add support for the VDD and VDDIO regulators using the regulator
> > framework.
> ...
>
> > +       data->vdd_supply = devm_regulator_get(data->dev, "vdd");
>
> > +       data->vddio_supply = devm_regulator_get(data->dev, "vddio");
>
> devm_regulator_bulk_get() ?

I always thought to use regulator_bulk* maybe 3 regulators and
definitely for more that 4 as it also clouds the view bit and is not
as straightforward to read as the single functions, but I suppose
it is a bit subjective :)

Linus Walleij
