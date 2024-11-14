Return-Path: <linux-iio+bounces-12240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04F9C8651
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608A31F2190D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DC1E47A5;
	Thu, 14 Nov 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afhDuexG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29113A3EC;
	Thu, 14 Nov 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577126; cv=none; b=LGQP066vkRJ75kuXjCeoMbaKcmKUWxQjSEJc9voNkgTGsZviYqyoRzLulEacUI/KJTswjMbeqRjZ6/PA0WY5UT7PFRdBSn6+i2dSuKBinsKyYTK/pCuLDmK2sge66PbR9Mn7A71mYdhg4Onqeirx6gDr+sK5k2PqfMQrgEEkceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577126; c=relaxed/simple;
	bh=Jg3FgyWPaL71rabeud5D50eE/bWgrW2xQ6HVGMLckVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJnVoAi+jpJ890pk3fSh1lHJiun4sfPPA1Tgh0qSHhCSM1Y9mMwBAdL6t/rzhJ7FFzavDuCoj49qsKw6LxuqKnUJprlWpTIepgMx8XCD/SmtPcjzsH1sLVhnPnPzcZFWF+qnVYcnqUZhahYdnhT3xPDUNAcIeJRGa+KQkBuMOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afhDuexG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316cce103dso5032245e9.3;
        Thu, 14 Nov 2024 01:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577123; x=1732181923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d35KLNXomOAr9zumvGG9Etjnd7QKJLy1hGTr+u/JGjw=;
        b=afhDuexGyi0JEGc9h8f4zqdZiJHRGc2YueVZjh4jFde51nQp05QfHuqB5eZarrPV8L
         l4tjshzLLqZt/qelWoXSREfnnwO2BKvgMSlbVufN+V3rRpM5Y4/5CWMfh9307q4R+BA/
         M5LlPk3BWPwuBi6uYDTyOAqRUgREpQcTiNsJc2bJhx45W0GeD+emhhSLJTNI0TLqiJYs
         44GdhKeLnsf6GcDeKXGRGwSw1EsoovIGD48QbXhU5u+Js3wE+Afy8H0UeJk12YilrD6W
         Bc45uuPLk3s4At0H5GCvef+AFy6gDz1R5CbrwtXF0Q4VrnMV66gP/5OQ6pEx6c7hFlgD
         /fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577123; x=1732181923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d35KLNXomOAr9zumvGG9Etjnd7QKJLy1hGTr+u/JGjw=;
        b=iKlWxfMLCnjwDaBDmWiiO8dlJa+Y+qFBFmUoNECecw5NW9vT+wfFokTaKTXjZKABez
         tYgI31+xnn6kR0MgXLxw7JOPjfP8b3lFaiXzI6s/YvLg31bQVuiQc7ljPzf0SfX7yMcF
         o3yGOgZhB45ELiGE4Whoql7/7dI7WrdUZwgzQ1ezB9pyvM14GKyTcVb/pD1Sf2NBzNkT
         H9a+cf/I5Xl98xdKLLM24TxXtHWtBMfrtmpCii88ygyG6dPjU5C+HwreBFuVsYPIwARP
         XGVdiyNSa25kTOfoM/cGxMENsGwbjSr13LYSqAMIEAQ2D8GvgBTZiTuwo5yS013GrFhb
         BqVA==
X-Forwarded-Encrypted: i=1; AJvYcCW/n36ycRBplcCpP38ubh89pKSVkG/EAaowvCRs2thKlJfi8noUbz4QTdO1ezeHWdPLcg4KTKHemdg=@vger.kernel.org, AJvYcCWbRwHu2v/Z6kFHLv9yXlfd3r/Zv7Ynfx5CTzHMyiaCHcH61YkH+wV+HH1dt5fnHLkPXN2oAanK24GqUnYH@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3zH6LA45KxnxYkSIhALJ9i6fjUDB0PHNnnJfQwkyIL/p04ls
	bkyToUuPxKszYtalFDFq8HluywaCZtgpI5oUSuGYWQsrCnt17Wf7qFxVch1tGH5F+dLY
X-Google-Smtp-Source: AGHT+IEOFosBIQHfTQeeNEqGgyHag0IIyKVo2TGzp4lefpLaOPt0K0gfXhBh0atLZ9L2x01ng4qE0g==
X-Received: by 2002:a05:600c:444e:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-432da6d6676mr16658115e9.0.1731577122464;
        Thu, 14 Nov 2024 01:38:42 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298760sm17222605e9.37.2024.11.14.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:38:42 -0800 (PST)
Message-ID: <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
	 <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2024 10:43:05 +0100
In-Reply-To: <ZzWfXbjaDkFnu_Jg@mva-rohm>
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
> All the sensors supported by kx022a driver seemed to require some delay
> after software reset to be operational again. More or less a random
> msleep(1) was added to cause the driver to go to sleep so the sensor has
> time to become operational again.
>=20
> Now we have official docuumentation available:
> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Proce=
dure_E.pdf
> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Pro=
cedure_E.pdf
>=20
> stating the required time is 2 ms.
>=20
> Due to the nature of the current msleep implementation, the msleep(1) is
> likely to be sleeping more than 2ms already - but the value "1" is
> misleading in case someone needs to optimize the start time and change
> the msleep to a more accurate delay. Hence it is better for
> "documentation" purposes to use value which actually reflects the
> specified 2ms wait time.
>=20
> Change the value of delay after software reset to match the
> specifications and add links to the power-on procedure specifications.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Sorry for not including this to the KX134ACR-LBZ series I sent
> yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
> support when I was notified about the existence of the KX022ACR-Z
> start-up procedure specification... Hence this lone patch to code which
> I just sent a miscallaneous series for before.
>=20
> =C2=A0drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix=
-
> kx022a.c
> index 32387819995d..ccabe2e3b130 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_data *d=
ata)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/*
> -	 * I've seen I2C read failures if we poll too fast after the sensor
> -	 * reset. Slight delay gives I2C block the time to recover.
> +	 * According to the power-on procedure documents, there is (at least)
> +	 * 2ms delay required after the software reset. This should be same
> for
> +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-LBZ.
> +	 *
> +	 *
> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Proce=
dure_E.pdf
> +	 *
> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
> +	 *
> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Pro=
cedure_E.pdf
> =C2=A0	 */
> -	msleep(1);
> +	msleep(2);

msleep() is not advisable for something lower than 20ms. Maybe take the
opportunity and change it to fsleep()?

- Nuno S=C3=A1


