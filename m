Return-Path: <linux-iio+bounces-17680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED616A7CECD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78C116D348
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CD2192E3;
	Sun,  6 Apr 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlvZX1HC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE5204F94
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743954376; cv=none; b=Loys9j6e0bfjrBIMTPb5zrJNeyDt5sGB3+MCHgrJwdxnT6vVxXYEyNLLhTstN/FuLNhg1DI33kjSuGIhl4WyMvZLI7jzlMdSB8zJyzLdJpSHOZbTyxA/eUondNwsbzesU8jePt4G1M/xJrpsEJXD+Mj1Z20BWZRx2Zg5ku4tfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743954376; c=relaxed/simple;
	bh=Lzbtf6qQIM7TBDYUBUW5LHOJ2K7HdfmsZTtbXBPfueE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og3KIj5Ak0Cg2KhrmYcssBnX7FTh+EhzsTEBcXYpbItrZgDRqNMMx3hw49yFlw3bOsOg3uT61fKTwxwBsUCmIpHudKKr4yKFspaKWY6loa3oiwbjbz34hOLLqwuWLRwkBmYcKRCveKygd7kgbXV3eYtIlR6x/4IMS4ipGrtvVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlvZX1HC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso678760466b.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743954373; x=1744559173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzbtf6qQIM7TBDYUBUW5LHOJ2K7HdfmsZTtbXBPfueE=;
        b=RlvZX1HCVBhUYXTnB+agzkhWYFAdrGk7VNg+y3W0tQVNhZ9/HzKlsWu2leOVUFRDb0
         IvMEdHIOAMaX7HrzCmzgRgSRqbObKMrkEMToxGEwZjUZD5xdSbCpXvQSAqrGOrfSz9Wg
         MdpfJH0tDCt3zuFEGC8Nc9yF0X14J0m8VOGAEcspjhY3k2ap6bDyNWLw7gaO2Gj300vJ
         33kifKMhH5LxURhRvONENw/tu5LfsKK1jAijW0RmVvWDabxHFa98O3KJqyrjrHQtCKlI
         3qcYN4mARtRtPLFlkG9jS96hN4UOCcq8c+5t9wE8PJPz2VNpX9vOnkEoEQizEcOgbzW0
         YOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743954373; x=1744559173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzbtf6qQIM7TBDYUBUW5LHOJ2K7HdfmsZTtbXBPfueE=;
        b=LC4u+0mRFB8Dq2Hy++lY0sxmeKhGiUD5kruxhQ4JZq5d2IuOpzMApUcqVDTeW3JU8s
         mB+3PS3NIMWPZ9o54FxzI8l9BhBj5FTQzqaj+QO78aa70xgzDNWGEmLmw6sXtA6spaNF
         2JUwFoyyF6Os2613lCIoiQPCZIMODzqjAZyEpxL4v99GoX1Z2/paF7yd7b03x7hhYaRG
         Cvps3vId6jGXwxMR8y+ZSNhYYcB7r4AMgwHQR+slJlsyZUzSY2EmDNLIvYgIiiBpTguE
         uW89mY2urSRvunUTnvDk9XDmhqz9yjI1QP9VFFXbXJpj/CKnvCKZbtZY62HwxfBZgqht
         YsHA==
X-Gm-Message-State: AOJu0YxYhobDXoZ+0Bq1WuhW/7ZGYqycmhp1gatsYgiCo34h3dV5slnm
	iFHR8TeawDiDtg7crdrDmj+9E+nAN2Km1nwGsIF4dSFZn7DkDhpGSIk6TAHzvuTYVQ/wyOMUSaF
	uXxRajm6Y2SY73HuNJs1he65BkrT+r7Sypqs=
X-Gm-Gg: ASbGncvgnp10d6i0Y3D9rIhKYceklyL6Z//LYPdwKDE4qQsEErG5ZbfVCjQhYoldH81
	b0HEhGImOT0wsIPjyM89qp6mz9FeF/B9YzVl5fDpdjgrc7oKOYWqgxDYah4xp3TW5TXdnaLipKL
	jB3DV0w1/+2ImzkMMwFp5xGRLOlQ==
X-Google-Smtp-Source: AGHT+IF2HIZu4JACYHiJA40FSFnZ/mtuSsqDDXmr2xCarSJsbP1oxeljTFVECXLv1JHOTHiCUZzX1AQp/ZhGsZpYn60=
X-Received: by 2002:a17:907:97c1:b0:ac7:95c3:eb12 with SMTP id
 a640c23a62f3a-ac7d6d05ffamr962236066b.16.1743954372620; Sun, 06 Apr 2025
 08:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406153120.2129133-1-jic23@kernel.org>
In-Reply-To: <20250406153120.2129133-1-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 6 Apr 2025 18:45:36 +0300
X-Gm-Features: ATxdqUF3zXVqVl1feUvOTIfhwiNMmxT97fMjA1EA-Hok84MfVQ_mjHLTjLhyzGE
Message-ID: <CAHp75VcsHmozPe9OYRv2Txm5+bFC4OM_4OVGQA6VmaYGTfWQOg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: IIO: Update reviewers for the subsystem
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 6:31=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Lars-Peter has not been active in IIO reviewing for some time. Without
> David, Nuno and Andy, along with many others who review IIO patches, I
> would not be able to keep up with the rate of change and would have
> become a bottleneck to development.
>
> Hence update the MAINTAINERS entry to more accurately reflect reality.
> This is not intended to give the 3 of them any more work or to oblige
> them to review any particular series, so if there are any series waiting
> a long time continue to poke me via the list.

Acked-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

