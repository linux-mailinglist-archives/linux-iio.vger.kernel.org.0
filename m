Return-Path: <linux-iio+bounces-27665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD80D1818D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD653019B9A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313C34164B;
	Tue, 13 Jan 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI5y+FIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FE328638
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300686; cv=none; b=Nxv+V01VxUPVAMmGHNc096qvaSPsYL1hFyd2jJmPcvEInrT/a6ozmBmZK3i1Xk4gyyfAAaKDjtkOtc8+T6UuOE827oJMbscD9KB+b1eMwUcDv/C+MYkCDCZURI0lyqkk2cPkd4rGJJY4IvfJJxHdSo+5u058fkH+DXFkxN01ktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300686; c=relaxed/simple;
	bh=mxOcD1cA12y/6rHKrAjW+DtvChOgFYiutRcSmEc8Wp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayhH1SDGEO5Jzcmqn+y7NuDWfpnstMmZz/OA7vJBZ1iV73cGD3VNFq6Zz9Gg8Oh+MzMgcjWJDNuOV7TrFMcB3thGqF87Gwrqh9AxXljPsO07kVmk3PpMmvunqPXzoc94EIvhJck/8+lmztmrPt5FiQLagYvBmJe+mxWG66B9R6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI5y+FIe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso67557355e9.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300683; x=1768905483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxOcD1cA12y/6rHKrAjW+DtvChOgFYiutRcSmEc8Wp4=;
        b=fI5y+FIe4yVLc4F3IT8ErlddaAz/KTmNu+1DAHYz5w4I7XgNDhmpT5kRoZQjTN3ihS
         grq1zk9DvwnI8nlgfy/n531XvFS1mOj6DRPsaNc70uDYvVK1okWUB7g0WKmtunxJpKLg
         wgu4u1fsFxxQvyg0Ti7nfHNC/j3Apfkhj0rOXqzKCQOnPt9gNQFXzV1F9Yxs0UWBV6qt
         bcBEeV8+ovstlYBmtn7AyVQCqod/dx48AOQCoY5IjcvZp4cmF2YdB1n6TRikeoy2zCCE
         PJfaZPWug+yffPoFICVZo4c7sR15lYRgmGYc1QS4zmNEhCD027Jh1kTzhPvrt5FT5AaI
         F0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300683; x=1768905483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxOcD1cA12y/6rHKrAjW+DtvChOgFYiutRcSmEc8Wp4=;
        b=mMe78nE9SBZ4iMczU2pkqe+zLDQUN9t4O7Rwsbd5FMDBZF7HLYrOn+1ZkJ7Si4lwV7
         Coic5pYGIrWc3xWInLdyU+BWJu3JJShgixpPvpjLVp3Vl8c2C6dxUGOpXlbVvnBQWnzV
         0VaYMHgJkEknho7+RXFjfnTxTuPBO6CmF5BgCV/zmwpCSR/qbOiMA4T3Gud90PAsjFr0
         8k/LaUpVAVHUuHju5tpi9Rc0lQE81CDMvKIgU06cEdi4MO6s48kLHU9WL2/84VPze8vG
         8PjlzrqjQRoCSLKMeHQ3sti3gQaI51Nk32GjGAJbol1a3Hi8o6VDXY8GPtbyAhLiLhJO
         6qWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW+Frz3FVcEb63hoxtLmJnqkunyRn4YsDTN82XMpHYNuhXe8X4TYn1LJwgPdef3sVEu3JqEgzL5/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyURpZWlWg6oCBe+w3sQIWm6Dlie2Sg9LfTjkYSLceNBkdZBF
	NRqMN5xHafBUuc0OftoXt0PTv1ofNMUWZMfOncCfM3foQYw7MArPXPOq
X-Gm-Gg: AY/fxX46YiONxpxSOWhFGfLQADvZBLOeuPwTDPICpCw3VCc0mMPVf5VQ6XDELC+T7M9
	x6O4nJgtEGT5PzvfiT0Z3V2N2ptRqAPtSnLfnIX+7z/QqSWr+5kiyKxHA6FpzR1LeN1kaCo56wW
	s+HqHejgZ/1eORCnBn1FyhQ8Kz+/HeYKcCDCoiifZEghkuPt70bJHRlmsMOO0tCZRnsqAzCR3Gt
	eyYkoZpHJt78TG+A2XiZWXWnHRDHcQmTXwSRF94+zhVeiNoL/VywgOdTHfmQxdD4u8PqTLbkgyt
	8TG+0cAG11RRG6xRc/COC2FSw5A9rCWPpMpOPP9qAuOnmTt1gx+D5DS/KhZcH1F2fj9o14rpglq
	j5+6NhynkM0paP36yxM2FkF9CHYe6N7yii5fHGIJHA7Z0Q5wU0qEan2eE0ggKTTz7rNbr4o7Aby
	kKK93VypohwBpCmVi8llE=
X-Google-Smtp-Source: AGHT+IGZWI8BC0XO4q/PcONBO/S1NJ8k2S4bjAnGk5dNdRHI+QqShN6+xW8K63IsOGXYRmKeEVVOOw==
X-Received: by 2002:a05:600c:19cc:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-47d84b19f69mr237676935e9.13.1768300682455;
        Tue, 13 Jan 2026 02:38:02 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm409588395e9.12.2026.01.13.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:38:02 -0800 (PST)
Message-ID: <98897c0488e67f543f437b96412c78e10a59a81c.camel@gmail.com>
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou	 <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>,  Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck	
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Tue, 13 Jan 2026 10:38:44 +0000
In-Reply-To: <20251227144707.1bebcf27@jic23-huawei>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
		<20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
	 <20251227144707.1bebcf27@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 14:47 +0000, Jonathan Cameron wrote:
> On Thu, 11 Dec 2025 21:45:21 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>=20
> > Implement iio_device_claim_buffer_mode() fully inline with the use of
> > __iio_dev_mode_lock(), which takes care of sparse annotations.
> >=20
> > To completely match iio_device_claim_direct() semantics, we need to
> > also change iio_device_claim_buffer_mode() return semantics to usual
> > true/false conditional lock semantics.
>=20
> I wasn't rushing to review this set because I want it to sit
> a little longer than a typical series to get more eyes on it.
> Anyhow, long enough for this version at least!
>=20
> Whilst I find it hard to care strongly about out of tree drivers
> and in place flip of the return logic seems a bit unfair on anyone
> trying to keep those rebased on mainline!
>=20
> So with that in mind, maybe we need to name it differently even
> if we are getting rid of the old implementation all in one patch.
>=20
> Given earlier discussion about this one being rather more tricky
> to name than the claim_direct because claim_buffer sounds like
> we are grabbing the buffer, I'm not sure on the best naming to have
> here. iio_device_claim_buffer_m maybe?=C2=A0 Ugly though and
> these are super rare so maybe this isn't a particularly major
> concern.
>=20
> Given I think the people maintaining most out of tree drivers
> are Analog Devices maybe this is a question Nuno can answer
> for us?
>=20

Whatever you prefer :). I'll be the one taking care of any conflict
that comes and I do not mind dealing with something more painful if
the diff flow makes more sense for upstream.

Also not sure we have any out of tree user for these claim buffer APIs

- Nuno S=C3=A1

