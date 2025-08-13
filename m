Return-Path: <linux-iio+bounces-22659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9EB24781
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9FA723B3B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287592F5308;
	Wed, 13 Aug 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlP/e8YE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604412F28F4;
	Wed, 13 Aug 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081502; cv=none; b=GBJIg7tMC3cbK1FX+XVNQGmeniNL0VQ+4FDCn2bYHCPa7Qlrh1m3YT2CyyDzeAB3xZ7a1ZQuiVnoOIJlyPF7P5bPGWW4+1pLd2Bbw8BAzwoCmD+YZ8LTDwI/cooxGgWXKSX66nSU6H5I8fCcOjNdXNAkCfks6Ab5iSZXxBQY0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081502; c=relaxed/simple;
	bh=QY7qr0I6LgMrOyOYt+AMt+NPx5uOUbX04ftyQkj6SWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7L2ZVzKQbZhUkubV4PQBdvf4unjDoRfzf98R8snZr44UwKufFOcCIFDRX9m/4Qa5xtdN6Nfvbc/0Sb4gZgxUN4pMbWXtqwoY6zKezall3kV2b7En5lblE6nx0ufALqkfDQk3VkTFVOdLtLXMtnRDUzgm/hE167fdSKlMcpXz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlP/e8YE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af97c0290dcso1121671566b.0;
        Wed, 13 Aug 2025 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755081499; x=1755686299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T35sU1adLWCvhuxOUIoOZX8UAkanpK4deZEokYRD1p4=;
        b=jlP/e8YEkoqbkjAD+3GVhhTid0waijHh6DKxGoT8wsl2UuOdcCgPbUsgyzpqpxkxFP
         Fg9O0S81r3a+JPrwDgMGhH/G6bV4V1360hdEnMP9ggeawhBb4G+x603vfLq60k1t/Hsl
         gY+tgKQU0FnxvdGl6bftGRvQd+mwZ8HpgTqz4H8z1RqIuv2IeUxwtWUL+XDQ7E9QIOHU
         ITKnmxKDRPcA4tG57/jztLz3n9mTcSwvOOwdqMyW4wXYD7tQaJe647ToKtIZMuWx72/r
         +7/Xo9JBUfdWqacIIKOGvtzukDJ0gCs0D6JGeSW1mgSKouAoSc3a5O8eRSVhzeRtqRr6
         kXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081499; x=1755686299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T35sU1adLWCvhuxOUIoOZX8UAkanpK4deZEokYRD1p4=;
        b=TpNXwiFoe7vjEXM4De14Zi6g9IC6/beA+3KF1Y0CFEvKRWLI/pOgbFls+SfN39H6ax
         0qeyu8HDiw1PWjy8Eqg2ZI+KCBgj+DZBsyILXpg1ML2jp783td3cl+k9buCcnQeCERVV
         cuuAEbg1hWc0yLCWH5eVMP2WWtqMFMHdtqch9ONvJKaGEK5ICyUbO7dIv4fO+2c1884r
         GTeUSg4WSV4la3aybf9J4b7DNj/EtomzfWomAUDksKdjYbNjFyfN0heIPHSnQ/xvt5qX
         ddTGkMb5Jif3eM+3jJjcp2FO5CZeoSazQ/OEggr68de2PvYmfB+w1TUGTN44Sguj3yTq
         w2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjPa5sXSFkiXqX6M7UhtwTHpUR5Sq3SVJrl9/RRiFzlf28Lh9Fj/Y2p6cioP6GxKQBzaLSsHFyZsiemyo@vger.kernel.org, AJvYcCXexlExl3DXVMFI2JmE2/wfd1coP48b1uxeqyV+2yasYdunC03G7JMBHOKLx3UgpzR1YlqItpEhOMow@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqg8uAhNfFMhqNz6SxFGRenw0AlU6I+O1arOka2L9YZVp4bvnP
	fmUjbT3IOf0MuJUg6kkAhA3Lxd0ZpXn6/b5AmI5ahRlXXNPkbZONiw+FehBOoc81smu9leX0HUk
	BF+E+sS9Sc4xmwqpTX57xLQyMYTD8NbI=
X-Gm-Gg: ASbGncvaLXxNybZ7QCMtj/0JGi1xwYxbXCeWeRXI9sM0gRxba+FdSJX6NwMiprD6XK3
	Kk7aiMtCTDtbw6bWzzoCSQ5ZzKU+CdrpEiSTX2KCR+fXtf7LnfnbE+QF+TiMWOVdQRgBq/blRua
	ddV4/uLQ9bTGco1gVycFpmPhS1Ewh1OZGM5R42e8WI+Yc7eH6FLeq2eCNKeemPnZ63BtFTI0QWC
	j6wlsiv4g==
X-Google-Smtp-Source: AGHT+IFzY2SW1tfom/cbI5ohrcUDZwwmQTP7hgfgfJHhKN0DKqqhI7h6V16OuwW9LzO1uU/N7vK5gq7VS7+RrZmw0I0=
X-Received: by 2002:a17:907:7f0b:b0:afa:1453:662c with SMTP id
 a640c23a62f3a-afca4cca53dmr209419366b.8.1755081498439; Wed, 13 Aug 2025
 03:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754617360.git.Jonathan.Santos@analog.com> <22ea35425827176a842ea0e523040acd20e27bcc.1754617360.git.Jonathan.Santos@analog.com>
In-Reply-To: <22ea35425827176a842ea0e523040acd20e27bcc.1754617360.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:37:42 +0200
X-Gm-Features: Ac12FXziAOSc3nNSdGsiq8kv16tCP1EIJfQsHqVPui1mj9F3XklHBlI4OKk26wE
Message-ID: <CAHp75VcArEre81Yhy9NcXwHGXUZkuTWxrQ=q2Kbs4KX_22s3Ug@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7768-1: introduce chip info for future
 multidevice support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:49=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Add Chip info struct in SPI device to store channel information for
> each supported part.

...

> +static const unsigned long ad7768_channel_masks[] =3D {
> +       BIT(0),

> +       0,

Please, drop the trailing comma. This '0' is a terminator, nothing
should go after it.

> +};

--=20
With Best Regards,
Andy Shevchenko

