Return-Path: <linux-iio+bounces-27433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AACEACDF
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF5930184C2
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8E261B9C;
	Tue, 30 Dec 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJXzKCRJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F023BD1D
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135095; cv=none; b=TWqqK5e76tsIkxzd/iLjbFevLJTDZ9NieSO47EDDm4ZgWfiQ9EYAqmaVeXRGlsSph7TYXQjbL/zzpz627ldhERuFzchpJO9IIQHLdMUB6a17CMQlS37HHyWc7nLOegVXZ2Y79+mJDUwpjbHiba/rnj/bSasUcfGaiRlNzltlDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135095; c=relaxed/simple;
	bh=uwTMxixqDFwJzT/YcES2D247zq5VMSRtvyF8Xzf8XoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfFIwJ6p0D7ELLLhmP58bL88e+LTgfFpEvA9Gtez3vAH3gaWF1aNemX94Y8mxY9RJ8/y+BedASgQS4Ax8p122ZfGX71AuxjXa6bneNPjyJeVkTm60OqGts1LoMkcjl3xQPD+Igq3lqnPVKZMhhBbJaaof/Q+uEnV+30CFY4gc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJXzKCRJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7a6e56193cso1643706966b.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135092; x=1767739892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68m8Et8iKajhcf2vw0RxShvDBILtNM5HyOsc0o5A4aU=;
        b=aJXzKCRJtBV0M1lxsCeXHq6lpVPapEcgNGYfq5S5CVuwKwPV5WNHWml4LH5pYvcu9w
         +WbaQ7wwLazbC1T2ia5ovxAQA3K15GNanije4C5y/DE7gwf2PWkFuLEzTNVscmGR1rqK
         IOV6j92zHpl0P4h68c9cqhBU7oFA/q0fE5hlT7PYfOxpzsnJOKrd+neO3fPhFkLBkqhN
         GXkUgiLRnfmxpKC78HzADRWyw+Wkyk1yefB2wr+wNv4pVAdBreRX+Fi3mviiDnfiyVyy
         rBBalKm0SaiEd/0aq8xHMWXxCLy/oyQgpluqOfP+Aj1d2vVXWlwccHU1CFOoPG8Oueio
         J7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135092; x=1767739892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68m8Et8iKajhcf2vw0RxShvDBILtNM5HyOsc0o5A4aU=;
        b=Ozw/BsE3PP2N71BT9iopDvjrwrEIxc+CfAI4hVMIjYQqw3N/0GQf4/zZTzKb2KR7t3
         BYEUjFFfYXLTzC2Jk/zgqhogP7xElNmj+jj9Q+kpCsCjbYB+J34noDamc+nsPTWv996Y
         j9BFx1clbR++7m9/6OIKuuAB/3aOrCkBva0esqOvsDcOg/nLcvLzh4nc9XJ2YPWWOD7E
         WkAyQay1/dnodx2lAECXEm8DcQflBEKuJNfsuxG6kURSE/AvJHQbjKUMaGRZbEL2y5SQ
         jzwtBsUcYOxaHzSJKMT89Un5K+Lfb93BCNPr1dwYAphXxg8VBGTGpbCNeWIecbAiz9FY
         BzXA==
X-Forwarded-Encrypted: i=1; AJvYcCUtctg09raw8RA6iK6AEgd1zc3IWelVBH6N0X8FE26eXW1jegx/yj4YMvSG2MccTASR337qPt/XoFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfz8vqaFwU92ipDQTObquKJ8iHNoYpv1/BW2kC61+pkuPun5ie
	i12cbxi0lhOOwkXY3DlIi7wKIHQ/QHl5gfA0cTjAPLDBFf3OunXCOSA2GTsP8OgdwikhMn6aWAn
	jJlkFLX0ojSA0bpgLTh226ZZNtwaLh7M=
X-Gm-Gg: AY/fxX7G4508GgrxTBxoyZsnQj129mioaswX+4aysTlZWXSzvNUfyx0bovxzSHvwJaf
	akiUMWA1C3/LNXGuhqgGFB8w9UXG3CeezRyUxzluaKQ4qZ1vNOjGUzLfrXR4AnTP0PpLdAbaY79
	rsrFncVDmDyKhCYcgqZFHeKeJLoVrLzldEOlo7n8SMNmh4umXarMGgPTz7P7p6GZTExtMsP4zy5
	dKCGi6IMJuF25JN/pORcRUjxzG7SwzWYJnoxLGTOdxitvMW8g4x6chhU9Kxr5d3z3GI9GbMtB4W
	d6MnclfQnQeHB94sLot13qbp+dyQyC+xw23GnkJSWtg8IJ6apOUlCO5iPdoP4ZeDHZerQfFtOJo
	qqQyCqGE=
X-Google-Smtp-Source: AGHT+IGbHofExjssXAGtcn+wc7knIPEPN+eZQJGtS+Tq5WPDkgFPiDYqG5GmJg6SsvIDAY3HCfyZd7DjDsutbjsCsqM=
X-Received: by 2002:a17:907:3c87:b0:b76:3476:a83c with SMTP id
 a640c23a62f3a-b80371d7dcbmr3740046166b.40.1767135092087; Tue, 30 Dec 2025
 14:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230203459.28935-1-tomasborquez13@gmail.com> <20251230203459.28935-3-tomasborquez13@gmail.com>
In-Reply-To: <20251230203459.28935-3-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:50:54 +0200
X-Gm-Features: AQt7F2oDnvEMs00d0vVFpiQOazaxtC8s0yeffK8CiV-wS1QSvyv6tMvcpje74j4
Message-ID: <CAHp75Vcr76Z=npXr0pu57oCrgmSWsLO4uB9qKLmmxSKap4R9MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] staging: iio: ad9832: convert to guard(mutex)
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gmai=
l.com> wrote:
>
> Use guard(mutex) for cleaner lock handling and simpler error paths.

...

Don't remember if it was in the previous rounds of review or somewhere
else, but Jonathan (? IIRC) suggestd to use

  ret =3D foo(...);
  if (ret)
   return ret;
  break;
  ...
  return len;

However, this one just duplicates what is already in use. Have you
checked the bloat-o-meter before and after and see if there is any
difference in the compiled object file?

--=20
With Best Regards,
Andy Shevchenko

