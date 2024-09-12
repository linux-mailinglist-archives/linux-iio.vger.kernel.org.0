Return-Path: <linux-iio+bounces-9468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D1976C96
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 16:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8A1F23A49
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63011B654F;
	Thu, 12 Sep 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJBl8BVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B619C552;
	Thu, 12 Sep 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152498; cv=none; b=BfaRhiQvmtQisbJ8AmUN6T8B7qw+zwbXvp57n2K5qT6vG5Om4Kc6swB2kJQ5ZSTDDe69SGOdhVQX6P4I0AIdFewWYu957886N3rc03CSVq0Qxz6sHYYXnXrlkGncvxJmTRqrriGDnyFMLmLygoURpNJ5GROTGSNja5YUPhU2VoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152498; c=relaxed/simple;
	bh=Ng1We531z+ADdZeN339PERoJ+VtYQJlwGsc0+ZO3Jrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKnvLJxL8uHeI/eTYlKZ0MR3R9rDFALU3ke585BghlW69Y+vkHl7o25HvYThQKzLhr3/WnifBwo+npmLzRsInavSrmhrsTB4SKU5K1DvZt+Xvw1k/3RfJ6qR3jl32T8lrW3XP/8wiyZ7g7QfD9Ky1YiRKTpXqrW8/3HcmPAFtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJBl8BVw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so13294591fa.2;
        Thu, 12 Sep 2024 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726152495; x=1726757295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUm0nWPOidfCrggryH30scnyqAxC5irEWmcDPpRUwQc=;
        b=eJBl8BVwdP+y37vJ6dSUDKRSz35PMooMjsKHHZtuSUoTCRMDzxmuJEiyAyp4QlMQSi
         U+vWvgZVDLFBbJGH2kG8E3E/BtYpUhBMGsax1e0Cw0zLL9X0OhdNB+/MsJzrZWM+Qj3Z
         uBKkd4/bMRB31AiY9WnkO+gE65+oYqqVG6krvswG1alLUNJ8P2KYpfSkl5f7+19RA+B3
         Mz9bk8/Qux2ayu3vHXO/Ps8XRz091XRFILveYTsJxx4iBqG6Zum8KZobRW29+Uzp6vQB
         AtYM71HLPrt1kkMNeln8zJ4gm+ySEQk6lprTtPTDXNH7DYIWApt1LyuoGrP23WnqVzn8
         Y5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152495; x=1726757295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUm0nWPOidfCrggryH30scnyqAxC5irEWmcDPpRUwQc=;
        b=HLmpmFf/3aOe5KFBUBqIOfmMH3JVzDI201EMy8yJAIsTkBNJKBl2EDvjRectEDJgvz
         HZYdITHIDVfIwP5BpkFGKrvOqasodJMuSLeGPtKZdU4FmzFwvVtFW8Tk9ilk77Gvnnl8
         eFlXXcWGxg0EqVQxLVykqePfG/aMGehCkUrKuJxqj1x+zQBfEiqEnaYcFd2kOdXZ0WBC
         In1QhVZr5UvVZdXMFF5Z8w062Fuoc/L+2yYN3G212MRBmbcpmMUoFwI+AvRnWctFLan7
         hwpm28bqeF1aUDlZ8tRcCk6LPJhozc/A/J6zVk5ExosZBz1MCg5QpKpLZ1v9rGQJuSZA
         ui5A==
X-Forwarded-Encrypted: i=1; AJvYcCUZaoVMnGiNkmrGrHsOoZMUDH2o6G3WUJMexHfTTbQ4JxALdrq+cquXjUnYsGrAX0npW/EzS+KMi45O@vger.kernel.org, AJvYcCW9RZdOwMogEgXMvliaSDhsicLxZODihHHWoSYaJXQz4W0OaBXXiM96beHQO/sePrQ0JUeGQk+RMAvg@vger.kernel.org, AJvYcCXXaG88TsOn5CCuWCpjrO18JVCrp/5QoFbrg9eHvve4rlylzFt7Ae7v2MaXszsTyODjc9etF1kxOpsijHvG@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYTpyPYPM1L3zQOVLZ3tv4FyIkAFwsaq7wpGDNai5cmHIEmsT
	GHOWoMnfMv+HwVxBLI2hqFsM+vqONgIRd9VLvMvAYpWvrMY0zjRJklp6ARDEb6Fc5vOdZ0V4e2Q
	WcY5ospWh0slVLpFOWPcVavL6API=
X-Google-Smtp-Source: AGHT+IGnv4xxGM66TT0a/GyY0WL54Pjx0jtXuvVU+oyHKxJrlWryaJYczU+VBGx/R916mtU8dat+bdi2BvSNlHmUg6s=
X-Received: by 2002:a2e:b8c7:0:b0:2ef:2b05:2ab3 with SMTP id
 38308e7fff4ca-2f787db726emr17969841fa.10.1726152494707; Thu, 12 Sep 2024
 07:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912121609.13438-1-ramona.nechita@analog.com> <20240912121609.13438-3-ramona.nechita@analog.com>
In-Reply-To: <20240912121609.13438-3-ramona.nechita@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Sep 2024 17:47:37 +0300
Message-ID: <CAHp75VdOjodDaz6J4sWOiT2HHmdXpOPcWeS5kz4e3rB_=gh3xw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in sysfs-bus-iio
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:17=E2=80=AFPM Ramona Alexandra Nechita
<ramona.nechita@analog.com> wrote:
>
> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio.

...

> +What:          /sys/bus/iio/devices/iio:deviceX/filter_type_available
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filte=
r_mode_available
> +KernelVersion: 6.1

I believe I have already commented on this. The commit message keeps
silent about version changes. Why?

> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Reading returns a list with the possible filter modes. Op=
tions
> +               for the attribute:
> +                       * "sinc3"       - The digital sinc3 filter. Moder=
ate 1st conversion time.
> +                   Good noise performance.
> +                       * "sinc4"       - Sinc 4. Excellent noise perform=
ance. Long
> +                       1st conversion time.
> +                       * "sinc5"       - The digital sinc5 filter. Excel=
lent noise performance
> +                       * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st=
 conversion
> +                   time.
> +                       * "sinc3+rej60" - Sinc3 + 60Hz rejection.
> +                       * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st=
 conversion
> +                   time.
> +                       * "sinc3+pf1"   - Sinc3 + device specific Post Fi=
lter 1.
> +                       * "sinc3+pf2"   - Sinc3 + device specific Post Fi=
lter 2.
> +                       * "sinc3+pf3"   - Sinc3 + device specific Post Fi=
lter 3.
> +                       * "sinc3+pf4"   - Sinc3 + device specific Post Fi=
lter 4.

Also, the original file was more verbose for the complex cases, like
"sinc3+pfX", why has this been changed?

--=20
With Best Regards,
Andy Shevchenko

