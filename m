Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB62761A7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWUHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:07:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E312376E;
        Wed, 23 Sep 2020 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600891644;
        bh=l3Vhnjb88U+k8TTKsLndTWj5EF/VpS9Vh43y7zHxXhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DY5rAywGnqT6Fbx98eo2QK+1MhC9imrfkyunMaKvElRHJGWsQ3+XvLLkSNnLHzGqv
         s9oDJi8VMGtZd80HJTwoCC7LVZe+2WdAgG1BsRmCsivmTfUqXBTARKWtlW+ZB19qy7
         ito2mQPqy/pFekpsbJBAC0ofsq0dZYbU6Flx4vBY=
Date:   Wed, 23 Sep 2020 21:07:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/1] dt-bindings:iio:adc:amlogic,meson-saradc yaml
 conversion
Message-ID: <20200923210719.456b940b@archlinux>
In-Reply-To: <CAL_Jsq+-2MA8ych91Ln_sY=VJQtU=muRk9ZtBcRqoTYEOY6ezA@mail.gmail.com>
References: <20200920135436.199003-1-jic23@kernel.org>
        <20200920135436.199003-2-jic23@kernel.org>
        <CAL_Jsq+-2MA8ych91Ln_sY=VJQtU=muRk9ZtBcRqoTYEOY6ezA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 08:08:48 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Sep 20, 2020 at 7:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This binding is non trivial due to the range of different parts
> > supported having several subtle quirks. Martin has helped
> > clarify some of them.
> >
> > Note, I haven't restricted the amlogic,hhi-sysctrl to only
> > be present on the relevant parts if nvmem stuff also is, but
> > it would seem to be rather odd if it were otherwise.
> >
> > Perhaps we look to make this binding more restrictive at a later date.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> >
> > ---
> > Changes since v2
> > (thanks Rob and Martin)
> >   - consistent capitalization
> >   - clock names etc all shared, only the number of them changed dependent
> >     on type.
> >   - missing maxItems for nvmem-cells.
> >
> >  .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
> >  .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
> >  2 files changed, 149 insertions(+), 48 deletions(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.  Thanks,

Jonathan
