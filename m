Return-Path: <linux-iio+bounces-5913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F828FF065
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BAF289A2B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D2197529;
	Thu,  6 Jun 2024 15:10:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE6196C65;
	Thu,  6 Jun 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686612; cv=none; b=chEOlVN7sbjx1WYJH5Q6TkKH9rzQgohIGL+Q3Yof01udrXlrf1RMODrTDy1K/1xZTbArINydAucZhTHqsaP/VK48eaTO8VzMiK8ue9AOtUaHRVwVAKdZ92NAxbqp/c3616uge+ax3f81ujA0SoTUtks4n8LU5bl7ONT0aofOwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686612; c=relaxed/simple;
	bh=ThYfWkVZq+xxHPZzWBX0JDqaDQnqCEqItdLxeyZzmFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCvOKWB2rAWBjpPn9PwoZVPnWB4TaHRaojhskulFSBWqjD7zEeZl8PRKm6HPGJw3VHJGpXklPBLHPuhx1pqpmrpznB+hrmuhpM8MoTBCopJtmo+OObJPZHMdLGQJNVvdvxpt7m8HS8jKe/HWAY4mdAV+8+lNoeE0DsNn81aksIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295e488248so1320613e87.2;
        Thu, 06 Jun 2024 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686607; x=1718291407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jOGBua+p9M0Sd6v07XuabYs/DUuTufTW2i+aDQNa+M=;
        b=tSbt9wMi4VYU/D2aKeMVOE3gGMoa0GE4XPGsQPkjxROfY/6MY58zUz/hPC9K7+OEmq
         bICy3nqyxLc6/y29d4685hvy9xYNJdAO7DrkYzqhyPsrLVCxD0912MJTHzA7+VxD/QI7
         PuM+8SAIXVrUjnj9txNCbp4Ps1dFQKHrpZt1MIlI2ulAge6NbtaiAR3mDrhkPzJdqxA0
         tr/UrXu23fqvDMpExAdhDBJlkSFMb3qGUHQxldlBYvhJ/IXraN23ywsTpDLMYKdTMSuS
         jSoKDrGiBXDllXfG57jLO837oygGzyhE3GdRveDpQUAGjqHALEMlbEsZJfIOBWriWrKZ
         MdqA==
X-Forwarded-Encrypted: i=1; AJvYcCUsjCZoqlZSBZ7WW4pHTXqVRs51wvXR0LwWv/gFxdaA0HXrfT6OhS19kzn87qJhh3+VZlYKMSnnuz0ZTnnPY/pXTWSo+ytp7KRYHbeqkP5lw2asmE9bEgEqL1AYIBYjw+2D3xJE5TB1anreAfT0i6SXFaN4zS+ZG2ATZq7OtJDvHw==
X-Gm-Message-State: AOJu0Yxk2r5ldfZIsMkSpYPvDmoNeQ/Si/DTrS0kbK0ADJ7EHJGepXrR
	mO8HSC4oVD7HLtpZJTqewQiHu3GBWB2filmm7s3fyNuxjHxW8UPFDALaFeMn
X-Google-Smtp-Source: AGHT+IHfVh70HmjGy3/+qXQs7aeOIu0ot1qZIVqdIMrutTJ6CiOVYkEj3FtiF9HXSA24ffGlGEvsaw==
X-Received: by 2002:a05:6512:2f7:b0:52b:95c4:4641 with SMTP id 2adb3069b0e04-52bab4e3661mr3043795e87.32.1717686606411;
        Thu, 06 Jun 2024 08:10:06 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423d533sm219951e87.183.2024.06.06.08.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:10:06 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso9030591fa.0;
        Thu, 06 Jun 2024 08:10:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSTmLG0YfVPu9dc1/JFtzyWkoHiMWk11SOZIMqe3a4KDcutDqxWwbH/HTgEsJy3TiJ1d+xCI1CuOTutpMT8NCoOHtto0y+ICtw2yi8SvRm5LnZK9s+Wuk1aHBryGlvCTFbTivzFtjmSxJ1RxJUDVzReOJJiGU5spBj8Mr5OIhEbw==
X-Received: by 2002:a2e:854f:0:b0:2ea:b956:db16 with SMTP id
 38308e7fff4ca-2eac79ba896mr33235911fa.8.1717686606111; Thu, 06 Jun 2024
 08:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605172049.231108-1-macroalpha82@gmail.com>
In-Reply-To: <20240605172049.231108-1-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 6 Jun 2024 23:09:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RpyESyzVp18EDCqkBQ-A4j9LYhXQe+bJOP+MGbUsC+Q@mail.gmail.com>
Message-ID: <CAGb2v65RpyESyzVp18EDCqkBQ-A4j9LYhXQe+bJOP+MGbUsC+Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] Add GPADC for Allwinner H616
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, p.zabel@pengutronix.de, 
	sboyd@kernel.org, mturquette@baylibre.com, samuel@sholland.org, 
	jernej.skrabec@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 1:20=E2=80=AFAM Chris Morgan <macroalpha82@gmail.com=
> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add support for the general purpose analog-to-digital converter (GPADC)
> for the Allwinner H616 SoC to support the ADC joysticks as found on the
> Anbernic RG35XX-H.
>
> Changes since V1:
>  - Split dt-binding include additions to a separate patch.
>  - Removed patch adding compatible string as it was already upstreamed.
>  - Added patch to add the adc-joystick function to the RG35XX-H.

Please carry relevant Reviewed-by and other tags forward.

ChenYu

> Chris Morgan (4):
>   dt-bindings: clock: sun50i-h616-ccu: Add GPADC clocks
>   clk: sunxi-ng: h616: Add clock/reset for GPADC
>   arm64: dts: allwinner: h616: Add GPADC device node
>   arm64: dts: allwinner: anbernic-rg35xx-h: Add ADC joysticks
>
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 11 +++
>  .../sun50i-h700-anbernic-rg35xx-h.dts         | 79 +++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c        |  5 ++
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |  2 +-
>  include/dt-bindings/clock/sun50i-h616-ccu.h   |  1 +
>  include/dt-bindings/reset/sun50i-h616-ccu.h   |  1 +
>  6 files changed, 98 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

