Return-Path: <linux-iio+bounces-3714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09E1887A5A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 21:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC972820ED
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B493A29B;
	Sat, 23 Mar 2024 20:44:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436451DFEF
	for <linux-iio@vger.kernel.org>; Sat, 23 Mar 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226687; cv=none; b=XW31EWxfmw2AemU6Isn8i0oUm0omTcq+n4no0v6Va6l3SWjfPmT8X+cqKazjH0yaMUBWPNhP47t5aKvx3swc6aBK4QWmw+IdtTjZZKfD0Pkb0dW7yXtB9k+YISC6fe75zAiKTbmuixxzm6FS/K4Sg98cV+gTHpYuFMVBJuuY8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226687; c=relaxed/simple;
	bh=4cn7e1ZNgP9JRFS2MR28C3me8UKkrRDxTuHIiMG8WD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ubAwY3AY5XBcorM6YEEIHFtc1Opyq9hVpePNWoB4lPL3BAwkXkU//JTwbjdD/CAjIKovYfMkY6KQU3w1omhPlfhtziSZlh+/iUNEiTBKUNejoP6bNUgRCLY3bAeeVvF9ho/KIny3JuJ1YnvXWAs7It9dL6EANDlEWoX0FhIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 29c2437a-e956-11ee-abf4-005056bdd08f;
	Sat, 23 Mar 2024 22:44:37 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Mar 2024 22:44:37 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <Zf8_NZ5cNb9TVThx@surfacebook.localdomain>
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
 <CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
 <CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
 <20240323182918.2cf624b6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240323182918.2cf624b6@jic23-huawei>

Sat, Mar 23, 2024 at 06:29:18PM +0000, Jonathan Cameron kirjoitti:
> On Tue, 19 Mar 2024 10:28:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> > On Tue, Mar 19, 2024 at 10:01 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Mar 19, 2024 at 4:28 PM David Lechner <dlechner@baylibre.com> wrote:  

...

> > > > +       ret = device_property_match_property_string(dev, "adi,spi-mode",
> > > > +                                                   ad7944_spi_modes,
> > > > +                                                   ARRAY_SIZE(ad7944_spi_modes));
> > > > +       if (ret < 0) {
> > > > +               if (ret != -EINVAL)
> > > > +                       return dev_err_probe(dev, ret,
> > > > +                                            "getting adi,spi-mode property failed\n");  
> > >  
> > > > -               adc->spi_mode = ret;
> > > > -       } else {  
> > >
> > > Actually we may even leave these unchanged
> > >  
> > > >                 /* absence of adi,spi-mode property means default mode */
> > > >                 adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> > > > +       } else {
> > > > +               adc->spi_mode = ret;
> > > >         }  
> > >
> > >        ret = device_property_match_property_string(dev, "adi,spi-mode",
> > >                                                    ad7944_spi_modes,
> > >
> > > ARRAY_SIZE(ad7944_spi_modes));
> > >        if (ret >= 0) {
> > >                adc->spi_mode = ret;
> > >        } else if (ret != -EINVAL) {
> > >                        return dev_err_probe(dev, ret,
> > >                                             "getting adi,spi-mode
> > > property failed\n");
> > >        } else {
> > >                /* absence of adi,spi-mode property means default mode */
> > >                adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> > >        }
> > >
> > > But I can admit this is not an often used approach.
> > >  
> > 
> > I think Jonathan prefers to have the error path first, so I would like
> > to wait and see if he has an opinion here.
> I do prefer error paths first.  Thanks.

Still the above can be refactored to have one line less

	ret = device_property_match_property_string(dev, "adi,spi-mode",
                                                    ad7944_spi_modes,
						    ARRAY_SIZE(ad7944_spi_modes));
	if (ret == -EINVAL) {
		/* absence of adi,spi-mode property means default mode */
		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
	} else if (ret < 0) {
		return dev_err_probe(dev, ret, "getting adi,spi-mode property failed\n");
	} else {
		adc->spi_mode = ret;
        }

-- 
With Best Regards,
Andy Shevchenko



