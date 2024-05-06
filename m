Return-Path: <linux-iio+bounces-4848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4908BD094
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48B0286AA3
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38094154BF8;
	Mon,  6 May 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vA3nbQRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485C154436
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006681; cv=none; b=NojwyiWGU+6iE6xLtuc7SK842QmusaQ/6z5NBUOwA2EYl8jOqvkCWB7vJvQSPRIZOvgqxFQ+peTczQ8LuBCDuuypF/JEMd6t3Zc4BNk26r0B0jfvtn5xYGvmUdh9l7t8NOGIEhtXEInGGKl/Lgb3w8wZBkbikNLy1bywprq2x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006681; c=relaxed/simple;
	bh=gcmU5KHDsIgDieHwyShq1qbTDOmmXgqU5v7T+celYzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzrVBpbBkwylMEjMbwcyUoV6/u6xIR9UTCGZ3TcrY92Ct+SmnDD5FfpfJR0HQOXm5IMhYSgdAKo3xJ3Hn9dw8o5nEYDd3KanwM9JMQsj9NnyyadoKxyjDxuUJ5WsMOeVejfLGrsFUEUZReRY7c62gguanCmvVGyFyAGLcOFclQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vA3nbQRs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e1fa2ff499so35003721fa.0
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2024 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715006677; x=1715611477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcJFzkfee7mBqZtFVJndFmi3NW8+eQHyeH5MZMzFDxI=;
        b=vA3nbQRsL7ul/HhZjlTMujvouLngKlIbzmiRj4GkQAhhQLeSu7j84+V1XjRQjKqW66
         Twd7Em3bAsarV0bStk9vkrSpEX5CK+AEtRqtZXBC95kc2ANgDVgOL1tQ99DG303LHXe1
         op9tOqk82bh3Aol7qAzdZVihEJHiOxIVMqC1u9y+IY7oEo+fvssLn1zYuRPOj/Fv0dAH
         4QgN6Sv7Eyps0AhUmkmyBuJI89NYmU9x3hlA8jsHb635G24brpSIKkp1mjqsOh5C/tg3
         URXEzZP3+v3JOLhY033M+KGA5HSNNLlKF0OOlLhZfs7R1ndKq+7xlKFs4Re6FFAyyeYI
         Qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006677; x=1715611477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcJFzkfee7mBqZtFVJndFmi3NW8+eQHyeH5MZMzFDxI=;
        b=r4wVl2ZTFNnTT9C+yT2gEFq14vPt9+eqro8YqM25LU+Ka6d/sMaO5IqHwjh9gc7ySW
         dcJPyb0vseI1Xc6zVHaUGLnzgjwaC5qKXT5fl7jCuPbHvxAU2affVldpm6TytAJ+wUGT
         R+k90D94cJ4Bmg3SaDyLUnlkMK30VD4cUhn6JUBpjwa3NwpLKT53NIFXtbhIFu2WqaDl
         0TiEnI8HZ6NwUHj2uQ2X/W1SRQlFAGhcrikXMxQLv+n6SVbqFsSragJCDQMRkMRDm7Yj
         UZXVb3FDwHp5wBvTC/SN5nVtGnE7Y3+AtgcxEtrHWWzE9CSw9gItW+WVue/gOvLMBuTI
         VlEw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+NMq/hsxQNushPAIS57LMIpGqMSBx7LTQS2oU2nqMWyWr3+9X04e5XPF4WJDK6KoeGRaXCrIKnFeQ1dzn3Jf8jMKIyWaLgKp
X-Gm-Message-State: AOJu0YzLkPbxZwyMc6QLTYbXjMVN4o74OQ3B93ICUnaj5eEGkxad7gzM
	WPdFvblnomI8QFDmG63FnMpOH97Z7lrdIbf6RTCP0lwUJt7VaMQVvKxOW3MEBl/dGTkVWs11C1x
	amam7Isfi7bpdlHKlJIZmcnQT3ZAlRyAufsqdDw==
X-Google-Smtp-Source: AGHT+IE6otZjp+HMHatTlAGvUbU2zdhnxAGZpInuyTDX2RS/6+kqsjoHYSazeUt5BLVh+8RqN+znD2lXAFAwZSwfhe8=
X-Received: by 2002:a2e:7312:0:b0:2e1:d95b:3735 with SMTP id
 o18-20020a2e7312000000b002e1d95b3735mr3227506ljc.11.1715006676759; Mon, 06
 May 2024 07:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
 <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
 <a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com> <20240506144616.0b90664b@jic23-huawei>
In-Reply-To: <20240506144616.0b90664b@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 6 May 2024 09:44:25 -0500
Message-ID: <CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for resolution boost
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, Julien is AFK for a bit so I'll try to respond to the non-trivial comm=
ents.

On Mon, May 6, 2024 at 8:46=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 06 May 2024 10:55:46 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:
> > > ad738x chips are able to use an additional 2 bits of resolution when
> > > using oversampling. The 14-bits chips can have up to 16 bits of
> > > resolution and the 16-bits chips can have up to 18 bits of resolution=
.
> > >
> > > In order to dynamically allow to enable/disable the resolution boost
> > > feature, we have to set iio realbits/storagebits to the maximum per c=
hips.
> > > This means that for iio, data will always be on the higher resolution
> > > available, and to cope with that we adjust the iio scale and iio offs=
et
> > > depending on the resolution boost status.
> > >
> > > The available scales can be displayed using the regular _scale_availa=
ble
> > > attributes and can be set by writing the regular _scale attribute.
> > > The available scales depend on the oversampling status.
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > >
> > > ---
> > >
> > > In order to support the resolution boost (additional 2 bits of resolu=
tion)
> > > we need to set realbits/storagebits to the maximum value i.e :
> > >   - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for 16-bits ch=
ips
> > >   - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for 14-bits ch=
ips
> > >
> > > For 14-bits chips this does not have a major impact, but this
> > > has the drawback of forcing 16-bits chip users to always use 32-bits
> > > words in buffers even if they are not using oversampling and resoluti=
on
> > > boost. Is there a better way of implementing this? For example
> > > implementing dynamic scan_type?
> > >
> >
> > Yeah, I don't think it's that bad in this case. But maybe dynamic scan =
types is
> > something we may need at some point yes (or IOW that I would like to se=
e supported
> > :)). We do some ADCs (eg: ad4630) where we use questionably use FW prop=
erties to set
> > a specific operating mode exactly because we have a different data layo=
ut (scan
> > elements) depending on the mode.
>
> Yeah. Fixed scan modes were somewhat of a bad design decision a long time=
 back.
> However, the big advantage is that it got people to think hard about whet=
her it is
> worth supporting low precision modes. For slow devices it very rarely is =
and
> forcing people to make a decision and the advantage we never supported
> low precision on those parts.
>
> Having said that there are good reasons for dynamic resolution changing
> (the main one being the storage case you have here) so I'd be happy to
> see some patches adding it. It might be easier than I've always thought
> to bolt on.
>
> This and inkernel event consumers have been the two significant features
> where I keep expecting it to happen, but every time people decide they re=
ally
> don't care enough to make them work :(
>

Supposing we knew someone willing and able :-) ...

Do you have any specific requirements for how dynamic resolution
changing should work? Any particular sticky points we should watch out
for?

I'm assuming this would just affect the bufferY/*_type attributes,
i.e. if you write a channel scale attribute to change the resolution,
then the scan_type info may change and the bufferY/*_type would need
to be read again.

