Return-Path: <linux-iio+bounces-17471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9EA76706
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AC7A4574
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3B1E5B67;
	Mon, 31 Mar 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkBB50+Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDC8472
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428543; cv=none; b=g0M4D/52RJm97rI2N+wStJ9Dr9Fh+CEtxr14vpmykrefFmuNCLT+5f+7mlK7bmbiVg09ZdcdMAiJqVhbXi2QHzb+aA7T+jks7aeUW83Qk7u6geO/PC2pO9gAEsam3lReWhZ9ib/P59XTxfJBUhq9YwdRTH8zFA6sKeCINafwVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428543; c=relaxed/simple;
	bh=Qh9YwYki2IU+j0SJWMEDxXFY/G84Of4+4t6g2v8JRIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp5uILGy9q/UcITGgmcEwbPKAA+dVlSYTBc9ElKyOlb6igvDjcPP/UpDGfvnAvYFRiTQN18c1gX+/wC+qfSsPEsAJfVmZgS0VLrUWxQv2unVD+TjbWpuj+i4AsB2v0+ArSo1Tl/wPUC4J3840clA9LuIchGX1AdK+YtvLNGOfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkBB50+Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25520a289so751022566b.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743428540; x=1744033340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNso9buWx7rEsJco4uGEo3+u2S5DmHeLl5hKdot6WPE=;
        b=KkBB50+ZMFe/JSbmcLT7xCLj2l1W2QRQxvMMIGL4RlGfOJkHSrNS9PvqloMquzIuDE
         tIa4CNmz1SXYd3bCdRK8DYx2d5htXlSRH8+EKLWAEttJRUWQSX8NI32jocWupDoZFVYi
         vIDii7mc5ANvN9cZtGa0IrUhZ0exp8adw+qdVXibr7eKFOig+jQrwa+CNuAGgoOeyJe1
         ZE92HKhdVbd22B7702ARhAFOHT/hhwJmo+tsJ1kH/ChUdz+3Q0mpydTzndapdOQTFYI5
         8uKiV3XWw6MJlN9fA2n+YORuAcSwp/ecwR4bX0k2Fx1dJm/uGG5xHVV9oj11dsEiXpyH
         Ue9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428540; x=1744033340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNso9buWx7rEsJco4uGEo3+u2S5DmHeLl5hKdot6WPE=;
        b=GPIne0fTBG1qMM4aBcMA41HviiP4ALxmifR8Jd8FdukZmwILhEASHUjWqlD5dLK/i0
         z11kBSXJKGDzYigHwid5g6B/qGw/a+LV5oSzK8Cu+Owt6QwQmZ67b7AbgQ/Nt4v7ke5t
         Usr9enxnupe6XCxOjspPj7yLW4jNZ04KilHYlcnmoBQ607DDNOJjMR8ryNlndKcFrfr4
         ikd/NpEQu9O6RnO0Ocf/ux5lxTWsjzwf/JEmm4Iku7+XO8IB9drJPBD8cfi8L/Gvb0JY
         JVUl1JUO3KD7uJv1YMtobMuBu05920EK7iU6YhhcGNThFl7NyHeTvQwwX8CA0ru/z3jB
         mhPg==
X-Gm-Message-State: AOJu0YwKaKC18Vd1Ax6VOV1NJsaGBUzXq8rpD0wHRSP+thTn9UIzh/kz
	f6FGfHV1eo3ZYk2M0EgVbbBSSZ429A1r3zU02NE3GeCISmRD0KpA7gaQicZFzht1AsUD3JAIvwI
	oNPdCrRP/l5I7J7jaRiefJKBx8/s=
X-Gm-Gg: ASbGncsNhoQJaLaalae1oDtVdlPqkyjuoBzJEwYPd/a3/6z2meNLlxUPizqMJc6uMwE
	jJCav6FRjzocyjaB53AQPDCY8xNN9xACYOkGPtB3Zn0J/lM7qBjo2eTsWkZVT9ssxo2MzDKsNlR
	kD781gz80Vzg9gvxDTiDSmFrTLhjwu
X-Google-Smtp-Source: AGHT+IHMvxdNd1hSrDFi9wGObx+s10umSf1HV1WOHaUT3ImjaxO8dHcsx7QzOP/TcXKcq61XnIgjLQvQcDydCNgYcnE=
X-Received: by 2002:a17:906:7955:b0:ac1:e00c:a566 with SMTP id
 a640c23a62f3a-ac738bbe6e9mr839662766b.45.1743428539842; Mon, 31 Mar 2025
 06:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121317.1694135-1-jic23@kernel.org> <20250331121317.1694135-38-jic23@kernel.org>
In-Reply-To: <20250331121317.1694135-38-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 31 Mar 2025 16:41:42 +0300
X-Gm-Features: AQ5f1Jqfyu3RYZY8ftiVKC5NtxlQCfJGjiAwIQBMAoI7dHwTa7yEoEBVmMqeqMs
Message-ID: <CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com>
Subject: Re: [PATCH 37/37] iio: Adjust internals of handling of direct mode
 claiming to suit new API.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>, 
	Jyoti Bhayana <jbhayana@google.com>, Nishant Malpani <nish.malpani25@gmail.com>, 
	Eugene Zaikonnikov <ez@norphonic.com>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Shen Jianping <Jianping.Shen@de.bosch.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Now there are no remaining callers of iio_device_claim_direct_mode()
> and iio_device_release_direct_mode() rename those functions to ensure
> they are no used in new drivers. Also make them now return booleans

not used

> in line with the sparse friendly static inline wrappers.

...

>  /**
> - * iio_device_claim_direct_mode - Keep device in direct mode
> + * __iio_device_claim_direct - Keep device in direct mode
>   * @indio_dev: the iio_dev associated with the device
>   *
>   * If the device is in direct mode it is guaranteed to stay
> - * that way until iio_device_release_direct_mode() is called.
> + * that way until __iio_device_release_direct() is called.
>   *
> - * Use with iio_device_release_direct_mode()
> + * Use with __iio_device_release_direct().
>   *
> - * Returns: 0 on success, -EBUSY on failure.
> + * Drivers should only call iio_device_claim_direct()

Missed period.

> + * Returns: true on success, false on failure.
>   */

...

> -EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> +EXPORT_SYMBOL_GPL(__iio_device_claim_direct);

Can we move it to the namespace while at it?

...

>  /**
> - * iio_device_release_direct_mode - releases claim on direct mode
> + * __iio_device_release_direct - releases claim on direct mode
>   * @indio_dev: the iio_dev associated with the device
>   *
>   * Release the claim. Device is no longer guaranteed to stay
>   * in direct mode.
>   *
> - * Use with iio_device_claim_direct_mode()
> + * Drivers should only call iio_device_release_direct()

Missed period.

> + * Use with __iio_device_claim_direct()
>   */

...

> -EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> +EXPORT_SYMBOL_GPL(__iio_device_release_direct);

Namespace?
Note, the good outcome of the namespace is that we can easily see who
(ab)uses these... OTOH, there are static inline functions in the
header, which provokes this to add MODULE_IMPORT_NS() into the header
as well. That said, perhaps also get rid of static inliners and have
them to be real functions?

--=20
With Best Regards,
Andy Shevchenko

