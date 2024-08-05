Return-Path: <linux-iio+bounces-8243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24978947557
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 08:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DB928136F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78F13DB88;
	Mon,  5 Aug 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwKdiqWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18381E4B2
	for <linux-iio@vger.kernel.org>; Mon,  5 Aug 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839715; cv=none; b=G9wX2u079el3DzXxC9rEk64oPSoPAlljDx3yCX8TYN2kdi3S/+UQ91lUqv2vTucvWqaTnJtVK+lyeVamLpIEEgie2ioyanuk7Hpg14wB6Yq1RrxSW97E23pNF34H4jjRV3P0HBdn1Mh9p6hOrZIuMEshVMBhJWM4kG2az6lTJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839715; c=relaxed/simple;
	bh=OpFDjKna7PlQsNfsSEnEPxioL6gh7QvoXVodDcUCakc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZRwpYyPJTjNw+Gva+tWTiUXayw/jzX8gI3gcWKhmC3MyHPAwh0mdwp2+Mbj1YXB5Bu3lwB7bB0IT5MwGcycFtfd9EU39TRRlJiLfu5M1eVRUei4xzU+iXJnThK1JLP28N28QiS75mcoxCIBZJ47ZCPz/UrkV4bg5vaKYuSaUbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwKdiqWg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so1177015466b.0
        for <linux-iio@vger.kernel.org>; Sun, 04 Aug 2024 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722839712; x=1723444512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OpFDjKna7PlQsNfsSEnEPxioL6gh7QvoXVodDcUCakc=;
        b=hwKdiqWgbyfGgN9J7qfga/Fm60TcfIb6OXdjIFyOOQD22cUR2W/rxwkEclfbentjRm
         F+cZWU66L2bmzAbSkzh6JlEnde8YrqJ+/j2w9KF8qfJajWp7drDolTNUXZqLj9ZT02y7
         adcptkpjYocU9ery5tH/ts4npqNyo11yuqOtTiIaT+hFu49AKuno0O6E1VuwvdfyR+4j
         pV/BWpgpnY12sjkvOvtJ+0FKs0NW2rSOw3xLx3UZDDEpo+/rWFZ97jHnnLXfcCKYdUFl
         AEAb0DukC43WYtBkvgSSKaL4UL2NIL+oge2l3kCHH+U8xR9kjGpgMnui1bTnRrxMu/t1
         RGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722839712; x=1723444512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpFDjKna7PlQsNfsSEnEPxioL6gh7QvoXVodDcUCakc=;
        b=T8sOpimojkpClYY+V012xq9nofC1+yuiNmdrt7B6D37r3ednhGgc1PWs0xfMu3oYym
         r/m9auEqMnpHyHsQixeOvHtgm3cmwI3cnjNu+FJhOQLRLQhUNOU96SfDEH6pj8MynIan
         wOI8ydTHhc/1DT1VrGRD5it3/scLuKbodYFKHYl2J/3I5DupXXnE7YU7Z+OfesCFeQoV
         /3ombx04vwiEAOXSKIKJFk2Wm76ZrdtDGK+ivGv5kfX8dSTmmaEe9RGhOlzZ+g+RRDiz
         C6kT7JIhiZzDg0EaxzRRWICOgdj2AoF9HjikniAxG+cAsHD7FC8kgzdBJ3kWlt1R/GRu
         9saw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+1QpaYtmZqU4468dX81bMEeuV4rLNvvQ2T3N7DDfW1/m7HQWNSJluaNeqo2ZXuUMkDBNhOucHXepWEWNlQ9sIFBNPLoRo4Lk
X-Gm-Message-State: AOJu0YwIPkJoFB6DwfUqBlyAWip/3wcHisHW9VdYmvn6V3GHAVrogx42
	wOUuISnWNLmSIDXK8BEhzh6TUn19rkjUDKzSbDwtF0klQeGcl7+a
X-Google-Smtp-Source: AGHT+IFgnFnoqHxDsogP3403UL0QmpCjetPwZ5m2OKtl4FCoOP/XJBXhdCLrVBQ67orZyj972L54Sg==
X-Received: by 2002:a17:907:7246:b0:a7a:aa35:409a with SMTP id a640c23a62f3a-a7dc50bd79dmr683696566b.68.1722839711833;
        Sun, 04 Aug 2024 23:35:11 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d427b4sm411419366b.130.2024.08.04.23.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 23:35:11 -0700 (PDT)
Message-ID: <55ab0594033908ccfeb302d5c2fc9adf819bc4e1.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: ad9467: add digital interface test to
 debugfs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Date: Mon, 05 Aug 2024 08:39:12 +0200
In-Reply-To: <20240803143806.17bd4e56@jic23-huawei>
References: 
	<20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
	 <20240802-dev-iio-backend-add-debugfs-v2-8-4cb62852f0d0@analog.com>
	 <20240803143806.17bd4e56@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-03 at 14:38 +0100, Jonathan Cameron wrote:
> On Fri, 02 Aug 2024 16:27:06 +0200
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > One useful thing to do (in case of problems) in this high speed devices
> > with digital interfaces is to try different test patterns to see if the
> > interface is working properly (and properly calibrated). Hence add this
> > to debugfs.
> >=20
> > On top of this, for some test patterns, the backend may have a matching
> > validator block which can be helpful in identifying possible issues. Fo=
r
> > the other patterns some test equipment must be used so one can look int=
o
> > the signal and see how it looks like.
> >=20
> > Hence, we also add the backend debugfs interface with
> > iio_backend_debugfs_add().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> I'll apply the series, but I would like a docs update for the
> debugfs files this patch adds.=C2=A0 That can be a follow up patch.
>=20
> Jonathan

will do

- Nuno S=C3=A1

