Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89BE381DAB
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhEPJgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 05:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234937AbhEPJgd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:36:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162C761028;
        Sun, 16 May 2021 09:35:15 +0000 (UTC)
Date:   Sun, 16 May 2021 10:36:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maxime =?UTF-8?B?Um91c3Npbi1Cw6lsYW5nZXI=?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iio: si1133: fix format string warnings
Message-ID: <20210516103628.2cf899a0@jic23-huawei>
In-Reply-To: <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
References: <20210514135927.2926482-1-arnd@kernel.org>
        <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 May 2021 10:45:02 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On 5/14/2021 6:59 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > clang complains about multiple instances of printing an integer
> > using the %hhx format string:
> > 
> > drivers/iio/light/si1133.c:982:4: error: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
> >                   part_id, rev_id, mfr_id);
> >                   ^~~~~~~
> > 
> > Print them as a normal integer instead, leaving the "#02"
> > length modifier.
> > 
> > Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Indeed, use of %hx and %hhx have been discouraged since commit 
> cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary 
> %h[xudi] and %hh[xudi]").
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan
> 
> > ---
> >   drivers/iio/light/si1133.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> > index c280b4195003..fd302480262b 100644
> > --- a/drivers/iio/light/si1133.c
> > +++ b/drivers/iio/light/si1133.c
> > @@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev *iio_dev)
> >   		return err;
> >   
> >   	dev_info(&iio_dev->dev,
> > -		 "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> > +		 "Device ID part %#02x rev %#02x mfr %#02x\n",
> >   		 part_id, rev_id, mfr_id);
> >   	if (part_id != SI1133_PART_ID) {
> >   		dev_err(&iio_dev->dev,
> > -			"Part ID mismatch got %#02hhx, expected %#02x\n",
> > +			"Part ID mismatch got %#02x, expected %#02x\n",
> >   			part_id, SI1133_PART_ID);
> >   		return -ENODEV;
> >   	}
> >   
> 

