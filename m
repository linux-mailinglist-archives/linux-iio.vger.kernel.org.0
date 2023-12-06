Return-Path: <linux-iio+bounces-696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F13807C18
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141B12821D1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856522DF97;
	Wed,  6 Dec 2023 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Av2kQHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C0D4B
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 15:11:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f84533beso659121fa.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 15:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701904278; x=1702509078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym49stG0u9xWh5s5s8hZY+z00ruxCs5e0PfM7tt66xY=;
        b=1Av2kQHoRKJDsmIWdLEWyK6huRkQ7NeLAU4HUkqTfsBhB2O5tYlRmcLnNGIU1suHpM
         xwbjlwshMsNDoSifqEC96aXQoWuG+NB0RTi06toTRDgJ5jzlEYaqpdcGIkHcClq+1d+B
         xp41DReMCdIWRFyP9LlNe/oh9kXA/1Z9DO18LyABAEEx//2SG1rmEd1BI3MAt6WQi40w
         cgTY4e32UoUSt1kRG3RG9WQ2o4djaSaAHnad6lTW4Rr/87YzZgmITxvsJ59gLdYtSlif
         H85y03MYOppYeUo7c6hsIlzrAOA42Iq3hpW3JlydJjiedz+aHaCCV2QakfWTfLEfzEmK
         sHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904278; x=1702509078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym49stG0u9xWh5s5s8hZY+z00ruxCs5e0PfM7tt66xY=;
        b=SQoH+5B4rwkozGHFZF6UZgbHGRaC5/lYsfwEhn2Ni7TVmZGzWsaN4Lw52aArrMJMsF
         MnFnco2gz+hGghMZU720BKFOO0wwBuFc0JA2udgGYFPIh4nbacHbXEKh6meFgBvWEOMG
         5XV1BCvs5QsPrHjBiQ4wDfLtDXGA8GdEjv/xisQu3uHlu2BzF7a7K28CZk/QYofIHV1N
         dB7KXzmj0FFCtAUlv9lCzBSABG1BfnJUEI9RCrTBjl8kHMccgPzXelcJy6YX9qKRwTGv
         WTwb30TCyxgwEO/2gcmDZHQIFKAnhISQXfkp6v0eNjqoLpGYMIUDnFlYILrwfoEMYD79
         AMwA==
X-Gm-Message-State: AOJu0YyfRF5GpxBuX5uYZ9jRA4hcYrpMqZ5iFShcFE79Q7vhpPIM5shF
	fY/kniL0vNCwH4tF8fpZuOIlL2sKdq9OW6MMqYODiQ==
X-Google-Smtp-Source: AGHT+IHYEkbaSNFJmoW56K8HQxEhSuS1Dx3NtOal1I92UJcMhXVyYLB3RTnbwHU6gBVhIW4PxOnb1oT8uf8Eid8Z0vs=
X-Received: by 2002:a2e:880e:0:b0:2c9:f9ea:efa9 with SMTP id
 x14-20020a2e880e000000b002c9f9eaefa9mr862555ljh.101.1701904278574; Wed, 06
 Dec 2023 15:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-7-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-7-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 17:11:07 -0600
Message-ID: <CAMknhBHowwN=xP_zC1MYchfzm5BpNakPtuejEYcO6gRO4MtwBw@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: ad9467: use the more common !val NULL check
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Check !val instead of directing checking for NULL (val =3D=3D NULL).
> No functional changes intended.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---


Reviewed-by: David Lechner <dlechner@baylibre.com>

