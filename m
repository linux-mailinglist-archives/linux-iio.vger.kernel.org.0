Return-Path: <linux-iio+bounces-23965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F428B5206F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8FB7A8704
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5042D23A5;
	Wed, 10 Sep 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="AlZKCx5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E572D130C;
	Wed, 10 Sep 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530330; cv=none; b=Pzm9SO9kbcbt5fpPQBLmMFkETQ9NWdDgFBCnLILfeZqvAEY6vFQLrw7ggsW+i6W3QOyv8ES6cTz2lFrsGeHtyR4Amv9qQ0c4eUtxQmK8ekMZY4ee3LkaD5ukvCIziVPuJ2Pc8fXnRHfi733H5z4Dg94ueXt1/4ZIsoVRj7SKdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530330; c=relaxed/simple;
	bh=e2HEGdY8HTT62VzkGjra9TT601j7gUIe3tNGN/jo964=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMF+PbdB/X3h7luu32ECrTAG8CmTunYXNfBh6NLtGhFCrVfQoR2Rk+9f5XAKGGmY+cKkTBs8qsj8wK3yOy/YCFlzIQNt9ToRaAulZpGU1IsXZXgbelNceADmo+Sob2JkRoJHOBrDDGM8ktpO9B8NhfG6fR7xUM8/J84U+iRQOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=AlZKCx5w; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 52D83173BE2;
	Wed, 10 Sep 2025 21:52:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757530324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzYM3A6axo42RwWGBvA7uplSP/pVgQAc0gg+oED22Go=;
	b=AlZKCx5wHPGfIp3d+rqGRqYDu0K2dnUK/WMsLABgsRTL8aME8eYTeKoaz2NLmUYP5C8wqK
	jYLfJwv1O/DBr6P1muQd5dyCuTj459wPVLkl5ZG30kWZRKloi5HJleiLAPrvfbYsqCqmj+
	t7H4UeegkLhsAzQTqLtgI1I6b+rqS5qUNHWU2nijSSorhACZJEqAHY3GNA38Op1MBGLCrK
	s/LSKk2fVEsdMK9+OQA+o1sHvWAkpqE7VEBTJU/kAU1nf9xRCdWG18Hr03aMHFIGg8Wan9
	kiKIe+25NPdtHzmkoIGGktMoghCgiu4nI7ori7KfdlhQ32JoxdmoauQzoD6jnA==
Date: Wed, 10 Sep 2025 21:51:57 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] iio: accel: bma220: add get regulator check
Message-ID: <aMHIzUuNx9LXQdag@lipo>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-6-e23f4f2b9745@subdimension.ro>
 <20250910185841.075594bb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910185841.075594bb@jic23-huawei>


Hello Jonathan,

thank you for the blazing fast feedback!

On Wed, Sep 10, 2025 at 06:58:41PM +0100, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 10:57:11 +0300
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> I don't follow the 'add get regulator check' of the patch description.
> This is ensuring they are powered up if necessary.  So I'd
> just go with the vague: "turn power supplies on"

to be honest I added this just because I've seen the devm_regulator_bulk_get_enable() function used all over the place in iio code.
but looking at the linux/regulator/consumers.h header I was more puzzled.
just some forward declarations and then static functions doing exactly nothing.
I'm afraid to ask what that is all about. placeholder for a future API?

best regards,
peter

> > +#include <linux/regulator/consumer.h>
> >  #include <linux/types.h>
> >  #include <linux/spi/spi.h>
> >  
> > @@ -205,6 +206,13 @@ static const struct iio_info bma220_info = {
> >  static int bma220_init(struct spi_device *spi)
> >  {
> >  	int ret;
> > +	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> > +
> > +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> > +					     ARRAY_SIZE(regulator_names),
> > +					     regulator_names);
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");

