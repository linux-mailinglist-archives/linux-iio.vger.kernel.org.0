Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89699274217
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 14:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVMbc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 08:31:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2911 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbgIVMbb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 08:31:31 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9DF169E53D806C3CC4B8;
        Tue, 22 Sep 2020 13:31:30 +0100 (IST)
Received: from localhost (10.52.121.155) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 22 Sep
 2020 13:31:30 +0100
Date:   Tue, 22 Sep 2020 13:29:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] 2nd set of IIO fixes for 5.9
Message-ID: <20200922132951.000035e1@Huawei.com>
In-Reply-To: <20200922075717.GA1797611@kroah.com>
References: <20200920190349.2732d4e8@archlinux>
        <20200922075717.GA1797611@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.155]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 09:57:17 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Sep 20, 2020 at 07:03:49PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> > 
> >   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b
> > 
> > for you to fetch changes up to 888f7cdc893a67d556187b12f40c9e9710ec1c99:
> > 
> >   iio: adc: qcom-spmi-adc5: fix driver name (2020-09-20 18:26:44 +0100)  
> 
> {sigh}
> 
> Commit: 888f7cdc893a ("iio: adc: qcom-spmi-adc5: fix driver name")
> 	Fixes tag: Fixes: e13d757279 ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> 	Has these problem(s):
> 	        - SHA1 should be at least 12 digits long
> 	          Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> 	          or later) just making sure it is not set (or set to "auto").
> 
> I recommend going and installing the scripts...

Have done, though "naturally" didn't run them on this existing pull. Sigh.  Will resend shortly.

Jonathan

> 
> thanks,
> 
> greg k-h


