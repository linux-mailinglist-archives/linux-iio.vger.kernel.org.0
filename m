Return-Path: <linux-iio+bounces-14249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA04A0AAFD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C481D3A3215
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBED1BE871;
	Sun, 12 Jan 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c115Eg/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9320DF4;
	Sun, 12 Jan 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736700015; cv=none; b=QosrPE2Wrul200jX+sq3m2hV5qise/NpAd44QOsXPPP3UQwl92ihJWBHksIrqnKNSHbccWBemdIs1lbhUtD5jIblotNs7Z0snsMG21jyLjSAOKKAY2PtcQX8sdR26Idsce+bAH8Q6W9rx2edLXPoirwgoNTspsiqEH8S6MoVcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736700015; c=relaxed/simple;
	bh=DD/juU9ACGWt0ccBf3GuJZuORc/SZlbw19veSmxGX5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uysAeBw+H7qViyeeqe6xKWSS5PvjbiEDB8bJ63UwVcMg6Gj8SXGMmq8Rm9RCEdktIgzSSVnJMdcNwLQdQj17OohZnqG2iD6lejbCvVd8amhwwrxTgVt1YD4K1fTcrf8HxiWd+Tr/foAYdwsI552IVwSt0vAG2UqjbjhjdrlrkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c115Eg/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC93C4CEDF;
	Sun, 12 Jan 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736700014;
	bh=DD/juU9ACGWt0ccBf3GuJZuORc/SZlbw19veSmxGX5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c115Eg/yj0CcRohHCi7W88LmrSaMZ4tksgmPPbo6nxRFIa2newQjb4Fo5/YHeiyYB
	 YjZfoePuYNhmkG0dU8OV2rstcnnu4ZGdOTDoKAZXtozew/q+GGjLGoONQyLGQ0jFGc
	 e16AHU9CeN8DWhvsNOWHgBYJU5f+jOeUCylVcIIJ5ACwb6XZ3fG45mIvp1238LkKRo
	 XYVU89GATy8ZnQMdCAkXn+KWIu/pV2xp3EBGQCQPGUi0NeayjQObThfQPjwXdlTY7H
	 9SFAxiyUmEbpLCb+oyVWdK/RxUq7AM+QhtvilOs75igT8rdwgqypO3VSCIaCIs/ly2
	 xkLsBH/yndv7A==
Date: Sun, 12 Jan 2025 16:40:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: light: veml6030: extend regmap to support
 regfields and caching
Message-ID: <20250112164006.218cf045@jic23-huawei>
In-Reply-To: <D705L20050OB.3UOW9R2QA4QA5@gmail.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
	<20250107-veml6030-scale-v1-1-1281e3ad012c@gmail.com>
	<20250112131845.539ecc7c@jic23-huawei>
	<D705L20050OB.3UOW9R2QA4QA5@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 15:10:14 +0100
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Sun Jan 12, 2025 at 2:18 PM CET, Jonathan Cameron wrote:
> > On Tue, 07 Jan 2025 21:50:21 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >  
> > > The configuration registers are not volatile and are not affected
> > > by read operations (i.e. not precious), making them suitable to be
> > > cached in order to reduce the number of accesses to the device.
> > >
> > > Add support for regfields as well to simplify register operations,
> > > taking into account the different fields for the veml6030/veml7700 and
> > > veml6035.
> > >
> > > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > > ---
> > >  drivers/iio/light/veml6030.c | 141 +++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 116 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> > > index 9b71825eea9bee2146be17ed2f30f5a8f7ad37e3..a6385c6d3fba59a6b22845a3c5e252b619faed65 100644
> > > --- a/drivers/iio/light/veml6030.c
> > > +++ b/drivers/iio/light/veml6030.c
> > > @@ -65,6 +65,11 @@ enum veml6030_scan {
> > >  	VEML6030_SCAN_TIMESTAMP,
> > >  };
> > >
> > > +struct veml6030_rf {
> > > +	struct regmap_field *it;
> > > +	struct regmap_field *gain;
> > > +};
> > > +
> > >  struct veml603x_chip {
> > >  	const char *name;
> > >  	const int(*scale_vals)[][2];
> > > @@ -75,6 +80,7 @@ struct veml603x_chip {
> > >  	int (*set_info)(struct iio_dev *indio_dev);
> > >  	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
> > >  	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
> > > +	int (*regfield_init)(struct iio_dev *indio_dev);  
> >
> > With only two fields, why use a callback rather than just adding the two
> > const struct reg_field into this structure directly?  
> 
> The rationale was that extending the driver for more devices with
> additional fields would not require extra elements in the struct that
> would only apply to some devices. All members of this struct are rather
> basic and all devices will require them, and although integration time
> and gain regfields will be required too, if a new regfield for a
> specific device is added, it will be added to the rest as empty element.
> 
> But that's probably too much "if" and "would", so I am fine with your
> suggestion.

Absolutely - it is in kernel stuff so we can always revisit if it turns
out to make more sense this way.

> 
> >
> > I'd also be tempted to do the caching and regfield changes as separate patches.
> >  
> 
> Then I will split the patch for v2.
> 
> > Jonathan  
> 
> Thank you for your feedback and best regards,
> Javier Carrasco


