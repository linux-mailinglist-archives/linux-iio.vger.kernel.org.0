Return-Path: <linux-iio+bounces-23553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E0B3D51D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B77C3B0A6A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 20:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7662236FD;
	Sun, 31 Aug 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ezOF9S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7290335C7;
	Sun, 31 Aug 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671354; cv=none; b=CKdvkkkXCZ1vuUsNseSEjsW8MY3rJ6nln9VGQYaabyNaXZ3O4vENR5Cd2hkWTUMQMoLECwHobGdbCPompXCAKpQlMq800PJ1H5Jgtrqy7TrdrRcJGIQyKpg9MJXK/nyAwMtzYof4uG4w3cxnmrvEvcW6yXWBZdtX9+URDvTSIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671354; c=relaxed/simple;
	bh=uoLat+lz2k1bJQDD9PFxBMfp/zaVYhCJqyrGD47m3KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euPnQabzARGRfq7W8mtqg/UazKmu+1ZxZPTOozERLvJpkAITBb+PWzskz1DvCIoRXrUA9pJwr0bPNhbhIvkeIg2wljzJgV0TxKjtymj5kvqoyXi0d+rTjpNBdXPNNvGMP9c/8GkT4JqZoQn8y9fgYbcuRbXNR1RaQMkKeFO1j1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2ezOF9S; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33693226e47so31083401fa.2;
        Sun, 31 Aug 2025 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756671350; x=1757276150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12Lu0LCJZEiW0z5SkJkHAr3ze6gdFivfBpIEj64lyRk=;
        b=G2ezOF9S1WnldRRExyYUPji3F0coXKW1seG2bUxRPBZRNgfq3/tDvE+6zm5pax78ak
         Xl6xTx+7UIg2PjSumoIl5sfyx20tUq4JC8lCw3iRO7BxyVCKYVIX1v0JyeY/8Ty49P3v
         m9r596kRS8PR/qo6nOIVzYlT6jfxkZr8P7b+3S/vjVEFJZXcHWAEAB9lOq56lLkccNSz
         cuTty90xjE5S4P6NAGzM6xjoS0cTCRKwHGtZpRKy+NidfZCemWnyoLreHnM8Bp4FhpdI
         kkNQoeHBq1jV2UqG6jgD08hSxnuZ7WHirDamIpvlpxwDPS2CX67P5/Dyj9Drv7CEj9CN
         vPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756671350; x=1757276150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Lu0LCJZEiW0z5SkJkHAr3ze6gdFivfBpIEj64lyRk=;
        b=l1Z7/tzcQTfUooScax8n+alUt3fG1GtPRbXMmJYm4lpe0el1OqifY8ioq7de6mU+98
         C149cLHBC8hP3ZC3jtV8KBFJDXPemziiC0VrTFG7Tyehh3YZJJ8Fx17RQ7dP8DomnXNa
         zTJN0vJwU4qKiQeCIBWihNLf+v8iySnZLGbDqr7QT6ZM9imugzkHKLGBUUO0buHRX9/G
         j/GzzEU2wvImf1k4fsVuFC+oY7f4FIEiyP9ARJCRUPNd5HC20XK6+zx1F49Jr2oQTrBG
         I3OiPP7KIurvGE+b2nZcFlkVROSfshRL2ACk1Sy7TorNU5eW6b+fUxlZtYOV1KrcaHso
         vnhA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Y6YONtg7gMIp/ozrDAcKeldW4eT5NaYRKvs9kTAm7h4Tchu8QApgt9PZn2OIJX22HtT4TYldVVo=@vger.kernel.org, AJvYcCWQzNAQ++P5QzOw5erJ7GRGUeeedjq10YX+A7QDtiQNG3TewYJmqEFvZ7r+4Z5eTaR3Y7Sf/t4EnyAQvJ/X@vger.kernel.org
X-Gm-Message-State: AOJu0YztYun/C3kkIn6RnHLMMaIrhHAQ8d9ah3QBug7SnT9QrrteDMzM
	jaUbMH6LgeSxit7/KFkapMfVBQo/zQyd1vzQt+A4RRc8VR25e2utH5TyCnzOCyqjpFwzDMvKkZq
	lcJ5umX400VG71YIGBWiytZpRVieVGok=
X-Gm-Gg: ASbGncvl6i3irNysIOxW5S1XDvx0EG6fb1/JJaWPz9ELQUNvKlV9O+CvvnMAXZg+Oma
	xtzs6omRqhpG1E0Lo3cYI+8rR44Te16k3YjRYd42qudr8u39jKzivPqzQN71u8XhD0hW62nqgzi
	y50VX0HlHA5kHnQ5pCPnMhekR1aR0bgzewAkWY4S0en97/xz1KDrPSbjziR3vxvba8M76+Lvvqn
	lofqjjnGptS7r+68Db4JByDJywc5T6GdoGv8BHjQ0DNEKBE9NBv
X-Google-Smtp-Source: AGHT+IFhqr9HScEmVktIqvDaz5RH+zQjrqykoPkiAtmFryQvl1n4GeQt/J7gybcE7FEWMiZMPD/bTvyxyEVAf8ihG7M=
X-Received: by 2002:a2e:b891:0:b0:332:1720:2ec7 with SMTP id
 38308e7fff4ca-336ca5bf530mr11581431fa.0.1756671349418; Sun, 31 Aug 2025
 13:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
 <20250830192538.3b508c5c@jic23-huawei> <CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
 <20250831161149.27547d16@jic23-huawei> <CAE3SzaRncowQSu4DDT6020hBJiJs0GGkNkjzi8CPxJ5kukoFPw@mail.gmail.com>
In-Reply-To: <CAE3SzaRncowQSu4DDT6020hBJiJs0GGkNkjzi8CPxJ5kukoFPw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 1 Sep 2025 01:45:37 +0530
X-Gm-Features: Ac12FXzmUuI4nXZDG0poQDJbHmZrdNI71Xg8RzUkFm0YQeYodiQoZy4f0ZY1XSQ
Message-ID: <CAE3SzaTr5C_NKi56tWhA6qkyVm4mz-vGkpBv8TS=ErkBeHePUg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 1:41=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.co=
m> wrote:
>
> On Sun, Aug 31, 2025 at 8:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 31 Aug 2025 11:09:26 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> >
> > > On Sat, Aug 30, 2025 at 11:55=E2=80=AFPM Jonathan Cameron <jic23@kern=
el.org> wrote:
> > > >
> > > > On Sat, 30 Aug 2025 17:05:00 +0530
> > > > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> These are the functions where I have used it currently.
> static const struct iio_info ltr390_info =3D {
>         .read_raw =3D ltr390_read_raw,----> reads sensor data, scale,
> int_time, samp_frequency from register
>         .write_raw =3D ltr390_write_raw,-------> writes sampling
> frequency, scale, int_time into register.
>         .read_avail =3D ltr390_read_avail, ----------------> no reg read
Update: I have not used pm_runtime_* calls here as there is no
interaction with any register here. In the rest of them I have used it.

Thanks,
Akshay

