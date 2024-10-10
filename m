Return-Path: <linux-iio+bounces-10387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FEB998708
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BF928324D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F91C7B70;
	Thu, 10 Oct 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcCj1dfG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3D1C330C;
	Thu, 10 Oct 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565354; cv=none; b=LC7bMUKfurkHYRYFyc2C4U++vPtNYFf1ghPaIXlYRTuY8G9BFOmhr5LE7DtAtPzRVAtmkFRdoie7FR8HBuHJdUL1QcdO7DK11GgbhfZIybxg1T/cwsppxa+/zA9e4iziRVo0Nf4nL+wsfdsUETGENwfl8JlQCANd/r8MM4RMhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565354; c=relaxed/simple;
	bh=PA+AyIK6HVAOwxFW+cad6bDe4pCNTmVuDFKilUPqNfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQvH9YpMPrS+CZ8bk9dw3Wwi2ndsB9sXL5JPbJUM55F4j3v/L1jrdUkAJoY9j5+D63z1Ihuy3RK8JLyvb5Xuzkvyzvtuex131iedn/0v6WrY7l6u1HeAQ0mwzxCcc+l0zAb5EEEif9Omq54IKnpDTC6HB6ok7sJC2YP7JwqcFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcCj1dfG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-430558cddbeso5851005e9.1;
        Thu, 10 Oct 2024 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728565350; x=1729170150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9DiEWt7hAhyZIjlst2WRz52IU6Lfsq/DckUi49+8mp8=;
        b=lcCj1dfGefBBT+mhFstlXNKhdj3sLimG0PpF/UUBFoVQOGMXdaRHiisRPiQeAWARwy
         2pM4vDR8QI6TYeXVIvsPo8WwCC53oTrzog0/WXJd//r7TweltKZa2BtuyDmbbBDBva+X
         1IAAcYukl16TUe3Wz2HDdV8qoH4jwA86w5boUA3iK/CK0/wY++/zEMfnHmfI2SzPP/+X
         3ASF0enJ6YivRGpIxEB4ZghhvvFqoUnh3CzgrPHxPcAF3pTESLOBpqbV6r2Nz3mSgrMI
         Da9CgWzJClFwR23hMZVjblOX8Al9ZWR+6OmzkZ0nwp3TKuNwtehCd23cpmHMjn2/ljP6
         zcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565350; x=1729170150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DiEWt7hAhyZIjlst2WRz52IU6Lfsq/DckUi49+8mp8=;
        b=az8JHC4bM4D7TuBGH1/7G9XTtqE1CJzMLlKuz5i5mITBAu0GnzU3Ab3Q8OkMia8n6C
         vdAfszu00mKQ815pRbVLdsrOkM4Ge7VVGXFHtihtxQKsIfdKxkbvQLFdX/qxWFXjBTM9
         LNdZfU+kmNYlGZKPqcJ96LCNl31sAS+ckHTXPVfKiN6GLbajvfjSOeNPYUj0mDy43/Yy
         /FJ/Lb0y6TbzNqEqfHAK2iViLGWLaBZ9jjj3TdRrw9OjjclsX2XVT4pP220C7C+8HS55
         2TmSVXc3Uk1zoqZQXX8zUCN2V/VNu+to+EmLhZzJS7A1Us6cSJgecXCjJDjOwKJhSToz
         ZE4w==
X-Forwarded-Encrypted: i=1; AJvYcCU+gLZs8fbd6lmnE6HTw9MwDo5m3H0b8sDKFHdt9h+HryFy2UUZzupSElMmqvYuhlBwZ+8n73dqQdBn@vger.kernel.org, AJvYcCVufyEK9dWYdLMIfu1RSoumh1jWM5weEwADYhCAnKXNtEkJ/d5QEgsHhahmxetAJFjYJOguIhSPo/mKIm+Z@vger.kernel.org, AJvYcCXP3sl+9W0+aKg1pJKDqwdkEO/BomH1hSq7flKf8++7Ban1oyBg1AJXxZllad5sDEnwCwWH1bZIpmof@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaSkTAIlq46AArKiwMQC+f32uloqz5iZXHCs5USBEE6WqNSu5
	L5DvTw8JrKsz37agD7Vue18F/84Sc/O/b8IGTfsy1ySBdBZwaD18
X-Google-Smtp-Source: AGHT+IF6RO41Rjx/vUobowbOd+q5scv4tWrSd4h8e52DT+yh1za2AXX5MpDhjrkqKjLJtKkyRynMCw==
X-Received: by 2002:a05:600c:1911:b0:426:5b17:8458 with SMTP id 5b1f17b1804b1-43115abf3b6mr27344335e9.12.1728565349621;
        Thu, 10 Oct 2024 06:02:29 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm15935925e9.12.2024.10.10.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:02:29 -0700 (PDT)
Message-ID: <6570aa7415aa0ad212259e0007928ad2c6bcfe1d.camel@gmail.com>
Subject: Re: [PATCH v5 05/10] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dletchner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 10 Oct 2024 15:06:44 +0200
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-5-3d410944a63d@baylibre.com>
References: 
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-5-3d410944a63d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
>=20
> The follwoing calls are added:
>=20
> iio_backend_ddr_enable
> 	enable ddr bus transfer
> iio_backend_ddr_disable
> 	disable ddr bus transfer
> iio_backend_data_stream_enable
> 	enable data stream over bus interface
> iio_backend_data_stream_disable
> 	disable data stream over bus interface
> iio_backend_data_transfer_addr
> 	define the target register address where the DAC sample
> 	will be written.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

nit: On the commit message you could properly name functions like=20
iio_backend_ddr_enable() etc... If you need a v6, please have that in mind.
Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-backend.c | 78
> ++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 +++++++++
> =C2=A02 files changed, 95 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 20b3b5212da7..81f3d24f0c50 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,84 @@ static int __devm_iio_backend_get(struct device *dev=
,
> struct iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
> + * @back: Backend device
> + *
> + * Enable DDR, data is generated by the IP at each front (raising and
> falling)
> + * of the bus clock signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mo=
de
> + * @back: Backend device
> + *
> + * Disable DDR, setting into SDR mode (Single Data Rate).
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_data_stream_enable - Enable data stream
> + * @back: Backend device
> + *
> + * Enable data stream over the bus interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_stream_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, data_stream_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_stream_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_data_stream_disable - Disable data stream
> + * @back: Backend device
> + *
> + * Disable data stream over the bus interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_stream_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, data_stream_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_stream_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_data_transfer_addr - Set data address.
> + * @back: Backend device
> + * @address: Data register address
> + *
> + * Some devices may need to inform the backend about an address
> + * where to read or write the data.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address=
)
> +{
> +	return iio_backend_op_call(back, data_transfer_addr, address);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, IIO_BACKEND);
> +
> =C2=A0static struct iio_backend *__devm_iio_backend_fwnode_get(struct dev=
ice *dev,
> const char *name,
> =C2=A0							 struct fwnode_handle
> *fwnode)
> =C2=A0{
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 37d56914d485..10be00f3b120 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -14,12 +14,14 @@ struct iio_dev;
> =C2=A0enum iio_backend_data_type {
> =C2=A0	IIO_BACKEND_TWOS_COMPLEMENT,
> =C2=A0	IIO_BACKEND_OFFSET_BINARY,
> +	IIO_BACKEND_DATA_UNSIGNED,
> =C2=A0	IIO_BACKEND_DATA_TYPE_MAX
> =C2=A0};
> =C2=A0
> =C2=A0enum iio_backend_data_source {
> =C2=A0	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
> =C2=A0	IIO_BACKEND_EXTERNAL,
> +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
> =C2=A0	IIO_BACKEND_DATA_SOURCE_MAX
> =C2=A0};
> =C2=A0
> @@ -89,6 +91,11 @@ enum iio_backend_sample_trigger {
> =C2=A0 * @read_raw: Read a channel attribute from a backend device
> =C2=A0 * @debugfs_print_chan_status: Print channel status into a buffer.
> =C2=A0 * @debugfs_reg_access: Read or write register value of backend.
> + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> + * @data_stream_enable: Enable data stream.
> + * @data_stream_disable: Disable data stream.
> + * @data_transfer_addr: Set data address.
> =C2=A0 **/
> =C2=A0struct iio_backend_ops {
> =C2=A0	int (*enable)(struct iio_backend *back);
> @@ -129,6 +136,11 @@ struct iio_backend_ops {
> =C2=A0					 size_t len);
> =C2=A0	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int r=
eg,
> =C2=A0				=C2=A0 unsigned int writeval, unsigned int
> *readval);
> +	int (*ddr_enable)(struct iio_backend *back);
> +	int (*ddr_disable)(struct iio_backend *back);
> +	int (*data_stream_enable)(struct iio_backend *back);
> +	int (*data_stream_disable)(struct iio_backend *back);
> +	int (*data_transfer_addr)(struct iio_backend *back, u32 address);
> =C2=A0};
> =C2=A0
> =C2=A0/**
> @@ -164,6 +176,11 @@ int iio_backend_data_sample_trigger(struct iio_backe=
nd
> *back,
> =C2=A0int devm_iio_backend_request_buffer(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_backend *back,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev);
> +int iio_backend_ddr_enable(struct iio_backend *back);
> +int iio_backend_ddr_disable(struct iio_backend *back);
> +int iio_backend_data_stream_enable(struct iio_backend *back);
> +int iio_backend_data_stream_disable(struct iio_backend *back);
> +int iio_backend_data_transfer_addr(struct iio_backend *back, u32 address=
);
> =C2=A0ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr=
_t
> private,
> =C2=A0				 const struct iio_chan_spec *chan,
> =C2=A0				 const char *buf, size_t len);
>=20


