Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285ECCC9F3
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfJEMaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEMaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:30:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D852C222CB;
        Sat,  5 Oct 2019 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570278611;
        bh=r2fd8y2E93hYu8OVo5Fp87oBQdhWfOgQx8bj5sFr+04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=noNGsc13R1P8TRZEBzpPcH/dGCGaIEu8kvQgyPp1k/wz9330dvZConRFj80uNVuYq
         nm9dgRdv0pQkcmzlBtxwiP1on7Jyzbtutr0MLMf1Q3qa7ZtZAcuCITRd4YsDu9qlpX
         1uqrE9hqj5B72EaD97Oj0f0dHLmTr/tD+KU8qQRg=
Date:   Sat, 5 Oct 2019 13:30:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, knaack.h@gmx.de,
        lars@metafoo.de, tomas@novotny.cz, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] iio: light: add missing vcnl4040 of_compatible
Message-ID: <20191005133006.4fc6c0a5@archlinux>
In-Reply-To: <a93e2e861ac7f2473a05929f4511bfa0@akkea.ca>
References: <20190917145637.22605-1-m.felsch@pengutronix.de>
        <20190917145637.22605-2-m.felsch@pengutronix.de>
        <a93e2e861ac7f2473a05929f4511bfa0@akkea.ca>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Sep 2019 07:47:31 -0700
Angus Ainslie <angus@akkea.ca> wrote:

> On 2019-09-17 07:56, Marco Felsch wrote:
> > Commit 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040
> > proximity and light sensor") added the support for the vcnl4040 but
> > forgot to add the of_compatible. Fix this by adding it now.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>  
> 
> Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca
I turned the above note on what missed this into a fixes tag and 
marked it for stable.  It's no a particularly critical fix, but it
is fairly trivial and very unlikely to have side effects so lets
get it tidied up everywhere.

Thanks,

Jonathan
 
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c 
> > b/drivers/iio/light/vcnl4000.c
> > index f522cb863e8c..16dacea9eadf 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -408,6 +408,10 @@ static const struct of_device_id 
> > vcnl_4000_of_match[] = {
> >  		.compatible = "vishay,vcnl4020",
> >  		.data = (void *)VCNL4010,
> >  	},
> > +	{
> > +		.compatible = "vishay,vcnl4040",
> > +		.data = (void *)VCNL4040,
> > +	},
> >  	{
> >  		.compatible = "vishay,vcnl4200",
> >  		.data = (void *)VCNL4200,  

