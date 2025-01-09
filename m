Return-Path: <linux-iio+bounces-14060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D82A07EB2
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60093A19A9
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D418E756;
	Thu,  9 Jan 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mXxVu49x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488318C03A
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443628; cv=none; b=nuRnJDJm/rGVSwwpObIIDJ8jUSaEjbjTsof4iDCwggwDV/IqB1CWfOMI8aEAQV3fJYjWhRgHFKrNRUltyP6aeTWDENK7of2CoHd0bsnRELJ/2CcyBu90VJH/AOYrwMH9UVZdINqv2W4jTDPRIt48jazYULenVV+z41+EklpIiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443628; c=relaxed/simple;
	bh=fOgl2r3Akud0vnBpZVjxkDi4M8y7Dj1ztJJxkxVLDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY/GJyuygoBHAomwSeaeNhwPP5gIEx1Fy1e9CoCcaviB3CqAiC3hKhDkDjGH16FbgHiECB6T7bxflhFxOEesfZEHtaF0/ouhfKTvqs5uU4N+SG+cG76ibmpW+1Idbk86uRpEH8M5NsqWT0fqY+J89DLCdApWRooT/OzjQlGXqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mXxVu49x; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1215037f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736443623; x=1737048423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8G2zRTupWo+/FpDhu5ZIgjxjM7Q9ilyM88puz8yFGUU=;
        b=mXxVu49xehIGejegqOX9SYCNaOfKUNmfGLyXlFzMwDfAAIqWSIn95kKEsNGTojYAM8
         djOXjO3z9AQMoSiJKU8A2MKj95yvMInEs/X3jtN/N2u2W+ItOz2oNjLHVWntjH+y0vQq
         AB+bBFmaiE/KUwXlAcxXk1EgmBNrxdv/XwDo+HHL2Qn0RciFYpqdI5FrVQGIBZiaoYRx
         v/Fg1hOlJbu8WRTAKw29tnyBf7lQp/NGI+z9eIchhsPu9S7hiO+17gNVjp1TRETPJX5Z
         d1r4PTM+q91uaEPgNtx8f/mmc+bjo0aXI8kxWLWVF1hRJzmVBI4xBk5FrunoIMuZPA1H
         zwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443623; x=1737048423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G2zRTupWo+/FpDhu5ZIgjxjM7Q9ilyM88puz8yFGUU=;
        b=dbiPZdPFahBbTnCcn8n7jElZSPgwkHSzCfhwXGBisNEuW2oVatrIlw2AZ7atBtjyzW
         sW7sgwr59ayqTVaILlRwx1EY7N7SAnx7jOFAc+StUp+iGRkkitGj87wCoo37cWhGVfMi
         QTR5Y+dnPFcpWAXcdQ2t79cN7fFhUyQt6c5LEFGLIBTF4Lsz7S9JtRDgqI7Hcbc3ztaT
         DQ6A7V+aE2fH+nbN6vILECnA2EYdBfe+AHomPDFlIx0ydiAPzT/uxABTT+GHDSZCl3Ta
         g62+I8/bEejWtAn/oV5YXBKpBx/Pnihg4IAHCCtiuim/KQ6/X+CdKjbRAu8tZC2VCiAQ
         RjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6bkKp+hLr4S6hJtQiCzZWAtEJ2JHLxNiUiSITiSB1KPLR0j8p7ktkCwZ8E+gvZSP3KXtPjh+VLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZc58YuIg5AOfthUXM9UbCK9x40TfHx9W1WJApCffr5gaQpF0
	HLQ5JIIogHd+hHcdh2ZYXcwPdxg2WSKbyEq0rgHsCfVSxSXBo6UckPj/82qBy/U=
X-Gm-Gg: ASbGnct9FcfNPzNHonMQ2A6iny7PdUQY/h/TDYSFPVu1XcB2HNChdbCOlb62KQnXxOA
	LnGAr7ANt7hIVv8dldZ2PkFHWltGtctdHei5DyXfX0WPRvZCEKp6x0yu4kyFkPEBwucnc8PM6vq
	ARq5pvD150XAQJIWj/BOfzBYZ8AuB/fxH2TJuGCQsfs/WratBc4i9mopRJCDyiljOYtkxyXotgJ
	NEB/zKDzIWSoM/5a2JDJrCrAn2PH7G3xoU9Elg/qbQKeala
X-Google-Smtp-Source: AGHT+IEYAB3fLkW6WzB6gRoU0Ma0APJ2iTitskeYOuahF99igNaJZzFDX2uGmrWq+sIKIPgzHQHj6g==
X-Received: by 2002:a5d:584c:0:b0:385:f6f4:f8e with SMTP id ffacd0b85a97d-38a873573ccmr7171144f8f.50.1736443622111;
        Thu, 09 Jan 2025 09:27:02 -0800 (PST)
Received: from dfj ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddca2dsm61354935e9.21.2025.01.09.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:27:01 -0800 (PST)
Date: Thu, 9 Jan 2025 18:25:47 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
Message-ID: <gnh2oayoj5bwqwrixm5x5qtjdq5i3cclokekkezagonl65su3m@b6b4p7duyot5>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-6-2dac02f04638@baylibre.com>
 <80fa8faf-b5ac-4f3e-84b9-acf8ac6ab26d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fa8faf-b5ac-4f3e-84b9-acf8ac6ab26d@baylibre.com>

Hi,

On 08.01.2025 15:16, David Lechner wrote:
> On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Use "instruction" mode over initial configuration and all other
> > non-streaming operations.
> > 
> > DAC boots in streaming mode as default, and the driver is not
> > changing this mode.
> > 
> > Instruction r/w is still working becouse instruction is processed
> 
> s/becouse/because/
> 
> > from the DAC after chip select is deasserted, this works until
> > loop mode is 0 or greater than the instruction size.
> > 
> > All initial operations should be more safely done in instruction
> > mode, a mode provided for this.
> 
> I'm not sure it is really "safer". The way I read the datasheet, this just
> enables bulk reads of multiple registers. So unless we need to do bulk reads
> it seems like this is just adding extra complexity to the driver without a
> tangible benefit.
> 

this change was initially requested from the HDL team to stay aligned with
the HDL side streaming/non streaming mode, and later, applied since seems
a safer way to operate.

I see that for the driver and DAC point of view, this is "functionally"
not needed, but streaming mode for configuration or raw read/write works
until STREAM_MODE register is set to 0 or to a value >= to the register
size to be accessed, since the _CS deasserting completes the transaction.

I.e., a transaction with a STREAM_MODE set to 1 would fail in case of 
a 16bit r/w access. Staying into streaming mode seems to me a bit tricky,
and setting to instruction mode may be safer since in this mode the
STREAM_MODE value is not important anymore.

For me is the same, i can remove related code. As you prefer.

> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index 27949f207d42..991b11702273 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
> >  		return -EINVAL;
> >  	}
> >  
> > +	/* Primary region access, set streaming mode (now in SPI + SDR). */
> > +	ret = ad3552r_qspi_update_reg_bits(st,
> > +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > +					   AD3552R_MASK_SINGLE_INST, 0, 1);
> 
> Missing undoing this operation in the error path if a later operation in this
> function fails?
> 
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> >  				      loop_len, 1);
> >  	if (ret)
> 

