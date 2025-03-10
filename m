Return-Path: <linux-iio+bounces-16716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A7DA5A6CE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7922173929
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3E1E0E05;
	Mon, 10 Mar 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPnzy/Oa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE8382
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645005; cv=none; b=IlRLy1jfirXqqEP64blpqC6wXgL5S+/JFI2pliuKxTHYWdgk4C8iVDvR0ZQyIj3OmwFaVlxG7f/Xy7MkRfjrQOkHJ092XiE6GgvYTwUQXc+rKmBguwDlUKDX9Xte5zz2iEMFEvOcKC5l8si2xslASmSS0EkeKKzhoAzA76dsyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645005; c=relaxed/simple;
	bh=qXl2SdpuCNmiA2Jgb13ogGbUVRw7z3q193IoJj4D3C8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzxVS2vBll+sxB+1wlNP+mojQ2EHxo3nUwPIEIFefCAODx2dVcge4obhwrq6llyEfGrPw2KESR9CHKNuJCkO6B0WZjkJRh+HuPC3nOGMNoq+dHCNVXiLtcdHEa6M8hksjNOwHLgQ752tLSvzHZKIA53OY2VuxyvVSUIzLuzxGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPnzy/Oa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so9532535e9.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741645002; x=1742249802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XcOMAFCKMEwib8vqPWklIO9zNsQPfmYC+nAf0Fi3RgM=;
        b=BPnzy/OaIDzY1sPf7BfYMwPSPHHpGZODZ1hYJWXY2Sr39lgCnQdaLzhFdaA9FluKs5
         hGGct41C3kQTbdwViNaWjrscRkCla4QF5KYMJHDvZ1uAWOygbbb1r1buJpyFUGzRTjRL
         GaF7oJhWoytBPrsoGduQPHaXnRK9qtqkmFSBvgii0HhupDk9sgRvOnR+COzPtOpxPMka
         GmAqeAsPal36ZOEJ0EEIMYUwbT85bwI3Fwf5YLvUz4jl/Q+3bN5NMe8RQxab3dlY+fsw
         rEso7twIFTwgwnaT5QpnWZypuROR3mEUzD4wC5+0TZAgsb+HT26o81rZLKw/utKRs75P
         7YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645002; x=1742249802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcOMAFCKMEwib8vqPWklIO9zNsQPfmYC+nAf0Fi3RgM=;
        b=ITiDgh4qrAYCUU/U4OKCgEwzFrUd+w/5Ln+0rLIyBKGG+JioUZxMZ+2UmXCPc2OLoS
         XDm2FxsDSqcSUP04Zeo6UanBibHLkHYO936BNcMYmdl4BBXKMtPhY4XDu2E+Yuu0CTi/
         1XgxzP/zhOVIvn5BzZ1lI/eqZRc56LUHY+vc6Eqa1ANBA2g02Ef6NggjzsIMLs83yR9t
         JX6EQAd50OHs9fIxoPZ0q6iH1vCOEzb++c7KroFoT6WJT+/uhGoqXfbfNQD5sTDpB85l
         r4COWOIM3iyTAAFZSuOimtM03NMMce0hLsZflTrxPe3T8Oshixu4UTTCBPBRw8eGp4Nx
         mzwg==
X-Gm-Message-State: AOJu0Yz3XTYllL0DtOrH5z4JmhQRJWVVeE/XIvAWsSwaYv0zjBElS3hF
	f3rMhg2yi30qYT2CdpYtnZlUZ3tGM9YOZo51LNVM2lODgmciyAIwT5ztn3VCNKg=
X-Gm-Gg: ASbGncsSpRD0byTfp2I4TNXyGajQUBbM+gy+0y3UMowKfzrnbarjdLSRdyFMX3Nfmqx
	w0RADQ8ffwyCnElMTnMWg1R7ZgsxlNy2tW7YboHd7/sZ38RXW2vZqbxGJ0pY1Kl1g7XCo8WTuSn
	4VcxbpqwKMAPCwVrp1EJd4MM1exwD2pmJvwZuUbhqqXG1tQ1IyDTIrXKazr9lJXLcELEk+FlkUE
	ur69Pvq0Af/OWFRWH9BhJWQYIGxn/FGZLLmPwMuZLA+3TYK+S4LAd89tWOk+568ZIcX8xFO7qB1
	lg/1r72pyIFR9dfpANkV0pkk2hqFAW2eQFoUofB/6kQlVk5car02Bromsn1qou/2+0FXD8ET/33
	2J/7WKe3WmIa83Kpqx7DDCq20yMx06g==
X-Google-Smtp-Source: AGHT+IGD/HRM9LZLBVjJpWi+7kxx9qhpRAGwNvztd10dHm94mjFaux2iRE19S4maApT+fkn8JisAlw==
X-Received: by 2002:a05:600c:3b27:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43d01d169cfmr13359675e9.5.1741645002104;
        Mon, 10 Mar 2025 15:16:42 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cefd99c48sm72144275e9.23.2025.03.10.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:16:41 -0700 (PDT)
Message-ID: <8e50a509d3603fbe40ba26c48816d3e3c2837a72.camel@gmail.com>
Subject: Re: [PATCH 01/16] iio: introduced iio_push_to_buffers_with_ts()
 that takes a total_len argument.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 10 Mar 2025 22:16:57 +0000
In-Reply-To: <20250310200427.634e9d2b@jic23-huawei>
References: <20250309182100.1351128-1-jic23@kernel.org>
	 <20250309182100.1351128-2-jic23@kernel.org>
	 <dce7a134576836f58c41d5a3cb3bf244f0f9c447.camel@gmail.com>
	 <20250310200427.634e9d2b@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 20:04 +0000, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 08:34:50 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2025-03-09 at 18:20 +0000, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Check that total_len argument against iio_dev->scan_bytes.
> > >=20
> > > The size needs to be at least as big as the scan. It can be larger,
> > > which is typical if only part of fixed sized storage is used due to
> > > a subset of channels being enabled.
> > >=20
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > =C2=A0include/linux/iio/buffer.h | 13 +++++++++++++
> > > =C2=A01 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > > index 3b8d618bb3df..75d5e58b646b 100644
> > > --- a/include/linux/iio/buffer.h
> > > +++ b/include/linux/iio/buffer.h
> > > @@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timesta=
mp(struct
> > > iio_dev *indio_dev,
> > > =C2=A0	return iio_push_to_buffers(indio_dev, data);
> > > =C2=A0}
> > > =C2=A0
> > > +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_=
dev,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data, size_t total_len,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp)
> > > +{=C2=A0=20
> >=20
> > Kind of a nitpick but what about data_len as the size relate to *data?
> Maybe data_total_len? I kind of want to make people wonder what the total

Fine by me... It is starting to get a bit verbose but I guess still on the =
acceptable
side of things.

- Nuno S=C3=A1



