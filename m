Return-Path: <linux-iio+bounces-18368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA43FA946B7
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 06:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECBA175967
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 04:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E612CDAE;
	Sun, 20 Apr 2025 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtoMclsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59CEEDE;
	Sun, 20 Apr 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745123818; cv=none; b=II+n+h5bhqiNGQvD3BmfOadFMj26fYTbYBshX6kEWT3MJ+ge/KW73a2WmotszlgCUU1m6r9XcMI1NzY4iXizFNeJXfoop/DH99v4xcuQ2PprMKbBp3OtkmCtpsTdIJlCZKb1hsiF+Y4isOxh39Ae8e3fd8a9Yd66XDxWW12Sqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745123818; c=relaxed/simple;
	bh=u3c63v6eYgVIIEuuAuLE4NfbYZpTokBg6euJh1qMooY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U60ZNLg7ViLSWnJYuCJrje6ZYiV9ZJ10jWLUTIzhqZ0NUSkR5ce1a/QtK2T+0NirWqBqn1CwgNwqO4CshbOCAxwMuN5jFrbG4CrMT3aR8OqiKEQ6FRYkRPExa0bqEE9Sl4fSs2ly7V0DsA3QDZNhFyt4+PeeDhUSnXvHWcIWzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtoMclsS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so4692106a12.0;
        Sat, 19 Apr 2025 21:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745123814; x=1745728614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbRJ4qFwyobcIGndyaXTTaP6oXbYgisvmymcgV986Lk=;
        b=FtoMclsSY13y59xj7Qi4pWxRtFguU2yvZPkI4oi1IKmL08/tatbC5P8aNivkQ360O2
         Gzzz962/0a/en70vPJyeddaBIfCB68FzV3xHEHISDAl++KxLMB3/3IIzNviuCkD7Qi3J
         zGbQ7USdnCG5/AG2vUnMn66wUllPqclrJyuC5ptaYmij980TGL1OSk5DskkIXklEt9q+
         8oKErKxVWMsPmrGnS4J3YeOcTLgeCnnjXy6qM/D2Fp3d9oHulsEVDFpx2MFCV2qrGoEJ
         /jEaFYjLsTB7UmV+2wvfkbJAYjHM9/DUgm9rD8apSv+hfRMKZihhrsoGx3ImSdCbFN9W
         Lkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745123814; x=1745728614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbRJ4qFwyobcIGndyaXTTaP6oXbYgisvmymcgV986Lk=;
        b=Ybdz9bmQj7EvZcJBdLXm2FtPOHofscqX539x3Y3fVGskNnk+2Ebu3gBNxyklM1RaR4
         xIeOb09IoZUQQXEpdFPHhb6/Cs1aIQmgvFj0BYtoxk0yQaWTQt4oWtzpBObJXxsmhfYH
         Sv27iQXstcURiVt7ftGGRbxLAYac7wrgLZWPFTvNRZ0yzCMXDC6Lr6t9x8TCtCegac3a
         rfexnJQSRgf0pCAeaP5r8Icxp+No8ajZPRdMbRBLVIbGp4lZaHrp1IAzhclNxGH6gB42
         Ck8EFyboOKwRaiGlC9YnhZ+tWl0E8zR6ZOr0qfYuYBFBLyIqzWWxkAtvlSwEEb//D9ia
         AlXA==
X-Forwarded-Encrypted: i=1; AJvYcCV2OTU5pCwaQ8Rd1AWUwA1VfHY8WuK0UlcRmRjkE5MGS+tP+Vju9GoyxxBF3Y05jom+PV2tUmGVftU=@vger.kernel.org, AJvYcCVm+2zGxj+u+Q8pzzRCGYY+4r7sbGxt7rGl/FdK6Jmd4L99UfFZqeKHS3W/oaEmbUpVZ76VzZTyby1x/Dez@vger.kernel.org
X-Gm-Message-State: AOJu0Ywen8M8gu0nQHpqVlhyEQmLHj8tkZUMe7Nx/jL5ouKCvQD5JnBG
	jrMlZ+eyEtX7UJVwUd0SHcyyq6pNPq/z5TSK/xw2CPc3H9gJjlxQHWWSbov2U5NTJypRLZk6bof
	4HnEOEetxsquODSJh5jHP9K/oThk=
X-Gm-Gg: ASbGnctsdL836a7at3HIvPcZgAbnMgwHRUx7tFq5wCnaDDNRmsg6atlejtUt1Cw4qe+
	0tyO6xIMqjI774vjOE0FycsC8oXQC/ZVJhpwf4+CR0tNcF+swsvkfU2fiA0PNACmKYX8NnJF2/0
	WP2hLs3qiB2FXRkncJvxB3WA==
X-Google-Smtp-Source: AGHT+IEZtMxpIOpgj0BiX3b4rCxCeSReO7I3OFNc+w0rwCr3NPFYMZMRCX4R/6qGeS1IWSgRYBPndOkcGshtLNjvceI=
X-Received: by 2002:a17:906:f5a5:b0:acb:6ec0:12ec with SMTP id
 a640c23a62f3a-acb74b87d49mr686883166b.35.1745123814251; Sat, 19 Apr 2025
 21:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 20 Apr 2025 07:36:18 +0300
X-Gm-Features: ATxdqUFs5m5brW2LGy4SoZCUe0fRKmWpm72CmkbtHljHRe_kPuHBhB8VwXHWys8
Message-ID: <CAHp75VdcMoxoBU+fKQ5ex28N7YJNcEe96dOuq6hWFxpnn7UYyQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 1:59=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Creating a buffer of the proper size and correct alignment for use with
> iio_push_to_buffers_with_ts() is commonly used and not easy to get
> right (as seen by a number of recent fixes on the mailing list).
>
> In general, we prefer to use this pattern for creating such buffers:
>
> struct {
>     u16 data[2];
>     aligned_s64 timestamp;
> } buffer;
>
> However, there are many cases where a driver may have a large number of
> channels that can be optionally enabled or disabled in a scan or the
> driver might support a range of chips that have different numbers of
> channels or different storage sizes for the data.  In these cases, the
> timestamp may not always be at the same place relative to the data. We
> just allocate a buffer large enough for the largest possible case and
> don't care exactly where the timestamp ends up in the buffer.
>
> For these cases, we propose to introduce a new macro to make it easier
> it easier for both the authors to get it right and for readers of the
> code to not have to do all of the math to verify that it is correct.
>
> I have just included a few examples of drivers that can make use of this
> new macro, but there are dozens more.

I'm going to answer here as the summary of my view to this series and
macro after your replies.

So, first of all, the macro embeds alignment which is used only once
in practice and the alignment used in most of the cases is DMA one.
Having two alignments in a row seems a bit weird to me. Second one, if
we drop alignment, it means each of the users will need it. That
significantly increases the line size and with high probability will
require two LoCs to occupy. And third, based on the examples, the
macro doesn't help much if we don't convert drivers to properly handle
what they are using instead of plain u8 in all of the cases. Yes, it
might require quite an invasive change to a driver, but this is how I
see it should go.

That said, it feels like this series took a half road.

I leave it to Jonothan, but I don't like it to be merged in this form.

--=20
With Best Regards,
Andy Shevchenko

