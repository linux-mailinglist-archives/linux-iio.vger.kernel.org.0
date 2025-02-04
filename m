Return-Path: <linux-iio+bounces-14969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D73A27389
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EF63A1345
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F861216616;
	Tue,  4 Feb 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im+TqnAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B521660D;
	Tue,  4 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676456; cv=none; b=maEA5NRC5WPMbAK39OWUVn62OdliOGp4mzJ1tTjdxZdFeONhNhFUtUcijBfeKDe/8+AReJBbhEW6I4+yHaK9UtyeHjbBkbF56fz5W/ZJGmJ2rJrVMArHFyY0CGv9+5Wr3OXWQudyzhoxP8d5rNignyPVpu8ErxJr6UFByeruexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676456; c=relaxed/simple;
	bh=DWfZZyNiHrlfTSKF/UZWhyhu1z/qId1iFLKooHKvS2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4U8PPCakvNXAXirroX+PLnXNlKQMop/1+8N3R24q5YDVnI1jArtXzL4aCVKOLNXc0lxDXuV0msL/Pk3iOXQPjMw+tdGMcOZWZuYHlBNfIqDqmcGtDH6bU37MSuCe+ni7obnb8rIXxheyvuBRRARze3tuFGhA5/zKcLhpy4xHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im+TqnAe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5b18d5293aso90185276.0;
        Tue, 04 Feb 2025 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738676453; x=1739281253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClM3trTgrmbKmLvwXodhqkaYvA9BOpUueVIT9cvEspM=;
        b=im+TqnAePWgMVro7UCQJ4E2eRi4OkQih9Nx9DbG3l3e+WW5NB44F/xCe0VXKmOmcWP
         UYYuNg5UKloWnuparlORhydPgqEQ/yOJWcEAG8GHXDb2VIwbWh2hKqLccpieQcc6hS1I
         cVsBOj9ZzB+X0JH5hU1FZllqsstqvsBw9P50wb0WWqlxK/5VkNNFiU4ZMkcob35nq45K
         dCrWk2C15qjG+GFyNEIg3VP+EOJhDnpC7C4oUzb5YQbuchESUjYRZgRdHqOrD5qHIgz1
         EQY3fwxmG/ynkIPfLeabrDURYvkfR/qLWgpvscTxy/OP0BBPdYMw13cmIIbftZT4Dm3u
         YuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738676453; x=1739281253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClM3trTgrmbKmLvwXodhqkaYvA9BOpUueVIT9cvEspM=;
        b=ZW10aNtqg9j70leF3jslCeC+wDbNL2inGago45/HPJOw05wCFWovvdnz699y3zvZ2l
         5rcMF2L5aGd20lxKu5ruArL2OkYnPXaWzC5Zbx330SYFyEEQHMIx+XUWdG8DbjsthEhh
         GBTP9gl9XJtBpmAWXAf8Ks9uApClHyjmwUFtB+VNEv9s0BKwkPzk9C/kOkxVsPKgQm4N
         SInbouVi/q9aMnM1n5dKPWPfK4lM1wUnWzx7K19iamCGMicAYo7vEM6sVFPMq+HMH+ii
         uM55MgMsFFP8VkT5u2ozhDiQU9IZtazELJDwQ7aqO/jnqqRlc5ymMJeX6LRMZyKKoJs4
         IbDg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5rkOEE5+P9O9fN82SIH9L2sGvs7I798iarOICSWVDtMNeyfur9imWOeB+4JPd73PkcX7OboJN/cc12Tx@vger.kernel.org, AJvYcCXjKH1DAKUzUFBXxUbLBUrGIam95SjGOsQ3R5TmQHvZqDHsebjfHSTJNLW1AuGtV+C3Ovtb3YZP1jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBAF33SmKNfTzoF9o5qeqsjopn6JTkzyLQjbI1mOcv7m9nm0E
	/iSP53h3aXPdbCYUR1CK7NN81iSUGBi0ZJXfyc9VlZaCXQGOw04ZfNo9ACFpmesyeCdJMJ2Im5t
	y14rZlG5j9RXfeMClkX2Ht0i74RDXx0LR
X-Gm-Gg: ASbGncszHyEadlOXE4P49bS7MQEDtcjy6DxE4nhBzfTJTVME+wpOlnCRUWC+hiz/KaD
	zqD31yKiOD/JhaXIJKlriQyawP+iTd7rudwJEumnmWpW1DHgreKJUvQMQrzeSluMK9f/NEujT
X-Google-Smtp-Source: AGHT+IGQSkb8yrVXg43IjaZ/x4VRVzF+oV+A6PDQ0N38ImKOiBKWcvv/wEMmUeyD7TYBpCjdjSWbQvQ7MxsKo9yA0P0=
X-Received: by 2002:a05:6902:2483:b0:e5a:9c77:7419 with SMTP id
 3f1490d57ef6-e5b12dc8fb1mr1433477276.0.1738676453282; Tue, 04 Feb 2025
 05:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128120100.205523-1-l.rubusch@gmail.com> <20250201174818.26dcc646@jic23-huawei>
In-Reply-To: <20250201174818.26dcc646@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 4 Feb 2025 14:40:17 +0100
X-Gm-Features: AWEUYZlQ6QCoIAjG8w5y4RG7CuIa4zGJUAeQiTQDSE5BvDRTWz0a4OEhZPDEQj0
Message-ID: <CAFXKEHbuJkG1Ptjz03-ZhfLQB6PuYk47BMKKPTN9mFnXsnF3kw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] iio: accel: adxl345: add interrupt based sensor events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, please find my answers below.

On Sat, Feb 1, 2025 at 6:48=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 28 Jan 2025 12:00:48 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add several interrupt based sensor detection events:
> > - single tap
> > - double tap
> > - free fall
> > - activity
> > - inactivity
> >
> > All the needed parameters for each and methods of adjusting them, and
> > forward a resulting IIO event for each to the IIO channel.
>
> So my main feedback here is to be much more reluctant to add new ABI.
> Anything you add is unused by all existing code and if it is unique
> to a driver probably never going to be used by anyone other than you.
>
> We have a bunch of accelerometers in tree and as they go wrt to events
> this one isn't even particularly complex.  The existing ABI covers
> their events reasonably well so take a look at how they do it.  Often
> it's a case of mapping names for the application of an event (free fall
> detection, activity detection etc) to what what they are actually detecti=
ng.
> Those generalize a lot better across different sensor types.  It's almost
> always a threshold of some type. The tap / double tap are more complex
> but we put quite a lot of effort into coming up with a general
> description a year or so back.  There may new things but most of the
> ABI is already there.
>
Please, understand my patches in "v1" rather as a huge set of questions,
than a proposal of reinventing the IIO ABI :)
My intention is actually not to extend/rewrite the ABI. It rather shows my =
lack
of knowledge combined with the curiosity of how to actually use the
(IIO) APIs for
such implementation. I know this is still tedious, but I'm sure it will bec=
ome
better.

My dilemma was/is the following: I did an initial implementation more simil=
ar
to e.g. ADXL380 for such events, and the sca3000.c for the freefall event.
IMHO the names for the sysfs handles were not at all intuitively mappable t=
o the
fields I liked to operate, such as tap duration, window, latent, etc.
The other alternative I saw, was setting up sysfs myself, IMHO clearer nami=
ng
but actually not really using IIO's event_config/event_value.

Personally, I don't have any preference. If there really is no way to chang=
e
naming of the sysfs handles, then it's probably a question of
documentation. If I
can make it more intuitive for a user who knows the sensor, but not
the internals
of IIO, then I'd prefer to use the names referred and documented in the sen=
sor's
datasheet.

In summary, I see your point. So, I redo this patch set as I did in the ini=
tial
approach to show better what I mean. Probably I'm just using it in a wrong =
way.
Thank you for the feedback so far, I'll try to use it where it still applie=
s.

> >
> > The sensor has further features still not covered:
> > - g-ranges scaled by different ODRs, especially for activity / inactivi=
ty
> >   threshold is not covered so far. There seems to be a particularity wi=
th
> >   the ADXL345 as annotated on some analog FAQ.
> >
> > - Various thinks like low power, sleep mode, etc. are (still) not cover=
ed
> >   here, others (ACDC bit, selftest, etc.) currently are hard coded or n=
ot
> >   covered.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> > Questions:
> > - Do I need a mutex/lock protection as this is the case e.g. in the ADX=
L367
> >   or the ADXL380?
> >   Actually, I understand those cases as protecting access to the state
> >   object by different channels, temperature and accelerometer. I'm unsu=
re
> >   if this is a correct understanding, where for the ADXL345 there shoul=
d
> >   not be any issue. At most, a currently displayed value on sysfs is
> >   (still) not updated. So, IMHO I can rely on the internal protections =
in
> >   regmap no further mutex is needed. Please, can you give me a feedback
> >   here?
>
> If you have an read modify write actions triggered by sysfs writes they
> can race (not serialization between different file writes).
> That's why you tend to need the mutex.
>
This explains it clearly, ty.

> >
> > - FIELD_PREP/FIELD_GET: I'd like to use arrays of enum indexed elements
> >   to allow for more generic function implementation passing just a "typ=
e"
> >   field, e.g. at single tap/double tap or activity/inactivity handling.
> >   When it comes to filtering out bits using FIELD_GET/FIELD_PREP, it sa=
ys
> >   that this enum array element is not "const enough". Is there a
> >   work-around?
> I don't have it to hand but there is a patch set trying to add non
> const versions of these that went to my other email.
>
> For now just carry a local version as we don't want to end up waiting
> for that patch to merge.

I understand. I'll do another implementation approach, I'll see. Good to kn=
ow,
anyway.


> >
> > Lothar Rubusch (12):
> >   iio: accel: adxl345: migrate constants to core
> >   iio: accel: adxl345: reorganize measurement enable
> >   iio: accel: adxl345: add debug register access
> >   iio: accel: adxl345: reorganize irq handler
> >   iio: accel: adxl345: improve access to the interrupt enable register
> >   iio: accel: adxl345: add single tap feature
> >   iio: accel: adxl345: show tap status and direction
> >   iio: accel: adxl345: add double tap feature
> >   iio: accel: adxl345: add double tap suppress bit
> >   iio: accel: adxl345: add freefall feature
> >   iio: accel: adxl345: add activity feature
> >   iio: accel: adxl345: add inactivity feature
> >
> >  drivers/iio/accel/adxl345.h      |   86 ---
> >  drivers/iio/accel/adxl345_core.c | 1150 ++++++++++++++++++++++++++++--
> >  2 files changed, 1099 insertions(+), 137 deletions(-)
> >
>

