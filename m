Return-Path: <linux-iio+bounces-24643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C274BB2A83
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357A93C6CBC
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656623F294;
	Thu,  2 Oct 2025 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2U0BMBK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791C1B85FD
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388752; cv=none; b=RvSsHJZI/dFaSt2Z/pw8PdPD62QrmavwYpC+FlIOW5gXpghIH8zpiKKjRqK/G+H35tsNPJAQkejNJXojAvAGnK0pbMt96v1IQ8QFD8yN8iz2AA4GVFR9NDO86w2JL8vcN0x2DDKi9R1bukZGydxF/7Vsdk++pzO4LydCkWh7FSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388752; c=relaxed/simple;
	bh=kqajBcfhnyiH952GdDDW4wkPaZlv3VtMaJHXRfk7Dpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqZ1022qOzpK2+lCXLYzjZMKWmF/LzKF6bYytT3rDSh5S/3LJUx9VXnXUIGXXhJvIoPuwXBdhvU4lAWND90foh1cN+MNYV6CzT+bjJVOgovyey6w1j6TxL6FwcvATGG3Kz3wUqUmKJAcmiGOtr9Hhm9LHzhI158LBB81V7Wwaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2U0BMBK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso1218670a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759388749; x=1759993549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZWe9sJjzXFJrzJbfI4do9XirvOVhX8rsNXWi20/gUM=;
        b=k2U0BMBKM2bp8J2X6coDT2V/tcS3OHHyRSAjC2t49vRjqBRlW2AnwQNRjGbMrvbyv9
         tRstQ7APNV8wnoiFeiwCsTVzevzrb+CVLkE7BbVWh2Ql5GhIzAte0L0KG95fhlga8RkM
         I4JqmOqVOuCac50s38RmYrlWzgEwRSGIv2BVklQYVGSSmxtf2CVPlrcpdh8K9y6emagl
         WDOFUVzoPyK68ZJM8QJD4Hi5zQarnRLQa2opSqO/4wNlYz+M0qml+8lcbuQtDml1DuFl
         y/MMYMB//H45FQOlNKRF2xd0k+q8oMGU9V5pOrVtmFP/6uCbRs4Iv0uIb4HHergbVCRD
         z0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759388749; x=1759993549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZWe9sJjzXFJrzJbfI4do9XirvOVhX8rsNXWi20/gUM=;
        b=OrXY9t42Ki79/O7OmT71r5jWCfVNi4sKzfV7E/7YznyzWog3q52VCvISiSfTYarZ6i
         7LSD4Ql0XiVHU9XgzJoS8IV3/nXBszUsdO7B3QK4ZX/LBvYFixZtuj0xSeEdmIJkBNkK
         FyvX9RPFTkPq7kG1MGp6AZol3rt0sNdxrf/KtCqLsC2Y0fg2JFJ/l9w4jS5tmw9nKbUQ
         KHpARaa/xRty9qZAkLmFkAcZCqfNDzeOyg2VxIrxKvTtD9rxaM5eh+exefyoKXDrzeYL
         MydbATN1gHhCQIg6adKdD0i4H6RUsKLl/6CChgMDZ56I4YrsxFSSFweREbeo4vB/H+pr
         0J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwR9PKOZ6sqlTA/HvuxWvRJ/BLXlcvfIkcAgGs0LZb0F1RyTqv6xxWRNrs1TareIzdX9Vq1+MzO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcVAy/a/VPDPqG5vzwH02KmM3TXUQhpLXJxy8gBIKjJBK2Sp+
	Gk81vpAqapFTCxcsvQlxOTrC3hGGc6UQ2KRleH5TRgW3ybqHlCDCS6zl0pfs5Lh5hUWWUIAWkmP
	WMmctsyCko633jTL6oJMew9ehNGtDm+E=
X-Gm-Gg: ASbGncu+8LUWK/PfVukvLg8h5FSmku/i/AXNXi/AvVNRBybw2RNiOXzGMaxDEWiUXU5
	zK6iZxgzBbzACuRs0LUleVTIXCfBivbOchndehWnZeYfOI45/em7Vk7xqXHpErvUkKOWQ9pxWUt
	JN6w2FSns7CpuxhgFAkYbD8XaCg+JiaqwBhDjuJIZjNcy+tbwX8WM1MsoB4eXCgQhz2H636w20W
	Pcv2wwAdFq67P+cX5ftXg7AEbPHdvcphQ==
X-Google-Smtp-Source: AGHT+IF6z6xvP8EKQnjBWNNUYUXM4tLIvPP2DGadjVE5IQ6sdKrCnvE2y+ttQ27ur9HBknRAgOcWbfanrNPkOyv7YmE=
X-Received: by 2002:a17:907:94d3:b0:b41:660:13b8 with SMTP id
 a640c23a62f3a-b46e6033460mr843740366b.31.1759388748447; Thu, 02 Oct 2025
 00:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
 <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
 <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
In-Reply-To: <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Oct 2025 10:05:11 +0300
X-Gm-Features: AS18NWChg2Gs11byKnDJ3HgKZr9JaYy6y8zdlFJt8XDvo3BCRfuqYggwXNDKvtw
Message-ID: <CAHp75VeXXBjc_o1ktqNnL-wH8CnjbsCHu8Rs_kpfYqCbbz6PrA@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt <Marcelo.Schmitt@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:03=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
> On Mon, Sep 29, 2025 at 7:59=E2=80=AFAM Marilene Andrade Garcia
> <marilene.agarcia@gmail.com> wrote:

...

> > +       /* Enable writing to the SPI register */
>
> Always nice to put `.` at the end of the sentence in comments.

FWIW, for one-line comments we allow different styles, the main
requirement is to be consistent with chosen style across the driver in
question.

1) "bla bla bla"
2) "Foo bar baz"
3) "Happy comment."

Each of all three is okay.

--=20
With Best Regards,
Andy Shevchenko

