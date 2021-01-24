Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A985C301C2B
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAXNYb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 08:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAXNYa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 08:24:30 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEE722511;
        Sun, 24 Jan 2021 13:23:47 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:23:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20210124132344.7181bd06@archlinux>
In-Reply-To: <CACRpkdZTJbAFK0j8U84pyW6za-SGJqGWnvertj8sXxc8Ou8VeA@mail.gmail.com>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
        <20210119124622.9490-2-mike.looijmans@topic.nl>
        <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
        <20210123153511.1802a15a@archlinux>
        <CACRpkdZTJbAFK0j8U84pyW6za-SGJqGWnvertj8sXxc8Ou8VeA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Jan 2021 00:21:13 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Jan 23, 2021 at 4:35 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > [Me]  
> > > Next, I think it is better to let suspend/resume, i.e. system PM
> > > reuse runtime PM since you're implementing that. This is why
> > > we invented PM runtime force resume and force suspend.  
> >
> > Here the driver is turning more off for full suspend than in the
> > runtime path.  If that results in significant extra delay then
> > it's not appropriate to have that in the runtime suspend path.  
> 
> I see the point.
> 
> The resume path calls bmi088_accel_enable() which incurs
> a 5ms delay.
> 
> The runtime resume path incurs a 1 ms delay.
> 
> The runtime autosuspend kicks in after 2 ms.
> 
> > Maybe the simplification of not doing the deeper power saving
> > mode is worth the extra power cost or extra delay, but
> > I'm not yet convinced.  
> 
> I would personally set the autosuspend to ~20ms and just use
> one path and take a hit of 5 ms whenever we go down between
> measures if it is a system that is for human interaction, but for
> control systems this more complex set-up may be better for
> response latencies.
> 
> The current approach may be better tuned to perfection and
> we are all perfectionists :D
> 
> I'm just worrying a little about bugs and maintainability.
Fully understood.  Though for things like this I like to leave
it at the discretion of the driver author as fairly safe they
are a user of the device.  

May well make sense to go with the longer times as you
suggest though!  Over to you Mike :)

Jonathan

> 
> Yours,
> Linus Walleij

