Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C30DCEBB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439939AbfJRSw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 14:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439902AbfJRSw0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:52:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE5620640;
        Fri, 18 Oct 2019 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571424745;
        bh=OqPa3AhbNUgoijvZsXeWlvCHx7lRFGDH4OJ29A3bdhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fb4rem9ugVmK91zACy5BmV8YBx0iNsVsPa7GZaV7wUqCzftCq+8WP2vmj2FGbVUEH
         0/LJVksSg25WYHHWRZAlou7Dp5AHcqH7eoEdLVrIDeb7DknHr1W2aDM9XqYmSUiynm
         pLsvt+Jm/AoY2P4zWsRykNQ46CGCkAF3Uh3Rl448=
Date:   Fri, 18 Oct 2019 19:52:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: chemical: sps30: Explicity truncate constant by
 masking
Message-ID: <20191018195220.084d382c@archlinux>
In-Reply-To: <20191017164112.GA5100@arch>
References: <20191013095515.1438147-1-jic23@kernel.org>
        <20191017164112.GA5100@arch>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Oct 2019 18:41:12 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Sun, Oct 13, 2019 at 10:55:15AM +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > When breaking up a constant to write to two 8 bit registers
> > it isn't obvious to sparse that it was intentional.
> >
> > CHECK   drivers/iio/chemical/sps30.c
> > drivers/iio/chemical/sps30.c:120:30: warning: cast truncates bits from constant value (8004 becomes 4)
> >
> > So in the interests of minimising noisy warnings, let us add
> > a mask.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/chemical/sps30.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index edbb956e81e8..acb9f8ecbb3d 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -117,7 +117,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
> >  		break;
> >  	case SPS30_READ_AUTO_CLEANING_PERIOD:
> >  		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
> > -		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
> > +		buf[1] = (u8)(SPS30_AUTO_CLEANING_PERIOD & 0xff);
> >  		/* fall through */
> >  	case SPS30_READ_DATA_READY_FLAG:
> >  	case SPS30_READ_DATA:
> > --
> > 2.23.0
> >  
> 
> Thanks for catching this.
> Acked-by: Tomasz Duszynski <tduszyns@gmail.com>

Applied. Thanks,

Jonathan

