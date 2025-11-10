Return-Path: <linux-iio+bounces-26147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B713C47F50
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20598188CB73
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F65127CB35;
	Mon, 10 Nov 2025 16:32:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3891EB193
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792376; cv=none; b=GlLcT/kMSJMdUocKhuALg7ccsKsl3Dwy6/VqoYM9LP3qBjyOKLrWTWyfcoxPo1xU6nbKfo5x1/maD2PU+Va0t0i8fpH6h6EeXhoy39xDT+sGJmCekQHUaCkOduS0Zxd53VVRdeFKpTJVqvE9yeGbRlCDyQsn/cEZr/GSGoU6LUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792376; c=relaxed/simple;
	bh=vGMbit6ddUlwoxrUxi6IwHq4K44T3JViUun4qtrQOtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX3cnVQDEN4hBC5AisB4aMXqZX92WqanEUU1COOnSrR07I0y+XeJ+yNBTPa8Jg0I/mcz9npzbsMpWplU0DtB6dkkvTCTh58yyXK2ohPQqoY69sCC03uScBKOd68AC0WKNAiqNbAnS8y7ofzBtNwMcBwaPnOr88LcUHN8JIqoC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89019079fbeso763475241.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 08:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792373; x=1763397173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHzMucwowrWDP2Qt+Y+UWKgurmYAh4juIylWzobpf/s=;
        b=t/F37nn/HvwzfoS/+oxn3kSXoQjsoHbGNIIBdmpXlPWdc1gxTjJXhnVOnhA7Bdjr7C
         xBjwV4DN22gtWgEnuge5xCeMQhqYxHb0ZGSQ/RV4LJXAfGH7y06xfvILQ290+9OECgP5
         qgR4WmjBIh90uEKuSp35WuDJbKtJJNlXW5va/ndOQzIonbIqvJN111OO5y5elMu5tzwQ
         ch4OcwQwTyuftxXb4hHoUZ3bumHWzj4RWEgL88oeqhQaARy4KPWF6KWa7JHPPWZLCntQ
         49CUJZ/ot+bG/YVo0wkNiECd3fFfxDhW+SzEHP8aDizBRURKul/Kp6kp2Sn+2rntZzp/
         Y5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXEqfQ2lASm8BzD0+MVANqungmWdbQtuyiiWt0hxOGv9AX0xXizH0h0Qwd5EPlk4xeE2MKZ30b9yp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgChnhqEttYjqmFUcAqw9HnQO8+NtrTrWQekiAaGtKAnTe3+DF
	8h3/3TfL+SMszegg0dl/Fkvufoq9u41BYsdp72EAKPfGi1eg5N1fpTq7jP1qyIw0
X-Gm-Gg: ASbGnct4LDplKG9SlSyKX4/l5YtudvpUuXRyxbvx2Ly4IOFf2nKvDn04V2w3pcwBbYd
	qSf0BKDJrRQzUmukcNRLq4V2Y4nGUi2QeI5gR5Tv8b/6iaOvP72ClcR4DhqRSGp0kGa+yqEiZjE
	Oy+vaoQJbPmR6nWhb/sPx3z34FLg1gC1/N1GsPpTeHdDebJBXi3K46CwqwWqH/RibdSQnbME1+b
	oaK9W5i+cvPpKaEDgGKEhCxcCbsXCZ7t45NOqhJeZqvLme3JG5PTU2ix6Um1u8R8mQG8JDPmprN
	ZaI7aIwM9V9wLtalVwRFjM9/Fq+833oVS41AaTjzfLgtIIyvxdXwwGdkl9mrJvgwc3DWDars+w1
	KIjNX81D8+W1uYiZiGE6qLpBHpa7scUMN5vquos35N+ReIiCL5usb9DlhEuahq8mJLbA8amTFfW
	l0BLXbnqITev4XAQ5U2r/lkH0gSaFMt74TOg5Y7ihQqR7RBRhY
X-Google-Smtp-Source: AGHT+IGh8RidmtISnBY9xyxa1FaoLeWjI/S+Y2tQgN4yYalrdAIw1IWJOiDK9uEReMOAg0QAPauvbw==
X-Received: by 2002:a05:6102:3588:b0:5db:e96a:8bf7 with SMTP id ada2fe7eead31-5ddc46ab475mr2107100137.10.1762792373012;
        Mon, 10 Nov 2025 08:32:53 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93718cda6d1sm4197908241.3.2025.11.10.08.32.52
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:32:52 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d758dba570so1482028137.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 08:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD38lbHb4KYpDUiUfvf3ZOLmKb05NLTEVwz772UyKAqgZXTLCnZy7QVTJnXpYMpJXWWVc5g92mcZQ=@vger.kernel.org
X-Received: by 2002:a05:6102:c8e:b0:519:534a:6c5e with SMTP id
 ada2fe7eead31-5ddd57eb0b0mr1693520137.33.1762792372340; Mon, 10 Nov 2025
 08:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103141834.71677-1-herve.codina@bootlin.com> <20251103141834.71677-4-herve.codina@bootlin.com>
In-Reply-To: <20251103141834.71677-4-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 17:32:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFOQANqnBX7nNST+WRxYz2j3gznohEZXF1SC-GyjDuGw@mail.gmail.com>
X-Gm-Features: AWmQ_bl9D3O0uVkd9QcrhvhsjRnIq7PDvVWO1-VB9dJdhU03nrwxJGeIcNitAIk
Message-ID: <CAMuHMdWFOQANqnBX7nNST+WRxYz2j3gznohEZXF1SC-GyjDuGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 15:19, Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:
> The ADC available in the r9a06g032 SoC can use up to two internal ADC
> cores (ADC1 and ADC2) those internal cores are handled through ADC
> controller virtual channels.
>
> Describe this device.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

