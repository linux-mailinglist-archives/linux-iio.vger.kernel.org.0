Return-Path: <linux-iio+bounces-18814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5BAA054D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0862917D049
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604527A931;
	Tue, 29 Apr 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0bPOM4x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257F25F7AB;
	Tue, 29 Apr 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914496; cv=none; b=AimPqsvPAk/jbSBj+pu7Ut9ooAZQmWEsITrgG1s5vVYczRolFXF4QG7Z93w0qAN6Snr7oFrI/WQS7LF/5q5jGCDe8UiZPZu7mvP4/6EFzfkA3sZQpEGPrO09TP1votvXEICirj0eUIpW5guajWJtd9nBL77w/BFoiPHtkzLq2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914496; c=relaxed/simple;
	bh=DfuiS9ywp+ZU4Ck3Hk6awbmMjHIGnG3GQm/4fFm6Gw0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBm56zW3HSjzQ4h2idRegspqSlVHjDZx9ycBKY96GrDU22kM347zaZzfwMTQtbSXyUIyfyCYcaVRHjttkS0cH831+9N75ZooLacqQ67Ou+M2IMK5ozeqwFu+pQWXfmqtiKID4HYN+Rx4POIlRWtv3PKqRYvWRI2A6/A9pvoilXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0bPOM4x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so37741855e9.1;
        Tue, 29 Apr 2025 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745914493; x=1746519293; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sndv3w7Q8kDv9+q7MF+dib355lQod7g3DGJrt36mzys=;
        b=M0bPOM4xRGb6h6sOYUeCGMOlJksRbau3zfn7NVCbod0VOtr13lfXyR+vUcfBC9Vw92
         cS3ThgHB2gdaTle3beGm7nKP703a6wzgdly0iN4MJWJQtqqXQ9PopTogQ0OD37V9qfax
         f6No0jA1/wdnGgVlUm7OIaev7yfnh/B2TkSud9ZCKSVznjJaMqMCXGhyjxZveUAW87Xa
         m9YevJV7UqUUbD+JPEbXdr1mdIytAPRodQUQFhAziPoABaQhT+Q4QSCmHl+1Hy5j5J9Y
         ffRM9zlx9bWBatMFKk4Uvzpo5Lta+21Xzq+jonvedgnjaDuQ7VZkME44AJ4UHgQEZPjf
         jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914493; x=1746519293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sndv3w7Q8kDv9+q7MF+dib355lQod7g3DGJrt36mzys=;
        b=d8iGaB8VPbFPJe0/E68dEZX8Er7h+R1NEJagi+KiLnvQk4Vz6NrZoNxlg6n2kSXkdM
         kYZOlvMAKaW8dtnnv5SI6tot2i6btwaWVXH3xOzq7SdQQ6WJKv5q2VEBBr7wypGSTNzI
         VPFxOv9F5uPCt5FyPMJ/x00KotTZji8tOZhRwln8BUWZakx+KVmHie+tZeCEDxE7O33I
         3VIjodCsbqywv5QossY1fOCH7GZQHgKFhxinLCd00sd9giEu7acwTYftsUQTSOLOPUqZ
         +qYAdDwGzC4mczrjLlYDOkWvHL2CQryoxFYdXFpzqzB458pcvaSTgIGutn7ncFaSDrTj
         w+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUa5/as7e2/gRvMEwDlzs36aVEVpU+u4iO6bqPLVIwQbXZXpo1AZo9vbAb7pJ0DwCz4EpwgXI8/bqv2@vger.kernel.org, AJvYcCUhgTK2GwGDHoKhSmUpdWTeOocMz37lCp3tlFpqJV07Uj+l7TqYcW6Q6VNVyaHi3axM8T7A4opTFMVF@vger.kernel.org, AJvYcCVX2G+zOZqAX2ZZzCDq6xVE5QCcQXZ7bw2EbpTqfx9L4oRwDqOAPVClHAepNfyVQcQXtwnSfGsV6yf2thC3@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJUd8QK6SM3n7jMgBlr+3KgslByvlBK/tghGcqDkhlzi0llDo
	ywKTFWxNjGyGgD+T01zPP0h6ctM2EQrA2KSHv2w+qZw+uOC+VjChEOeG9dOCPJ0=
X-Gm-Gg: ASbGncuOyEuuO1K3lX8SleNrFU8UFZDcJzqVTfLwxviQyTqPkUaqBUONUC821I8Qgr9
	6FBHwyvqWd9u6ZdPkL7InwRWr6dBZDZni4n1dA06SD9d9lql/BnfIu6Y85xLVee0eMICqSY17aa
	dyTQbCH6bDCirWd/cv29/SwDme1bb+UCByxb5DZKS5cHXth1XohGFFZSDtsYD7DANY6PLEGUKHa
	z2YWAQUHcT6lgFo2oF5OeeY6lw0nY7dEUaXmWuf/Ah9bI1bLs2242YkYk2tiVIfvbl1Ze/AKnVW
	hEtjWD3gComE+aK6zYdpV7XWIyOEA8A3/Gck7GqpFTfMeOpUjWP+9TWZ/s9yM17+Xoje1KqFgSg
	L4Jwsc3rP62sT
X-Google-Smtp-Source: AGHT+IGe/csrIqoHzRat1Mk0BnJwsWnqRjwYWgeJGxhqh7K08fEn/RPFJAlQAfOMl1xpWM90SO2eGQ==
X-Received: by 2002:a05:600c:19c7:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-441acaa8d45mr16042955e9.2.1745914492757;
        Tue, 29 Apr 2025 01:14:52 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53874a9sm148102335e9.34.2025.04.29.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:14:52 -0700 (PDT)
Message-ID: <23fbfcd79d2d8c924c84ea8a16ed28697bfd326b.camel@gmail.com>
Subject: Re: [PATCH v3 01/11] iio: backend: add support for filter config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:14:56 +0100
In-Reply-To: <20250425112538.59792-2-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 14:25 +0300, Antoniu Miclaus wrote:
> Add backend support for digital filter type selection.
>=20
> This setting can be adjusted within the IP cores interfacing devices.
>=20
> The IP core can be configured based on the state of the actual
> digital filter configuration of the part.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

This one LGTM:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v3:
> =C2=A0- update function to set the actual filter type instead of just
> enable/disable.
> =C2=A0drivers/iio/industrialio-backend.c | 15 +++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 13 +++++++++++++
> =C2=A02 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index d4ad36f54090..2d28eabb1607 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -778,6 +778,21 @@ static int __devm_iio_backend_get(struct device *dev=
,
> struct iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * iio_backend_filter_type_set - Set filter type
> + * @back: Backend device
> + * @type: Filter type.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_filter_type_set(struct iio_backend *back,
> +				enum iio_backend_filter_type type)
> +{
> +	return iio_backend_op_call(back, filter_type_set, type);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_filter_type_set, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate)=
 mode
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e45b7dfbec35..5526800f5d4a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -76,6 +76,14 @@ enum iio_backend_interface_type {
> =C2=A0	IIO_BACKEND_INTERFACE_MAX
> =C2=A0};
> =C2=A0
> +enum iio_backend_filter_type {
> +	IIO_BACKEND_FILTER_TYPE_DISABLED,
> +	IIO_BACKEND_FILTER_TYPE_SINC1,
> +	IIO_BACKEND_FILTER_TYPE_SINC5,
> +	IIO_BACKEND_FILTER_TYPE_SINC5_PLUS_COMP,
> +	IIO_BACKEND_FILTER_TYPE_MAX
> +};
> +
> =C2=A0/**
> =C2=A0 * struct iio_backend_ops - operations structure for an iio_backend
> =C2=A0 * @enable: Enable backend.
> @@ -100,6 +108,7 @@ enum iio_backend_interface_type {
> =C2=A0 * @read_raw: Read a channel attribute from a backend device
> =C2=A0 * @debugfs_print_chan_status: Print channel status into a buffer.
> =C2=A0 * @debugfs_reg_access: Read or write register value of backend.
> + * @filter_type_set: Set filter type.
> =C2=A0 * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> =C2=A0 * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> =C2=A0 * @data_stream_enable: Enable data stream.
> @@ -150,6 +159,8 @@ struct iio_backend_ops {
> =C2=A0					 size_t len);
> =C2=A0	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int r=
eg,
> =C2=A0				=C2=A0 unsigned int writeval, unsigned int
> *readval);
> +	int (*filter_type_set)(struct iio_backend *back,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_filter_type typ=
e);
> =C2=A0	int (*ddr_enable)(struct iio_backend *back);
> =C2=A0	int (*ddr_disable)(struct iio_backend *back);
> =C2=A0	int (*data_stream_enable)(struct iio_backend *back);
> @@ -190,6 +201,8 @@ int iio_backend_data_sample_trigger(struct iio_backen=
d
> *back,
> =C2=A0int devm_iio_backend_request_buffer(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_backend *back,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev);
> +int iio_backend_filter_type_set(struct iio_backend *back,
> +				enum iio_backend_filter_type type);
> =C2=A0int iio_backend_ddr_enable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_stream_enable(struct iio_backend *back);

