Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC313A6DC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgANKO4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 05:14:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732678AbgANKLn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:43 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D06145CAEF7E4A969049;
        Tue, 14 Jan 2020 10:11:41 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 Jan 2020 10:11:41 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 10:11:41 +0000
Date:   Tue, 14 Jan 2020 10:11:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second set of IIO fixes for the 5.5 cycle.
Message-ID: <20200114101140.00003576@Huawei.com>
In-Reply-To: <20200113110639.GA5809@kroah.com>
References: <20200105110051.445c9a95@archlinux>
        <20200113110639.GA5809@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 12:06:39 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jan 05, 2020 at 11:00:51AM +0000, Jonathan Cameron wrote:
> > The following changes since commit c05c403b1d123031f86e65e867be2c2e9ee1e7e3:
> > 
> >   staging: wfx: fix wrong error message (2019-12-18 15:51:06 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.5b  
> 
> I get this check warning when trying to push these:
> 
> Commit: 80d92ea5f865 ("iio: light: vcnl4000: Fix scale for vcnl4040")
> 	Fixes tag: Fixes: 5a441aade5b3 ("light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
> 	Has these problem(s):
> 	        - Subject does not match target commit subject
> 	          Just use
> 		                git log -1 --format='Fixes: %h ("%s")'
> 
> I'll fix this up by hand, but note that this changes the git sha1, so if
> you pull you will see a merge.
> 
> thanks,
> 
> greg k-h

Gah! Sorry about that. I really need to find the time to get scripting setup around
this as trying to remember to check by hand is clearly not working.

Thanks for fixing it up.

Jonathan

