Return-Path: <linux-iio+bounces-17305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58ABA74558
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB6618934F9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5897E212F8F;
	Fri, 28 Mar 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Pbx9+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C82F30;
	Fri, 28 Mar 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150469; cv=none; b=DoqtmyQ8oCHVY2cP9PmtuGtCB/AhSD08x7gLJ/yC5/mks+jrqADOLOoTnan3b+AUWp8OpMKZUvg88ECKyHU3CKMzUpIoVTTP587W3aJlFRDS2/VPvywEG8dlQakYAU0E7162+DtWU2b/J1MQfsLUJa0DInFCrPz0hhSF3fST7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150469; c=relaxed/simple;
	bh=MeqFKTDWc/WL7uBPpHngacKWnyXmWBq7/b+vlvItLbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hE8xW42pDePAhwYs6+MQ4y+dNrXpUTyyFvgyK19OqQMZhn8vwhTVOZnKuUWzDim/uHwidjkoUldEAXgaoUedrnAfzKijb4S6gdnxkLoProB3j63r2QtDnCgVHkaRU/teATaZYlPqpfAxp8erovIlnVeNB+SQFvClM6GLUT/SOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7Pbx9+C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so17695885e9.3;
        Fri, 28 Mar 2025 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743150465; x=1743755265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naBmh3HaepkrHLp1/SsJArNAoWnuKUyKgxv8rl5w6mk=;
        b=I7Pbx9+C/rPKVYD1sgREw4Lu3E193WoWirTD3zhcbADNj9whHlLBLnGGmK5l4KX4vt
         v63Hu2iyDBjugSkdVaqWe4u90sW8dJ8w+6hj+plMTDqrXjpomvWMXs/pLKZUUIuDuS/a
         u/CGt1GqIbmcYWhprr64C+OeyHxhfL8nQ6ioXtAAqfwnIBGamAHIieI3sDHxkJZu93XD
         UBgMwgtBFkZaAc+SJ9QSFqCkenzZOPcFnUent51vzO72eIHTert/e9/Zj/WkcXYUVLzs
         /C0XHhwQfOUfNDiiLfYG/ITXV3jRsmY4AiMNiigKGscvolvIDHfjjf6VbyxZTxPx0PAQ
         Od8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743150465; x=1743755265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naBmh3HaepkrHLp1/SsJArNAoWnuKUyKgxv8rl5w6mk=;
        b=uVptSEkWVqAxwxSOrMZr+aKk0z1RdNuGlnnpjd64jVheFDLQnqBU/KeaeTtFnlBisB
         is3hjkBqqyXluGqHtguyYEtJsVA0sqNXncqCXF2/A7PahBWVIcgMotJO8Qpp1adlM2Ia
         pisyLQ4iAEw80fbW17c7Nr1ywbi0c8qD+B7p3d54Wkhen5WkbcpedjkCWcR8ZCUwtkqH
         Me0blHO8bMsEuiuWqSXYG43tK94fcNCLzDmuOCll8GFQxSU6ZDpJIc/C+9WLFQhLFsBz
         LQ9RlWQ9cEebH1S2e52RRf8f5SFGYCuwWJwd8rH3XQ/7vjoCVYu7bVCSgjUJB0qxJeom
         w/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFReE9d3QCpObq1hTuLNVzkh+fJlsUNjYJhUN9PxlQIr2ZLU22Rmqqo7OrrGXwGjHfJ96+RLy62aw=@vger.kernel.org, AJvYcCWTjk5Pwpph2d/iC9VYxnYUgtoe14Gtt+JGForgJlmeJ9v69p56j6A92MsfnRfbPmLqWYO3Qxfa2mkO1S2a@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6odYAJuOyXrBWss9upGJngTHMsUDHPqIGHu+8tZhFKbmzoGOz
	ZsecLMnct/hGgYGHSYi1VnBtg4K3XLVbC4YzrNkvk6KlDqezucLa
X-Gm-Gg: ASbGncsR9+Lu5/MGTG6FvWJENWHIrxGExuZFXGDGPFSunC2lzYOwU9Q0Zwc1e+E5YkK
	mq2eEJISmP3Xq3ZJEdHLNXz1p7do6UAE/L+TRw7nbU9R3WYS6Vb3hYzUAkNy5yteLFPmH3sHHXp
	b65j4/fuL1Ly4lpa/lMd8VxYxwSH8V0Wy5mCi/PpT1wqU571Db2fLjC5UhSspHN2JIt0qPJmvpf
	WXXSUWKtLy0p7dNf1K5eUeTL+d1DZNG5CHO6Je/hyX1dgGSbfo3CySLDoomLtN1RQG+eHkeWoNW
	XHmvkOdxxklsYfut6u7qdTTKjZaESX/iel9sN58ao8jp20XVdwRzb+Hk8sb+D5+lx8dsSQn9X/o
	j7Tm+T7UTSiziELVuLb8=
X-Google-Smtp-Source: AGHT+IHcxC3yEgoJQj4Q4ffab2ZlS5GuWpCmVph5ZvbqPkoN9+Oj0PH3/kw5Ad+SQYjjFzd6BnQiPw==
X-Received: by 2002:a05:600c:444c:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43d84fb5488mr62208865e9.16.1743150465390;
        Fri, 28 Mar 2025 01:27:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba3e44sm20871755e9.4.2025.03.28.01.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:27:44 -0700 (PDT)
Message-ID: <2d12ff156996876e5bd85c793c07bb0c6747981c.camel@gmail.com>
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2025 08:28:01 +0000
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	 <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-21 at 21:28 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 106 ++++++++++++++++++++++++++++++++=
++++++++---
> =C2=A01 file changed, 100 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index
> 37397e188f225a8099745ec03f7c604da76960b1..41fe78d982a68980db059b095fc27b3=
7ea1a461b
> 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include <linux/iio/backend.h>
> @@ -65,6 +66,18 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state=
 *st, u32
> reg, u32 *val,
> =C2=A0	return st->data->bus_reg_read(st->back, reg, val, xfer_size);
> =C2=A0}
> =C2=A0
> +static int ad3552r_hs_set_data_source(struct ad3552r_hs_state *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_data_source type)
> +{
> +	int ret;
> +
> +	ret =3D iio_backend_data_source_set(st->back, 0, type);
> +	if (ret)
> +		return ret;
> +
> +	return iio_backend_data_source_set(st->back, 1, type);
>=20

I know it's a debug thing but we could use some locking in the above...

> +}
> +
> =C2=A0static int ad3552r_hs_update_reg_bits(struct ad3552r_hs_state *st, =
u32 reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mask, u32 val, size_t xfer_s=
ize)
> =C2=A0{
> @@ -483,6 +496,66 @@ static int ad3552r_hs_reg_access(struct iio_dev *ind=
io_dev,
> unsigned int reg,
> =C2=A0	return st->data->bus_reg_write(st->back, reg, writeval, 1);
> =C2=A0}
> =C2=A0
> +static ssize_t ad3552r_hs_show_data_source(struct file *f, char __user *=
userbuf,
> +					=C2=A0=C2=A0 size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st =3D file_inode(f)->i_private;
> +	enum iio_backend_data_source type;
> +	int ret;
> +
> +	ret =3D iio_backend_data_source_get(st->back, 0, &type);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "backend-ramp-generator", 22);
> +	case IIO_BACKEND_EXTERNAL:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "iio-buffer", 10);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> +					=C2=A0=C2=A0=C2=A0 const char __user *userbuf,
> +					=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st =3D file_inode(f)->i_private;
> +	char buf[64];
> +	int ret;
> +
> +	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[count] =3D 0;
> +
> +	if (count =3D=3D 10 && !strncmp(buf, "iio-buffer", 10)) {
> +		ret =3D ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> +		if (ret)
> +			return ret;
> +	} else if (count =3D=3D 22 && !strncmp(buf, "backend-ramp-generator", 2=
2)) {
> +		ret =3D ad3552r_hs_set_data_source(st,
> +			IIO_BACKEND_INTERNAL_RAMP_16BIT);
> +		if (ret)
> +			return ret;
> +	} else {
> +		return -EINVAL;
> +	}

Are we expected to add more data types in the future? If not, this could be=
 simply an
enable/disable ramp generator thing... It would be much simpler.

Anyways, you could define a static array and use match_string()?

Lastly, for insterfaces like this, it's always helpful to have an _availabl=
e kind of
attribute.

- Nuno S=C3=A1



> =C2=A0
> =C2=A0static const struct of_device_id ad3552r_hs_of_id[] =3D {
>=20


