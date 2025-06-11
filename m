Return-Path: <linux-iio+bounces-20399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906BAD4DC2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B49F3A2860
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715123537B;
	Wed, 11 Jun 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTUNRU5m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E05232785;
	Wed, 11 Jun 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628938; cv=none; b=oTATrC7tZMk94BW0RWK7VAeHkfYVGQkMnJ8vw9Ljj0HytAG79LPxqxNGLipgC+cEre92k05ywUwqVWXJ9t2EwWctYAAIw/R67ayOXbm9ITPpiqxVPLRoeLP3YCoSDiiLDe6Nh1z/GALnZKSMGAwwwLon9x2d7JTLruw7DtTEv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628938; c=relaxed/simple;
	bh=NbzZlFbp9MilzY0lStFAU5C/JQNiGLwMk/T6fCIRSDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTghbnFk3w3twbxYUAmoYGKlLK5jX7IkSfMMnVhVgW5A2hD7cC6gPnG0i9fldb4cDtsRH7kbLSy3AWHzBxQi9EAIS06u8o8AdhzMhb7+3F/CYe9APyZd3dtLlGBNFc261sJ+sCntx93nuajq5jxAvIfbeR7JLXc5iZV5QL2riIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTUNRU5m; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70b684670e7so435597b3.2;
        Wed, 11 Jun 2025 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628936; x=1750233736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbzZlFbp9MilzY0lStFAU5C/JQNiGLwMk/T6fCIRSDY=;
        b=fTUNRU5m5ng4jjt+Ci+Q8cwAr6a9TdP9cKcqX/iWF5YkaZ0xd7o0vghv2HH80hsv8q
         5hT4LX6RbIhaQyvDy0ZLC5aklSB8XsXv8iuG8Th0eGDhPI9HK1Wvcg9GpwIcQHCxNKKR
         ar2Z+Ur+aToXxlYFH4MmT5yIBLMRvH/L0HMp35MWn6ImC3kR8YhWfN4Y/rEueqMQkXmz
         kH4JpOPIyEOp654pE6wu4+zetuaJ+sPqDV5uFIIeGc9Shw26VA9hQrXFi/rXG99fAyFh
         a2LA4x5tH2sHSQcmcP3bnA4gANxHCxr9xWw2FrneA8XX5JseCTiT5AhzEalCX61qRBCS
         CxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628936; x=1750233736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbzZlFbp9MilzY0lStFAU5C/JQNiGLwMk/T6fCIRSDY=;
        b=ivo7gUmu7QTezobu8n+ajJ4RlmWWgSkhKTAIOUqgdCagUKgYjU/onrJr+8T/HKD7J3
         F5JgHHK7B3HqF8gGDrIBn8Wqgx5H+uNn6/n6+gvA9rTV3tUXDpPqZ5DhVI2IvZ/WNTcQ
         7W2opD9G/U+/9LQZOdIcxUY/ncOrPnTXn8z6GqijvGrqp71x7p4/1LwfiiopEkCcpWOC
         GoIBwCX8eNQCy4Ou3RvCAR3PgoRrNyMdpD+Qht16vnWiRbZTbRlkpVL7Txrl5D1qUJnK
         aT8L/3INFrd3N1Npeusob2v1OJEUiwGPI8/pGSnFMMa7+T8FR42M6grQ6KYQ9p78dIrP
         O/VA==
X-Forwarded-Encrypted: i=1; AJvYcCUQxRYEX3WGpQHJvpGmkgb/JyRlHPJFw6d1FEJ0QhG7cH+3PRz34eVvHqfJWZbVlar1O2x031hrRfE=@vger.kernel.org, AJvYcCV1Ql/GpNDDYfoYzZXaFuqtmIVMY1rHEyf+ew5PCXXRG7HLuggtfflfNwIZ+SKumH93qG0f/VbwcY1r7Yj2@vger.kernel.org, AJvYcCX8MJK1Qult3nLtslWpkkhyJ3iXJuWRFpHslwBw8gvmN0IOnAa6iAi4YM0LGu4ldBMMR8sXQ0HoA0ro@vger.kernel.org
X-Gm-Message-State: AOJu0YygRgHdcq3ZuX31u/3FcHIcqxQyrTjpjjZRhFgrbsKIF26P/C7z
	g90WtUNSPFvr9WHyVQVZW6b/1gduVlqMxi6t1SM50+0T+zI0TNMY5PXAfGeGilkQfcbhJczdM1c
	zxMVpSjX8ys3lJVucMZlpfndFOen9dT8=
X-Gm-Gg: ASbGncvJpDv0diPJTwt/mlGPNG/92KkWIwcX1U/cLtJpnDodx8xnqbaMzO3dn8EnY41
	IrBMYg4d/lwrpbof/CanB4ind2euIuKPwsLiQIj0ZgB4wBExU1AH3AUgXi2TvcEiWQgUGCBLsdt
	VEb7n1+YelNKk/yNi3jhtPnKzBwhe3zGmtWX0miHdjZJA=
X-Google-Smtp-Source: AGHT+IEFQN794osZ3VLd59D7VBxAU+Dt7mNDu8xg/+i3oE7oOTCgB8eAAcKaTdrZtLq+eSw7UlLCbHhVIGHaQU/3ctk=
X-Received: by 2002:a05:690c:39b:b0:70e:2d3d:acdd with SMTP id
 00721157ae682-71140b08a19mr13264007b3.9.1749628935967; Wed, 11 Jun 2025
 01:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-3-l.rubusch@gmail.com>
 <CAHp75VfitLPHZ=SUS-ME_fhJqCAwuDAzzN8yt1gq5Drvk7ySow@mail.gmail.com>
In-Reply-To: <CAHp75VfitLPHZ=SUS-ME_fhJqCAwuDAzzN8yt1gq5Drvk7ySow@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 10:01:39 +0200
X-Gm-Features: AX0GCFuMW4pSdI-CDsS_FlE9LXarn6flJ_PCzzRPHk9y6kKYvg48z-GqaNKYJlI
Message-ID: <CAFXKEHY-X-vA_9pzZgYX_HPd2gexi7r8DJJ6cp+H9Px3WY42aQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] iio: accel: adxl313: introduce channel buffer
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Jun 1, 2025 at 9:08=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Add a scan_mask and scan_index to the iio channel. The scan_index
>
> IIO
>
> > prepares the buffer usage. According to the datasheet, the ADXL313
> > uses 13 bit in full resolution. Add signedness, storage bits and
>
> bits
> ...OR...
> 13-bit wide data field
>
> > endianness.

As this is getting very annoying, I tried to set something up
involving checkpatch, codespell and ispell. But I guess w/o
grammatical checking. Just, in case, do I miss some simple tooling
here, any suggestions?

As a consequence, the alternative in the year 2025 is probably using
chatGPT for the commit messages and we probably never will have this
discussion anymore. Hum... ?

>
> --
> With Best Regards,
> Andy Shevchenko

