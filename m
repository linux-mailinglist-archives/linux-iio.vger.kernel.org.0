Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284718BAE7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfHMN5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 09:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfHMN5A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 09:57:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A11D3206C2;
        Tue, 13 Aug 2019 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565704619;
        bh=xQawURKWXQH+wBIe6TK7PRdByiafBn1Ss3RiNSef+F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8x5W8jtghuEAeBbLq2PhQnWxc+IWw2bW3dF9wl3uxXQ1KDvMbtmaUA/+RHEoqJwp
         QD56bVqlpdHvVzjCF1FY4717ELfgeKZ7E7PPnFv+hZHAkf31/LBBHiY+39b4LuPg+K
         mfMDchO1AsHLSLbb+EZlPXV+0D9daGYw314I5acs=
Date:   Tue, 13 Aug 2019 15:56:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new device support, cleanups and features
 for IIO in the 5.4 cycle.
Message-ID: <20190813135656.GA27392@kroah.com>
References: <20190812210428.1668b6d8@archlinux>
 <20190812205932.GA32616@kroah.com>
 <20190813081419.GA18284@kroah.com>
 <20190813143421.000070c0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813143421.000070c0@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 13, 2019 at 02:34:21PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Aug 2019 10:14:19 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Aug 12, 2019 at 10:59:32PM +0200, Greg KH wrote:
> > > On Mon, Aug 12, 2019 at 09:04:28PM +0100, Jonathan Cameron wrote:  
> > > > The following changes since commit e59fc52529118aaad9aa666f25530dde6e2180e9:
> > > > 
> > > >   staging: rtl8192*: display ESSIDs using %pE (2019-07-25 14:38:52 +0200)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4a  
> > > 
> > > Pulled and pushed out, thanks.  
> > 
> > 0-day gives me the following warning, did you not see this on your tree?
> 
> Looks like my tree was based before the change that enabled the warning
> by default (I didn't check but a quick build shows it doesn't occur with
> iio.git/togreg and does with staging/staging-testing

That compiler isn't "on" yet in our trees, which is why we all missed it
locally.

> I can't actually find any completion message from 0-day so not sure if this
> hit an outage or if I'm not getting the completion messages for some reason.

0-day is being slow/flakey these days :(

> Oops on missing this one in review!

Not a problem, nice to see it's an actual bug :)

thanks,

greg k-h
