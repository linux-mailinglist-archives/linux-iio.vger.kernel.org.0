Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806B5196653
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 14:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1N2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 09:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1N2m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 09:28:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAEE20716;
        Sat, 28 Mar 2020 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585402121;
        bh=7PkcQmJbiKBVYHgPxocBQ4qcTCA/rCmSDX0UTNOOfrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KL+OUnlNDPZw3rx7QJ9kmgeQ5Sh+3h6+6MRzZkvswiRrdjuIh/TC6H+LwyPKGNgw9
         2rcI8LE3nOPge5okKsd4655z2AJQ7JrJMhPmvuRHp+1HFLIYE0e9jAM+GluoWpruw3
         HufoF014Teo+Tnn6a2g5Qu9M7ygtggVtnalySbC0=
Date:   Sat, 28 Mar 2020 13:28:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 4/4] staging: iio: adc: ad7280a: Add comments to
 clarify stringified arguments
Message-ID: <20200328132836.34b20bb7@archlinux>
In-Reply-To: <9da7b4c4424cda9ab42353ab073d2a8313d978f8.camel@analog.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
        <469bf8db1c228913e72841367182fba2168fe795.1584904896.git.mh12gx2825@gmail.com>
        <9da7b4c4424cda9ab42353ab073d2a8313d978f8.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 08:07:28 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-03-23 at 01:27 +0530, Deepak R Varma wrote:
> > [External]
> > 
> > Checkpatch would flash a check message around a stringified macro
> > argument containing a '-' character. Add comment to indicate the
> > argument is legitimate and doesn't need fixing.  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

One minor thing inline, otherwise thanks for doing this.

Jonathan

> 
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > ---
> > 
> > Changes since v2:
> > 	- None. Patch added in v3
> > 
> > Changes since v1:
> > 	- None. Patch added in v3
> > 
> >  drivers/staging/iio/adc/ad7280a.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c
> > b/drivers/staging/iio/adc/ad7280a.c
> > index 19a5f244dcae..bef6bd1295ea 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -824,6 +824,10 @@ static irqreturn_t ad7280_event_handler(int irq, void
> > *private)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +/* Note: No need to fix checkpatch warning that reads:
Trivial, but please use standard multiline comment syntax (for most but not
all of the kernel)

/*
 * Note:
..
 */
> > + *	CHECK: spaces preferred around that '-' (ctx:VxV)
> > + * The function argument is stringified and doesn't need a fix
> > + */
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> >  			     in_voltage-voltage_thresh_low_value,
> >  			     0644,  

