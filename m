Return-Path: <linux-iio+bounces-6546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4490E2A3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 07:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93341F24030
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 05:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9055887;
	Wed, 19 Jun 2024 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhukkK4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589A28EC;
	Wed, 19 Jun 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774734; cv=none; b=uOGuPNvnIWnWqdy1yh96wvj4kgdmuEmRbsifoC7rlhUT2awZO+C5r3EEqvHfjeorVT9e6O5Tor6V/YNYEtYQixBY/nLCOwG3PdvY8130L8O0GGncRBC+J9pKX3/wkM8GeYCKBt3ZxIfCw3Wzcr/X3SUhv6w6nQPC4aiddDkcdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774734; c=relaxed/simple;
	bh=AeIuahDzMS/b+fTT/ZxbWMZ9XXQ1v7mt3kt4KzWvtiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDmx0/duC78teIYaqeyia+L0okwKbv1h2O0VXEmeapmDYXxBDPoyQl44Jya6EVTjG3IiNeobat3rcVrrSfDM3gr+TLFgk545nBF+su3mtMKYASINRyjWngC/ApOh+q60+XwHcgMe3kPLHLISzLC5OjVgCHhY5tfHtFwUI7Wzxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhukkK4J; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso5571210e87.3;
        Tue, 18 Jun 2024 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718774731; x=1719379531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c1F6xnAHauvFOYcCq0J2XUnG69uZBs3ONBdp6Omh+cI=;
        b=FhukkK4J00GFjR3Lfvigll0oubuVNEskmNkvk0kWN8+6dlzkTgrDiHxCbMD/ZrL+px
         UJZkUxiSVLnyI+eNjx//MQJLimfIWN8HANoDes1bUGu+HkhL73St9z1BKxAKNjljxfHB
         Ha4Dp4lRmGt7jZCfrBH0U+0xeWmF35+EQ0ft9HGG7159ncR/hqOnJcj8AwX0wcPip9ut
         lBkhsgdKq5ameKK5eKFNYFG9J2NE6S9/6jWvFa5FywQCb4HIcJGRJIFdE5UFr78jWKhb
         J0OTkffBOZ+O7Iel7h75P+eYBGKeHyeF8/XBdxCnGUNdONdehtwdsElbnmpKFOBRe3Bo
         qWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718774731; x=1719379531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1F6xnAHauvFOYcCq0J2XUnG69uZBs3ONBdp6Omh+cI=;
        b=Kp3N3drjbjy25BjY+po17izRG/6HJVr9LSHS1jOU+xdgKOdUpRjDz7MA0vjyDwsz3l
         Rl8DoEjslD6pYdsJJHEbw1cyrsRkVGkwocBa+9mq/OQLAnBUWZs/f5BfRIaNhFtlRn+c
         u02w2wOpnOFC2gXQeTrJxiE6+aB4YIOqDsDYb84wmw4KNOXdVEVSLcJFz2u93mu0bru/
         mpTEKVAeghpDS9+qvR+lNYCTZVuB+m2+H8LWzGyfLjv1ra6bpApaukYa2LD4ARo7GmGc
         t3LsdUNaG5b2wgSb4AWcxXRNilz9fj14p8g4hfZsGYZPFrZU++o5A7IiT8Yc0jWRdYRo
         +BKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO7Z5Xnj4q3MswIN3eEGf5M9ZtOMFh8W+V4sRP7Z8gX734WjG4v6rB8mPerCfMbGdVkImFy9wOdxEEO1hA1mHDVxnqgh89NomMBFud
X-Gm-Message-State: AOJu0YyNYdNDRl0467MqR+uVK4PgybXoWJot6JlVYOXzQ1CmkamGZdpK
	77ZAugnsWpcWqJWJdirN5tlakSdfqWOTcpfWL/X2boEVYZjv6sMf
X-Google-Smtp-Source: AGHT+IG/DVGkXmAEqGDh5KUjebygMtvE1/mxLvCU5d9hK36jehlgvx2HL6PsTaAOe9mI8TQRqUaFRA==
X-Received: by 2002:ac2:5b12:0:b0:52b:c244:c27a with SMTP id 2adb3069b0e04-52ccaaa8605mr760156e87.58.1718774730724;
        Tue, 18 Jun 2024 22:25:30 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a6c1sm215198855e9.40.2024.06.18.22.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:25:30 -0700 (PDT)
Message-ID: <36729a039fb1c19cf0e6d5f85df4d774b40a8334.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: add read raw service to iio backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Jun 2024 07:25:30 +0200
In-Reply-To: <20240618160836.945242-2-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
> Add iio_backend_read_raw() service to support attributes read
> from an IIO backend.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Small note. With it:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 929aff4040ed..b950e30018ca 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -357,6 +357,22 @@ int devm_iio_backend_request_buffer(struct device *d=
ev,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
> =C2=A0
> +/**
> + * iio_backend_read_raw - Request a value from the backend.
> + * @back:	Backend device
> + * @val:	First element of the returned value
> + * @val2:	Second element of the returned value
> + * @mask:	Specify value to retrieve
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_read_raw(struct iio_backend *back, int *val, int *val2, =
long mask)
> +{
> +	return iio_backend_op_call(back, read_raw, val, val2, mask);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
> +

I would completely mimic the IIO API (only change being indio_dev -> back).=
 Meaning
that 'struct iio_chan_spec const *chan' is missing.

- Nuno S=C3=A1

