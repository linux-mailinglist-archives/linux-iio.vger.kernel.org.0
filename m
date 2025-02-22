Return-Path: <linux-iio+bounces-15966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67AA40A23
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E277A99BF
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCD200B98;
	Sat, 22 Feb 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHcJxDVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCFE13C81B;
	Sat, 22 Feb 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242565; cv=none; b=Hg2HGsPzSshJoR4tgiMlR6wouSlVJzBkRBsuShq29zvQVl6sT9ZQksaxLNLe9mNC0M4l4DpblF+iEEun8jdsHOf32G+OXVw9T0Mv0N+6TDZ3FsIFT4tEIu04SpFRf948KN7xS03vHwVZ1fvugI2EhY/vjw5su1RDIFtZuCwkD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242565; c=relaxed/simple;
	bh=SXO4k/H90p6ze4MArtk+DGjYJ3EkjF4JI1PHOcPhQQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQMFtLiSUjZqwwEgwPUY/X3RPNEpBjjs1iERJIlkWqGK732I1yqKnTBztOvFzBh0K5L5oYAP9cVQTW5Y2Qv2TxIYCgbmkXVGFywqWGP10FLKeVjFOR7wYqv5mhRkVNKYrtuV/eEV5F6cMagGVrEMNSvMjN6eOOfzXjdNqHNuO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHcJxDVi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c665ef4cso53128955ad.3;
        Sat, 22 Feb 2025 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740242563; x=1740847363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfsEwmSd+3dd9HbNE1KVoLma0THOs7a+DQjZyXGopPg=;
        b=EHcJxDViTh9bgvYK3NeCAkK/nEMq+48wDQE3NoXvmJ3nDNfTHVXRwxFzMznOwCLPc9
         Ql2iAthnsx/EVS5ScjHq3oS4OZRII6KVIiKB0QOoGjZlZ56vcS84QCRfEEkgAjhoat/E
         w9inY7sHzEQ2T2HDRxNlEWQYEPUMKmfAf2jR22ffovJa8Cis5+gqal9RmpKWllze2ihF
         abrVq/HtSEma0R2juEkQNEV2w0EfBaWKaHu7D9XPbzOqTT6hJU7XpbUJJLWy+Wsf6Z1W
         wzJMuO9eJN5/xFSw4jLLPdRkE8uxVMuYYfE+z0g5F5dXTuYii1i8m7xCmLb65WMQZ2iZ
         cbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242563; x=1740847363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfsEwmSd+3dd9HbNE1KVoLma0THOs7a+DQjZyXGopPg=;
        b=LIibBdGi8H/C20XB9zw8vpghGDgEF9FuqTMH9+irfmpSArDb4BuqBY860G88h/0Uqq
         poj57d5eesVHTSH/oNVnOHpq2G76orCtpSdLSZWUUUBGtYpDuP+HymwtwZwM9y/gydQO
         GFGG/cpMiq+zgp3wEgD7bAkx0eqm4uHE51kEcyK/gMhnvORlnM91tLqwJcyRFx8P9w7u
         DwHVlKgkR1R8gAb7lqVKVMRkOHL/lBEJZBSS+WiPq/c3Wf3viUmOe6RUymaaWPMI70Hc
         SrDnNqsx0yzDkdeQPtLNToMptJ6dD5YkP03Nsy+/4bbe/G5cXISx+fxjaXg868SL0CYJ
         kXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDV9uB0jX+YHS425sq3YQZfAaKuFtSlKqOew8ywd+nwNDmOU7wzelxlxzUuuu5qhuQkmYqKG9MROA=@vger.kernel.org, AJvYcCW6L36xnnx3tyjDnhQNi7ebiQG87c2WNIzHEsgA7QUl0/alhPD0PHQ68ijD17kgNiYd2d8xLPr3Ihbi@vger.kernel.org, AJvYcCWum27aIO2DgqMxWB34HN3S2vswHJBRvyzgL6cZVhF2tVDEvIDZY3DCdIvg8mR3GnuIQVIRc+wMkfMeZUpY@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBHhXuXR5RqU3wIGHBx9k+rFCyIbwSKKPTZwlL0xErggpUp9I
	nI3iLGZsQbe46N6J8eMpwDVWE2ByI+JoNJJVWoCGSG8wVuuh8NiT
X-Gm-Gg: ASbGncsLDDD98AfUNa4P/v44WtRl+WFu70uaticYdoTvsRK83IqDHGDMvjzB47LQB1w
	dXQ0ZXJougBBC95kEdp/KTWgBMrxaZ6UzQB/BILdnr/6HcsfnMOgogmI07lFWLpnFiQK0CGdBpi
	rXgDv9FkFR8fRrrGAeBgYJ3Z9n/kcKnx2Tgh+7MbtL9RnLfSc2fzcxebgAJUF2NikXgCrk5RhOz
	/FXIwqBkO6YTNa/GQu3kRhbzvziLvk5N1efaKyuLLVJssNX5zy8EIr2b2xtIhvXmzblMkLJ5stb
	BhQNGP9AB+4kj7BotSG3MMqpvDQNT1JmBaxn
X-Google-Smtp-Source: AGHT+IFZZkcKFKwt5ckW2ZZB2hTWc+lkl3S+KFyclA3Ykcaxpqupy0ev5uu6ECgwlxoEM7JpUk2YzA==
X-Received: by 2002:a05:6a00:174c:b0:732:6231:f2a3 with SMTP id d2e1a72fcca58-73426c8d3a7mr12626436b3a.3.1740242562871;
        Sat, 22 Feb 2025 08:42:42 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568acesm18158944b3a.56.2025.02.22.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:42:41 -0800 (PST)
Date: Sat, 22 Feb 2025 13:43:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, corbet@lwn.net,
	dlechner@baylibre.com
Subject: Re: [PATCH v4 1/1] Documentation: iio: Add ADC documentation
Message-ID: <Z7n-s5yOD7D9t1Oi@debian-BULLSEYE-live-builder-AMD64>
References: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
 <Z7bn3TEC4faXbzEj@archie.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7bn3TEC4faXbzEj@archie.me>

On 02/20, Bagas Sanjaya wrote:
> On Wed, Feb 19, 2025 at 06:00:56PM -0300, Marcelo Schmitt wrote:
> > +For a **single-ended bipolar** channel, the analog voltage input can go from
> > +-VREF to +VREF (where -VREF is the voltage reference that has the lower
> > +electrical potential while +VREF is the reference with the higher one). Some ADC
> > +chips derive the lower reference from +VREF, others get it from a separate
>                                                   "... obtain it ..."
Ack. Maybe, if there are no additional suggestions to the docs, Jonathan can
tweak this while applying the patch? Otherwise I'll change accordingly on v5.

> > +input. Often, +VREF and -VREF are symmetric but they don't need to be so. When
> > +-VREF is lower than system ground, these inputs are also called single-ended
> > +true bipolar. Also, while there is a relevant difference between bipolar and
> > +true bipolar from the electrical perspective, IIO makes no explicit distinction
> > +between them.
> > +
> > <snipped>...
> > +In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
> > +the channel. Even though, there are three general input types, ``differential``
> > +is only used to distinguish between differential and not differential (either
>                                                    "... non-differential ..."
Ack. Same as the other suggestion.

> > +single-ended or pseudo-differential) input types. See
> > +``include/linux/iio/iio.h`` for more information.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


Thanks,

Marcelo

