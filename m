Return-Path: <linux-iio+bounces-19448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B8EAB30C9
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2017905B
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7F2571B1;
	Mon, 12 May 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h23yl+ZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FC256C73;
	Mon, 12 May 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036386; cv=none; b=hZCoAH2vmn5aYoDAeoWVjobjdj5mQysEMtOGCplSfWrbQVzFuuTaDB0WXoeRfe4leDrtt4BbI7OTleXZnEnI7tpPvQq6l6Djd6WWlrWwcPb4fwpfgrO+3ryUvhbNdJXAdTcjjZ0QCmKq4VKhaviwRfBtG9gMGuDI9y64zj2rHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036386; c=relaxed/simple;
	bh=isnbYV8jTH6SMpXcosxx1uwezjwExTjsCQIyI0kAwLo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+IGU0mctGOscAnEFYlDTFNU854WVMDtLXVCqY4bhgfpo0781oiX7LV3HVJobVGJTuEcFVHKbeI9lfLYaYudpSVWMzHQB5QlhzKCEfbS17lL7LCwexlnuS77V4/90jEGO1AP4SaIHtu7vpOUj4axOHrHJPOmAczUP7oyOyCqcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h23yl+ZA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0bd7f4cd5so3475738f8f.0;
        Mon, 12 May 2025 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747036382; x=1747641182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPk+W/jcKj4KahuD3Ov6QRv0TumK9Na5GoaM8Yh7J6k=;
        b=h23yl+ZAcu2jaUvdupzmj+1h3Sf+aUuDIwvMpZiiZNlKOQqQhFk2BxselezgLX56/C
         iSer2FigSc1G2/PTG5zGbzToCc0ANPtqHECm1faRauDPmKtJYuY6coYzypWJcjVLuraN
         xfBt7RlyZG9n032Qv3Jpwynrjuu3QOyJwwGfNAb2MzixfgeeiDHDdh14Ud2rxL1Hzsuj
         o2k+Duz4sTFJM3CmW/usw01Ig7sChSYfMK7L2KExmQ4yEfLuvRcwuenAM5kDn/EsqW7j
         sZU2XpvCSDo/rnPZqSk8XXZEipDL60FZAkFLsn6YcrtcpigNmbC4y1B8WYdYBLAEHXgd
         mTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036382; x=1747641182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPk+W/jcKj4KahuD3Ov6QRv0TumK9Na5GoaM8Yh7J6k=;
        b=kMVdP49lxvVRGOJ3Mn5Wj04bI1PKNaFLvl4tyOiaatMM3rQ//pe83pTd99XdvbT7zd
         4oj3wlxUzn714m3SC6sNYYFwyUv6OO3iqWU3j/QTFP7QIa2HkVPzZa9OrJxBE3IWZojk
         +VgJpqw0LhVYHMdN5jx+bo57f91iSl9v5I4dUcJFA2mETzgaTqdvmSoyn6CSn/U0F+TC
         6OXqURu9MBvQsUVzY/0k+n2kkbLK4Whqd3FPLglNTgMo2HRuZESzbIXFW6F69ySbYDO5
         qNgZrgTsBn1s+i3RNZBtfDEFAcrsdaXlQma9/uDskUGQp1dzGhi5mvYZvmNPHbLTeMv6
         xaKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQoAqve/MAltGwlguTCquV6nnyWGVlAJ8b7KPXtStPhQaPrllhYv7WMDpoAHCrOH9S5kvksFtCcPIh@vger.kernel.org, AJvYcCWSQ146PDzCqzddIsIAEr8asl6NfCUobYCl23XfBx2o77wKfQd7KjFcfWCKLpWL3+Rug+Lb66oJiMIM@vger.kernel.org, AJvYcCWSYxNCAMTZM/VhjENNbU1NQfCVuSExDAyefDIay5yf5z6P8PdhU1lkfRYYH15DKT7kxUETZebI4q2NHnTr@vger.kernel.org
X-Gm-Message-State: AOJu0YwunfbCEg6lruyzrK3X4ugTLuir4QwSjAbS2h4+yk8EyNSo5w8I
	62lPFY59Iv9LkQ0G9CVJ83dlw7BazJ6FBHrIoHPM9FStHtgW6Thv
X-Gm-Gg: ASbGnctx2drIOS7xVhcQMypFyb4ylD9IsVDTL9nAzCrKD0LOUa0wozDvWaNStS+802b
	zIvFucPG2apn1EXwOqEvTZlSfCaiTVaKSyHCZphIc0BUPugmqsCEQSRq+sxaw4GzP6Ow6UezBCM
	1BCxDuJ0snsPIaZW7o8CCxb6pc5cp9AHcwTauR6zDJsl2pCCHvCunsc5R7VCdScAoYqrhhHvxur
	mxtLOhfikExsuYs+X9bPlYHVWvkm9jpx/zTlL3+xl/rnkTO2NS6gku+Hs5tqwpXe4fD3j5Bknht
	YxbRjWfQ9mdxiFRkU98iZPTcP7QE76tTv4aEKfgLaZWYLLT/D5r4RLikncCgedYcWI1sSuuL/iJ
	5VUooMf39fW0nNmZSQk+RzNnOqw==
X-Google-Smtp-Source: AGHT+IGOQ+EFDLGkYtWQu+16fjBJc63uVRNsF6+99EfyeVrzgyeYWZISjDFaq+Wr5JblZR6ChVMnXg==
X-Received: by 2002:a05:6000:186f:b0:39f:fd4:aec7 with SMTP id ffacd0b85a97d-3a1f643a593mr9745003f8f.7.1747036382394;
        Mon, 12 May 2025 00:53:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf1bsm11686801f8f.72.2025.05.12.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:53:01 -0700 (PDT)
Message-ID: <cb2eabee32d1cb6128a7ef15aae749806ca19541.camel@gmail.com>
Subject: Re: [PATCH v5 02/10] iio: backend: add support for data alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 May 2025 07:53:27 +0100
In-Reply-To: <20250509105019.8887-3-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
	 <20250509105019.8887-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 13:50 +0300, Antoniu Miclaus wrote:
> Add backend support for staring the capture synchronization.
> When activated, it initates a proccess that aligns the sample's most
> significant bit (MSB) based solely on the captured data, without
> considering any other external signals.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v5:
> =C2=A0- add description for data_align function
> =C2=A0- add suffix for timeout parameter.
> =C2=A0drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 038c9e1e2857..545923310f1f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -796,6 +796,29 @@ int iio_backend_filter_type_set(struct iio_backend *=
back,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_data_align - Perform the data alignment process.
> + * @back: Backend device
> + * @timeout_us: Timeout value in us.
> + *
> + * When activated, it initates a proccess that aligns the sample's most
> + * significant bit (MSB) based solely on the captured data, without
> + * considering any other external signals.
> + *
> + * The timeout_us value must be greater than 0.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut_us)
> +{
> +	if (!timeout_us)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, interface_data_align, timeout_us);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate)=
 mode
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 5526800f5d4a..a971a83121b7 100644
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
> =C2=A0				=C2=A0 unsigned int writeval, unsigned int *readval);
> =C2=A0	int (*filter_type_set)(struct iio_backend *back,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_filter_typ=
e type);
> +	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
> =C2=A0	int (*ddr_enable)(struct iio_backend *back);
> =C2=A0	int (*ddr_disable)(struct iio_backend *back);
> =C2=A0	int (*data_stream_enable)(struct iio_backend *back);
> @@ -203,6 +205,7 @@ int devm_iio_backend_request_buffer(struct device *de=
v,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev);
> =C2=A0int iio_backend_filter_type_set(struct iio_backend *back,
> =C2=A0				enum iio_backend_filter_type type);
> +int iio_backend_interface_data_align(struct iio_backend *back, u32 timeo=
ut_us);
> =C2=A0int iio_backend_ddr_enable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_stream_enable(struct iio_backend *back);


