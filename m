Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC2D254DFB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0TG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:06:58 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44241 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0TG5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:06:57 -0400
Received: by mail-ej1-f67.google.com with SMTP id bo3so9096917ejb.11;
        Thu, 27 Aug 2020 12:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kX9eyuUyhq2QFDZPTT8K+fKfXv//9k/lun1Oefq69vQ=;
        b=kr2oH/9CxNs7iz8r8DpKFNCTMyQ28aGdp3TLDbLX5ElLn2zM/9q9ONlrMid5RvBVJi
         hjrxUbIVBwwNHG+Z0AcPDDAqcIZJ2Nk8ZOMjfQyFFHZeTq1yKxXeJtYFCn66Vss7wQEE
         CrJH2gdkN5y/i0sILTpZmY+D95+3Nn2ComTA8q+JmtKsJv+JQsGHzA9s347OUm+aLcUi
         b1VsdC5HhtupuibhJwnYGizsrJFxu+PcwyZ0PZXhAC0It5CxjJcWKd1XRzr3hfuMZRSf
         Ik5IpaDMmu9IV11nn3JLpMzthBQVZ4HIAS54WSDTR0UZbBvLNd9JkOH7lWt1DnX62KgP
         tbcg==
X-Gm-Message-State: AOAM533p9tc3H6iMApibp4zFbz+Sg86BQHmy9naKiUYoBIzLaFKTgNJV
        8lBnIFG9/lP1fk7p82yiWNxNu/vPWcjdUmdF
X-Google-Smtp-Source: ABdhPJwErb1TPe6yej5LwLYtNxfx1kujrjSq4jsHJ5VaVSvbdjyWgjoSXSM2n9G+Y0DfBXVTqlVBtw==
X-Received: by 2002:a17:906:37c1:: with SMTP id o1mr22299708ejc.279.1598555215565;
        Thu, 27 Aug 2020 12:06:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id w20sm2629985ejc.77.2020.08.27.12.06.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:06:54 -0700 (PDT)
Date:   Thu, 27 Aug 2020 21:06:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: stm32: Simplify with dev_err_probe()
Message-ID: <20200827190652.GD6196@kozik-lap>
References: <20200826161818.20969-1-krzk@kernel.org>
 <CAHp75Vf3s0+RrHnBoO4y4+t4Egth4uyYwtO5iPt9DbLJcunL6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vf3s0+RrHnBoO4y4+t4Egth4uyYwtO5iPt9DbLJcunL6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 11:27:12AM +0300, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 7:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and also it prints the error value.
> 
> 
> 
> 
> 
> 
> >         priv->aclk = devm_clk_get(&pdev->dev, "adc");
> >         if (IS_ERR(priv->aclk)) {
> >                 ret = PTR_ERR(priv->aclk);
> > -               if (ret != -ENOENT) {
> > -                       if (ret != -EPROBE_DEFER)
> > -                               dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> > -                       return ret;
> > -               }
> > +               if (ret != -ENOENT)
> > +                       return dev_err_probe(&pdev->dev, ret, "Can't get 'adc' clock\n");
> > +
> >                 priv->aclk = NULL;
> >         }
> >
> >         priv->bclk = devm_clk_get(&pdev->dev, "bus");
> >         if (IS_ERR(priv->bclk)) {
> >                 ret = PTR_ERR(priv->bclk);
> > -               if (ret != -ENOENT) {
> > -                       if (ret != -EPROBE_DEFER)
> > -                               dev_err(&pdev->dev, "Can't get 'bus' clock\n");
> > -                       return ret;
> > -               }
> > +               if (ret != -ENOENT)
> > +                       return dev_err_probe(&pdev->dev, ret, "Can't get 'bus' clock\n");
> > +
> >                 priv->bclk = NULL;
> >         }
> 
> Again, devm_clk_get_optional() and even, if it exists,
> devm_clk_bulk_get_optional().

Sure.

> 
> Please, revisit all patches on this topic.

I'll check them.


Best regards,
Krzysztof

