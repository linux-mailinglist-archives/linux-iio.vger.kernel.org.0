Return-Path: <linux-iio+bounces-10262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6499253E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 09:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D218FB21CD2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 07:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A51166310;
	Mon,  7 Oct 2024 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zolx/uh4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2F13792B
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284417; cv=none; b=R+BBe2kxVJdIlQ6XGt2yRqKvTxxvSiyN6fPdCVWWONuiniqGSdfB4pkP+7PsZOAdLvqOC95IMdYRMmRUt56Brr6iid+cj3WopBbBoFWNH3D6towEutG69yJ1fPBVoRJx3+hguAt2r2/SJf0al6UoUvmcpoBc/TpVm4KNth/aMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284417; c=relaxed/simple;
	bh=zATgE7lGXDAfHPAXx2wVXLiJYbpqKrNzx/5xyMndI9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyEu34+pAP3zfi0ZnHhF8R5xlgKtmH+ZOSOlC3awE/YYGj+8+W23tTAaAQkLIdN+k0tB8Ta8W5+Rcg3aa2nQlID+KdQPB2smSieTVp7bAwCNR/ymdYdEnoEdWanQPYydpnbSWFhisKQtuoknD/SCA9iw9AW0Ny6Yl68abDURE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zolx/uh4; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84e9893c457so1253054241.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728284414; x=1728889214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCLqDqcDPlkIv6TQ0OP2914TguL03CqjRYbcPbKcDc0=;
        b=zolx/uh4sLXaKuJgpnOpjOY/E6w9w/Fo3BaJWkc9NKbl1T6N01iswf6BiP/PY9GwCU
         WfsN7Z+cCyJ5JBeffsEPFTJS+kD5d7XecYpHsvqNONpEISFCV2Cxq90S9bBK7LHYr6z5
         OTsLsZpyIb3zoPhILtlfLFrVrBXhDLfrIZThH65R37RyOGTiSlZYjrSyi3Fptp3JKQ4A
         ONnE06dgyY2/OS5xnu3a8alIB9ziigEdEpGEeldZ33Vg2PSfj5prUWBo79auSLN3mc6O
         IfrQemRKHy4ay3daRNoaxR+oFhmLr5l7edXucGmo1MDfjGYUm/dCThVqPQ8F/TZVZmG8
         hI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728284414; x=1728889214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCLqDqcDPlkIv6TQ0OP2914TguL03CqjRYbcPbKcDc0=;
        b=jRI3SViwF25kcR9ABI+w0tms53b0aOb/eOQGj9fmTzghJ9++Ar+ER/A7GSTtiFCbVE
         lS6N30mOdCEFgKPa8dbwsNb/94/xhc0h7tGdOCQj6VJFbMz5kk1xD/y0ODpEgqmIKpJh
         osxWYeRavDLqmYxmN1KAGw00TSkQvjwsvwxdBXz9PNP1tG7yD8LCVwnrgQW5hr7Ca1Wr
         jNzaEX27qC85XljtVa0XJ5gMqKV5zKmJgk471PMYJgkCAgXWtOUruoBOT5ZcNyBCvCJi
         TXzx59ja9qG6/DhmQtvFOO3O8kpmbuGEG8L+fg3eZ1yrQbs9lPNhhr12ncIi0sBHTCr0
         xg0w==
X-Forwarded-Encrypted: i=1; AJvYcCVFM74wu5yD18CFijQZXclKxN0ayacaLXh8ou/oR3rAug+NevT7hsgdf6ra7BdLIZCSEZr+KGo9Uns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj01fW8hTEUY1iOJ25y9Cem7kM8hLTxV/unFxw5Ar+7jeAaso3
	GThBXP8oEsDrqegvfRu9FT935a1k003uC+zcapQ+tbi5qLJc5gvSOmtcw1+xXD5EFcm0jxw+SNF
	wpSID9a1ygIzX/eag4+ussOkW8uVR/6hGstGeEw==
X-Google-Smtp-Source: AGHT+IE94jRfwflznC7KODv2WkD1x23XTJ3wMsge83I47cZId79v2Pt+RgapF1ABmVYunsRuAp+VH6dyXb4vh/y7M30=
X-Received: by 2002:a05:6102:441b:b0:4a3:cc5b:448f with SMTP id
 ada2fe7eead31-4a405748ddbmr5781557137.4.1728284414377; Mon, 07 Oct 2024
 00:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919130444.2100447-1-aardelean@baylibre.com>
 <20240919130444.2100447-9-aardelean@baylibre.com> <CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
 <047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com> <20241001194114.16e0ffa5@jic23-huawei>
 <CA+GgBR_HTwNT6WKdweuuTZ_t+ZmMXrMkYNK+b3pp4f2MmTWzGw@mail.gmail.com>
 <20241004145430.000012f4@Huawei.com> <20241006115643.7b1fd461@jic23-huawei>
In-Reply-To: <20241006115643.7b1fd461@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Mon, 7 Oct 2024 10:00:03 +0300
Message-ID: <CA+GgBR9qGfZ2z8+t6kZEfZQOT_Qf7yFrtzNqztGPJt1wsM-eZw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri, 4 Oct 2024 14:54:30 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Wed, 2 Oct 2024 09:12:09 +0300
> > Alexandru Ardelean <aardelean@baylibre.com> wrote:
> >
> > > On Tue, Oct 1, 2024 at 9:41=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > > >
> > > > On Tue, 1 Oct 2024 08:42:23 -0500
> > > > David Lechner <dlechner@baylibre.com> wrote:
> > > >
> > > > > On 10/1/24 3:26 AM, Alexandru Ardelean wrote:
> > > > > > On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
> > > > > > <aardelean@baylibre.com> wrote:
> > > > > >>
> > > > >
> > > > > ...
> > > > >
> > > > > >> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_=
dev *indio_dev, unsigned int ch,
> > > > > >>         if (ret)
> > > > > >>                 goto error_ret;
> > > > > >>
> > > > > >> -       *val =3D sign_extend32(st->data[ch], 15);
> > > > > >> +       chan =3D &indio_dev->channels[ch + 1];
> > > > > >> +       if (chan->scan_type.sign =3D=3D 'u') {
> > > > > >> +               if (storagebits > 16)
> > > > > >> +                       *val =3D st->data.buf32[ch];
> > > > > >> +               else
> > > > > >> +                       *val =3D st->data.buf16[ch];
> > > > > >> +               return 0;
> > > > > >
> > > > > > Arrggh...
> > > > > > I messed up here.
> > > > > > Guillaume found a bug here, where this should be "goto error_re=
t" or
> > > > > > do an "if ()  {} else {}"
> > > > > > How should we do it here?
> > > > if / else. Goto an error label when it's not an error would be horr=
ible!
> > > > > >
> > > > > > Do we send a fix-patch or send a new series?
> > > > > >
> > > > >
> > > > > Since this patch is already applied, just follow up with another
> > > > > patch with a Fixes: tag.
> > > >
> > > > I sometimes tweak these sort of things if I haven't pushed out
> > > > as togreg yet (or they are really bad!) but in this case I'm not
> > > > 100% sure what the comment is, so I'll just apply a fix on top.
> > > >
> > > > So David is entirely correct in general but by luck of timing
> > > > this time I'll tweak it.
> > > >
> > > > Please check the result in iio.git/testing
> > > > I'll hold off pushing that out as togreg until at least end of
> > > > tomorrow.  One more day o
> > >
> > > The "return 0" needs to be removed in the driver.
> > >
> > >         if (chan->scan_type.sign =3D=3D 'u') {
> > >                 if (storagebits > 16)
> > >                         *val =3D st->data.buf32[ch];
> > >                 else
> > >                         *val =3D st->data.buf16[ch];
> > > -                return 0;
> > Doh!.   Just goes to show why I shouldn't just edit these things.
> > Stupid mistake.  I'll fix when on right machine.
> hopefully now done

Looks good now.
Apologies for the slow reply.

Thanks
Alex

>
> J
> >
> > Jonathan
> >
> > >         } else {
> > >                 if (storagebits > 16)
> > >                         *val =3D sign_extend32(st->data.buf32[ch], 17=
);
> > >                 else
> > >                         *val =3D sign_extend32(st->data.buf16[ch], 15=
);
> > >         }
> > >
> > >
> > >
> > > >
> > > > Jonathan
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > >
> > >
> >
>

