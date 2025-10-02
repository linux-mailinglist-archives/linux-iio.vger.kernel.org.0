Return-Path: <linux-iio+bounces-24665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D3BB476B
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C519E3965
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA09248F5A;
	Thu,  2 Oct 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM+LeLbC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B24679E
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421712; cv=none; b=ohXWEWcOvpeN0Y86inUtsCb3q9FddE91+Q/uuqQNDhu9hjfOv4lOGzLUuOZf/JiSu2X4q1x4bDHcXtOBeJ9tj0zKrV3dVVQj9Eyp7OyY931f1LDHg4n+3sQbhEKo/E77ZqAUhP9wbgxJ2V/1XRnSpy6tRTt3Qc4pFtSbnJpC05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421712; c=relaxed/simple;
	bh=l5OAi7HzDsDRfIL/UoL9RRK/6kinPrW4yzeqvaZDp5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmKZrctEkMCgyZ+Ujue2t9964tO00tHKvvESMBu2njf3rt5vaiB7HinwsJMg9d/gZaebif14Q/kHwUIPqLqi0zsshK15v2xprhZD7POj7loFfgcqVnq00+/33mMNFSkvfA42VlJzEnlsltY4b/UPJ6U/rh3vqOSZIE8uTNrr/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM+LeLbC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f605f22easo1278214b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421710; x=1760026510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbCJESHJ8jqO/tcwMWV6sW/NG3xdKaEr0isON+x8Jhs=;
        b=bM+LeLbCFBvZJuWdwS82NQ85eyhROqbgwavD/nx2IQ/E6ZP/s9zhKcfKFotyvSQVR8
         Y+IvgkQVodYtLJ2g+uJHNokxI4eKZOCp73m/7dqvb5Nr7ksOZuUix4D7CmtTZfoOaucj
         dYJ3+i85k3sTcxkrTT+BjWi+qCDrEQmCYRCdlvoH1mO3m0hEhsZcD8oW7nbbLnw8ZP4w
         DI3qcue8a80vSlhDMiudweRt0ftUHWWXBqYrIUvuujY0Swhv5XtQ/swW3KeEA/VZ4MVe
         E5MtPGewTghQIqZoJv/ex47GZtKc+mg6k7pOxBni5CnEiiZHg0YyFuq5Dgx9jzKwPQr2
         S6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421710; x=1760026510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbCJESHJ8jqO/tcwMWV6sW/NG3xdKaEr0isON+x8Jhs=;
        b=Eb9D1cuyqA9ZuePGDcLEtCwWKwZZwqce4uRvofYSMP7eiUagRnzcmL6n9qZ90UEF5l
         PMFPnBoSgEOQAZJoIwzeDNFmk+tSPKRX0qTyKa1vZxZcX6xkNwHIEO/fmO+VnpWEw8YO
         08x6kI2QO+G3cNsyDmFY563HNn2IgcdZL/jp96xmgpz5u1NpYR7NiV8PfKyxVj5H4Etp
         R/uzxgGqvuNeOcF4omGie9iTLqnIQ7voj/ZXJ7s2eO2PEVXk84BOCDuLGPYlr4ctYfZU
         w4ZkBY+6OUpQRfauGtruoT24ZwQJ48x/my8V/OvpSw9/KMIGxHF6JxURwhW2BXpH3yJm
         +A7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVREfBWgSCOy8NN2X6VcaXM4nUgIMdGQnbaPnxDoduGdXIbgTqqL/bpG4NMy6mqaE/4sEmrRrWsJ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkdfeSOKXx+myh0OVpZ18j01haLO4kkNThTOq3HtQlHlXsIyj
	y7xDHHIjkXMfX6dLm0bQxujL7EWTWaqrlrguzDFYQMu5OntK4zeDJpNP/nNGIogurH02a2HBPpI
	PyZmJ+4QuVaPbP0QMY8+VJ/faq0vOCP0=
X-Gm-Gg: ASbGncuajDirHAxL2w5TkK1cTtYQktIuRgySEWHK3KNbbuU0YQxyECYwvyWcFMjJCk6
	ACQXhJI/E4OtNR+XP0WQkFlQEVKbDyec+3xU3WVfUESOAWGPepuoGSb0H5oKqGjUrQngoFblYVB
	tIziu3Ce/vZ6TVniCvbXjqBPJX64JTZNJeyKuV4FnUVUSIT3cDxrKP5R9DrQd8oM+U+dC4RtNiW
	lLDz+hFbcXrEBusSZTcHaaqSIcgIEo=
X-Google-Smtp-Source: AGHT+IEf/mVaOwfwTajphWCRjS6OZaY41dyU0wDwW//TvmvlN1jWg/44MGVLKIueiWV72E2HWtd5YlRbRRes8q78y1U=
X-Received: by 2002:a17:90b:3ec3:b0:327:f216:4360 with SMTP id
 98e67ed59e1d1-339a6e749ebmr9175147a91.8.1759421710377; Thu, 02 Oct 2025
 09:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
 <175589097127.178922.52729764188594464.robh@kernel.org> <20250825115939.4c1ed3b7@jic23-huawei>
In-Reply-To: <20250825115939.4c1ed3b7@jic23-huawei>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:20:07 -0400
X-Gm-Features: AS18NWBZEPufzTSyN91BU_EyEGNa6W6EgE6V8aWkwSThLDVcbiogsfNGWk9PRA4
Message-ID: <CALC8CXfG1XrK4-HMP=8pRYhEHNY=A+J-s5rKr29cDXNNAUMkJQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup
 in example
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Kim Seer Paller <kimseer.paller@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russkie, you are a raycist

On Mon, Aug 25, 2025 at 7:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 22 Aug 2025 14:29:31 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
> > On Thu, 21 Aug 2025 10:31:51 +0200, Krzysztof Kozlowski wrote:
> > > The DTS code coding style expects exactly one space around '=3D'
> > > character.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >
> >
>
> Applied. thanks
>

