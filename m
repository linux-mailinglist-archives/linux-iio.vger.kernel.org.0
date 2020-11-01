Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116822A1F15
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgKAPcb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgKAPca (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:32:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07331206D8;
        Sun,  1 Nov 2020 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604244750;
        bh=zaRSNwY1ZAh179FupbjBNapW+0OGmxmNUA2NqRQM7DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wB+1iKH/vDi/y6iMdpvBhXq5ykVyK6NFK3Qbre4RK8xVpLewqtmHU5OiDVTVbcao7
         5JfCP/wyiVXtk/jpUyC+/J5OqGKpRL1oAZ9j4zUrqNVfuIjcui33sgK0OmNFTmrRNi
         CXOe6tW3hVJLsBmEcSrtBGvyD4cFwlIQWwxejtS8=
Date:   Sun, 1 Nov 2020 15:32:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     trix@redhat.com, lars@metafoo.de, pmeerw@pmeerw.net,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, andy.shevchenko@gmail.com, krzk@kernel.org,
        alexandru.ardelean@analog.com, jonathan.albrieux@gmail.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: remove unneeded break
Message-ID: <20201101153225.0abf45c2@archlinux>
In-Reply-To: <CAFBinCDKf_TJb9ONfz+383NB0yKDb2a_zxXktAoBHKg_03L2+Q@mail.gmail.com>
References: <20201019172824.32166-1-trix@redhat.com>
        <CAFBinCDKf_TJb9ONfz+383NB0yKDb2a_zxXktAoBHKg_03L2+Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Oct 2020 21:39:17 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Mon, Oct 19, 2020 at 7:28 PM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > A break is not needed if it is preceded by a return
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/iio/adc/meson_saradc.c       | 2 --  
> for meson_saradc.c:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied,

Thanks,

Jonathan

