Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E081440A12
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhJ3P57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 30 Oct 2021 11:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhJ3P57 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 11:57:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF1460ED3;
        Sat, 30 Oct 2021 15:55:26 +0000 (UTC)
Date:   Sat, 30 Oct 2021 16:59:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: add adddac subdirectory
Message-ID: <20211030165954.459b978f@jic23-huawei>
In-Reply-To: <PH0PR03MB63660FDDC3504DD4ABD1D76999879@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
        <20211028135608.3666940-1-demonsingur@gmail.com>
        <PH0PR03MB63660FDDC3504DD4ABD1D76999879@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Oct 2021 08:00:05 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi,
> 
> > -----Original Message-----
> > From: Cosmin Tanislav <demonsingur@gmail.com>
> > Sent: Thursday, October 28, 2021 3:56 PM
> > Cc: demonsingur@gmail.com; Tanislav, Cosmin
> > <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; linux-
> > iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH v2 1/3] iio: add adddac subdirectory
> > 
> > [External]
> > 
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > 
> > For IIO devices that expose both ADC and DAC functionality.
> > 
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > ---  
> 
> One thing here that I'm not too sure is the naming of the directory.
> I'm starting to see in ADI more and more of this highly integrated devices... For
> example this one [1], is something we have someone already working one
> and it has ADCs, DAC, amplifiers. So, I'm just wondering if now
> it's not the time where we just have a generic enough place for these kind
> of "combo" devices? Being that said, I have no idea about what name we could
> give :)
> 
> [1]: https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf
> - Nuno Sá

Naming is always fun. I don't want to have combo start picking up IMUs so
we need to be a bit careful.

We could take the approach we have done with proximity and light sensors of effectively
declaring one type to the dominant one.  There it's a bit clearer though - you don't
buy a proximity sensor if you want to just measure light levels.

Here there isn't always a dominant type.  The example here is titled input / output
device so no preference of one over the other.  The GPIO stuff is kind of a feature
bolted on, so ADDAC is generic enough.

For the ad7293 it does call it a Power Amplifiers 'with' the other stuff so maybe
just sticking to amplifier as the type is the way to go. 

Meh, to a certain extent it doesn't matter - we can safely move these around
once we have more of them in the tree.  The adt7316 is still in staging and
is an ADDAC as well so I think we should put that category in for now.

Jonathan

> 
> 

