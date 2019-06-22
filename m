Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90AA4F505
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVJ6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:58:35 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50804 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVJ6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2019 05:58:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 851469E74F7;
        Sat, 22 Jun 2019 10:58:32 +0100 (BST)
Date:   Sat, 22 Jun 2019 10:58:30 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/1] counter/ftm-quaddec: Add missing '>' in
 MODULE_AUTHOR
Message-ID: <20190622105830.787b2fe7@archlinux>
In-Reply-To: <20190618091731.GA8257@icarus>
References: <20190618090542.13885-1-patrick.havelange@essensium.com>
        <20190618091731.GA8257@icarus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 18:17:31 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Jun 18, 2019 at 11:05:41AM +0200, Patrick Havelange wrote:
> > The last '>' chars were missing in the MODULE_AUTHOR entries.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > ---
> >  drivers/counter/ftm-quaddec.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> > index c83c8875bf82..68a9b7393457 100644
> > --- a/drivers/counter/ftm-quaddec.c
> > +++ b/drivers/counter/ftm-quaddec.c
> > @@ -352,5 +352,5 @@ static struct platform_driver ftm_quaddec_driver = {
> >  module_platform_driver(ftm_quaddec_driver);
> >  
> >  MODULE_LICENSE("GPL");
> > -MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
> > -MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");
> > +MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
> > +MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
> > -- 
> > 2.19.1  
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Jonathan, please pick up this fix as well.
> 
Applied to the togreg branch of iio.git and pushed out as testing though not
sure anyone other than Randy is running checks on this one!

Thanks,

Jonathan

> William Breathit Gray

