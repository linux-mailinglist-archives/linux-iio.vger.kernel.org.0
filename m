Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB57ACC70
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfIHLeD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 07:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfIHLeD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 07:34:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30899206BB;
        Sun,  8 Sep 2019 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567942442;
        bh=73dqUp1UuFijMCdNUSXFQ3ADngSEc+MwZNdBG1PT9zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fh9uEAA0cOTgjt6bxZJBiFsr599jUiyznIekxWDCAeOPDXWR7GQ6ITjWeEt+g0JuP
         /iStZTilcO/8dc9VpLYxeswMBb2VLsjzaFxOIiF4cudpG8rsRu72ApdEBSit7stduT
         3OQEHjmxGqFUeEuy9wExsOz/oCillPPrfz5uOSr4=
Date:   Sun, 8 Sep 2019 12:33:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Elie Roudninski <xademax@gmail.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
Message-ID: <20190908123356.2cd844a3@archlinux>
In-Reply-To: <CAJJ5kavS6RU1tK-BqgWD-VmJzPuG114y+pNApYay=+xwCtAwQg@mail.gmail.com>
References: <20190901105410.23567-1-repk@triplefau.lt>
        <CAFBinCD96nJBPnyNgWA6CgwE2kZrkXB3-cgbV9aQLB=JtbrN2w@mail.gmail.com>
        <CAJJ5kavS6RU1tK-BqgWD-VmJzPuG114y+pNApYay=+xwCtAwQg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 21:40:49 +0100
Elie Roudninski <xademax@gmail.com> wrote:

> On Sun, Sep 1, 2019 at 12:29 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > On Sun, Sep 1, 2019 at 12:45 PM Remi Pommarel <repk@triplefau.lt> wrote:  
> > >
> > > meson_saradc's irq handler uses priv->regmap so make sure that it is
> > > allocated before the irq get enabled.
> > >
> > > This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> > > managed resources are freed in the inverted order they had been
> > > allocated, priv->regmap was freed before the spurious fake irq that
> > > CONFIG_DEBUG_SHIRQ adds called the handler.
> > >  
> >
> > Fixes: 3af109131b7eb8 ("iio: adc: meson-saradc: switch from polling to
> > interrupt mode")  
> > > Reported-by: Elie Roudninski <xademax@gmail.com>
> > > Signed-off-by: Remi Pommarel <repk@triplefau.lt>  
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > thank you for fixing this!  
> The patch fixed the kernel panic I had, i can now successfully boot my
> meson-gxl-s905x-libretech-cc boad using patched linux 5.2.11
> 
> Tested-by: Elie ROUDNINSKI <xademax@gmail.com>
Rather than rush through a quick pull request I'm going to hold this one
until after the merge window.

Applied to the fixes-togreg branch of iio.git (which is now based
on staging-next).

Thanks,

Jonathan

> 
> Elie
> >
> >
> > Martin  

