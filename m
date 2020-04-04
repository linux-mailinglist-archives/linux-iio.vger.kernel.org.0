Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6D19E68E
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgDDRCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 13:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgDDRCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 13:02:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49A4206C3;
        Sat,  4 Apr 2020 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586019770;
        bh=KtAT7mCgAta1aNMWMPWbju9BeOA1Mrp1YOuwU8AXNjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eLOSNVObRusS6RBLXTgmRNzihpJTwUkkSfV3+Hs2MfpPWplZqvDsgGOyVJF+M7+Mk
         7llKPRESNCahhPtwRuuUNyo6a/Zv7cOCM8mCz3oxPHjD2BPUSTfu6Co5ogFeRADwbS
         5X1TCZbXwagpjgWmGPWF/qy2gkEncAC5W41BJBjw=
Date:   Sat, 4 Apr 2020 18:02:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v7 2/2] iio: adc: Add MAX1241 driver
Message-ID: <20200404180245.30deab21@archlinux>
In-Reply-To: <20200403162154.GA8285@leena.republic>
References: <20200403121323.1742-1-alazar@startmail.com>
        <20200403121323.1742-3-alazar@startmail.com>
        <CAHp75VcKEqM4nxvu3QtqNDpwtJU77zu=YfPwmCXn_L=LsGSuAQ@mail.gmail.com>
        <20200403162154.GA8285@leena.republic>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Apr 2020 19:21:54 +0300
Alexandru Lazar <alazar@startmail.com> wrote:

> > FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> 
> Thanks!
> 
> > > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> > >  
> > No blank line, but this can be fixed by maintainer, I think.  
> 
> Oops! Not sure how I (and checkpatch.pl?) missed that! It's tiny enough
> to fix inline I guess, but it's not a problem to make a v8 with it if
> needed.
> 
I tidied that up and applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> Thanks,
> Alex

