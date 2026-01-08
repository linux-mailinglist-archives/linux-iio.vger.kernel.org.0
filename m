Return-Path: <linux-iio+bounces-27545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C95D02A71
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 13:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0723091450
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93AA4CBAA9;
	Thu,  8 Jan 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koJLXys3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35064CBA99
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875109; cv=none; b=usin3joKxNlD0vlQ4lOsgVkqDTnRieMerPxp///je0oB0PiROE86Z4m3C3YgYrVl/VSoktfDXARKUG9VzDJdvI6eh0LIyxscR0fr5qUVSX4ePlve+M/pfJPUtxZ9WNLk8O5CqWUD42vHFaH9rFpFXVNFRsz8jxGI4NyxkLTU1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875109; c=relaxed/simple;
	bh=aaHyXdS0nmiOSH+39v4TllnNhWztOoW+ppCJ7RxVa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCh3ajMvIjlKguvDYMSpLUcQTiMkdiwTz4nulxX8+LwcKJjju2sizbbL02sv5dmRCA9bNY0YnCKkcrukz9d9VZyz915HW/nHPrQF9fVdrQvzMm7LRjo8e7eTAm/YfdFstDEMpqNpJmc0hQScYAz8P00iOpjlrcpaWLBPAtixo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koJLXys3; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ebe501b49dso2173936137.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875107; x=1768479907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuHLAkpi+QoqrsNtnMo40SsdhSUfyacTFMUwhFx6NDQ=;
        b=koJLXys3IA+qyZ7CAZCe5pUZXZxq6kHVsMIHd4+B85mTLJqkMPydN+cmi3xx5f1Rt+
         cz+04Kza8mCuxWrxfc2kI6dWJTtI+MurnIS9KzApEIoWrh0V3p0ir5pq2cuzCvuZHrHt
         j6sXyTFEL5gAlMeiUV1up52QIUd+olw2bX7YV9MPpZoMdThDX/gW+EpOkNHsf5p842Al
         3vRgihucJdm6shRB07V+LqyTmlW398F207x7S2O5vqty/4s84k1R4JUUOMcpB7tgcFFt
         LKNPE4XR1bQb+lE4Og82o0Bt6rjPJ9xoF5cjF7GAUl9bXn/EKS32ocm/D9QZB2/lrUS9
         5YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875107; x=1768479907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuHLAkpi+QoqrsNtnMo40SsdhSUfyacTFMUwhFx6NDQ=;
        b=rIEr3937UhJjFogwUhflW1nZkAhvDDS7DsVGSZ2CX1rX4K4LmCtK6DOACAnLp4eS9Y
         CaQfAj5XYOh3xrIffGO2qqKdBoEpKwVOEqFK1h5vlelDb6odDNQuQFkfNVp1Ri+frnpv
         vXPSOx61vKHIl7RetxpT0Od1OAe4FiK8zgK9E/Q3tP7PdlIib/gA5UerEcFqzHgRn/3T
         ZDtUk5DB2Rg0ldEODzv/35uAXZfFVlqeL9wwOlGyM0Su2NfdJX0B7GZwlUMe73x1Yg2A
         k5Coq0D5mQUEXh/bBGSDBIQ2BLoZ+CKaCcDSO8lpYCb8CSVb1pOr84D9McTFwXir79bo
         khJw==
X-Forwarded-Encrypted: i=1; AJvYcCU8nlvtzFCC5iq3J9YqRYYabmV2Y7BGfW9uBfy8WtpaJPDjSn0GR+5kFJZpMVwEq8BA4en9oTQ49l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiqXI6qAQzyOfPmKpDuJRsj1GgOLZlS2zOubcqmUMQXR83G9z
	JQwRfl/EIc/wn2Ls0QikCfBfWujKd/qwU2XhG3DADnl/29olrsDxAfYJzZfBrITV
X-Gm-Gg: AY/fxX5d9hvxzfIR9qun0TLhBc+feBTOC7vdwyYYUCKBsBuGEZbbxdPLUveqbWPZ+Vc
	+YdSpB7Br5NRb1FknQJ+mgsXA3WxnRvUudwswQmXpVRMcO61o6+Bxumv8/FPwflnp+hHpnrQ7Mw
	avlmw/AMbuk+Nfh5mokabvJBMI7Ew5DD8Xw/H231jbMiTdGbyuCzjJvq8yxjfnBPGHPbuYeAYkI
	0COQxovwITau+Gb91euFeW5YuOpw/QSDPdALv/3jE4R/mL6WvIEUE4asYCV5IvlNanxKt2jYBQP
	5vRrtIpJw6/MDfbNLf3tRMbhCNI3re/AgP01PJJPYxARL7Ckf41uxaWPV4VHeps4pEimkY9W9KU
	jNqxEsf4w3pnftg253F2SCUDCnb/w/4KLpOlnMDDBYYckyjZ7LGpZlhGD8dEsVZUSuEDSg9mFCP
	62Z1g/dq6hHexSdDmznlE=
X-Google-Smtp-Source: AGHT+IEBwSk5QOmvxP7JWfiLaJmCUu07iMcs1hqKhN6MvYBXFCVIPi1VMHNI/PsFUx/a1aq7urblAw==
X-Received: by 2002:a05:6102:5714:b0:5db:d60a:6b1f with SMTP id ada2fe7eead31-5ecb6938423mr2317214137.23.1767875106642;
        Thu, 08 Jan 2026 04:25:06 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122ae554sm5583799241.2.2026.01.08.04.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:25:05 -0800 (PST)
Date: Thu, 8 Jan 2026 09:26:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Message-ID: <aV-ii6pdDYA02euV@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>

On 12/19, David Lechner wrote:
> Change spi-rx-bus-width and spi-tx-bus-width properties from single
> uint32 values to arrays of uint32 values. This allows describing SPI
> peripherals connected to controllers that have multiple data lanes for
> receiving or transmitting two or more words in parallel.
> 
> Each index in the array corresponds to a physical data lane (one or more
> wires depending on the bus width). Additional mapping properties will be
> needed in cases where a lane on the controller or peripheral is skipped.
> 
> Bindings that make use of this property are updated in the same commit
> to avoid validation errors.
> 
> The adi,ad4030 binding can now better describe the chips multi-lane
> capabilities, so that binding is refined and gets a new example.
> 
> Converting from single uint32 to array of uint32 does not break .dts/
> .dtb files since there is no difference between specifying a single
> uint32 value and an array with a single uint32 value in devicetree.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes:
> - New patch to replace data-lanes property patch.
> 
> In v3, Rob suggested possibly splitting the spi-controller.yaml file
> to have a way to make most SPI controllers have maxItems: 1 for these
> properties. I would like to avoid that because it doesn't seem scalable,
> e.g. if we need another similar split in the future, the number of
> combinations would grow exponentially (factorially?). I have an idea to
> instead do this using $dynamicAnchor and $dynamicRef, but dt-schema
> doesn't currently support that. So I propose we do the best we can for
> now with the current dt-schema and make further improvements later.
> 
> Also, in v3, I suggested that we could have leading 0s in the arrays
> to indicate unused lanes. But after further consideration, I think it's
> better to have separate lane-mapping properties for that purpose. It
> will be easier to explain and parse and be a bit more flexible that way.

LGTM
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

