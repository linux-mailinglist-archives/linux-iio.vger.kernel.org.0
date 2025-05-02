Return-Path: <linux-iio+bounces-19002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61EAA75FC
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9459E167A
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F12580FF;
	Fri,  2 May 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmj20tWy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DC257AD4;
	Fri,  2 May 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199581; cv=none; b=lA8hvOQVxzlCLQSb618JeekaJLi0UHN93RpEUULoNwgpIJ+F0iGV7WkoPaV7LVjct/uxIibUmKHvyvWoKzf//KcqLiB4r/Z65jXYTEK9B9G5SJcyBFZiABs461NbI3xDs+h7F3xWBL51SSo8b0hi8mrVRYUi/Ji5DVWYQ5bgQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199581; c=relaxed/simple;
	bh=TOFMUxNS2/4TZSVKVnuIHht89nFkd+rBPXsXltpT5Tc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iaJeGZG7IuG3FSJ+rzyyM5muflMjnJa7+f4LN/zl8cMZsQIv795FHgj43slKgSkqtckIC1aS+DDmExqLyDHUutu2pAvZEtqaIctVfw5e5fToteKIrDgFn5cFQzx063DKEtDT8EbbFgltQ4WaoCOpnFEPwcqW2kVIU/l0VGYJ8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmj20tWy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso1275981f8f.1;
        Fri, 02 May 2025 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746199576; x=1746804376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gHMqjVT46s55Pozie3W8hy9mIfIJmy04WVvupkhU18=;
        b=jmj20tWy2VIlhBQf1Yxu22iPVgw2vtwUhU8NXCdikoUoO33JDYxjvA23U2SmkCrTIL
         dTXwkkhObQm+JqlcoGTlElomfPVFf3Fo5KEtr250rviWlw7K1+aWnfrIBrMzWy+2lug2
         YjXstHGnVtpOsoB6AA12AQUsCsk3l5vyRcu9B6Fz+kQE/ZS4NpkaCFxFCi8P+BfNLUGF
         Xe6lyh/vV6eAq/NXZ2sBBZ/d0GEPW++KM2/LKW2HH1JQypzZQIefc2N9iQIGhk1eKGdg
         nX4TIrur5pltZ8xzwhIiZDN98BUC5Wjcw8dPUghE0uqS8R2l768RV313laSzt99DBRYA
         +mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199576; x=1746804376;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4gHMqjVT46s55Pozie3W8hy9mIfIJmy04WVvupkhU18=;
        b=SLXX5C7rVmntdXfRYTFNMP2ZxHI0rILzo8wtLcFnB29n13Gi3XiMs8WvwhS6GL0+rS
         whw5wquzkfpP73O23tPrLo9vt5wCyTQLYVI8kY0BncBVk8sGr5UjeuZhrFZ2GUk9kuH8
         DhJ4T2r9W4eUZNNroI0F2TLxV0Fudws2DKeL3EbhZ3pO/S1G24Az2GDYq2IWIugih9MH
         JpDtS2CynfNCYZEvwNsbv3GKW8gApkH0VyQXWXo5ug7W4XNsvkKcDyQ7qO5jqSUHq02H
         Nabt5yA9JRPIRoZnN7sk3dCF3NkeW99o2UjdGk4lLy7///0b9uJZHuNXjLAaIxSQBKvM
         ma+w==
X-Forwarded-Encrypted: i=1; AJvYcCVBlAf5vlmGpkYkxMo0mDH88uQpp5CP0UuaSmCzxS6rraSXwpclKvm2HONN4rSjJCX70KHqUw6PaoBx@vger.kernel.org, AJvYcCVjiywK4/2I/7vYEFJZ5XfJvRCP5TtTSGlB9bwGZ9f4WY5JY+tlVXSjBEoMviDYum7ZPPsCd7DISJ0y@vger.kernel.org, AJvYcCW99fCVcFp6O8YbKYj6Q2/BrG8ca0dw7IOULewVp0BaWnQLN22JRFLyidWn2JpRNiL8VGi8xkqNwdfKBeFK@vger.kernel.org
X-Gm-Message-State: AOJu0YwtuIpaRSTaI89LXvsPFBhboV1M9uvIw9zelrBsAllgHG1V3sLC
	yZodr/t9EeT59d9VWXjTWFnFPEYst30X11VaXvV2pzEwPJSgRNkd
X-Gm-Gg: ASbGncvJu1dxVvRcOPBKLps4ix/P3jUB9t81Ix/NVOBVxsWhzPvv69giRd8V0x0z4oU
	mTeLKO5fGv7QMKJP56Lsye065/M6AALWPqS5K8QUjg4fAlsBQqcxbbJEd5uzaWouv8ucwhU1/nl
	6/2dzPCyn8YGQRQe/TqjNb2v/5r+P+WY8MlVXm31YFzqorBQAmCKBuTzUhrAzGBv69LfPfV0Wkg
	Zo2I6U64jUiuFb6Yj98+/28suVudnRE17NW1otQtTzlp1mmiHY8rmShK97fFbIZDgJLdUuM+4ZB
	swsw9sZQGjOLwVEvOWQ63yx8Xcl36K/+cBxrtXQU7XDGjc/o6giDJdp/USYbLQe975IYFGBfOoP
	4oGT/zRuFvTmJ
X-Google-Smtp-Source: AGHT+IHNWS05xGhNo7XYO5K4ZF3dmLlkeAuJQLxQS55Busa5I9j1z85zKYmNTNx6fVe0V1kyy86myg==
X-Received: by 2002:a05:6000:1a89:b0:39f:cfc:d520 with SMTP id ffacd0b85a97d-3a09835604bmr2912802f8f.15.1746199576192;
        Fri, 02 May 2025 08:26:16 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b170b8sm2355945f8f.82.2025.05.02.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:26:15 -0700 (PDT)
Message-ID: <0ebaa8bc80dc8dcbad6b55beb7e9e59d4eac48a4.camel@gmail.com>
Subject: Re: [PATCH v4 02/10] iio: backend: add support for data alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 May 2025 16:26:19 +0100
In-Reply-To: <20250502085905.24926-3-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
	 <20250502085905.24926-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 11:58 +0300, Antoniu Miclaus wrote:
> Add backend support for staring the capture synchronization.
> When activated, it initates a proccess that aligns the sample's most
> significant bit (MSB) based solely on the captured data, without
> considering any other external signals.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Couple of notes from me...

> changes in v4:
> =C2=A0- implement iio_backend_interface_data_align with timeout parameter=
.
> =C2=A0drivers/iio/industrialio-backend.c | 14 ++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 038c9e1e2857..b7cbbc7a8fcd 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -796,6 +796,20 @@ int iio_backend_filter_type_set(struct iio_backend *=
back,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_data_align - Perform the data alignment process.
> + * @back: Backend device
> + * @timeout: Timeout value.
> + *

dData align is not a straightforward thing so a description is definitely
helpful here. Please add one
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut)

It would be nice to have a suffix in the time parameter. I would do timeout=
_us.
We should also document/define what happens if 0 is passed. Should we accep=
t it?
Should we block indefinitely? For starters, I would likely not accept 0.
=20
> +{
> +	return iio_backend_op_call(back, interface_data_align, timeout);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate)=
 mode
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 5526800f5d4a..452cb2838dad 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -109,6 +109,7 @@ enum iio_backend_filter_type {
> =C2=A0 * @debugfs_print_chan_status: Print channel status into a buffer.
> =C2=A0 * @debugfs_reg_access: Read or write register value of backend.
> =C2=A0 * @filter_type_set: Set filter type.
> + * @interface_data_align: Perform the data alignment process.
> =C2=A0 * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> =C2=A0 * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> =C2=A0 * @data_stream_enable: Enable data stream.
> @@ -161,6 +162,7 @@ struct iio_backend_ops {
> =C2=A0				=C2=A0 unsigned int writeval, unsigned int
> *readval);
> =C2=A0	int (*filter_type_set)(struct iio_backend *back,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_filter_typ=
e type);
> +	int (*interface_data_align)(struct iio_backend *back, u32 timeout);
> =C2=A0	int (*ddr_enable)(struct iio_backend *back);
> =C2=A0	int (*ddr_disable)(struct iio_backend *back);
> =C2=A0	int (*data_stream_enable)(struct iio_backend *back);
> @@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *de=
v,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev);
> =C2=A0int iio_backend_filter_type_set(struct iio_backend *back,
> =C2=A0				enum iio_backend_filter_type type);
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut);
> =C2=A0int iio_backend_ddr_enable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_stream_enable(struct iio_backend *back);

