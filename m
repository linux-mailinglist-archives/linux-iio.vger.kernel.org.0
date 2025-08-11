Return-Path: <linux-iio+bounces-22578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86A7B20CB2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5BE3B962C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E52DE1F0;
	Mon, 11 Aug 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2f1woPa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36B2C325B
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923862; cv=none; b=EncE66b2+9og9mMeQGOJcK39ElpUjL4prdPA6hmLzQYRNQku5hwPXZaI7UNgOorbYGR5B7B9u7Erq8vxbguCiit1HUuNwoRHG64XaWulzY5VHOu/fqoWeuwKV3gJmUVrT3Zzmvet6WCKj+YCkZWp5zg1EZGFn9uMOTogSiaN7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923862; c=relaxed/simple;
	bh=AcHxWEdP9Yz5r3+P+heKHlncmGmhw7FRJMN14eLnGsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QusXjN6ASQHzQ3/sl5u6tc/2KP+CvIs9QIU3aT1hfIAaavOaBaufEd1+g0ljqIQabZRljythsh0Pg/kdb5+t5uSY6lT5scsUo5QvzhqSjq9gPISEku+oDnuvohEeELQcBpEpxtr7IU8hURpY+LHLnpi1THuOAJj4pSnka8DG4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2f1woPa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af968aa2de4so813668366b.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923859; x=1755528659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd3n/10iD3sdo065cGd24mYNZuyIAlO0F7IhlQsb5V8=;
        b=E2f1woPaaDEE5XvSLN5BgmpZgQxMewwwN5H5COrbZpgQFENXVLhwTTptj855BvA+RD
         rKMvedAi4UciVsCUPjVx1qBqy0B2mTc7yNgI7czrPQXaUeTqpkrtjIhdcJzkVfWV5QvD
         7FR0bdSMN5CsRVJtUiSEqgfdpUYK8TncRj7i9zNxxRWtU92yM8LDclQebklT5hALly5R
         5bq5b1HRXVC6hmv5TvaMSPH6e/8gfP817fUnlcRZXr8gVLs4tr3c2mDX6lp48ynM4YU0
         rtApBscNgEZT2FVNL0Td5f1zaV/JqfdmGzRiG0RUAEgHTWiLAeYjrf+wNx6XCdQsNhUa
         7lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923859; x=1755528659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd3n/10iD3sdo065cGd24mYNZuyIAlO0F7IhlQsb5V8=;
        b=eQvhMEDatc51V+uPilIUFp51su2Ghp6W01vglqYiSuqwzrzOd+VW+PX9Nc4VCDEUNo
         RRvhFslzIi1STa8x+R4l5QcJGp/Es3OGCe8zMrMvoUrXtkeQmzFaPpW/jYpCPHaPEc8L
         FhsA94pJvHLNtRhKiPczeDBRwcJvNSkcgBcpEj1hIccY37+xB8VScdQsjLTKdolm5Gck
         VDx2GLA+j1xCyMMsBkgZdirmCyxabNFmf6JAfAZ/iTx5rXK7vmvYJ5vxNvvXmzCW3GCC
         CNZ8h4+ls8Lf8DIFDcAbNFVFHALaA4xIzVV6OlXl7UtoazOUjDOUEm4++iUAuT5P7k+/
         yv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4MYDmHQ0UMVXBSTusCaNu9j8Zj+E4GaY1Ydif42//qFakYYjQiJ5/cpwyZYDn9/SWszatABcOzEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fSa51YfwI+O+gyVzeH35htnVgHmyF0xBuNSyPQcyvNgePX46
	bq14o8dTMBVBxdCH9qDN9ejTsbz41TpaPffqi46vSEQd8WuJVS3IE26b2YXewHw91bzKPEiqTQE
	8Gr/lUf0xara8+/9gR9hCv+c35gpc/DA=
X-Gm-Gg: ASbGnctOlhT0weh9A9+FoZajWmB3z3MUmxTH4Z4kss+Du9GPNNz6cnM6Px9xEKgY7Qc
	tIzKfSN7IztK7ahZ+3b13DIzRDdEu9Y6FzfcUmFbyHjcas+JwgT1VOxZ6l3qq3L60TXo+hzLZiA
	7RTVqg+iG6hiZj/RA1FM48iVach9hSRuztqr6AG9gq8gwB07mdvr8rW7wOiN/FV4xfzHBvZNIOT
	V5JDG5q/lf+lQfQTmJs
X-Google-Smtp-Source: AGHT+IHKRmHExTW+7s7eXpxrFHUUEHTcVaKNRBHVyhVf0S7atzDsmteU9wq/fITipyJIVY3wnCklxHTuXhViq3bK6W0=
X-Received: by 2002:a17:907:3d94:b0:af9:7823:61ad with SMTP id
 a640c23a62f3a-af9c6516da2mr1287557866b.29.1754923859338; Mon, 11 Aug 2025
 07:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727210639.196351-1-hansg@kernel.org> <20250727210639.196351-2-hansg@kernel.org>
 <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com> <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>
 <7810b341-1216-4fe4-8c05-17acb00430c7@kernel.org> <aJnj7w5aJ3B-AGGD@smile.fi.intel.com>
 <4a9cd814-6019-442e-829a-794bb3216e5c@kernel.org>
In-Reply-To: <4a9cd814-6019-442e-829a-794bb3216e5c@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 16:50:22 +0200
X-Gm-Features: Ac12FXxvS25xmY3SuCE8t_kv3aUa6gepC04cGZgt2DcvXC8GgBgOzu__iKQANp4
Message-ID: <CAHp75VdY_HQgQpG=0Dxn0Ofu3VXvi7S47FFj=-CoWN0OrddwSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale() precision
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:36=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
> On 11-Aug-25 2:37 PM, Andy Shevchenko wrote:
> > On Sun, Aug 10, 2025 at 11:12:24PM +0200, Hans de Goede wrote:
> >> On 10-Aug-25 9:25 PM, Hans de Goede wrote:
> >>> On 29-Jul-25 7:26 PM, David Lechner wrote:
> >>>> On 7/27/25 4:06 PM, Hans de Goede wrote:

...

> >> +    ret =3D iio_multiply_value(processed, raw64 * scale,
> >> +                             scale_type, scale_val, scale_val2);
> >> +    if (ret < 0)
> >> +            return ret;
> >>
> >>      return 0;
> >
> > Simply return iio_...(...); ?
>
> That will change the return value on success from 0 to
> IIO_VAL_INT, which is 1 not 0.

Indeed, thanks for elaboration.

...

> >> +int iio_multiply_value(int *result, s64 multiplier,
> >> +                   unsigned int type, int val, int val2);
> >
> > There is room for type in the previous line.
>
> type, val and val2 is a triplet which belongs together,
> since it does not matter for the number of lines this
> takes it seems better to keep the 3 together.

I was thinking about the same, but I can't surely deduce this from the
names of parameters. I agree with your initial split.

--=20
With Best Regards,
Andy Shevchenko

