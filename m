Return-Path: <linux-iio+bounces-14297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD391A0BCEC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7796163597
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73C20F089;
	Mon, 13 Jan 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBiaw+wm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941425760;
	Mon, 13 Jan 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784537; cv=none; b=jeAux85b+mvp+Q8xspGztcaxfDQxrP6jXBxYuVNX9zvZAArs2CW9cedRta5Y13HyEhwcWeE6bezZxDgmyul/RUH5FShBBaAWfEEwbL+3t2HYiwWxzbP1rAjs3GYa+8/aEc4xONDQI/e/mFePVCIQDFImeLi0R8xXDlk/Th2TAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784537; c=relaxed/simple;
	bh=IWLwCF0tTks+BcH1gGdekXSUOOlrCVCpTYBq76sUxd4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQbe4c0Fj7v56faoVxgWa81zrIQTc3/oq54CxIQ3WSpCuCXmKTtPvlgTrjES+U/WN8QyomjZBkDjx5zjmPQmOBeq78GQSWDZ2s9KShabQHgaHSSM4+C4qWt6tp1enp6cAlW1Tw2PQGz3P9YFxxgfZR3e+xh8BszCBV1/Vvt74fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBiaw+wm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43624b2d453so46851785e9.2;
        Mon, 13 Jan 2025 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784534; x=1737389334; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHrDwByXB7zc8FsvLWj9DHABfiPjL/WqT3+dqmrzoHU=;
        b=iBiaw+wmj7m7DgZLRToz7CPJwn33fHb2Fc4YwZ1jJsoQUlPrH+KtwUJQa31kPWgHIP
         NLrgNXIRKYPEXiIo/hSxSEaiFzqcXbBQT71mVV4kIU44SFLaNi8mSKVxXVgiHzWAc7B+
         BD//MiHVaFMwXsiKEmg+w/TnmgdcRV5Ct4NDowv+qJgky6nB6AlHVm+natN3RiZUfyR3
         aCvafh89e86Kx+x55od4/yRavDKqGfpf76duXJ4tDHCnoo3U1QalhdjVUB2lCgSMvz0Q
         r6kvd4fpJgJt+PnVBslVIhpBPu1z9vcarcd1izbQ+aZVGPes1miZwSoFf031DLBD/9Pj
         womg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784534; x=1737389334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHrDwByXB7zc8FsvLWj9DHABfiPjL/WqT3+dqmrzoHU=;
        b=jhAyQxNYBMKmS4w4jwS0WYw1tGhjvTJrmrxvPlGebloEo2+XqfiOwKeEVk+xU3R/3b
         WY8YK01elcUiQiEV7QMo7xaEhen6jcOo3IYUAMrd/2SLGSv+yoTFeDwQxoCNmkZQezn/
         yKsfRzIsPJb/94C67Na/ec/KYfBGkhhvEoxcz8wtszkYCNjhGmiigujL4HLFpbHCN6or
         Pgk9vdrAJwkeJ4EmQGcgz4kr3xpOGJr5e9h+4XfWF13vDJfsgvnG5gMtG99GYmilXk/L
         6XJ1GNCQMu8GttwpitbX+Y6U1RbZVuSQrq9N8wWGPCpIcUj1i3BVSddXE0sunJ6x5x+n
         ViMg==
X-Forwarded-Encrypted: i=1; AJvYcCXbYnf7GUUtHHa4IEy/PpwzaHPiES5uOq7uzTHLpy84HsjR6yeJxjH9x/qkWVyqugisIc4dDlo/laQ=@vger.kernel.org, AJvYcCXe+XvW/+e0ZytbTdcPEUwNALC0n0Og6k8QhtceHzBDxk/4j92hjIjnM7qXuZDU5dTjaj1ytlEFpW5xRkle@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJJDEFaPQe3plqEqNaljo6De0Tfxl/k5XrkNT00/I5awr9WLn
	R7E5pniPDo9hFKEwPtKoItvz08cKOTMUz7VN5htkhSLTU6t6ML7W
X-Gm-Gg: ASbGnctrqQIjFCYj7a8FFHYW0DdUN6CtFGIwXJGB+RrtB8lIHM3vcTpNyEC5WBroCa4
	/yMYC44q0/t9d7MXCQwG7gaxDiuVGwUqJSKNLBkSAkBQUuS1WwIOfVNtCFt1iXMmf+65d39J1ap
	vLIkDdQcqrXTcl3O+JQWHfmKlR5Oi3p570LP/GqN5f87EOu3nFGfLCB/bdOcpEIi3V3YySR4ATB
	btdhCTFGsgnpm4h2428lVbPUzvapjNUVo4ltcG6vPpYP/lBBSloNVTXTzqepdcNTKoTYYp38Sbl
	lqb9Zyhl1KcV2i16vP5ngsWEfYKs
X-Google-Smtp-Source: AGHT+IEPVnsj17Djozr/h+uvsEuSsPiDlE7C2WygRUg6E61RS62wkC12oBMnwoZto5/nqxoddKMsZg==
X-Received: by 2002:a05:600c:4f47:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-436e26e1f6dmr178190855e9.22.1736784532827;
        Mon, 13 Jan 2025 08:08:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fd03sm151973545e9.6.2025.01.13.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:08:52 -0800 (PST)
Message-ID: <2f0f77d1e808dd9c55763ee46839a1cd2a74d5bf.camel@gmail.com>
Subject: Re: [PATCH v3 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello	
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno Sa	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:08:52 +0000
In-Reply-To: <bacd718d-4e6c-48d7-860f-e6de26bed416@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-6-ab42aef0d840@baylibre.com>
	 <bacd718d-4e6c-48d7-860f-e6de26bed416@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 09:37 -0600, David Lechner wrote:
> On 1/10/25 4:24 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Use "instruction" mode over initial configuration and all other
> > non-streaming operations.
> >=20
> > DAC boots in streaming mode as default, and the driver is not
> > changing this mode.
> >=20
> > Instruction r/w is still working becouse instruction is processed
>=20
> s/becouse/because/
>=20
> > from the DAC after chip select is deasserted, this works until
> > loop mode is 0 or greater than the instruction size.
> >=20
> > All initial operations should be more safely done in instruction
> > mode, a mode provided for this.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > =C2=A0drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
> > =C2=A01 file changed, 22 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.=
c
> > index 27949f207d42..991b11702273 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio=
_dev
> > *indio_dev)
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > =C2=A0
> > +	/* Primary region access, set streaming mode (now in SPI + SDR). */
> > +	ret =3D ad3552r_qspi_update_reg_bits(st,
> > +					=C2=A0=C2=A0
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > +					=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST, 0, 1);
> > +	if (ret)
> > +		return ret;
>=20
> Do we need to undo this operation before we return in the case of an erro=
r
> later in this function?

Seems reasonable to me...

- Nuno S=C3=A1


