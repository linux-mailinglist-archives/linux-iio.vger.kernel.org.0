Return-Path: <linux-iio+bounces-16109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7EA47045
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 01:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEF33A7FB8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4744250F8;
	Thu, 27 Feb 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pteHu9T6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A015A79B
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616452; cv=none; b=pzB4AaaHUo/K6qVzkCCAiP/K2tvV+xweoGrGIzjjiLHiUhc4eyGzy0lsUzkUvPZUBgZfbip0TouEgYMkBKERmRs5jLTFk8dMvaQXbxk1hymBfGHzKJRQHEPF+UoV1PH1ob9oX4A2UuvBN4L0cqbvZ0DTiMiIYw1bOxXXo2lKN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616452; c=relaxed/simple;
	bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ+738DdEoTOfPOdLK+D6kkzlD6q/IXGSvd26i21ibBIfEbQIHsU+j+biq9shpfrqm5sxn80DyGvGK2IkqG6H7cZqLl0VxPywO7bZHzQ6Z1WMcMOww0h3kFJtzjuMvO+1SZFLdfvpwi1TeGy+cJWjOdwWcKE5Lw4xl5Ub15iI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pteHu9T6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5461a485a72so318038e87.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740616449; x=1741221249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
        b=pteHu9T6W2F7U+uLiMliilAnz6MddKVP31ABsypnOxNc/eaMJyRwMP0xTf6E0juMdw
         Kwin3Hg0Pk56Z5s7OBhk21xvT43B/MCbCV3owZQk/fgvCtIkOQ5Itz3rIcu3fdCqs/qZ
         hnS/y0BhmZqL0oo23m3IYT9GDzbYm59jQ6xoed+PIGHt7xAM6AZdBUhx00thfcsjP4BJ
         Adkcmt4LXu6sU3z293EO+XEQjKVCshBJUfTqCzv/zm1fT4irObEasWVeXXfJdm0YXqMM
         CvhA3pXQFAuRaCF63WaKWUziG/0gaPGsTbRB9deh+Q8HP4B4kx1LnbJ6YZGk9KIQMDLY
         wE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616449; x=1741221249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0m85e3y2dJr+vnbmMvuCtrUbcNjlRo6dsWIZjIM6OY=;
        b=dAFBwmMF2uc3nMrLyNLNp37t6AUxdl3Pelca5w4bLuxZFU6LJi/QHgi2Ezwgs+3kxt
         A2YnKVIvo5wXjoJdABMqwlnetUfdKhjcrdDtfWki1axSNpwc6L2ifExsubvOivoJnOoZ
         HvH4yZz7IYOdLeG5a7iRfAfRNGSxo2NDFpe28gqR+I/43sb16TZ53jlUwMEb8mWdM6mr
         fQCVIZY4kU7N/Egtushedc/P7YXgFVVccba0q6ANNlYcz6PDqunRS6VnRi/tJAtNnH8Y
         6E71xE9cdVYgmKzgfv+lnn0tcA8dhpt02oWo/hpz/7F3ul9f+Ryi3YnQuc2tFaO2SVwn
         tEOg==
X-Forwarded-Encrypted: i=1; AJvYcCURmCrB3QTpltVqItCGQ/SPJCnTk7KEdp6wFx498bGV9wf64c3U+f5P840pbZAxzgHYAAf7iHbmrb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr954S7cKSZQnnW2bktxS0zNcvEYLMwhy1Hjuuzc6nn1w9sjaJ
	l/f2hzPg16kK2KgKUhn0YpEVFOEJtbdzeyG1yqd6ki93SfWEWgpMWr3bTAjJUbIeeyIYxNqNv2T
	xxDA5oDR8YYqfoFeA3GYdh+/xHTQ5lRvcZJN4Ag==
X-Gm-Gg: ASbGncvb137Whc3wq61J38LCiY37vqdw69PDW+za0I1OkwHDYWH1VLMpBFwXg3j8RNW
	vsaZfiB4miZ94SzfXE53O+lT9npWt22hMAyCAInARv8UROOhwEaUsMm/8ojdISDXGnuI/1LA0oM
	ljvg3bCzA=
X-Google-Smtp-Source: AGHT+IGk0bwizeRVbg8pZ8WmjGM8S00+LUG1kQZiLI2mX2EgJo48gbUR5HjgaprWg2ADtOmxLRe5adqlJ0n1Ufx5jUU=
X-Received: by 2002:a05:6512:39c9:b0:545:e2e:843a with SMTP id
 2adb3069b0e04-5493c5b85e0mr3233639e87.38.1740616448603; Wed, 26 Feb 2025
 16:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-for_upstream-v2-0-ec4eff3b3cd5@analog.com>
 <20250213-for_upstream-v2-2-ec4eff3b3cd5@analog.com> <CACRpkdZR8X17Bn-i2anqjxf0Gk60V175F7Xfwytkhy7_K+LsSA@mail.gmail.com>
 <880631da17a6d8ed4afe5a8c453fd4f7d0e4fca5.camel@gmail.com>
 <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com> <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 01:33:57 +0100
X-Gm-Features: AQ5f1JpLuJfZaZl_9L9BlB0RNZAYLUnV2bfevXjy2bS7H0GjQDbQCA5UMhow8GI
Message-ID: <CACRpkdaMBpUNHQu4kW0s0pDJSZ3M2GvNB7mY7DbnYuboebtgbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:02=E2=80=AFAM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:

> In my opinion, using the GPIO subsystem for the ADG1414 may be a better o=
ption
> given the intended use case. However, what do you suggest on how to proce=
ed?

I think it's best to proceed with a GPIO driver unless someone has
better ideas.

Address my comments on the regmap use please!

Yours,
Linus Walleij

