Return-Path: <linux-iio+bounces-21789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4032B0B7CD
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3B67A42D1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D251F181F;
	Sun, 20 Jul 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoTYM1pr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EE382;
	Sun, 20 Jul 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037427; cv=none; b=VNKsK/F4qwircQC1vbxhNDqCtkyJDfJuG+fvP0YOIpwUGflm0Cce/VFxqC1KqpgWR6DXQIP8yfqAveRXlfX+KTalMnrxou3nynxjbE7DvDg2+O64DM2xgpotPfnKsl+JskkzRd3zfU3A/Z+5VlWSm4WlGvfYTZ1IRXIPhkPUN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037427; c=relaxed/simple;
	bh=w6KP4M19R0S1kKUIBWkQBmHQAqBJGN4yegkkLZaODII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lExN7OMiKRIBGoVGJDju7B5KFs8SUXly6WyFyg+P98s5tqs57xp+ZeJVPfp2p8aJ3PMXFAc1HjtYvKzvVmDcnlrFevBPKAEP8HANmrNhaURsC33hhnMzjcde/io4nSiiF75dLBcdhip7sOXzmixAFt6ZhYsZ3adc3nV6CIvNC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoTYM1pr; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bb867ac78so372661276.0;
        Sun, 20 Jul 2025 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753037425; x=1753642225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn9SLuFGmitp9BvlucUTu3HHbVjGTQvf3Kb6WKYE6hU=;
        b=GoTYM1prYd7ZHMexPzZh1Up+IlzQjRzuWPXTyf+KOp6qfY/x0aPyJ4XzUsD051eR46
         EpPnNSdIa2f6fQcoEFby8wXfdwQCiZzpRZgiM1TcuS1NOrNEGAaG5jzsMcfmPgPP+ol7
         2a1+AGJSe8NS9FDA9ZzKiDeDZvpPZozC6LMBv2IoiO/gaj5bFkJT17FIqcdlQ/tp7ByD
         g8a+6dvvck7ul/ZTYLrbkhOaGzlVJo2rsqzSgTX/X2rOvHg07Qd1piUKeF/KZbzldWJq
         riaExUG3y0pfvfL6HRaRnUAxICr/wY10dL0LzB7B7sWJcRmf/39q1/nRKthBFvEuNhl6
         +Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753037425; x=1753642225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn9SLuFGmitp9BvlucUTu3HHbVjGTQvf3Kb6WKYE6hU=;
        b=douqpiKm/eryqapkJfcH8aL66sbyzd6evxVnWQMvrkz21xBXmpib17p/A7swN3VtII
         tr/9Tg+a2FBUCLCr1BbfBJkA0Y4nRNxlnIr5bKEhiJmm8zukUH5W2fa8mE/pt3Hu8J/F
         Qc+S9/mBYS4XaVwodS9VCW4I1B7HDBgTia38VnE4pFisdLd+S6SHH/EuwrvetkmJJTCi
         SHyqkDgJVC6+1We9edzB7anOVA3+vUqOk/UMg0H3rJ5YDV81lQkGIwRU/faQokjBF0B9
         1Q9mhoZfit39qdEDRcSoehag1VwCcL5rVVclAzeZAa/Ezx81D3Lwn2/1nbdBCLoVnFIz
         SVqg==
X-Forwarded-Encrypted: i=1; AJvYcCURddeeBJC7ZkcNfspJA/iW/reBainysZCi1BrJjgUV63slWh2H7qf7v5RhBLJDAqy+UCehH6zYaUc=@vger.kernel.org, AJvYcCVbx/gmIYuTtqreMzrYJoDQ5sIwFAAdE8/0yJ1wQ6T44iEw8+F491zgg/p6vybfTkuZAv89qftcGMY5@vger.kernel.org, AJvYcCXl6OO9EXA59j41h6CwvaQO3XSluur4hyPD7CrVg3BKxpIxBiCnYzbKeevfxt8yr5GlCQyyqddRkFM2PzNf@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJuel5P+ztzpPioBDqV/X+VlGRSJM20qejNhwE2Z/Ljj+NJi6
	TCyeBBwT8XcLD1nCy2Wwd8w/1nVUHKgB8iR7JxKIfhjeEmVy1o/LreL4SaemMcnDuOpHO+QgVB4
	3Je1biezFV30GU9/Rmg9Jube3oYhDErM=
X-Gm-Gg: ASbGnctd839Wk3fWiG/Pyh9jUewxITmv9gBlEFSG9n0IhHAN7V9K9PLOL6j8RymohB5
	6o4X3mU0Xqy8EV4mRWK6JFuhS1NgVg2n+HyPg0Qdkoa2vrlFq35yfmY0RCOreDAIKx1tpbNJmwF
	BLlImk95AcP94LWjCM7C+kXrzgUPkO99D9MdLQ36OilLzrBYpSrGs2PNTVXMkFBWNqLqM0j8U1f
	yIY/OY=
X-Google-Smtp-Source: AGHT+IHdPRUyZA/x9dvBYJSWQrxWHjoyseFbAjjyswLRXyfQ4x6txtrTjTfOwyBWADYy7cyV0sIb4rmeKz4IquBazgM=
X-Received: by 2002:a81:a808:0:b0:718:3b54:6b78 with SMTP id
 00721157ae682-7183b54af4cmr88446257b3.4.1753037424773; Sun, 20 Jul 2025
 11:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230315.19297-1-l.rubusch@gmail.com> <20250702230315.19297-9-l.rubusch@gmail.com>
 <20250706171611.7b4ae1a1@jic23-huawei>
In-Reply-To: <20250706171611.7b4ae1a1@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 20 Jul 2025 20:49:48 +0200
X-Gm-Features: Ac12FXzBcnqd78UKdnaBsnXCJZ7qBFpIhNONOQuDMZK4OYbIxPuhkhlIhlg-lig
Message-ID: <CAFXKEHa4M-Tp-y4dvNeWgYtUGo_ymyS7kqGbkhf+NJnmrrRxqg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] docs: iio: describe inactivity and free-fall
 detection on the ADXL345
To: Jonathan Cameron <jic23@kernel.org>
Cc: eraretuya@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jul 6, 2025 at 6:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed,  2 Jul 2025 23:03:15 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Describe the inactivity detection additionally using the free-fall
> > register. Due to the controversial discussions on the mailing list, thi=
s
> > section of the documentation will be committed separately to allow for =
a
> > more focused and detailed elaboration of the topic.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  Documentation/iio/adxl345.rst | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.=
rst
> > index 8ee01b8b87f4..c5525267ea12 100644
> > --- a/Documentation/iio/adxl345.rst
> > +++ b/Documentation/iio/adxl345.rst
> > @@ -150,6 +150,31 @@ functions, so that one follows the other. The auto=
-sleep function puts the
> >  sensor into sleep mode when inactivity is detected, reducing power con=
sumption
> >  to the sub-12.5=E2=80=AFHz rate.
> >
> > +The inactivity time is configurable between 1 and 255 seconds. In addi=
tion to
> > +inactivity detection, the sensor also supports free-fall detection, wh=
ich, from
> > +the IIO perspective, is treated as a fall in magnitude across all axes=
. In
> > +sensor terms, free-fall is defined using an inactivity period ranging =
from 0.000
> > +to 1.000 seconds.
> > +
> > +The driver behaves as follows:
> > +* If the configured inactivity period is 1 second or more, the driver =
uses the
> > +  sensor's inactivity register. This allows the event to be linked wit=
h
> > +  activity detection, use auto-sleep, and be either AC- or DC-coupled.
> > +
> > +* If the inactivity period is less than 1 second, the event is treated=
 as plain
> > +  inactivity or free-fall detection. In this case, auto-sleep and coup=
ling
> > +  (AC/DC) are not applied.
> > +
> > +* If an inactivity time of 0 seconds is configured, the driver selects=
 a
> > +  heuristically determined default period (greater than 1 second) to o=
ptimize
> > +  power consumption. This also uses the inactivity register.
> > +
> > +Note: It is recommended to use the activity, inactivity, or free-fall =
registers
> > +when operating with an ODR between 12.5=E2=80=AFHz and 400=E2=80=AFHz.
>
> This seems a tiny bit backwards.   It is recommend that the activity, ina=
ctivity or
> free-fall registers are only used when operating with an ODR...
>

Ehm, Doesn't the sensor always have an ODR? The real question is which
ODR should be configured. There are recommendations for specific
features. I may have either misunderstood or misdocumented this part.

> As currently written it seems to be recommending that if you want those s=
ampling
> frequencies you should also enable one of these detectors.
>

Ah, no. The other way around, when someone wants one of events
detected, the recommended frequencies should be used. I'll have a look
at it.

> Reminds me of the classic London underground sign that said "Dogs must be
> carried." which raised the question of how people with out dogs were mean=
t to travel.
>
> Otherwise this new section looks good to me.  Thanks,
>
> Jonathan
>...

Best,
Lothar

