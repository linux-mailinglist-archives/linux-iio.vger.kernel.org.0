Return-Path: <linux-iio+bounces-10320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D646E99419B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2357EB21149
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087BC1F473A;
	Tue,  8 Oct 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMKFt7MH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFB1E0DC8;
	Tue,  8 Oct 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373975; cv=none; b=ppLYC7eNXqVmt4y7O8n4FF2uUtuVCBtkRqlhFTJJiUQhx+vLvZ61vDuqM6w4a3JrqVuoYkB9vK4G/rFXx6UBqcn/+gg/7dVSWAb648CV+eBK/GaU2hxBQC8pJKISGI8TA1Wa9Kh4XsdOupWb2tXGMbXDvcoFW1brLYClE8yS3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373975; c=relaxed/simple;
	bh=RELeILqUqPMjl09GG2PwE621EkQ0tkrMlwNgbrAaLNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEgm0wiYcUYAX1DfaJjDS19iFv2YNL5hC8Vdfjwjz3wwMpdyOWvqXYc/DG3Bd+vywkmI7lA2Tu83sUHbWHy8VsqL5FKN6xYZQXQnbN+gQj52UOSj7HBJ0OWyr7BudnaLLxIDTYGFbSS2Cqda5zIkpkPYl+YOlTUb3DwYarlwUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMKFt7MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD77C4CEC7;
	Tue,  8 Oct 2024 07:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728373975;
	bh=RELeILqUqPMjl09GG2PwE621EkQ0tkrMlwNgbrAaLNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMKFt7MHlU6Iu3zUNuC3I78PPirCH7FrmCb8XLEz0pROiVWyHDfvIWGiwoWSJCyM4
	 isVRljd9abVHpvNZCo2jgJRuYn+vZ6ZrRRNKgtp7dm2FT1Q9cXOxGSzORK8O6FuLPq
	 QI9v+79hwvceCY+bQqtIpDWbTqgmLKykTR1X0DkIUIil/5DqEWvPrKH/WRwubj6IG/
	 D0bXJNsWSKGuRYHDtGnt8RyUjc0w5x+NGgnVORW4GPTh2XOEpDbWkLOgGmWvNwbsYM
	 9jEYAlAmAz7ofEcIvBHceXGiXyT2yxjePyFbWPD0ZduWwl2CuJ9sUZHLXwewhMfPeG
	 qIlQkaRQ70fKA==
Date: Tue, 8 Oct 2024 09:52:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: iio: adc: ad7380: fix ad7380-4
 reference supply
Message-ID: <v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
 <20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>

On Mon, Oct 07, 2024 at 05:45:45PM +0200, Julien Stephan wrote:
> ad7380-4 is the only device from ad738x family that doesn't have an
> internal reference. Moreover its external reference is called REFIN in
> the datasheet while all other use REFIO as an optional external
> reference. If refio-supply is omitted the internal reference is
> used.
> 
> Fix the binding by adding refin-supply and makes it required for
> ad7380-4 only.

Maybe let's just use refio as refin? Reference-IO fits here well.
Otherwise you have two supplies for the same.

Best regards,
Krzysztof


