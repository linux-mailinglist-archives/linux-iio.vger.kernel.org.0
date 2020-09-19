Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654DD270E66
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgISOHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOHf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:07:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03452207FB;
        Sat, 19 Sep 2020 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524455;
        bh=B6jcFgjfYLGUTWDpaxjq/Ri7kxd0yJ6bJmoZ32PBNus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AnUp/wcgEA7XJPyzXVn6O+rFhw7ANtl1L5vZdkfvKNBxnjj/GfW65187NJ/hPPUNa
         87io0Z0jV1iRosod7FW7BscyBQ/Ec9SzWkInqzUq5OuEJzlV5RISL25vTJqjhDJdXA
         tdf602+kYsuSDX++JghKfjZ/comLMGOEmbO86YZM=
Date:   Sat, 19 Sep 2020 15:07:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Phani Movva <Phani.Movva@imgtec.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 13/20] dt-bindings:iio:adc:cosmic,10001-adc yaml
 conversion
Message-ID: <20200919150730.24b24024@archlinux>
In-Reply-To: <20200915191317.GA2333547@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-14-jic23@kernel.org>
        <20200915191317.GA2333547@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:13:17 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:39 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > I don't really know much about this one, hence the binding is
> > a simple conversion of what was in the txt file.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Phani Movva <Phani.Movva@imgtec.com>
> > ---
> >  .../bindings/iio/adc/cc10001_adc.txt          | 22 -------
> >  .../bindings/iio/adc/cosmic,10001-adc.yaml    | 59 +++++++++++++++++++
> >  2 files changed, 59 insertions(+), 22 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
For this one. I don't have an address for Phani Movva that works so
I have listed myself as maintainer for the binding until someone else
steps up.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to possibly poke at it.

Thanks,

Jonathan

