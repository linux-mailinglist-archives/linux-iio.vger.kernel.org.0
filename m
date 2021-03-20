Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6A34D42F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2PnR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Mar 2021 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhC2Pmy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 11:42:54 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F557C061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 08:42:54 -0700 (PDT)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 903089E0183;
        Mon, 29 Mar 2021 16:42:50 +0100 (BST)
Date:   Sat, 20 Mar 2021 18:26:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
Subject: Re: iio: adc: anyone working on TI ADS7066?
Message-ID: <20210320182609.5e4e7f3c@jic23-huawei>
In-Reply-To: <20210320035234.GA95301@x1>
References: <20210320035234.GA95301@x1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 20:52:34 -0700
Drew Fustini <drew@beagleboard.org> wrote:

> I have a board with a TI ADS7066 8-channel ADC [1] that I want to get
> working in Linux.  I see there is already driver support in iio for
> ADS1015, ADS79xx, ADS8344, ADS868x and ADS124S0x.
> 
> Is anyone already working with the ADS7066 or a similar part in that
> series?
> 
> If not, I'll take one of the existing TI drivers as a template for the
> ADS7066 driver.
> 
> Thank you,
> Drew

Hi Drew,

I've not seen anything for this part.

From a 10 second glance at the data sheet I see it's capable of
ADC / GPIO on each pin.   If you plan to support that functionality
at somepoint make sure to define dt bindings and similar to specify
which channels are enabled and dynamically create the iio_chan_spec
array to match.  It can be a bit ugly to retrofit later.

Oh. It does daisy chaining as well. That is always fun to support
though I guess you may well not have it wired up to do that.
Oversampling as well - though that looks nice and simple for once.

Jonathan


> 
> [1] https://www.ti.com/product/ADS7066
> 
> 

