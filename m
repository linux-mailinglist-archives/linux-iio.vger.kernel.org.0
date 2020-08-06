Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1814323E01E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHFSFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 14:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgHFSF3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:05:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8982206A2;
        Thu,  6 Aug 2020 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596737128;
        bh=7sDGk0cuRvKpwl0wjGQQORXcJOfy5qUAfrD9AR4suV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qDVKR1Q8SOhlcBYyvzGbAx6d/ZXEhGCx+WAd5yDqWr54rlRGXKe07Parn0LftjmGM
         U6wY6LBST7W8oOx2MwnSWuRvuc0NyXbpnNzc8rv9YKaFdQsilTIptKL7x8+tzyfwEM
         G1y9cQI+//X8o6qkuRmFDV8J39knvZKei+WXxXxw=
Date:   Thu, 6 Aug 2020 19:05:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: iio: adc: maxim,max1118 yaml conversion
Message-ID: <20200806190523.712d2115@archlinux>
In-Reply-To: <20200803215826.GA3211566@bogus>
References: <20200801175850.1140006-1-jic23@kernel.org>
        <20200803215826.GA3211566@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Aug 2020 15:58:26 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, 01 Aug 2020 18:58:50 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple device with a simple conversion.  Special handling needed
> > for the max1118 which is the only supported part that has an external
> > reference voltage.
> > 
> > Cc: Akinobu Mita <akinobu.mita@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2:
> > * Added additionalProperties: false. Other changes are to make this work.
> > * Move the vref-supply definition up
> > * Add an else clause
> > 
> > .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
> >  .../bindings/iio/adc/maxim,max1118.yaml       | 62 +++++++++++++++++++
> >  2 files changed, 62 insertions(+), 21 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Thanks,  

Applied to the togreg branch off iio.git and pushed out as testing for autobuilders
etc.

Jonathan

