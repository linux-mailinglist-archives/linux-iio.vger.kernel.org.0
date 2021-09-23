Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E88415BF0
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhIWKaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 06:30:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3851 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhIWKaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 06:30:46 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HFWXw0ZR4z67YDm;
        Thu, 23 Sep 2021 18:26:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 12:29:12 +0200
Received: from localhost (10.52.121.46) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 11:29:12 +0100
Date:   Thu, 23 Sep 2021 11:28:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Peter Rosin <peda@axentia.se>, <linux-iio@vger.kernel.org>
Subject: Re: Reading ADC that comes from a multiplexer
Message-ID: <20210923112858.000022fa@Huawei.com>
In-Reply-To: <CAOMZO5AQk4zkgwk9ALkaasFv6t68K-bO6roki1tcdgnyk0wuTg@mail.gmail.com>
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
        <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
        <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
        <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
        <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
        <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
        <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
        <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se>
        <CAOMZO5AQk4zkgwk9ALkaasFv6t68K-bO6roki1tcdgnyk0wuTg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Sep 2021 11:50:14 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Peter,
> 
> On Wed, Sep 22, 2021 at 11:28 AM Peter Rosin <peda@axentia.se> wrote:
> 
> > Nice!
> >
> > While I don't completely understand that iio-device node in the beaglebone
> > dts that didn't work for you, it looks like it's just a renumbering thing?  
> 
> The beaglebone dts uses some undocumented properties such as:
> iio-channels and iio-channel-names.

Some of this comes from the dts-schema repo.  We haven't been strict in
adding the entries to individual ADCs until they actually use them - which
has the advantage it gives us a window to think about the of_xlate (see below)

https://github.com/devicetree-org/dt-schema/blob/main/meta-schemas/iio.yaml
Not that it helps much as little in the way of docs in the dt-schema repo.

> 
> > However, your version only remapped 4 channels, and in that case your new
> > iio-device only had those, i.e. 0-3. But the iio-mux was looking for the
> > missing channel 4. Maybe that was why that variant didn't work?  
> 
> Yes, this is where I got confused.
> 
> The stmpe811 has 8 channels. On the apalis board, the first four channels
> (0 to 3) are used for touchscreen. The other 4 channels are for general purpose.
> 
> The ADC that is connected to the MUX is channel 4 (which is the first
> one that is
> free for general usage), so I had to pass:
> 
> io-channels = <&adc0 0>;
> 
> in the mux, instead of  io-channels = <&adc0 4> that I was originally trying.
> 
> and now the mapping is correct and I can read proper voltages when I
> switch the mux.

It's possible to add a translation routine to a given driver to deal with this
sort of case. I guess no one needed on the that driver before + all this
infrastructure post dates that driver.

See the of_xlate callbacks that let you map more obvious numbering to a particular
channel.

We are in an unfortunate mess here, but I'd argue the lack of io-channels entry
in the dt binding should in theory mean no one is using this property (as they
should be verifying against that).  The problem will occur if we have a pre
yaml conversion binding out in the wild with a mux or other consumer.  We could
cross our fingers and fix this now...

Jonathan


> 
> Thanks!
