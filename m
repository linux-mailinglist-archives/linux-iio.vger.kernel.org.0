Return-Path: <linux-iio+bounces-3583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF2587E593
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 10:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D86281F8E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A42C1A2;
	Mon, 18 Mar 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/3eOtkP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D52C19D
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753617; cv=none; b=gJETAfYt6JG8IFC4jDWgkuqGnwLAFsrx35c1QNgpPVCL7I7nT0i+z9PnFfs2Abyn85DpKBfvK2IgX6nap/ZJM9w42VpkbIvd+2/A3Gv1Nr+QLwlIHXnGi/aZwym+FCDx+KsKD2Kc55eATacalZm7iDrtshUCvZL5WPwzfnDc4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753617; c=relaxed/simple;
	bh=Y1W3YK6DFUzBrPxMi/82A6BBRYSC0a9EuHzxzO5Idu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5TeWh3kU41CbtAnR1YoxwfivgbuLFJjx7QllXUYDpett8z4esXkFA4TAasTP8vxNiIBqkt7rTF5EXlYugOq+2OxPJAxSDC9A0hbm4hT3ONPjzluy8F8F7oD8vxyOHN9xxev5gziHp6HAMaP371o6fuOILTaalEjUsLRlW5tKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/3eOtkP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430c4d0408eso8290131cf.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710753614; x=1711358414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=957a887D4bBCae8DOcFMKPtL1eaFnlSe7t6MFc2PxTI=;
        b=g/3eOtkPOlfHiXh86tIzMQwtAE9HmwLz9HBTLuYfqxcM7HQ3WzU9R56RjAvmMEX4j1
         ly/qQbkJp8cscZKrDMy0JdzVFd34k1cOzNnFGEov980a7ABXSeS0zR/9FOJtqwXLwVH8
         v56GngSKGzmDwr07zZdFdjnX80Y8mzgth5bAPS3wJ3W+7la6cfrbEKB5sS8podL2G+gZ
         Sz73Az+rtPk70DeCyvubZ8FdwRqyFrfYVeVvHmyrLHUpOk7LsA4ZIoqPNG+2+FB5wdRE
         qMUrk/8kwUCae5FyBtaGUQj9CvN2hHOFFmDY9dS58N9opKzESHWcxwvIAZuZly5M7mB5
         epFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753614; x=1711358414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=957a887D4bBCae8DOcFMKPtL1eaFnlSe7t6MFc2PxTI=;
        b=oJPZ7TviNoVDUpgbKgpVjrN0r7qjwR+lZM4p5YE03n7+wkpDKEJcJ6BcetvpBkX/iX
         8JJ9zSN0pYE5XAOi2wk5KMwvzBg9hmsS0+EzPsvhp0Q7mICAXpmRnqYbUBz0zorPxCjY
         j8Wk1hViKn0bzYMPa4isz3k34FARhGXSuey7a2souW2q5UaXygW8+ISgnvBO+GGmFJBE
         CMY5yl4CShGly8mFwUNZiF3X39Ft80Xew2V2bBdN4F1cISs98gFlklFYXxMvxIKKRztg
         xrGIAhbvL/m0Nz/eqkZcFvDDllpcAe9Z5v7x9j9Pru/2xz/tIdU/A55+TaIUIQ/5tUUu
         8sig==
X-Gm-Message-State: AOJu0YyBUQt797zsTqSYl30U7DvI5IIfo6poEXLBmGIrmtui6DWKQGkc
	1pZDKlLLyJIdmb9qHS76Ug6HqxwKp28wO4Faul9ndoH9wl26L7lP
X-Google-Smtp-Source: AGHT+IF3R5Es0lgWm9i8KW8dXuMIGCUALJs1SEgxF+bjcF9aB+qeKNLds9fA1/7fN0933fSGYI09MA==
X-Received: by 2002:ad4:4ba4:0:b0:691:23f3:2cba with SMTP id i4-20020ad44ba4000000b0069123f32cbamr10590131qvw.30.1710753614364;
        Mon, 18 Mar 2024 02:20:14 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id jp10-20020ad45f8a000000b00690c5ec348bsm5043560qvb.119.2024.03.18.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:20:14 -0700 (PDT)
Message-ID: <aaeea094d3413da83b151debbe50cc3833f89b03.camel@gmail.com>
Subject: Re: [PATCH v3 3/4] iio: buffer: iio: core: move to the cleanup.h
 magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Mon, 18 Mar 2024 10:23:40 +0100
In-Reply-To: <ZfX1HGqT1LwA2b73@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	 <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>
	 <ZfX1HGqT1LwA2b73@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-16 at 21:38 +0200, Andy Shevchenko wrote:
> Thu, Feb 29, 2024 at 04:10:27PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
>=20
> ...
>=20
> > =C2=A0	ret =3D iio_scan_mask_query(indio_dev, buffer, this_attr->addres=
s);
> > =C2=A0	if (ret < 0)
> > -		goto error_ret;
> > -	if (!state && ret) {
> > -		ret =3D iio_scan_mask_clear(buffer, this_attr->address);
> > -		if (ret)
> > -			goto error_ret;
> > -	} else if (state && !ret) {
> > +		return ret;
> > +
> > +	if (state && ret)
> > +		return len;
>=20
> I would leave the original checks. It's natural pattern
>=20

It was suggested by Jonathan to have it like it is now (and no strong feeli=
ngs
from my side)...

- Nuno S=C3=A1



