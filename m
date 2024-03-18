Return-Path: <linux-iio+bounces-3582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A425587E587
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44297B20CAB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6228E0B;
	Mon, 18 Mar 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTQ4VHpU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD128DCA
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753535; cv=none; b=NLiZ8WcissaZblvjXZ0/uj3xW/bHhMxsz1+SsWpmvM1fMdCNmcFnb4X4BR8QFZUHJtx4VcNbCTUCMiC0V4mJmin0wnOd8K/popv3HgzFvGMp5SPCxHpSLVFW5IQ0BDvoU/Q3gJF+vht8C8QHsQ1eVVvM8SAJMbtqgOjG2Y8bGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753535; c=relaxed/simple;
	bh=pfdFOC9WeHH0NJ4SKABMldGn/AUn1f/jArMDQY9q5XA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KieCf0/odXY8l53hXMLEcwTE2gP0j/O1nL4siCl/QIfomCVpzToU0bu2ES7IcuMb6vHk5RCk829n3o2CeYIw3vyP7QJw0HNMX9f3Yxed98wZUlS7Nc83kGNDpxpBaBZo3k/nt7bYiUQ/VSR3NjmMzNtgkAf41rFfVo22tGSWcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTQ4VHpU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7882dd2b1c9so331372885a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710753533; x=1711358333; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u2u7XovadNqaaYmxWrYn7uvuRBDOinPCY6/DhnlTqE8=;
        b=NTQ4VHpUy2B2+0fcgkoM3JlIw4Q4NhBWMbceMm/uFZd8eE59asxNva+synejGokY+X
         JPYfjqfq8k2+/btqmvmhnxgq6lN/ZKaZVGWYNoWgs1g9meyb/r0LtueoUGXT9ymlJckn
         ympF+EYydQNX3BXkmqswaiJ3huVQVeqlQZuxGz37kij23SRM2UTyr5kozf7oy82N9sgE
         CRdcqeyYLBMeg+SHES0A1X7UsJZFwE8dFHfabbBYB+MWOZxyfe/tkZAn+LCDI1zc4198
         AR3UtkE4pumXouOkFHLiCsu/pQhviYcYIWbsxQ8qTXQk80oiB47Yw4yuQ0loDYcvO62d
         GHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753533; x=1711358333;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2u7XovadNqaaYmxWrYn7uvuRBDOinPCY6/DhnlTqE8=;
        b=WoCDs5f+lRGQ00nNtGv3wEPvx7AFtstgE+aYiz/p/45RVFFw/7CKaito5sYGlxBfIw
         xtxThVZwolH3Ui9yjewn4fYqQebLv09ihIXMovJ5pVL9CNSMjZ4j/oAW11IYp2wxPWUU
         nanLJXwMnFPJ22ZCpzMzUEjC1ereh/stMs3GU06AoA0R/RpiBCLwM3qSa2oksQxDsXMQ
         UcG8I2CVGp374ERh80S7RcN6fXIU9MABh/iPY2mwgIMMaXWrmy+BXvusrL4LPzqE3Ry+
         brYeCeVHfmFyYBoDP0uSW17i4X6juINbNZ/3Gwo1AVD97ZVucUV3yJG5VigbLmGCYro8
         wzzg==
X-Gm-Message-State: AOJu0Yxd3iF4ZTxW38K6FvlCIPTn3Eoo6TLe1/DOhffk0tZdBG5jMB4g
	ma7UKBQEu33KV5zfttog4iAO5H8Dlmde+ci5ftlOl2g/1twz3B70
X-Google-Smtp-Source: AGHT+IFcbmDVQBSS2zWYG532+RO9G3dS1hl/FZ0/UP4IpyDFtsJUEtDAa8+J9fAQamv8sqADYdJ9Rw==
X-Received: by 2002:a05:620a:2446:b0:789:d0eb:3ee4 with SMTP id h6-20020a05620a244600b00789d0eb3ee4mr20405383qkn.29.1710753532552;
        Mon, 18 Mar 2024 02:18:52 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id g6-20020a05620a40c600b00788712ca95esm4384554qko.13.2024.03.18.02.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:18:52 -0700 (PDT)
Message-ID: <6d6697113e4b71d85f17c570167925c4c11de52c.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Mon, 18 Mar 2024 10:22:17 +0100
In-Reply-To: <ZfX1Yv456gRr0RU4@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	 <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
	 <ZfX1Yv456gRr0RU4@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-16 at 21:39 +0200, Andy Shevchenko wrote:
> Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
>=20
> ...
>=20
> > =C2=A0static void iio_trigger_put_irq(struct iio_trigger *trig, int irq=
)
> > =C2=A0{
> > -	mutex_lock(&trig->pool_lock);
> > +	guard(mutex)(&trig->pool_lock);
> > =C2=A0	clear_bit(irq - trig->subirq_base, trig->pool);
>=20
> Another side note: Why do we need atomic bit operation(s)?
>=20

Did not checked the code but my guess is that the lock is always grabbed so=
 we
likely don't need the atomic variants. But that's something for a future pa=
tch.

- Nuno S=C3=A1

