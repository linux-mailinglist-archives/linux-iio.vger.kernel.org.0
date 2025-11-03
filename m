Return-Path: <linux-iio+bounces-25837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C48C2B1E8
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64CD3ACB8E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A92FE571;
	Mon,  3 Nov 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmdC3iGS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980011DF74F
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166571; cv=none; b=IkVZWZMqIGF5Z+W0IvvtFtqAsS+Bdryx4UUMwXr4lTQQsElVZnfoJo/bLYnJC7FLJFF7s1E0de8X2vk3xsQJ6ejEEPiXDqDzjtbmwqjSJQ4LbbJ3dIr0Pm/A3VKB1g/hqYKZvnkJDD0sIb9E+/zCw7AbiOfn5QeaXpfHoswGqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166571; c=relaxed/simple;
	bh=uIwmmWbf5c+njS/FfLR0Rc6VWzmIcFUMhywikgWBWMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUn6L2ZdRtaCATsn5T0cjiRoUIKpvzhWHvMWv8rKWFhdJGzDhDVUlTQwFZAfT8Rcg0y4pJqsX4JXuQxQ8N8T2SCT0LiXTe5d4k2UIMUY5XiJcysLBzGo7bNZpQLQr4ItyWGGOcZTRYGiSmQTx/GJu9bseqCtlfxa4JZKF2/Luk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmdC3iGS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47112a73785so27865175e9.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166568; x=1762771368; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvI/x1vaT0M1lYPuFLpSNzfsdRDGeiwLG/ytatnOCpI=;
        b=jmdC3iGSIqn3CJXeyN6zRUVPqC15KnekUGoVUZ5mNrJQYHOxhv2NcxQTLpdSqn8U+x
         gOzegne/qThr3bIOHwIUn6x1umH72WtmM9nATYKiQV+ApGjps5pvw1VYkCJV4hERkG/y
         DnMD2psX7I6FWpOute1ZGWhZp5kyLoOPdgqJrogeAS57pTFr9kI7yq5Nddc7WNr6PeYv
         2SBrkeL5v3gSheu7WE+wZkyqrlHLC4SL28l6CgdzP5FiAfiiohqvg5XjZn36enpHCWUv
         LxWZVTjI1lh09y2ND8z8xvZWTRZOUAUyTR8hW8B2vlQLczmRRAF43+ZGi/kk6ssEniZ8
         M/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166568; x=1762771368;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvI/x1vaT0M1lYPuFLpSNzfsdRDGeiwLG/ytatnOCpI=;
        b=XgUBmylkAJDC+m3Dl9lXCQFkYHTO1QRNOF9e5EMtR+nagtbX9FILhJOh/ntUmhW8g1
         CUbxeseSv6bj5HUrtKWG8DYuH2fi1cnL4lCFrbcHp1LTEJ4KB0iACFsIlFkAHv5oEauT
         Q8LKApLIvetzSnhG7NkZ10Kd/SvtTeeSCecWmpNU596l2M6yiV6gyLKz/SgaxJUZqbkh
         eEzVOTBQMMI8vv3ZSdEKNkUiiOiXkRgyXZuflNHEMpcSzRoLgztgX6GX9WfsS1JJfpCS
         PZARgOiWQFruQSeDynPCZmRY9TKuSL8lUGQvZC4ZGbvJKV2nN3Hbz5Jk+KOWtSky1FIJ
         h7ew==
X-Forwarded-Encrypted: i=1; AJvYcCVWdVJfR5Dv10wH0VQC9hESQQwTUMBTYmkjE27Jf/fbJerRK4R2gBh9+7mXNSwPS16uAiiYRD/tK3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEDgb2l2zVER6TlOGs7h0yagrlzBjDWqs9tpmHlaZqIIkPp7T
	rrgrKa77tubvsX/3a5uWLwE8Wu1ruR5b4Lj5cmpcrGWD8+pjz5s6CGL5
X-Gm-Gg: ASbGncuYBgqWK4nVso8cRmF0JPQJKBwKCGtIwI3TsDIFEuKa5Rl0uyk2fU2LoubU0wX
	7ozLiT4N9pxJAzc+PXSVH4q0Ish4qXp3HEu2VE272pKOlnBtTfakHEVDM+C+KmrIX+1bjTioCQN
	5wzCBS6S+F8LkiuW14/YMvDuPpnawZ8nfkpjFn8LOPE8du/x9o2xUYugp5LUxtdBwYR8zZB1SaM
	2Z7xkDJfx/Zm4uFH5v61PpuGXTso/1GgL7k4aP4BZ6g6ue+10IPTUsNYobUvWP8pyY5+Icknlel
	bs9BBtU3xSjKsD53HSSuH+6AWJeWOuHSBPD43G4rDoHDG3l6tNPnqSvvilbvvQlj8ltK7Kp9+In
	yh4vN5tf2JfytlGzodt2RvuuJQ23Fr1kP0/n8z9k6BMSGETTohxE8Wg73eV67cssNbE4U/OjUdk
	6Y+vAxtKfJfGK3aYK2Zg8=
X-Google-Smtp-Source: AGHT+IG6mUyUie6cS60nZSS3OeVRXVMBaCXdabekJ8CsGUA1VfT/hup+fBBpR19mXUZjHJGYn2xTPw==
X-Received: by 2002:a05:600c:871a:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-477307c5165mr103889485e9.14.1762166567763;
        Mon, 03 Nov 2025 02:42:47 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c583d91sm148675685e9.17.2025.11.03.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:42:47 -0800 (PST)
Message-ID: <5055dbac56e5535e7595eef7c4378067cf736be5.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 03 Nov 2025 10:43:23 +0000
In-Reply-To: <aQTQtUUQpWY_L5q1@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	 <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
	 <aQS7YIxYH2suDmoS@smile.fi.intel.com>
	 <83da9af88f23bc87c558e220d7d1a32a0d91403d.camel@gmail.com>
	 <aQTQtUUQpWY_L5q1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 17:07 +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 03:00:07PM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2025-10-31 at 15:36 +0200, Andy Shevchenko wrote:
> > > On Fri, Oct 31, 2025 at 12:31:23PM +0000, Nuno S=C3=A1 via B4 Relay w=
rote:
>=20
> ...
>=20
> > > > +	union {
> > > > +		__be16 d16;
> > > > +		u8 d24[3];
> > >=20
> > > Why not __be32 d24; ? Yes, it will require explicit size to be provid=
ed, but at
> > > least it will look consistent with the above. OR u8 d16[2]; ? But the=
n it becomes
> > > simply a u8 buf[3] __aligned...;
> >=20
> > Because I'm just keeping put_unaligned_be24() as before. In fact I'm ju=
st keeping the
> > same type. Sure we could do __be32 and the cpu_to_be32() with a proper =
shift but=20
> > I'm already doing way too much than I signed up for when sending v1 :)
>=20
> I think no shift would be needed.

The shift would be just to discard MSB...

>=20
> > > > +	} __aligned(IIO_DMA_MINALIGN);
> > > > =C2=A0};
>=20
> ...
>=20
> > > > -	ret =3D i2c_master_send(client, (char *)&data, sizeof(data));
> > > > +	ret =3D i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(=
st->d16));
> > >=20
> > > This will add a quite an overhead to the transfer (not that I=C2=B2C =
is super fast,
> > > but rather the processor is going to do _a lot_ of additional work he=
re instead
> > > of doing something more useful.
> >=20
> > No really. This exactly to tell the i2c to not do any bounce buffer if =
the adapter
> > calls i2c_get_dma_safe_msg_buf(). So I would say, it's actually faster.
>=20
> I might have forgotten the implementation of that, but does it hold for t=
he
> controllers (or cases) that never supported DMA?

When the DMA flag is given, it just means i2c_get_dma_safe_msg_buf() will g=
ive the=20
buffer you passed to i2c and does not setup any safe, bounce for you. So, I=
t should
work.

- Nuno S=C3=A1


