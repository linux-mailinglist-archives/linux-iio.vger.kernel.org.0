Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD726E3AB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIQSeF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIQSeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 14:34:01 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA8C06174A;
        Thu, 17 Sep 2020 11:34:00 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 655929E023F;
        Thu, 17 Sep 2020 19:33:52 +0100 (BST)
Date:   Thu, 17 Sep 2020 19:33:51 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>,
        Pascal Sachs <pascal.sachs@sensirion.com>
Subject: Re: [PATCH 05/30] iio: chemical: sgp30: Add description for
 sgp_read_cmd()'s 'duration_us'
Message-ID: <20200917193351.6d640cb5@archlinux>
In-Reply-To: <20200718153345.0a6a5720@archlinux>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-6-lee.jones@linaro.org>
        <20200718153345.0a6a5720@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jul 2020 15:33:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 16 Jul 2020 14:59:03 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/iio/chemical/sgp30.c:236: warning: Function parameter or member 'duration_us' not described in 'sgp_read_cmd'
> > 
> > Cc: Andreas Brauchli <a.brauchli@elementarea.net>
> > Cc: Pascal Sachs <pascal.sachs@sensirion.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> 
> Perhaps we can do better on the wording.
> 
> > ---
> >  drivers/iio/chemical/sgp30.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> > index 403e8803471a9..82e407d48a0aa 100644
> > --- a/drivers/iio/chemical/sgp30.c
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -227,6 +227,7 @@ static int sgp_verify_buffer(const struct sgp_data *data,
> >   * @cmd:         SGP Command to issue
> >   * @buf:         Raw data buffer to use
> >   * @word_count:  Num words to read, excluding CRC bytes
> > + * @duration_us: Time to sleep in microseconds  
> 
> Time taken to sensor to take a reading and data to be ready.
> 
> Something like that maybe?  I've not checked the datasheet but from
> code that looks to be what this describes..

Tweaked and applied

Thanks,

Jonathan

> 
> Jonathan
> 
> >   *
> >   * Return:       0 on success, negative error otherwise.
> >   */  
> 

