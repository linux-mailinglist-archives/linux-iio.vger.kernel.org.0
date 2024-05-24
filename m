Return-Path: <linux-iio+bounces-5265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B88CE494
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF261C21553
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2E85C62;
	Fri, 24 May 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwW5njxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEC85C70;
	Fri, 24 May 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548343; cv=none; b=rXnZ6a05nauj3GXMwwJewfnzRu/sNT1SvBm0bfS3dnYpkUDk45S6W82/iY8lmuF8ZjGzT0bGbi4njjJKBBA52xwMfkwA1rtedJbf71oqIlTvGVXk5SFHDgxPBixMl6uqJSy2wxhgDcfuZsaxsF3Cqo6basD/n5C7cwlkg3/JoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548343; c=relaxed/simple;
	bh=J+OjSK1r8M7K6af3iSJrN1bXkLNXevvkzXvY1+rKn44=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WftieyzxXQLLoF4s37DXDHIIYs62bplOhmmyD4pmOlyJPGHlazH2OQZmDocOnzpj05ZDtrXpcUnRrvhhnqVC7/8ENNkiGo9DUZQyaKVimk9V8K0ya1/qy2O2sE7SBmLFrMV1kEtHWhqHSALZ3gBcrUcGIx5RbZnVwu2LXBKd6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwW5njxb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351d309bbecso5967729f8f.2;
        Fri, 24 May 2024 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548340; x=1717153140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BcK+5vVRc+uTXtmmtAse4Gdl6CUHX96faDyJFsHx5Y=;
        b=iwW5njxb9G0w08CPMOC7pBUJ2MYgl3KEtTuY/uaNd+sYi37ScH8pxEr2A7l+ia2/nl
         c6KvbgH/2EGS30pl53jNC3Be/ZOWZNxwArPtEGfd4PBmRIcSAbfsnRmSqLlq1euLxeoe
         gLAk9LvM5i35kSslogv0sIL4i7bQoU8RaHXE4fbked0hZnVRXEActJt2Jhpl76KOuJeN
         wQlsaklpnJmPCkY+AW8i5G7wT5WjtJS1/2aEt7h73HkYMH2apDMVxWEwAGxELKK8axHa
         pNRBr4zOqZ/gcqklzbSAzqejOuoAvW8vwt6O/bYLMyYt8/SSgF1/NWKVO8rYkVYqalkK
         wDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548340; x=1717153140;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4BcK+5vVRc+uTXtmmtAse4Gdl6CUHX96faDyJFsHx5Y=;
        b=X8tl/sb7ncBAgk7BwtOiJG6HuoUO/ntANc/O5kyIQMeFwM4x624wBdghLDK9l4VZaY
         5WknAu9izvWehaFhC4WfzqOojJgVAsSsFeha8ioEstHyCGWyuI9QwCWe497SfvcTYKRg
         40i4ASMpU/wmV/lhaKG2BQhVzn/iJszP0I8vDKAAy8Yo2NXnrsQO48bYuolFnLnqNNKj
         /lXSpZPR5YRuCvZ4JZq2Dl0Gf8YxvE1kXxknMlbHZg2uDZCcwE48I9OQpP0iS3qa8lrP
         oU1J9O0TZuR2SimyDkyn9855wQhohSqyt23BhydG9AWSBOAgt/kw5PYbtQJhyLx7Ogor
         bdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZWEnt2EYY/WJ2Cda2Y5oBiiSc5QAEepYF8YefBhVYcs8AySuaiXTpc1SkjDmVNaQvFtOTmqhXiVDo70H7A2MzMJqrVioOcasvzjKQ+9cxcIhv+ygxWVVcYMdbYmcGq7wk8g1Ruzdux/YuQDLLE5d0QYTVA8jK6lyfe2ZzLqyXkN3a7Q==
X-Gm-Message-State: AOJu0YzinzypKnKztw7m42Z/dmqBA6LNlIj6AR0z07UsMlqNmvlrp4dS
	MoRl07gujD4Rb+cBO5MxLma2Aoq/EVR5nUbo968FFoRnv1xSXnH6
X-Google-Smtp-Source: AGHT+IHj0jFgqbaLdsCiMHWbnw0YXGszeakC6UjFWbrC1rNNZjUERwY4Ui23DPYYr4EYhatpcMZpZg==
X-Received: by 2002:a5d:5149:0:b0:34a:4227:e9e8 with SMTP id ffacd0b85a97d-3552fe02974mr1226314f8f.47.1716548339708;
        Fri, 24 May 2024 03:58:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae96bsm17475585e9.35.2024.05.24.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:58:59 -0700 (PDT)
Message-ID: <20d139d06895f29ba69e4ab8ed362acd4c352279.camel@gmail.com>
Subject: Re: [PATCH v4 05/10] iio: imu: adis16475: Create push single sample
 API
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:58:59 +0200
In-Reply-To: <20240524090030.336427-6-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-6-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Create push single sample API reposnsible for pushing a single
> sample into the buffer.
> This is a preparation patch for FIFO support where more than
> one sample has to be pushed in the trigger handler.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v4
> =C2=A0drivers/iio/imu/adis16475.c | 12 ++++++++++--
> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index f9455ecb348c..ab955efdad92 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1249,9 +1249,8 @@ static void adis16475_burst32_check(struct adis1647=
5 *st)
> =C2=A0	}
> =C2=A0}
>=20
> -static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +static int adis16475_push_single_sample(struct iio_poll_func *pf)
> =C2=A0{
> -	struct iio_poll_func *pf =3D p;
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	struct adis16475 *st =3D iio_priv(indio_dev);
> =C2=A0	struct adis *adis =3D &st->adis;
> @@ -1340,6 +1339,15 @@ static irqreturn_t adis16475_trigger_handler(int i=
rq, void
> *p)
> =C2=A0	 * array.
> =C2=A0	 */
> =C2=A0	adis16475_burst32_check(st);
> +	return ret;
> +}
> +
> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +
> +	adis16475_push_single_sample(pf);
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
>=20
> =C2=A0	return IRQ_HANDLED;
> --
> 2.34.1
>=20


