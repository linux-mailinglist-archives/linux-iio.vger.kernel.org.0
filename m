Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1012EC23
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 23:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgABWPj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 17:15:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36553 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgABWPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jan 2020 17:15:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so22545272pgc.3;
        Thu, 02 Jan 2020 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pf2sPSQ2r8gVDM6GDT9Oydz7LRk2MFbOJVaKwovzVYg=;
        b=ANs1k2MAT75YWXuwBY6qXWUXxwioKeNQ/7/JLTHIvraQhydyHUxx5OmeL5xNSoxBuO
         u07eWe9Rl+c/W/16sP1CkNSnAipEKqg36IEkRfdZ1zYOGhBEzPdC0nvxFACCQi/QDtnY
         Cy+dhitjmXtz0KgjBg+5vseSjwXRQpzfUmx4NnMLSvLXnhEoKGHIPrdVuiX8G51JWQJ1
         ZrsqPMZEqgBBz0HWDrZMFUNgvOL+Nz1zW9evRrB8hrVXEnefFmeZfwlqVrisk5/W8Odk
         3mJ5dDM6oQVVn+EqcxRINCOBiKbvpP/qVozvjufcQNwabjpvTIEwpKA3StkWV/pJckW7
         7+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pf2sPSQ2r8gVDM6GDT9Oydz7LRk2MFbOJVaKwovzVYg=;
        b=cg2bAEwReW3bbM+7CeRGxGCwp+zyYLAO/62tOOzEe5mbx40zCL6euN9Gxlvkmnvz+N
         BPzFUCVu9yG4W3ooJCTiOfs2jbJw2KNMXFgM3pPh3kcGshPQIniJsjYNGyXi3/eYUXKt
         q5yHwkV1F0S3TvgPo1CwWKl4Jw6YI9rKXBHvR7uzZELPT+Cxoj1cdUa2h9mUWh74iKtf
         8IkCVD7Tumk94EUrs6VRutm+jzOC8Jx0konbvYdR+HFClger7IyBay1V+2zanZ5cZIhZ
         ZRHjvNtrFXhbD/zkZxuF5mr3ZBQ6WDWaGTPyZEi6Ghi0IqqYRiyhOG/FwO+JWHuYdgU9
         QzHw==
X-Gm-Message-State: APjAAAU0/MtzT4+ZNlA2zhbHh+HwfXx0iay7RViIt0Yn8cuJ9ueGoe6t
        ulYHD0iPzVrejlxHsUI5KeA=
X-Google-Smtp-Source: APXvYqyonRxh/5OL9ZFS6CV6d7AM3DmbkqPcYGdi8P07EG8uPxw+qTrI6XLkOLItci4AWmahz10WLA==
X-Received: by 2002:a65:5ccc:: with SMTP id b12mr91179615pgt.124.1578003336592;
        Thu, 02 Jan 2020 14:15:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 136sm59225359pgg.74.2020.01.02.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:15:36 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:15:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>
Subject: Re: [PATCH 2/2 v1] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200102221533.GC8314@dtor-ws>
References: <20191228201109.13635-1-linus.walleij@linaro.org>
 <20191228201109.13635-2-linus.walleij@linaro.org>
 <20191230173919.373f4e8a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230173919.373f4e8a@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Mon, Dec 30, 2019 at 05:39:19PM +0000, Jonathan Cameron wrote:
> On Sat, 28 Dec 2019 21:11:09 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > +	/* Enable chip and IRQ, disable analog sleep */
> > +	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD,
> > +			   OPMOD_SSD_OPERATING | OPMOD_VCON_IRQ);
> > +	if (ret < 0) {
> > +		dev_err(gp2ap002->dev, "error setting up operation mode\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Interrupt on VOUT enabled */
> > +	ret = regmap_write(gp2ap002->map, GP2AP002_CON, CON_OCON_ENABLE);
> > +	if (ret < 0) {
> > +		dev_err(gp2ap002->dev, "error setting up VOUT control\n");
> > +		return ret;
> 
> drop this return ret out of the brackets as it's either 0 or negative anyway.

Not my subsystem, but $0.02 anyways: I like calling the temp as "error"
and explicitly return 0 in the success path even if it could be
collapsed, as you can easily add more initialization without needing
to go and alter previous blocks.

Thanks.

-- 
Dmitry
