Return-Path: <linux-iio+bounces-6976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60260919899
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911B51C21EEA
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D6192B61;
	Wed, 26 Jun 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HB0r+sCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430C1922D6
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431763; cv=none; b=pkS4hZXJFfpYwgbFMMmiTYxySp1g5RPAr5Gxmf9zPtek3zfnwisQO8ywnQ/ZAVPREbxKCbtdfsbFajgpCCxh5pmIwXv/C3C1t3rcENDPENSkeSKzkvnN7VWrALDe5zdUKpudm7Z3s3Xiru64waXhogrXCQk9ZPe1BvHWATarawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431763; c=relaxed/simple;
	bh=VStahdc+xT5qsKNlriY5Qfhtj/4m/b+JQnzUhJkoQWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wudk+ZGI66pA/47/y1KRijDIU6c/QnA6VxDVvrl0LEmk5GhnROVQLbO8HnXaVKLNaJ+Iwtq/y1obYjkYlAh+8kypSpgko6OnotYeidEtcfC24VtP4D2h9ChKAGvnYzgRNVXPvpqrNp/m9IU0jFMiuFLnVGIqTLDpeV7nJ/se9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HB0r+sCk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so868028a12.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719431759; x=1720036559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VStahdc+xT5qsKNlriY5Qfhtj/4m/b+JQnzUhJkoQWc=;
        b=HB0r+sCkvmIyBrf0NWN48WIBNOrmLUftimyojOKhPmG2owJrzv824rBTpEr9lEYPYD
         puNtgv3U9EyI3OUAhLZPibbtuYLLwmPNXyOUTPtSTfQzTvrrzXMRgix4DH6R5nQMJuSm
         CQaV0WbI/dG2eAL29DCHr8BMx/F3vnKoBkNFU/c73yJfpBdY5LxnRONLkLLQ0JyciHR3
         LyNL905BYW8zSsQuPMWzppL28oWo+sd0JpN63CczNpParJBEWkxHAgO0xj2h/CP5kVB1
         C/9IvOTcUtEOUFwLe6XBu0ozTVJHnGLiiPykEbXWismmK8NVPBffUqdCWI3uypyUphE2
         r0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431759; x=1720036559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VStahdc+xT5qsKNlriY5Qfhtj/4m/b+JQnzUhJkoQWc=;
        b=iYY2NbVeY3rnjMM8QYEjFpQ02O139ai1+rPBGK2s3LPAZ1B4bx74ry/b6P6iOsmHE9
         2BhzqLKnC1tF9GwYBy79VAYadjTByvzVfiMuTcIKZZIhgOeKg8/PgwpGGOVZYe/H+Tn9
         RzLN+K+a5Q2ASrUkaHrHHdhQIz/Z6xuvhMGWEMMn3bSZa7IE83iMmqtwoy33Nlokp3Mh
         W18l3IDFdmCVH6UpUAC/DSyRwJ3LVNtl3qst4QqRMAwmjv2sq8KXKz1hok+WhuRFtmt/
         kOIAHBaisPCtbGlECgEDdV1pipxoYhtPgCyaY/5KEZduiYo4gsWF5l/M5mAF98v4mGBE
         vvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSslVsaX32riwm5S5JgePuSPA0y+vX+5Bsn7blds1zW5pBC58m6sRFziPxrpeiGvFFBELVdMyZpVtaPqbjAvtPQtjJzT/xQEar
X-Gm-Message-State: AOJu0YxLsuXwnPyHU8gSprI4W63FdsArcJuFdJaIpR390b3Ii/AlV+7C
	VFf8a/k2MrY8CAN5AJPXQ+uv0UI4PXuw3nGOz7ZdDZXcOG1aJyXnJ9t8KLUTJck=
X-Google-Smtp-Source: AGHT+IGx4yr/IsrDbjytCCrhgFDG4h8ha+n7vpXHHMXD1rUABSW7A50SrfYz2LfdXXZXN6tlmkX52A==
X-Received: by 2002:a17:907:d403:b0:a72:554d:829c with SMTP id a640c23a62f3a-a72554d8597mr884511566b.3.1719431759269;
        Wed, 26 Jun 2024 12:55:59 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72451fd535sm453244166b.149.2024.06.26.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:55:58 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:55:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <u7kisifvsi2bwbayum6rlndu7mingsm3jpaqym6jrzpfzecukz@6xtbqlwxauf6>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
 <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>
 <20240620173838.GB1318296@google.com>
 <ip5aysvcuchc6q6sikghcz7vjn6zvih5r3amkvp7n7xpvncbhh@jdq5lkckeoej>
 <cgtiizodhbyutaeu2kw5qszb6ap6bpzdk5pnpurliikhz4isvp@3xtidwcttjkb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odshdq4rqvga6wxb"
Content-Disposition: inline
In-Reply-To: <cgtiizodhbyutaeu2kw5qszb6ap6bpzdk5pnpurliikhz4isvp@3xtidwcttjkb>


--odshdq4rqvga6wxb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 26, 2024 at 09:43:29PM +0200, Uwe Kleine-K=F6nig wrote:
> I wonder what's the state here. Maybe Lee waiting for William to send an
> Ack that Lee can do the first option?

Huh, sorry for the noise, just noticed Lee's mail after sending mine ...

Best regards
Uwe



--odshdq4rqvga6wxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ8cksACgkQj4D7WH0S
/k7zYAf/XnWC8IKcAjOYCWUlOn51NvYiVs+jnm/GKBWbNOMgjmXYnWRxgRHEVzhT
x2EkGFN8ECZTxfySdpZgzYWC5G59mSKgSSwfUEohqEUjCbVG6ZIHKMPXKs6olaqD
KqD2CDfwGSJkasedNYJ0PRoE4wWnEDOx+mEbtqATfewhmcQo1FPAo0J94mt1yuxw
xcERsKlDDVmEj9H7yL2GAUEJ6Neons7GErFh/ZIrJjSkH1BvhBsv/Eyg8IiyR76s
abCQ6Y6yhpNRsiLzXXNZAckMQ0BdY8db3P0Hm5ejG6uo+mCoFXSXKI8k3N/T/pQd
x2J4zhIJDOGVtFb4YRD+NmzkrHVPUQ==
=8Tv7
-----END PGP SIGNATURE-----

--odshdq4rqvga6wxb--

