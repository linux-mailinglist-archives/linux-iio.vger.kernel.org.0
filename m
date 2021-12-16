Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99C547731F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbhLPN3u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbhLPN3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 08:29:50 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C06C061574;
        Thu, 16 Dec 2021 05:29:50 -0800 (PST)
Received: from [81.101.6.87] (port=52572 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxqpQ-0001qe-Co; Thu, 16 Dec 2021 13:29:48 +0000
Date:   Thu, 16 Dec 2021 13:35:12 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Message-ID: <20211216133458.307acea4@jic23-huawei>
In-Reply-To: <20211214165608.7903-3-nuno.sa@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Dec 2021 17:56:07 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> Define the sysfs interface for toggle or dither capable channels. Dither
> capable channels will have the extended interface:
> 
>  * out_voltageY_dither_en
>  * out_voltageY_dither_raw
>  * out_voltageY_dither_raw_available
>  * out_voltageY_dither_frequency
>  * out_voltageY_dither_frequency_available
>  * out_voltageY_dither_phase
>  * out_voltageY_dither_phase_available
> 
> Toggle enabled channels will have:
> 
>  * out_voltageY_toggle_en
>  * out_voltageY_raw1
>  * out_voltageY_symbol
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1

I was thinking more raw0 and raw1 rather than not having the 0 for the
first one.   If someone has the device in a circuit where they want to use
the toggle mode then I'd assume they know about the special ABI and can
cope with this.

> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		It has the same meaning as out_voltageY_raw. This attribute is
> +		specific to toggle enabled channels and refers to the DAC output
> +		code in the INPUT_B register while regular out_voltageY_raw
> +		refers to INPUT_A. The same scale, offset, etc applies.


