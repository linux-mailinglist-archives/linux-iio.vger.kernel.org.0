Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C1400EE8
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhIEJxF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Sep 2021 05:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234907AbhIEJxE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 05:53:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EA160F12;
        Sun,  5 Sep 2021 09:51:57 +0000 (UTC)
Date:   Sun, 5 Sep 2021 10:55:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
Message-ID: <20210905105518.56fde2d4@jic23-huawei>
In-Reply-To: <MW4PR03MB636324E990C3ED6BF8D6D94399CD9@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <20210820165927.4524-2-mihail.chindris@analog.com>
        <20210830170555.25887e82@jic23-huawei>
        <MW4PR03MB636324E990C3ED6BF8D6D94399CD9@MW4PR03MB6363.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> > > +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > > +		return -EBUSY;
> > > +
> > > +	return iio_buffer_write(filp, buf, n, f_ps);
> > > +}
> > > +
> > >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> > >  				 struct poll_table_struct *wait)
> > >  {
> > > @@ -231,6 +317,15 @@ void iio_buffer_wakeup_poll(struct iio_dev  
> > *indio_dev)  
> > >  	}
> > >  }
> > >
> > > +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data)  
> > 
> > sample or scan?  Sample would be a single value for a single channel,
> > scan would be updates for all channels that are enabled.  
> 
> Maybe iio_pop_from_buffer()? To be consistent with iio_push_to_buffer()..

Works for me.  

J
> 
> - Nuno Sá

