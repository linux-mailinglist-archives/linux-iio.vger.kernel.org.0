Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBA432FBE
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhJSHk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJSHk0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 03:40:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B12660FD9;
        Tue, 19 Oct 2021 07:38:13 +0000 (UTC)
Date:   Tue, 19 Oct 2021 08:42:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V3] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <20211019084227.475ecdb0@jic23-huawei>
In-Reply-To: <YW5v6OPgC84X73Qg@kroah.com>
References: <20211018192351.39245b42@jic23-huawei>
        <YW5v6OPgC84X73Qg@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 09:12:40 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Oct 18, 2021 at 07:23:51PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > 
> >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-take3  
> 
> Almost :(
> 
> I get the following error from my scripts:
> 
> Commit: 4862202a0171 ("dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg")
> 	Fixes tag: Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
> 	Has these problem(s):
> 	        - empty lines surround the Fixes tag
> 
> Also, there was a merge conflict in drivers/iio/adc/aspeed_adc.c, but
> that was easy for me to resolve.
> 
> thanks,
> 
> greg k-h

Sigh.

The version of your scripts I have doesn't check for that particular one.
Anywhere I can get a newer version from?

V4 sent out. *crosses fingers*  Naturally the commit above was early
in the series so I had to fix all the other fixes tags again.

Thanks,

Jonathan
