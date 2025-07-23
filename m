Return-Path: <linux-iio+bounces-21921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B76B0F75F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CAA1C85391
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52A2E370E;
	Wed, 23 Jul 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIPQID/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB052F5B;
	Wed, 23 Jul 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285589; cv=none; b=oJfX7i16cpHE0+HMSUMioeP/q1bfMqILta3MmdwyS26lB8XKzU9jmx4eKoJz0gbre49sTxwzuTt+nebRvk2Yo6Y7N241vyxGSr1lzuFKHwXT925Y+IXpfVOyBiH88y4mqHvl94jhc1NO33k/KdH2i0AIaBFMPA+av7Hwa2RG/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285589; c=relaxed/simple;
	bh=dUv9MMs+noEA7xGItL464cy1D/uXEdHuPgyb+EuaOXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv3cvTGClOYrdNJf1DTmgVxRidZ3GGl+y3HZT4xgk6Jn/Y9zqnAfXTc7jiU2NtGDpTKez/EugoBhOvWKnYbI50COPau04W0F8LF0ta6qXPpe2sEPpBB/5uypnGHEJ3SJ7j+39HfDeXVYh/kMCMcewLXntPI0JuoYaT7sW/8lPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIPQID/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D05AC4CEE7;
	Wed, 23 Jul 2025 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285588;
	bh=dUv9MMs+noEA7xGItL464cy1D/uXEdHuPgyb+EuaOXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIPQID/v+JLi1Hn/FGdTWCwqcrod9WrT9VT1Rhc4LOSj6MiYRovkiuWhqvh3OBI6F
	 v8EkzCnIhPbHH/iRauA4t0BNdWXIquR8zUUHf37ryFTdS8EuPaukMp0K3CyIWEfd40
	 7/OdBU31UM2pdppbZTLFUkVNXJNzXajR2FOZoAZXErwKxwB5YXux59H4KE3h3khxBL
	 Vus2xrvFV4bE0QYHLLFHy/jj2u4CSoVVmGcZK3bAs/ewo6aQn5J0ScIpYzEjrh3Em4
	 I1Zy/IhjfVscQfPfOd5GPYlssNIY9xgA3tNjm5I2yQtWCLlEQ/UieHhXQtqvRPOUpP
	 sd+Fci+VMggjA==
Date: Wed, 23 Jul 2025 16:46:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add debugfs register access support
Message-ID: <20250723164620.5ed508f9@jic23-huawei>
In-Reply-To: <4cb1a608-a069-450c-8962-7966259d97a8@baylibre.com>
References: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
	<4cb1a608-a069-450c-8962-7966259d97a8@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 09:13:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/23/25 6:46 AM, Akshay Jindal wrote:
> > Add support for debugfs_reg_access through the driver's iio_info structure
> > to enable low-level register read/write access for debugging.
> > 
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> > ---
> > Testing details:
> > ================  
> > -> Tested on Raspberrypi 4B. Follow for more details.  
> >   
> 
> ...
> 
> >  drivers/iio/light/ltr390.c | 99 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 89 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> > index ee59bbb8aa09..1f6ee0fd6d19 100644
> > --- a/drivers/iio/light/ltr390.c
> > +++ b/drivers/iio/light/ltr390.c
> > @@ -38,12 +38,20 @@
> >  #define LTR390_ALS_UVS_GAIN		0x05
> >  #define LTR390_PART_ID			0x06
> >  #define LTR390_MAIN_STATUS		0x07
> > -#define LTR390_ALS_DATA			0x0D
> > -#define LTR390_UVS_DATA			0x10
> > +#define LTR390_ALS_DATA_0		0x0D
> > +#define LTR390_ALS_DATA_1		0x0E
> > +#define LTR390_ALS_DATA_2		0x0F
> > +#define LTR390_UVS_DATA_0		0x10
> > +#define LTR390_UVS_DATA_1		0x11
> > +#define LTR390_UVS_DATA_2		0x12
> >  #define LTR390_INT_CFG			0x19
> >  #define LTR390_INT_PST			0x1A
> > -#define LTR390_THRESH_UP		0x21
> > -#define LTR390_THRESH_LOW		0x24
> > +#define LTR390_THRESH_UP_0		0x21
> > +#define LTR390_THRESH_UP_1		0x22
> > +#define LTR390_THRESH_UP_2		0x23
> > +#define LTR390_THRESH_LOW_0		0x24
> > +#define LTR390_THRESH_LOW_1		0x25
> > +#define LTR390_THRESH_LOW_2		0x26
> >  
> >  #define LTR390_PART_NUMBER_ID		0xb
> >  #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
> > @@ -98,11 +106,62 @@ struct ltr390_data {
> >  	int int_time_us;
> >  };
> >  
> > +static bool ltr390_is_readable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case LTR390_MAIN_CTRL:
> > +	case LTR390_ALS_UVS_MEAS_RATE:
> > +	case LTR390_ALS_UVS_GAIN:
> > +	case LTR390_PART_ID:
> > +	case LTR390_MAIN_STATUS:
> > +	case LTR390_ALS_DATA_0:
> > +	case LTR390_ALS_DATA_1:
> > +	case LTR390_ALS_DATA_2:
> > +	case LTR390_UVS_DATA_0:
> > +	case LTR390_UVS_DATA_1:
> > +	case LTR390_UVS_DATA_2:
> > +	case LTR390_INT_CFG:
> > +	case LTR390_INT_PST:
> > +	case LTR390_THRESH_UP_0:
> > +	case LTR390_THRESH_UP_1:
> > +	case LTR390_THRESH_UP_2:
> > +	case LTR390_THRESH_LOW_0:
> > +	case LTR390_THRESH_LOW_1:
> > +	case LTR390_THRESH_LOW_2:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool ltr390_is_writeable_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case LTR390_MAIN_CTRL:
> > +	case LTR390_ALS_UVS_MEAS_RATE:
> > +	case LTR390_ALS_UVS_GAIN:
> > +	case LTR390_INT_CFG:
> > +	case LTR390_INT_PST:
> > +	case LTR390_THRESH_UP_0:
> > +	case LTR390_THRESH_UP_1:
> > +	case LTR390_THRESH_UP_2:
> > +	case LTR390_THRESH_LOW_0:
> > +	case LTR390_THRESH_LOW_1:
> > +	case LTR390_THRESH_LOW_2:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}  
> 
> Using rd_table and wr_table is a bit more compact than readable_reg
> writeable_reg.

Or given a lot of these are ranges of related registers you could use
ranges
	switch (reg) {
	case LTR390_MAIN_CTRL:
	case LTR390_ALS_UVS_MEAS_RATE:
	case LTR390_ALS_UVS_GAIN:
	case LTR390_INT_CFG:
	case LTR390_INT_PST:
	case LTR390_THRESH_UP_0 ... LTR390_THRESH_UP_2:
	case LTR390_THRESH_LOW_0 ... LTR390_THRESH_LOW_2:
		return true;

(with macros as Andy suggested)
	}




