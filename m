Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89798270EBA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgISPBX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgISPBW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:01:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B552208B8;
        Sat, 19 Sep 2020 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600527682;
        bh=U1U+UK/bW7H76oSzR8KME12lohxaCPUKyAaXfRdIVS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JVl6ebwIWJkZk3Zuq4Oc5sioqWBwzNZ07G/OAz2yMh6PyzMOYKvv80UUiJRMLLijT
         LNTPK2W+aLodF8sUJ7lI8PGqrtTPSTX0tBgArB5dBmaGjTNszzbSFNvs0nNlGpo6hk
         ZydiIbItKDLCzqH0jD/YgN/bcfIknB/NhvIaWWlk=
Date:   Sat, 19 Sep 2020 16:01:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 15/20] dt-bindings:iio:adc:ad7768-1 yaml conversion
Message-ID: <20200919160118.57da12da@archlinux>
In-Reply-To: <20200915191505.GA2336645@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-16-jic23@kernel.org>
        <20200915191505.GA2336645@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:15:05 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:41 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fairly straight conversion.  The one oddity in the original binding
> > is that spi-cpha and spi-cpol were not marked as required, but were
> > in the example.  Looking at the datasheet, there isn't any documented
> > flexibility in the possible SPI modes, so I have moved these to requires.
> > For spi-max-frequency I have gone the other way.  I absolutely agree
> > that it is good to specify this in the dt-binding, but it's not
> > strictly required.
> > 
> > As Stefan's email is bouncing I have gone with Michael as maintainer
> > of this one as it falls under the ADI catch all entry in MAINTAINERS.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.txt         | 41 ---------
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 89 +++++++++++++++++++
> >  2 files changed, 89 insertions(+), 41 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied,  thanks,

Jonathan

