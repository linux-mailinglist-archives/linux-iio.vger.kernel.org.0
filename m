Return-Path: <linux-iio+bounces-25758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C0C25C40
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D04FCAE2
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5527702D;
	Fri, 31 Oct 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgQ37Uaf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB9192B84
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922776; cv=none; b=aBiylFIHL+mTypVnPpSZzLFzCjRg0c2QwqaLrQO4tUCA2oDbwoCMBpyeBTLFoAKFKpEZcVNP4OStL0wkm+feAmDFcchlGxSeDOzD46QWKVMMnseziEEmq1sPxiIUpOf3NNGzMM6cWagJ2yaE5DN0FbHr0VfWbpDXJaqRx5fG8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922776; c=relaxed/simple;
	bh=iVrKdL7BJ1WXlZNZq+FP2Vdv2KnfUVTjh0VfJ4aJAuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPlYnRP1EslgZ8EaJBBiIWtlPPQ3D9UAS8fal9Le733PPiYwAvXg2JDf82GWqH+G222iCy1qFMCNP1xkGbd+pv3lusHmTUxnL83OsIUT+CGNIXr745sCmi2546CN7mrxnAnG7hi231igLRNwG/8o1GCS5luBnmhq2hdQ7y18Bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgQ37Uaf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so20539435e9.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761922773; x=1762527573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJnZGaYlxeq+sjdV1MOCrXQbu0Mx2xQC4/pPwml1y+E=;
        b=jgQ37Uafs5kESxXdzyTJXRqBZGQPBv5XD/OFSii/fIuLlb/LGLUCK++WAbC7TcPnNr
         W8YMFcvrLIeAHn9izEmSWExGWG20nWcoxJskF2MTMAqIk3ITLY4zbt9wv8WWngIZJPjl
         lkqJAut11aoPJSfzFF1N4m5zEiZ/BLBc/HiKp8AScRMn71wFNMGTHRUa44zner6lGAQd
         Ygf+MqY1icZtjPR46bORlC+s47ZKBPGNO+KTsdIC1e218O/tFVydYPbQ5cJH0hCsd/ZG
         2OA5hvoDJ2+POHq5zh1Ev2NimO9GYskDTLOub99a3JwTBnLaGRE+u1CC18xaxVdydLsv
         8Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761922773; x=1762527573;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJnZGaYlxeq+sjdV1MOCrXQbu0Mx2xQC4/pPwml1y+E=;
        b=GDQZfplmjDxAJ848bhg/qCijKwxzTZOfahR4yqJqPlDdiMukVKmBUQd99Mv/gGWPA0
         Zi/iLlJt4yMf3MOV7n1mTSckP0gs2NBKDljNQASXGc2zRSpxc3liVGXYdROX+OUACL9a
         O3zHbKNVuJ0WR7fTzv0GuOlAwQZyIBdCns9XmRZ3ZJs5OK+o70AAzbIoOMMixBC2Vfm0
         hrlzHF/96MD2fa9PLTpB6jAR4qxjuhrU7Opw1jU8pwcG5VbdF84PMEbPTGYa4wx+/Djc
         KahsJp7NmeDXLJZ4u5Zqw4mcSbPH7fo7zalQM5jyllG3L9Cs5wxm2WasvSNm4qHiqH5/
         qutA==
X-Gm-Message-State: AOJu0YxrOHsCxDdV+uvLDSvpR5oenSm0Jwhu5dp4N43Sx6I/5/6a+788
	Uf1IADuAkSKritQj32EPPefqxMhioyoe6Xw9C4qvToNUgQZL71DAKnuR
X-Gm-Gg: ASbGncts18QaVmH8MpPqh9kqlotS0cPzJulF6nW0unuSp97x1ZG/yMinbye7pBXzTFJ
	G4LijaBxUyxfY+I6OsA58D6lFbPU9Mk5pvU6jrJnjMfc7b+DvYN+ep007bwQOvfkcYx5SOOj6Ch
	hA6el45iquFig0dcbiHNgcrGyVQ3uNFVgYstk4IWhmNqLeIehbdc4/c1f3UzksAO5CUv+M+lJth
	GGGSrHaFv36bZSueHr8PSwIn4Ke2HpcUEBB27+3lNXTTcMMCuBU6zb48H4F7OhSEjMZr7l5AyGM
	aPznBI3Uto2wkvTjeZcSeHedXNYSJW+E493kjVuATIV1jF30+nATRP8xZrW1AcNOc8qkVlJPvTL
	BvB+FPPLL5elE0gutZRgM0iMvG0FVmM7ZWSZ/hjwIu98wCdZNH5CqnGhWhWkoGZVS5SvCVjaNZt
	AOggjn1ZBB
X-Google-Smtp-Source: AGHT+IFu+hJP2b+lhWQU1zyQiE9AEQuZRYDB6xpzH76opEtM9+yCnV6gIfCnzpBDuOq7h4fO+6a/wA==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-4773089021cmr38971495e9.29.1761922773018;
        Fri, 31 Oct 2025 07:59:33 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm3947799f8f.23.2025.10.31.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:59:32 -0700 (PDT)
Message-ID: <83da9af88f23bc87c558e220d7d1a32a0d91403d.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko	 <andy@kernel.org>
Date: Fri, 31 Oct 2025 15:00:07 +0000
In-Reply-To: <aQS7YIxYH2suDmoS@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
	 <aQS7YIxYH2suDmoS@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 15:36 +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 12:31:23PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
> >=20
> > Make sure to use DMA safe buffer. While for i2c we could be fine withou=
t
> > them, we need it for spi anyways.
> >=20
> > As we now have DMA safe buffers, use i2c_master_send_dmasafe().
>=20
> ...
>=20
> > +	union {
> > +		__be16 d16;
> > +		u8 d24[3];
>=20
> Why not __be32 d24; ? Yes, it will require explicit size to be provided, =
but at
> least it will look consistent with the above. OR u8 d16[2]; ? But then it=
 becomes
> simply a u8 buf[3] __aligned...;

Because I'm just keeping put_unaligned_be24() as before. In fact I'm just k=
eeping the
same type. Sure we could do __be32 and the cpu_to_be32() with a proper shif=
t but=20
I'm already doing way too much than I signed up for when sending v1 :)

>=20
> > +	} __aligned(IIO_DMA_MINALIGN);
> > =C2=A0};
>=20
> ...
>=20
> > =C2=A0static int ad5660_write(struct ad5446_state *st, unsigned val)
> > =C2=A0{
> > =C2=A0	struct spi_device *spi =3D to_spi_device(st->dev);
> > -	uint8_t data[3];
> > =C2=A0
> > -	put_unaligned_be24(val, &data[0]);
> > +	put_unaligned_be24(val, &st->d24[0]);
> > =C2=A0
> > -	return spi_write(spi, data, sizeof(data));
> > +	return spi_write(spi, st->d24, sizeof(st->d24));
> > =C2=A0}
>=20
> ...
>=20
> > =C2=A0static int ad5622_write(struct ad5446_state *st, unsigned val)
> > =C2=A0{
> > =C2=A0	struct i2c_client *client =3D to_i2c_client(st->dev);
> > -	__be16 data =3D cpu_to_be16(val);
> > +	st->d16 =3D cpu_to_be16(val);
>=20
> Not really, we don't mix code with definitions (with only few exceptions,
> mostly related to cleanup.h).

I know, and that is fixed afterwards. That is a cleanup that does not belon=
g to this
patch IMO (and checkpatch kind of agrees :))
>=20
> > =C2=A0	int ret;
> > =C2=A0
> > -	ret =3D i2c_master_send(client, (char *)&data, sizeof(data));
> > +	ret =3D i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->=
d16));
>=20
> This will add a quite an overhead to the transfer (not that I=C2=B2C is s=
uper fast,
> but rather the processor is going to do _a lot_ of additional work here i=
nstead
> of doing something more useful.

No really. This exactly to tell the i2c to not do any bounce buffer if the =
adapter
calls i2c_get_dma_safe_msg_buf(). So I would say, it's actually faster.

- Nuno S=C3=A1

>=20
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;

