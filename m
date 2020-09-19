Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0960270EB6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgISO7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgISO7O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:59:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463962075A;
        Sat, 19 Sep 2020 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600527554;
        bh=oSzEfu0jqQUWF0q6QUFdcAmM62WZ0nbJ3x4eWqSsLqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E1AfXUuBGW6kl7Q3Ifa+Gsfq7Ys6AzHFeU+3XHrX8z5N+gUPPp+Ulgb5mJXoNLz/Y
         PW3hp91SadFQsprTTP0ucljR9vT3Np9bQgsh42kOV38w+QYTfVhTeNj810/oG7001x
         iAvFWvYGHtLv+rfbL6rSmXny3r1nGqbjIcm5LQtU=
Date:   Sat, 19 Sep 2020 15:59:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 14/20] dt-bindings:iio:adc:adi,ad7949 yaml conversion
Message-ID: <20200919155910.759ad750@archlinux>
In-Reply-To: <20200915191350.GA2334565@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-15-jic23@kernel.org>
        <20200915191350.GA2334565@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:13:50 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:40 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple SPI driver. I've added the #io-channel-cells
> > as an optional parameter to allow use of this device as a provider
> > of ADC capabilities to other devices.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ad7949.txt    | 16 ------
> >  .../bindings/iio/adc/adi,ad7949.yaml          | 57 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 16 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied,

Thanks,

Jonathan

