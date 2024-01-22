Return-Path: <linux-iio+bounces-1820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668C5835D9A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAFAB269A2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EF38386;
	Mon, 22 Jan 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ycAF07x9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B317BD3
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914302; cv=none; b=O3Vf3tIou0eyLOQCbt+U9CsZ7K3hp2EkHmWutRQWpaja79WT4HOOJzP37+H5YjPm/PoaqtUYjYjk4G4o7feg1QCta/WfuUvDem5ZJH42yW8IjW50IrhtEBqqTmVcXCEXLPamOVSsGESuQDTthGXzE55W7bOB5vfae8dT+V4Jtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914302; c=relaxed/simple;
	bh=QyE/8NyXVr3Tfr/ZnpAh7fZ33WpIHCb+Y8Yv2pKaXMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+XTCyKeljgxao0MJlUVNgZfSaYdsMmONV3la0Oguj6Qk/ANxx8ngJiyCcUOeG2/oNxxvuIp9Qv7ihj0qEBSwI56veUn712fqZ5ALbQD5g+7qOz2Srt9zXb1N61B6Z1pZJ8AbZt5vvTM0vSpKvDVDUKV86soCs6KzT8+UPN3Wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ycAF07x9; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b7480a80ceso2351661e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705914300; x=1706519100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvVYPG2wkBtcA1rgHmS9eb7auIL+LdUcG6OcQuzbBzo=;
        b=ycAF07x9vaCIWQDRYKziJigjQYhQfFzeSpPxTQDcv8VH5f6EAAJs6qJcDV+tSthMo9
         nJ0AfIZNQssU0ml1jpUBDwHOBjI/arxZ0AxRYpeQf77gRsVLkFCxlK/skFsf9zFVSEoX
         p0kItXGDbzhzKteomOvntwp06hgp5S++wYtQgfYyxF8iJw3G50ISFOFONgMZF810XcZr
         kHQgXsaaACN12mc12WVg3BrTe/tgQOgFWR2ozYSDE/jSjkXHRWfT+r22lbvs9/ZIXHkS
         5lsYLsSU/u0wW84TaL968KiGp+XRfoVMdUUeMnhiIW8DoihyxRDzCUm761p7OM65sCzH
         T68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914300; x=1706519100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvVYPG2wkBtcA1rgHmS9eb7auIL+LdUcG6OcQuzbBzo=;
        b=FD6+BwQ6jHafVPyKhoWkCL7OloXAuEI9IDkIvf0vD32apjWKj4XuGf6Rkguof+Kpc0
         oJOATar0LWkU2V88rSh3dweLWe3pf1sz+mMi1ADdJgrGrViePxP8Zv/RCzLACpwsFwLZ
         jOllKvUJotjwauiE67lD/qgrjUEMtGNrwJiAl9Yy70DMZzZLDi1X+DIRFw7nRL3bnTZA
         nmfd4IG9Zk+ALpZtNZEKZvPlvHbmlJ/kf0a2XCp+QMLMLc8DEyBhfdFclpXLqdiCrXrg
         VmvjSKZzAzwW5J9qH/mQxROReyPGYexGA8reQlen5+gNWSyPtezGjHFHQWczgE/vLdYX
         Wm4A==
X-Gm-Message-State: AOJu0Yw0rOroG/GkFanS2n9WHoburzPdANdyLCq023XDrY8hLzdskG0o
	Z1AxKczDzeLS50Hl1uKCfjzxjLJiRJ7Vt94qOn+VTyLJNQhPyk0v7+t2hGoqZEVi5/YxyTpLg6I
	W260T73hpi3az/chNHMEifeDu5U5wnH8hZgLAbw==
X-Google-Smtp-Source: AGHT+IHheS7NWJx+J+HYh4sCUPZZ/z2Hrr+vRuda49Q2v1TUQj+dqawrZbQpWmcGgwV6TakV/unBeLmjvEhCwMRjikc=
X-Received: by 2002:a05:6122:2785:b0:4b6:d49f:c218 with SMTP id
 el5-20020a056122278500b004b6d49fc218mr2349856vkb.17.1705914299751; Mon, 22
 Jan 2024 01:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121055005.20042-1-rdunlap@infradead.org>
In-Reply-To: <20240121055005.20042-1-rdunlap@infradead.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:04:48 +0100
Message-ID: <CAMRc=Mdj=nN0cHpVpV2cckS=z9vr_ZW4tNX7yS_1V-caLYiPsA@mail.gmail.com>
Subject: Re: [PATCH] iio: dummy_evgen: remove Excess kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 6:50=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Drop kernel-doc comments for struct fields that were removed to
> prevent kernel-doc warnings:
>
> iio_dummy_evgen.c:43: warning: Excess struct member 'irq_sim' description=
 in 'iio_dummy_eventgen'
> iio_dummy_evgen.c:43: warning: Excess struct member 'base' description in=
 'iio_dummy_eventgen'
>
> Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/dummy/iio_dummy_evgen.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff -- a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dum=
my_evgen.c
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -31,8 +31,6 @@
>   * @regs: irq regs we are faking
>   * @lock: protect the evgen state
>   * @inuse: mask of which irqs are connected
> - * @irq_sim: interrupt simulator
> - * @base: base of irq range
>   * @irq_sim_domain: irq simulator domain
>   */
>  struct iio_dummy_eventgen {

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

