Return-Path: <linux-iio+bounces-10002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B498CFE3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 11:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB6C1C213C2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2209197556;
	Wed,  2 Oct 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Ll1rZmh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E91946A4
	for <linux-iio@vger.kernel.org>; Wed,  2 Oct 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860579; cv=none; b=OC7Hvt34gPZdM3n/bdNlNdMVHAWAWDkZ561SI6IGWIu0exXbNFdBo+Hd5FxieQ09LGNBRxdDXuNWU2jsTePRU67pM4R2QTK1FbYWobHQPUJpxHh2CY9In9SjjCVki2G+JOH7KRndZyEtYd7dV7XKmtLmPSqbq1VNQfNOlCnXd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860579; c=relaxed/simple;
	bh=Nw78eTzVuXLjAYnoFep52+ddSCTkBiKv6vdlxpFYRbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGDJU6PjbVT0Y6YmEbQueA6nFD9AyhiXS98+1xlZUvCMfZU04iFLLN1ZLE5dH4ydrg4uMZ/wBOGo9NQk+z/vIg6lzbXE7KYdtoqMzLlQroqAJIdW3U6IMX88kWMuTIcEycJoypiU/G6pFttiRlw/tjS94Lx75q2T7d6JXWL0Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Ll1rZmh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so27309215e9.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2024 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727860575; x=1728465375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mARU2JRNf824g+wSTdZKdCSsUJWrycXAUZwekvNLius=;
        b=2Ll1rZmhakc2Duh77ubWZdMgqhBXefiMIkWDUGH8pTVbGtNINqWXsvsf071dBu/ceo
         7iFdMrHfdlARbVIG5MV0XfLx/C9BiU72t0pCXZtscJw4dGtwhkVNXVMsSsClwjXt8ioM
         Xe6njAYGcOPyekGw5rB1CQS2Z3OBn/zIB27ujgTbEnChth08NNLGs19v7gIQMjg8VCMu
         ZpMIfHHp4rSKLOpBkcWXTIF7YmvkVtm6fXDWAEJPyattffms4bPL2xo4KvptOL2smH05
         8pWEw+x08boi/TfFkxSE/2A3EbwB3cdg+cTjLqzknEUUHv6PYZehYmHAReyEiq1i3ghw
         R5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727860575; x=1728465375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mARU2JRNf824g+wSTdZKdCSsUJWrycXAUZwekvNLius=;
        b=RHmS/toKuFu8zVz98HOCEmXEeNgGswCWsyn4v1uRUdd6+mTmcY26mSSLj5Y4lM27sZ
         bxrSBm+LBMoafAVoOf78UasO09FgpcXwwZVJbIbDqb7ki1OsAJAnopiOSVu7VBAJf1ql
         tbT/a/yuC6HOc++pIYjHsFMb+nwDrVaVrag4gXiFF71jFEJr0/66vg4Au5IDOgjbynRl
         /oUmwR8czVhWMt9DerCWltJnEkIhUGZB5LtoQKEQD/shn2sT+oDMKPwUNpELf8mlEYeD
         j5RKmsvlpbeqSnZBAcTKLuFcbFNWFxOCBKCh3Oy8Ykp+7336y2bnGvm6SgwZq/wLmcWa
         VgvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhcunnqQS4eMkDDRyFcQQ4WCFUTSYcyq23InUBH314FZagDM/3VlZEF37nJshyC/7CtYc23vuurTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFlraG/sSOiqewzbw6wbtokZUpGhObjjnZMVmT6tkvwDIIJ/h
	VdYh2OlHwK9j8L3RxL3GVmaOfc1C61CX1bCfR1GNT1Yj5TGMznpxYxTwgDyqENI=
X-Google-Smtp-Source: AGHT+IHjYPXshleNOOL5YqopAR5Eaoq3n6imSPJoN7soIHrdFO8abgIVveMyDprXSPWCr4eQ6NMLxQ==
X-Received: by 2002:a05:600c:1d13:b0:42c:df67:1d35 with SMTP id 5b1f17b1804b1-42f777b02a0mr18766775e9.1.1727860575480;
        Wed, 02 Oct 2024 02:16:15 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79fdfc34sm13208785e9.27.2024.10.02.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:16:14 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:14:55 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
Message-ID: <4qr4uyo2dp23g5pcy6dliq43in2dww3rol6dhlnjnyg6iravlo@jq454ylj7wu5>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
 <60610fe3e5885033c0a1d14db6e2f576367a2e44.camel@gmail.com>
 <45f72533-ba1b-4531-890d-63d86a1f0ca4@baylibre.com>
 <fa2ab3b06dfb227de2f449c52b83ff6ffe1f79c2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa2ab3b06dfb227de2f449c52b83ff6ffe1f79c2.camel@gmail.com>

On 25.09.2024 13:59, Nuno Sá wrote:
> On Tue, 2024-09-24 at 16:11 +0200, Angelo Dureghello wrote:
> > 
> > On 20/09/24 14:50, Nuno Sá wrote:
> > > On Thu, 2024-09-19 at 11:20 +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > 
> > > > Extend backend features with new calls needed later on this
> > > > patchset from axi version of ad3552r.
> > > > 
> > > > The follwoing calls are added:
> > > > 
> > > > iio_backend_ext_sync_enable
> > > > 	enable synchronize channels on external trigger
> > > > iio_backend_ext_sync_disable
> > > > 	disable synchronize channels on external trigger
> > > > iio_backend_ddr_enable
> > > > 	enable ddr bus transfer
> > > > iio_backend_ddr_disable
> > > > 	disable ddr bus transfer
> > > > iio_backend_set_bus_mode
> > > > 	select the type of bus, so that specific read / write
> > > > 	operations are performed accordingly
> > > > iio_backend_buffer_enable
> > > > 	enable buffer
> > > > iio_backend_buffer_disable
> > > > 	disable buffer
> > > > iio_backend_data_transfer_addr
> > > > 	define the target register address where the DAC sample
> > > > 	will be written.
> > > > 
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > >   drivers/iio/industrialio-backend.c | 111
> > > > +++++++++++++++++++++++++++++++++++++
> > > >   include/linux/iio/backend.h        |  23 ++++++++
> > > >   2 files changed, 134 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > b/drivers/iio/industrialio-
> > > > backend.c
> > > > index 20b3b5212da7..f4802c422dbf 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device
> > > > *dev, struct
> > > > iio_backend *back)
> > > >   	return 0;
> > > >   }
> > > >   
> > > > +/**
> > > > + * iio_backend_ext_sync_enable - Enable external synchronization
> > > > + * @back: Backend device
> > > > + *
> > > > + * Enable synchronization by external signal.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ext_sync_enable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ext_sync_enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_enable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_ext_sync_disable - Disable external synchronization
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disable synchronization by external signal.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ext_sync_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ext_sync_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ext_sync_disable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
> > > > + * @back: Backend device
> > > > + *
> > > > + * Enabling DDR, data is generated by the IP at each front
> > > > + * (raising and falling) of the bus clock signal.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ddr_enable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ddr_enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate)
> > > > mode
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disabling DDR data is generated byt the IP at rising or falling front
> > > > + * of the interface clock signal (SDR, Single Data Rate).
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ddr_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_buffer_enable - Enable iio buffering
> > > > + * @back: Backend device
> > > > + *
> > > > + * Enabling the buffer, buffer data is processed and sent out from the
> > > > + * bus interface.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_buffer_enable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, buffer_enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_buffer_disable - Disable iio buffering
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disabling the buffer, buffer data transfer on the bus interface
> > > > + * is stopped.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_buffer_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, buffer_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_disable, IIO_BACKEND);
> > > > +
> > > IIRC, both me and Jonathan had some comments about the above 2 calls? Aren't
> > > they
> > > about buffering? I think I mentioned something about using the same buffer
> > > ops as
> > > typical IIO devices use.
> > 
> > i have now separated iio_backend_ops, keeping buffer enable/disable
> > for axi-ad3352r case only,
> > 
> > static const struct iio_backend_ops axi_dac_generic_ops = {
> >      .enable = axi_dac_enable,
> >      .disable = axi_dac_disable,
> >      .request_buffer = axi_dac_request_buffer,
> >      .free_buffer = axi_dac_free_buffer,
> >      .extend_chan_spec = axi_dac_extend_chan,
> >      .ext_info_set = axi_dac_ext_info_set,
> >      .ext_info_get = axi_dac_ext_info_get,
> >      .data_source_set = axi_dac_data_source_set,
> >      .set_sample_rate = axi_dac_set_sample_rate,
> >      .debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
> > };
> > 
> > static const struct iio_backend_ops axi_ad3552r_ops = {
> >      .enable = axi_dac_enable,
> >      .read_raw = axi_dac_read_raw,
> >      .request_buffer = axi_dac_request_buffer,
> >      .data_source_set = axi_dac_data_source_set,
> >      .ext_sync_enable = axi_dac_ext_sync_enable,
> >      .ext_sync_disable = axi_dac_ext_sync_disable,
> >      .ddr_enable = axi_dac_ddr_enable,
> >      .ddr_disable = axi_dac_ddr_disable,
> >      .buffer_enable = axi_dac_buffer_enable,
> >      .buffer_disable = axi_dac_buffer_disable,
> >      .data_format_set = axi_dac_data_format_set,
> >      .data_transfer_addr = axi_dac_data_transfer_addr,
> > };
> > 
> > 
> > could this be good ?
> > 
> 
> I think you're replying to the wrong email :). But yeah, I made a comment about
> the above and that is something I'm also expecting.
> 
> Regarding the buffer_enable/disable() stuff, please go check past discussions (I
> think on the RFC). I'm fairly sure I had (and Jonathan as well) some comments
> about directly using IIO buffer options or replicating them in the backend_ops.
> Likely the second option is the best one so we can take a reference to backend
> object directly.
> 
> - Nuno Sá
> 

Hi Nuno,

trying to fix this now as (hopefully :) ) last point for v4, looking the RFC
i find:

1) Embed struct iio_buffer_setup_ops in the backend ops struct;
2) Or just define directly the ones we need now in backend ops

About 1,
looks like that then the frontend cannot customize the buffer ops.

About 2,
i already setup a specific backend structure only for axi-ad3552r.
Removed the sync stuff, we have now only 5 new APIs. 

What i can do here is a better naming, and better description as asked from
Jonathan. 

Mainly, this functions are starting and stopping the stream from dma to the chip.

Proposals may be
static int axi_dac_dma_stream_ebable(struct iio_backend *back)
static int axi_dac_dma_stream_disaable(struct iio_backend *back)

or 
static int axi_dac_data_stream_ebable(struct iio_backend *back)
static int axi_dac_data_stream_disaable(struct iio_backend *back)

or still more generic
static int axi_dac_bus_ebable(struct iio_backend *back)
static int axi_dac_bus_disaable(struct iio_backend *back)
(or bus_transfer_enable)

-- 

Regards,
  Angelo

