Return-Path: <linux-iio+bounces-10330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A06994A77
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E5728A6C8
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FA1DED65;
	Tue,  8 Oct 2024 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X96B4HIX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517F1DE890;
	Tue,  8 Oct 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390792; cv=none; b=Zg3M4yXeYDwjspdbAJsmVtQsrLEPG95Q/2p/cYr2vUToFpug24km7x/o8y4BRxEBJoaYU9LG77JObImkhNheP/5gC+CwAw3kmko8KRlRDqfvWhSu7CKm3IYVNXulWcDlphPTWgnaZZJGJIyYOFuiQBnsvsIK7cxKMmGxV3GyEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390792; c=relaxed/simple;
	bh=i5aFXLeJhi97VF25NeRAbiywEu1GSWWwgfZFZYm44JU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ko9Jnxxcf1ZIGmGgck7VyceBYfignkV90iKqXycXTDTA8Tz3WMsawy9LaiuWj8/QcuMOAd5ExQBGyNeFEjWYy8A+Weq476xweGPL+wH3M936cIijD/oTr1x4ahtLaO/ECVRNsxKcDHRvMcU4aN++J9JPPZMiMHW38Hzp2YUk188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X96B4HIX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so5053994f8f.1;
        Tue, 08 Oct 2024 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390789; x=1728995589; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i5aFXLeJhi97VF25NeRAbiywEu1GSWWwgfZFZYm44JU=;
        b=X96B4HIXc9xcXMFcKXgauDJFbTPt/JM+E3cVgUH8InTdAtg72dSo8ohgXzpd41MNUp
         8QmGaLBORWSkG0qfkLiF0P+3/CanFsV64rol8deBHmPpLvkzDYGbDQin2erdgXthfkYk
         c0bzcJQoR4JsDOk01CYmTcalXmR6+a2bA2yGpGSxbnYl2TYBvTF3XMIfZQxJwUH6Nklo
         dEAcpMKjiZgW8Xp5dynp+/27PQuXrdBCbJuW/sjsuziCGWY67KEx0A0UjnDVHyq5ybBI
         HLiWdGeZ+LM7KNKujF067QGkIQTZA0jDX24ezm39DQyXTLbajbG7l/fWAj8MnZ3oB/Lb
         2x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390789; x=1728995589;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5aFXLeJhi97VF25NeRAbiywEu1GSWWwgfZFZYm44JU=;
        b=MNMPPORKedKafkgQ025ennikTQ0xVXL1ZsKFqbgCrcjSygHQgIKs4xUvgzQIdM1vst
         eneI//H1glY4vvEXIta8xV2jT5+If/rGRw4mp7qNY3aMjTjQQyi9hgfpJ9i8g3vzYUhp
         Lgx0d+IbkScI3vCzRO/+qRSM6xhFGYxyt8/Pmz7v/YqtS7yy1URIcAPbCqWU2nT6rkRB
         5mMpC05hZ6ns7WcYGoCRLfTbMciEW0IOMZdKEAAXG3ORGHvQ2cVGWch+4lDOJEJ8sO2+
         N25INivdj4fKlamUX1JSPjvlTq5n1K7oTIfogun390oBf5Uf1xpl5MmoGjQ3zn6SXKoB
         a1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW30BnGI4hZ7gy38XhNVu+F6QJb3WXZbbvfzboz7W9bj1zQSoC4sNUgFMtLgFsMZaUfWAkIWHI1GgqEfw==@vger.kernel.org, AJvYcCWZOE365fVFicWCGuTuqbB+CNOJ/LVzrDOApwNAyUK0t04fcZePV86xloJooj5Vof3eMsAugBrHzW0=@vger.kernel.org, AJvYcCXAGCJl6DQT8FYCjD1xcucUBPnEXJAQUe6h0nV6r9QXB3MQKOLdQvzGjD/pl3BfeYvCICS2N6u0GgrQfNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNCK0Hj4FWlAKD4DIN5lvbHBhvNQNUBkr/fzlASTSpihrnnoc
	zhBoXxrGH2PYIclK1fquYgakCNfoW8izYm/fX7oMgaI7EUHTUw6Cop0DXb+kfAY=
X-Google-Smtp-Source: AGHT+IEeLNN3olYlcDCqSgEErwvb2uX3gPED4kOShUzKkbZJZHDGOwbTEVIYvGwH0rXKRIXEHMIE5A==
X-Received: by 2002:a05:6000:1b8b:b0:37c:c4c0:9b78 with SMTP id ffacd0b85a97d-37d0e8f05e8mr12469328f8f.48.1728390788727;
        Tue, 08 Oct 2024 05:33:08 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7b7e:80b8:b4bb:6d07? (p200300f6ef0227007b7e80b8b4bb6d07.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7b7e:80b8:b4bb:6d07])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99429c8bb9sm406329066b.196.2024.10.08.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:33:08 -0700 (PDT)
Message-ID: <27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman	
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Jonathan
 Cameron	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Paul Cercueil
 <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel
 <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Date: Tue, 08 Oct 2024 14:37:22 +0200
In-Reply-To: <172837459910.12274.5022869861872605261@njaxe.localdomain>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
	 <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
	 <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
	 <172837007815.3337.5869213289160447430@njaxe.localdomain>
	 <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
	 <172837459910.12274.5022869861872605261@njaxe.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 10:03 +0200, Matteo Martelli wrote:
> Quoting Nuno S=C3=A1 (2024-10-08 09:29:14)
> > On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote:
> > > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)
> > > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> > > > > Consumers need to call the read_avail_release_resource after read=
ing
> > > > > the
> > > > > available info. To call the release with info_exists locked, copy=
 the
> > > > > available info from the producer and immediately call its release
> > > > > callback. With this change, users of iio_read_avail_channel_raw()=
 and
> > > > > iio_read_avail_channel_attribute() must free the copied avail inf=
o
> > > > > after
> > > > > calling them.
> > > > >=20
> > > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > > ---
> > > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 64 +++++++++++++++++++++++++++++++++--
> > > > > ----
> > > > > -----
> > > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > > index
> > > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e=
16800
> > > > > 7a44
> > > > > 7ffc0d91
> > > > > 100644
> > > > > --- a/drivers/iio/inkern.c
> > > > > +++ b/drivers/iio/inkern.c
> > > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct
> > > > > iio_channel
> > > > > *chan,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_available(cha=
n->channel, info))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > =C2=A0
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return iio_info->read_avail(chan->indio_dev, chan-
> > > > > >channel,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const int *vals_tmp;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int ret;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan-
> > > > > >channel,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0 &vals_tmp, type, length,
> > > > > info);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret < 0)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > > > GFP_KERNEL);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!*vals)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > > > +
> > > >=20
> > > > Not a big deal but I would likely prefer to avoid yet another copy.=
 If
> > > > I'm
> > > > understanding things correctly, I would rather create an inkern wra=
pper
> > > > API
> > > > like=20
> > > > iio_channel_read_avail_release_resource() - maybe something with a
> > > > smaller
> > > > name :).
> > > > Hence, the lifetime of the data would be only controlled by the pro=
ducer
> > > > of
> > > > it. It
> > > > would also produce a smaller diff (I think). I just find it a bit
> > > > confusing
> > > > that we
> > > > duplicate the data in here and the producer also duplicates it on t=
he -
> > > > > read_avail()
> > > > call. Another advantage I see is that often the available data is i=
ndeed
> > > > const in
> > > > which case no kmemdup_array() is needed at all.
> > >=20
> > >=20
> > > If I understand correctly your suggestion you would leave the inkern
> > > iio_channel_read_avail() untouched, then add a new inkern wrapper,
> > > something
> > > like iio_channel_read_avail_release_resource(), that would call the
> > > producer's
> > > read_avail_release_resource(). The consumer would invoke this new wra=
pper
> > > in
> > > its
> > > own read_avail_release_resource() avoiding the additional copy. The c=
all
> > > stack
> > > would look something like the following:
> > >=20
> > > iio_read_channel_info_avail() {
> > > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_raw=
() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ii=
o_channel_read_avail() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0 iio_format_list();
> > >=20
> > > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_rel=
ease_resource() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
oducer->read_avail_release_resource() {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 kfree();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0 }
> > > }
> >=20
> > Yeah, exactly what came to mind...
> >=20
> > >=20
> > >=20
> > > I was going with the simpler solution you described, but my concern w=
ith
> > > it
> > > was
> > > that the info_exists_lock mutex would be unlocked between a
> > > iio_channel_read_avail()
> > > call and its corresponding iio_channel_read_avail_release_resource() =
call.
> > > To my understanding, this could potentially allow for the device to b=
e
> > > unregistered between the two calls and result in a memleak of the ava=
il
> > > buffer
> > > allocated by the producer.
> > >=20
> > > However, I have been trying to reproduce a similar case by adding a d=
elay
> > > between the consumer->read_avail() and the
> > > consumer->read_avail_release_resources(), and by unbinding the driver
> > > during
> > > that delay, thus with the info_exists_lock mutex unlocked. In this ca=
se
> > > the
> > > driver is not unregistered until the iio_read_channel_info_avail()
> > > function
> > > completes, likely because of some other lock on the sysfs file after =
the
> > > call
> > > of
> > > cdev_device_del() in iio_device_unregister().
> > >=20
> >=20
> > Yes, you need to have some sync point at the kernfs level otherwise we =
could
> > always be handling a sysfs attr while the device is being removed under=
 our
> > feet. But I'm not sure what you're trying to do... IIUC, the problem mi=
ght
> > come
> > if have:
> >=20
> > consumer->read_avail_channel_attribute()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->info_lock()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 producer->kmalloc()
> >=20
> > ...
> > // producer unbound
> > ...
> > consumer->read_avail_release()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> >=20
> > // producer->kmalloc() never get's freed...
> >=20
> > The above is your problem right? And I think it should be a valid one s=
ince
> > between ->read_avail_channel_attribute() and read_avail_release() there=
's
> > nothing preventing the producer from being unregistered...
>=20
> Yes, that's the problem.
>=20
> >=20
> > If I'm not missing nothing one solution would be for the producer to do
> > devm_kmalloc() and devm_kfree() on read_avail() and release_resources()=
 but
> > at
> > that point I'm not sure it's better than what you have since it's odd e=
nough
> > for
> > being missed in reviews...
>=20
> I honestly didn't think of this and it would in fact prevent the
> additional copy. But I agree that it could be missed in new drivers,
> maybe a comment in the iio_info read_avail_release_resource() callback
> declaration would help?
> >=20
At this point I would say whatever you or Jonathan prefer :)

- Nuno S=C3=A1
>=20

