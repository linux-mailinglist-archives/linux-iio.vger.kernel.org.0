Return-Path: <linux-iio+bounces-5897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C3E8FE664
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAC2286400
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2243195815;
	Thu,  6 Jun 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtpaQgp0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9013B28A;
	Thu,  6 Jun 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676600; cv=none; b=Cg5m18R6bchPiOLB3a+xcET6kbeFoGIf17RRPaWF9Tv4g88NXSOQ2IYSk7z17anvfSnRFwZwnG3xHkuz8hv5Jaj2JdxJ2PTT2HFm0gNLqYMBYaTtJhtRWMuTbofgP8UCkCWs2J8HzmD5XM73XArQgdrWcaor5dQREl7TffYCQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676600; c=relaxed/simple;
	bh=8pn8/jGprupn5WDXqc5TOyZpP+OyIaCyvmTNaUMSJkk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzZBk2dvKkcEJ+U8Z4kDwKTkQGKhIcENatDCxMs0v4Zf3aW1G2VhBWSljn4RXFn00JdSS8nQo7Y6tjn+A+KEoMW4feW/+nETzIasvh/ey31O421ofUifpx6XkO4B3Asy7pHSrsQqzxhsLVDazvCk5dSGngyMwlWFwbuYdLsjcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtpaQgp0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4215ac379fdso8948175e9.3;
        Thu, 06 Jun 2024 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717676597; x=1718281397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gzXR/OvjO7v9S+Oeo5jOyL/ZCpVVTFjEqhMz5dsHPGw=;
        b=dtpaQgp0UciRolzV1KM2VxMXAFFX8wE2i2slZNaUDlnIkoM78U+ejmw3fLuzNQgIBN
         cdyiWtmM83l9tbyqtacn6SvT9pJPZmQq59on/6rZ+IfeRX1j4sdkKsVVPfvhY1nSHopN
         1XyqkiNIoG8XQ1aguLmyEYpWyBDdsNLnIWHqgH323FrUjDApYzudlYIQPkP47vUb4/LS
         UE0QoA/6lL8F3QzFir88AWCQIu71B+GDLpKwI273sfVf12QHtQiMQbFybMoVZ5385xdr
         AfJwmmknbTq8g7/f00RSaMZm1EZ+b1I+svbToiBI4ubYJhL1/fu5WToFU5br8Cur1MUc
         YaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717676597; x=1718281397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzXR/OvjO7v9S+Oeo5jOyL/ZCpVVTFjEqhMz5dsHPGw=;
        b=tRUEfbTszKnJEdTLL84EBAtpYxBVo3R/kijitS/0QEGA8iJAreZuPjyhAkTKixIRYw
         s5IWlKNczaISwE68KLJmXU3SfKDJwPHEHjb6yPjhukbbyCDLdmVCcm3ADLEVBZB07mpX
         3tGOta+0eY4HgZrWMRx3tw4Eq9DlEpKiopNDD2z6RIHp26HN81AMIfesnpk7lZMt2yYt
         qq0GRf6vnN21HAIL+ZHLmWIQXuaPEWkQphQtMXRp5peeQuQD0dHKBa5EdTUGF7XuqOr5
         uw7Ofk7eUNz0bu6UZBQCM2AD2m3IdrcxBsFyxOOyDMTKHhcObJdJ9KUrGgx9Nh98himt
         vIfg==
X-Forwarded-Encrypted: i=1; AJvYcCXWrvwRHgBQFjZ642/mNw1sCL/Pj/gHhQ8JrAmRUT5g1fGzBl64Tt0h3vYPQP8NDgX/Tu3L1NyupRVgEPjtH0VihRXMut2ED/OvKJ0cqL9YwEm9AqU0s1Nh0cO/p7EjJgVxfNiob05R
X-Gm-Message-State: AOJu0YylfPMXnJYX9vFG+wHGuUiK9/p767Wt/wco8qzvhkfUHozsKDZ3
	y/AJHGsqaY4aF68KTIAFawpxkUXPkRnEEvTVyG38IPtsoHdeqOGz
X-Google-Smtp-Source: AGHT+IFCSu0IrRiUf8/+5xHet83VVekm6q2A38YBSMKLcaH1ziPPUdgKF32p6MjIheC5Oubb9L/2Hg==
X-Received: by 2002:a05:600c:4f0f:b0:421:2a43:6518 with SMTP id 5b1f17b1804b1-4215634cc35mr40922135e9.33.1717676596946;
        Thu, 06 Jun 2024 05:23:16 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd18asm20066655e9.39.2024.06.06.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:23:16 -0700 (PDT)
Message-ID: <da57a64e4f5cdda7ee6b794c448995eee648c436.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>, Chris
 Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Andi Shyti
 <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 06 Jun 2024 14:27:03 +0200
In-Reply-To: <ZmGMwwglUlS6_NI_@smile.fi.intel.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	 <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
	 <ZmGMwwglUlS6_NI_@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 13:17 +0300, Andy Shevchenko wrote:
> On Thu, Jun 06, 2024 at 09:22:38AM +0200, Nuno Sa wrote:
> > Use dev_err_probe() (and variants) in the probe() path. While at it, ma=
de
> > some simple improvements:
> > =C2=A0* Explicitly included the err.h and errno.h headers;
> > =C2=A0* Removed some unnecessary line breaks;
> > =C2=A0* Removed a redundant 'else';
> > =C2=A0* Added some missing \n to prink.
>=20
> ...
>=20
> > -		if (ret) {
> > +		if (ret)
> > =C2=A0			/*
> > =C2=A0			 * This would be catched later but we can just
> > return
> > =C2=A0			 * the error right away.
> > =C2=A0			 */
> > -			dev_err(&st->spi->dev, "Property reg must be
> > given\n");
> > -			return ERR_PTR(ret);
> > -		}
> > +			return dev_err_ptr_probe(&st->spi->dev, ret,
> > +						 "Property reg must be
> > given\n");
>=20
> Even if it becomes a one line of code, it's still a multiline branch, due=
 to
> comment. I think {} is better to be there. What does checkpatch say about
> this?

Checkpatch is fine about it...

>=20
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
>=20
> You can make all these lines shorter by using
>=20
> 	struct device *dev =3D &st->spi->dev; // or analogue
>=20
> at the top of the function.
>=20

Well, I had that in v2 (making the whole driver coherent with the local str=
uct
device helper but you kind of "complained" for a precursor patch (on a
devm_kzalloc() call). So basically I deferred that change for a follow up p=
atch.

- Nuno S=C3=A1

>=20

