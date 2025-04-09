Return-Path: <linux-iio+bounces-17852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1084A81E57
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A117CA1B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C825A2B7;
	Wed,  9 Apr 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE42Zmel"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1032125B9;
	Wed,  9 Apr 2025 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183914; cv=none; b=dO9jBCe39dPDvNznNv49tcr8f1GuQIn7phsscHchN5t1fcnWE/+NxRGOw4KhnpGe2ugeDGa+kZJmZrjIGe+DXDhoDqgy6X8XD0Q0E3j/q+wJUERf/x7T+18AXsH74UBydiesPH+4+ayQBByraEb5LgNt2ZhHwaKKmimT/k0CyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183914; c=relaxed/simple;
	bh=0reF5eVkTPs+VQ+XzqgvxURmmJIR5Kufrz5v6wcSEdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWv7sU71QMHVWEQLOKMEl44BKY7hMECXp+4ZOlSur11xjarGMuPuuFezI1UZB7jv//ZgSM6LdLWej7mZ7TcI2ZqjcRIvYFgEs5H3sFlF7prKDE8ERjfuogm4/6SdzG0FH0vV59UAjmSF2FS3b+2BOb2jfUgeF9QVvUOXG9Bp+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE42Zmel; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso36386545e9.3;
        Wed, 09 Apr 2025 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744183911; x=1744788711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxkrmrDnX1oVlK+vG9j1Gh2jAbjCk8teFF7Lnah4O98=;
        b=gE42Zmel2zjYuzaqA7Z6PgJfS2EFd8v2qsK0JnoeRhywZKpSpbMNTZHptcJTl6x69j
         AS21VWActTSGpZxdXb88oYk+jvsR7eA/mB/a9qZMNPcaYw0IqbeOpITY0X1uuwe6ZCoa
         ZzG00oVaXizfYbsa/LPQ08gQaGHEQmCoSkmpzNAX4Ckj17OdGwn3iVSdPiVLybDKqM74
         /uv6CfCjQsu0AVKuezx8a1CWM2KWUN5U8mvCF7A7n4D1prJK4x/RFcp87cYONhp4wIME
         1FpLdBf02vl2r//x9g/VmAbETftOTJ+b+AOfWM3omH727Qji5hZM9H9CPaPub9QNsEDq
         DZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183911; x=1744788711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxkrmrDnX1oVlK+vG9j1Gh2jAbjCk8teFF7Lnah4O98=;
        b=gf6ir4hh0WOdY24JSj1RQGgf5ftj1xopZ72EsVfgNKONN2u4gAnkxmvoZu5PHCbVSZ
         oMKLHiEHPDY0R4ZNIvnsTy07OLRF96NIr3zAW4iVKjuPICTrXO87govkgc9Zju4/rHdL
         Dplp0jvMjkkqeyWiKlHywsIE9qgL422Z32KXzET89oIkLfD7wWTxqfyhTut5W86GBbHd
         Udj3vPeqbzh+ZTjfAmjQ7ViUqZktSbONUqbRhRDufsQ7EbQbvvmiuA3IFY2RC8XUWZoX
         e+Gqh0ST0VtDvHjlTBYwgJbu5nFr9Zyc1uf7+eZBWKBoEBAk3RjDEXvFTu4NL8xCYKWT
         zWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk/8pRuAUSE7O6tqkD4RSNa/t+hAa4Mkq8OfcJsmEBQwiJl8+ZCNe8C6PSCSoIyd/DQK5uBGuMFeE=@vger.kernel.org, AJvYcCXybI6qO/1eWBFrdfxQAynXvVvOROPJxyF8b5xu86PEjcBtHRSF8YByhjDsbRxUkW2LomxginMd5VHjb00R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1M11eX0m6vnMqptXdUw8gObh119yTiQtY7R7Nu42xp9qWPVeh
	oSUTw5T9bHp5dlzQDtgPEUs6x5AcFoTwtODMlk/Zuur0fWceUJ7y
X-Gm-Gg: ASbGnctt+2v4GoZ0JMxLEewkX+pgim3Lr6OHod+WaLgAUYkez7g31F8x5ORo7GTNiy+
	ElvwPWqKICoe4wm1kHOyHzdj+mV6zBXBd26nCNHf1ySFkhOSJekDuAoFG3c+e0jU1GBaLDCNl8g
	Il0SwojWNOlOMVNtvBs8ToiaQ1HwChVW8AEZ+cUzo0sDLLLgJIGccYO2HzrBULIs7KAmJTl4BZu
	ezPUV/rJSDOLMl1C8z1k4KsojBt6xI1XDFBBbp172uANq/1yOfCQLa9ZZUzfcs4NWxveM52tLwF
	bzSBF+VDf2GC4qNgATQZlp/g6F8ILm5exuN+AdsOeIX6taq/A7YT8YKCc6ArKUrWym/H4JiQmEl
	RCg/qYby23f8TYIs=
X-Google-Smtp-Source: AGHT+IE+RJVpqMf15Nm4Oq0HJr4Jofxhvw22oqRlpuJ57WBFl4u2dFpbeuHGNH1NyfH4T/4RMBanbA==
X-Received: by 2002:a05:600c:548a:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-43f1eca8070mr14482225e9.13.1744183910715;
        Wed, 09 Apr 2025 00:31:50 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm7193965e9.3.2025.04.09.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:31:50 -0700 (PDT)
Message-ID: <0900650872a1533a344df375e99ce116046b3ee0.camel@gmail.com>
Subject: Re: [PATCH v4 5/5] iio: dac: ad3552r-hs: add support for internal
 ramp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 09 Apr 2025 07:32:09 +0100
In-Reply-To: <20250408-wip-bl-ad3552r-fixes-v4-5-b33c0264bd78@baylibre.com>
References: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
	 <20250408-wip-bl-ad3552r-fixes-v4-5-b33c0264bd78@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-08 at 12:18 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Hi Angelo,

One issue that needs a respin and then a minor comment... With it,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 166 ++++++++++++++++++++++++++++++++=
+++++++++--
> =C2=A01 file changed, 160 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index
> 37397e188f225a8099745ec03f7c604da76960b1..9a8eed7a06e4f2e7b23d59764b8f2fc=
21e2c4537
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
> @@ -54,6 +55,18 @@ struct ad3552r_hs_state {
> =C2=A0	struct ad3552r_hs_platform_data *data;
> =C2=A0	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values=
. */
> =C2=A0	u32 config_d;
> +	/* Protects backend I/O operations from concurrent accesses. */
> +	struct mutex lock;
> +};
> +
> +enum ad3552r_sources {
> +	AD3552R_SRC_IIO_BUFFER,
> +	AD3552R_SRC_BACKEND_RAMP_GEN,
> +};
> +
> +static const char * const dbgfs_attr_source[] =3D {
> +	[AD3552R_SRC_IIO_BUFFER] =3D "iio-buffer",
> +	[AD3552R_SRC_BACKEND_RAMP_GEN] =3D "backend-ramp-generator",
> =C2=A0};

nit: I would use more generic strings. I assume "iio-buffer" is just the "n=
ormal"
data so use something like that. For the ramp, is it 16 bits? I would just =
use ex:
RAMP_16. I do not thing that the "backend" prefix (as well as "-generator")=
 to add
much.
> =C2=A0

...

> +
> +static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
> +						 char __user *userbuf,
> +						 size_t count, loff_t *ppos)
> +{
> +	ssize_t len =3D 0;
> +	char *buf;
> +	int i;
> +
> +	buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +

When are we freeing this memory? I also do not see the point for a PAGE_SIZ=
E
allocation for such a small string table. I would say to simplify things an=
d use a
local buffer with 64/128 bytes (should be more than enough). If you see thi=
s growing
in the future, you can also go with seq_file.

- Nuno S=C3=A1

> +	for (i =3D 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
> +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> +				 dbgfs_attr_source[i]);
> +	}
> +	buf[len - 1] =3D '\n';
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}
> +
> +static const struct file_operations ad3552r_hs_data_source_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.write =3D ad3552r_hs_write_data_source,
> +	.read =3D ad3552r_hs_show_data_source,
> +};
> +
> +static const struct file_operations ad3552r_hs_data_source_avail_fops =
=3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D ad3552r_hs_show_data_source_avail,
> +};
> +
> =C2=A0static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> =C2=A0{
> =C2=A0	u16 id;
> @@ -550,11 +678,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state =
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
> @@ -661,6 +785,26 @@ static const struct iio_info ad3552r_hs_info =3D {
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
> +	debugfs_create_file("data_source_available", 0600, d, st,
> +			=C2=A0=C2=A0=C2=A0 &ad3552r_hs_data_source_avail_fops);
> +}
> +
> =C2=A0static int ad3552r_hs_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct ad3552r_hs_state *st;
> @@ -705,7 +849,17 @@ static int ad3552r_hs_probe(struct platform_device *=
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
>=20


