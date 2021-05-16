Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E1381D85
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhEPJGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 05:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhEPJGg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:06:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D3A610A6;
        Sun, 16 May 2021 09:05:19 +0000 (UTC)
Date:   Sun, 16 May 2021 10:06:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
Message-ID: <20210516100631.7310a7bb@jic23-huawei>
In-Reply-To: <20210516044315.116290-1-liambeguin@gmail.com>
References: <20210516044315.116290-1-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 00:43:13 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> Add a devicetree binding to optionally force a different IIO channel
> type.
> 
> This is useful in cases where ADC channels are connected to a circuit
> that represent another unit such as a temperature or a current.
> 
> `channel-types` was chosen instead of `io-channel-types` as this is not
> part of the iio consumer bindings.
> 
> In the current form, this patch does what it's intended to do:
> change the unit displayed by `sensors`, but feels like the wrong way to
> address the problem.
> 
> Would it be possible to force the type of different IIO channels for
> this kind of use case with a devicetree binding from the IIO subsystem?
> 
> It would be convenient to do it within the IIO subsystem to have the
> right unit there too.
> 
> Thanks for your time,
> Liam

Hi Liam,

+CC Peter for AFE part.

It's an interesting approach, but I would suggest we think about this
a different way.

Whenever a channel is being used to measure something 'different' from
what it actually measures (e.g. a voltage ADC measuring a current) that
reflects their being some analog component involved.
If you look at drivers/iio/afe/iio-rescale.c you can see the approach
we currently use to handle this.

Effectively what you add to devicetree is a consumer of the ADC channel
which in turn provides services to other devices. For this current case
it would be either a current-sense-amplifier or a current-sense-shunt 
depending on what the analog front end looks like.  We have to describe
the characteristics of that front end which isn't something that can
be done via a simple channel type.

That afe consumer device can then provide services to another consumer
(e.g. iio-hwmon) which work for your usecase.

The main limitation of this approach currently is you end up with
one device per channel.  That could be improved upon if you have a usecase
where it matters.

I don't think we currently have an equivalent for temperature sensing
but it would be easy enough to do something similar.

Jonathan


> 
> Liam Beguin (2):
>   hwmon: (iio_hwmon) optionally force iio channel type
>   dt-bindings: hwmon: add iio-hwmon bindings
> 
>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
>  drivers/hwmon/iio_hwmon.c                     |  2 +
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> 
> 
> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717

