Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0877A46008D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhK0Rh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhK0Rf0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:35:26 -0500
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Nov 2021 09:32:11 PST
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E1C061574;
        Sat, 27 Nov 2021 09:32:11 -0800 (PST)
Received: from [81.101.6.87] (port=48008 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mr1Q3-000560-5D; Sat, 27 Nov 2021 17:23:27 +0000
Date:   Sat, 27 Nov 2021 17:28:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211127172646.22848575@jic23-huawei>
In-Reply-To: <20211123115336.65827-1-antoniu.miclaus@analog.com>
References: <20211123115336.65827-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 13:53:34 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

Clearly you are exploring new territory here so thanks for persisting and
I think we are getting close to where we want to be with this.


Other than one question over whether the generated ABI using
extinfo matches what you have in the docs, the remaining changes are all ABI
/ dt binding review related which will have impacts in here as well.

hmm. Side note, my kernel.org email is blocking for some reason so sending
using a different account. Hopefully it will make it!

> +
> +#define _ADMV1013_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1013_read, \
> +		.write = admv1013_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_enum admv1013_mode_enum = {
> +	.items = admv1013_modes,
> +	.num_items = ARRAY_SIZE(admv1013_modes),
> +	.get = admv1013_get_mode,
> +	.set = admv1013_set_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
> +	_ADMV1013_EXT_INFO("i", IIO_SEPARATE, ADMV1013_RFMOD_I),
> +	_ADMV1013_EXT_INFO("q", IIO_SEPARATE, ADMV1013_RFMOD_Q),
> +	IIO_ENUM("freq_mode", IIO_SHARED_BY_ALL, &admv1013_mode_enum),
> +	IIO_ENUM_AVAILABLE("freq_mode", IIO_SHARED_BY_ALL, &admv1013_mode_enum),
> +	{ },
> +};
> +
> +#define ADMV1013_CHAN_PHASE(_channel, _channel2, _admv1013_ext_info) {		\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel2 = _channel2,					\
> +	.channel = _channel,					\
> +	.differential = 1,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE),		\
> +	.ext_info = _admv1013_ext_info,				\
> +	}
> +
> +#define ADMV1013_CHAN_CALIB(_channel, _admv1013_ext_info) {\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE),		\

This has me a little confused.  How do these map to the
0-1_phase_i etc that you have in the ABI docs?
Unless I'm completely forgetting how this works this will give us
one attribute for phase and another one for _i

Perhaps it's worth providing a sysfs directory listing for this one
given it's rather unusual.

> +	.ext_info = _admv1013_ext_info,				\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] = {
> +	ADMV1013_CHAN_PHASE(0, 1, admv1013_ext_info),
> +	ADMV1013_CHAN_CALIB(0, admv1013_ext_info),
> +	ADMV1013_CHAN_CALIB(1, admv1013_ext_info),
> +};
> +


