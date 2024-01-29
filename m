Return-Path: <linux-iio+bounces-2004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A983FFCB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3811C22D10
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CDB52F81;
	Mon, 29 Jan 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQGlKOx8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24453E02;
	Mon, 29 Jan 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516139; cv=none; b=bsianj+YNzjnxJGYc0uONGjYCH+61pSemKsjcnk+RTk3srGoemA/xeZmRkT2Be82X24aqmdNjHDxbZejwaE/m0EOkHd3qoRnVFx76+AEJtBGivqZN2zhPjXGpSSZ8AjTxHVJfURPOgbJ2ZL/tGYwe/lK3PI6uQLY3FZ7RXFo8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516139; c=relaxed/simple;
	bh=7muQ1StB6x5XaFGccp6wIo++p4fdPmC5mLD1gYXoZjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JqJKbuJWlf4iBRTj1WQGIwp3ug++7kETn0WJRGRcfixemb8Lzzmd00WQHlCLFCrukWT+c2Bh4yT8B4ObyIuJjRJ1Q1T3XrteVugNdm5BL5XDkXhRatmtpS7pUoPHyMf+p6Bvd5rx0n05dcOPmMxbtPuyIXHh98RVD0aCP4V2qrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQGlKOx8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso607286a12.0;
        Mon, 29 Jan 2024 00:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706516136; x=1707120936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7muQ1StB6x5XaFGccp6wIo++p4fdPmC5mLD1gYXoZjY=;
        b=DQGlKOx8VapBA4U8JuCvA0mY2ytBpvaJTwEA+Gx9+JzCcPQxsVDTZD/OpOEzI3nk9H
         Vk2ER5fz3Shmy6izSPe2DUhlJ4SJq0Oe9r1nQ+8tFIhTv3Rwd4cFgTKUXHWqvySdfthh
         /xxcb1TCt1rVLtQ14tDU0YTwoRLaddcZRxJ9LGzRrobV/5qL/F15/v+72i8oGmsdyJi1
         26eNtGGuhGEoO1z/lxnI9natnVPySvnHrmJC5CPbXYZUFm6XgrTFqlIJLHIARTvp6F/H
         t99QdUAT3//dkLb7ku/LoGuOMRSbiuVhqzdynEKxbjnkWg4JxmtUe4Pwe0ZJdpnknS4t
         R65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516136; x=1707120936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7muQ1StB6x5XaFGccp6wIo++p4fdPmC5mLD1gYXoZjY=;
        b=DMygir0OX98i1vz2DQ8YFlOHm4PNoSeAUaytsr+9Qc4Um9QYP0ci5sW9mSOIbtc51o
         pz0cEDPFv7Kvwspwde3gjhnwBPvREk6ifT/cAyYxHiqrOPHbAPt4uOlNqJ1TZSelRi1p
         zbadxVZajm+EduX28piCtGCN8xPqv2azwgFPM8n9dteNWmLnuY0jxhVpdODFyw8FgV/k
         j0G7I1JENmG49JoaOqMD8Bsr6SGhUn90ti0kaHYW9Ly+rLBOSpr8sb4pvlEBMG+X34h5
         syn//zKsNcsL029K4NnBHZqt8pbKSs55FH+U82fsW55DSzVqu9hu54nxFezahB4Fzk8O
         LsSw==
X-Gm-Message-State: AOJu0YxmN2P+2oec4HhP0T9QEppxAUljksg+4Mg3h4KrQvWygzv3fAuK
	Un/tZ+OwGAFJCMWJYxo+dQJOfWL1m5wvbMHDbpqM+JrjVV+Phlj/
X-Google-Smtp-Source: AGHT+IFduPtM3ZeVAcbSKSi+TzWbfqH38rJHbquhwfK/62ZmJhbdnACp/YU15Iw2yLdLtmK7M5bktQ==
X-Received: by 2002:a05:6402:3124:b0:55e:e9e3:715d with SMTP id dd4-20020a056402312400b0055ee9e3715dmr1667169edb.12.1706516135847;
        Mon, 29 Jan 2024 00:15:35 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id j16-20020aa7de90000000b0055ef0574a59sm1208022edv.40.2024.01.29.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:15:35 -0800 (PST)
Message-ID: <dbf75dfff3ac2d03d198de918a6c525f7b5266c6.camel@gmail.com>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Saravana Kannan
 <saravanak@google.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 29 Jan 2024 09:18:52 +0100
In-Reply-To: <20240127150726.3c9150c7@jic23-huawei>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
	 <CAGETcx_0wij8j5u7YRNPDgpPDkJoFq4AL7oRy0iFUELYTbc9Bg@mail.gmail.com>
	 <20240127150726.3c9150c7@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 15:07 +0000, Jonathan Cameron wrote:
> On Wed, 24 Jan 2024 19:14:35 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > The property is io-channels and not io-channel. This was effectively
> > > preventing the devlink creation.=C2=A0=20
>=20
> I'm a bit lost on the devlink side of things. Is this something with
> effects on existing drivers before this patch set, or is it only causing
> real problems with the changes in here?
>=20
> i.e. Should we mark it for stable and rush it in as a fix, or can it wait
> for the rest of the set?
>=20

I guess you already figured this out? Anyways, this is a real fix that was
affecting any consumer using io-channels (so nothing to do with the current
series). Since the there was a typo, no fw_links were being created.

I stated in the cover why I included this. Just to make the addition of io-
backends later on easier. But if Rob prefers (or you), I can just send this
standalone patch to the devicetree list.

- Nuno S=C3=A1
>=20
>=20

