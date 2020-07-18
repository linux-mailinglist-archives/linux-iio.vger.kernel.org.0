Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF6224C9C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRPmc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPmc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:42:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A61520734;
        Sat, 18 Jul 2020 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086951;
        bh=sKn9vFElC2tCEp74wzpFNMsORqJJ6syTCHl3CtNILxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GXHPfUUyUfG4NIsvWL8t6VGDhTaGUPD/lO4eZyf3azcVtBBpf1NuvyjJIYElVbOu/
         OpxHw2KwDGaiEHp/xPxz5obQqIpzq1apKXSULQK9J775kbb9L+zowTYZvUyc7hdwDv
         gcGaPLtHXK3Z7EfzdIV98u7k7aFB+bHQhRjMZ5+s=
Date:   Sat, 18 Jul 2020 16:42:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 09/30] iio: temperature: mlx90632: Function parameter
 descriptions must match exactly
Message-ID: <20200718164227.0e31c078@archlinux>
In-Reply-To: <CAKv63uvMb1R2OyBwFuCTU+E5YQfHwBB+bqRP+jXO9yn4e2Wu6w@mail.gmail.com>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-10-lee.jones@linaro.org>
        <CAKv63uvMb1R2OyBwFuCTU+E5YQfHwBB+bqRP+jXO9yn4e2Wu6w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 21:48:06 +0200
Crt Mori <cmo@melexis.com> wrote:

> Acked-by: Crt Mori <cmo@melexis.com>
> 
> On Fri, 17 Jul 2020 at 18:56, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > '*'s are not welcome in kerneldoc parameter names.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/iio/temperature/mlx90632.c:175: warning: Function parameter or member 'data' not described in 'mlx90632_perform_measurement'
> >
> > Cc: Crt Mori <cmo@melexis.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
I got lazy on bothering about the addition of optional brackets.

Applied,

Thanks,

Jonathan

> > ---
> >  drivers/iio/temperature/mlx90632.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index eaca6ba068646..b9a8089be3f63 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -164,8 +164,8 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
> >  }
> >
> >  /**
> > - * mlx90632_perform_measurement - Trigger and retrieve current measurement cycle
> > - * @*data: pointer to mlx90632_data object containing regmap information
> > + * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
> > + * @data: pointer to mlx90632_data object containing regmap information
> >   *
> >   * Perform a measurement and return latest measurement cycle position reported
> >   * by sensor. This is a blocking function for 500ms, as that is default sensor
> > --
> > 2.25.1
> >  

