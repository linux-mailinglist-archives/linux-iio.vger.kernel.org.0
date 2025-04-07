Return-Path: <linux-iio+bounces-17770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77873A7E6B8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA5B42312C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64ED20896C;
	Mon,  7 Apr 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHjEGKap"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5ED20550F;
	Mon,  7 Apr 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042907; cv=none; b=JKD7vgobj5RnSQECsFdiGqLUZPJscXbN/g9jv119zRGeOqoF25oAGT7duy/oe7MzArHCD2ZQZWJLz3BjI9svYtRvlgW2emoDvYMNOmYPmXj923CSVt2LG5l6TXKzo8CtL1kMftplANDlKvWv38HSBNFtzZxJqYhoHKWH/6lQtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042907; c=relaxed/simple;
	bh=5yWUpnVtLO2ae7RhruYIfQZxJ3K0iMlULlAfW9t1Q40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXPWjTiuJcwoyohshXCzGlDG5s2I95TwAFMeiiOl4RXlCqZmOOJD7gQWqlMdVwBD+fqq9IB0rIyzEnnGgDxLPs7v5Rj6ZlrVqwGQUMzyxZfiV/sH0HWfxCVJ0/2yV/10vyCN5ZEZO6P6q4d6HKTFZ21WcvX7btsynphreEf5OVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHjEGKap; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3735562f8f.2;
        Mon, 07 Apr 2025 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744042904; x=1744647704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3GH2lIOkxW1VJ2UhaZgk0ThWX6loYjO81HIE73RIVo=;
        b=YHjEGKapOS+wlCV+F3sBCNFzu4glKXrnFps+V4XdZGxUGZzamGaT0y8neJW/d2y/bz
         UoyYjsNZQeX9TDSFt94IZKkjiKJ4BKYrZb9Hu277z1M/oAQbgojKWi5qyhXHw+A7EvvD
         y74lVf0NbnCt4Ag98McIIf+2ukcm4onGpCICWowr9G/8HJwxC5xMQLDE+olaHrnRzttQ
         bNmlmEQIbt4JNNdvYPuYvLrV3sbF1bUGnJANdJz/G0hLoxSs4lFJPA3ZzUgl4BA0ph3a
         7uS9RpHyuzKFD4r2K2d/GFoem0LE7GJV01EuaTqMTYR9QqoXGSi+FvqZ9ym9A3Qe+1p4
         O89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042904; x=1744647704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3GH2lIOkxW1VJ2UhaZgk0ThWX6loYjO81HIE73RIVo=;
        b=q4RQeSqge6GX1rt+W9EMaP3QQ0NmenaIG/6w1ACIKV0MDO7WyvhYI5Z3asUg2DQu77
         /n2JEWk23iXQrEe0n7fFo8o5ehEPhsqunQS2AGcR3aCAG+AwK/HECvzcPEnoEnV1+ioL
         Hhaar8uR2cPkjR7M313qUQdvV4vqFBnuLEMNHfOjBFhsWD5hQJXewxCKt0sGfIfpmP6Q
         YuM2ej2VKGEbV958eO4kKeeRN8twsqFy3dhzdxg9OCXNRUYz4Wuxo3TP0xk8j2vLDpye
         NpAcKdepQ4leFrzmjD9xYtTzsGZwKo5X+vSAJeF8BGbdpd8xVFgri+A9qSMEF4BMq9lN
         SFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUA5kc7tBq+iJO5UY5SqvC2sBSES23Z1SaEuonUG2h5Sjz4nyAlKR1iLtxwXjeU7ufwWyLZInpIYKw=@vger.kernel.org, AJvYcCUitKHjnvR2JmGNYVcYFa7FKnwdHb0zWtqT63Md4ChQV5NELvbsprene9beWdWdvtfI3+biNCBxP40UfB3r@vger.kernel.org
X-Gm-Message-State: AOJu0YzCz9duu+Zb3ZoopC/E0Ac9fEzxVy5+fCwy9b7C+wKfNDYdvMkz
	iho5CtvDXQ/3Yc8sll7IfTxw5b3KdgIYCpecvIBGJB42b5xdeAxW
X-Gm-Gg: ASbGnctaId/Kv4+mGcPAwYjeR1sRK2yWVA0G6pLmnahEiDoT/zBwfMNlASOEh6Zt9et
	8wdO75IdV4W6dsl+CBvelZrJjSRssF5UeQXhJYpBZBnOrvDhNO8pjcIpXGAtZBLQuXhGVKgyjLu
	AyF2c7fp/tBRBfaHoreI8nhDv9CNbStVG1L0ThIwwi5jVEJuAzT+b428MahqEhrq/Dky5CZbJMq
	S8dto/B3cQ+meoceyAOd/9yOudBpEh21AoSafMM1nEPF69YJfan6DD9peyp1/zatl7PABOfi0bT
	UXoTpvcPFCz67pxQ8soRkarFtLfouglJprA7C30ggRcIs+2MQ7bD3wV6W2sPq3Onqof3SSolRJo
	cxlV88EXp6AveHCIA
X-Google-Smtp-Source: AGHT+IGCrbVf8fDqR4AEUFrC71bn3PpEn06k1QNCIEJcgIOecAxDuAdBpNZ7WAoYncqCG65qwi+rPQ==
X-Received: by 2002:a05:6000:2484:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-39d0873fd0emr10993400f8f.5.1744042903622;
        Mon, 07 Apr 2025 09:21:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm6231487f8f.14.2025.04.07.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:21:43 -0700 (PDT)
Message-ID: <b0f136eb616876018f2a952ee60d7376258e66fd.camel@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: dac: ad3552r-hs: add support for internal
 ramp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen	 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier
 Moysan	 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2025 17:21:43 +0100
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-5-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
	 <20250407-wip-bl-ad3552r-fixes-v3-5-61874065b60f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 10:52 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 124 ++++++++++++++++++++++++++++++++=
++++++++--
> -
> =C2=A01 file changed, 118 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index
> 37397e188f225a8099745ec03f7c604da76960b1..3dcbda23c732f5f5e655bde31c5dab4=
96055
> 4bfc 100644
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
> @@ -54,8 +55,13 @@ struct ad3552r_hs_state {
> =C2=A0	struct ad3552r_hs_platform_data *data;
> =C2=A0	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values=
.
> */
> =C2=A0	u32 config_d;
> +	/* Protects backend I/O operations from concurrent accesses. */
> +	struct mutex lock;
> =C2=A0};
> =C2=A0
> +static const char dbgfs_src_iio_buffer[] =3D "iio-buffer";
> +static const char dbgfs_src_backend_ramp_gen[] =3D "backend-ramp-generat=
or";
> +

Why not having both strings in one array? See below...

> =C2=A0static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg=
, u32
> *val,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t xfer_size)
> =C2=A0{
> @@ -65,6 +71,18 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state=
 *st,
> u32 reg, u32 *val,
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

Do we have some number of channels variable in some chip info? If so, I wou=
ld
loop over that. If not, disregard the comment...

> +}
> +
> =C2=A0static int ad3552r_hs_update_reg_bits(struct ad3552r_hs_state *st, =
u32 reg,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mask, u32 val, size_t xfer_s=
ize)
> =C2=A0{
> @@ -483,6 +501,76 @@ static int ad3552r_hs_reg_access(struct iio_dev
> *indio_dev, unsigned int reg,
> =C2=A0	return st->data->bus_reg_write(st->back, reg, writeval, 1);
> =C2=A0}
> =C2=A0
> +static ssize_t ad3552r_hs_show_data_source(struct file *f, char __user
> *userbuf,
> +					=C2=A0=C2=A0 size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st =3D file_inode(f)->i_private;
> +	enum iio_backend_data_source type;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D iio_backend_data_source_get(st->back, 0, &type);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +			dbgfs_src_backend_ramp_gen,
> +			strlen(dbgfs_src_backend_ramp_gen));
> +	case IIO_BACKEND_EXTERNAL:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +			dbgfs_src_iio_buffer, strlen(dbgfs_src_iio_buffer));

Even with only one array, you could easily handle things here...

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
> +	int ret, len;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> +	if (ret < 0)
> +		return ret;
> +
> +	len =3D strlen(dbgfs_src_iio_buffer);
> +	if (count =3D=3D len && !strncmp(buf, dbgfs_src_iio_buffer, len)) {
> +		ret =3D ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> +		if (ret)
> +			return ret;
> +		goto exit_ok;
> +	}
> +
> +	len =3D strlen(dbgfs_src_backend_ramp_gen);
> +	if (count =3D=3D len && !strncmp(buf, dbgfs_src_backend_ramp_gen, len))=
 {
> +		ret =3D ad3552r_hs_set_data_source(st,
> +			IIO_BACKEND_INTERNAL_RAMP_16BIT);
> +		if (ret)
> +			return ret;
> +		goto exit_ok;
> +	}

But here is where it makes more sense... I would use match_string() and the=
n get
the match index and translate that into the backend signal type.

Plus, I still think you could provide a 'data_source_available' attribute t=
o
make the user interface more friendly.

- Nuno S=C3=A1
> +
> +	return -EINVAL;
> +
> +exit_ok:
> +	return count;
> +}
> +
> +static const struct file_operations ad3552r_hs_data_source_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.write =3D ad3552r_hs_write_data_source,
> +	.read =3D ad3552r_hs_show_data_source,
> +};
> +
> =C2=A0static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> =C2=A0{
> =C2=A0	u16 id;
> @@ -550,11 +638,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state =
*st)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	ret =3D ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -661,6 +745,24 @@ static const struct iio_info ad3552r_hs_info =3D {
> =C2=A0	.debugfs_reg_access =3D &ad3552r_hs_reg_access,
> =C2=A0};
> =C2=A0
> +static void ad3552r_hs_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return;
> +
> +	d =3D iio_get_debugfs_dentry(indio_dev);
> +	if (!d) {
> +		dev_warn(st->dev, "can't set debugfs in driver dir\n");
> +		return;
> +	}
> +
> +	debugfs_create_file("data_source", 0600, d, st,
> +			=C2=A0=C2=A0=C2=A0 &ad3552r_hs_data_source_fops);
> +}
> +
> =C2=A0static int ad3552r_hs_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct ad3552r_hs_state *st;
> @@ -705,7 +807,17 @@ static int ad3552r_hs_probe(struct platform_device *=
pdev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return devm_iio_device_register(&pdev->dev, indio_dev);
> +	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_mutex_init(&pdev->dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ad3552r_hs_debugfs_init(indio_dev);
> +
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct of_device_id ad3552r_hs_of_id[] =3D {

