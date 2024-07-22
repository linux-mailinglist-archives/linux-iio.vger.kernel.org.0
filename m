Return-Path: <linux-iio+bounces-7812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E19396B9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2593D28252E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DEA3D969;
	Mon, 22 Jul 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I80hkbas"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B01401B
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688751; cv=none; b=X9vZ9H252PY/xeg2JP25klmQRYrSv18g2j3WhY7K6uzvC+LaW9WM16CIcTXfO2fSmi9FfW2hAKUAK7CQvZ8x0gYY7teBLdDfTESMnExr/FxWUvNpp1+MfK7kpQWDuQiy5I1n/WDG1aZvWk5hwmQQH1dUSM0Wgn2b05LX0pP/K3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688751; c=relaxed/simple;
	bh=w9w+5JtTD68fFgt9vZdlRT+RT8adZeg2tVN67KcWsXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iypM3EEvhCOp9EizDwAiDEXYZBxD3KZFCVRymKrQuDXYJAXnKkewOeDnTDOP5DgNh0awV6bY/SiJDIE5jksC1jMb42r6Sec3jPP+lgHkP3XbAnHKG6PuQ1MuXQmUPJfOsahM9jYS/cVbb6T89QOdC349RAnd4yMb7qrCsVgV3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I80hkbas; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-703ba2477bdso2254003a34.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721688749; x=1722293549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OBWhGpUKlOIatVEnqxOU1UjIaAYS85luuscu5u5Jgw=;
        b=I80hkbasObnG+LLK7Uewyb1Nhzqh+BC8Jt7hWVOdjS2hmSPg2WIn261J2L9np5MRBx
         geq+bmOoomz2e8G3ObWyBzAkfpjJvmdIJ0BCTUjUC8ie37KPDH8AuNE+0yUUYsU00RMK
         h5FnHdS1gUTcC5EGTzyO5nqIMzQRDOrPfFVF+C0M5RPQHFMTsFOuNT5BEWgrKLlNlMVE
         vZH9Dy4HhdC7yEML53XODFK6bAPgm3ZwQNTAMhWULkAEItr++DEOcLkUcQP0weV6tpyQ
         IH8WkjcSsKbxBiikhTcMKVkwz+snUMfjFT3yU2CctRUV8Lhyie7K01KXcREF5UQON/1I
         VXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688749; x=1722293549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OBWhGpUKlOIatVEnqxOU1UjIaAYS85luuscu5u5Jgw=;
        b=Yv7YWq9o0Tz4WVgmlWkIY0qWgj9WHw5NIlC/bLTAd7pU3JTCQxgJv/aoS1isAxN9vE
         OZ/drc09U1+150Ooo5AkQlpJOyFKv2EmPOD+b1WoDT91GGkfQy7WvZ+1oFgomoW9E2FP
         rM/uGnahX/vCYuRmB6exO5N0StW3iW0023IJ7zBYszx+ousW9Z3v7rg1ulSgvoJfbeA2
         uZXwjjEP1Vg/CZQyYWXHwTuNiFqBQLn/+MprWuOg6LBKrdNuzrZqXuyKqm2bqdwdPesn
         nT/2L6hLwHI5ltMq5eEUje2vmhtSR9nxNrMkjzF6mQ8mW9gExu822t2dMFh+sGiIO55z
         Z46A==
X-Gm-Message-State: AOJu0YyNc4wW5RGQ7kBjIb7zgz+pf4OA2HViiXjNDOvbv91id6NYPWK6
	z+ylMTIxlA9TcS8FOYEace4WwPMiSm1QK2SCYPCBWtuertC8PDKFzlLAAA==
X-Google-Smtp-Source: AGHT+IGJXd1lpC+vhK+cZ1l9fYkfO3bIgefFHPQXS8JR6crYPXL9K6Rns6o24dDc38jZ7vbmx3cBsw==
X-Received: by 2002:a05:6830:3884:b0:708:60b6:146b with SMTP id 46e09a7af769-708fdacc860mr16067756a34.8.1721688749621;
        Mon, 22 Jul 2024 15:52:29 -0700 (PDT)
Received: from archlinux ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5526f7sm5845509b3a.118.2024.07.22.15.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:52:29 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:52:25 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: Driver for AMS AS7341
Message-ID: <j6xv64c5ynszsvdvya52qsmptx45azrcklimy4g2atqryzugtr@qoxf2kp7kecj>
References: <hix5scxn4hdii2b2nlaxha4ao73frko6ndzpbuyvhwcl2hveaa@o7zzkkk2fkk3>
 <20240716190115.3e565521@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716190115.3e565521@jic23-huawei>

On Tue, Jul 16, 2024 at 07:01:15PM GMT, Jonathan Cameron wrote:
> 
> in_intensityX_raw
> in_intensityX_wavelength_centre
> or similar?
> 
> I see the datasheet conveniently provides a centre value for each sensor.

Hi Jonathan,

I think a wavelength/wavelength centre modifier would suffice my needs.

> Maybe it's worth considering how representative the full width half maximum value is
> of the data that we get for light sensors.  Perhaps that ABI also makes
> sense?  IIRC we do have a sensors with strong dual peaks though which
> makes this sort of description tricky.
> 

I can add the full width half maximum to `iio_chan_info_enum`.  While I
may not strictly need it, it is nice to have and other sensors might
benefit from it.


Thanks,

Gustavo

> 
> Jonathan
> 
> 
 

