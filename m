Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D889330528
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 00:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhCGXGA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 18:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhCGXFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 18:05:39 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE84C06175F;
        Sun,  7 Mar 2021 15:05:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l2so5229137pgb.1;
        Sun, 07 Mar 2021 15:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XtRSM0w13Qb1yabD0yvOGJiUG6gT2e1c0aSLnOFytzc=;
        b=qqpw7VXyGhTyjQDiNWQvy+fZqojgqjErZm6pCLbKaMo8BltCZW6n83L/4NHkQIyw1l
         OG7wEU7XsaVivWPrzL6iXfy9zkcKDb1+0O+TLlwapo13/SWW/t5DgpIFrhNf7lHlL9gY
         TG5rism1NvCMTSY8XFbDRtnbJMge7ptt+7CxawGKg83tKY94uZFnxAWYnSy4TQ2jORsS
         k5jBXiFjEijqKa+VstXfHUP+VdQzUn7z3TzHpP75lyhJdYPSG0yNbRcZ3efCB9KkN7L5
         qR0pM0qSQauu9u/WlgIoiJVlwAzexoZzczYVRGOJTCKIzPL+yQX8JTVuUQRjYo95a/mV
         BlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XtRSM0w13Qb1yabD0yvOGJiUG6gT2e1c0aSLnOFytzc=;
        b=X9w1qUzNk7+zrIormjQmOrYc2RzmsCHMPwE2Iwxv2+uhSpPry7vCCGv/XO+zFCZ6sF
         RuyH7qQRrqqZSb5IfUZuLHV/8XlJ63F+2fj9ImNBGcEOss4kMKnSOWrd25bC3HhLZl1J
         7/caq/90dy0nmLQ7FPs1TvaBYahSMyQ2BeXXC2Vzw9zV415x2XDo3M5oIAXM3tlMVvwM
         lpDiIBhVcGPbJ7KKjwQKvOIEqSDHQpo3QMMAzlgI/jgOdzax6iH584eJu8Vx2Evoxws9
         1ddDf2TTkWkyAKbn7oeQnC04IaUxIIcK1HK7roTacJWRM9NDX+38oJ1wn6QwKRiO/+Ej
         7N1Q==
X-Gm-Message-State: AOAM531ZDoeWkLXKRGxIojOQlX6LWeuURJlWYrpJpEswWAiq+qCAWo7s
        ZpYPwjyMC3PucGSE/3GiZLE=
X-Google-Smtp-Source: ABdhPJynFdhgChyPxLEfnQ6VKIMDURJUnkeggRhI6GHFju/IlzJvlb/bAyyPTr80X2b7bq4l9ZresA==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr17631072pgj.451.1615158335573;
        Sun, 07 Mar 2021 15:05:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc9b:5ab2:d763:15bc])
        by smtp.gmail.com with ESMTPSA id x1sm8369251pje.40.2021.03.07.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 15:05:34 -0800 (PST)
Date:   Sun, 7 Mar 2021 15:05:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <YEVcO/NeKzBsFEdL@google.com>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305133813.27967-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Oleksij,

On Fri, Mar 05, 2021 at 02:38:13PM +0100, Oleksij Rempel wrote:
> +
> +	/* TODO: remove IRQ_NOAUTOEN after needed patches are mainline */
> +	irq_set_status_flags(spi->irq, IRQ_NOAUTOEN);
> +	ret = devm_request_threaded_irq(dev, spi->irq,
> +					NULL,
> +					&tsc2046_adc_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					name, indio_dev);

I'd recommend dropping IRQF_TRIGGER_LOW and only using IRQF_ONESHOT and
rely on the platform (ACPI, DT) to specify trigger polarity according to
how device is wired in a given system. In general I believe newer
drivers should not specify interrupt triggers themselves.

Thanks.

-- 
Dmitry
