Return-Path: <linux-iio+bounces-20998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BBAEBC93
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC93AAAF7
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFB2E973C;
	Fri, 27 Jun 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVKxqA29"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916819D89B;
	Fri, 27 Jun 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039666; cv=none; b=UIybUva11SO24oivp+zHLTH+8/b0ggd/3/L3oGalvvKpAvi4n/Q/naIZJZlv0vq+gF8BUoTJE75bslFblRKRLRuPQCFPNGb9FCC7RvVfEfu3pEuup+TUFWJY9uPavZojghfZWxc0ck/qSy9DC3BHu5fki2OAbGY7L42gIVRV6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039666; c=relaxed/simple;
	bh=Dzk7FkZrP0cI66APZQkjMGI2vyePpXuiq+b5mTMeppg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiNrzCU3jQfj3LiLGQVlGf0fkE7nzuPVPv3cS4i1tbZynGNf4asLRKuzB0Fo7ATlSFByXn9y5Ogp2Wl3C/3uKFKHGiGEjIyXyqPECrG/FCYdzjuyQCtXKkpdiDaQot7eXxZGYqhX3sXMzRnstDA7JtIxP5Ithmt4s00H8XfMdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVKxqA29; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453066fad06so14758545e9.2;
        Fri, 27 Jun 2025 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751039664; x=1751644464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tr68OiRxkYNsG7/O5fexvNcA0uazWCS0xz7KV2c9znY=;
        b=fVKxqA295SDiLFRxtvRmnuqdpCucuXF0URpBsU+GnCJYZuaALAa11yo/guOszb/qkO
         qyr5J6Pxnzl2BWvx+rjuP2fKjfb8ZzPkWBYwe7w71rPu7Z+6iBY1a8H+ms4CMiwKFxMU
         P8kFBvZwTvNX/aD+XNiwwcHYSHgJO4oBf+l7urpONY8SfmBZ6JjtnGlRMW6G8spOU3iA
         7hHD/6pGHrZ9hJpHeuhFUdA0YsTxdffaglXEcZVDSh2g+SiPfcDeLX43MBfPYC7QHbbJ
         e9yqcdaAQcIatCCsEl8LgZH6+Go17CMQiqINhZVGbdUkCdIjXSdzWG20GBs7nZQUKHAq
         1qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751039664; x=1751644464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr68OiRxkYNsG7/O5fexvNcA0uazWCS0xz7KV2c9znY=;
        b=ZLc6AE+cc/MvB9vC+90pgGGS95mb/6V6mouaoS6PQ7seT3vchFjbrCOPSSzN2v33sU
         NPtNAQ+WthNa5J6F9/nzCEOYsqJbj+phZQBObWtqsDYQY0dKdxRsigXwTHmQANP+4hDX
         plfGaUyWN5Odyyc/Wlv7wA77tXsXubMSm0kYTE6eUPYOXi4hBsdUhyOCDN2qF0UBduku
         DsjJlSv72DGdcceDNxoNwIo7qOkTOC6cYMHFFvKLSLo6SFwB999Do0OknGFH02Om440Q
         DiRryFQiJzd8C0OeTTEBSMCGrdmNwjQub7GpJeBl/eCw8/+6cARm7qB4JEYJGs66/8RX
         6Sbg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ37ZNU/03AQaJQXmNg5peyo3lotjYyLIw70h/rkMiNBB71QHNPLeYoaMTzxm3e5Ewv6e824eHT8A=@vger.kernel.org, AJvYcCWXkRN/oKGePzxXGIkD19ckLFtszJVTmDgtG3mxUFK8f+RnvU31wyDeuyBYtGR2JyzP/mR5uuz5r5AteoP0@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbvQHFqs1VVhaRz20g5MuQhf3Ticca0e99MrpEvAbkg/pijGA
	rEQA/4ZTkim7wkmlD2RuncOjas1sVdgrM7lopzBSUz0s9uYekZ76Y98V
X-Gm-Gg: ASbGncvlbQcr3PBEOoJtpnY9cLy7FqwbdKyhtShVgQUAwiMYaCemmNG18WIqqiVy/Sm
	fyj5qgnz+HxOp04qJpamYBfewHOicbYDSFDLMDOnKyHmBdfW2q4Be7iXdEQNvdFN8EWHedxTg0E
	5dZKOrY481rYFe6IEP7Ur5ytsBiaVxoP0rc+ThVM17+0BT7LJvJTaLOWXMKygmO+OLwambCx+kW
	g7K2Md1y6eKBvO9/pMBF/LT0/uM+OBu9tB/1vfBkkYPuG31CLqTo8w8fGFjU+kXiSDFI6WG60g5
	P8OFfzNOXRoo61XuMoSS4P3UL7DebNxNkH0uHhsMUFa/TIFbVwEtyqzPtGY4dkxnOfbT8g==
X-Google-Smtp-Source: AGHT+IG52LLY5tfp79dpkJwmL3CkYmsnztQvfc0hEH9hajFNoydKgQhJZ+OGgT451bj5FJaXII5dnQ==
X-Received: by 2002:a05:600c:1c9d:b0:453:c39:d0d0 with SMTP id 5b1f17b1804b1-45392e83a55mr18445845e9.13.1751039663395;
        Fri, 27 Jun 2025 08:54:23 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234bc1fsm84064705e9.14.2025.06.27.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:54:23 -0700 (PDT)
Message-ID: <c0f4907eb762e618dcf64a6821320f814715be5f.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3530r: Fix incorrect masking for channels
 4-7 in powerdown mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2025 16:54:33 +0100
In-Reply-To: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
References: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 16:38 +0800, Kim Seer Paller wrote:
> In the current implementation of ad3530r_set_dac_powerdown() function,
> the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
> the bitmask for the operating mode of a specific channel. However, this
> macro does not account for channels 4-7, which map to the second
> register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
> a result, the bitmask is incorrectly calculated for these channels,
> leading to improper configuration of the powerdown mode. Resolve this
> issue by adjusting the channel index for channels 4-7 by subtracting 4
> before applying the macro. This ensures that the correct bitmask is
> generated for the second register.
>=20
> Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD353=
1R")
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3530r.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index
> f9752a571aa53ca0d7e199ed6a78550358185bf9..6134613777b8e1d4516109b74e0b3b7=
9edb1
> ae75 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -166,7 +166,9 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_d=
ev
> *indio_dev,
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3530R_OUTPUT_OPERATING_MODE_0 :
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3530R_OUTPUT_OPERATING_MODE_1;
> =C2=A0	pdmode =3D powerdown ? st->chan[chan->channel].powerdown_mode : 0;
> -	mask =3D AD3530R_OP_MODE_CHAN_MSK(chan->channel);
> +	mask =3D chan->channel < AD3531R_MAX_CHANNELS ?
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3530R_OP_MODE_CHAN_MSK(chan->cha=
nnel) :
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3530R_OP_MODE_CHAN_MSK(chan->cha=
nnel - 4);
> =C2=A0	val =3D field_prep(mask, pdmode);
> =C2=A0
> =C2=A0	ret =3D regmap_update_bits(st->regmap, reg, mask, val);
>=20
> ---
> base-commit: 0a2857e778599c2794dc89c40dc79ead631b34df
> change-id: 20250626-bug_fix-404361f2f190
>=20
> Best regards,

