Return-Path: <linux-iio+bounces-697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AD807C3D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316431F21941
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF752E3FE;
	Wed,  6 Dec 2023 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a3vyMMYZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60310CA
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 15:19:03 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f57d9952so716211fa.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701904741; x=1702509541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxrtHT7s6IcITHCFNYQ+kwwBou9nM5qBTeueESClJXA=;
        b=a3vyMMYZooWpXPy0Ojk1h97s0wKxsBzJLRiPUBTXl/EJ1vZdS8PqeXErYvTXnc7lkG
         +AF/XKzFZO8EFWovkWwMStXSUfv4zqBPwurpd3oQCpskP73KNGdkdf+U6lRPuuitBfVv
         bXCpAe8DPwU2NmaTmKdkq8FCrV/J7ST404R9CEwymzFThl1hUJvBTS58CCawSAT7fZIG
         /WyRdE2TXItJT1uCGi/C8xAxaxtqHXqw0vmcni1/Cj2xPH+p/xb+cwwJQZMmnlkA9hnL
         HzanhPf5U8JA/L+Bwz5RDnP+Xy8UwqQB10Lg5hf4BLWc0ylkQi/iLGcTwBvODefC/8tV
         NYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904741; x=1702509541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxrtHT7s6IcITHCFNYQ+kwwBou9nM5qBTeueESClJXA=;
        b=WDk7/CL1D+AVJUziCtzTRGGHUtgqZhRMZpm8Q5Ni7LynENYtsZtE4g9oQ4Ee2uez2p
         QOrUe4CR6Hw31PlwZbqNDMRpHJ6QPi3DR2enw1g5JpXYy8SDeTG+XwkXpSTPBD/rk4VL
         NsXvoIP6HGbwyhLaHJXTHtWhzio3zckm43jac8IFWG+/CVvLso4Ltv4gj8wX/re753OH
         ove4NiDSVbvIi04TXiBzusH8+lQUcq93gPCpkJLw0OYXx4tvoftcLnf0fGxQC/i9msWf
         6zrJuob6eIjcyewCqK80E6+hugAq9FqIuXujKsa0E1AdZ3uava2amAv8XBto0ZpJQUxm
         tG1Q==
X-Gm-Message-State: AOJu0Yx6x2kUAnAsNQJEjOnGdCCklsVHHiXCV7zWlflJ8Cfgd+tVwg/Y
	/z4oTqsZCn73pXFaTYwEsMurZTeSVtJO8AfqRO8dVNK8lQp8uJDt
X-Google-Smtp-Source: AGHT+IF3mG+CWQDAWK6KUHNEEEkZD//9qLPAEGl0CLIZUiby7wApo6wvDg2RsD/hR9JBfX9hnS6CR9Kj8BXNsE0Gpts=
X-Received: by 2002:a2e:8ecf:0:b0:2ca:c36:f4cd with SMTP id
 e15-20020a2e8ecf000000b002ca0c36f4cdmr882415ljl.82.1701904741303; Wed, 06 Dec
 2023 15:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-8-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-8-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 17:18:50 -0600
Message-ID: <CAMknhBETZMD2DUJKXsFQW1rHjhEM4rr-s9GpJ5=nHWH-ww_Vcw@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: adi-axi-adc: convert to regmap
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
> Use MMIO regmap interface. It makes things easier for manipulating bits.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

