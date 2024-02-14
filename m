Return-Path: <linux-iio+bounces-2544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208C85493E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 13:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AFA2890C1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E67487BB;
	Wed, 14 Feb 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOOQEJMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC58364BF;
	Wed, 14 Feb 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913927; cv=none; b=jD8MXVNK3bH+0PUzr74S1YYkTaKgOIhPb8+bxtY1G04PfqooujA1ka5y0HQkQZw498BnYEhnSZeb8RC7RX06DgJ9Lptx7qa2KJj+CHmG000Ff1x6Tje3maGjYkJAkSaOYFOYiaxwFLIUaClzxDB0r5lTp6GhHLsDcmd/vfG6bu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913927; c=relaxed/simple;
	bh=wyuyLEh2cqw5UMwPruowX3Q/bkgESYYC7Ij/ClDKrZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=futn16nrbByf+hOoxfDP3lS8MPAu8L3I5nLo/hNq22uMTYwqA34DcYR8ZyAvGCKlMAbr+z5JHijpj4Z0c0tSM8H/KPFBN7E/lSK88vpfne5/hsa/Y3ohrXm+GAe3Y7a+D1z9p0Am1v/4ODfmj3V2jujd93MRI8SzIaCGKKJ7MSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOOQEJMV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5638de1d953so299390a12.0;
        Wed, 14 Feb 2024 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707913924; x=1708518724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wyuyLEh2cqw5UMwPruowX3Q/bkgESYYC7Ij/ClDKrZw=;
        b=dOOQEJMVrgExo70l1Osxwc4aWYp9sUIMcId8YWlg6aDdBtB/GdpF6SHRPnbNGydCbr
         qXCWI8kDme19cPyuQz5FidfnHJXkcs0PyeFnazv3Zhtv9dijdX0BboRtmgvU2Q/Ytxtw
         FW2+V+/RgLR/8mSY/JRUklVsfkn4apZkETvJg17ml5Z8RYsJkaGA0wgl7yFhWURDPVeA
         UWu7Wr0qiKysbE8BKyCsJfjKuu9CbJqEJVMbtV+47R8oTp0XngxoCLQ+DAv+FB6SUDgA
         sPomxX0owkufLxcgU+cC4xg5RlyHDVcXwkcFtoGXrNDpOLDzNGwPXBq2yF42Adx+K3yv
         CE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707913924; x=1708518724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyuyLEh2cqw5UMwPruowX3Q/bkgESYYC7Ij/ClDKrZw=;
        b=cNDwjberh8Vk1j/gwoOebcyADv4aaeD5+k+eSvrl4c8IUKQjnlZ4NGcq9fPWdwtd1T
         5vbtHHQtZNGB+fiNcQsQ3N4pB4OSGXI54O5hft0h3eUCl04D/2/Tqno6fjkY4GdGJxWA
         2zI1By7uB1TkS2AqUO0itgi7n/FEi5PSh9hhWAgK1obwgSsJfdVNSQWwmvZKii9I10on
         dQYdHsvd+vioQY8thr7t+W5ZiDwkIUWReTGssrfMk7fhSHrxLoWPJm7QtNdxq+9UEXB+
         IA5ONAt16C35ydORe6vAwJi2QXq41yPmdVbeOsm3jxZxHepApAnTWLFkTUv6VttyOzld
         fisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK2rfU2/MwDlGEzqzY6KVwZmSMV84gmBWkySq2k64HQQ+qz5DU/cCAxoskBrQwlkAckqra/Q78aqpw+lEvUJXALBilxV52kjjNDQ==
X-Gm-Message-State: AOJu0Yz4L//2JYcuYtvameYXjqVeWqrturDpR8qHgv5gTS8oBTCZMQsi
	26nydZFdfY4J23IJsEEhWq/SR+rw2lKFuE10YPMRisw8OMT8yTri
X-Google-Smtp-Source: AGHT+IG00Wt0n2r2pqLN7EQ2e8M8e0/dFzf14vl8JKN+kK6YMyeoSPUmX1bX3H+8MFFnq2PgWuKjtA==
X-Received: by 2002:aa7:d3cc:0:b0:561:3006:4df0 with SMTP id o12-20020aa7d3cc000000b0056130064df0mr1814167edr.42.1707913923465;
        Wed, 14 Feb 2024 04:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcpYnaEk1/psLR8AjkN8bKHxpB7XDXOUKqgbwYe8viL2ARjnjKr14OgYdPBBConLASo4mvQIQyXaUSwPjkPTG+W/qaOMkukIk+P9pUtMf2njdlD2SkVgr1F2DvuvBD6ReJLssf3QFo6Q5oPUq9YvKQUCMIoKj/E6JxS0/PPAnAvH4S0lcdpCB+CbbnebFR8zvl4UOJ5FZ06i8WfOWZHg5ZzO3+svNMf9bL+M8WT7zI9DBag0AcCUSBoEaVq5sPB6mQxK4Ul+wPgRybLHMIPQPbI+ATXYDsJnd444ALvNe2H9vnGE5GxiQMmvkqy7opkLMJ1zBk0fLN1yz98WeIVfBHzjjV/KA+v0tZkYi5NZ4AzF4TKu60GqW/9Sit2wnNGA==
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id es27-20020a056402381b00b00561f2b109cfsm1495617edb.76.2024.02.14.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:32:02 -0800 (PST)
Message-ID: <be58e8b4716dae855843645de59671309352eb41.camel@gmail.com>
Subject: Re: [PATCH v11 7/7] iio: adc: adi-axi-adc: move to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Wed, 14 Feb 2024 13:35:22 +0100
In-Reply-To: <CAHp75VfiM0cqFsdN3nQQzZkea+cKfbFKkSM1J4LdE3LYGFedWg@mail.gmail.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
	 <20240210-iio-backend-v11-7-f5242a5fb42a@analog.com>
	 <CAHp75VfiM0cqFsdN3nQQzZkea+cKfbFKkSM1J4LdE3LYGFedWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-11 at 18:52 +0200, Andy Shevchenko wrote:
> On Sat, Feb 10, 2024 at 10:57=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Move to the IIO backend framework. Devices supported by adi-axi-adc now
> > register themselves as backend devices.
>=20
> ...
>=20
> > =C2=A0struct adi_axi_adc_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *regmap;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *dev;
> > =C2=A0};
>=20
> So, not sure you need these two as one can be derived from the other one
> (IIUC).
> In any case, it may be amended in a follow up.

Yeah, I think you're right and I never really thought about it but one can =
use
regmap_get_device()...=20

>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsleep(10000);
>=20
> As I pointed out, the comment is good to have. Maybe you can add it
> when reducing the timeout in a follow up patch...
>=20

I did not included because there's no documentation for the delay. But I'll=
 try
to ask around about...

- Nuno S=C3=A1

