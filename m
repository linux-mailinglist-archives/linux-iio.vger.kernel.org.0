Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0240EA7480
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 22:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICUTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 16:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfICUTD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 16:19:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7454421883;
        Tue,  3 Sep 2019 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567541942;
        bh=pytEIm1nyGtG8YLK4WL5/BjtV/AfTKfIT1qFFwkQ+/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJclrCp8+UPOJPx50/p9UjXVZdr/BipK2Vy8poy01bGyck004n9l9/3Ju/9zNyTEz
         ESWY8E8a04uZmzbw3elB+tBdeunGcQA2Reo83vPaQ4jN0BMuRjMkYKutLkO8LPC9lq
         wkfRatTpokxa+PLpmkftZe1yg1JCGJnEFlcgR7Bs=
Date:   Tue, 3 Sep 2019 21:18:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] Second set of new device support, cleanups etc for
 IIO in the 5.4 cycle.
Message-ID: <20190903211858.5ca279f9@archlinux>
In-Reply-To: <20190903191635.GA27105@kroah.com>
References: <20190903193624.170e3c34@archlinux>
        <20190903191635.GA27105@kroah.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 21:16:35 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Sep 03, 2019 at 07:36:24PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> > 
> >   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take2  
> 
> So close, I now have this error:
> 
> In commit
>   9d8568e3d496 ("iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1")
> 
> Fixes tag
>   Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> 
> has these problem(s):
>   - Target SHA1 does not exist
> 
> 
> Third try?

*crosses fingers*. 

Thanks,

J
