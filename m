Return-Path: <linux-iio+bounces-22655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F6B24715
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345FB188925F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E272D63F1;
	Wed, 13 Aug 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2zR9KDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7023D7D3;
	Wed, 13 Aug 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080329; cv=none; b=g+lhg+G80wtyJ5CxWg8vfCp6R4Uvl8t2V228yl6hJXw700x5Vy7tO4sz47kwgWtnRZwn/8ACzigq1GoIm4twg7J3QLIGn3rCyxe5Q2IaolxfK+28iPuhNa2L0B4YUHsvXAgAbjFY+1omnnHwXodCwHsobIh/12r32SGG0jGFVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080329; c=relaxed/simple;
	bh=vVOv2yI6QFHHNY2oKXlrzYxsjKpiYtnVJcrHElYK1g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AarUlrssPkIx2ttRC6rgBig9pxbhlg1TSiZbqJQ50t+cO7j/rrU/qWhk3pUSZE+SFZwvG1SiW1CSwx+3AFqlPzHooOJL021pcwqcGkT3PYxyUnw246UsjEtxogk8LBOoq+g0Of/DIDW6F/QeOa372mJOC6rQfZmdWPhrZxtWtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2zR9KDP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af93c3bac8fso901052666b.2;
        Wed, 13 Aug 2025 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755080326; x=1755685126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo6gUfo+Gn6ecWVrQ1TwetIpAqzbUrV2lNC8R9kTkoU=;
        b=m2zR9KDPV+WiVqGWmqA9eHILmfHfA/nvdxz0yAmzLbdk9HdMyOL+lSOC2HLDvJIaqK
         TFdCah0+FCgEhBcuzjXL+CT6taWbcRmc1TNfJ72s3uXuiPVQ3vcy5tTXOPspdsQyHivX
         +GMPywNfmFAABcbnC/sfOv3LY4hi3uRg6S85l2dxuWsB1KQUStoKBScGnQ74pahx1ml6
         kDY7MxBKOwW1sniJRcpyjAUmyzjJALnbVa/1/HJB/X8E9Z1uqpztzL1RJ2lZrPa7SUXc
         uAIVT9iTGd3X5GGLmAmhYzmT4O4ykphrNR48A99ZBrzCE7oCuui82Crgagh8Zn4cFjEi
         P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755080326; x=1755685126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo6gUfo+Gn6ecWVrQ1TwetIpAqzbUrV2lNC8R9kTkoU=;
        b=h5J+/fnSSEuvN6bwFUqgeVw6zJmGS8kMGVPv036bpT/BFv72DWnO3KbBjsVxQSee8o
         plaaL2ePhg/ZjxozsSW+mhzXHZM3C4einfczPJ2mpsbSjYQAdzhitwjb7gHSlXUsOmWq
         q46Boss9R6QhiUvChMBEd0dix7cU6xxlPrSXeVC6QFmksAgqeGgh4UweOxeeq6Yy/TP5
         wH+K2MzAbgzujJRuJGp4ZD5jaALUzZt9S5Y+TmjK9/cO0lnj0XWG4zKGmgCyg/HSncjI
         byT9jHpbgrpqqORoMIPQN4wG+k/gOOYveb5qniEAX6aJBI5jc7VoD7bKILRD+qWLNSMd
         ptiw==
X-Forwarded-Encrypted: i=1; AJvYcCXCWwlVBK+RhuOvu9bcaTxTGiGIEMUP1/k+Lgm2PzZIaQOpbKMZuFy93cLxcREmUiUEPZFxTqqXBi2R@vger.kernel.org, AJvYcCXpoROp2r9nSxdxT0Xhxm7d1SWgNmkaMw6VUbDEc9uLODk1P8Mu1+MU6WKUG+WySvtv+5sW3atfD8hs+qLK@vger.kernel.org, AJvYcCXrRVBHsLcV4a0p04IYSKU70DQ94sBFkQpQUbsyPU7a9auphhOEZKBDzgUuqLwfLZsviEg2lpINqxFG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oLmNTORa8HdT1a9T9wUTvpH44YNb/LiESZNCZxvDGfO1+Qz0
	4MqoKAWr00OMy5CQz7VXNYw9wkcTh6U7wrdpkuGfNAjMqCUJir5vb/bQXMjxfLc7N1jEy01ZjkS
	icJsLjZBSfEBHhXmfil2QvMo0qD0qHvI=
X-Gm-Gg: ASbGncvpqA2WlYl+71nRe3Cc13GoIsCXgmVQ23miunbW9pXwzIo5c3ekcCWdYk7w0ah
	h8F816woBBNnjliw/GR0FyizkuGwZWa4tYTumFiGxLwAY3FTLpreshmZfyOQKTo6H/AfincyaZE
	5Fxzvl+rQBi9+JRBMhbospJnp3ZWPyIfDoqYaLXgcxSzSFdtTvbj5sH3zp/LVBHwRK91w9hMwO+
	n9jGYrtvw==
X-Google-Smtp-Source: AGHT+IGtOP5mjRNn489PVNmO4vxPIPDTQuikzEg1Mg84DhRNL/wstyNWuOrvAB/lXY3xmy0yJFQH+vb9BWKZDBE0wXg=
X-Received: by 2002:a17:907:96ab:b0:af9:3341:8dd with SMTP id
 a640c23a62f3a-afca4e0a53emr253787066b.31.1755080326385; Wed, 13 Aug 2025
 03:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com> <20250812-ltc2495-v1-2-7bf4c6feec2e@gmail.com>
In-Reply-To: <20250812-ltc2495-v1-2-7bf4c6feec2e@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:18:10 +0200
X-Gm-Features: Ac12FXym-72-12HeDvRzb4FHkYj8rPhzeDeFEWJF6uJcrP5JI1RHyGTR48Sg9Cc
Message-ID: <CAHp75Vc+XjiRoV42zuZDpqsWKLN+5=uv3wLFMk6LGUagmhBMMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ltc2497: add support for LTC2495
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 7:09=E2=80=AFPM Yusuf Alper Bilgin
<y.alperbilgin@gmail.com> wrote:
>
> This updates the LTC2497 driver to also support the LTC2495.

...

> +#define LTC2497_CONVERSION_TIME_MS     150ULL

Why ULL? (Mainly why the 'L'/'LL'?)

...

>         if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
> -               /* delay if conversion time not passed
> -                * since last read or write
> -                */
> -               if (msleep_interruptible(
> -                   LTC2497_CONVERSION_TIME_MS - time_elapsed))
> +               /* delay if conversion time not passed since last read or=
 write */
> +               if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS - tim=
e_elapsed))
>                         return -ERESTARTSYS;
>
>                 return 0;
>         }
>
>         if (time_elapsed - LTC2497_CONVERSION_TIME_MS <=3D 0) {
> -               /* We're in automatic mode -
> -                * so the last reading is still not outdated
> -                */
> +               /* We're in automatic mode - so the last reading is still=
 not outdated */
>                 return 0;
>         }

AFAICS these are unrelated changes. Please, strip them and if you
wish, create a new patch.

...

> -#define LTC2497_ENABLE                 0xA0

> +#define LTC2497_ENABLE 0xA0

Why?!

> -#define LTC2497_CONFIG_DEFAULT         LTC2497_ENABLE
> -#define LTC2497_CONVERSION_TIME_MS     150ULL

Unrelated.

--=20
With Best Regards,
Andy Shevchenko

