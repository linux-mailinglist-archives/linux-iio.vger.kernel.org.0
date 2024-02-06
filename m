Return-Path: <linux-iio+bounces-2269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E356384BC86
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B221287344
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685EAD531;
	Tue,  6 Feb 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLVl94zr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154312E63;
	Tue,  6 Feb 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241874; cv=none; b=J+UMexu8E/yDJJtyVpdTHXWetUCEnWDdNLIOjVOQbnSaGlq68UdpTT3ZfEM0sqyhSAIiWGPTkbqvdOIshbNSQtZXSKsIQqyLNugI7yJ7GIJe1mv4SBBTIl6vZh3d+/r7ZfL6ZuHz1qA++4JUxE3DRvKfxnguXzPO4r/MS5ehDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241874; c=relaxed/simple;
	bh=/XBVrO1xD2Spv47XF1F/7ZHropSIJRZ3ree5L2EXwkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCz0rgZGoODid+wK5zdRfm34fX755NOKTbdKftXcWKvofgz5UbUACrEKMY1MghvJq3C2xP35nhWTOHlFcHPVirtdiU6iB0NuV5Jh5mXjTWbXHLtsVif+KNo3cUrHxOhtrfHabkEM42Laher+vfBQ69ojsK0xvwT7z4TVgeAZaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLVl94zr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a36126ee41eso749969166b.2;
        Tue, 06 Feb 2024 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707241871; x=1707846671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoVf6e25WbGD+ukic3/asA7LxorBexHJtv+/2483s3g=;
        b=hLVl94zrEcqRGCnsqnlDkrLSblxX4DGPRu6VTnsxBO+V23erXP7ok/F5vc+d1bYgH3
         X2uwdZkpbOshM/m5GfhMOMc8x4bGV7xwcZfvjO7kEZV0DJrUNj0GJ7+QYGJRjTLhkwsd
         AqfAGmsznuHlN+1WwmwpecTL8AFUf/lidKO5VH1e50uiZZXtsMTPknjUyIMINkgB/a26
         TfpjPt8hi+jf5xDUlV4OJohR5RZx4fiN58HEHGV9R8s+JHdS8vErnqVTVoWcD3H0f8uG
         S2GSpBBQnbZZZTZJB+pRu/tqFuORfnxWsc1yDAhP1llFe+YA8L96I8Cjoy8XOGhrtBjE
         b9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241871; x=1707846671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoVf6e25WbGD+ukic3/asA7LxorBexHJtv+/2483s3g=;
        b=sQB0QlVx2PA4rGyiyl9FKB77xzdgp7QSnqVBMN3yLvnvcDwtcwtEXHaKZ6Yt7+xL+F
         HQNSMH1kTBxaSDC2kR86vqd510s/dx/QidLlGpuEMk07Qx5KnwOYLBh4Q+KFH+PFYMk1
         +hQHm6zPLoWkVBXD9wdIaNTEFXK9nBoFqFlEc2Z4WEcuvJQnYFZad5Rkmuk8S/ydl01D
         tdx3kPOqdTUqff+DB4Cd/EbhOTLvVkRDVZ7gL82sj7gMdnT7R6HJT/6NG9/t7cu/2sAB
         /iVKT1PplijAidZNRvYEM6IjUnDs7iOJm6rhG5GsEHim+KzOCJRsbiMzZi/GSAzc/Uwu
         QrXw==
X-Gm-Message-State: AOJu0Yy8JKRGKecNPt774f8YKxYQa8+Zi9UpvyjDHIjsQw6uZIVB0sza
	W4bzZ6SpG0soGhuhS8us10+Ji8f9aFKIqWom0iF40+6Cpdr/d7qyKZlvh4BnEcomWoaSFCRHYmV
	W+Wqz2BVxSdgVplkfDLHfqNJoTUw=
X-Google-Smtp-Source: AGHT+IHnp67a8rSjkSThzushnaauZPdd1+McrQ3DIzSPiTpprltoypThT0uIbWSMCgCQg+Q76faUZcdEZAKjcT0Saqk=
X-Received: by 2002:a17:906:a184:b0:a37:4c04:a472 with SMTP id
 s4-20020a170906a18400b00a374c04a472mr2164451ejy.18.1707241870323; Tue, 06 Feb
 2024 09:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
 <20240206-iio-backend-v9-6-df66d159c000@analog.com> <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
 <CAHp75Ve=Utqb0rtuO9c7xkxqpasFgzj4x4d4mm-CHM=_XJUrrQ@mail.gmail.com> <8d7d33a633f258389adba39930769d577a05cab2.camel@gmail.com>
In-Reply-To: <8d7d33a633f258389adba39930769d577a05cab2.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 19:50:33 +0200
Message-ID: <CAHp75Veb2TWQQzw=8q+u4YiPX7Q5j8216WL=HaqY1eO_JjPj9w@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 6, 2024 at 4:20=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > > -               .max_rate =3D 250000000UL,
> > >
> > > > -               .max_rate =3D 500000000UL,
> > >
> > > > -               .max_rate =3D 125000000UL,
> >
> > Forget to comment that these might be preliminary converted to use
> > multipliers from units.h...
> >
>
> Note this is just a conversion and I want to change the least possible. I=
 can do that
> in a follow up patch.

Yes, that's the idea.

--=20
With Best Regards,
Andy Shevchenko

