Return-Path: <linux-iio+bounces-13858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94269FE522
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 11:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D83A1F54
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA821A2C0B;
	Mon, 30 Dec 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr5P4Lyy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567F171C9;
	Mon, 30 Dec 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735552922; cv=none; b=dz7iQT4noVNTMh7HgHC6q3YKtelAN6fEYao9xR+z+O677pXVwv2NscuJ3aQCxqXC7f4g7p4f5yW7vZ1c4G9vxKXwXjcjZ8BGHO3+f9T0f2kX0U74SntZ2qytzUYxiSbsq4OlsTgKmK+kXw5x8tsPDAtsPe648ROz6le5DDSxH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735552922; c=relaxed/simple;
	bh=4IH5Uz+ZOV3DD/XxDNPOvubA9+91wCczy7G8+dwZ95k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Cb3oGceSD2EaIes8d1R2fDBd/G4LGZuFyAiTi0ftgygdxRklxWvXZXnyJRw40Rc0bAjT8rzx121L5pOYZiRQ8F/4NluulqoSMndhVW4LwxtuOfPhw3RqZ9K4wIiEzW/PWr0y7x0NrIRl3fGV4mY66zBh3zTw15XDXkM5P7nuaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr5P4Lyy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d161947so4289183f8f.3;
        Mon, 30 Dec 2024 02:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735552919; x=1736157719; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ4Pq5PgA42OQFhdICtd4TJQMzoXC6uWkgMdmISJGzE=;
        b=Wr5P4Lyyl/sFKkgLmNNaZMVQY2xD7dkRbve+h/x34xQG1iSH9remH4lbRdeRzMhWLY
         9rgA9txZzaCRqH2vEbK53+pRpt0kajSIgib1ycjjnt5GLn9xarNp3f/VD7Sj1gpmnaja
         edeYn0MAbNttlFsG9tml3fk6IPqa5elY6xWL5Q6eYRqHuRMv3jyvM4BsXdDLNtnWGleb
         kWMposlILnaBtclhu13gzdzQokgb6aJZRY++/WDXHTRpOYKhhrCXGAd5hUlYs0svP0EC
         XL9xfyfrYDUXHOX03gvS6PDdtItDDbng2nWlaXStAOrJj6RXR5+rkjveD37wWAfLtcIK
         WV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735552919; x=1736157719;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJ4Pq5PgA42OQFhdICtd4TJQMzoXC6uWkgMdmISJGzE=;
        b=I6FsJy3vb2ihP84J8hR9JFe3jJTCbXuoNtzKEgrPubrb2vinEMcvuVsw0k46aFEcgv
         KTeKfgaqjLnBex/DSKNIOKAueRu0IaV/+abrbh8TV5zWYB2xrZhJY5mCXS3EBtQFYW8U
         QwqERT2d/20q4sDmbY1Q2jEPbEzIVyBJbUZ1MzsBOXoV23nuGzxo73M+9Z6F7QhZqbNW
         CS4qWfwVBI6YAtgoW+iS2/WNCfOWnQaW+3SuHHvzs3Mfch/CDreNfRKCoxWJ4fBXCXOk
         jbuRuNXlgzOia4PjOiM/UX4qvkAWEwrRwQ/zWk378aGSCdfM1EwL5qp42f0IOOaXEflz
         8uTw==
X-Forwarded-Encrypted: i=1; AJvYcCVbv2jZPTAZBqap/khp4Pi+Tg3R/AxTZ0H6AQ8eXZpP1uo8sd3mcYXY70mRaRQG7pUjJjZJ7dGQTYedKOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxerHegMqAOEjQaYo34CDr/yhrTaoWduC545DgBylL6Kcddf3ig
	D0tsFF8zVZjG758DentnbjDdesQPHihBwBouSi9JOAjKVIT1k9ctA8FJpQ==
X-Gm-Gg: ASbGncti0shI9b+b75YZuO7wczzTRORCdnp8lGyDMrBf/JpLGw0HiyAQZRIn+hQlmd/
	LHEYwDLnLKFiodRfkROyTR0JPqU4+g/fEJnns+9P6c8eEIO8/mQCe0y2UTaTtkR6UX+khXQ88Pq
	odjWvSXPHNbTAQ4UyzfBN+QrorCELMBazAeLgimxI290g2BDlMUy2jmcMLh4PpNuwnjC9fRQjYS
	e6mdz8K4bMwQTRX1RYV52oCQhH+6iV3lUNXhj3s2kf/1y51+3rfgXXSxkIjsKsrc7FRRU3ZdHDC
	mfHtty82W/r3Slxqacj70nMH5Q==
X-Google-Smtp-Source: AGHT+IFEwMXjOadgTT1j4b044mGxK7Tjpt/d7lDya9unKAJukRtLKJ3awgTNamWx7xrB6LZeHL+s+Q==
X-Received: by 2002:a5d:6f01:0:b0:386:3dad:8147 with SMTP id ffacd0b85a97d-38a221f9ed6mr23661694f8f.32.1735552918732;
        Mon, 30 Dec 2024 02:01:58 -0800 (PST)
Received: from localhost (82.158.190.253.dyn.user.ono.com. [82.158.190.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e278sm30026484f8f.75.2024.12.30.02.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 02:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Dec 2024 11:01:57 +0100
Message-Id: <D6OY5V93Q2YC.S61HE5A0GMO1@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: veml3235: fix scale to conform to ABI
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
 <b5aa553d-fed4-459e-bbe8-70b9b9b39cbd@gmail.com>
In-Reply-To: <b5aa553d-fed4-459e-bbe8-70b9b9b39cbd@gmail.com>

On Sun Dec 29, 2024 at 7:53 AM CET, Matti Vaittinen wrote:
> On 24/12/2024 12:59, Javier Carrasco wrote:
> > The current scale is not ABI-compliant as it is just the sensor gain
> > instead of the value that acts as a multiplier to be applied to the raw
> > value (there is no offset).
> >
> > Use the iio-gts helpers to obtain the proper scale values according to
> > the gain and integration time to match the resolution tables from the
> > datasheet. When at it, use 'scale' instead of 'gain' consistently for
> > the get/set functions to avoid misunderstandings.
> >
> > Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
>
> This looks good to me, although I now think we made a mistake with the
> naming of the iio_gts_find_gain_sel_in_times().
>
> The intended use is finding the gain and time (selector) for the new
> scale (while preferring keeping the time unchanged if possible), right?
>
> So, in this regard it'd be better to use name which reflects the fact
> that the function finds gain and time for given scale.
>
> I would now (after having to look the doc of this new function while
> reviewing the code 2 weeks after reviewing this new function :rolleyes:)
> name it something like:
>
> iio_gts_find_gain_time_sel_for_scale()
>
> Well, it's not really in the scope of the review anymore, but I'd love
> to see a renaming patch while we have only one user... :)
>
> Anyways:
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> Yours,
> 	-- Matti

Hi Matti,

Thank you for your suggestion, I will add it to v3 as this patch and the
one that introduced the helper functions have not been applied yet, so
we don't need an extra patch to rename the function. I will add your
tag too because I will only change what you suggested.

Best regards,
Javier Carrasco

