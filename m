Return-Path: <linux-iio+bounces-17928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6BA85CE5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31773BE18E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991F2980DA;
	Fri, 11 Apr 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxPOyF1P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAC20C472;
	Fri, 11 Apr 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373845; cv=none; b=lW5cptQysbedLszv7aasMD5+gXu3FQfw/D+/GF8Q5zfKS5NJv7Ps6YB/cZo5qHhLgP0g5YHaTrPNN6YazARZ6NaxSP+w6PNdtNUYpXVUfNiUtssZdwbbioHjDxbcoDprQPSUyDnmc0tbMspXPQq7ccYZbIUCROBt98YIp0gbsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373845; c=relaxed/simple;
	bh=LQ1M+1b8b9vBLsNLkDWj7I1E79qb0JgGieKSY9mEVNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r236M5fd5gbyNEkUyS1ksrFEPK4XLQQa7BT41DKW62YIWxdsnZmTNuQtwoZXHt/pPHikK7ffuY6m6IQubs9SX2rL7JkmwW1hemWNSoPZwi+jFzmskqmYt5fGqO0NUwix4I1K0INXcLzXb4YNJd8pfIkWDikDW3M8qE9qMIWDO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxPOyF1P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso10237465e9.0;
        Fri, 11 Apr 2025 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744373842; x=1744978642; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kn3LV5txXzAwuf3XmOeQiyMiqP5GN1TzCfz2bJ6NzTI=;
        b=kxPOyF1P0ybe5zQxxO98hMxsXvV0myeBAArn760+K6xjegbbNIAQhv48MwTyBJq4z2
         WG6Cr1qutM5wZC6pxI+cd5mR8KIb3H0ggO84nlgiFpdBx2dCsmlsj4P9tnDWcE5+/Z5O
         RmZGkFt/yALYDMf7UC8PS9HSnhdsvd3KvEPcaXklVqpy/s7Jg8MLDoJLo9S1PZLkAtMm
         VxXIaXnVbmwooUIv8cmhoUzylvMpRWAaCZijL8eIbdwnPyjyaj5a4CI6UDWjwv8o+WZ4
         gktcFTJrJyfAhSjyFjz7bKyl3xN9NpsHskLqmj6OzhMBlEmakcfwAaht/ieoCIwAunwr
         dHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744373842; x=1744978642;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kn3LV5txXzAwuf3XmOeQiyMiqP5GN1TzCfz2bJ6NzTI=;
        b=HJjz66Nd3jvMt8x/iQq42otMk8swbsCcPMnrl31VctVQpqtbXO4VrrDcgyqe24KH5k
         mc/8NsVb3LpIk8inE4votm2OpqETSovl7O746A86yK6n/Rto+dZ3rm+zmrLxOW5aKAh0
         eMzv2I6NaXwzgNZAbS3jpl/Dbt3/oIz4OgFfH7XZrzFrf9esYJjhakfSQWu/sT+Xcu46
         AdIvxHQsHG+GLjur0qzVWv2KPVSaVNWXREGNBYG+ey03QvQnI1EU0bs5eGd4WnklyzE3
         5tBSlQPebgcuQzseb++l068A98LbQfgDHQ7LdS766N80cQ4NhZMVEDCB2E4VFYki546E
         ftKg==
X-Forwarded-Encrypted: i=1; AJvYcCVKOX/vveucVSYpjqv6YwWP5wfC1btq6n919kOdS9TW+qdjzKoSfH+8MXZwvlvp7BNzmBchc6FFdLl8sUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BxgXOKszyIkHY8FReshrNYHwGZWsiXz31Tsi5NZCXK42WpEX
	fSU8Bh2Fl4/bKgZgyyt1bfnI/2u/enr+Dm6PW36Th68mXsrf3qqX
X-Gm-Gg: ASbGncvXe3GX3RLOotUHJe2gJZ6ibV7EzqBUpFd3qtEbV5qDDkOBQcdUTRf2Cf7prmN
	qxOysYU6XlF1CX6M6VjTQer0ibWW9zQZHpz9hADIN7mDLji5Yvp6ytVlg7rirTyEn5kTk9EwEFg
	kzBZ4YbVr5j80/7sUXKzACElzxNuTX1l232JAEpZGV/pTkj2N5SEsUTU4IUWCFlv7zQmeZ9e6Ep
	9MrNquNJ8WbAjof85jP4T6/t+wXaKOfZXvG77UTsVcxuf0KtTh4PFTNxw+iqkfAwcojWCZ0i/I/
	cTwsxL6kQ01kyry5lt8PMp2W0l3WmdUSX3Bbhn+K6uXM7Dw1+LgpyfenWVgOhZA42HeFdT2VsZR
	TUb6itOB7lARo
X-Google-Smtp-Source: AGHT+IFog+0qqKPQLdM6uZje+i8YjA1ktJFYq86eWkauLTJn40A5FydWdSSXRi5qC247Pyx5FwVaBg==
X-Received: by 2002:a05:600c:1d93:b0:43c:e9d0:9ee5 with SMTP id 5b1f17b1804b1-43f3a959c51mr23698005e9.18.1744373841571;
        Fri, 11 Apr 2025 05:17:21 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23158849sm84339995e9.0.2025.04.11.05.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 05:17:20 -0700 (PDT)
Message-ID: <5cb7ab70be67f8b97b5fd09eefab0f2c33d99d20.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, David Lechner
 <dlechner@baylibre.com>, 	cosmin.tanislav@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, 	jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 13:17:22 +0100
In-Reply-To: <f5f40475-fae5-487f-b5ce-dc6c5dfe3600@gmail.com>
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
	 <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
	 <10a9dd5cdf55b6a9845fb9543cdef5f2251ffa6a.camel@gmail.com>
	 <f5f40475-fae5-487f-b5ce-dc6c5dfe3600@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-11 at 14:39 +0530, Purva Yeshi wrote:
> On 11/04/25 11:19, Nuno S=C3=A1 wrote:
> > On Thu, 2025-04-10 at 09:51 -0500, David Lechner wrote:
> > > On 4/9/25 3:29 PM, Purva Yeshi wrote:
> > > > Fix Smatch-detected error:
> > > > drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
> > > > uninitialized symbol 'rate'.
> > > >=20
> > > > The variable rate was declared but not given any value before being=
 used
> > > > in a division. If the code reached that point without setting rate,=
 it
> > > > would cause unpredictable behavior.
> > > >=20
> > > > Declare and initialize 'rate' to zero inside the 'else' block where=
 it
> > > > is
> > > > used. This ensures 'rate' is always initialized before being passed=
 to
> > > > DIV_ROUND_CLOSEST.
> > > >=20
> > > > Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> > > > ---
> > > > =C2=A0=C2=A0drivers/iio/addac/ad74115.c | 2 +-
> > > > =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad7411=
5.c
> > > > index a7e480f2472d..26770c68e5fa 100644
> > > > --- a/drivers/iio/addac/ad74115.c
> > > > +++ b/drivers/iio/addac/ad74115.c
> > > > @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct
> > > > ad74115_state *st,
> > > > =C2=A0=C2=A0			return -ETIMEDOUT;
> > > > =C2=A0=C2=A0	} else {
> > > > =C2=A0=C2=A0		unsigned int regval, wait_time;
> > > > -		int rate;
> > > > +		int rate =3D 0;
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0		ret =3D ad74115_get_adc_rate(st, channel, &rate);
> > > > =C2=A0=C2=A0		if (ret < 0)
> > >=20
> > > I don't see how rate could be used uninitialized since we are
> > > returning the error if ad74115_get_adc_rate() fails.
> > >=20
> > > Also, initializing to 0 would then cause a divide by 0 error
> > > if that value was actually used later in the code.
> > >=20
> >=20
> > Agreed... A better check could actually be (in ad74115_get_adc_rate()):
> >=20
> >=20
> > if (i >=3D ARRAY_SIZE(ad74115_get_adc_rate))
> > =C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> >=20
> > Kind of a paranoid check but just making sure a faulty chip does not le=
ad to
> > an out
> > of bounds access.
> >=20
> > - Nuno S=C3=A1
>=20
> Hi Nuno,
>=20
> Thank you for your suggestion regarding the paranoid check.
>=20
> However, ad74115_get_adc_rate is a function, not an array, pointer, or=
=20
> vector. Therefore, using ARRAY_SIZE on it results in a compilation error.
>=20
> I believe the intended check was:
>=20
> if (i >=3D ARRAY_SIZE(ad74115_adc_conv_rate_tbl))
> =C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>=20

Oh yes, bad copy-paste...

>=20
> This ensures that the index i does not exceed the bounds of the=20
> ad74115_adc_conv_rate_tbl array, preventing potential out-of-bounds acces=
s.
>=20
> This check prevents potential out-of-bounds access, it does not address=
=20
> the Smatch warning about the uninitialized variable 'rate'. Smatch may=
=20
> still flag 'rate' as potentially uninitialized if it cannot determine=20
> that ad74115_get_adc_rate() always initializes it before use.
>=20

Well, as said, this is a false positive...

- Nuno S=C3=A1


