Return-Path: <linux-iio+bounces-22185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409CB18B7B
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2702B7A2B46
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B71FECAF;
	Sat,  2 Aug 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAPLjFaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F7188CC9;
	Sat,  2 Aug 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124850; cv=none; b=S8Pxk6EPz5y3cv56j86bK05MEAjGi+Lwvr3oQkZ6vE1+uc9eebV9A6hROw+fdG2ceKmp7mU45XFLtFCfT9Lm6eZvuFv5LfPgqD4rpUfTbLZ/qrZDyKwlZ1z09H9P4l/pXg3Ffh/SFzjMFrXjZfyA1V8kpowPdVwZNIGUn8kFW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124850; c=relaxed/simple;
	bh=DceKwVjihrPeNuYll4AYwUb826BrPhH9qlfynWqNUqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrzXvQ7HINuKCuq4ioSoKCz4OPwbgm8ScJheOA7GsOMmjT3Ta/cp26jaKhtsC8reSP3vw5CC4JTmWC9CCWjq0H6mHL01LtzrYFoI+GmEUUmama2qIupNQqRNFj3TOQQW2hSiKNsLqO/qOFHNX8lei4JUNplg6bwtMpsctgrjjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAPLjFaE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so375994266b.1;
        Sat, 02 Aug 2025 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754124847; x=1754729647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU1HBrAjgvLCJiyBijqBt4BoY6iAZYa6lIWj6WSABpM=;
        b=AAPLjFaEsZiMIBgBxUFMX28OspMENk3JHGCw+gHX4KA+5H/lNdWRi969qOaHTx7R5B
         MrHvEeICqsw9YberH9EAy/3jxvwF+GNHsQLP7LcW7IfZKA1B3C0hTXz9amF6yF4jkXgv
         V/miEds43QoQccdZA+P89l+XHbO5dI4zetQrrCd6tdYo5wsFkkvo2l05aGzV6Rw3Ga8i
         R+UsmVT6Bf8nPIRlGtbUt5coJYhJx7dI9AUWXzcfEBz8glj0xXbeQGj9kwNNnSKLKCQL
         zd2QkkPNzjGbTJD/8jF2a2KfGiwxDROaYmVlShokIpDl6/sjP0LG6isGip0fEI73b+ph
         RFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754124847; x=1754729647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU1HBrAjgvLCJiyBijqBt4BoY6iAZYa6lIWj6WSABpM=;
        b=S6+Jmuse9Rx21XygGldXiVPDbsa7dD7a5UfZJY6bEtlmqUyNPF4TND0z1hTQuX52hp
         6WJrVGuuwpiDm6XVYGz3O5ckrKfYzrdk8qLW1FPwyQzeJUfyfh3M99r4cgml/KHKakid
         ZCGlgOslReUwu7brlR5xznfdfNv5G9IZqAumQKD9JeNsEG9q0GxstA1l67DKA3jJOT6+
         ejVrLyd13dkYTSz8i7VXByBbjL2hlM6WprhFAUoybY8RoRgAOss2DDbg464xY5QwVgZw
         TUmLuNcoaN1aHoz7yvbsiENJ+YQWLYeEmIScEmDitNl9MQdIauZ3p3QhkrojurEZLffB
         bF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3SL8Z973OmTBli+9itlVOIEyxjKZL2sYwlBOREi7wWBzdmIofuSaR4ks6zfAYzloW3rKY4LHcacmn@vger.kernel.org, AJvYcCUUMRx1druffZsykEymFzE/4VEihcfOFcQBijIAd2PMMezf0WXjB8bTFVJ/Ybe/Tf+hPUfWF+wjDdPv@vger.kernel.org, AJvYcCX8lPcWnzv3JOBLN8GvSm4B5+PY1zIGi4I0EF14hyBjGjwY6iDQ3ixDFU++h87ygRUvaOonvgzCXKdE0kYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZI/Bp4eJTYaQJVeiJv5U7FTK3yTsWJ4uJcdeaD3g2VJKYlaT5
	mbz60DY5+WziR2bhOSrE+rUovrv+9pQNEQa+6PhZhPLIaia2dMcHDaOozXOgI+cLQQ63Xw1woS/
	q6oVeqIM0g+k/AhHfw9XHkW83an7mCQI=
X-Gm-Gg: ASbGnctTnV0lVatwU/cVAxWDvkz9CxHzTHILuPim6jbeOHWC0UNFkq03dpBtic5Bb4+
	uaFPDjh2vfBrOyd78qpz8tTf225OK+Q5sB70eW8wP+CcFRwaKDtUVUMDyOovpHwzpX3KoRIwaEw
	8UkGSkbZQMSATYCaw9W+2lEUNMooEWHF16LWyZ7qhElhCBXfmA2zml5ypkxLt2JPbAwBiNkdYAu
	DVyiJUAcw==
X-Google-Smtp-Source: AGHT+IGRQIv8+UsCudF7XcTshc97KPBhqgCTBCwoi4BZGKhvyPN88Z8+rithDAp0yFIHck8losjT/A35Y6AftYjN1sI=
X-Received: by 2002:a17:907:d8d:b0:ae0:dfa5:3520 with SMTP id
 a640c23a62f3a-af9401ef899mr234980566b.31.1754124846997; Sat, 02 Aug 2025
 01:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
In-Reply-To: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Aug 2025 10:53:30 +0200
X-Gm-Features: Ac12FXx8NIF0XC58CyyLB8MuiGbhCHGpnva1k4JAFViKmoM8cv18zU3ke-gEGsM
Message-ID: <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magnetic Sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 8:44=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.co=
m> wrote:
>
> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
>
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
>
> The driver supports raw value read and buffered input via external trigge=
r
> to allow streaming values with the same sensing timestamp.
>
> While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus

the sensor
an interrupt
an I2C

> configurations interrupt(INT) is not recommended, unless timing constrain=
ts
> between I2C data transfers and interrupt pulses are monitored and aligned=
.
>
> The Sensor's I2C register map and mode information is described in produc=
t
> User Manual[Link].

Replace Link here with 1...

> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/inf=
ineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-Use=
rManual-v01_03-EN.pdf

...and add space followed by [1] here.

...

> Changes in v2:
> - Drop regmap implementation in favor of using direct i2c APIs to
>   have uniform communication APIs across the driver.

This I don't understand. I mean the motivation behind this. Usually
direct I2C communication is used to do some initial checks and
configuration and rarely for the actuall run-time driver
functionality. Otherwise it means that the regmap may be used with a
customised read and write methods.


--=20
With Best Regards,
Andy Shevchenko

