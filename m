Return-Path: <linux-iio+bounces-18480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15CA95911
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3F3A57F1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80021D3F3;
	Mon, 21 Apr 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9OxXP8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E020F079;
	Mon, 21 Apr 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273514; cv=none; b=gMSjuFTNoe8mRZj0hToEj3x/9D16lD77Xjtn1Ll7C+9Jk3tVkGiWRI+grGU2ZGuk4Ua3/V5nLgk5V+dPghJAciFnLHHhZN6WHJy/dr79hk8ri4cvxYJhZnv20cQEACWMUNuXGICAOJO8HF8I9RqsgxgRPr7iozRAjnPiJu4vSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273514; c=relaxed/simple;
	bh=eTR0ipIBnOeHQgIc/nG7dbbKaaPEgU2dFRmsjRd2eHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umVLVhQRvGPttz/X+rMvgRvZfjVn9lLav5VFgpVDMfMnVJyFAY2ro9GNUO/Fc0Y/qVuuzE4CCQfrYVrbtIAU4IpToCzos9ItOpHrTsIootjMo+HCj/i9zs2ogSuMDemgBPe3BLjoSYhCmWHoUCx/aVxps5iW7/DFe0b9VhkM2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9OxXP8E; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6e01e8f4cdso577723276.2;
        Mon, 21 Apr 2025 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273511; x=1745878311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6oJo33YIPnZF5HafKlw3NEBLjOgmj6M3xKMPgOHy5k=;
        b=U9OxXP8E5W9Xeq8NJXz807i77EAyS0MFMvn/mslRsSSckyOOvLPx3ASaIyZCy574zJ
         dEncv/JnCUTR/wTN4+OfOvIMTud9tgZV5GuhX9D5Au4Rr8bwBdlUqnsAyopP+yy5K2/Z
         stxhukuOdiUCs0DKidyqmQDhi+Ze0vd+td0nZysf61MWq8xDneRPqR0n6DPJJjjJ/Dto
         2nf1Nv5iSGXghiO8mbKEkUcWrIO56iJALzbnoj+4OOUNaZDT58eiXDCJbf65+gLaAYa4
         7Cr6UO8yx69zHRboGYXxzrn8cMyXbtgL1vwNBSaYSdG+nOQ/osa3jvJoDxw3B/maaEIN
         G9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273511; x=1745878311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6oJo33YIPnZF5HafKlw3NEBLjOgmj6M3xKMPgOHy5k=;
        b=aQ8AraEzbdGGLgvYmc2hHfVdxNtGDBsFiVU8CKLq+Gjo/AglbwfiAWWOgmgiqrs7xy
         yjMbuOqvTHNk7x7Ln4hDUaIa1Sv+b41gPc6SFOH63ZohIEY3PpBIUodMx6/vN3Jao+Gt
         npY1hBbTbZXgkAftOu5FlTU3CgbHSjAbIXc1UkguAjJvKdMzs9Rk29mwzGQ2JukDzOqy
         cRadUE9wdhvZu/X7RKxoUK0m/LFfrvozmuUkVUfkK99yntOnhxGNYYHKAyn03hpG8Cj1
         iuInV5j+fVlWkuCWfMa0enmYPnGSq9VGLY1BgHosV8VQCyiyxGv5aPAco7DWS2hOgTlP
         rDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV151wNdNTxl+FIV5oWz82wX6LE9JSgBGPdmNDX49hCeOiw6IxufwvNO2lwL/qNHWCN4PsvhJrmLU/MVkqV@vger.kernel.org, AJvYcCX0FtKQMOjlMlOO33YVy8F0cWsSTclhy090fbOsRyffEjIFUu0KKmltZY/SMsWhcn/G6Amu7Mlvqc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9C/kK59WQ6Niv/upywoMVfFGecGsr3h0x9Au40CWYTHHVxmqs
	CHIP9NnnfVchTXF58rQHWJPSXiSWtZH2f2R/g49zPxgTcvSnkWpaOj3M8y7Xhhnv4fwbbaK9xha
	dfmC9YKmjLs3/P8T649nvZDktAMo=
X-Gm-Gg: ASbGncsnpXGz5Ukh9Ttd9RFnBpjxZ97h92Olx408oHMA6VHiDJvQLPX5gvG22Kd9uml
	5Vu8g4dzpiWBBMkrvovUQv3+LFJIklgF7dJbTkbuLasAORNUdLFswJez1sTUYlFMgmqPJGsHBia
	QlBjBu+FD+k1ppyw8lJYBJSw==
X-Google-Smtp-Source: AGHT+IESd71NguhfhymoMq4InE9Ol04qIYtpO0twVMBU/9swig5QQ28cO6Ro90Ix8k5owUtUgvc/cKvNgHDNF1RwG/Q=
X-Received: by 2002:a05:6902:140b:b0:e5d:f9bc:1ba5 with SMTP id
 3f1490d57ef6-e7297d93485mr7850042276.2.1745273511143; Mon, 21 Apr 2025
 15:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414184245.100280-1-l.rubusch@gmail.com> <20250414184245.100280-10-l.rubusch@gmail.com>
 <20250418193411.406bd974@jic23-huawei> <CAFXKEHary=PcCh3GEEXznJQgcxj54ZmGR0jmzBdpx8ZVtk2_0g@mail.gmail.com>
 <20250421112228.453dfa89@jic23-huawei> <CAFXKEHYsMKHMYoBq7U5n02=0wnVmp0_CUrbvxxFFRLJDayS7Kg@mail.gmail.com>
 <20250421145417.571b862a@jic23-huawei>
In-Reply-To: <20250421145417.571b862a@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 22 Apr 2025 00:11:15 +0200
X-Gm-Features: ATxdqUF5pb30tdLZPub857wg5Z6J1ZR31foxG8h7hw8_JQA9ewlduHCyNG_TKDg
Message-ID: <CAFXKEHbPB6vBf6MRTEoQY13p+EPqSeFMP2uPh46BavXFsXTmag@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:54=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 21 Apr 2025 15:39:33 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > On Mon, Apr 21, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Mon, 21 Apr 2025 00:12:17 +0200
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Happy Easter (again)!
> > > >
> > > > On Fri, Apr 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@ker=
nel.org> wrote:
> > > > >
> > > > > On Mon, 14 Apr 2025 18:42:43 +0000
> > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > >
> > > > > > Add the inactivity feature of the sensor. When activity and ina=
ctivity
> > > > > > are enabled, a link bit will be set linking activity and inacti=
vity
> > > > > > handling. Additionally, the auto-sleep mode will be enabled. Du=
e to the
> > > > > > link bit the sensor is going to auto-sleep when inactivity was
> > > > > > detected.
> > > > > >
> > > > > > Inactivity detection needs a threshold to be configured, and a =
time
> > > > > > after which it will go into inactivity state if measurements un=
der
> > > > > > threshold.
> > > > > >
> > > > > > When a ODR is configured this time for inactivity is adjusted w=
ith a
> > > > > > corresponding reasonable default value, in order to have higher
> > > > > > frequencies and lower inactivity times, and lower sample freque=
ncy but
> > > > > > give more time until inactivity. Both with reasonable upper and=
 lower
> > > > > > boundaries, since many of the sensor's features (e.g. auto-slee=
p) will
> > > > > > need to operate beween 12.5 Hz and 400 Hz. This is a default se=
tting
> > > > > > when actively changing sample frequency, explicitly setting the=
 time
> > > > > > until inactivity will overwrite the default.
> > > > > >
> > > > > > Similarly, setting the g-range will provide a default value for=
 the
> > > > > > activity and inactivity thresholds. Both are implicit defaults,=
 but
> > > > > > equally can be overwritten to be explicitly configured.
> > > > > >
> > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > Hi Lothar,
> > > > >
> > > > > Patches 6-8 look good to me.
> > > > >
> > > > > This runs into a similar issue to the freefall one. I haven't dug=
 into
> > > > > the datasheet but does it report on one channel going inactive, o=
r
> > > > > all being inactive at the same time?  I checked and it is the all
> > > > > case so we should be both on a pseudo channel to describe it righ=
t
> > > > > and reporting IIO_MOD_X_AND_Y_AND_Z not the OR form.
> > > > >
> > > > > Sorry again that I'm only realising this on v6 :(
> > > >
> > > > No problem at all! Sure, I'm still in this phase where counting eve=
ry
> > > > single commit upstream makes my ego greater. On the long run, thoug=
h,
> > > > I guess it's better to build up knowledge and end up with a decent
> > > > implementation quality, than just increasing a commit counter. For =
me
> > > > it's fine. I also hope it's not too annoying for you.
> > > >
> > > > >
> > > > > Difference is for Activity the definition is:
> > > > > "The activity bit is set when acceleration greater than the value
> > > > > stored in the THRESH_ACT register (Address 0x24) is experienced
> > > > > on _any_ participating axis, set by the ACT_INACT_CTL register
> > > > > (Address 0x27)."
> > > > > vs Inactivity:
> > > > > "The inactivity bit is set when acceleration of less than the val=
ue
> > > > > stored in the THRESH_INACT register (Address 0x25) is experienced
> > > > > for more time than is specified in the TIME_INACT
> > > > > register (Address 0x26) on _all_ participating axes, as set by th=
e
> > > > > ACT_INACT_CTL register (Address 0x27). "
> > > > >
> > > > > So all vs any.
> > > > >
> > > >
> > > > I think I  see your point. At least I change here for inactivity, t=
oo,
> > > > to AND'ed axis.
> > > >
> > > > IMHO, if I set OR here, the first axis raising the inactivity will =
put
> > > > the sensor to sleep mode,
> > > > where AND needs all three axis in inactivity state. I'm not sure if
> > > > this works out, I need to verify
> > > > it still with the hardware, for now I'll change this to AND.
> > >
> > > I'd be surprised if it worked differently but indeed good to check!
> > >
> > > >
> > > > > > +
> > > > > > +/**
> > > > > > + * adxl345_set_inact_time_s - Configure inactivity time explic=
itly or by ODR.
> > > > > > + * @st: The sensor state instance.
> > > > > > + * @val_s: A desired time value, between 0 and 255.
> > > > > > + *
> > > > > > + * Inactivity time can be configured between 1 and 255 sec. If=
 a val_s of 0
> > > > > > + * is configured by a user, then a default inactivity time wil=
l be computed.
> > > > > > + *
> > > > > > + * In such case, it should take power consumption into conside=
ration. Thus it
> > > > > > + * shall be shorter for higher frequencies and longer for lowe=
r frequencies.
> > > > > > + * Hence, frequencies above 255 Hz shall default to 10 s and f=
requencies below
> > > > > > + * 10 Hz shall result in 255 s to detect inactivity.
> > > > > > + *
> > > > > > + * The approach simply subtracts the pre-decimal figure of the=
 configured
> > > > > > + * sample frequency from 255 s to compute inactivity time [s].=
 Sub-Hz are thus
> > > > > > + * ignored in this estimation. The recommended ODRs for variou=
s features
> > > > > > + * (activity/inactivity, sleep modes, free fall, etc.) lie bet=
ween 12.5 Hz and
> > > > > > + * 400 Hz, thus higher or lower frequencies will result in the=
 boundary
> > > > > > + * defaults or need to be explicitly specified via val_s.
> > > > > > + *
> > > > > > + * Return: 0 or error value.
> > > > > > + */
> > > > > > +static int adxl345_set_inact_time_s(struct adxl345_state *st, =
u32 val_s)
> > > > > > +{
> > > > > > +     unsigned int max_boundary =3D 255;
> > > > > > +     unsigned int min_boundary =3D 10;
> > > > > > +     unsigned int val =3D min(val_s, max_boundary);
> > > > > > +     enum adxl345_odr odr;
> > > > > > +     unsigned int regval;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (val =3D=3D 0) {
> > > > > > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RA=
TE, &regval);
> > > > > > +             if (ret)
> > > > > > +                     return ret;
> > > > > > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > > > > > +
> > > > > > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > > > > > +                     ? min_boundary : max_boundary - adxl345_o=
dr_tbl[odr][0];
> > > > > > +     }
> > > > > > +
> > > > > > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, v=
al);
> > > > > >  }
> > > > > >
> > > > > >  /* tap */
> > > > > > @@ -837,6 +943,13 @@ static int adxl345_read_event_config(struc=
t iio_dev *indio_dev,
> > > > > >                       if (ret)
> > > > > >                               return ret;
> > > > > >                       return int_en;
> > > > > > +             case IIO_EV_DIR_FALLING:
> > > > > > +                     ret =3D adxl345_is_act_inact_en(st, chan-=
>channel2,
> > > > >
> > > > > Does it makes sense to allow inactivity detection on a subset of =
channels but then
> > > > > report it as XYZ?  I guess it didn't matter when it was and OR, b=
ut if we
> > > > > change to AND as suggested that is going to be misleading.
> > > > >
> > > > > we might have to allow separate enables but report an event as th=
e combination
> > > > > of channels that are enabled X_AND_Y, X_AND_Z etc  I guess we can=
 improve activity
> > > > > channel case as well by doing that with the X_OR_Y etc
> > > > >
> > > >
> > > > Well, initially I guess I only had one enable for inactivity.
> > > >
> > > > This was kind of confusing to me. There is a register to enable
> > > > activity and inactivity on a per axis base [ACT_INACT_CTL, 0x27].
> > >
> > > Agreed this is a slightly odd concept.
> > >
> > > >
> > > > The interrupt event will set a single bit for inactivity or activit=
y
> > > > [INT_SOURCE, 0x30]. In the interrupt handler further one can read o=
ut
> > > > the [ACT_TAP_STATUS, 0x2B], which contains tap and activity
> > > > directions, but no information about inactivity axis.
> > > >
> > > > In summary, for the ADXL345 inactivity can be configured on a per a=
xis
> > > > base, but the event won't tell about the axis that fell into
> > > > inactivity, i.e. the first inactivity is supposed to put the sensor
> > > > into power save (with link bit and power modes set - I think
> > > > inactivity should mainly be seen in the context of their/Analog's
> > > > power save concept). As said before, initially I only provided a
> > > > single "inactivity enable". Then I saw actually I could set and off=
er
> > > > this per axis. I don't know if there are use cases only to observe
> > > > particularly the x-axis for a general power save. Probably rather n=
ot.
> > > >
> > > > So, I agree. But if you don't tell me explicitely to replace per ax=
is
> > > > enables by a single one, I'll probably leave it as is. It implement=
s
> > > > most transparently what the sensor can offer for configuration.
> > >
> > > The snag is what I mentioned for freefall. It becomes very hard to in=
dicate
> > > to userspace what it might expect for the x&y&z cases.  If inactivity=
 requires
> > > them all to be inactive, I think separate enables is going to be real=
ly
> > > tricky to build a consistent ABI around :(
> > >
> > > Some devices we've had in the past have allowed specific configuratio=
n of
> > > and / or for axis combinations. For those we've normally kept clear b=
ecause
> > > the number of combinations gets sill quickly.
> > >
> > > If we don't have a separate channel enable usecase today I think we s=
hould
> > > go ahead with general inactivity / activity (and/or as appropriate) a=
nd
> > > perhaps solve the per axis case if anyone ever cares about it.
> > >
> >
> > Well, I think here we need to distinguish:
> > Activity: would allow per axis enables and events indicate per axis act=
ivity
> > Inactivity: allows per axis enables, but only a generic inactivity indi=
cation
>
> Ah. I had it in my head it was only one set of per axis enables for the t=
wo
> types of event. It's not! So indeed your description is what it should be=
.
>
> >
> > So, also here, what's still missing? When doing it similarly  to my
> > understanding of freefall now, for a v7 of the patches...
> >
> > Activity:
> > - I would leave activity as is (is this ok?)
>
> I think so given the separate enables.
>
> >
> > Inactivity:
> > - I replace single three axis enables by a generic enable, setting and
> > unsetting all three axis for inactivity
> > - I need probably also to provide a similar virtual channel
>
> Is it the same one?  I think so but maybe I've lost track.
>
> > - The axis for this channel are AND'ed
> > - Now, with the virtual channel, usage will be "separate" instead of
> > "shared", which will result in a single enable handle in sysfs
> >
> > Is this a correct understanding of what is +/- missing? Can you agree
> > to the points I listed up, or is something's missing (documentation of
> > course later)?
> Looks good to me!
>

I fixed a v7 together. Eventually, I added a virtual channel for
inactivity and another one for freefall. Pls, let me know if this is
ok. So far it seems to work out perfectly. Now with the '...x&y&z...'
sysfs handle for enabling them. The docs are updated as well.

Best,
L

> Jonathan
>

