Return-Path: <linux-iio+bounces-22450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44354B1E88D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552A516E69F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C2797B1;
	Fri,  8 Aug 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL5CygKl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC981CAB3;
	Fri,  8 Aug 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657007; cv=none; b=gSg0bVYPJcwj/27iMSbNHdtGwxA2z0OkIW/48TuQ36GTeYEJZlWevaHe3ezEb94FH3zVOOFarBgajEzg2ybeOfnBIFhhPLcZ6Edml/Oguno+sOlFM0vR6llT3uzLY0GftIQkJxPeztiJ//ngfNFt+1ZqhGoLofcNoS6+ki6sRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657007; c=relaxed/simple;
	bh=Ap/jlKpvDyV76kTfPTp69hiAoxWlrVcNjSdEW4Ql8kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFgCGjSKadMv4L4ANU4dKp5cXPjwcGIY3nQgRQYrxoVwWepSkaGKFEmQ1HTEIGVyCNUVCS9E6GrrQMMvDsNvkBh1YMYdzrxu9GDo7cevTBDCHVHAM/TX1dj2xV6ImhG5kGyne4ax/9KoAyt5YyjwaEkCW+P3KwmUDk1Sf5nz5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL5CygKl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af910372ab3so531496166b.1;
        Fri, 08 Aug 2025 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754657004; x=1755261804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap/jlKpvDyV76kTfPTp69hiAoxWlrVcNjSdEW4Ql8kg=;
        b=IL5CygKlzi7bfTrNSM4L1vfsxLlaOeJ1PuB1IQiYpb2SkzkOSFworzT8EQt6T6lTfe
         NLpUgCxQ1+TkK2gsMew9ACdxIL4qXV30MWkV+ip5xEnQuMs/lHcn71XhOQNnZmJzevCq
         4CkuRc4cnQJlKdre8w/2A09O/XhzNv4/0cMeS1XJBmrXu90TyTmsMMzLov4hQCOV3BkH
         ULjTjbmYBP77sVvzdzdUuaVyJOTj2hRPEhmxvvD4NZLcKvq1DlK+LqN/wziq1k26hbT9
         Ohl32/rK+rOTsCy5bzfRvG0TRUCl/fxTtoBwXgtVhg1uXpbPNThjbpqe4cQl/lBWQ1wI
         oQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754657004; x=1755261804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap/jlKpvDyV76kTfPTp69hiAoxWlrVcNjSdEW4Ql8kg=;
        b=N5IgnhLlRBw1B7n81sS32bBONcBaCo8pR8NkXrZl5wjNNTPyS+/Fj09w75yEJQ2EFy
         JCFGc64Sq0EPJF7TQKc6rgwhJBC5xf/A3V8/bUdNb/vYf9WCBikxU0g7J8F2d+3WS309
         ffrP6olBPK6fcXzNvlqKcS2fWhSIwH4s+GXFQjUQGinErauCNgI3lGuQ07xNQL0x1d+0
         5n9D9a7eQtH4212J8c5oHIPyqq0HpfIhet1Soi3F/cPoTcfNM/uV8Itdh+2AqYyjAUbx
         xAqtWoW2Wvcj9Tw4pGzA7EMv21uAQ/eKuB45CSq81tc+cSyDETQ1ykv+8IDRglwBYJEF
         swGg==
X-Forwarded-Encrypted: i=1; AJvYcCVSgPTnwMM7D9rY6Nhw25SUwl7LkyswonJYcNbDOckEWYcrvVtKhWYwu+m7IYBG37JdCWmeI9uL4v7PG9x9@vger.kernel.org, AJvYcCWNz8ylO6LEiZaojDoewhbzAffWr+6xbZEZR1E2157KbmhTNz0kr8t0oPPzdLosy7JI4DFYv+iCwV4C@vger.kernel.org, AJvYcCWk3Ez4qWBo8SfFGQKSUU3d+okMEjj/PTeXnKkA2XsgTiaqVBAiETuwrLCscyjx6YSyvJtA99OcmkXY@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPCk+wdlU+AMe1AXfTwTk3/Sa008B/vnlAbugEQrCtzYf4c86
	Xzygg8gP66syR0yuyCq19L7f8uQxJs/G/XmSOwairrlGFf32IYdlmP/8moSG/qJXZl/bzcoY6rI
	ekpfdcmBceenFhsYbNWG1pvKWMg6cgUc=
X-Gm-Gg: ASbGncvzhcOjekSRm/cYx33RIzV7uRR6c8nW8s4XmnVTWfb6Q6g2OGO35wtC9SrW0bj
	j8l8la7f467kb42xQXrXUgou2mJY/Fge0fzFXhotNmEkB648qJKCk37gL9n5ZHNvcTlos+JQAWp
	alpXv+tTPnSTXgXZnkpSbcogHnGrOlOfu2ehpS4vL4RZSpZxZs2hFa973UW3hMZZSKVD+Gqmkxp
	5vwOiEy8w==
X-Google-Smtp-Source: AGHT+IFWNAixuN06PKtrVNWI2iEn66/ZgbDwV/E7f1VRCqzlojjZyFGtlhxxvJZF4F2xXjGME5cK/TjcWFOnG0B00ic=
X-Received: by 2002:a17:907:6094:b0:ad8:942b:1d53 with SMTP id
 a640c23a62f3a-af9a3eba1a9mr635744966b.27.1754657003749; Fri, 08 Aug 2025
 05:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754641960.git.mazziesaccount@gmail.com>
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 14:42:47 +0200
X-Gm-Features: Ac12FXw0V2w-S-cL5t5Enj_x3LsCQcy8KzSqvML3hFVFwYyhsRMTIXy97VlLsPk
Message-ID: <CAHp75VcZtKMLByp7QYa_w_McECuDW+zA19HEiTxhYOTcOwxpHg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Support ROHM BD79105 ADC
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:50=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Add support for the ROHM BD79105 ADC
> (and do some minor simplifications to the ad7476 driver while at it).
>
> The first 2 patches were originally sent as an RFC:
> https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com=
/

This version LGTM
Reviewed-by: Andy Shevchenko <andy@kernel.org>
with the exception of patches for DT and MAINTAINERS, I haven't even
looked at them.

--=20
With Best Regards,
Andy Shevchenko

