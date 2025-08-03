Return-Path: <linux-iio+bounces-22228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A4B19506
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9179B1740E5
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E231DF742;
	Sun,  3 Aug 2025 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K79ZU4HD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEF2E36E8
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754250231; cv=none; b=LaOZa5bIrzAF75mcxwAdrtdmjO+aw5tnRtB63Ljh3otrXdFKGVLudzED+XWM1KXs0V4Fxl64ro4RQ4Bx3/ws1r7zXyZOU6gp3Lhonac2WodyUGQky7vD17cL7+XnmW1tmte49l0cmbpaIwO89HHV+6z+Nqbpp7TQ7GbFBysN38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754250231; c=relaxed/simple;
	bh=OpH82yFdhtmELjdW1z0MOIc0TTPJiGbj4NdDadinLmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU/F393UXIM6W7CcOjHJ7aLxlsUBCzpGY7I5qfLWCwWw6URTlVmVyrYeyZbXkwEWpzXtxlAQQoGSZEeK9Y92eltXU1qv+A+py3Bs2qk3luk6/OX5SzfXSnvrh59bw1mF9pzmZR+yIkmnfK+IiHwuIZYaWIJr3QrGsazE9uZNvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K79ZU4HD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so6247841a12.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754250228; x=1754855028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpH82yFdhtmELjdW1z0MOIc0TTPJiGbj4NdDadinLmc=;
        b=K79ZU4HDcpw96XnQx8Uw2ilYLHZ9XmVPxyE35rynO+3AW6/B5ttIETcak2lPgZasW/
         VgRGRKfmeHDJTdGesBPzcSoVa774R9h5Q2PtGInPTi7GuPPx5jCCghqIyuaiF6OweNuZ
         yxd5d2rp+AgLKJOaqC4mizadWIJtKD7bpLtZlzIc4Q/UdmtRtbzY7qo2qL7UTPfbpolP
         65mEbt0UUX+CNTBliAnRP978tLg7LZNmPwJEkFTu1C+PBSXFZ5oiWIr4ySEFy1j6tACf
         nVoZOTwywFmh04AdkwSLpMpVjosazaBsmtyT6+dzC6JpdR3LR/hzW1n+T280QfYacngW
         FHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754250228; x=1754855028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpH82yFdhtmELjdW1z0MOIc0TTPJiGbj4NdDadinLmc=;
        b=iOBkP4EXx5atGVaDh4M0AHoaCeAooZ/fRV+NtCQVGasXmrsj5RNobzBBLm81ifu8o4
         MhTuyNiUNLqdxe3UZGXQy4SChNUuW+cSRkAKWjpMJLgcfrIPTTfh+Q3xucasxvJpi7xf
         ajPFkZLDhAmcEYLChN2dswP8+94hJINp1k0qfD56LTKDa2J9lGy5XeADdvtNg6rqWLAw
         AhjExNfvP7R1N3cYvta66mQz1yVy9E87XTX5AHw7huHn79sdXwDpfcSz84QCWDRtcMex
         9IfUvrbbjmhGSZ9oVdoLIO7Zn+lbq09F4qxFplozIupDVC+HgdQK6dFdUgO2SjOE99vU
         +c7A==
X-Gm-Message-State: AOJu0YyCOpyfh8G+YXL2nihLonDJWPX4W5nbTRr89uHXWxehg1EuSYNO
	qgrkxtYe67Z8jn6zfW5/PFHzLVnOTxoJPkxPBa3xeXGVNQxLwx2mGkGux6k5E1dqbIAES9qLAQT
	AbzBMZHYXvQ6VjG3eFeJZ102M1YyOFjY=
X-Gm-Gg: ASbGncta2QRLkvOB84B14yMaeSwvjnLIVeTpC1Fi8e2VLnsHD0qzRMP79Zfz1m1qdxa
	aAhSIeuF+W7RFcXmGW6RFNHVhLgSCMK6zLsz1Uf1v2phqJAKqN/HMDJFjvi2qGsAbOYMjVW+EVo
	81Vcr+mYneERm3B9Ft6D65c4iG4kXPQUNynYDiWlCDdCt/LFAyWr06b+GzbEa+fTxSLbeQxCfdi
	hNpf3+c2qX/1tRTbrAL
X-Google-Smtp-Source: AGHT+IGUBT9vxR2+o6QSdIqRARf8ohvpiOH2IDwF+aaaQ8LsjOF4P01sdelf3ZOEbYPW5EJghNwEgJjJ8LPDD7HmimI=
X-Received: by 2002:a17:907:9690:b0:ae0:66e8:9ddb with SMTP id
 a640c23a62f3a-af94000dc4bmr887775566b.19.1754250227457; Sun, 03 Aug 2025
 12:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802164436.515988-1-jic23@kernel.org>
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:43:11 +0200
X-Gm-Features: Ac12FXy-j502ljtZtfMukFUQacqqhlFPT8wza91FzUN39QbdQyqzo8K3_3x9pug
Message-ID: <CAHp75Ver=qgkPR_Gao-T-oasBYapd8=hyV_PQ46Fn3wFe8_6cg@mail.gmail.com>
Subject: Re: [PATCH 00/16] IIO: Enable runtime checks on buffers size and related.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost <astrid.rost@axis.com>, 
	=?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Christian Eggers <ChristianEggersceggers@arri.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 6:44=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Main aim here is to switch almost all of the light drivers over to
> iio_push_to_buffers_with_ts() to provide runtime checking that we aren't
> copying from beyond the provided buffers.
>
> A couple of bugs showed up whilst doing these conversions that should be
> back ported (patches 1 and 2).
>
> Various other cases benefit from conversion from arrays to structures
> and putting the temporary storage on the stack. Given these cases are
> a little more complex, they are done as one or more patch per driver.

patches

> The cases that were just a simple change of function call from
> iio_push_to_buffers_with_timestamp() are grouped together in the
> final patch as not much to say about them and if we do a patch per
> driver this and related sets will be unnecessarily long!
>
> If people would prefer I split that up that would be fine.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
with a few nit-picks here and there...


--=20
With Best Regards,
Andy Shevchenko

