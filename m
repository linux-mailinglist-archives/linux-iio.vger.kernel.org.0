Return-Path: <linux-iio+bounces-25446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE15C0ADD0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8BE3B364A
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D824DD1F;
	Sun, 26 Oct 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyz/GNnF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334C212566
	for <linux-iio@vger.kernel.org>; Sun, 26 Oct 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496674; cv=none; b=eWEigFdDCeEFKJRxKlu5GhMmLjYhexyKAoC3dP8XRfyvrQF71akRkV9DzfbXHMjkwGJHdsmsTzvRxLEkGOS8cQ9vYBT5STQbz7kn/fLf7rZeyp3vZQl5EV3GcfNOplzuamJFECGCl9fkn7mET/jR9zMiI8HDo1bPl0ZkLTdgQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496674; c=relaxed/simple;
	bh=Jn7ngMBWIUhPYmq3HsmvV2FyXT31L+46gLuKAYt+qfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgSBUggMMLvdtNL+CkvEwr43GDzXUXhv3pgmzQ4fi6l1vUjcZkPRmWRAcG7ZAVm4ViESHZKHOIE6opuTAcjNpQgxb1TufjCDF2RBWoQT0V7rmgx10kguzH5wF41uL8Spq2scoODJSLfNwd0RCTlVFTDoaSdkoavh9IXpJmSx8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyz/GNnF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so501714266b.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Oct 2025 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761496671; x=1762101471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XxEe6D+FFfQqIEEbE4sKMO9/YUuuqd9OGSQoRJvBWE=;
        b=hyz/GNnF0aCD6+j5VZLNSwr5I/e++NY0+Qh5HeeM5t4U+kBRfipDmegwE3UmvV79J+
         uWdgZyQFWUyItGQ8QqCKzD4v0q1EzanyXytVCg6VXiWyCbMtHklksjRaw/HdFOJw/G9f
         vVvx8V3aqjmD/D9YCaEXisbwmGR4lduR9yc4bmLmLczjkzId1SvSm8FzdrfixZCZB74T
         9ICmqOpivpdMPx/idChI57Yvdh9IF0d0fyyrtaGDUidJklATrmWwnmIpqm5F2SwQHg9v
         5zTtMlJqo9EshP3asxflvPpjI0lkoYpJKg3Ktn7W8PlwB/ylXFagSHUo0SbOo2htYwnB
         TzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761496671; x=1762101471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XxEe6D+FFfQqIEEbE4sKMO9/YUuuqd9OGSQoRJvBWE=;
        b=SBieX5BZM4CTjAAo4fdWYq3l4SwU+Y73mpjMNVW8La3M+MEuLjT/xGgezvj+WB4c41
         1b1FXIqvA7vZ9jwxxKBo+LzefAUhyHMmTiZdNG2W7dXJjNU2T65sBlEf4awYZMhQEg8h
         qjpON9G8K/KJm9u/zZrPqlSRm9fiXcsRYZrbWifHjg73zxC9IsfKyumF20ChO6VaJAaW
         +5kv2ca+n7FBh5zT5W1Plo6p4t5NLdx3rF6/NZUhn1QWDlNlRJ3PQw0oE/2Z5C2At+Hu
         EzhKXQQ0dV4LHspOM9Q952vifoFFDlS4tykKjuW/JiqP8mkq/oU2kVmDcakNGcIpf1Lg
         Hi/g==
X-Forwarded-Encrypted: i=1; AJvYcCXU6Siitf6QKB3rubEGhHymZP2ZVOn2+C2dUxLx2/W9ItuYfYawUOop5lOtaUXyPkOXVcbGl7YMfT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwL714fh0S/oHUjU7YWzUp9Ee3pzoDLVKi86F/AHMr+Jlh2OdO
	SY7dA5X4IF9nScG3wWAHPaPi/k4+ZVpk1qJWK1gH4uPNZ48Jsw94yPJo
X-Gm-Gg: ASbGncvsUsus2WYVa8E1Ip+BuCSjvzVQ9uKSzetFZi1nN/Kj0/tecRmZqeh5yckWcf/
	NclZ4vBULe8Bm7F9s8jBDy/qZW0YhxSRr5ZkOuRHfO+6nQB1kB/4E6X2cvXoG75Cni2d1vrKbKm
	gjSCYRruhmPGaaYewDDkkdgg3qJlLfbUi7KkI1tDVJJy1v8iY/eJFj+yJqVFyBvh/2l95L5eIGx
	9FlBeHgfW8UViKMGJteXN4RhLrGGkFT4uXXiJ/dM4JFrDPKetyoAbiLVY/bbHHh2SfPoZ0/UHGH
	nV12UABokpRNDmhwndc32Upq6GXnc2TlLqBFOaxK1EeId7iOfPnpUzCwycJjVGEzpSV7Qebrud9
	HZEC+7EUP1q8YRLsIoo3OirvHCilVCquZFO4DswOq783PooYEzHQ5ffZZMwCN4xKlXYLo5iCs/C
	niXVEnLA==
X-Google-Smtp-Source: AGHT+IEoV/OCny3StslIHhY+HhBv9Tk1poW78TbiqX3CKYhoXcDxOU8er8pKIVdW2dVWKc/kXQmqZA==
X-Received: by 2002:a17:907:968d:b0:b6d:6c8f:6af6 with SMTP id a640c23a62f3a-b6d6c8f6f3fmr960640266b.16.1761496671063;
        Sun, 26 Oct 2025 09:37:51 -0700 (PDT)
Received: from home0.fritz.box ([2001:a61:123e:4501:d88:2861:1686:c41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm498050366b.64.2025.10.26.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:37:49 -0700 (PDT)
Date: Sun, 26 Oct 2025 17:37:47 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <wla7ldkhm3mca6eadlx2cith43pcvdg4tertmrhjufqa7wqnc7@fcfacbnzcjvo>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
 <20251018161143.0a89495b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018161143.0a89495b@jic23-huawei>

On Sat, Oct 18, 2025 at 04:11:43PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 09:27:59 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> > monitor capabilities SAR ADCs. Each variant of the family differs in
> > granuality.
> 
> Resolution?  I'm not sure what granularity means for an ADC.
'Resolution' is the correct term here, thanks.
> 
> > The device contains two outputs (gp0, gp1). The outputs can
> > be configured for range of options, such as threshold and data ready.
> > The device uses a 2-wire I3C interface.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> Otherwise nice simple binding. Nothing to add to Conor's review.

Best Regards,
Jorge

