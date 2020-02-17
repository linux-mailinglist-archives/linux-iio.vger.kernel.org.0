Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582E1161984
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2020 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBQSQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 13:16:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729850AbgBQSQV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Feb 2020 13:16:21 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A369C27816D817E11BC4;
        Mon, 17 Feb 2020 18:16:17 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Feb 2020 18:16:17 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 18:16:16 +0000
Date:   Mon, 17 Feb 2020 18:16:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dylan Howey <Dylan.Howey@tennantco.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200217181613.000057d2@Huawei.com>
In-Reply-To: <20200217141902.GA31535@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
        <20200208163154.4d4f6752@archlinux>
        <20200213220407.GA11762@tennantco.com>
        <20200214132400.7133bcf5@archlinux>
        <20200217141902.GA31535@tennantco.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Feb 2020 08:19:08 -0600
Dylan Howey <Dylan.Howey@tennantco.com> wrote:

> On 02/14/2020 13:24, Jonathan Cameron wrote:
> > So ideally we'd get someone at Freescale to confirm there is a hardware
> > rather than a documentation issue (i.e. maybe we need some other magic).  
> I'll try that route first. I have an NXP contact.
> 
> > If they do we probably need to avoid breaking them so would need a module
> > parameter to be 'enable temp' rather than the more natural option
> > of 'disable temp' to be set only by people who need the highest
> > frequency.  
> That's what I had in mind.
> 
> > The question is whether anyone actually cares about 800Hz?  
> I have a use case for this. I'm doing some data logging with this hardware
> and a higher sample rate is always better.
> 
> By the way, this hardware has a fifo that the driver isn't using. I might
> add support for that. Currently I'm trying to log and getting hammered with
> an 800Hz interrupt and that is causing some issues.

Yeah.  Those sorts of rates tend to get tricky without using hardware
fifos.  Great if you can add support.

Thanks,

Jonathan

> 


