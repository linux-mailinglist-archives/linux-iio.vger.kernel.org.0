Return-Path: <linux-iio+bounces-522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CCC7FFFF4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6816FB212B4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 00:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A217CE;
	Fri,  1 Dec 2023 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EgkiEx+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9A10FF
	for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 16:12:24 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9bf8964c3so20326071fa.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 16:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701389543; x=1701994343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+S6ZNm0KY70bzKBdaXHGr9e7p3t5vwxIYL3G+hCH9Y=;
        b=EgkiEx+Vcd230vMg3k+g1khMK+c/37irFitUfftbLmkI4ENDgI9Hg11raTawsFLvBg
         ThtPknKqohzR7RhnFKEi0fh8/BUGUhpO7meziEFNb+uNz4Mrifx8ZGIcNL9qtbONjUh0
         MS07QKpp73AUuaD2UcQOp+uSSM+wKSXnh1JlYClAl7sFd/ZN1HSA5LX7WtZC1jv9xrpS
         Ft2jse4sT+pgn/7jiIDv6JkhHsJoZWpyTbDOATsrGrR0OaibWQDkfQEURJRZUG1+piTX
         Kd+WCKjx5d9+FlO9qX9O0speDuN7qjHmZrArsy6r3uViBuOE492X6gueHImwp+WHY1fq
         Wh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389543; x=1701994343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+S6ZNm0KY70bzKBdaXHGr9e7p3t5vwxIYL3G+hCH9Y=;
        b=RH+kbBUv4DXh9xdV9ZSH451mcUqCpKNGj4+ib+yUPfEYrmory2kySmFTlBNVLoxlD9
         bF1nuB/fzANaZhwolwSYoIJd8ySAE1zFqL3wTjEd+yFuWBkN3RlL8XGfh3tyqYkVnUXA
         0RCOBpWpeLLm8PF7NViOR0aMznEMy1ltx2Xen1UPQpCYoBJZpkNSAjpTuA9frqkqBdam
         JjKf1b7UItwFbvVrdke+cEkSDD4o3g7w3ZB8QC2pbAZjNlvgjCuXnn3YEBfU+s7M7j6+
         HypESB8EWIvtrrTJFJL3cZlRtOWGN07v0r+z+YfEmvUmmK7tWMyw4OIOveuhFNXjXntI
         543Q==
X-Gm-Message-State: AOJu0YyOdjK1xpq9UTj0p/tpKTJrYjPOBqGNQidW16LuEEikVAmAbVHr
	T9qja055Ry615V5CNd+5RP6z79uE5cR5rZOUpG0gqA==
X-Google-Smtp-Source: AGHT+IGsS1+sHRmFzKHBh3sQJBe24WgzbWubLmdDK9T41aJOvKZPFcBk2x+6D8vxIXt5dM/JwNd7Cmh+ItiUzD/BwPg=
X-Received: by 2002:a05:651c:23a:b0:2c9:d862:c66f with SMTP id
 z26-20020a05651c023a00b002c9d862c66fmr217019ljn.92.1701389542959; Thu, 30 Nov
 2023 16:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
 <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com> <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
In-Reply-To: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 30 Nov 2023 18:12:12 -0600
Message-ID: <CAMknhBEdXNkpEt-kXBez7zC0XGvo8AZ1G0Y9Y0XVr2EmpA_Qpw@mail.gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
To: nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:30=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay

<snip>

> > +       st->back =3D devm_iio_backend_get(&spi->dev, NULL);
>
> Based on the descriptions given of IIO frontend and backend, I was
> expecting this driver to be the backend since SPI is only used to
> configure the chip while the adi-axi-adc driver is the one determining
> the scan data format, providing the DMA (INDIO_BUFFER_HARDWARE), etc.
>
> Also, from a devicetree "describe the hardware" mindset, it doesn't
> seem like this chip (AD9467) should dictate a specific backend. I know
> it doesn't make sense practlically for this chip to not use DMA given
> the high sample rate, but why should the devicetree for this chip
> require it when there is nothing intrensic about this chip itself
> related to DMA?
>

Afterthought:

Put another way, it seems like it would be much easier to say "I, the
arbitrary frontend that actually handles the data from the LVDS
outputs, need a backend that provides a SPI connection to an AD9467
chip and takes care of turning on power supplies" than it is to say
"I, the AD9467 chip frontend, need an arbitrary backend that handles
reading data from the LVDS outputs in a very specific manner that is
determined by the driver, not the hardware".

