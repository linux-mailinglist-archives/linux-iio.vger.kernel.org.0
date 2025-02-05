Return-Path: <linux-iio+bounces-15049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7CA299A2
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178E51886032
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7981684B0;
	Wed,  5 Feb 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="biB6qS/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D9944F
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782051; cv=none; b=vGPT20PWrutRlt7Z18HwaOzN0nuCqwjZWnxta1LvVOai8+hBCWtPpd2GSp3L4VcX0iN/URivoVO+e8HIZUB7U9c1Yz1jyYMmPeUJmMk495kjWxoVB7jQcbcQxPH90S8FIa0lesrAuZkztrHt6n7IQlmKS5KCbMISV7Txg6vtlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782051; c=relaxed/simple;
	bh=D9R14jc1oIBu2oIkEeAP7/1rFUGBDa4v/I9iujnZ8Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckLua+0rWScDNpkOuQMB17BKs6wYgVj37TQxfQn3/FOC8nkZn+jPqM5rwHZYF+Dde4Aq1O5yjAP8+6cJYyVBbp2LtZh08YKgTNQmWp3FAtnsxXIxoYnRlGgD54J+YHgEZTRh27i2iuJx0neKHsMT/wqIKWz3UhLMpsGNUKYDSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=biB6qS/y; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5188b485988so13584e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 11:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738782049; x=1739386849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OqjKIQEhB7lTLUPHJbvdkfuC/SWAq3NqPa8sJU4wL8=;
        b=biB6qS/y4L3e1txstnK2YWD5D1GGYQpkBwtHu3+TZ0XIR9xUciK4d77gxVaD185uBZ
         CjYb75yPJ64N0KcgsEjv4ZdD15kFsJamFomY5ywel7iMkmTmT+eE2H0w/Gz7fg4HlFHm
         WKvDIQbHkxG7gkLRVa3lhOjVZX1qfE5s2KQBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782049; x=1739386849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OqjKIQEhB7lTLUPHJbvdkfuC/SWAq3NqPa8sJU4wL8=;
        b=pIO+hfvCFzhabvOFxAaS5dHfDdiMDurzOe7+wW4azBthEp7kWu4C6F8kUQoySGT10T
         UekiD/TI83/TnZA090malQ9SQWAbC4y8dIAo4IsaJUZXY8XAWKJGycIrKYK/dWUIwG4J
         XJT9BmfOZDBz33HDK8vATMooUWMxeV0S2IGenrsu836ZbSlVCdZVxX3sIlecQDBsJaKx
         c4XB36nNJJYSt/D9Uj5mKKPirj5hujsGToyYD+dO0kyDv5yivFt8U5ZgRLma2ACVy7cF
         0p6t1y47BBliyT1ZWE43RAfVjPOoPLFClc+f1kFVrR1CpO+TpaDrN5gH61FG5iA+ox/h
         owJA==
X-Gm-Message-State: AOJu0Yyo0kS/JCneFBvBx2CK+55zuwDQFFmpFffs43+3QWna2sPGhC4E
	CJk/8pwVnGuhuMZ1HfwTsbaOdBLe6Gsq/rTEhvQG31wI604DfTi25PSNOlPUlqWoLNZfqnB5Gjh
	sxseCk37qY7hd5+CfFq2ZyGbzpW/L+rg182HCvPnp8hq5JJBpI64h
X-Gm-Gg: ASbGncug9FEPQsUM3jvzThnpLKrX2hbGV8S26hQ6HptbcaMrv9tYPoYRHaoo4UOhUeQ
	juLpQ41/Fh9bNTNs8n6b6iLS2cdlfrHl38FEwO5BtqydYT538k18cjPW3Zz3jzzA9HBWmFGrNVG
	R3d+jA4g1Lk093kyCZovbS9XQ=
X-Google-Smtp-Source: AGHT+IGnr6NSSWjZ1AYRVw59p4S9m3Wde81faWfaYhf6Au9cVtiUGUSw8tIl/mo9VkVIAanSpKSfl1lZy+KvFIA9SGg=
X-Received: by 2002:a05:6122:8c6:b0:51d:e9de:3883 with SMTP id
 71dfb90a1353d-51f0c4e6203mr2453864e0c.8.1738782049236; Wed, 05 Feb 2025
 11:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204200250.636721-1-jic23@kernel.org> <20250204200250.636721-6-jic23@kernel.org>
In-Reply-To: <20250204200250.636721-6-jic23@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 5 Feb 2025 11:00:38 -0800
X-Gm-Features: AWEUYZlzqozI51b36Zn_1aCJWVhyA_T8uZvhfTG52YmB0vX_YkvXMd41x9i7dpM
Message-ID: <CAPUE2utqXhvZa0s2ZbsN665eiCJJ-JhyAucLJUEgODFqnKaDpw@mail.gmail.com>
Subject: Re: [PATCH 05/27] iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 0d7f0518d4fb..b60707eba39d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -337,19 +337,26 @@ static int sx9310_read_raw(struct iio_dev *indio_de=
v,
>                            int *val2, long mask)
>  {
>         struct sx_common_data *data =3D iio_priv(indio_dev);
> +       int ret;
>
>         if (chan->type !=3D IIO_PROXIMITY)
>                 return -EINVAL;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx_common_read_proximity(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx_common_read_proximity(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_HARDWAREGAIN:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx9310_read_gain(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx9310_read_gain(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 return sx9310_read_samp_freq(data, val, val2);
>         default:
> --
> 2.48.1
>

