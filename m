Return-Path: <linux-iio+bounces-24659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F12BB3E96
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B701C2852
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012473101CD;
	Thu,  2 Oct 2025 12:40:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EB537E9
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408801; cv=none; b=dCyauYgVSQh2/ymAl2PwpnTWe+dB39aKPWd5olSy/Yqff38+UD1zkmXNBEqtsdKcL5K/roRrN9nqXnWwrUG88097jT56fERF620bRX4OLe1K3p3dSJE3i3e+WkmJXVffULhBnQYwcv0qNzSKC9dHTv9LUeJLuKCSHg93WKGS3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408801; c=relaxed/simple;
	bh=7O8Q6H/V342Hk9kSuK7PF1mqEQCZDCjvYkaJgb/FMnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZCLBqT05knulRuMV2KJg6syNm3gs4tXl0gkms4e5T7c04m5wIqXa9loCyt1IUDvwAmwoReKQoLVdysKklt0DI7L9BHfk3/UoAh5eeo5ajrsCwdzYC1v+F5gR5FanLS+2KI/3YsGG/Ng9smPD5+AVOdA8ZfVVPrvuvtgBkDdvQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so968717241.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408799; x=1760013599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJG7Pi+JGjs1abvLn2qtglQhq0wRNhthICu3ohkXyqQ=;
        b=LSzwAPJOsDEVxDV0Whaqykz2dT92XN/gY7hBLQeO9y6TgNWfpAwTG8rTCyEiT3/IJN
         VuoBUEUz4I6HfajZAZCi5SRg/CNCKb3bXjuBKEJ7XkE8fGWTLOc5oMSVeVhFWrvvud8i
         NByWRTSAMoP92DH0w6wF9OpwRcP3oULtlO77nID15MVfTQAabI7pJNGMWTm+fs6uHO5d
         gV3Nh0PeaVnl/3pAeXJu7GZH1WcUKjE8+qWOJCVE1Qs/cnJQDgfPHsf4GdAo9XZ8TNf6
         xvIQR71OOn0OmUYDcWWZWmGX3wVkQT3xgcHmCzkv/pU5cptUjHmq73N5nURCbswfi4NM
         nz+w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9JUH/goI1Yy11nadjn1ataVO9Nbg7Zilh8+8JFCIlM5fl6Nezcd0AfqwklLabc2j0JoqSFuQmZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcMSarhIr7pRCgzfESoW/ojeBHcHBbTCCf3IL78PEZWg1fKK0
	UIc6PAqCiOuUjkCMIrlYMbZ07WWy1jGqHViJPEU8FG5W+qhirSCWbLF4GttyOX2ZSGQ=
X-Gm-Gg: ASbGncsxVt9CrR+IkmTjwdTt2jNN1Zw1FRZ2csdGWm17RJkPsgwZPGXawL5lFFSu4JR
	rLEAG/X0N7nQmpBxXDeP0Z+ZQuTGwHa70L1B/OPwUTbPpcMcJp6lQ2Iy7kmQDvEhNEEKfJidAjx
	3sqjny3qyu4qdJzCI71Erh8DlOcTd8pa8SJ5bk8PFElONI3q8ra8DqemZXyW+lOquSozhAcYQf5
	emkZlSuWaemZNVZ/TH7fST1fRoZPZlMLYkvcUDY1h5fWD/zu35evjkn7G0rEXcbd1/oyhNavuOB
	x+K4w28v8cBvz3/cma725QZbxl5GddYS/s3CpWbT+DXeYe9hseVgHW712VIWk3vIue6aP4k77Te
	OdA+3jFQezIBniWBjZQuamUw6ZyGZ9yVxbK71ZRkZChDQ0k+vMib1F1W9DPkCmoLU0mFukk5boB
	PTK61ljgbZXmYFPHoDf4g=
X-Google-Smtp-Source: AGHT+IGcemBOdhFnvdgk513ULhnouliludHlDqRnq3H3rKuDq/iW9BYRvoi6nVFiQy7Gc6w/czjmPA==
X-Received: by 2002:a05:6122:3c48:b0:544:9f73:9b46 with SMTP id 71dfb90a1353d-5522d4f9e78mr3184454e0c.16.1759408799003;
        Thu, 02 Oct 2025 05:39:59 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf3e2a5sm453678e0c.14.2025.10.02.05.39.58
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:39:58 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5b62ab6687dso1098191137.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGXKECAojlH4AnLAO5uprxYutOqKyeM/6t0pG9ugOiihV7xE23JEOj/cPcbFyVsyyNX/2NNOyS0Tc=@vger.kernel.org
X-Received: by 2002:a05:6102:390c:b0:529:b446:1749 with SMTP id
 ada2fe7eead31-5d3fe5260edmr3028987137.15.1759408798147; Thu, 02 Oct 2025
 05:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:39:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1kbS-KvD0mFXHiApd7K6K1scm94WBg-84MQPtN__h3A@mail.gmail.com>
X-Gm-Features: AS18NWB_Zolx4Yi5Ewsp7mWBmwmwJ9vX5Skmzp6rXOAIB3SYIXAxIWXsQiZ4XoY
Message-ID: <CAMuHMdX1kbS-KvD0mFXHiApd7K6K1scm94WBg-84MQPtN__h3A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The ADCs on RZ/T2H and RZ/N2H are exposed on the evaluation kit boards.
>
> Enable them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

