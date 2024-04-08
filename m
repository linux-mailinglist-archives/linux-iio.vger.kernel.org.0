Return-Path: <linux-iio+bounces-4143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6289BA78
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 10:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5893B20FDF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A838FB9;
	Mon,  8 Apr 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH70WkZ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB13B298;
	Mon,  8 Apr 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565569; cv=none; b=dfMGgSUdQH4EoZ+kD8F1kPHkyxGhqI3pPXYAsTWEI43GD7B2Ngur8x1p30ojUWpku1DGOU7o6e7FpDfpV61U7VdkWIIomwaIRSdtEzbd/+fFs6cFkZ1uEIA6PhPXI0xQZ+WOnOhkZ9uEiiFl+dS2LC+TLkSlKZA+Qf79FZqSl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565569; c=relaxed/simple;
	bh=1qROFuujq2tL9WuXLtizRkvBECBqPbdKvVLQMOBmYC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyBKMVfrIzLGL5pLv/mBho6qddGasRFEi5j/J94vdjT9/yFUXh56bZGtsXzomPXQGSlmjDdfl8IPK9/b41nU1m9uCgR5p0ldbWD+yFgpisqK3K4t4r5ker9F5byEsp/t3Rmm6yzVe2L1AgpQnGPOdtQFB74V1M9nwz4qAsoBEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH70WkZ7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51d90def9eso61778566b.0;
        Mon, 08 Apr 2024 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712565566; x=1713170366; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ggn9exM1EaINLQ4p5qpv5HFO8yOhiQUmK3beChxflIE=;
        b=KH70WkZ7jFOo4I//Edc9MhcF0GBjRBkthLJUBIXykQT9HUA6l9pl2vyJmq8Ti0QO0N
         P8LUeX4OMkqe7s2lNdLM9vpJwQiyzCwpCesyzBdYovMjAVTimeJ/WNCVedB7b3vBSN+B
         7uAsxK+XVMbo64n9BvogEKa5yMUx+f8AV1Yy2EuEyVH0b7ogPJfaYy0ZG7cD4IoRWhEE
         91niu/cWe79ySyLZ70rHBKeWUl+V2lS0JzUMD7zqh4+UhZ29ZQs99hfcEOMDUa4V9oc+
         7O8eEYqMb66zcH3RZ4sypX05CIq/Sd+QeLPqIN/Ty+gcxhZmNievlaOxdl/DDsMODNaE
         /oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565566; x=1713170366;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ggn9exM1EaINLQ4p5qpv5HFO8yOhiQUmK3beChxflIE=;
        b=ATUiG+cAREY6cBgKHlDxO7mcaTrOuFfIKyRkdhAg2SNJPNNzI27ex0Q6Tk2zCfiuKz
         sibXOn0mxu2eAUMB2Ee+izcgftYSDX3J2SqiyyIRwM62LsuqMYbnKfuhUfkY7B4CYGck
         yBfo1bQ/hGBuPT1h8IaiNAOWglZcc09JvmQb6EjRnQ2w9tcFUuFYNd1HQlNFzdmc8AYQ
         MsYOI9ynTqNsObDwei6D75uMz76a2GBDJxS8OpWiAwhubZXyAHsyuDrhM3UWOeQaN83M
         MOhQHQVJI2UkuVvOw3IYGdsnLTMJ7GogAvIfCFiyFkqWRogVgKEfatQM2bg5zTTxVh+t
         gRog==
X-Forwarded-Encrypted: i=1; AJvYcCUXLohcQvnW67/6n5ivWhEg0oV86OuFApTziB1gTGiRXIEpjYyJN2xP84Jf0MSS79NGOj4gNe8bWOuzGiOBaUE/sxlFipvcvUfRmA==
X-Gm-Message-State: AOJu0Yysqph98XCwkMJUU3LkTqye1e6OZ1ZpGB2Mv0YmPgot055O/lp6
	TS4PbOy5Kgr9rkidy/lMiaNApRzjrhzupKo/CdqCnlpXyM1+d3De
X-Google-Smtp-Source: AGHT+IE+pv57Gi7+DHUuwKa8elQdvQK+g5+W8zngx1vEN1tPf/A5WB9flY105MqYJ2qj1b5zd+ZD8g==
X-Received: by 2002:a17:906:374c:b0:a51:7ff3:5d5f with SMTP id e12-20020a170906374c00b00a517ff35d5fmr5381817ejc.67.1712565566129;
        Mon, 08 Apr 2024 01:39:26 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090635da00b00a51bd07b525sm2744108ejb.66.2024.04.08.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:39:25 -0700 (PDT)
Message-ID: <dab21fac537be5d4158e3d08aa035736bcedaa5b.camel@gmail.com>
Subject: Re: [PATCH v2 03/11] iio: buffer-dma: Enable buffer write support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Olivier Moysan <olivier.moysan@foss.st.com>, Paul
 Cercueil <paul@crapouillou.net>, Alexandru Ardelean <ardeleanalex@gmail.com>
Date: Mon, 08 Apr 2024 10:42:58 +0200
In-Reply-To: <20240406172352.6784c6e6@jic23-huawei>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	 <20240405-iio-backend-axi-dac-v2-3-293bab7d5552@analog.com>
	 <20240406172352.6784c6e6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 17:23 +0100, Jonathan Cameron wrote:
> On Fri, 5 Apr 2024 17:00:01 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > From: Paul Cercueil <paul@crapouillou.net>
> >=20
> > Adding write support to the buffer-dma code is easy - the write()
> > function basically needs to do the exact same thing as the read()
> > function: dequeue a block, read or write the data, enqueue the block
> > when entirely processed.
> >=20
> > Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
> > now both call a function iio_buffer_dma_io(), which will perform this
> > task.
> >=20
> > Note that we preemptively reset block->bytes_used to the buffer's size
> > in iio_dma_buffer_request_update(), as in the future the
> > iio_dma_buffer_enqueue() function won't reset it.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> One trivial comment on alignment that I noticed whilst reminding
> myself of this patch. Otherwise looks good.
>=20
>=20
> > +
> > +/**
> > + * iio_dma_buffer_read() - DMA buffer read callback
> > + * @buffer: Buffer to read form
> > + * @n: Number of bytes to read
> > + * @user_buffer: Userspace buffer to copy the data to
> > + *
> > + * Should be used as the read callback for iio_buffer_access_ops
> > + * struct for DMA buffers.
> > + */
> > +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> > +	char __user *user_buffer)
>=20
> Prefer aligning char with after the (

I was keeping it as it was. But I can fix it up while doing the change, yes=
.


- Nuno S=C3=A1

