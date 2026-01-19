Return-Path: <linux-iio+bounces-27958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBBD3A9F7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0842A30274E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB1364EBF;
	Mon, 19 Jan 2026 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XztQSOuu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A386364EB7
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828218; cv=none; b=nSJ11zTt2RMyXNHmdMjG7287k3suV1ON+YnS872VDBkF/BkMyGhz7tmW+K7Tp6yLpOwzZXm9ApWRbuOgsyEv0r0DxrtQYQel1GXwlhLF1+MIa9KGAJE6xtOCVPYSTDlohtLBbBlAAYAx2GehCq5qXcYb1yDdEDrevZ/dfLv+2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828218; c=relaxed/simple;
	bh=RbIznMFxyjtdscNIHV+mpdQT2F/p5a92VpVZkbRVgCw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNIOh5qiuIdVumM+J5giutFSiBDy+FMidlvszjMXqdBewrqp/IQGFADIIzcuZ5yfE2PznfEM9A5zFPEs0d3tX56lDRtOK6Lx/lt9/JPcLS05CPXANTbWYU/hWPP8i7DrnOT4lW5Y6/A4draPIt1RzHrW/uearJvWuUEAzYjcGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XztQSOuu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5384ee23fso466696085a.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768828216; x=1769433016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=As7ad+RroQjVUHt90+2p37ZNFr3kAcDjR6210U9k6EI=;
        b=XztQSOuuNQ7SiY4+8EUkBdNz9etJRK8wNQQ5Ackw04WUt/HEg6EGhJ1i3V87lvDAaL
         HLfJCiRoONq40qKZF3/81edrGdxkvcjZ2pjSi20Qzh56KhnSc422yhr/i7Liw7f6cUOg
         zyG2wQkewsPgGu7Ndj3MBp3Rsmh7HjMlRhEZ1e2KkNwro1u2jn+rkDGA/j9H85hdi2cf
         fF7j8H4rlw1LqVWcZ4IWOlcx1PX9ymHpDVKAINdpC+Vp5x5gEpk7M4L5em2mOCq3t4vo
         UAooLkn2G94hDhgtzFGgwavP1zWRNHxH0JJgt02whRZKlftNvy+L0wOsL6QHBhSiFa8r
         BtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828216; x=1769433016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As7ad+RroQjVUHt90+2p37ZNFr3kAcDjR6210U9k6EI=;
        b=woaYgvauh4d4YiaQgS7fl9YYDXDM4dRubCXJSOw60ta6iq6h0EqPjOcQo1mcpPa56D
         B5zocOayfHjtfRhCxJrKqTkRQMfN5ElhYNvUunjzNEEkJj98CT6gfVSux5KHOwA7l280
         19w7trqstgSHRzXzup1xygktsnG2qk/jufIWvkE60DxC4ytO5SrwgNTauPlFKhB1MKpq
         IxEr5vklMhoztTSSZBue43B6S7aJ1c73EPkB8t8Z6xyruswNgymyGTInSvn5XSmZNA2p
         0vtYUsgHWpLemiOyGnPH//rjrZROexGReQ7x25tMajP1gpxfFny2llqku3dV47ZC9fu+
         bexw==
X-Forwarded-Encrypted: i=1; AJvYcCVA26lbSh0GlaeUTc4pn3zU/dP4kIdH0sCokCDD/9fHO/7dnyP0M4QES1Xh/9DLaOpFxQCkXwlihCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrogfu/xLMZGZWGIx2NEKxoQ+6x8vyo4iX0g5HBdmbng6MjgSj
	woxo9JMPT0LOwjgS1uawyVnIu9Z+l/Vj08nFwUOov6zKY0JnI+GW/UOb
X-Gm-Gg: AY/fxX74PXijBLblezP1ktPm6eAub+v4ivlbJEoQvEsnl4nqf1ogbnsDTfLpbifPAbC
	nQZ0Xyrjucp4YVrNwjwYHIMayxtxawbQ7NFwH0BhgeEC7NFI/YfCkl1k+Yt77SBiJ6GvLta/gfb
	JcwqfwzD6JOrja6VTgoW4g8WBkeIjigsvDsOBtveJSVkSW4xDDFlUVgqqK7VVjaxxmGWTPj72je
	B996pkNEa4W0Z7PWR6tvKreEdaHnW6rnBuy81wZIeysbKaq7FklUerUb12IF+loYvZRwZQs+LAt
	/5ysNPDo5M+WeKQ7WRoCsQ916W7caR9HFilhhmzT14Ozp9OJ18t8q6SKpZTclFdQnHi/UMclJck
	RxfvG1wWq1JoeivgUwi9DjCTdao2XMBBuIRhANWDWIRSan71WmGXUMmPz6cJ+BLsc7jFBZfIiyK
	soPs/ulRLbtKfVpNA6sTo8g/ZRMsx6sffBN7NeUb6gdUc5MapptUCOBVtkw/7AXg3Q9ARNErfs/
	bZr
X-Received: by 2002:ac8:7dc3:0:b0:502:9f6b:a3b3 with SMTP id d75a77b69052e-502a1e60bbamr148654691cf.37.1768828216161;
        Mon, 19 Jan 2026 05:10:16 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad820sm774437585a.10.2026.01.19.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:10:15 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 19 Jan 2026 13:10:09 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <fv4kgfxqgzrw2yaq3vv5g5douyer4ocqk5nloi5iwxc2aueby2@vswsu4jxz6xh>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <20260116192916.436d24c9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116192916.436d24c9@jic23-huawei>

On 26/01/16 07:29PM, Jonathan Cameron wrote:
> On Fri, 16 Jan 2026 14:32:22 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>

...
 
> > +
> > +	cp_resistance = ADF41513_DEFAULT_R_SET;
> > +	device_property_read_u32(dev, "adi,charge-pump-resistor-ohms", &cp_resistance);
> > +	if (cp_resistance < ADF41513_MIN_R_SET || cp_resistance > ADF41513_MAX_R_SET)
> > +		return dev_err_probe(dev, -ERANGE, "R_SET %u Ohms out of range\n", cp_resistance);
> > +
> > +	st->data.charge_pump_voltage_mv = ADF41513_DEFAULT_CP_VOLTAGE_mV;
> 
> This leaves some odd corner cases.
> If DT defines cp_resistance but not cp_current then we ignore the cp_resitance.
> If you want to insist it is either both or nothing, that needs enforcing in the dt-binding.
> I think I slightly prefer this option..
> 
> Alternative is define a default current such that the maths works to give the DEFAULT_CP_VOLTAGE_mV
> if both properties use defaults and use that here + document in the dt-binding as the default
> for this property.   That may mean if only one property is set we reject the pair and fail
> to probe.  You have comment about valid combinations in the dt-binding so that's fine.

Understood. I suppose the following in the dt-binding would be enough:

dependencies:
  adi,charge-pump-resistor-ohms: ["adi,charge-pump-current-microamp"]

as current can be defined alone (it would use the default resistor value).

Kind regards,

Rodrigo Alencar

