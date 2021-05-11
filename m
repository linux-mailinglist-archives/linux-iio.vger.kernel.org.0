Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E737A88A
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEKOKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhEKOKS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 10:10:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F81613F7;
        Tue, 11 May 2021 14:09:07 +0000 (UTC)
Date:   Tue, 11 May 2021 15:10:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Message-ID: <20210511151014.3d9d6768@jic23-huawei>
In-Reply-To: <91258724-09cc-ed39-2277-6fbcca0c53e9@redhat.com>
References: <20210511095409.9290-1-stephan@gerhold.net>
        <91258724-09cc-ed39-2277-6fbcca0c53e9@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 12:44:23 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 5/11/21 11:54 AM, Stephan Gerhold wrote:
> > KX023-1025 [1] is another accelerometer from Kionix that has lots
> > of additional functionality compared to KXCJK-1013. It combines the
> > motion interrupt functionality from KXCJK with the tap detection
> > from KXTF9, plus a lot more other functionality.
> > 
> > This patch set does not add support for any of the extra functionality,
> > but makes basic functionality work with the existing kxcjk-1013 driver.
> > 
> > At first, the register map for the KX023-1025 seems quite different
> > from the other accelerometers supported by the kxcjk-1013.
> > However, it turns out that at least most of the register bits
> > still mean the same for KX023-1025.
> > 
> > This patch set refactors the kxcjk-1013 driver a little bit
> > to get the register addresses from a chip-specific struct.
> > The register bits can be re-used for all the different chips.
> > 
> > The KX023-1025 is used in several smartphones from Huawei.
> > I tested these changes on a Huawei Ascend G7, someone else reported
> > they also work fine on the Huawei Honor 5X (codename "kiwi").
> > 
> > [1]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
> > 
> > Stephan Gerhold (3):
> >   dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
> >   iio: accel: kxcjk-1013: Refactor configuration registers into struct
> >   iio: accel: kxcjk-1013: Add support for KX023-1025  
> 
> Thanks, the entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 

Other than those things 0-day found which would be good to tidy up for a v2
looks good to me.

Thanks,

Jonathan

> for the series.
> 
> Regards,
> 
> Hans
> 

