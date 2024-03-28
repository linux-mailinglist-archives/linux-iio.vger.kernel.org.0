Return-Path: <linux-iio+bounces-3367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0008740A3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 20:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C55A1F237A3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726F140362;
	Wed,  6 Mar 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNLR6VvM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0860250
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754073; cv=none; b=aIHmIChn9CJeF5UEe8R2vvg7m+eRsAnpuZ0NhsmiGLnmLiqm12CI4oDKPOtJc9jGl3QR5GgsqTBXHeVw/V0IylEb6shls4d4SsWHXjAbzB2IykMXJCwnoE5XcmEnfrP1sQy5xq4LXeKev7tP4aQf4mgix5K8bOkeKV6lE30Xu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754073; c=relaxed/simple;
	bh=KKJXr/IAgS9AlJDdgpqcbHwwmBwIbrtKq+tJPd0RqcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a55qnU0B/wKqTpctZHc+BkB6V+lZ8kqMfiSI1pEui+soZahOW7tySDz3fW18P7c9OXcmTHpGyRIgZrKtqPfV1vFb7iGPEmQ3o5Msnxw4BhgwHi5+IaoLzjTfRIrNAn22uYzChwLZ/X1Vo8yAtEShXmFw7iT28/E1RpL+jj5ysko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NNLR6VvM; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47288b46f2fso27684137.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2024 11:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754071; x=1710358871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKJXr/IAgS9AlJDdgpqcbHwwmBwIbrtKq+tJPd0RqcE=;
        b=NNLR6VvM5YDs+X8UGYbmIIn2zOPQ/+iBIFrH3hMIBuza0waQh89wAUZMNPebLewIa7
         QyAxWpJd1eObLLkR9k69Sc2v6UTqvlbvSOORj4UTqyjK8X9xTMXoyes/Nw0Rx5pBxucn
         fAiLwIjQaK4JgGnkU7x14A9gxjgCjhvAgVmv4rZ3cf3cIg+yDtf7lihY3C9snFfMkdWG
         4fCfDEz7+5SRXl+IdywHijEps5Upzkf6qcRwDaayp4cqRFN+SmDFD8QUSnquTNUQI8i4
         wI34sA0rohoBrdrHNZeURmy1J1xEcwtcAyNTNd8OAXcaSB8MC+x7uc615LyE1xaY7v2I
         YFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754071; x=1710358871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKJXr/IAgS9AlJDdgpqcbHwwmBwIbrtKq+tJPd0RqcE=;
        b=oGgb/ZhT6bkNsUK94n8LI93jQVZa63Uq0GEFKOsCH+pb5y5s9JXMxL63wfvI4cM17r
         jsgHrTjuBmO8SUFM3jwBlHWHPo5WAJBpiUsdJxkAlGKkFGcVGTQwT/81kT1R09QChODy
         q1uBVfTH+fATzUxLUpWKHJdqF9Tt2llTMMEn3ZyC+68JEzmIhbZ+yWGwS1+Fa/4QcT1N
         VTi+b1k5sVWCKyaFpYyANeAenFZy5RksBPWnzLhNhEi3pt56n2xEysZcwhqhZwxPQW+E
         B8gsLiaWSemxcNk3Mu5MVYYhvejUikRbiCocsDR92EKPdfcbqQdM8UgUyp2QNx+LAJWF
         N8ow==
X-Forwarded-Encrypted: i=1; AJvYcCV/5q3BcSNnDrBlBncfK/fKcGq62BfhMXBlE+bQ83N8t533ZFkprluQ5T0bFyXnmsO7EIdZkpwCswZfcmI3+PhTP5f16dHNnxva
X-Gm-Message-State: AOJu0YwPdTRStP/afejATu2psKROIXhRuAGQEnmRsfPlZE5+plOjaVvF
	moE0KwwJMSl8luW42SQJKYKHktMlvhPTVwk+hIy3wGPv2IObAU/NHd5jqWVtwIk=
X-Google-Smtp-Source: AGHT+IFO+ljYLVgCOupSmKdJuFOFah4rKhUWFVzXldvgD/GHMK/C9G/U7YhQ9LS9dryw7WNrKrcxug==
X-Received: by 2002:a67:ee52:0:b0:472:5960:9e9b with SMTP id g18-20020a67ee52000000b0047259609e9bmr5925192vsp.29.1709754071236;
        Wed, 06 Mar 2024 11:41:11 -0800 (PST)
Received: from ishi ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id dg17-20020a056102571100b0046ee0e665ffsm2323364vsb.2.2024.03.06.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:41:10 -0800 (PST)
Date: Wed, 6 Mar 2024 14:41:08 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/11] counter: stm32-timer-cnt: add support for
 capture events
Message-ID: <ZejG1BJlT2BTL44G@ishi>
References: <20240227173803.53906-1-fabrice.gasnier@foss.st.com>
 <20240227173803.53906-12-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/7E2qpchrMeFZ+eS"
Content-Disposition: inline
In-Reply-To: <20240227173803.53906-12-fabrice.gasnier@foss.st.com>


--/7E2qpchrMeFZ+eS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 06:38:03PM +0100, Fabrice Gasnier wrote:
> Add support for capture events. Captured counter value for each channel
> can be retrieved through CCRx register.
> STM32 timers can have up to 4 capture channels (on input channel 1 to
> channel 4), hence need to check the number of channels before reading
> the capture data.
> The capture configuration is hard-coded to capture signals on both edges
> (non-inverted). Interrupts are used to report events independently for
> each channel.
>=20
> Acked-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--/7E2qpchrMeFZ+eS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZejG1AAKCRC1SFbKvhIj
K3DwAP9JgKrctTyHYndvFGfvRBz7a0xr6aDBY7DMfn5Cd+yMRgEAtVnZbcuUt76/
QGXXSQ+ceWI8oq9r9tubyWD2rrCO7wI=
=CNt0
-----END PGP SIGNATURE-----

--/7E2qpchrMeFZ+eS--

