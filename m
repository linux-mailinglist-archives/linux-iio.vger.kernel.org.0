Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC68BA64
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 15:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfHMNeh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 09:34:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbfHMNeh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 09:34:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4202F1B0A1A224276374;
        Tue, 13 Aug 2019 21:34:32 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 21:34:30 +0800
Date:   Tue, 13 Aug 2019 14:34:21 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] First set of new device support, cleanups and features
 for IIO in the 5.4 cycle.
Message-ID: <20190813143421.000070c0@huawei.com>
In-Reply-To: <20190813081419.GA18284@kroah.com>
References: <20190812210428.1668b6d8@archlinux>
        <20190812205932.GA32616@kroah.com>
        <20190813081419.GA18284@kroah.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Aug 2019 10:14:19 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Aug 12, 2019 at 10:59:32PM +0200, Greg KH wrote:
> > On Mon, Aug 12, 2019 at 09:04:28PM +0100, Jonathan Cameron wrote:  
> > > The following changes since commit e59fc52529118aaad9aa666f25530dde6e2180e9:
> > > 
> > >   staging: rtl8192*: display ESSIDs using %pE (2019-07-25 14:38:52 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4a  
> > 
> > Pulled and pushed out, thanks.  
> 
> 0-day gives me the following warning, did you not see this on your tree?

Looks like my tree was based before the change that enabled the warning
by default (I didn't check but a quick build shows it doesn't occur with
iio.git/togreg and does with staging/staging-testing

I can't actually find any completion message from 0-day so not sure if this
hit an outage or if I'm not getting the completion messages for some reason.

Oops on missing this one in review!

> 
> Can you send me a patch to fix this up?

On it's way.

Jonathan

> 
> thanks,
> 
> greg k-h
> 
> ----------------
> tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/staging.git  staging-testing
> branch HEAD: 6aed51d8912460cab375f7fc4ea834851e107b7a  Merge tag 'iio-for-5.4a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
> 
> Regressions in current branch:
> 
> drivers/iio/light/noa1305.c:87:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> 


