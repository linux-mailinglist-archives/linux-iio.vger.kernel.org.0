Return-Path: <linux-iio+bounces-5939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A98FF587
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12151C2592B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D471749;
	Thu,  6 Jun 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEQnIDyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCD4C618;
	Thu,  6 Jun 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703801; cv=none; b=uHfEZS+AlDhJV8yw65zWkl0hPMaBwhUVSF6ElqybmrYgIV7n6QZm5LCBU/fYrFAkagXWxavHnuVrpkBqc961uPAgl79baw+55x2Efx82bYPKLuYy5Kcb7pcz4m46oDdj76G9sgV9fnWbGNJdfsvAAFEyf22DyCWzHatT1OkDtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703801; c=relaxed/simple;
	bh=Qurdt8ueT0yPwWNrPmEHkTDIsNDf38jckmh+NndaPUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEPLYiK+08H8rUNpcQgKHxmneNONpmSDN0cC3nGQNBw8ITbppgOCKsDscCY1nJW92qf+VLfPcTCIVXcAriCFhyVm9/LNTGyQe+Ea1NNaAyA52DwcDXuKLZl/nQbfT5VtpC8sOXml98LiJS7u2Z6tn9oyZFNUsqy+ObohVwUNvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEQnIDyW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47f07aceaso12858025ad.0;
        Thu, 06 Jun 2024 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717703799; x=1718308599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdytDqtRYVnzm7SE/5i1mvkB4M1tizM3b9ra2VRKybw=;
        b=PEQnIDyWQ1bcgfyhlnRBR2UcYfrKFVwvb00c6xeGdCZtmN0SYbDXeAB2O9IkHsTFEW
         0dO9tgA+lBfH2x1a+bwjvcj1OVF6mxNUgD+Y94OtMOrJkpQh/yaT1Aa1AF3smXfG8urT
         GT2Qjs4c5wetpJ7f+fOgBWOEB7Joj//DzQqn2gKjY3HQbylVkkET8lx8QQ35b6D3k9fi
         4qRKfTK2PYmHkI3f7xpfSTC+keMKKsH9u9rC38hWgP7+G8dlc4hfKIadhEy/4WxR5HeH
         X0wSulG43pZ7hKoKiZxBHz+hZ6DhLLLsqO1QKVn52EeSTGMcY+zgL/A5h4Q5+ZbuKd49
         vQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703799; x=1718308599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdytDqtRYVnzm7SE/5i1mvkB4M1tizM3b9ra2VRKybw=;
        b=IXY1sdOJRMs1Rwk2PwnmeJpZWsayaT16tGgpvhX/29/jWu3IcDYmmTwLHjYhEy5LWh
         XIe+1Cz8jpfvUlTfluCsnO9Z9mvIaYJBr1cV46hZEOniLxH7MuX9JN/m5LZzX/+w9Oy/
         6NVHz2J0RJT8NpbiZp6qAOhOEUZ+8CweH8MzqLg5jTe92Z2XH+H9STCcYyHs4GahIU8+
         a73zXtjEPL7aILEdsIjCIv3aQF4xYzSPzJf0aUwsA6YN5FxMsIF0PgA9xTCy+h7e/6cM
         XpNswr+xCsBbYlC9KFywSbSoKMgSnEXpfY848tTTDRVZWlkxK+QtotszkHM6+3Pmy7IW
         TcYA==
X-Forwarded-Encrypted: i=1; AJvYcCXTB/PZbLCFlwGAkYBd7L9/Ti7Ygq1bD48v/fw1ANOB3dltCb58TYF0lhBsWLshntVXNnxhyCwsAb6HclDkZO7phdXaTuYaxrpafi6NImZxEVkrKCue9ZjSi8InRkc/2o5LowGT3lw7vvNdnSCNC1M9YCPbjQ4QfFNJDLJEj+FGuTolSzY9QyxZdz9RFI/jGhZELMcRUeu6EmCe6YhzIg==
X-Gm-Message-State: AOJu0YzzUdvextnZiTqSSk+ImXXLKhDufK3V/g2OhuYdKsw/G24I+QgQ
	iL7jrKW6X7ShFHU1mDAsEwdw1K7ZwRqIw8bFq0dwp2Y7AGA4xJVCzNw+fkwK
X-Google-Smtp-Source: AGHT+IEAUSBFeu+UyER5srYHIDsL4ueH8psy5WbTbQUcX4H2C3ae5yNkubqlnwrL6NHxRtJi8gXRuw==
X-Received: by 2002:a17:902:e84d:b0:1f6:8466:e4d7 with SMTP id d9443c01a7336-1f6d03c0d9bmr7664275ad.51.1717703799114;
        Thu, 06 Jun 2024 12:56:39 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76075bsm19243465ad.40.2024.06.06.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:56:38 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:57:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmIUwHhjAUzZnfW5@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>

Hi,

On 06/05, Mark Brown wrote:
> On Tue, Jun 04, 2024 at 07:41:47PM -0300, Marcelo Schmitt wrote:
> 
> > The behavior of an SPI controller data output line (SDO or MOSI or COPI
> > (Controller Output Peripheral Input) for disambiguation) is not specified
> > when the controller is not clocking out data on SCLK edges. However, there
> > exist SPI peripherals that require specific COPI line state when data is
> > not being clocked out of the controller.
> 
> This is an optimisation for accelerating devices that need a specific
> value, really if these devices need a value they should send it.

I see it more like an extension of SPI controller functionality.
Though I guess it might also be used for optimization if tx is known to be
always 0s or always 1s for a device.

> 
> >  #define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
> > +#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave mosi line high when idle */
> 
> Realistically we'll have a large set of drivers that are expecting the
> line to be held low so I'm not sure we need that option.  I would also
Yes, I also think most SPI devices, if ever requiring anything, would
expect the MOSI line to be low. But this patchset is about the exception to that. :)

> expect to have an implementation of these options in the core which
> supplies buffers with the relevant data for use with controllers that
> don't have the feature (similar to how _MUST_TX and _MUST_RX are done).
> Even without that we'd need feature detection so that drivers that try
> to use this aren't just buggy when used with a controller that doesn't
> implement it, but once you're detecting you may as well just make things
> work.

As far as I searched, the definitions for SPI protocol usually don't specify any
behavior for the MOSI line when the controller is not clocking out data.
So, I think SPI controllers that are not capable of implementing any type
of MOSI idle configuration are anyway compliant to what is usual SPI.
For those that can implement such feature, I thought peripherals could request
it by setting SPI mode bits.
If the controller can provide MOSI idle state configuration, then the controller
sets itself to act according to what peripheral asked.
If MOSI idle configuration is not supported, then we just move on and let
peripheral driver adapt to what is supported?
Guess we can't blame an SPI controller for it not supporting something that is
not specified in usual SPI protocols.

But yeah, it's not that evident what this patch set is all about and why this is
wanted so I made a wiki page to explain the reasoning for this set.
https://wiki.analog.com/software/linux/docs/spi/spi_copi_idle?rev=1717699755
Hopefully the figures with timing diagrams and transfer captures there will 
provide quicker understanding of this rather than I try to explain it with
only text.

If you still think we need feature detection for MOSI idle capability just let
me know, I'll implement what be needed.

Thanks,
Marcelo

