Return-Path: <linux-iio+bounces-16783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA65A5FC25
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC107AB695
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5526A0B9;
	Thu, 13 Mar 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeHioJ2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74626138E;
	Thu, 13 Mar 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883996; cv=none; b=px7/ELaa+f5qVt1Jd28m7KmITlILmzPu2DgrB/LaKg0SFbNElH2agsrPsNKKgaUie4EG1FCQeVwsaMhkPFfJWytddsArGgM30J3IcChrSs0CeJzeafZ/66HDaYcCrjJI7KmD7tksvGErsS+eSQsRNiEr+keG+nhLBkBj0K78+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883996; c=relaxed/simple;
	bh=kTTXTVPn8NUHqRiIZEKZXhYTmuz1K7M32fm2acNDAS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAVrtPbaH5P5lO4eFcPtuNhTk+IgYgglFjgrdIYRAb3TVaHDkO+BeeEJaMjcgCPfNRuEfOBgpqhe2K984KT2WvjaiHZQ5H2cX9rg8MnalLV1b/KWm4eBR+y9sYLI8R/w6rDoOpdg/UmPB9bkupMFmt+DrtMI5YgOyZNrV0MiSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeHioJ2u; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e636caf2aa4so145329276.0;
        Thu, 13 Mar 2025 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883993; x=1742488793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpMfEfEeQMMLUbXgHwTtp/6maKEVU/1Ktyh/Yj20O60=;
        b=IeHioJ2uXukzcrdQb+j6lPKHDh2aEA8BlYXLG/xHJuvgMwb9DHef2JMLrquvtiNXTw
         hMepzkA1uKHyFnbqlqrjt+vUGt9uNp0uljnsGXQNiz82oRSG6Gcido2My9L42SDJPUP3
         ffDI5VKfY/8OSRdTgPsS5vhoWyOL2uMN7/YgdA787a4O+0FtIHOUKHMLTOLEEdEEBm7J
         kSRlfliIsJXKjz8z+aBDk0EtXRLZ0Hw/dqeFmMfjc49z/EWEGTFrigsA9HcQjACJNwWg
         GytqyB8LRpm5ASWJKg/se6oTWFPPL7tcWplFSu/2BaBb+H1KHCOW3edbxOqtXwW5OrYE
         rUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883993; x=1742488793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpMfEfEeQMMLUbXgHwTtp/6maKEVU/1Ktyh/Yj20O60=;
        b=fjdoQRdwe8Jiet8JCOCPsJi9LAIBbIIaEeQjJ1ypVGOpmrZu7hFlzXiDXClzzzJOTp
         rEnQh8pGFyvbSZ4K7wqPM18/psrJ2vLicXGJXDZK5Rz7LEZhyFmO7NVZFXkHg1Atd6co
         rnFrP82NM/sh93Y4IXyfpdp7SywPD53iWdwLhSQBK2QeprEnq4C1iIhcK8lLz11De0OD
         7WODRGozLtHj8LKA/mGYJtOpkPMj+ov8o2tvcam31YaBbRCpq5deGYcPN80auAsKpJEw
         4myox3QJFhIrYHVCUJyRBAL3WqwxFj8LOQJ8JQk/N4chQ1V9najWpcsa2/DhVp+hEi38
         aemw==
X-Forwarded-Encrypted: i=1; AJvYcCXDAMWtzCN/+XYbgpBl4EciOMLKZ3JobvYVLXk9CsrU5DyrskILUNabNTNV5poM7ygGii/qTAGvpmA=@vger.kernel.org, AJvYcCXlDw9fGELF7YMSwOWuh36Ds0pQe8XdYioGcHy9hbt8i+JvKODAqE9D1ujPnm6fcvxzirRv0ufH0mq2VZJG@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJ+3WFTf1r4/PVdsd8dUi4BBSmeCOcJXOVjKlK5l0w8GRWWTk
	rf0Tl3OmhiQdtogUWn7Vrevok0BLZJs07Njf+V8rmd1rGpn5daZhQMIhCKc7lpOOR5XxFJHnitz
	n1332tIowHrShOhtT4QapwGlP4bg=
X-Gm-Gg: ASbGncviMhnYHCEdWQCxr1NDVddDAnDAyWBOdEksVxFE0YEwIyjdmBxygz9M+hXXFXd
	7kJvS752qt9wYb46yQ27uBSt1Fgw0RWucFKQnVuatHtuFrzMOCSEd/RXbYCM21utuQ+/LzDnLJk
	AMhS4eqACoclC3F62T9CxYmSec6Q==
X-Google-Smtp-Source: AGHT+IE0krfPf6hIkHHa9rxku57tVFK/Jsev9YJhQ/qB/W7cUa2X/VyX9hKtLNC3J8STcZ0V+ZQH+EROE85gYb/9xPw=
X-Received: by 2002:a05:6902:1701:b0:e60:974f:a03e with SMTP id
 3f1490d57ef6-e63b51eb164mr7277937276.6.1741883993426; Thu, 13 Mar 2025
 09:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-15-l.rubusch@gmail.com>
 <20250304135917.39ef0071@jic23-huawei>
In-Reply-To: <20250304135917.39ef0071@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 13 Mar 2025 17:39:17 +0100
X-Gm-Features: AQ5f1JqDvQ9suFRK-JOPQEi1z8ToTfC5DsNr_wSDRZtRwddfjEHdw75T_MnVYYI
Message-ID: <CAFXKEHZDo=AYFswbM48T7syNzk03rPa0PbLceh3C_HPUkKKxQw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] iio: accel: adxl345: add coupling detection for activity/inactivity
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:59=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 20 Feb 2025 10:42:33 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add coupling activity/inactivity detection by the AC/DC bit. This is an
> > addititional enhancement for the detection of activity states and
> > completes the activity / inactivity feature of the ADXL345.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > @@ -337,6 +356,69 @@ static int adxl345_write_act_axis(struct adxl345_s=
tate *st,
> >       return 0;
> >  }
> >
> > +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> > +                                enum adxl345_activity_type type, bool =
*ac)
> > +{
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regv=
al);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (type =3D=3D ADXL345_ACTIVITY)
> > +             *ac =3D (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval) > 0)=
 ? true : false;
> > +     else
> > +             *ac =3D (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval) > =
0) ? true : false;
> > +
> Why the ternaries?
>                 *ac =3D FIELD_GET() > 0;
> is a boolean right hand side anyway.
>
> > +     return 0;
> > +}
> > +
> > +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> > +                                 enum adxl345_activity_type type, bool=
 ac)
> > +{
> > +     unsigned int act_inact_ac =3D ac ? 0xff : 0x00;
> > +
> > +     /*
> > +      * A setting of 0 selects dc-coupled operation, and a setting of =
1
> false and true rather than 0 / 1?

I don't see where "false" and "true" here has an advantage over 0 and
1, since the text speaks
about setting a bit to 1 or 0. Anyway I changed this in v4.

BTW. in v4 I re-added the comments about the channels for /* single
tap */ and /* double tap */ although this is possible to see from the
iio channel. Since I add comments for freefall, for activity, etc. it
looked cleaner to me, if definitely not ok, let me know please.

> > +      * enables ac-coupled operation. In dc-coupled operation, the cur=
rent
> > +      * acceleration magnitude is compared directly with
> > +      * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to determi=
ne
> > +      * whether activity or inactivity is detected.
> ...
> >  static int adxl345_is_act_inact_en(struct adxl345_state *st,
> >                                  enum adxl345_activity_type type, bool =
*en)
> >  {
> > @@ -695,6 +777,11 @@ static int adxl345_set_odr(struct adxl345_state *s=
t, enum adxl345_odr odr)
> >       if (ret)
> >               return ret;
> >
> > +     /* update inactivity time by ODR */
> > +     ret =3D adxl345_set_inact_time_s(st, 0);
> > +     if (ret)
> > +             return ret;
> > +
> >       return 0;
>
> return adxl345_set_inact_time_s()
>
> >  }
> >
> > @@ -718,14 +805,54 @@ static int adxl345_find_range(struct adxl345_stat=
e *st, int val, int val2,
> >
> >  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_ra=
nge range)
> >  {
> > +     unsigned int act_threshold, inact_threshold;
> > +     unsigned int range_old;
> > +     unsigned int regval;
> >       int ret;
> >
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval)=
;
> > +     if (ret)
> > +             return ret;
> > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > +                       &act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> > +                       &inact_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> >                                ADXL345_DATA_FORMAT_RANGE,
> >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, ra=
nge));
> >       if (ret)
> >               return ret;
> >
> > +     act_threshold =3D act_threshold
> > +             * adxl345_range_factor_tbl[range_old]
> > +             / adxl345_range_factor_tbl[range];
> > +     act_threshold =3D min(255, max(1, inact_threshold));
> > +
> > +     inact_threshold =3D inact_threshold
> > +             * adxl345_range_factor_tbl[range_old]
> > +             / adxl345_range_factor_tbl[range];
> > +     inact_threshold =3D min(255, max(1, inact_threshold));
> > +
> > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_A=
CTIVITY],
> > +                        act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_I=
NACTIVITY],
> > +                        inact_threshold);
> > +     if (ret)
> > +             return ret;
> return regmap_write()
> > +
> >       return 0;
> >  }
>

