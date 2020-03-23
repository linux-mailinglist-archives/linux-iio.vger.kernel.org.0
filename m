Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0451418F85E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCWPRU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 11:17:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38318 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCWPRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 11:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so7349800pgh.5
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5WxcqTugnAo9X+DA9YOBgJCfSv0O7b15VIBu8XZa4A=;
        b=dwq6Y3oh/SSqSVYxAanGu7uxp0yDphGU1TNq+c4SKtXqlb9zuvHXCaH0gOHVf+5owJ
         +P2Pu9mYk41+q9pQeY0ykRWhajyOPs3Brrxy+so9T94idHN72XXDNXUEUsaEKpfWaZv6
         vXzcQmMJelkP9IhglFwx6U1FyWlfxLLQLk4n+rdMmAmGPeUIWdsPEsshDHuXFHrb30pf
         bWFyUZLg0RGBpwL+pnvpXAPtVFCrdoB/eRXRGKJPUM8TxGIO4wWHes/GEVprU7BTahs7
         p+u4Vv8vxKVlnacXkB5mR7RxVqCxF5Y7aHmMVqykJpLC1piO3Ffh4bU1tZIe1/WLMlUu
         9M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5WxcqTugnAo9X+DA9YOBgJCfSv0O7b15VIBu8XZa4A=;
        b=DF+SnC6BpIMz5rnAagLSU5aaGAzPE8tED1rCFRIfS5nNbZEp2jGmoEAFZgTrBPMpD3
         2Hh/2yoPdgwqVCLuxm0mUiJvfHlUHqAgoDzF3dU7vFK5hzIXw+L3P6qzZwDtgFRR7kfs
         i6vi5GWqVe1Th5rKOVG7v6aM+5INl/xODSZHCe/j9LCfMI1so3uYgoBnCVE1w3uoiGvT
         Zr0SB2SYDc5iRRUbZrsyR4Gd8VKi7GcUfHXlUu7fPyYW/0HERlZLWnm+yQMWSb2tYTVn
         UcCVh1wF4S1eRP9jeBLOrI1ztAN/QJM756G0paGwSNCrqNA3uld3k88uRGB07aW/aN7h
         uQAA==
X-Gm-Message-State: ANhLgQ1HdR3NUYnldwpWWjhc3yOZR9ZU4dEolF4JL1aMGsFWTBlGKvsl
        O3vYxrBd2ZIwVB3IJEUcOMQ=
X-Google-Smtp-Source: ADFU+vsLgUSOlKYleVFj8hshgXTaxjeig+FDVpdTlRGs2VtJLisA5pe5cnBHT5G8sxHrpr2RoXcIeg==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr21702334pge.18.1584976638849;
        Mon, 23 Mar 2020 08:17:18 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id i187sm13502225pfg.33.2020.03.23.08.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 08:17:18 -0700 (PDT)
Date:   Mon, 23 Mar 2020 20:47:12 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] media: staging/intel-ipu3: Reformat pointer
 initialization
Message-ID: <20200323151710.GA22110@deeUbuntu>
References: <20200322185350.GA12377@deeUbuntu>
 <CAHp75VcP1O_QwepgAHPBaTLcr_3=ynV6hsmcgvYnBCz7DdoWxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcP1O_QwepgAHPBaTLcr_3=ynV6hsmcgvYnBCz7DdoWxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 01:35:58AM +0200, Andy Shevchenko wrote:
> On Sun, Mar 22, 2020 at 8:54 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> >
> > Reformat pointer initialization to make it more readable as per the
> > coding standards. Problem detected by checkpatch.
> 
> > -       struct imgu_v4l2_subdev *imgu_sd =
> > -               container_of(ctrl->handler, struct imgu_v4l2_subdev, ctrl_handler);
> > +       struct imgu_v4l2_subdev *imgu_sd = container_of(ctrl->handler,
> > +                                                       struct imgu_v4l2_subdev,
> > +                                                       ctrl_handler);
> 
> I'm sorry I don't see benefit of this change, actually an opposite.

Hello Andy,
Thank you for your comment. To me, it helps quickly and clearly spot
*imgu_sd. Also the initialization looks more structured. But that's just
me.

I will wait to see if anyone else wants to share their thoughts, and
then circle back to you on next steps. Is that fine?

Deepak.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
