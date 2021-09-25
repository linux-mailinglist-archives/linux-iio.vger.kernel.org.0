Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C584182BA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbhIYOaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 10:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYOai (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 10:30:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E1F6108E;
        Sat, 25 Sep 2021 14:29:02 +0000 (UTC)
Date:   Sat, 25 Sep 2021 15:32:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org
Subject: Re: Reading ADC that comes from a multiplexer
Message-ID: <20210925153251.20776333@jic23-huawei>
In-Reply-To: <CAOMZO5D1gt6tFhHzTALGFAs8Zt3aBbanw0Sz93AmWHwcnCvHSQ@mail.gmail.com>
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
        <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
        <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
        <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
        <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
        <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
        <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
        <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se>
        <CAOMZO5AQk4zkgwk9ALkaasFv6t68K-bO6roki1tcdgnyk0wuTg@mail.gmail.com>
        <20210923112858.000022fa@Huawei.com>
        <CAOMZO5D1gt6tFhHzTALGFAs8Zt3aBbanw0Sz93AmWHwcnCvHSQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 11:41:38 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
> 
> On Thu, Sep 23, 2021 at 7:29 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> 
> > > The beaglebone dts uses some undocumented properties such as:
> > > iio-channels and iio-channel-names.  
> >
> > Some of this comes from the dts-schema repo.  We haven't been strict in
> > adding the entries to individual ADCs until they actually use them - which
> > has the advantage it gives us a window to think about the of_xlate (see below)
> >
> > https://github.com/devicetree-org/dt-schema/blob/main/meta-schemas/iio.yaml  
> 
> On this document, we have "io-channels" and "io-channel-names.
> 
> What I wanted to say is that in
> arch/arm/boot/dts/am5729-beagleboneai.dts we have:
> 
> "iio-channels" and "iio-channel-names" (Note the 'iio' versus 'io').
> 
> This is what I mentioned as undocumented properties.
> 
> Maybe I can send a patch fixing it.
Ah!  Got you.  That definitely seems wrong so a fix would be welcome.

Thanks,

Jonathan

> 
> On my imx6 board all is working fine now.
> 
> Thanks,
> 
> Fabio Estevam

