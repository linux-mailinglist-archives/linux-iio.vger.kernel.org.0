Return-Path: <linux-iio+bounces-27464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF6CEE290
	for <lists+linux-iio@lfdr.de>; Fri, 02 Jan 2026 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43093007C75
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jan 2026 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF52D8DD9;
	Fri,  2 Jan 2026 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFy5F7c5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DE25BF13
	for <linux-iio@vger.kernel.org>; Fri,  2 Jan 2026 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349482; cv=none; b=YlvR4U24qdu2/8fnbGRTN0+tXlEo+Abuq31QitH7d+WY1yIl/Ydhf8RT6RHQfU06DFzgo/me2wffifueY0lBfdG0W6EEVzDV4BAbXqqyysX1/xZOeYS4id87DD1d9Ah7vr1n//6Hloq5F0FRg02js1OkgwX+OOgcfPEaoSKnsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349482; c=relaxed/simple;
	bh=Inf6vFoMr7AeWr71RodfHSvYSwpzt/uXSmUX8arDCWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFWaqlTQuVlc+UTHc+SzklZLb2/KeyOc22fornOBfe0FHOJDJi6Q2iMm0MdqCyzIQz2NP7++Vp6ltqzq5BDm/fE1qN9ucS89usf+ggIZ1P5uRVMD8oZTjWPyIKthrH/bhMGK28kNPbL0oLeL09lT5dUfLrf+rDejFCCjX0Hhu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFy5F7c5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso7193984f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Jan 2026 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767349479; x=1767954279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Inf6vFoMr7AeWr71RodfHSvYSwpzt/uXSmUX8arDCWE=;
        b=eFy5F7c5eEgzyeC92gW5cQmJFNNJvt9scx7hdnKpCwcLD45tnN/xasvLXH21Lc6owE
         QhcAS8a1IRWWl41ASleC66TfzAzbd3dFE20KfRFIqzgpMv2DdWR6A7WiBnqqgZ5E6QbY
         XLInDsT5pksM3j6DSgSyWPlY/dsAOg7EVXZ+7j0692G4i7st4DUAfTUiQfE5fbvNiBLr
         WopwLRTU80aRxufzhVBSpTzEEh9HbM4NMs17vpwbpjOQZ09MXBhcZHbeNDAdCKWqpW2r
         1c2JRefoItqLx1PjJQCYglCcgXY3mx4L/U0/mcrPMDxi+akNbnsxOXDRnaEF05xxkmym
         hUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767349479; x=1767954279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Inf6vFoMr7AeWr71RodfHSvYSwpzt/uXSmUX8arDCWE=;
        b=Ndu0v/9fpSa0YZKV/Hwklt2DHocxyHav46pHxF5dq+I98eCYv9ys1E2ZL+QCSNOAUr
         P0g/5OW41X7vQSH77Nd6y7URliJyc3mYHU+0KBJA+JoU08Wh/op08zLrXzdztncRyEO6
         IwwuLaKdsF1fTwLMqamHmsRnhNUrbweGAYeerzwu0RG1ntBUx+9Tlhk4fmmw9WCAM7xA
         icBIIVL4bg39FJm5TmsIrWvC2YnbK6xuN1ryY0v6R4CESNW/s5zVi0nCnPa9Sz9/cisF
         SgeF11tDCJcxRXOvv8kr2jI/MHRgsD9+LTBX0LMbn3rCrDLX3Tc/NgCvPEUAOFNNJRxb
         0XnA==
X-Forwarded-Encrypted: i=1; AJvYcCX03iUI5a+my7JOc7rdZHp2ggY04W9H+zzrKHxu8I8sdTrpgAbuW5ev1w+jlGPdGOiHFhTy5BmROgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIt7C+5KkAZe+ya7k5d5NVESYuUNye9OX6YHnHkyo5f6wQnJ8
	n4B36R4xPXTMB2SHT/CrrWuS2YjD8tNV1bis8FGpsTSJ/g6M3+nVudIf9QQUfw==
X-Gm-Gg: AY/fxX7ayEPlWX9rw0EM2xPzIwW+ENFMp+bPMRSuZJr3DQ7Te16B+VpwdwUJe/JVIas
	Z5QC5wIqf5G3h0kMlTFRI3BzTT4/04nO4aPP9hxCedCbfSaJhF+ldGLIiDhMVu4HoTQl/1pQckO
	iXDjqwUaC3gHqZsj2vm6eDYj74uZoCfBgC/61JXfN0Mj4ARR5h4w578htsfweNwkF2QAs1YY5Iz
	bSkC/XvYP+z8dOt9E/BP0/LjY0HLS4Z24bolnzUTCmMqh1DSNyRMCygq8jNf5b6KSSCzjSHsWqH
	DSzOcF7FX3Wezs7k3UWbczsk7Z4nVdHa6kROcaaAwD/8Ko7KFdz5ymgChCmvsJ+YskMCeUc+UFB
	scfzsQaDU1krmhtWHdQEzKW4BDTegzMSzFAV5gMQ99g+eJDhR9dkE6i1WWmUMQ4T+a3S0Almn4o
	md0T3m1g2tFIBFsARkalFeNzI2/qG7Kw==
X-Google-Smtp-Source: AGHT+IEbWTlbn3sMz1WvkvC70j6Yrk4Syhk4VJsVpP3UvOR5dQyrK+j7xHFMD0t8mVZa9KJOeuUcFA==
X-Received: by 2002:a5d:5f46:0:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-4324e50d540mr57964389f8f.45.1767349479286;
        Fri, 02 Jan 2026 02:24:39 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm83919335f8f.7.2026.01.02.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 02:24:38 -0800 (PST)
Message-ID: <9b92a721cefe9ace63b15d049c463f4c26079d9d.camel@gmail.com>
Subject: Re: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 02 Jan 2026 10:25:20 +0000
In-Reply-To: <CAHp75Ve5TF76gOVgxxW_RGqD10L40EC+gu3URfwrKk-gkh7Q4g@mail.gmail.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	 <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
	 <aTBmriwVrMwlKiXX@smile.fi.intel.com>
	 <760dce5b5721ae6e46daeac03b96df7b009db3ce.camel@gmail.com>
	 <CAHp75Ve5TF76gOVgxxW_RGqD10L40EC+gu3URfwrKk-gkh7Q4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-27 at 16:02 +0200, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 5:03=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> > On Wed, 2025-12-03 at 18:34 +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 03, 2025 at 03:11:38PM +0000, Nuno S=C3=A1 via B4 Relay w=
rote:
>=20
> ...
>=20
> > > > While at it, fix a mismatch between the function declaration and de=
finition
> > > > regarding the struct device (dma_dev !=3D dev).
> > >=20
> > > So, all others use simple dev?
> >=20
> > Totally forgot about this. What do you mean by the above? If other func=
tions in the
> > header use just dev? If so, the one I changed is the only one that uses=
 struct device
> > (in that header). It is also consistent with what we have for the devm_=
iio_dmaengine_*
> > APIs.
>=20
> Does the device, that is physical, DMA? Or is it a separate device for
> that purpose? I mean that naming may suggest that they are different
> devices. The original Q was about APIs. Are all of them, after your
> patch, use the same device semantically?
>=20

This device is the DMA capable device which provides the DMA chan which ind=
eed is not the same
as the struct device in the devm APIs (that one is the consumer). So dma_de=
v might be a better name
even though the docs already make it clear.

- Nuno S=C3=A1

