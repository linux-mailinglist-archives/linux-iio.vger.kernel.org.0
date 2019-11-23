Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF0107E56
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKWMZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfKWMZx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:25:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD13520714;
        Sat, 23 Nov 2019 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574511953;
        bh=z07hXbxuYWALaZvw5W/e1nEbTvKOPkGW10MgUIV9CjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NX9zjUy5SwdZQWO9O5tSZ6mL0TkejzaL0PiMLKnCavTuSbYuDRdxCHPdoYyN6j2BL
         DX3cfQvZRm8QYY0/eib8okpO/vtMGD/fwxP04RjBzs0mXZLuLBmFxzJqGv7FB6ylYX
         rvojvzYGYI6NUDaW+/WyNrieyRRL3LMoMmHr66y0=
Date:   Sat, 23 Nov 2019 12:25:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad7292: Update SPDX
 identifier
Message-ID: <20191123122548.54f0f529@archlinux>
In-Reply-To: <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com>
References: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
        <CAL_JsqJzi_0eYj=rMxwQe+OTh_m3ngocOvcPZd-tykAwAJAw6g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Nov 2019 10:05:52 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Nov 16, 2019 at 2:50 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
> > licensing.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> > I split the changes into 2 different patches since they are about
> > different issues.
> >
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
I've applied this to the fixes-togreg branch so it'll go in during
the early RCs.  Nice not to have a release with a different
license, particularly as this was me running too fast at taking
patches.

Thanks,

Jonathan


