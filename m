Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA01E2803
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgEZRLt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbgEZRLs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 13:11:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE798C03E96D;
        Tue, 26 May 2020 10:11:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r16so989557qvm.6;
        Tue, 26 May 2020 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KYV7/EJY8skNu4Mtq/Qn2Agcp3CmHlLCDVh2doozBEU=;
        b=JwgYEdJDQ/uIIcFwlKyXpzLsjqIz68AIdnPC+fopKjr0+O03ByCELarQloCi43hpXw
         T4skqKg491ay9e6Ss90HK8Nz8iwTozfzoENWKGmYFDzw8/JWdLzNv1vEsPiVjQ5qm48p
         gfP0L+3lFoFd4iP0aXgBGAbGM/06liMiMW5owj4yBX4gfq7ftW7MFTX5b2NCj2FqUeIl
         d8tuenFc9nl9DDYiZ/WxeT9r5lqJGzNMFuuWMhTIywN0/MriK7DvMMBQnNmj9IMpardx
         t+pjezF0N0pP9IY1xNd7UadO7Gdj/a58GkbLUZHz1wEteG6Uml7f2TS/1ijuIVzpbux/
         KmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KYV7/EJY8skNu4Mtq/Qn2Agcp3CmHlLCDVh2doozBEU=;
        b=eEG1ePi+1kyPbcI7Ly1XS3jV28HYKKrZDgBpO63oDGjZMNyoPQKsnoRlSV7sCvQfcA
         C7mEX+8AbM3eYlgURwpcNXSJqZ0aehrpFRo+O4O6RoO+DjaMwm7MxH3HoFHg4TThIEmo
         okY/Sl7jPYdOKJeWAdNHQW7QYMJYj7tqpsEoWjklz1sHVnuUm0sfYk8ww6t8KA9GhdPF
         cVpIhU5/WgrpdFP+Yj21qVxs+IsntGRIen18EME4vBPlImYkLsYkAtSj5jQeu070c9J0
         JnJZj1JJfNq0VISm02goIL+vB3CQebUpTLmpYCt7G+hPgS4xn0r8v64OqOA45dFwJG8Z
         EIgw==
X-Gm-Message-State: AOAM532g691a38DCiMEdhGU3GREaxlI4OOHOcSFzKVkB7N6Vbn/Bw4J2
        M1Wst5oAfkTT0k3Zm7h9QVU=
X-Google-Smtp-Source: ABdhPJzEDF5z8a+BdBW6FzpI5b4GVQxMz0KacM8N1MLQOhuXRFKizNhj68n7e7J/KVVH4OHepYffww==
X-Received: by 2002:ad4:57a2:: with SMTP id g2mr21036833qvx.137.1590513107751;
        Tue, 26 May 2020 10:11:47 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id x1sm225275qts.63.2020.05.26.10.11.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 10:11:46 -0700 (PDT)
Date:   Tue, 26 May 2020 19:11:37 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200526171137.GA21760@ict14-OptiPlex-980>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
 <20200525151117.32540-4-jonathan.albrieux@gmail.com>
 <CACRpkdZo4PsC9Y8seMfS33escA6ZVKWwnbW2BCFOKiX2gY8RDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZo4PsC9Y8seMfS33escA6ZVKWwnbW2BCFOKiX2gY8RDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 26, 2020 at 11:22:07AM +0200, Linus Walleij wrote:
> On Mon, May 25, 2020 at 5:13 PM Jonathan Albrieux
> <jonathan.albrieux@gmail.com> wrote:
> 
> > Add reset-gpio support.
> >
> > Without reset's deassertion during ak8975_power_on(), driver's probe fails
> > on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> >
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheet says that, if not used, reset pin should be connected
> > to VID. This patch emulates this situation.
> >
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Thank you!!

Best regards,
Jonathan Albrieux
