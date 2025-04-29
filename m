Return-Path: <linux-iio+bounces-18818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A2AA05BC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01341B6282E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87C29345D;
	Tue, 29 Apr 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6zAqIq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B942820B2;
	Tue, 29 Apr 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915296; cv=none; b=hfGCZnyfNGQoUOQQzMULbYTYwA9wuRVGrsm5DT+XzxT2BEPrvk3iBN873YexK3KmbSH1VCGFR/tdUINlUPvALg97TKw7AD8BUf+U+79VA2Oq5Oj+BMnkwZdPsgyyaXijkBvPriQv7UJ5yIHIFs1K0JJD/HqC2zDi3iWHPu3mVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915296; c=relaxed/simple;
	bh=oiIYGLVaryNmP4b9joXCtmwuK9gnLcmQ6q0Qn8TLP3I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBcuJpgwYaErxT3JeIpluESaZrsBbuKrZrWo70lMdyvOe2m4M8JX96ZgZc0DgCGBF0dx8csrkgupIucTGpSloc1kr76NDK7SmXNEq1DTnhpze+0PumRbBVDuIEdrE2fNCfNMtZ6N2WdohjIvy9+yOeT9LZGaPnQjMq77yA/oI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6zAqIq3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso55343195e9.1;
        Tue, 29 Apr 2025 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745915292; x=1746520092; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtzTNjtZDU60W2bs8OvIBOH9Kq7lrWqCDc5aRj+boNg=;
        b=Y6zAqIq3XW45Xnvo4l0HNyXmbMQAUX9YSNo1VyRPLxYI3dWmMl5ACTC+XcVjrceezE
         qGAnGlaSlaDgFdKSIEHWM5OrrcIQejjXcNVN3jjbRjYLx3E9+fXBcW+dxCJQce6Zsb1t
         T4SenyaQVL5AD6IThD6KFTa0+a+rDOKrAsa/xB8lvZRIfV6jk9TG7Vce6zNbq3ve1gtA
         8wFTymZHEIbTA2q4uOdH7S7wMFEaGltZ/HynlkECuP2jsUb+BPR6Io2LQCaF2mu5X1hn
         Chk9Zf/eb77BnxRbBT79GGIpzUXfHkyzR8ESx2q2/810e9NeruVqDxLCfomfz8MROt2C
         v3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915292; x=1746520092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtzTNjtZDU60W2bs8OvIBOH9Kq7lrWqCDc5aRj+boNg=;
        b=GAKs3MUGQvZWjYYPp8I6W95pHYiStxjFg27i6GkmGle1YVCzMjN1TJXhdRtEZT4aAC
         sCLOg7z4IoQZASKpEjfOLBKWppNt0/ySFf7G7f5LcazYoedG4wIUMJTHSMfACZXVNqAd
         33vtCqzZklI+10cnW3ThLZlLY6RajYmFk793GT53t5zMrf8Yb5grqhKoeDLavYIwdz0E
         gEzobgnDX+g+vNuLwM82O5jzano8b25AhfFstNH6vggAgEuQ1Dp1iKhs9FkKtB8nnWu1
         S772v9/Ol/f7NoSWLgGkVNvgN000DtqSslJAPVy1XBRxYHPb+sJU7H23xO8kLG2XkzCu
         VTVA==
X-Forwarded-Encrypted: i=1; AJvYcCVcJvlz9Muc0cnKxKM0NeaXwVXD3NHQZhyEcv5p7q+HmM/+VlMXiWXIos3wA7+i4hfWvnlRbX95pk994vWO@vger.kernel.org, AJvYcCVo7CixBKFCnaH7J91niif5/+JnaX1MHvso7O7/QUw7XtqzVTvPmJJbi2DEXntnOzKqJdjYOVkOZ6kD@vger.kernel.org, AJvYcCXfyMcKxs/Hip8hvcX5aojaOxC8RgkxZ52iwMCVguFkYGU35m6p4+DhEcRCD9FKpS56fiMWlYBfKbYo@vger.kernel.org
X-Gm-Message-State: AOJu0YyphLaMPqlK+mZ0ar3R0YjeEquT9Qk/xYBn9B6JkpT6WjjHc/DC
	QggrIrlzPXDejsS2Q1BTfwQrYV1rIkeHrzPaY+fvthHpyhu/dTMg
X-Gm-Gg: ASbGncv0RX7E6xQVI/t2klvmLzuoin1QDE9TNBNoZg4b3uCqoQzhjdRZU6d1aDr81cX
	4SoioevUgK6M9vJ0H5oN9+HveCd9uI8acXibsixsPlJoxisrxmFD+9RCCObjaaj3hm2ZYGM9YM9
	RJyX/4SZcNxHQNapVOCaA4H34kz1RsOk1E82XpRgz0IxJUyXDLFTGfyouCKwivOXdZ5hK1lYwMs
	wTRjbLSaWDO+bOFwCSWjuF87f2U+z1IbZk1Vn/wGnpD5MASJNE4NKskQtz5jUpbOCzEHQbqjMu2
	4qepwzxvp47tEXKoyQBbb1GSb3xOgpS+bnqTio1T/+xe1pbVmFnXAajYe5YTNBixXTP18FKd9ZF
	V/uhuARYOJys2
X-Google-Smtp-Source: AGHT+IFSiljljE4c8dR0p1cx0UndJBY3bORBaaTbd/RHYBruq2cfSoOwtTBcNNXaxkEMB5yzBGIHqQ==
X-Received: by 2002:a05:600c:138c:b0:43d:23fe:e8a6 with SMTP id 5b1f17b1804b1-440ab76a962mr99923835e9.5.1745915292364;
        Tue, 29 Apr 2025 01:28:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a13bdsm180114875e9.9.2025.04.29.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:28:12 -0700 (PDT)
Message-ID: <6db027ae67a46cfff906932e5d306fa0d9edf766.camel@gmail.com>
Subject: Re: [PATCH v3 07/11] iio: adc: adi-axi-adc: add sync enable/disable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:28:16 +0100
In-Reply-To: <20250425112538.59792-8-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-8-antoniu.miclaus@analog.com>
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
> Add support for enabling/disabling the sync process used for data
> capture alignment.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Some comments from me... I'm also still not convinced this API can't be mer=
ged
with the sync get. More comments on the frontend driver patch.

> changes in v3:
> =C2=A0- update the function to match the new backend interface.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 2a3a6c3f5e59..9947be059f98 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -44,6 +44,7 @@
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define=C2=A0=C2=A0=C2=A0 AXI_AD408X_CTRL_SYNC_MSK		BIT(3)
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> @@ -416,6 +417,22 @@ static int axi_adc_ad408x_filter_type_set(struct
> iio_backend *back,
> =C2=A0				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
> =C2=A0}
> =C2=A0
> +static int axi_adc_sync_enable(struct iio_backend *back)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_AD408X_CTRL_SYNC_MSK);
> +}
> +
> +static int axi_adc_sync_disable(struct iio_backend *back)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +				 AXI_AD408X_CTRL_SYNC_MSK);
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -559,6 +576,8 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0	.request_buffer =3D axi_adc_request_buffer,
> =C2=A0	.free_buffer =3D axi_adc_free_buffer,
> =C2=A0	.data_sample_trigger =3D axi_adc_data_sample_trigger,
> +	.data_alignment_enable =3D axi_adc_sync_enable,
> +	.data_alignment_disable =3D axi_adc_sync_disable,

Same comment as for the number of lanes op...
> =C2=A0	.iodelay_set =3D axi_adc_iodelays_set,
> =C2=A0	.test_pattern_set =3D axi_adc_test_pattern_set,
> =C2=A0	.chan_status =3D axi_adc_chan_status,
> @@ -605,6 +624,8 @@ static const struct iio_backend_ops adi_ad408x_ops =
=3D {
> =C2=A0	.free_buffer =3D axi_adc_free_buffer,
> =C2=A0	.data_sample_trigger =3D axi_adc_data_sample_trigger,
> =C2=A0	.filter_type_set =3D axi_adc_ad408x_filter_type_set,
> +	.data_alignment_enable =3D axi_adc_sync_enable,
> +	.data_alignment_disable =3D axi_adc_sync_disable,

Are we using the disable op at all?

> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};

