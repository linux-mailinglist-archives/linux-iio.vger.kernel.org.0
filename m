Return-Path: <linux-iio+bounces-12626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145E9D856D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ED7B355F1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F854194C7D;
	Mon, 25 Nov 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="20PBngV+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218B1957F4
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533524; cv=none; b=sCdOU2BXfHJJ27NV59CqE1Ln3KCfIqo/B4+ACHa+GDghryiQA28YfRBm2RvfSt8ZLtS+cASQQc/x7PCLe4DPIe2X8O6GYuEwxwSyES4o/zqPWZUe7WXy4bXwEujnHz2pM11k737UklXX1irOOq478AW8d0+d8Y8BDnw91JgWMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533524; c=relaxed/simple;
	bh=NEXnkmUpNhcGagRcr6DpkooLnj0tGVVohyKmbBIxAY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiZZ7YXwuBtut1U7bXUNeUF33CA6XQ9vW33Zz9yzdUhY2BXfgM3OSwsce2iePQogO3fQ+bPDc9+VKRHEBb3nJO9mVYgu/GjRbJGr/OY82dDQOYRxY9CJL4gD8L6ZJKNs7Eyl1+v0fvNoK2pJ4inI+mYVCvT9sLuyEa8UMKpTJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=20PBngV+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso39169095e9.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732533520; x=1733138320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgpbbNEkmgykeByyCVQ3DYDysEEYXvtEqm0PcuXiWnk=;
        b=20PBngV+QQ9/NCLJv9AjZgOfsC0gdE+rOZO2aVf1n22js1JwWw78zeyz0u2le0XFjk
         p/1ZvVrxM6ynRUj2xliCp5sRQnBAoc/TAvRouxOcXTqOgQAxNLKdAzHtWjj+vrMTBaQh
         oQyHUc3RmyBNRCMNuwPgzJmP+rWqb+AXg7rEef0tF9mQHj9mmalOu0sPYsG0qYfnc6Wn
         qjzaZXJyIfNJiir9kIVkowZmnwk2kvqOVXm//pcpLTa/qwnmoL9zJTHRIh14G57U2SNW
         P0LSXqIjo5rhtkkXmpGvCS6+bTwoiVbTrewoxfHKP59Tj5artPU0+gBGFQcyr6rlyhFX
         wJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533520; x=1733138320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgpbbNEkmgykeByyCVQ3DYDysEEYXvtEqm0PcuXiWnk=;
        b=oiCTmdpnz/yWb3x7Bo2XUEQXwAcwdoz7zo7FwK8rv28lnf76dfnIB39ji7r192RuBf
         9KDRtDamtkwyZZ8y4GZOB7SfML//Fh070LGEXgUZpfh8lF1TbsQxkvFTH/pr9xCi7mv6
         0tBPU1OYUp0Ld8E+mxe0y5nPKuiaOjoPh5XRTFgYgkv3xDl0PWfg/tjgFOLnO5aHgyzq
         wP8qawabmcTyDGpQ4valluu1Lk9H+ZdtcXzHYr3eQOZfs9tA/msk8jeSQTwoQ4/nOxk+
         0Ummr0tmfAyxlgQjT+KBc7gTjhyM6qnzEXWy/3969ZhJaSJuUIMgi/Q56kpCOgUSy9R/
         +wAA==
X-Forwarded-Encrypted: i=1; AJvYcCV00yJ07plxfuO0UdpFGqB2yA+9Sc/ZSPM4jJx4hsvd4pF6+0TabhO/yDMTvYb/v7eVcRNaIE+2JnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWVCtZBg6URuWCWk7KwIlsj0IVIs2fjgYFzWFrWPbWilhqH3c
	bwdz+jvc8Um5NcGMIKPIwDV/hwp3O5zgYVxR4dQbW+Xd3cp6dTn5N5koG6P29tw=
X-Gm-Gg: ASbGncsqAe09JBI1UsZaWDFgy/HEjXL9FH9vl+vYUL9VXLhwRmdxUgF1oWOHbXA+p7B
	qhdQRmeVfrkVLpR+GACB4pYo/enwdiHhMn9WVK/E9VzGO1j0sFKY6gFgq+qBFq2Lne85GLSVNMu
	iTeHVUANe1VSJynWZ0/2bGGa1sFwck60Gmz/Flicg2HcmdzCTZ7u2uchLesTw9EXF2crlWT0PeJ
	k9kxeVczP49rr0mvNosJWoW92uCj+bUKW//MPDWV6XNIjx5UTkJEOzmgyT2/f0WuNYAJpjB6i5K
	+SXvkuClpcAnHALtvrSxqWHuiDbVX3xOB74MCQ==
X-Google-Smtp-Source: AGHT+IGdH/1xkGe0FxMfcw0BJDlcTwbp3cxANiuceTiyzSfv5C+lXqoyYhq0xioqTflZztkvT1oBRQ==
X-Received: by 2002:a5d:64c3:0:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-38260be3f72mr9001002f8f.48.1732533519689;
        Mon, 25 Nov 2024 03:18:39 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf63sm10142315f8f.102.2024.11.25.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:18:39 -0800 (PST)
Date: Mon, 25 Nov 2024 12:18:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during
 probe
Message-ID: <rtuckitd5jy4mpt3kaytrj7wjqh6cvy6oqhsypoonoxkznmxzi@b4l3hg7teqys>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
 <CAHp75VfX7Rtx96mY8V_9M+m1y_zwuoz+VGcmoF75YTjoT9NF8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rxk76zajr5xqamz3"
Content-Disposition: inline
In-Reply-To: <CAHp75VfX7Rtx96mY8V_9M+m1y_zwuoz+VGcmoF75YTjoT9NF8g@mail.gmail.com>


--rxk76zajr5xqamz3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during
 probe
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 10:25:43PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > A driver that silently fails to probe is annoying and hard to debug. So
> > add messages in the error paths of the probe function.
>=20
> ...
>=20
> > +/* Only called during probe, so dev_err_probe() can be used */
>=20
> It's a harmless comment, but I think dev_err_probe() name is good
> enough to give such a hint.

Seems to be subjective. I guess I found already too many functions using
dev_err_probe() that are called also after .probe().

> >         ret =3D ad7124_soft_reset(st);
> >         if (ret < 0)
>=20
> > +               /* ad7124_soft_reset() already emitted an error message=
 */
>=20
> To me it looks like an almost useless comment.

Same as above. If one of the first thoughts when you look at this code
is: "Huh, no error message in this exit code", it helps.

I ignored your side notes for now as they wouldn't affect this patch. I
made a note for later however.

Best regards
Uwe

--rxk76zajr5xqamz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEXQsACgkQj4D7WH0S
/k7P4wf/dDEkByXl89Aj6HC/hhXcKyFIaOM3CCD9SSOqqjPA/aLPJko431hRUTtY
1Vi0Bvl1UzbYEZT4pTjmgTCicAuLS81J9h1d5gxPWcJ7bMzb/kDLouNXnREC/fgs
b/21vjgJ2p0z9XJgRG676nYcxugzDAfobrB2Qlm2hiB40KVF4RRd5SDsNir6yPRH
jnTtOWMF6pH3m6cXF7fkRmnXmZE1S86OuvN0UGJOsL2bsr0v1ZDvny0JgQ1dHjY0
28QhAzAyhDF9VpZpFR0DS5CICsMSVBPYNykNzlzdSjXj/Dmf36lU4NOF0TNFjSUH
XWD6a888CC2Fj5P7HxTQL2DXatHxXg==
=W0o4
-----END PGP SIGNATURE-----

--rxk76zajr5xqamz3--

