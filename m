Return-Path: <linux-iio+bounces-3366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3788740A0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 20:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFCD1C211AC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC36140360;
	Wed,  6 Mar 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jwvw0I7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB013E7D3
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754055; cv=none; b=VRQGMQLF+ujkmibmB4sJvNlbPnPPuUFgnhLRgXWzKpa27t67Vyh9yaUD72iNmYz5mjC8O7Zl7lVmqO5er/JWwOTwzOHSHcAGKcA8LmX3dqNKpqXpuVNoXhtrcI939YDnaKdRjSiFizNpmoCk1JzsVOk85PXjicYu3VWSdiOIDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754055; c=relaxed/simple;
	bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqLFANWkSqsNCSy7RTVP8nwluEgk6909QkGOzr+d13hmVUDxvLz/PX5M6ofk7WCVqjzTa4OCnu0kxE4ENAVqfgiK17xeMHQRxZMnsW9v8H1WMRaODOZKYwyCxJ9ggZPTc4Wt+3PW4WG9TzNJeFznSTr8CYNJYkwxXORH5FiaTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jwvw0I7g; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d33a041ebbso1321323e0c.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754053; x=1710358853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
        b=Jwvw0I7gSP93wzf+T4MT9BPf28KCNJ7qAl/e+moPGm6O9snpKmydgN4aBOX8YuXYue
         wcqNF+TZ836yPmDGvASCv5SoG9SkIO/3qieXiojIkxpfEoGfW7h5HI9W8+ODADrjN8jq
         jpXkn8jfRz1Ap+bhgRVO4cqaTggnn6QUtdJsc+8YAss2KFE+qxDEJayEIoFPCxzM8fLC
         vGBYUS4lFYBIVXLA2m/M/2NbIbgYF33fVMGG8xN7M+DpdUjw+qhEug4wcGhoJAvMhH9Y
         MTjqQPNh0XDUg41NG8fLZIOMxDQbF1FmKsYEL7ojvcOoKQ/zwsJMbVOPPFmUF3HVeVTQ
         FVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754053; x=1710358853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLww44fHzXJw1Kt8CwXW/KAA0YiI8Bp1KLHYfbruk68=;
        b=EwWWs6/+IDPR4z9CFYb+7FiYDMGj0tMmJGl67VwC9EvqTZYosiTT+QCsfwwXOieHok
         R4dw16UuibsfSlQ/W83UXAO6itLSHrkxzXt8HB+XkQfd+ECGQOoLJwdQouFDumOjbxq2
         vo9e6djeWU0Fl1+UmhV1W5YD3qaVqrFonaGxXcYdQ3Nq5o1oignAUHsgSkhBu0YiC5zH
         Bksa+ZoaEKHPidBHD2jTQFS4Tm/u8JefQsS7UNLX+VawupFmHuOps6vY6RgLpbwb4BS9
         /gfNRgTzpfCeZTvMNZC55woB63C7JibqOUYxqkCBYA+S0FnSMaotjM9N2FGoTM6BnWDG
         ylyA==
X-Forwarded-Encrypted: i=1; AJvYcCVa0HQ61S5Lv1SI9389PFmuJBKXkBmZm9iurwtqXmhBovP9vXD9YADYnFNdNLUtyXZJt/IGJQmjx+hdvRzRud/bLRUlK7LI7mBP
X-Gm-Message-State: AOJu0YzqYTWjF2lxxNH+Q73tT0PhPdRPbsL178JHQi2Yz7NM2JaLK7PW
	7MVcMTSszRwCUv30PbwPc3C6x+5pOfiKI7VVeF/++zwuJ5U5Yf9suenrdL53cik=
X-Google-Smtp-Source: AGHT+IFX+X96b30F665Z3v9XkkXlmdpro8bRgsJ4O1L64Bn+CTNhw2E2bPqB2AjrkrHwsVj2Sgb92Q==
X-Received: by 2002:a05:6122:49a:b0:4c8:e834:6ce2 with SMTP id o26-20020a056122049a00b004c8e8346ce2mr5202856vkn.5.1709754053042;
        Wed, 06 Mar 2024 11:40:53 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id n21-20020ac5cd55000000b004c0460eeea3sm1641635vkm.43.2024.03.06.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:40:52 -0800 (PST)
Date: Wed, 6 Mar 2024 14:40:50 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] counter: stm32-timer-cnt: add support for
 overflow events
Message-ID: <ZejGwl9cjNmnIEz9@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-11-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AHJchM3hVcrGYiEl"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-11-fabrice.gasnier@foss.st.com>


--AHJchM3hVcrGYiEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:38:02PM +0100, Fabrice Gasnier wrote:
> Add support overflow events. Also add the related validation and
> configuration routine. Register and enable interrupts to push events.
> STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
> lines. Request only the necessary interrupt, e.g. either global interrupt
> that can report all event types, or update interrupt only for overflow
> event.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--AHJchM3hVcrGYiEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejGwgAKCRC1SFbKvhIj
K8/NAQDCuf6KLzSMo+Kw/cpwoHQZKeN+w6n9G+6YESGIsrFwJwEA0oJlwcWAw71G
bVtRni++MRNTj1R0wO9V3GCUC9ShYQw=
=UU4f
-----END PGP SIGNATURE-----

--AHJchM3hVcrGYiEl--

