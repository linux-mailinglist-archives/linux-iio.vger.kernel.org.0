Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72181FEBF2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfKPLta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 06:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfKPLta (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 06:49:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507EA20723;
        Sat, 16 Nov 2019 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573904969;
        bh=3HH7HX8fSkkDcgIdzdGuNZMUlhgVA3fS5tQFFqx3jws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mh+ioHEL0q6X99zIm5FVogzqT6I4170MCs0nJESj8ta22T72KKgw1Lm0os9xVsahd
         3gyQ7Ag1BNuKpSuYu2BNSXK1EeebNtcfbqNp+egMLvX/jcW2PYzk+jA7rd/yUhTA7c
         VE8i+VbwmI3Ccjb/j8/zZSqnp2wZAKAslvEGlC4g=
Date:   Sat, 16 Nov 2019 11:49:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191116114923.39e9ce3c@archlinux>
In-Reply-To: <20191111114423.GN3218@dell>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-2-gwendal@chromium.org>
        <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
        <20191111114423.GN3218@dell>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Nov 2019 11:44:23 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Fri, 08 Nov 2019, Enric Balletbo Serra wrote:
> 
> > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dt., 5 de
> > nov. 2019 a les 23:28:  
> > >
> > > Add a new function to return the number of MEMS sensors available in a
> > > ChromeOS Embedded Controller.
> > > It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> > > registers to find out.
> > >
> > > Also, make check_features public as it can be useful for other drivers
> > > to know what the Embedded Controller supports.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> > 
> > Version 3 was acked and I think we can maintain his ack, so:
> > 
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Also,
> > 
> > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > Lee, how you would like to handle this? I think will be safe for
> > patches 1/2/3 go through the platform-chrome tree without an immutable
> > branch. Patch 3 thought still needs and Ack from you if is fine.  
> 
> Please take the entire set, converting:
> 
>   s/Acked-for-MFD-by/Acked-by/
> 
> ... and send me a pull-request to an immutable branch.
> 

Agreed.  Please do an immutable branch for the whole series v5 if everyone
else is happy with the changes in V5. (I think it was mostly my
comments on v4 so fingers crossed :)

I'll pull it if / when some follow up changes touch the resulting code
on the IIO side. Gwendall, if you can highlight if that occurs that
would be great as well!

Thanks,

Jonathan

