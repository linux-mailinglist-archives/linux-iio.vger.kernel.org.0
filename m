Return-Path: <linux-iio+bounces-11636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5909B691C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C487B22219
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4E2141D9;
	Wed, 30 Oct 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDsVR9Va"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576A1E573B;
	Wed, 30 Oct 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305625; cv=none; b=XrpHW+hg5YhZYobKbXMVDqYOt3WeWFmx6QnqSxsZXRTci7aglGsJJOEEqG0luXP1soUSZ2HIzlM4aPxL1F0ZKAVMKwYtbyAFtnhQgzrqve2G07L0C2uPPY1EADKg6/5jhb3RqyPrEMiCx7kkNMlTugqpki9N9Kiml1NZfBE1keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305625; c=relaxed/simple;
	bh=Z5gVZhp6D1TES0aWQFSn9gb/GoSlCRKexfne6oHSOpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET4Yeq/fuQDcyNw2j7CD1BQ3bOFV8jUc8aJx2CUT6zqouw8GIKCDGAS2UCPlbOLkd1AjEU6A+hO1U0iDb3z097T+FLwfQJsVAj1D5gVLXvrrTytjY06qOF3PH0hkE4SikWzNOwzkFRSKJjEakXT2FVTNsteE537Atj8qvvmGWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDsVR9Va; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1000809566b.1;
        Wed, 30 Oct 2024 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730305621; x=1730910421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL6g494dCDURUvV6Gm9V0WqHA34f4AywV8P7ZaT7UX0=;
        b=eDsVR9VaRsHvdvejjUgsD3Ojm2QEzfWtmgvykWIUUn5owRO9aedF2kopdC2hy8lB4W
         /z2Z0ECMrSu4xTG17O3iG62l6GfjeWUJxiuHf3l1qOtpHjKprLf8ktsVdzLS1QQ7WF7p
         9NT34nkfhv4trPEry/9lrABG+Skglx6zQ291TVI5c/RRn8WGs+vLwpY30/T/I/dRcrsM
         G7B/YHySzuR5f6IU3GuzUQf3jponH90tsLlA99mB0noVqZMAl1YqRyHTosWqBTXcEJju
         fVJdFgchFDYfs8848ufVX8XX9rsBM+2EjTfhRqM7Mvi1+dUpaVXewiCcaf3MjAx+9y/M
         I9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305621; x=1730910421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL6g494dCDURUvV6Gm9V0WqHA34f4AywV8P7ZaT7UX0=;
        b=EaUnoM5WLwPmXE7yRK7Rmu3M5tUweV9kEybYQpNymAfp7LMCYfWRyXuFD1e7Qus6jA
         zYF5mnPqQlBcV7U6vaOI/8RPVhVXKDWoifTqEgtMa2TnPkpMosUhdw+srZwBi/vG/fxL
         K4cK7GpERomWA1U/pa0qMEcOQkbRToqIgbMIUbK6FfGMc8manVXlrqUALRnQWbdo5jDU
         81eC8gG/iPrOiMPSSYatjelzS3xYIWwJccRA4wv8JRNGgpN6zQoYcGxgxJecS99XPajB
         jOz1Sf9+MKevR8uR/WgntYQM7ft+BJX20AxBJQnE694RBn7JkkAYPSL7u86tuICQpdnC
         CreA==
X-Forwarded-Encrypted: i=1; AJvYcCWl7m97G9+E3iInH2P/e5DT3ZvPXDIvFJJY8sg3Ap6r0foHtqU0RGB/4Uhpsgj95HAsVsSn0mw2aazAuvnk@vger.kernel.org, AJvYcCWscII5GXsvDa7y4sgHB54bWYNVCVN0B9RFyhsB8ZKK+zbaYW3zYBaHa9BBZMhtvh5Jv9u5amdQXbkD@vger.kernel.org, AJvYcCXEWp6jBmjQA58XU30vTe92EpPgk1injz8C9KSkLtmImyjgAWh0RAs51XiqGNSi6WDRwDHVLqTDZPlo@vger.kernel.org
X-Gm-Message-State: AOJu0YwWla6y/1z8zZKNWFcjrbfKTnCp2sitoiBf4ssKSCcZWmDbEbjW
	PrDblLMsbDyCsFQVuIV2edb5aSJHxwEIlo0VMZ/08QH1T/A6OtLBhMD47mrAndlapXChQTNM3+H
	mDiF/UEEviEaMI1RjMILfIh6CIQg=
X-Google-Smtp-Source: AGHT+IH8F2i/ZAHGzrQ8NhWG3ucD3fmiMWqQjjUVUnSlco3GAnI5OvGB4ZoHFE246UsXhzy2aZ/j03PTX7uQUlQKbIQ=
X-Received: by 2002:a17:907:2d89:b0:a99:33dd:d8a0 with SMTP id
 a640c23a62f3a-a9de5ff9ad3mr1357100466b.38.1730305621259; Wed, 30 Oct 2024
 09:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-topic-input-upstream-als31300-v4-0-494297c9e50a@linaro.org>
 <20241030-topic-input-upstream-als31300-v4-3-494297c9e50a@linaro.org>
In-Reply-To: <20241030-topic-input-upstream-als31300-v4-3-494297c9e50a@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Oct 2024 18:26:24 +0200
Message-ID: <CAHp75Vf8ZO3ZJ0V8QGXMN1VXeA4=nUEjOJmJbpGWF_OdkGP8xQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:30=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

...

> +       ret =3D devm_mutex_init(dev, &data->mutex);
> +       if (ret)
> +               return ret;

Thanks!

FWIW, I'm about to send the last three patches to fix them all.
Currently sent to IIO, GPIO subsystems.

--=20
With Best Regards,
Andy Shevchenko

