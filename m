Return-Path: <linux-iio+bounces-18542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F0A97A51
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510317A61FF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC34298CBD;
	Tue, 22 Apr 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEJFGOlY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25D1E2606;
	Tue, 22 Apr 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360395; cv=none; b=LMapKxnZVXg2DWMoRrFVI54uLj2UHEjhmnXwMLpRIrwZcKyywP5pPQIXNBZeRLTGU/6w9nUNduqr1sil3Q8Dp29BzW6a5niMWXUd13jJepBN/PRDTCU0Ht9yZ8f4Kw/0lkKTHlYTV7S1vyxFzGfOupuMN0mkTMTtfrLnxjim8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360395; c=relaxed/simple;
	bh=sZmHoSGS7tw9nFCBTn4dw+aonqxZqbj8Sfuh4/8H5HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCadQnscrWPTsgKKMQ7B22CM8sxS1e2eCFmXx61P03M9SVOjEVUIdkRhfyvMcBrOv2G632E4zd7FG+Wk9c9ZLzUPyaosLCSLcPpAHCys/VF6EtF7g28ukSue+Ek5eSw/snU+i+RZMQca+W/O1LjC/iUV1Tnk2fDoRLlChhlWc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEJFGOlY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so10278498a12.1;
        Tue, 22 Apr 2025 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745360392; x=1745965192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evpYIJU/iATwAu2nEHd9+zj4m40Dzzq89xrgyo+J/9c=;
        b=MEJFGOlYzb04OR/aSA09u6egmYkw62QZXWC6lx1s4jZ0/m9thpw6GUsPL/7hsOSOyf
         ylydfNrfTwp9csJEHqYFEKlYVxIbbDNCGW23qKIc5svJ0e7ASoRLqt7caoQtOo7VKHwV
         XrAoWkGdTqQztqBrzb1jDf6SN8ImaWE7K4zfOhY7R1HeMRG3EjFE+IzwQk4j7MlShx+q
         mkWp485MAPPyKn/XVmbgp1gkH1fQExtvk938XmFCCcvMMNd5nYymg5xbFVAu50G8AQs3
         AGEMB2zaLkOBT3XK5vyddOptfFzQAFFXguNkj1icNNft9aw9c+ozjEmpHUBHpkN4BCsk
         be0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745360392; x=1745965192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evpYIJU/iATwAu2nEHd9+zj4m40Dzzq89xrgyo+J/9c=;
        b=tvlfe7nlkrmvI8EVQ7fR18W50NmHwXYn0eBxoN1bLDcoURoFQ+cWesjaVaNWVd9+bf
         uQFsmDVT/qNGCupxJkAdub5UpS/XbUbh1psMKaSosDhsIttmKeGGg0tXF6/ho06/IJeg
         ExUEmoKujtgUXx7ryudJmABk1BTcAVM7BWa9fr7PFAbECmBalcRcfIo2oUUPls2ymELk
         GPxK1iX3C+bb8UqtyGs3Q9dWdIO3YIoPr7r491Qu07EqlXHfnu1N5YPVkJao3GUIsqoD
         hTXIkqcc/9ym0tzKUAs2d59WlIwChlS9OsNqWpEykl658BYOdXGlMap9FkMtivdqNEdw
         Ku6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqqM3aMXr0EzOQv3GFkkEym3WLH1FB+hexdErvpx9gOEfcDtUs5nacwTaWq6dyM/yc2Dz3yqvshWU=@vger.kernel.org, AJvYcCX3sXEzuVqzg5AA41KQuBF663+k0cg6FRHkhtCNQbe5r38bSghHuWL3l369Lbu+g72nV1UNUb+AJzsLGPul@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD9FjgYgB+679E14uAX5BHFXYlEvAddIKzGNQcqTaewrrNMGH
	HsMmzZQhnqVOfiQr3brtXyqO4A/U4DWDxs0sC4NUIKCg/iBg8t7RAzy4/PLVSf0YmoI86KeIO3g
	oNqvxIIzNurD51lrcG4fEIAK7K9k=
X-Gm-Gg: ASbGncvTbrBuY2KKNnqKmMxsJSpq8ED/3a8lbsd93pbhmTUTgZlATdSWxCYswFbMMrt
	cGmVcYCP5hsarTkSefupdVZC9ALgTwzW2z3j2ttBP5o/LwXxEQCyBAaiRE9D5iHQq/O7NlZ2R9g
	uHcd2TNGAOtr0jOV+YRyVesw==
X-Google-Smtp-Source: AGHT+IFg1heiLQM8LW9/alQbD5xYL7FAgOuJUEBvGh+slf1RWtYCKXsiBug2uMJWAwpXbjVuHqB9rrwRK7TulalmoDQ=
X-Received: by 2002:a17:907:6e90:b0:ac7:e80a:7fc9 with SMTP id
 a640c23a62f3a-acb74bd59ffmr1599993166b.31.1745360392012; Tue, 22 Apr 2025
 15:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
 <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com> <12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com>
In-Reply-To: <12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:19:15 +0300
X-Gm-Features: ATxdqUEgkLF7optyAlJ9EfmLvinWXROrw_I7D2C317zvmD2gmc_K2N2tY0FnEdE
Message-ID: <CAHp75VcHMTSGRrodixsLDS-xCi8KQJ0MtMSMi7tfATUgd3E5uA@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 4/22/25 3:57 PM, Andy Shevchenko wrote:
> > On Tue, Apr 22, 2025 at 10:28=E2=80=AFPM David Lechner <dlechner@baylib=
re.com> wrote:
> >>
> >> Drop the sensor_data array from struct bmp280_data and replace it usin=
g
> >> local structs in each interrupt handler.
> >>
> >> The sensor_data array in struct bmp280_data is not used to share data
> >> between functions and isn't used for DMA, so there isn't really a need
> >> to have it in the struct. Instead, we can use the struct pattern for
> >> scan data in each interrupt handler. This has the advantage of allowin=
g
> >> us to see the actual layout of each scan buffer for each different typ=
e
> >> of supported sensor. It also avoid juggling values between local
> >
> > of the supported
>
> I think what I wrote is correct grammar. Same as if I would have written
> "each type of sensor". I would not write "each type of the sensor".

Ah, I meant the plural: of the supported sensors. Otherwise are you
talking only about one sensor?

> >> variables and the array which makes the code a bit simpler by avoiding
> >> some extra assignments.
> >>
> >> We can also drop the BME280_NUM_MAX_CHANNELS macro as it is no longer
> >> used.
> >
> > I like this change so much, thanks!
> > But one comment below.
> >
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> >>         /* Pressure calculations */
> >> -       memcpy(&data->sensor_data[offset], &data->buf[3], 3);
> >> -
> >> -       offset +=3D sizeof(s32);
> >> +       memcpy(&buffer.comp_press, &data->buf[3], 3);
> >>
> >>         /* Temperature calculations */
> >> -       memcpy(&data->sensor_data[offset], &data->buf[0], 3);
> >> +       memcpy(&buffer.comp_temp, &data->buf[0], 3);
> >
> > Shouldn't these memcpy():s be get_unaligned_be24()/get_unaligned_le24()=
?
>
> The scan_type.endianness is already defined as IIO_LE, so we must preserv=
e the
> the little-endian order, even on big-endian systems.

Okay. so this should be native, thanks for elaborating this.

--=20
With Best Regards,
Andy Shevchenko

