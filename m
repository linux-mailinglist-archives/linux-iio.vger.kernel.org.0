Return-Path: <linux-iio+bounces-18389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB83A94973
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C111892A5D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B21D5147;
	Sun, 20 Apr 2025 19:45:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBA2905
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178321; cv=none; b=rjCSqCD1IVs7gSGEIwnG50q/0Wcke73m9B5xnViMwcTM18H6MQIzG8zZKNTqv6lbOd54RMkdZx1XRrStDxT2v2GZqGbncH2WT7N66zK43/UD12pziCv3LF900Nrsb2jnpWUsc7Wkeh5TRfaJ1SvM23G1e4g50mV/aqPC/eM6gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178321; c=relaxed/simple;
	bh=vJdBOf82Iy5iMcvXU5YCcDimg9KUr1N7wqDkB08AQLQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R39j6/cre0bCxNv4n6qIdVtS7trfdPAdTPZViQlMgdT8nLMQGzfFEWVlB+577ARhmFQRfbDSbksCkIkqj8HhjaQfKBDhcOVzfAhq5BchpT786N1YwTI6+386LTB308Xv91cCxiPNj1CQUJOR4FKNA8Ng4/foO2+X/ClTN7dqK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id f826c47b-1e1f-11f0-ac2f-005056bd6ce9;
	Sun, 20 Apr 2025 22:45:12 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 20 Apr 2025 22:45:10 +0300
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
	alisadariana@gmail.com, tgamblin@baylibre.com,
	olivier.moysan@foss.st.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, joao.goncalves@toradex.com,
	tobias.sperling@softing.com, marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com, herve.codina@bootlin.com,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aAVOxhe_VAvMXWRQ@surfacebook.localdomain>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
 <20250416081734.563111-3-j2anfernee@gmail.com>
 <Z_95naiV7zpLokPr@smile.fi.intel.com>
 <CA+4VgcKfDo2NSeBA6+z5AqCeEBds0-DwC0-e3H-bkJ7hEcHaWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+4VgcKfDo2NSeBA6+z5AqCeEBds0-DwC0-e3H-bkJ7hEcHaWw@mail.gmail.com>

Sun, Apr 20, 2025 at 09:03:05PM +0800, Yu-Hsian Yang kirjoitti:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> 於 2025年4月16日 週三 下午5:34寫道：
> > On Wed, Apr 16, 2025 at 04:17:34PM +0800, Eason Yang wrote:

...

> > > +#define NCT7201_REG_VIN(i)                           (i)
> >
> > This doesn't do anything useful. Why do you need this rather useless macro?
> >
> 
> Actually here we should define NCT7201_REG_VIN(i) as (0x00 + i),
> We simply it as (i).

Please, don't. Use the full form which makes a big difference to the perception
of this macro.

...

> > > +struct nct7201_chip_info {
> > > +     struct device *dev;
> >
> > This can be derived from the respective regmap. No need to have it here.
> >
> > > +     struct regmap *regmap;
> > > +     struct regmap *regmap16;
> > > +     int num_vin_channels;
> > > +     u16 vin_mask;
> > > +};
> 
> Use regmap->dev is okay if use regmap API.

No, you are not supposed to use regmap->dev (and you can't), you need to call a
getter API and get the device pointer.

> But if we need to print message not from regmap API,

I don't get this. What do you mean? The example you showed prints a message for
the device. The same device that was used to create a regmap.

> how suggestions to do in this case?

Use the one that you can retrieve from regmap.

...

So, you have commented on some with agreement, and left uncommented a lot. Does
it mean you are agree on all points? The rule of thumb do not comment on the cases
you are fully agree with. Current email just makes a confusion.

-- 
With Best Regards,
Andy Shevchenko



