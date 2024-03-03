Return-Path: <linux-iio+bounces-3275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1A86F57B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098B5285C9A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D95A4D4;
	Sun,  3 Mar 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btkRZBG9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDC59B78
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475168; cv=none; b=IrXN2J8s42K8qg6OkZ+875qWo5ZqXaLL0TrQsRIesdnn4/geqAwKq/8rWf3fEvq1fv4staowM2GSXRvQjzI0JIn3o+t5lDqj/EACa8yKL6JNKDMtgV/UYwzyxkO9I+3W4PxifiAG1nNKWcSGooh3UtRWxTi9eYau9W4uIGJQjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475168; c=relaxed/simple;
	bh=NCDrrJlc3tRE6yl7ATLHxCA3vYz9taO9U7grccTrnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSi+QPRd0WOdgwNMabdaR/hb2bnL/P9ME+YLKP5GmwDLEwCsikbhkAKByON8opzKLHeO+yIKbtwzIzWruAuPEnEEi0NAU5PpmUyr929QQsZQWrNrJ15RCN3pkuboMAdt3NhvDnVUD68Lzthu3LNk005zlDo/y2atT6nbx2E/syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btkRZBG9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so2433399a91.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Mar 2024 06:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709475166; x=1710079966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97ZbKR/nkeCOTOB37P+kvgKA8uhgX0z9ipBzLO+afkw=;
        b=btkRZBG9v2sWoYpJ4nT5Nlb972Nop10XcqgVM571+QtpiwGBDUClC2Ny0FlhKrmksx
         w/FoF0sb4+F5YPuhu8pCUwsiSGpq4tPHk8+8BNEqicsV1y4EOA+vs5zhbnOvAMs5m2Es
         zRb2rKfXpbRx/ekWvVsdaSOWiUuhAfydFRDQ1SSsaURFvoEfXnUm6YtDjG2ovFBPvB6/
         FbO7WMyfrb/MpiZt99219SnLTdN0iw0BZjQcu9GLFzqMKei+TG34+u7ejOFgHN5/Z87k
         Nlq2wg6GWYSCTBzpc+sGgXizWfxkEYnqWQhGm56AeuP9mAE0YaS8vkgNc+smOJXNugit
         gEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709475166; x=1710079966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ZbKR/nkeCOTOB37P+kvgKA8uhgX0z9ipBzLO+afkw=;
        b=GwqFFDOuzXW3ZGqOsPpRJAqHQYttvKVg8ST/oRAayVXg7kdus3j+hwUQ/o5bvNSyY+
         xPoQqSWCo1tL0i8z77/9PxW3fWkbh7cOnTBDHyyTjZbVdZ6oUkbkCOQjB2zOFFy0pfTp
         nx8CIwEtAU08TodZydI0SwDxdpVj5HvD8kwlXsMtfmu8TKKh+R6HKOgDPUgofWmX7mhf
         etkb5kClNJkdIuPkt6spCDQNm/RspgvxzS4l0kwM+pzM+nylKXxX8yETQCs60kE3Ao6W
         AIf1bHBh8PVt5YjEL2ruFcKSsN2OjQ2gtlhpa7CdWEgdkX9hrM8Nx4qH/dI1flKEshxX
         uEHg==
X-Gm-Message-State: AOJu0YzysjOvdqKU9fLl3FuShg26Wnj63oPVqxONRp0wJE6J6+uCZ7y3
	dfCcQa/drwEls/ZqhbnDLmePK5j4XxR6C+hyOsugVvKnHbmZxvNblc3HBjJ5Qkw=
X-Google-Smtp-Source: AGHT+IFG+wGaEtdkA4OQ9eiWV3WBTHsJ2Jsq86wcnKWy9omE+7oa3Usnduwz4hYZlHm7CS4l9UtJ9g==
X-Received: by 2002:a17:90a:4211:b0:29a:a1cd:da65 with SMTP id o17-20020a17090a421100b0029aa1cdda65mr4517702pjg.43.1709475165878;
        Sun, 03 Mar 2024 06:12:45 -0800 (PST)
Received: from ishi ([2.56.252.75])
        by smtp.gmail.com with ESMTPSA id bf3-20020a17090b0b0300b0029b178a7068sm5231556pjb.50.2024.03.03.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:12:45 -0800 (PST)
Date: Sun, 3 Mar 2024 09:12:39 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removed priv field description to prevent kernel doc
 warning
Message-ID: <ZeSFV7T9Rwm2Adal@ishi>
References: <20240303140300.6114-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HiSxRJ/9FIC6peuO"
Content-Disposition: inline
In-Reply-To: <20240303140300.6114-1-prosunofficial@gmail.com>


--HiSxRJ/9FIC6peuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2024 at 07:33:00PM +0530, R SUNDAR wrote:
> ./include/linux/counter.h:400: warning: Excess struct member 'priv' descr=
iption in 'counter_device'
>=20
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> ---
>  include/linux/counter.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 702e9108bbb4..b767b5c821f5 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -359,7 +359,6 @@ struct counter_ops {
>   * @num_counts:		number of Counts specified in @counts
>   * @ext:		optional array of Counter device extensions
>   * @num_ext:		number of Counter device extensions specified in @ext
> - * @priv:		optional private data supplied by driver
>   * @dev:		internal device structure
>   * @chrdev:		internal character device structure
>   * @events_list:	list of current watching Counter events
> --=20
> 2.34.1

Thank you for the patch, but it looks like this was already resolved by
an earlier patch[^1] and in counter-next as commit 0b3bbd8f9baf[^2]. It
should be picked up with the other Counter updates in the next merge
window for the Linux 6.9 cycle.

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20231223050511.13849-1-rdunlap@infradead.=
org/
[^2]: https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git/commi=
t/?h=3Dcounter-next&id=3D0b3bbd8f9baf245ec77d86f6f5bc902105b4bfa9

--HiSxRJ/9FIC6peuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeSFVwAKCRC1SFbKvhIj
K8axAPwPx/2NnRyJz3BUspGwzmgozohYut1T6VGt9yyDNzc5kgD+MoQ0fqaxeXiZ
mb9g91TWYRxgrfvQOCAUjtl4/0v7qgk=
=hOEr
-----END PGP SIGNATURE-----

--HiSxRJ/9FIC6peuO--

