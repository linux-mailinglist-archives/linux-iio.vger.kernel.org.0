Return-Path: <linux-iio+bounces-17670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762ABA7CE23
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D73B1554
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B36205E3F;
	Sun,  6 Apr 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhRB0Rvb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEA28373;
	Sun,  6 Apr 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743946316; cv=none; b=bGSnmB4MvbbeL5lqkhoDDybjbhg2ODC/nBxFkKqwoMP/PQBw4O7pw7R6MHo5svAQJ3RhfaHlVRVO4+25CG3aJ+YpyxzWSB8Bx4+ibac1SSAtdV9mcePYfMt91vXJgklDMuF6XUIBrwrEC/cqsIlfko+MBpewkk3r0L8mg7pOvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743946316; c=relaxed/simple;
	bh=077caTKMc0sF/k2kVwAiY5wgSb5/nHBAklGE+fYG+X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8P81uwMwHSpl9+adtvw3mmXpbD17wy0/gCQo5qx+IT50tqXMBXBCW+q7FghzS1zatGpKZu+o0eSR64hVUCKA6wh5a9nkg6g91HxGCxqccbYbSrxCruyW/FXzbjBzb/ZAw/jtA6kIjRWkQ0t+M2qe6YondoUB9TO3e+UkO423uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhRB0Rvb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fb0f619dso32894435ad.1;
        Sun, 06 Apr 2025 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743946314; x=1744551114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyHVR+vELFDBiZE+c3cqL1wtIZk/YDoGKxfos86ADiI=;
        b=hhRB0RvbmktkeN298/jVmk1dmSq1PjQM8dXW7hu1HgIw5Cu+gMJgbxsgT/5rSvvvzf
         ehQVUrkJHwLfnHXBsOJQm0DZpo4PCYcqxHp3Y5WcptSkOw0m/aGNto9+wlTUs6+PiLBJ
         ZjNBN9gvYQaWmldScmSYym8cEAFxdB8VHd9vk3aqOS1lEZMhkTjGW0aRvoaPmdmWm+iZ
         q4h4Ii3PRmDBHQO3CrNRumzlTNTXGQbRkgFS87ueyP7BgUE/9g9vLL5kgsy5A3976AAH
         f5PIleMBEhVyvLaM+1qdk9Rr/MVq92QQb/Il9808vZgpHsiZ9rCrilCn7KJn7fjIq+wQ
         vHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743946314; x=1744551114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyHVR+vELFDBiZE+c3cqL1wtIZk/YDoGKxfos86ADiI=;
        b=RIQm4gRE/S1e3HzSV6ZQ1XwgdZu+Ca7SlUW/wrfHXeSJDRlL5YxWku4j3femgXs69O
         9sAo6d8auwx1n3OiaZGVRuKYOK3DKyk6PuA1EAPDzdpEN0EfOYJnZQoKnJGO4zvOdGe6
         LEqIVL42cXzUoDjvazPXeb2OePg/UxtZZDmV4AMa5jlTHl+FXWCmd7U/LHecUWR0wOuW
         M35rV6eXncyH0y99WRecUpfkpn0T5bCBp4aWWeONH8yEZx4IrtypqNzGlhE0CBr40Cur
         yWlrIkrkYv4ilursECy6uGfcFCZ+M3K5ys2jWyMV2nchhsohpNpP6AoreywVOStdyn2B
         zAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMWavFVpCtafHF5L8A+lzstrh4469wbUyvI13ZYWLfIHX3irUDJzWSQ5cubvDKCWkKkz8FG6UfYHc7@vger.kernel.org, AJvYcCXS3Pd5eOmTRqrB8YjOq0Y37oxWYH6C68FL5O1pjiEllBbjrnl1EOBwQ/+aSSUCAA0fHLcba3Ta2L+y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc176uqH0vKgrI2BSfe/kF4Dz29CtMQEjyRpJ3WM8+SMWCuDvc
	rs6jD5K9+F+tzQVd7BIVqyTQAOoTOL7ZsgHzpWBM/F6UeXhqPrHsQbQzTWyhGujft2nfbbP/tiW
	hXjhss8fCeoT+PBGkDoN9inzwdf0=
X-Gm-Gg: ASbGncuEOTTxmIiIGZoQLCctx/qDCDFYHJspSFmKRPKMqejAzLsemDNkwZbJCZXQnRg
	C+fW2r5fVkh1g017OZ3IgFkrJQFuypnAXfjUCXWMWQN0uNuJKv+y/bjOHoITaGaDU8bmvqzIbqu
	fERDmBbq++Vu4hcBNfdsy/tEwZu7I=
X-Google-Smtp-Source: AGHT+IEjNSTy5cZROdcttYVWtsoOdaz2axiWjTAgPgRNfCUTqyJa4RAlzKsAoeTRyFeXGLVpxmLc63qTmNQP+/w2GUk=
X-Received: by 2002:a17:903:2ec5:b0:226:3781:379d with SMTP id
 d9443c01a7336-22a8a0a3b6bmr118709895ad.33.1743946314573; Sun, 06 Apr 2025
 06:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-4-gye976@gmail.com>
 <20250404123308.00003d72@huawei.com> <CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
 <20250406122048.3d59c2b5@jic23-huawei> <20250406122628.7511e1b0@jic23-huawei>
In-Reply-To: <20250406122628.7511e1b0@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Sun, 6 Apr 2025 22:31:43 +0900
X-Gm-Features: ATxdqUG6_JLiStXqMciqK2C1YeA_ChVpdD31tVhLpE4p7BpI_zQYLIpNQodPAA0
Message-ID: <CAKbEzntnZ+SJ07An+tD3ByrxqOR0FrJ09bymoUZODM0XXjYFQQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, lars@metafoo.de, gustavograzs@gmail.com, 
	javier.carrasco.cruz@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sun, Apr 6, 2025 at 8:26=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun, 6 Apr 2025 12:20:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sat, 5 Apr 2025 22:47:45 +0900
> > gyeyoung <gye976@gmail.com> wrote:
> >
> > > Hello Jonathan, thank you for the review.
> > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz=
19b b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > > new file mode 100644
> > > > > index 000000000000..6cdfd34be016
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> > > > > @@ -0,0 +1,7 @@
> > > > > +What:                /sys/bus/iio/devices/co2_range
> > > > > +Date:                April 2025
> > > > > +KernelVersion:       6.14
> > > > > +Contact:     Gyeyoung Baek <gye976@gmail.com>
> > > > > +Description:
> > > > > +             Writing a value adjust maximum measurable PPM.
> > > > > +             should be 2000 or 5000.
> > > >
> > > > I haven't checked but assume this also results in a scaling of the
> > > > measure _raw values?  If so the control should be via the standard
> > > > ABI scale.  If you need to be able to establish the range, provide
> > > > the _available for the _raw via the read_avail() callback and setti=
ng
> > > > appropriate bit in info_mask_separate_available
> > > >
> > >
> > > In this device, changing the measurement range does not affect the
> > > unit or scaling.
> > > As far as I know, increasing the range just leads to a decrease in ac=
curacy.
> >
> > That's unusual but fair enough.  hardwaregain is perhaps appropriate
> > as this doesn't really map to calibscale which is the other thing close
> > to this.
> >
> Actually - any idea what the gain is doing?  Is it adjusting a analog
> amplfier, or messing with the integration time (I have little idea
> how these sensors work!)
>
sorry, I'm not affiliated with the vendor,
so I do not have any information other than the datasheet.
And the datasheet doesn't specify any trade-offs related to adjusting the r=
ange.
(only "=C2=B1 (50ppm+3% reading value)" is here)

I think this range setting would be better implemented in
some other way (like module parameter) rather than IIO subsystem.
For now I'll just drop this range setting code..

Regards,
Gyeyoung

