Return-Path: <linux-iio+bounces-18603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B5A9B4E8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4703B7D80
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128CC284681;
	Thu, 24 Apr 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEN0bp72"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22B1B4141;
	Thu, 24 Apr 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514139; cv=none; b=i4jeoAcQ34PvmR3kP9/Wgx6s4Q392tjYxkqynL04BLqFGzOqSECfyOXkROVjXLywv3WbgorViXK+KVplGwNgSCDy34hu5zAY0PjrbDwwNNdcBrUWvcM6lT6R3krQV7G0TC4pyYZny4h5I+b8oRq+zX5esgX0AgHP5p3ZnkuFnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514139; c=relaxed/simple;
	bh=WkcCSbDN/ZU2oZjime5zidqS1XL1m5hB3C//OeBt6zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWKTje8AIdpWErs9R8kO5+nGagKbCt9LMDe3FgK8f31W5wVLnjj3HYZ2y4W7jcCcPhzx7VQdSiJ455aLhOX6Qiui3X/T+IUb7nI6nzqWZ8utlVfPA3wjtgCOMN9VOe0cIuk0ZwiAqSixUmApeAQJ1k+bGHyWvRT/TNIP5J3k9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEN0bp72; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3b12e8518so233923366b.0;
        Thu, 24 Apr 2025 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514136; x=1746118936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkcCSbDN/ZU2oZjime5zidqS1XL1m5hB3C//OeBt6zc=;
        b=LEN0bp720PNd4KmSfFguStYu1ndsNW20FBzFUgKLLvKRhzrFQkiK45VN6eLsck1Utw
         TDUIS6mL8Rhb/V0zksLL5O9aJM0no7ZrBBjNuUM+bVRu8IXC3ZhJ37dm54c8NAJ9R0tw
         1DPG2Cv45hm0PEjI64qGAX1pPgQmz5EhxwxcxxOxisGplMXaAYg/Kz940ROJq0s4Zave
         rZ+36shbUZ6bIV3Oo+sZ3R+u9C88F7sE4VaIesMilcKu7EE7PzhaMhgMSwhkAbYI9uPG
         aZ+fPr968iw5KXFQNqm4+gPYsALLxWPh7mL56AGXWMhJ/YpBZr+MTLQTwnPJNXlQP+ck
         nFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514136; x=1746118936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkcCSbDN/ZU2oZjime5zidqS1XL1m5hB3C//OeBt6zc=;
        b=pyPK9ysxAjOZxp6gZtA/TWq+d+Z5RkBKC/8QSYQhgTkJxOjFbMq9eXtOiyhFQ/Sn5q
         8VUMdYHylPDVxaBP6WsZiHm0iFdYnp76qIPyo9vT4SmFn9QvGL32P2L4APOTDyJeq2oi
         hTp8xvvuiFOKp9Iz8DBhbgI6pMLNl4851LUMzqAmzRuVFYxAXL1pzx0dhOxsRQ75cnz2
         2a7fq6r1PjwmbJ0+EMR3ybX6B54xikpYGzEoxkgVlIbkC6wO+q5fR7vGqElW0IbKVNjH
         6/n4L2cw/VdnEYy/tgn3s82KVHNXkqMZ5YbqxYZnpTkUPFs1jl0/3vHFGgu74L1Qh9+l
         5Fqw==
X-Forwarded-Encrypted: i=1; AJvYcCWPHTgBhPsk6Pb0nEWQPfSE2hCw6gQLbw75tN2OSXRzaPoFE33eVMuZDVLy0o3AJkwCZy8rrYta2ow=@vger.kernel.org, AJvYcCWt85dv1E7tlmiVnWrudFDIj0r3jTK4cQC5BQSAWyLbjHJltwW45Eq8q/ztMBiniB7pmAGVa08I67JDNced@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5ooECD4DFZ7HCbF2XQZU8D1WOe3N1MObULa5wi+pwqrOuF1T
	wqnnNABVChiyzKN3xQ+khOxSv2bEaJ0KYHZQIodrIw2s4obVKateRxnzuPM8ltTT6NYkHbhkAuH
	KwPP0G1qndXm0CWB2rd34CJeNIyA=
X-Gm-Gg: ASbGncsfO2B89/2ggKK7fI9t367MD6zrxIumI1bmUEDl2VSXMw7GbNAwDp3CMAeNGmH
	9AgMm0MXqXJ5bD6YnoEpj0k3T/fuV6yxyi4gh6X/GIlltyMPuD+F+a0IgFomb+H3DmmdKRZxKub
	5XEztxIw2ZbWCNscwz4uK5uHm4
X-Google-Smtp-Source: AGHT+IEHxo13L0sXvAke4ty9b+v4Z7Y0lEATPj2aXj/69ooRG7KecObOYygckKmL5PhgxgGc7inKBrIS/BRos9kUdGc=
X-Received: by 2002:a17:906:6a1f:b0:ac4:76d:6d2c with SMTP id
 a640c23a62f3a-ace6b54761amr31197866b.40.1745514136147; Thu, 24 Apr 2025
 10:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424151604.626758-1-olivier.moysan@foss.st.com>
In-Reply-To: <20250424151604.626758-1-olivier.moysan@foss.st.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 24 Apr 2025 20:01:40 +0300
X-Gm-Features: ATxdqUEBDL7z20qNs0yG_M2X9nqYMo67214nlsnEXBB5e6fuFVOwBd_KZJdSur0
Message-ID: <CAHp75VfwiMAa+y+_sHpJ27D34=PtMG=nskXbV+GuNgWpH-85KQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: adc: stm32: add oversampling support
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:22=E2=80=AFPM Olivier Moysan
<olivier.moysan@foss.st.com> wrote:
>
> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
>
> The current support of the oversampling feature aims at increasing the
> data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution, a right shift
> is applied to keep the initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2^n ratio <=3D> n right shift)
>
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
>
> Oversampling can be configured using IIO ABI:
> - oversampling_ratio_available
> - oversampling_ratio

This version LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

