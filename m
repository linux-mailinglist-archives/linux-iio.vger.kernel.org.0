Return-Path: <linux-iio+bounces-15891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB3A3E581
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F33170A2C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187F26461E;
	Thu, 20 Feb 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBFLVz83"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FC20B1F1;
	Thu, 20 Feb 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081751; cv=none; b=m1LP1c+jo9jNuZcYoKyWjFlMMV+1uQ9aCBjK/qlkymja8AbHXFcceOMWPkUiF1R6E5qGE3x8RwdPTzweMKVgeg4UGFfbmP8K4Feq7AqOOxHTgLXAxNFCGPvwe9a5tnEXAJD+1N93tgV2x50GTnOTjLgVrzk1bVHT1ggtlMvs0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081751; c=relaxed/simple;
	bh=/ZP+jJ0lOXjz0kmCIpgDpmDWqvL3ev3Cr0Ir4efdUh8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=vDvkfjyl0AfIxZdwtpedmYi4zMUsYW2eN07nnmb9oxMrm1nKP5GsdAy476tCjdhkb/Ykutwx1gArQfBi0pCilUVe1mg4DQ0QNLcPiXk7GZnMvfCkIWDx4YYQOgMy7a0mAi+/Qz6Teaa26sb9zhT5PJ6xskiEea0F338TnuoZxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBFLVz83; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f3ac22948so731151f8f.0;
        Thu, 20 Feb 2025 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740081748; x=1740686548; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csgCb6u5Fodu0zC4/YRtvX7gHnFJEBoqe713JSwv3R8=;
        b=BBFLVz83yM87Yafogl/sTPFteXkXfB4o9ltHTiyJ5qF8GkHRrdmhg5Se4c1oWdN9KU
         MjoSYXz0vdHHfB0PWKcQcdGQ3PiYXiJgOXbG5oJ9uUMlBSabwa1pI9hj7+1h/8SiX9vm
         bxXu3dFB2j450+1zRRLw1v1iQB9s3ePrbIdL5Grw2gzOegGgA19KaTy7KRK3A34tePx3
         Oroe+qrKapnL6p8XC7DNQrE/YHkWdhsjCVhOS3kk0zldcY9MLAUGMjyHr2E7+s0ft1XT
         aRqE3/PjKktGXgEbyXdDzlR5bj57uQhNR2ztmoPTKh6qroCrrXW1p/QMSnRG0aTz3cUg
         OVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081748; x=1740686548;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=csgCb6u5Fodu0zC4/YRtvX7gHnFJEBoqe713JSwv3R8=;
        b=gkEnqxZpzT3AXtLcrB2bCW3PdOByCc/vR4sS4A9N44N00+nCmNruIqyF0l+J8K7RSJ
         wNJIaVlTLelZgxRvNsS22C2uXlKHms2YJt6Ntbf5mbLziHFqOFf+XoUmv813iGyupnTK
         jsVii8zNOnErH6W76W8Op/en/1nps/tUZH7QdMXwz9PBaSr+lEWBEqfQr/a846WXF8F5
         E2z+94YBxq8jynRNvG+nMF0Opr6nGr+r0trzbfZjaJaJ1jI50Hi4/KLB0W4fyc6vk2qC
         w1+b6CJ0l1KZZqV29Te45F/o/sgdbY+Mug8vBHP+leIpVkVXetdXJPtXnc/k3nM+5wER
         pTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Nvu0ZtKuFwIhoz3Ht8JwrGDF2CYMzfNSPFQATvQWNeVEq2NWOE22fkSe495QTppbWBhINaGwcHAfegw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/w/rEr/BEPLcJTyfCpITEWsVxU+1v92GAqQLNs8PJY9L2DEt
	nIm5v4NjiZcT/ELCEYVdR0EQAtZ6iI/wZBWeSgk+Mziis3jsc+98
X-Gm-Gg: ASbGnct/T5GaHiI2tuknJrTB2lRRoZyf2j+7/JumEZb3t4RXUscZkgQ/igAL06NjUl4
	RktMMSwRHG6j1iPamfqv9iE90yc0B4Z7Qx1aRB5xmzm9UokXumjhZrJSxc0xW6AgMclTCi6DFUN
	wyaflF2RZmAwcV0CxUJAl3rpEMA9/tcm496n6W2xMF6gcQeYUueK34D8J2oPulzbkDj+qchYuMj
	C2Lun0gPj5ZWePryGeGckn198rbaf3HOkh0s7U8WRmu0fryXFYBAc+6DaidnxUiNw/NajExRUaC
	wcAFWAPMVYYTqLWGHJRhQNaSAoSmQpnTfZV50VKeaCoiETnyEyBEyP/63MgRlAWiC4b9iM7ABW3
	WNKJvUqAvhywVfph004OBD1qBGDAd3ZTeQ+Q=
X-Google-Smtp-Source: AGHT+IEtlSicy7Lw8Qz5zNvhBSB31/jGaHs4MFDmY+NzMrbSpW2WeBmjQgXSsvZ2CvsEQjEhN3CFnw==
X-Received: by 2002:a5d:598d:0:b0:38d:d9b3:5916 with SMTP id ffacd0b85a97d-38f6e7564dfmr448121f8f.1.1740081748088;
        Thu, 20 Feb 2025 12:02:28 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-4eb5-194a-5112-4af4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4eb5:194a:5112:4af4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa1esm21259676f8f.100.2025.02.20.12.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 21:02:26 +0100
Message-Id: <D7XJHYJJYHGA.2829KPQWL3N8E@gmail.com>
Subject: Re: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Karan Sanghavi"
 <karansanghvi98@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <Z7dnrEpKQdRZ2qFU@Emma> <D7XJGM6MAB6N.2FYSUN4OJELUA@gmail.com>
In-Reply-To: <D7XJGM6MAB6N.2FYSUN4OJELUA@gmail.com>

On Thu Feb 20, 2025 at 9:00 PM CET, Javier Carrasco wrote:
> On Thu Feb 20, 2025 at 6:34 PM CET, Karan Sanghavi wrote:
> > The array contains only 5 elements, but the index calculated by
> > veml6075_read_int_time_index can range from 0 to 7,
> > which could lead to out-of-bounds access. The check prevents this issue=
.
> >
> > Coverity Issue
> > CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> > overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> > elements at element index 7 (byte offset 31) using
> > index int_index (which evaluates to 7)
> >
> > Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor=
 driver")
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > ---
> >  drivers/iio/light/veml6075.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.=
c
> > index 05d4c0e9015d..5dd951f6e989 100644
> > --- a/drivers/iio/light/veml6075.c
> > +++ b/drivers/iio/light/veml6075.c
> > @@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct vem=
l6075_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	return FIELD_GET(VEML6075_CONF_IT, conf);
>
> Please declare the variable at the beginning of the function (there are
> some integers there already) and rename it to follow the driver
> convention, it for integration time: it_index
>
> > +	int int_index =3D FIELD_GET(VEML6075_CONF_IT, conf);
> > +
> > +	if (int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> > +		return -EINVAL;
> > +
> > +	return int_index;
> >  }
> >
> >  static int veml6075_read_int_time_ms(struct veml6075_data *data, int *=
val)
>
> With that applied:
>
> Reviewed-by: Javier Carrasco <javier.carrasco@gmail.com>

Fix:

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

