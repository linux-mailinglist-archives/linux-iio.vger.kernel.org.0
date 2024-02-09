Return-Path: <linux-iio+bounces-2333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A482F84F0E8
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 08:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5954F1F25B63
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6E657DE;
	Fri,  9 Feb 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJmFclJv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6F657CA
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464326; cv=none; b=i46P6ZFA86mB/j7lONzorOiL0vZd8Bp187Fxjo7Kx+UtBxm/24PyJKHX1JWDTMQACifyFQt8glTF1lqJxshBsYiLG27i6WjBE3XnOlcHwMYMY8QISbiKOZvxi6d12qDM0OSQ+vv8P1bna0HBvSUjV2jTE2hJdpbPNo3NvPFma50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464326; c=relaxed/simple;
	bh=ZP/1j0Gy9pY+fnHashRRjeL9nucjMXFcKMAL+mXm1X8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0zz+Rs8y+5fe3ITzrjxdEiVQ4EwlBZL8R7H+aK9EDn2PiHdFMcpkEo42KSUh4HDuNJtqGsbmdcFGcIjZ2KCPKun6KLEhyp2+Zu2/SvwLyHbaUCCQYl/sPbQd1eUeyQkqS/6AHqdthwirWkvQ622fMqMkk4PuKV4AcMJr14se1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJmFclJv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so77541166b.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707464322; x=1708069122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34556y/QWj5JRGeNNxMnROMvVDC9Ee4qOiaFioy+2oA=;
        b=BJmFclJvAakd9r8zSadkmZ++6PdjtNfTHuXW4zxwNb+JxquC15O1fJtJC3WDtclEe0
         G3MiOij0KD4jJDm8yxa7He1ROzqywLjgLfrpd2dhkqVGSQlDuwpT3efz3zWU4IJZaaoV
         L2K7/EDee+w1KRNdDH5CmFyMG3zzEbMRtZ8n2h/WLGhfeCJudCOBKoKa8vK5G3yABpfN
         202YTEOL37eABo1c24Rb9sSx5HBpRcWE3ZmYIRFxdQjfTCP9wuOiQtMkhC8gFzoFlQId
         671ti6d99uvyaE1LASxaA8s+xbsjCA2GGIf1W2hDRmp14s/JLXxuTDCX4VYJGrbjkLVn
         j7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464322; x=1708069122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34556y/QWj5JRGeNNxMnROMvVDC9Ee4qOiaFioy+2oA=;
        b=iHWIu7Y6bi9XEz9j7IBEheHuG1s+xnfhyfhB3boqb+EJwi9bZW6ANmMMv8XnPLH59m
         +vqC7CRgrhsLE8XhfHG9LJFR/V9BokPa9B4RgNje3nWn1hfatBinUZLl8Bw5skVOqqdp
         00PF4T6kGpPIoxHhVRGAMg1sOhp9/75b1nWC7FTtVV5Fhumphz7t5XbyP354Rjc6wNCI
         7OUWQZ3kKnF4YSq3bAqnP3wO1NwUBxIKJc6Pw8MSOkdI9gfxuL7TCIhRoOs20/oktafL
         WPEsgCZ1QZTxTJP5J0+2TEaIUBNI9lS7N/KJw+SzXodpk+ak1Wy2EFTEd4upXBjQwHYt
         ckSg==
X-Gm-Message-State: AOJu0YyoPM3wlnxyBjv4efMY61NHj/hgpIVV18cDgyoeKk5++lOpvZop
	Rf+bnvZGOmhoycCyWC4RXCmlvvkb0oxdtd0RnFq+3351V15vDBcvgshycsktJhcNig==
X-Google-Smtp-Source: AGHT+IF5nI/UUjIUnRyweO/R61YwqPaxXYi7fW6cT9COHCv5jdNYlyBL63JT/PdgFZEM/vLaLEKRHA==
X-Received: by 2002:a17:906:f6d9:b0:a38:1938:3d41 with SMTP id jo25-20020a170906f6d900b00a3819383d41mr478072ejb.10.1707464322448;
        Thu, 08 Feb 2024 23:38:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm2yrAB4nn8/Tbd1s1+Ff9CY3MYR8YNm5daiG3v+2dHqBNRrrjKsrcYxFzMayQW3Wppq8FN+2dHowJhhxrmfQB1k/brrnJWJKtQiPWCLjgqXMtzvOltOaklou3ilkx2tkUT4ROodVkmoyeFRRtd+T7bjvl7YntDHy0zj4m7B/y0hLgtB7rtmE88hGAMqkB8GO1sgRzZ9Vef+OVWA==
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a376758a10bsm496115ejc.17.2024.02.08.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:38:42 -0800 (PST)
Message-ID: <2ada0bacadf63dc4216a9a7f4d9d5d47041a8c8b.camel@gmail.com>
Subject: Re: [PATCH] counter: fix privdata alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: William Breathitt Gray <william.gray@linaro.org>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>
Date: Fri, 09 Feb 2024 08:42:02 +0100
In-Reply-To: <ZcUeyN8OF49CGqij@ishi>
References: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
	 <ZcUeyN8OF49CGqij@ishi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 13:34 -0500, William Breathitt Gray wrote:
> On Mon, Feb 05, 2024 at 04:58:14PM +0100, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Aligning to the L1 cache does guarantee the same alignment as kmallocin=
g
> > an object [1]. Furthermore, in some platforms, that alignment is not
> > sufficient for DMA safety (in case someone wants to have a DMA safe
> > buffer in privdata) [2].
> >=20
> > Sometime ago, we had the same fixes in IIO.
> >=20
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/base/devres.c#n35
> > [2]:
> > https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.=
org/
> >=20
> > Fixes: c18e2760308e ("counter: Provide alternative counter registration
> > functions")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > William, if you prefer, we can do something like in IIO and add a
> > specific COUNTER_DMA_MINALIGN define
> > ---
> > =C2=A0drivers/counter/counter-core.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 09c77afb33ca..073bf6b67a57 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -34,7 +34,7 @@ struct counter_device_allochelper {
> > =C2=A0	 * This is cache line aligned to ensure private data behaves lik=
e
> > if it
> > =C2=A0	 * were kmalloced separately.
> > =C2=A0	 */
> > -	unsigned long privdata[] ____cacheline_aligned;
> > +	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
> > =C2=A0};
> > =C2=A0
> > =C2=A0static void counter_device_release(struct device *dev)
> >=20
> > ---
> > base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> > change-id: 20240205-counter-align-fix-3faebfb572af
> > --
> >=20
> > Thanks!
> > - Nuno S=C3=A1
>=20
> Hi Nunon,
>=20
> This change sounds reasonable, but should the comment block above
> privdata be updated to reflect the change?
>=20
>=20
Hi William,

Yeah, maybe. I can spin a new version with that... To be sure, you mean (in=
 the
comment) private -> privdata, right?

Also realized a typo in the commit message:

"Aligning to the L1 cache does guarantee..." - Obviously, I meant "does
*not*...".

Thanks!
- Nuno S=C3=A1


