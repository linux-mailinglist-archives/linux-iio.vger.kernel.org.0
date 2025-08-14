Return-Path: <linux-iio+bounces-22709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FBB25A14
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 05:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45275C03BA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FC139579;
	Thu, 14 Aug 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPgj8sO1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168303D6D;
	Thu, 14 Aug 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143401; cv=none; b=Yjr/v0hFsbt4unjZW5cl/bgOnOtNrjdPk3RoSiP3u4PZ+7wYCRz5giyuvF7/NeM2Pt4V61D3t+xYZRj0X9q7OwAMrukPvcFUtoEQDRxmuNbYss0naa4wm5fNwT/Nt24YMkyjHYF+VaixuE9Res82G/DA7fh/VM1BmsOcFu023l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143401; c=relaxed/simple;
	bh=HA6PI6QVTTTOhrD40NxnFG89l0OdxrCLf7J4HkVH0cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyhGLojfrJYYoAGKKvtyoQ+Ztm1NymgDIFQde5dJZ3eSO4RVACECvPB2/bZQEnzQ7RsjJAsxnoWXHNLaXJllYb12cdRYN5uI80PmBrl6JZy1WnKpqkEGSyVI3QH3/LUCQvlA/6pX/VljAul7bFvppricf8pLHfpggZLQn7c2WKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPgj8sO1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f8f02afaso4220961fa.1;
        Wed, 13 Aug 2025 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755143398; x=1755748198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA6PI6QVTTTOhrD40NxnFG89l0OdxrCLf7J4HkVH0cM=;
        b=dPgj8sO1g+qhjv9MOxYks2MMFiQm+EvwO3OxCmX+QpBf6MtT/X0ZWolImtVX56TD65
         JewiETgEB6CiXT3abIs4lfP/+0wENgk/XnUOC90D/vq0RWgPTKg471kSc5EbZCbqfH6y
         BodPkUV4Wl2cu+IsXbop4jfX8Fcy2Rcrh4lx4ZSH5YgQlYQmtzWgd9OTYhUPa3kqK5zL
         iAXGmAtceGAbqByIthzfjbe//SP30OA88UuAlg29ygE5Fh/jvVJixoJsIe61rzF1cHhA
         rvaYyrZtEsV5pEyF+y9n85N3q/j8LbM5V0gR0xBMJYq6StCn+PUWloJcDHqmldOvSUnx
         27YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143398; x=1755748198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA6PI6QVTTTOhrD40NxnFG89l0OdxrCLf7J4HkVH0cM=;
        b=jWaSfw+mQE79Nizee8DeaIteyIpaRY5IRYxDhFgWoQhUlRA507KFP7cfGzFxE2j1Hy
         AtMZzIzqWW45BZ9PCXkReiQute0teAoGy9DKJi37vqrXX8nHx/5gKLStbWStM8guyGSD
         49YB7xKCvpA4u4Jlh9yhNUIxoKE8m3eQvfm8bTWIT18M+87aQ4ote3a8y8rSkzLa+kZL
         60v1/x3Uca6TIN2TGB/O6+Ndw0X5NsjpC019EJKElrbK54RsurfL+CFPkG80FSJsjgX8
         8aTm360TYXn0SvK5FaRSRjT8Ko9axagxJuc/BDQCh2OKYldpf2MzyNwMHDsajT8OX6lR
         K6sA==
X-Forwarded-Encrypted: i=1; AJvYcCU1jlh9jnpD+baIcDaHxzdyGfS4j+X9FA5Q+0sJm3JoU3pPf1oHTo3b8Lwroo6l2FWxaM3ubXa1XBGDFdK1@vger.kernel.org, AJvYcCVeUrt5LHVF9cAVMw9IGPsjtIDGCzEZLRc1Akb5ojmL8OUad1Z6cZMnUcvizHKjZ2JyvTeVfBNZVrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXait86zPiqVOQRGR4Mh9qGSy/AHc3WeRXqUof121eUDuwJmdd
	yBC6BnhBai9U9dMGzCPAVEuqHgOHr2vVP1LSHUiFiZvRCuQsRLLnADw1PscimnriXO523KKmndi
	re8yzU6tk0eEM+CQYrlWWjxVBaeT8gHg=
X-Gm-Gg: ASbGnctHYiCuMwJoqomCIp7eSeaxRVqry791L1g+Hr1XAdWiszxlrVhqf/B7wYk3uPS
	aSXuJHC/i5zXmOPR+VtzgCnFhvCr6YlGWz5Y8y9vzCWS4Q+bCzhAbhR4zemoowqs9g1WaL9BcRM
	/0jufEU/B5PkqWh8GWtwf/2zC52FXQmDIZvsykTYjaEh34P9o3wlrNhr61IHXyWD6EkQeoWQ5vt
	w042OBS
X-Google-Smtp-Source: AGHT+IF8ciJjxEGJQBuEWTAG6hzvZvUV99a1zpZ0jumYrtsIOBX1feJpvESEO5bW3T3cwxfleqv/r8RXTybO7GSWUss=
X-Received: by 2002:a05:651c:41c3:b0:32f:41a4:5584 with SMTP id
 38308e7fff4ca-333fa88a597mr2717711fa.27.1755143397604; Wed, 13 Aug 2025
 20:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133017.72476-1-akshayaj.lkd@gmail.com>
 <aJyYJLMUYAm_uqUx@smile.fi.intel.com> <CAE3SzaSNV4DMUQB5rQQSV+QsCS6Z2BjFkFD3eaXO9J=TjUbNYw@mail.gmail.com>
 <aJ0G542k3K4jGrrw@smile.fi.intel.com>
In-Reply-To: <aJ0G542k3K4jGrrw@smile.fi.intel.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Thu, 14 Aug 2025 09:19:46 +0530
X-Gm-Features: Ac12FXz6Qxm8YfcTyJfLUdqF81gpHau-ZpVqNBuvz8IFOyVnoUQu4yOHXPtKGlo
Message-ID: <CAE3SzaSvhSY2V3rVbO3T-qso-uoo01YeMR0=H-PHwBDj8ZsbBQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Add device powerdown functionality
 via devm api
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:13=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Aug 13, 2025 at 07:27:09PM +0530, Akshay Jindal wrote:
> > I thought so, but removing i2c_set_clientdata would mean that
> > dev->driver_data will NOT contain a pointer to indio_dev.
> > Irrespective of usage, ideally dev->driver_data should contain legit va=
lue.
>
> NULL is legit value for driver_data. The rule of thumb is that we don't a=
ssign
> something that we know will never be used. Also think about debugging iss=
ues,
> with the "legit" value in some pointer it may lead to not noticing a real
> problem or to a problem that never exists if driver_data left untouched.
>
> > Hence I kept it.
> > If you feel otherwise, I can remove it, but I feel this should be kept.
>
> I feel definitely otherwise.
Removed. Floated a v4.

Thanks,
Akshay

