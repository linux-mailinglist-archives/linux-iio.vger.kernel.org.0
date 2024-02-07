Return-Path: <linux-iio+bounces-2282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C784C726
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF281F258B6
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E520DCE;
	Wed,  7 Feb 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR5LxUXB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2120DF5;
	Wed,  7 Feb 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297621; cv=none; b=bViAipG0polzwlrqHyci8SKWVJgU2tkdDNDF8a/9q98fLN524zrXuQkDVlMzccbANWd+BXj1UjA/VUVCOweMUQvcDnymzn+5hMOvq+bdycXzp6bvbZLH1rpPtH5HI6G72+72xzFbfyJeiRbunoDxb21YneTVGAxrKELfdnrxsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297621; c=relaxed/simple;
	bh=z9nw8FLwM9+e+s7KrvfDxVPXnoahsORL5p3+IFpyc9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1bDHCFnCpd+jNnvSYmrtTG58B5g8c+eJ17tXbUQSREsWAwJdxpigT3k8nQx9TOqug1ZYoZqpKjRWAhG88fsLl1EZ/jusW63YtUHZ84Itf9nqbWbCnMeTnKrlKl2/w8plpqPDNoVisGEF0pywisVEyTDDdJ+1gZAg2pUWvNq5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR5LxUXB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370328e8b8so46175966b.3;
        Wed, 07 Feb 2024 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707297618; x=1707902418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9nw8FLwM9+e+s7KrvfDxVPXnoahsORL5p3+IFpyc9g=;
        b=hR5LxUXBorj8rGgSdnZXGq6hlEUg9K7aFtEhuy9HfPHSi3udxRQ0H/CJYJpTA7m75H
         jjH6kVGYFySCUIuB6PGcEmpuvFNdsjK2LC1YGzbQXujaQXp/lsqjM74ywY/UU2wzE1Y2
         cr5dQvD5nqnQe2iOTb2uSAgXfaHKUajeip9spuH7GeevBhysJ+N/cCueCEg/YRBykZa9
         Px1bc/OGCM3vizMrhv5HzlTRVEPX1+jXlbRxY7IBPz8MGJs8Q8eeyBHjCPiyrwsL6ms0
         HVf5ZVUSPMvOSTRV0UVnXMWVaW66OplMXRGAzWdM0KHu4hfxKpvGSAZiiPepgn+1R1Kj
         iIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297618; x=1707902418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9nw8FLwM9+e+s7KrvfDxVPXnoahsORL5p3+IFpyc9g=;
        b=atW3eU0n6qaffdM39g7pQNm8gQaMSh7R3+ynQN1AOm/LPtecTutO3pK560VCR/zXvW
         m4vgxPRNsWNTjNsGnGaPIm+g8I7RckLNjAlScNTn+Idn7CAnaLsrGxfSCt1+ysgaeq7J
         46rXv1mRdv1poikcGwmpX1uFQWmR4XGN0ajkxj1rWUt9LnhwOKi9GfCwZUqJBaumRqcw
         tTHH6MQI8d8ZMmizF5P1U9jHrXhD9RGG57hDvBpA0iiFkbzDCuM6y0N4CURWZKZrrJA0
         sHo07v3QA+TZB7vAEDVUerNOnsRccXFHBu/KG7avYF+ssa55YtvvQcMH2lAdeGQI/5f1
         KSXw==
X-Forwarded-Encrypted: i=1; AJvYcCXSPBs/dKMPvRgms1SzHA39K+X0+CLbZ3/XwWGsB2TSkmmd8kjp9ajN+j+hTDIGLczCC9f02M6WeZYwLS1PCLT+4F27YgpQZXFhJMdmpaLs+HPcD+zCOlODnsxwI9RANlhjSL2qBQ==
X-Gm-Message-State: AOJu0YyY+fHLcc/OGt0ffihE1mxmEZGod3476RSDqNwwA9rVmtqbC/IS
	50Mtkt0MTy+U4bOxFDQoYkuWSFspZWDln5Dt7idBVRFRS+q+meIl
X-Google-Smtp-Source: AGHT+IGm1C/0MjQjHTso3RY2d6P+CU1Y3RM0zgxuGbHxF2/GU89nwLAY9QSEk3cKpqxsCidS8PHWyQ==
X-Received: by 2002:a17:906:2111:b0:a38:406d:5dd4 with SMTP id 17-20020a170906211100b00a38406d5dd4mr2270445ejt.36.1707297617313;
        Wed, 07 Feb 2024 01:20:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVokPVQt3b2tj7rcQr7p15fYblgdqH8/p7mxgxzNGuTr7Vz0MwVPGq9u95MMNFg6Sdgx5HKtgp26N8wrLv2sIsNNtD9nN7s754k79gKh6TgcP4Rh6HCfIRFxz1oiGcYICJzbCp95LOxO7Yc6qvu0uaoYsMMkjkQRzoiy+o7OvNtaIPhoPc45WupHS3kST9OSV4EbFLnZq5mFeLVzX2fYlgnrBCeEipdU2BL/Yl10s2O5QjtQulPrfTA6FUinlbOLC8chPnfk8lC9CQdpp0nwq2olGhvvHJagdGjTnsgF0PZk/LIQfWZe7kJ9UEX9SvMXWuLXilz4QSr4JvkKQyYm48BmxQZAzZQ12nZKwTrrtX6P6tO0no0V7cXyABg6x1TzBV8RAfhBNE=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906081300b00a367bdce1fcsm535494ejd.64.2024.02.07.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:20:17 -0800 (PST)
Message-ID: <18a89feff869edb9bef6c5d7ffdbc7baadf2cfee.camel@gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Wed, 07 Feb 2024 10:23:36 +0100
In-Reply-To: <CAHp75Vf3vvYHz6pTpAQGEAxV-obWV+0XbhVhaFqYU5JUbtFY8Q@mail.gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	 <20240206-iio-backend-v9-6-df66d159c000@analog.com>
	 <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
	 <f6ed72343be50c358db8e7e36d9afa875f788425.camel@gmail.com>
	 <CAHp75Vf3vvYHz6pTpAQGEAxV-obWV+0XbhVhaFqYU5JUbtFY8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 19:51 +0200, Andy Shevchenko wrote:
> On Tue, Feb 6, 2024 at 6:51=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> > On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->back =3D devm_iio_backend=
_get(&st->spi->dev, NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If not found, don't error =
out as we might have legacy DT
> > > > property */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(st->back))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(st->back) !=3D -E=
NOENT)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->back);
> > >=20
> > > This looks hackish...
> >=20
> > This was suggested by Jonathan so I'm keen in leaving it as-is
>=20
> I think I proposed how to improve it. Jonathan?
>=20

Well, you did change it around so that we have the typical 'if (ret)' patte=
rn.
But, honestly, that is also bringing an arguably useless helper. So, yes,
currently we are not doing the typical "check for errors first" pattern but=
 I do
think that the code is perfectly fine and readable as it is.

It's also already pretty late in the review process of the series and there=
 was
already some back and forth so to me, the above is really a minor detail an=
d I'm
not keen on changing it at this stage (unless Jonathan really feels strong =
about
doing it).

I'll spin a v10 with your dev_err_probe() suggestion later today but at thi=
s
point I would prefer to not have to spin another one (afterwards) unless re=
ally
needed (meaning, not because of minor details).

- Nuno S=C3=A1

