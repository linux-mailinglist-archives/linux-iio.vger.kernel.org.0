Return-Path: <linux-iio+bounces-10610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B199F99E27B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704902832F7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905931AB6D4;
	Tue, 15 Oct 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sVls2s/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375F1DD88B
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983465; cv=none; b=WJZjUUOKP04Erd9W5z8InQ+Zuplk2qy+A7YgXeZIL7ti5FMNNfRyk/UlsNDS5rfQ/UbW8AxXzz8MTdZvcD0CNji8FvRaD2TBSJ1Sxu5Nz0YI/vrXGhdLLuFBh0AVMo4bH65mvVmPGfENToC5JEb4LBJKiNVnmlrzWsmYG0Gx5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983465; c=relaxed/simple;
	bh=HmU2U/g1OAAlOudivqA9vY5MRTPns4lodRZU40lGkLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm+x+lMdjGQvmtjuP47sfXfsyiAv9KPC1ZBRT07uD6VxqwOfKpQjkiayPo1F1kOsBk/TTINn9mCZDpL291JxO5Eis6a6jozxQW+rJe5RewyXXISmI3USfjcvEkBwXZssLInQmRH9j8b6ep0z2TTRcjVr4GApeuBWV8tEjOcWnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sVls2s/7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so8715973a12.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728983462; x=1729588262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKYX/X7mBxPp2nsbdWzAtfQtdeIIhxTu5G+abp+bZns=;
        b=sVls2s/7KpP/FDKJSb+knTM6ggR5CrORPbQKP3+PPYjWtFFdRY50a87PxoRUuGg6l4
         A6ywRTDGjEY44xbZYigEs90Fyp2Fz9pDENr0jKdWUrvLJVkXOmslDRnk40Zv7pA65/Dl
         NhDG0Dz7/ngQurUuHGAQYCXyrP2/GTrk4/Py0APKLpPpVKgosFvHpEbOTG3UuWtMatVp
         VZABiV9Lqb4LkAuLPtmsGT7c3kC9x2uI2uD9T7jpnO1fVtMdFNvZNkCsWeVk98EP0aec
         ACkgSuDXS6v+wurXWoQuuixwy4B0jfXSGqoOb4Htyu6en3ZiWMXK05z+4gItUabrPTdo
         iQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983462; x=1729588262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKYX/X7mBxPp2nsbdWzAtfQtdeIIhxTu5G+abp+bZns=;
        b=CMsM5SNVK/E/jXtph0D+/hOp7vhOhZM5RfdyoZfJ5aPZNN6ZsSnuO4JsGfQWENFIbr
         nderM+6OoSv4OPWKiXIZFHln+ha9k8fvCE1/AscQR10v+VZA/NB6vu/ar5ngK4stjw9n
         aZscuBwWq1kPXrsInaQq5QU0rw3lPbHFmlVE9/u/fJ5n3pF0rpgWNh9ynRTgthGylB9i
         QPtV3BmFWeV7GfSvpA9tyvMEvmliNayNWNH7hKSyvbzsiP/hIQ2CwC0W+Fd2yJu4xKLM
         oIX20WvudCqy2GpaYhzsU39B1mz7Fg4YSGaxLVIdlN1+e7dHpjBy0pGjxAdu+xz3EgXB
         4pZw==
X-Forwarded-Encrypted: i=1; AJvYcCV0cv++tg4/gWNPyuEjvNkzA5Wer2OY++O6IbxQxCQEKLHMCpj+kueXQoOC1bj7wf0D5yk5VfV5jgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0At019dr0W3tOsh1Qsq3HErBiM21vhrzEebeVLtqLxPU+eky
	gZMhxIaitn+dfrTruCjYclbZF6dUHKYF6DC3LgVDRia2ZoKzzNwJcIMeeukNIbUoprcJsV93vnX
	2DdoUmEZouNh8nfVBsO7xbsL5FMyvKOQaf3AD+Q==
X-Google-Smtp-Source: AGHT+IGmhwhZFzzcmR6cBoSAtHt5axlbjpP3SJn5Ija0fnp0VR7nDAoptCMqzkDm1+vRBtFUi8OGGMQk2xKXo/DJAwg=
X-Received: by 2002:a17:907:7f1b:b0:a8d:2281:94d9 with SMTP id
 a640c23a62f3a-a99a13ae729mr1930686166b.23.1728983461702; Tue, 15 Oct 2024
 02:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
 <20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
 <v7in5n6ktmu5kfzlndn4eujmk5n66fmft4lvwuvucqbcv5r5hb@etdqvn6ev6nl>
 <20241010192218.12808268@jic23-huawei> <CAEHHSvaGTKFA1mUeONXUQ=aTirVemHWFc_E-i76sQgtQ5_Svtg@mail.gmail.com>
 <20241014193701.40e3785a@jic23-huawei>
In-Reply-To: <20241014193701.40e3785a@jic23-huawei>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 15 Oct 2024 11:10:52 +0200
Message-ID: <CAEHHSvbvGGD=EPjdB+hPoKx3AHjTB8e3f_umLhv83i4=sRJ0Yw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 14 oct. 2024 =C3=A0 20:37, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
>
> On Mon, 14 Oct 2024 11:00:39 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > Le jeu. 10 oct. 2024 =C3=A0 20:22, Jonathan Cameron <jic23@kernel.org> =
a =C3=A9crit :
> > >
> > > On Tue, 8 Oct 2024 09:52:50 +0200
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > > On Mon, Oct 07, 2024 at 05:45:45PM +0200, Julien Stephan wrote:
> > > > > ad7380-4 is the only device from ad738x family that doesn't have =
an
> > > > > internal reference. Moreover its external reference is called REF=
IN in
> > > > > the datasheet while all other use REFIO as an optional external
> > > > > reference. If refio-supply is omitted the internal reference is
> > > > > used.
> > > > >
> > > > > Fix the binding by adding refin-supply and makes it required for
> > > > > ad7380-4 only.
> > > >
> > > > Maybe let's just use refio as refin? Reference-IO fits here well.
> > > > Otherwise you have two supplies for the same.
> > > Whilst it is ugly, the effort this series is going to in order
> > > to paper over a naming mismatch makes me agree with Krzysztof.
> > >
> > > I think adding a comment to the dt-binding would be sensible
> > > though as people might fall into this hole.
> > >
> >
> > Hi Jonathan and Krzysztof,
> >
> > I am currently adding support for another chip to this family
> > (ADAQ4380-4) and it also uses REFIN.. but in another way ad7380-4
> > does..
> > So:
> > - ad7380-4 does not have any internal reference and use a mandatory
> > refin supply as external reference
> > - adaq4380-4 does not have external reference but uses a 3V internal
> > reference derived from a 5V mandatory refin supply
> > - all others (AFAIK) use an optional refio external reference. If
> > omitted, use an internal 2.5V reference.
> >
> > I am not sure using a single refio-supply for all will make things
> > clearer.. What do you think? Should I also send the adaq series now to
> > bring more context? (I wanted feedback on this series first).
> >
>
> Sounds like that context would be useful if you have it more or less
> ready to send anyway.  I don't have particularly strong views on this
> either way.  If we 'fix' the case you have here, old bindings should
> continue to work for the part you are moving over (though no need
> to have them in the dt-bindings file).
>

Hi Jonathan,

Just sent the new series with an RFC tag.


Cheers
Julien

> Jonathan
>
> > Cheers
> > Julien
> >
> > > Other than the missing ret =3D, rest of series looks fine to me
> > >
> > > Jonathan
> > >
> > > >
> > > > Best regards,
> > > > Krzysztof
> > > >
> > >
>

