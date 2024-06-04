Return-Path: <linux-iio+bounces-5758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAE8FB35E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492941C20C8E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989214658D;
	Tue,  4 Jun 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/+oPtOa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFD143894;
	Tue,  4 Jun 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507164; cv=none; b=pgKr7ts/ihQT1mRWLYCdv8VTa0+kyI62PtybOKTGwS4VRhStna0+ojhnUECFqMnrVK5Za7XMYEFh5MDjcPRme9HLrYgitJL1ZNnxEsURp/RVzulfVnL03HlQwI7e2ija6Sf8ZgrDFhAKLgyolrHz74booM1uKynhHWVwfCx0oHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507164; c=relaxed/simple;
	bh=YJVMvwv8yrvbQTt6Dpj5ooLvEPn9RhqjCuP8saFqK3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsqTdT6blt9M4fjwbLwlwMBFNbaG7zorhz4165nUImB2LYr7hoyqiXMygEAT3c4h58UhN2/UcJo5HNmhMSN56GHGRLdxVAyRty0nUzmny+wJHQ3SCXQBoQZh1La16zNP15wPEnBFx60qxLo2QoGAzF7YIXn9F94SStjhT9hHmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/+oPtOa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaacaso724800166b.1;
        Tue, 04 Jun 2024 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717507162; x=1718111962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJVMvwv8yrvbQTt6Dpj5ooLvEPn9RhqjCuP8saFqK3k=;
        b=e/+oPtOaXQuov5rdz6D9kWR08s4lYjkQRAyXSWKHY/hN6c9F4nuuAPSoAkSg4AoJx3
         xzVkgbGiP+4u18nUL3cwM95g+NNxeltm8lsYu7RVmGkqdLpTPBBCHwnTE+9V2L38Lt7j
         a3MHcGVTnlo11AcZL9Ku5CY6mQ33QJsRCVF1ytlAflFMNtWkpR0zqA9zVY3UbfJKH/KI
         jg+GEx0k+mx/W0V6DYNUiYHCiQpokhmP1EXrTUu+1D118iUcMzknjmc3x/W+sBYGLA+h
         y53HskVEBRE6VWT0L5zI/fsn69EEtWpPOPJ2/t8rAt7UwXPnxsuN9NiFu7ApaaCWB8N5
         2tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507162; x=1718111962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJVMvwv8yrvbQTt6Dpj5ooLvEPn9RhqjCuP8saFqK3k=;
        b=avwTE7IRt1XmroK2GCTK13N0E9uCqiEUiyRiuAtAE7DHeaTDQQ/rp4SNy5TmoTd01c
         Emd2whQNhNRxehLEAtTCxOwNnAb4jMQsa69FbtwUusZyjAlxiRAWxCCZG2aIeRIzlsk+
         TGR2y5AvC32Gkyh7sefqlTPniW4quwG4Q6sNTkC1Yv/JczIRZW0rbL5qwFbpffJcl+3K
         pw2528KLyp9MIOtDM+jxWLn5e6zV9Ztu+0zX09lQTRPICQxPmKJuWfQU8BKq+xiG33n0
         bKK9VJ4XdmvdVj/mYYpN//rJtI8WPMNrVZo+TGRxiU1KRsphvRou8wwJGhhHG9VT1kfx
         4izg==
X-Forwarded-Encrypted: i=1; AJvYcCXi9mWqdUffGyw60STaCIN5NxmgWO7y5x+Udxj7KXCr9Iz5tDTc+IUd0EiEzy37t1gWgr40qF4I2AFcURzf3vB1iCR/1ZuNUL29onCu3eFXwmOSyboZGFRlOFvnww5dF4mqI+moBEvT0INyp2GwfwIZLKpxl8f2vJxUCOH7lQcwCjk6Jg==
X-Gm-Message-State: AOJu0YxnAgsC0zCxEQjgdsL8DHVQjOVZmgD6hkeh9rY44BoRsX61SQUD
	eqByl5q0oDzhTJA43eShPobBoTZElLZXSYTQe3VvAHwi2R1yM3FjgYUxn87UqCz0GDhvzw/9pHw
	u0wVZp0HBaxPe0WA+fgOAsxaObYg=
X-Google-Smtp-Source: AGHT+IHDbpSFR8VgGbrUMxndBUIdfujfvQsl0DAQdoYXCdvQ0K5qPJ6brxy9idGG/uw3HyLxGrGZcT0HjfDhQ1mq2G4=
X-Received: by 2002:a17:906:d794:b0:a68:eca8:2d3e with SMTP id
 a640c23a62f3a-a68eca82ef6mr449184766b.12.1717507161399; Tue, 04 Jun 2024
 06:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com> <20240604123008.327424-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240604123008.327424-4-angelogioacchino.delregno@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 16:18:43 +0300
Message-ID: <CAHp75VdtfsSA7quU3Eo0=Yv=J_yXVo5_+_WgxGFJ5M_MLbf7NA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] math.h: Add unsigned 8 bits fractional numbers type
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:30=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Some users may be requiring only rather small numbers as both
> numerator and denominator: add signed and unsigned 8 bits
> structs {s8,u8}_fract.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Thank you!

--=20
With Best Regards,
Andy Shevchenko

