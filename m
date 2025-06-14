Return-Path: <linux-iio+bounces-20669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD9AD9FD7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5223B5119
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443A1E3DCF;
	Sat, 14 Jun 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXkIoMzo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E98F77;
	Sat, 14 Jun 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749935850; cv=none; b=TrdAef2qQW358YDMa8UYZjt8l0cLrGqWRf10p6fW4ZqnXuVqIty0UD3b+tT8Vs3NE7NzLiQWihOSIf4fh7JDCvc6C0upCFxvO0P9OmTQfDiSoP4TJ9t6hg2ln71ORq8zJXLtkXc2csrfuv08a9oHuZCgy9tOMBvTF8sCIXoHK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749935850; c=relaxed/simple;
	bh=AtCbgc4ofTahpX6BcUnPAx8aFU+Gr7HS1JVprnOvCwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IT3zNvU/cFASEXlEQz/xMOJ1hiDq7q3HCTKGkmyeiFNKohAgcGngeKqm1E5qXGBygRrIJj01OC9CtJB42BJK7UnNdoH01XlMC8MqihEffb1qj+K7XoXkmQF7OBdOZxtqHnBno/sdbdmaoM7Y46WpgTy3YcTdzAYZDXxmLUvG3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXkIoMzo; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e7971effd6so943781137.1;
        Sat, 14 Jun 2025 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749935848; x=1750540648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtCbgc4ofTahpX6BcUnPAx8aFU+Gr7HS1JVprnOvCwk=;
        b=DXkIoMzo4YcvMRF7Tazfz2cgZ4McCMdn4gjeykMB8cC5kaptAai3qgDWCFkCtrq1o0
         yngtb6WPPZLv0Wn3b+pkKfW2fLDhp6MeWKkuzonTCWwrwNKPF+t7W9FWcQ9xpLLEMLSB
         oYkl+y3hfONBW495n1vWgF2exR6lHTCgsaUbt1GTsk/c5LH4/V361AeuKmqsAjdbd84/
         gw3nkpUgg+nmBpaUlMN/HQE+qgQNLq5fsjZ/b+da3K8lY7oDs7bnsCTOo+EOxhRH5uq2
         44XV9RzcgIYc3SwiVW9TbdyIFdplbr4P1YB35DCu4qB9Mm6o5WdYLASLbU/gts8ituhz
         vVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749935848; x=1750540648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtCbgc4ofTahpX6BcUnPAx8aFU+Gr7HS1JVprnOvCwk=;
        b=wwQIp3Ch0n9NfoZxh+EKsg4aJkh3jsZtQ5VMFn9B+ljPQyI98UMVcvx7rh1zEOn4OT
         aruqu7VtTwWTCX3KZ/R/DckwSrKK1M9eTc0hfIiACUHSeDhOlesd+TnGhX65kVdVyD/Y
         6dylexyklFy76OMrh5FaWufxh86aT6Lnrx6GufJhJOlge1l96ewMUXcvcNGfnv/0vlME
         7j+A/DfLUa1ybYthnAJ9Mkr66Okz7++BAQ9INqyBAPMATFah5mZx2VOEn/jP8RXnndYS
         hcbye7o82qlrf/azAfpfxOI8318UCZpTneFucDDSOUR7wffvfd1mwWwlN0F6bCO7XWL/
         eYFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZL1yXe8jtMbj9n/iP/cU1NQfFv+dKYMUHGJ0Ak87DKPuh8r8gL4rP7ysIGXotG3uPDd3VESyaZ5g=@vger.kernel.org, AJvYcCXt+2gDLWqMokfVHl1QBcf0ytNmLj5DGBfp4ok0UZIjeSxP815a9OZPQPSdwp8nu/7m2m2gc+uBwxjLR7D/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YjQCw1Oo9UDxWahZDOAtXF+IxiRplfiRrzwNseyXrULYEATv
	dI+Z4Zs27/CvkUmmUM5ZxIFur0iRyWsZeqF0fUGbZqAFmyOQwk7OQpdbFqBvgD5x7fFagobwq9S
	4Rrf98bn7JCEJ1RwWQ8kkxFdtWOXRFGw=
X-Gm-Gg: ASbGncu5aj9im5WW88ngr+6csmO2FzzlqVpMILaAZxOn+nDX/RksIZQhziIjJj7KGwf
	Znjf6mRtKXlgJ/FWFu9O4Dbiot2S7CidWkTskTfFoZer8h+s7xYa1a3Nn1yDT35fy8aFWJlsKnI
	KY1AOYwRJgZslcPmKaQaB8heD8BL2LkSrLdtZNg1CCJQGrn1i31urHxJ6Xbw==
X-Google-Smtp-Source: AGHT+IHvK6N0seBFyFZDV5yJGXigXGnKDNfU/5ZbkfquHTqd7i51Wa71GJUKd/zIsx/XWtMlxGxIBTtZb23WytwezSo=
X-Received: by 2002:a05:6102:2c11:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4e7f6222f5amr3671722137.19.1749935848101; Sat, 14 Jun 2025
 14:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-4-andrew.lopes@alumni.usp.br> <c707bb2ad7334736c56687f20824be4b3ef71d74.camel@gmail.com>
In-Reply-To: <c707bb2ad7334736c56687f20824be4b3ef71d74.camel@gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 18:17:17 -0300
X-Gm-Features: AX0GCFuSy8M5Fs56KHKcfTkTSA4rNH-o5-QwrhA4C0w9vtnhPcJxfDQjXQC6vZ4
Message-ID: <CANZih_QUvHWhFRr6rNLhYOuyQ77oqUyvrtAMF593zOdWfa=JYQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:37=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Wed, 2025-06-11 at 16:39 -0300, Andrew Ijano wrote:
> > ---
> > For this one, there are two cases where the previous implementation
> > was a smalllocking portion of the code and now it's locking the whole
> > function. I don't know if this is a desired behavior.
> >
>
> In theory, it should not break anything. But you can always refactor thin=
gs (like
> small helpers) to lock only the code you want. There's also scoped_guard(=
). I would
> say, up to you for re-spinning a new version because of the above :).

Oh, thanks for the suggestion! scoped_guard() is exactly what I was looking=
 for.

> Just have something that I'm not totatlly sure... Did you made sure to co=
mpile?
> AFAIR, guard() had some complains when used in switch() case statements. =
Maybe that
> got improved.
>

Well, it did compile for me, but as David and Jonathan suggested, it's
better to create a scope for that.
In fact, when implementing this I looked to other examples that used
guard() in switch() case statements, but I didn't notice that they
added a local scope too.

Thanks,
Andrew

