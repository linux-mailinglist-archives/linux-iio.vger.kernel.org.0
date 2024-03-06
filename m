Return-Path: <linux-iio+bounces-3364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD0874099
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672E5B22113
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7727140380;
	Wed,  6 Mar 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHKWpNi2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1639F13F45D
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753997; cv=none; b=hzHgmEYHQxul7IYKJFRvXzeWPKFL4BGneGFnickBwppOm/rcNVXRCVHbQmZPctp/B3dNRHAwchJlXSdP26iNFGUQ/WTV4/dpcgGSHM5+2pJg4cm83z7TtwgGPl7AvyfE9BYEsR5TSGe6cde5cWls0vzjBZmL6Y0JTMKPNHtV/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753997; c=relaxed/simple;
	bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACOhOFPizp1CB60oMKz/lasVOXxeEE9licKK+jWjdfQTb5xM7eaLVIOJPFCoh0rRU9szcfmU99pwDQrZvYYaEFJpVOMHnmlRt9r5y5Y5fBJMC2fvRLE1RT+MbpB7yPaTNzHYKQPpBDl2qK5jtSmZ1OcOvLFHTCmZFTT5TSqLnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHKWpNi2; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d346e4242fso2090741e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709753995; x=1710358795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
        b=OHKWpNi2LpJcpoVAnzcsAGJsZLKBdruIypwDl+3w0Hl+sKCR+rHsiYpjfhh/OJGLQG
         21V7p3ZahnIUgPedOyTbDL5qiVvrK1BIyjC5Ial20ljxrcnwNzFRydT90HmUtND4jjzD
         KSpXGVWdhEXg4Ycgd/xAu3w/SmpFugEYe+HAR5gvYmGeNyREk5uUk4ZmB/XCiLFRz257
         pV9gF4Io4JoEhcpFQw0KkM2rqKdEYmAKx6reXqSTb+aUuZSXY08+ymWf94TmNnpPO3wK
         eK1FCkmByHSRQx6FHnSvudeesNPxda2imk0igMxL4MArCuU3wG1knJXO0FNYlJsS3zxB
         Yq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753995; x=1710358795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUaL5wX9lCcHMpyt8Zu+oEHigjdI4PKIxNn0fnhJ8Po=;
        b=NASc/mwUfyvxOSduoHM2T8ZjkmVp+LAQABULv/whPw9z32fQi1HK3M1f0zr1tYARPw
         4FHLk69tWbc3689X+NK5BgdaFqV+bZZqpU1tnhkNpZJ56ElypYtCB3EA+DgEVaJApE2V
         Uy9vvSXR0aOq5+x+fSlx5D0s6KXrCPwe9GlVZqSYycyk340doyWRDFFhwreqyQX5AV2P
         75SNqYo8GQy+IevxtdARoyiO0WM9g/E3cFlprAE4zpPsZCFPJJyFu/EI79zw3pCa5Nc1
         t2G3SBWKYIgHhE1achPOczksu0uUlXBFuJQzpnhaAKYRXQlpOHmP8WdcffCpvB3EcgDB
         hZjw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ogWkEBUFlQ1848s1SRdyN/YHSWY6snwmSryLrt3+E/jXQzIa2qg9FhNwL3sMcRotPcB3j3n9ggjHW3XiiTCDkIk30gMHbWDv
X-Gm-Message-State: AOJu0YzaxlVjf/DzCc7iyCAt10zR3mQPrdsmRa6QOTCmD+KzwpdoLgbB
	t0O8oK9UTvbjAnQhzmGlKJ6u0/K8SFICh/oCoYPKxti+6dOHhYjNhdlAuzHR57g=
X-Google-Smtp-Source: AGHT+IGXg5I00ytK4b1k0hPS2EZIeSRWy/K14ck3db1WCJDBJQ/eqPd+cm7XflCOTeslEXOmUhInbA==
X-Received: by 2002:a05:6122:30ab:b0:4c7:5fee:f525 with SMTP id cd43-20020a05612230ab00b004c75feef525mr6341546vkb.13.1709753994992;
        Wed, 06 Mar 2024 11:39:54 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id d20-20020a056122033400b004d347f2551asm1500370vko.40.2024.03.06.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:39:54 -0800 (PST)
Date: Wed, 6 Mar 2024 14:39:52 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] counter: stm32-timer-cnt: add checks on
 quadrature encoder capability
Message-ID: <ZejGiKovtkCrydzp@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-8-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O7snGDCakkkZmDqH"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-8-fabrice.gasnier@foss.st.com>


--O7snGDCakkkZmDqH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:37:59PM +0100, Fabrice Gasnier wrote:
> This is a precursor patch to support capture channels on all possible
> channels and stm32 timer types. Original driver was intended to be used
> only as quadrature encoder and simple counter on internal clock.
>=20
> So, add a check on encoder capability, so the driver may be probed for
> timer instances without encoder feature. This way, all timers may be used
> as simple counter on internal clock, starting from here.
>=20
> Encoder capability is retrieved by using the timer index (originally in
> stm32-timer-trigger driver and dt-bindings). The need to keep backward
> compatibility with existing device tree lead to parse aside trigger node.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--O7snGDCakkkZmDqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejGiAAKCRC1SFbKvhIj
K5KbAP9fffVz3i5+FStoFd1EjIyVXWU6OcHNjQXPePsUhuk1WQEAoZG/LUlGu/3W
4MPtiZAoi8G7OzYxEFU0+n2pwYQl1As=
=Pqa6
-----END PGP SIGNATURE-----

--O7snGDCakkkZmDqH--

