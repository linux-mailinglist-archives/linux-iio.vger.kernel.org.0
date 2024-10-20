Return-Path: <linux-iio+bounces-10811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B919E9A5394
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7F282B00
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4618787F;
	Sun, 20 Oct 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdD78Tya"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4141465BB;
	Sun, 20 Oct 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422013; cv=none; b=fCVGhtgLDWAXPGIQb/jhrgRQCRrLoXULVFeWs8gZN34A5uKCR3pTetlIO2h+LXlSM7pxF22HPhhpQ1Z98nVTTLEjQdgS8NFN4xtKOpYrUK8+eu8YKjU+iIgtduv5Z4cchmWwyVBGCwJDunR3UacbZsCoYf1+d/1uNv1Y0nHCIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422013; c=relaxed/simple;
	bh=yAcfpOxj9t0NOhWYxCiaqe0yIlaU7gqHRvUW7RoK9To=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADdajPdpeImz1QIYbcsE+OM4P8PTUNnAhBeJNbXeW4y9MGu9eSRN0i0oiEfX0R9TjSBbHfdJb6ks0WHIFVQ3z0112KNaM0hxpplj4iqOumypdoygAUmbjyMArn7WVWRqhLAsO4XjzFW5MJKSFp/IvifYxUecFCDumb20YUOZu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdD78Tya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF8C4CEC6;
	Sun, 20 Oct 2024 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729422013;
	bh=yAcfpOxj9t0NOhWYxCiaqe0yIlaU7gqHRvUW7RoK9To=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NdD78TyaggvRGiCVBfHXXPT5j9xFRc1Ua1CwqLcQfGRkHf9VBpisXtKyiwDZ6WiNE
	 IfcFqbA8adzE8RO6stlR23AgoRSnG4OryNrmRTh6nhMgSHgvDpHyzfGBZSBCbRxofH
	 sSewPpVjorUusi/7kZAWZFy9RHUqbZRA+f/sdyTcHUgizwbQn3QK4kCmu4WtTtYB+A
	 q+cRK8ExaTmTRKwnYmCYfJr5I1nA0148TwrPzwbpbrL2k0LpgGpbDIKxz/6L2MjjvU
	 B7tJlb0pEyTmU9CelQpcnxkTLX9l1ikP4iB95mkQBJuvIjyt+T9z8zA7jjXtiTbZWE
	 9R9llwl+aVbtQ==
Date: Sun, 20 Oct 2024 12:00:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <20241020120004.305b2e72@jic23-huawei>
In-Reply-To: <87sesrak8w.fsf@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-5-justin@justinweiss.com>
	<20241019124013.0575e05b@jic23-huawei>
	<87sesrak8w.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >>  #define BMI270_CHIP_ID_REG				0x00
> >> +#define BMI160_CHIP_ID_VAL				0xD1  
> >
> > This one looks like a cut and paste error.  
> 
> No, this was intentional -- I added the BMI160 chip ID here so it could
> be checked later to avoid conflicting with the existing bmi160 driver. I
> could add newlines before and after this group of _ID_VAL #defines if it
> makes it clearer.

Got it. Just add a comment that it's to exclude known bad firmwares and
that is fine to keep.



