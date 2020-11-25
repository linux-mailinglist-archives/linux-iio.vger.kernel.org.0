Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289E82C46AC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgKYRZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 12:25:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2151 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgKYRZv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 12:25:51 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ch76D0GKvz67HP6;
        Thu, 26 Nov 2020 01:24:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 25 Nov 2020 18:25:49 +0100
Received: from localhost (10.52.126.32) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 25 Nov
 2020 17:25:48 +0000
Date:   Wed, 25 Nov 2020 17:25:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL V2] 2nd set of IIO fixes for 5.9
Message-ID: <20201125172532.00002342@Huawei.com>
In-Reply-To: <20200922163747.GA2322802@kroah.com>
References: <20200922134018.064157eb@archlinux>
        <20200922163747.GA2322802@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.32]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 18:37:47 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Sep 22, 2020 at 01:40:18PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> > 
> >   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b-take2  
> 
> Pulled and pushed out, thanks.
> 
> greg k-h
Thanks!

I managed to tag a slightly earlier commit than intended, but no
harm done beyond a few things in the tag description that weren't actually
in the pull. (some yaml conversions).

The remaining patches will come in the next pull request.

Thanks,

Jonathan
