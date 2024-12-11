Return-Path: <linux-iio+bounces-13326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F49ECD3D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B09318877FA
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0622913C;
	Wed, 11 Dec 2024 13:32:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365023FD1E;
	Wed, 11 Dec 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923973; cv=none; b=ekPfJXMd9rCg+WB5lJKON4PvTr6dIO5jNAWQey80t/tuI2QPPFUTclYTf4xV00g3c3qOVvPO2jMVsudobtFQMH2aWLw3eu3CmbHMOqwKzjGyuCVnE4sYMoHlJyDI4++M0c7MhBhLy8MJNb6AO0BnAMIrz/OYmJDEmpMNaip2GuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923973; c=relaxed/simple;
	bh=WBpyGmIb70wg9K9GwaOM4gN82HO8z8OSG/O0/eeYFNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hReiiFgfKE+OFNZXSOwhf+B5JydZHnil97qFBRtaFGn8QlBtS2fLj+C3od1XoVq/KHtM6Y3sHStRZMV6dgYAjnlrGfza2vNeIkDym3u0hYfVxJEbuvCnQMMjj59q398of9UgjlYHQVhCtXGAYXjuXtISV7gxsLu7tWirQvsSzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afd68271b6so1505798137.0;
        Wed, 11 Dec 2024 05:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923969; x=1734528769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWGPA9eK5LfhZIVxz8KXWeG48hXCJW35NUBXQ7NNPJ8=;
        b=E1CZtHYGcqDUOdSF/jHdg3N7s3rG6phqGG74h+eupU1mf9MqIxfeQtwujGwzWtmlB0
         I81CuraBdJ8jqcAKxf7ZYnA4Lg8hDet/akJN+J5LL8OkIr0JE89WG7gggUR7gu2q3no3
         jGZzkfsZP6A02uNUj9UmHXr/Y0ySu3e6x30RMljrOpfdjHtUfQ4TQQY9lmW92MD4IWes
         2TV6gVv8Wcozw/UcB/0hwhzorD7Wl3L+2Ss96z4m7OxOR0mT8KelU9MArfO66zUOJ9gG
         8T14FPO+Z/vY6SLeGBYWocJwf+1OkZ5k71ipx+OgDQcYTsfBQ7/tohqMzyWwjSz8vg6k
         r8oA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYvMdse7bPNR3yTZC/4P5LiCAEqzun4TD2EpU3EE+oH5CleC+Dp/efdRCYBAdyXtR4hvUAcn6rjbu@vger.kernel.org, AJvYcCV9fC517rSKQZ5BsjTVz90VJ083lHT6MkcuUjddtF/8s+uE4Xm3M0s9U+CMiwh7GRdd5LyFHv535cLrcy2G66rpkGs=@vger.kernel.org, AJvYcCWQiIHGKAb/6eI7XAU3vinzBsLcQHclRTYMIRHgn6y1eD/bGyloHlwTgFZS25/1tWT75AN+qccVbHTs@vger.kernel.org, AJvYcCXNm1SLOIpS1PTyMvKloiNkxaoycUuqxplixLhHWOrACjkriyMXlS2c2rpe97BYarCk9ok8w14SmbBp@vger.kernel.org, AJvYcCXSVoFi+HDvrQsqrIbDqdf1TkVlAEIqKzLn4/GnyurUh88SxZtHWHyuh0bC6pYi0wUKOanE7uYhDTa9YceL@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhM+XFZlRnfFv+Vo1SXE56yCTCupHUozqeTdtMZf9eylYepKE
	mt04a0F+kptvjBDzGrnIYM/HPZhQ9VHr67kOBkO1hx5Oaf/anvT/p5S2pHRb
X-Gm-Gg: ASbGncu5e73GoxiblbpZeeSltqAZ45DkNoDxLIo3325rE4rlI7SHQoWD46Fo0KCIJx6
	oierMav+3OX5utd1zi15XXdyrKAaJQO56ooEAuMvtgqBvAgdYpzcXt5ytebYpZPWbYqjuhDbFJd
	tDrgZj8lEpILZ9F+g7QBeGKoLxKn/9ACSUOmHlspfKVqetrIx4UGEGiXomtt9C/jSdH0yvZ1+Pu
	S4rgbMzNGk1vsdJH+DFMX9VwnZUHyK64v6pqYUvf0zq7oc3lbJ790/6P5/wGCqMcBwb7FCEZWU0
	DXz9fCr5h7pfA00/
X-Google-Smtp-Source: AGHT+IHjDkl/ZJ0BrMEY4W5QAo2VBdlQDLSZZ5oerYsa27e5xs8LPz8RoxK6+BmavjLuLfZJ1+qNjg==
X-Received: by 2002:a05:6102:b11:b0:4b0:93ef:d573 with SMTP id ada2fe7eead31-4b128cf0887mr3390198137.0.1733923968985;
        Wed, 11 Dec 2024 05:32:48 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc94sm1423319241.16.2024.12.11.05.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:32:48 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4b1279ca1d2so299247137.3;
        Wed, 11 Dec 2024 05:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUE5nzAbVJ1V6tjJxn1nmQ89gfqMcyhNKJnNbVWom5pmkEUJfSM0yj5cU1kNC1IyQratXiiVNPc4mMk@vger.kernel.org, AJvYcCUvfq5L/NOne520Wkkz3oSYQeB1+io9AdYkkVvOGu1nTrJpMfh7AnMSsfCxVhXTrWOAG4is2k5qranz@vger.kernel.org, AJvYcCUzODeLQObdv85cKt+ODxa2aQcDhF7RwMHTv/0P3De0n1m2RnAqmTfkum5MKukg473PqsNJyzBH9o3qJUuG@vger.kernel.org, AJvYcCWIK/sjHHV5jFCP3JT7O11PK6qb6V3DRX6/vLFS9a60BONl3vcIxvgGXT2rLEn3Aq8uQxejDeCbUZST@vger.kernel.org, AJvYcCWolfmMO2DNCqgvrRocPUYicLO1G5ZXZdqz16igJYyTSkUshcEJ0Cl3MQVb+klzOa6fDpbEz4uPuSUcUSfvZKa3OJY=@vger.kernel.org
X-Received: by 2002:a05:6102:5494:b0:4af:ba38:d04a with SMTP id
 ada2fe7eead31-4b129087fefmr2891431137.21.1733923968163; Wed, 11 Dec 2024
 05:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Dec 2024 14:32:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWU5vV_Q5c0NgJ2yF=BwHNX25he3OThbLJbt0TN=sbwGA@mail.gmail.com>
Message-ID: <CAMuHMdWU5vV_Q5c0NgJ2yF=BwHNX25he3OThbLJbt0TN=sbwGA@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:14=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable ADC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.14.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

