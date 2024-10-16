Return-Path: <linux-iio+bounces-10654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E99A046A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CE3285861
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193EF1FCC6D;
	Wed, 16 Oct 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VnG97B2a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF01FCC6B
	for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067820; cv=none; b=vERG+taGN8EOwB2INhqT+vRNnVg/iqLptAd6j4bFN5kZzgG42rmhckRccjJIBLkqDeWYm/Idpq0wN5VNkeSsWSOa8z6aTvgyTRf4E0+uIzjsk8GAOH+V2v1tY68PEiqtYR0eJBm+vXPUNqUqWkwPt4zvYeklFu5yxZOdzxrbr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067820; c=relaxed/simple;
	bh=w3g0Fn5Mfd9fDtUeCzIpWV081s38HRgl5Pl5wCNQDG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehVaHZ/i/jzfRNF+aGSkA8+J8Ms7Vo+CTPG0ydyVELc8wD4HRBHNTPt2axCPTa9RVGWNkkdduQ4x2r3vbNKJEqYMU777PMYTC+wEPKaDVfxMR0k7hJXqGHsx87ETJLZe8UIqPQoakrNaXag10SyEYjd5S9kvcjFsQn6LfdWxDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VnG97B2a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso38778525e9.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729067817; x=1729672617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gKZmMs4w+DDsatMIrnFTI7zIzR+qyauPVq2X7PfsunI=;
        b=VnG97B2aJiGcNV4XW5AwaohFYBrIreB/nh4Zk+rfpjrH6QhXbW9VnCHDitGArmSxSD
         YF0VuAaJSnCdQbHVlaam1QM/63vxpZOLOJJ98wxU4jWWuHGoys6060ShGFfeaeXUbr1F
         70n+AuExU49hT0negJd5FxjWFZuWLrMHP7rbBiYf176YsDSGRLgXmlj8AZmNK0MWj1+C
         CpRvOFJn5PODWUSoM5yZYXTf8Khp7Z/qJ/Uk6yFiQvDDX/DNMQHCc2d+VFv5wi1ZK2Is
         gOddCNLeGLNcmHRFmbD7fy6Pgk6YvLD03lROQoKG2SxueVEoKOSsKB9+2xyLHCX3TTHC
         5DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067817; x=1729672617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKZmMs4w+DDsatMIrnFTI7zIzR+qyauPVq2X7PfsunI=;
        b=QsSBYAF8ydraE2hUgp//+7xPeRfhj0/XTUw74Dc82hsL3IULvi0ipeWknanGQff/Bl
         Wy4o7O/32T6AkMits97BV3z6NYc2pIpcGuEy/Uk3xMiOck+c30AKTbrLDXMIQESwIr6o
         UOuwJAxQV7RaENJoQ1OHI7Vc78QX4OdYxZrR1/JZ1Ep6I8tH5du2XbuZ6oPFTnt+Fap8
         POxalB1yIM4ioQcsIxONpnC2YP1Fj9RLovghCzm2hIv+/gft1msDf0S+cxmOm1HD73ec
         55Hy7Ll/ZZYEsJkywVZGALwgh8PTESF22suaUzuCyLG2MB4NbLaXUvouPcAlHJC/PbRp
         yYJA==
X-Forwarded-Encrypted: i=1; AJvYcCWb5GF+aIWQcVxrJcE/GOQELT9NkjomXrC9jbZb8eVeOekq/LYHbQSMNnq7K71mVWZF4u1bRln9Los=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkoU0r4eVB1RMRFLUjzkSDKUefDG3PCi4EC7X3KGDY8VtPrGa
	yHk4/RNUxFFDXKFBNJQ8Xg10sQ4ertQG0MLSdPAG0NCb+0lO/UQE0CYWd/MSy08=
X-Google-Smtp-Source: AGHT+IFRJdBQH582trH9wT6BtwYZ7vQBkNADiYoMcxo+OBtSWkYERq9wOrwJkvE9a86yjCnfmAOaxA==
X-Received: by 2002:a05:600c:1c9d:b0:430:57f1:d6d with SMTP id 5b1f17b1804b1-431255d5099mr124678535e9.1.1729067817144;
        Wed, 16 Oct 2024 01:36:57 -0700 (PDT)
Received: from dfj (host-79-50-238-21.retail.telecomitalia.it. [79.50.238.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55defbsm42571395e9.7.2024.10.16.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:36:56 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:35:26 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
Message-ID: <c6emj4i56zozdpkgx6gkzgdlnwvkagll6g2yc6naumnrxqkvee@5ktdjfsem5bj>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
 <c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
 <8642bdb546c6046e8fe1d20ef4c93e70c95c6f71.camel@gmail.com>
 <2815c8b0-e2ad-47cb-b5aa-00297cf57899@baylibre.com>
 <781cf5fa075e13260e1b20f5acadb70bd8107cd0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <781cf5fa075e13260e1b20f5acadb70bd8107cd0.camel@gmail.com>

On 15.10.2024 17:00, Nuno Sá wrote:
> On Tue, 2024-10-15 at 09:38 -0500, David Lechner wrote:
> > On 10/15/24 1:37 AM, Nuno Sá wrote:
> > > On Mon, 2024-10-14 at 16:15 -0500, David Lechner wrote:
> > > > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > 
> > > > > Add High Speed ad3552r platform driver.
> > > > > 
> > > > 
> > > > ...
> > > > 
> > > > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > > > +			       struct iio_chan_spec const *chan,
> > > > > +			       int *val, int *val2, long mask)
> > > > > +{
> > > > > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	switch (mask) {
> > > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > > +		int sclk;
> > > > > +
> > > > > +		ret = iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > > > +					   IIO_CHAN_INFO_FREQUENCY);
> > > > 
> > > > FWIW, this still seems like an odd way to get the stream mode SCLK
> > > > rate from the backend to me. How does the backend know that we want
> > > > the stream mode clock rate and not some other frequency value? 
> > > 
> > > In this case the backend has a dedicated compatible so sky is the limit :). But
> > > yeah,
> > > I'm also not extremely happy with IIO_CHAN_INFO_FREQUENCY. But what do you have
> > > in
> > > mind? Using the sampling frequency INFO or a dedicated OP?
> > > 
> > 
> > It think it would be most straightforward to have something
> > like a iio_backend_get_data_stream_clock_rate() callback since
> > that is what we are getting.
> 
> Hmmm, what about exporting an actual clock? Maybe it's overkill but from a
> correctness point of view, seems what we should actually do :)
> 
> > 
> > Re: the other recent discussions about getting too many
> > callbacks. Instead of a dedicated function like this, we
> > could make a set of generic functions:
> > 
> > iio_backend_{g,s}et_property_{s,u}(8, 16, 32, 64}()
> > 
> 
> Hmm interesting approach. I don't dislike it. Kind of a generic getter/setter thingy.
> We could then still have optional inline helpers that would call the generic
> functions with the proper enum value.
> 
> > that take an enum parameter for the property. This way,
> > for each new property, we just have to add an enum member
> > instead of creating a get/set callback pair.
> > 
> > Unrelated to this particular case, but taking the idea even
> > farther, we could also do the same with enable/disable
> > functions. We talked before about cutting the number of
> > callbacks in half by using a bool parameter instead of
> > separate enable/disable callbacks. But we could cut it down
> > even more by having an enum parameter for the thing we are
> > enabling/disabling.
> 
> If we don't get too strict about types it could even fall into the above u8 category.
> 
> Instead of lot of new simple ops we just grow an enum.

so a single call for all enable/disable calls. Looks good to me.

What we want to do now ?

So if understand, we don't like too much IIO_CHAN_INFO_FREQUENCY
but at the same time, we don't want to have several new calls in the
backend proposing a design change at this stage, where the patch
was (likely) in a good shape.

What about to simply add a IIO_CHAN_INFO_BUS_CLK or similar ? 

> 
> - Nuno Sá
> 


