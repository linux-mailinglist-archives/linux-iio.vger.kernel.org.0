Return-Path: <linux-iio+bounces-19899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC512AC351A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61C41886871
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9E18A93C;
	Sun, 25 May 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9EgQMMn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB9111A8;
	Sun, 25 May 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182603; cv=none; b=LQtSHAeq/v49MKP3B2V7HjK7/dewdI+/TlJX8wNVj510xaXx4kWzfLO2neVk1aDzxxqFFwhNh/v4rUM5i4+XKIqV6vUzXNGOgUZ5lSLs3eJ85Nm+8/H0CEJHwKdkncFLDLAWnIfFex4Ufih3St13l6MCyqMYfLuVWdBw9vG8zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182603; c=relaxed/simple;
	bh=sjlx9s4OvwdaAILZYcPuTEe/EYm/DOo0jp3Iv37PAz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyx56sI0rVPM0Fp9gGpfOVlxQgKg7CiauIWZxTHI/9sphmkjBjuNJDc0zmA9pPTuanhgptBEsyc25RQ7vlbx4mGuUj3eG6JjxAoCsa1QkgeyyCbA9Ol0iLNm+y3D/E0LeSlkRf/rkbDrHZ1AV1dQXu/R5ZrXzXkzgaxwXKTskIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9EgQMMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF88AC4CEEA;
	Sun, 25 May 2025 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182603;
	bh=sjlx9s4OvwdaAILZYcPuTEe/EYm/DOo0jp3Iv37PAz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9EgQMMnLSmBEnoXSl3hU5wMbvMwiqNdZwun9p5IT7DHzI/KWUgKzadCBu9Vj3hha
	 No9pEzk1YKXEpNfNnFVAwbmPQPpDURn1dEj8soCtW33tTsRXkbyhKhk64oKECt5Vpz
	 uTjmUugLbVYhvf3s4QOENbZ56YUmx/VPx/SDnZ04GJEzQomapxqrRREg68KQ25IoiI
	 tWAqlnhmsDDEnZxAEz3Ww1Z9GgnlRvzj7m/5lvZbf+Kg5nm2CYFzmegtmpe0BIHIyM
	 Yh1L2V6hV5Si86UKP7pIqtYAjzR5s1hgemqNgqqcBmuFUHxor9l0/jm5A/mKavuVxj
	 wh0R3+t6QIMlw==
Date: Sun, 25 May 2025 15:16:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 arthur.becker@sentec.com, perdaniel.olsson@axis.com,
 mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
 clamor95@gmail.com, emil.gedenryd@axis.com, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250525151633.18b82382@jic23-huawei>
In-Reply-To: <aDLIHEj4lqlgargJ@mail.your-server.de>
References: <20250519060804.80464-1-ak@it-klinger.de>
	<20250519060804.80464-3-ak@it-klinger.de>
	<aCsQKUwGeq4Ed4ai@smile.fi.intel.com>
	<aDLIHEj4lqlgargJ@mail.your-server.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 09:34:52 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Andy,
> 
> thanks for the review. I have a question and a comment below.
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mo, 19. Mai 14:04:
> > > +/*
> > > + * veml6046x00_gain_pd - translation from gain index (used in the driver) to
> > > + * gain (sensor) and PD
> > > + * @gain_sen:	Gain used in the sensor as described in the datasheet of the
> > > + *		sensor
> > > + * @pd:		Photodiode size in the sensor  
> > 
> > This is made to look like kernel-doc, but it's not marked as a such, why?  
> 
> I'll remove the '@'

Better to make it kernel doc!  That is add /** and check for
errors using scripts/kernel-doc 


> 
> ...
> 
> > > +	ret = regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF0,
> > > +							VEML6046X00_CONF0_ON_0);  
> > 
> > Something wrong with the indentation. Please, fix all places like this...
> >   
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to set bit for power on %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
> > > +							VEML6046X00_CONF1_ON_1);  
> > 
> > ...or like this.
> >   
> > > +}  
> 
> I don't get the point what is wrong with the indentation. In the coding-style it
> says the decendant line should be placed to the right.
> Did i miss something?

Where there are no other constraints it should be aligned under the first parameter
on the line above.

	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
				 VEML6046X00_CONF1_ON_1);  

This is one of those things that has never been added explicitly to the coding style
doc because there lots of subtle corner cases where it isn't appropriate.
But all significantly to the right usually means is 1 tab or more.
Where possible most people prefer the above style.

Jonathan

> 
> Best regards,
> 
> Andreas
> 


