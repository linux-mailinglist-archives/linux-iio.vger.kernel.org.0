Return-Path: <linux-iio+bounces-718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27120808B6A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC63DB20E18
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451E44395;
	Thu,  7 Dec 2023 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FgTQXwvW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD91719
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 07:05:57 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca2573d132so10690841fa.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 07:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701961556; x=1702566356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50wXkgxhwd7VVmaWItypX7buhSjm3DOhX6j7yctjfj0=;
        b=FgTQXwvWgOkOb+XnUO8F7ebzTfoYVpygk/DCq1H6DLE6OSZHGGEMQiHY+U3HjSwmAk
         e+ReqtFwxzGqJcVrMRKJGqWaVRrjOu0bsDndjdLKZ3YV+mBAK51Ua2Et8sQTsKo3RQLE
         FfufyTykwPVF0sbajz3JRI/nzBIeqlBwQYgbqVMofoAhQLtvXt0HYZlbPtyv3YoL7mHI
         y2ajcCUCbAj0YXJGKMkDD4a/oq2PKSIKyhOHps58Nn+s037sIn1k9HERVSJjnt1giAl1
         xIUrL2yddcwhTI3OgxGOvTXCTkBlYHFUtCbLADGRyEVBu2Iig0ek7I9399g1MzPqbD4I
         V12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961556; x=1702566356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50wXkgxhwd7VVmaWItypX7buhSjm3DOhX6j7yctjfj0=;
        b=lZCnvQGFg9Tq7psWjeY3E0A0NVJVVkVg/MbB0jdTEXf9CqWBEYnM/kJ7FY4Z0X6u6S
         WjEeRATuj1tw3Zw8gYnrlGE/w1/Pa9vIL9v1Fb3OhoEZV5t6YALKdnAOQG/luaeL0iNy
         wOFgwccE3dW/UeBzGeJ8FfziHbdQHZzmuW3b5aBkLt5AWHEgD2HDKJASKk0WbA7OTQzA
         FQDS4ThVCiH+fY9RNWQOs9jd8WytFU6yE1N5BCFl/Yzwp3yAHquJnc3EYy9dZQGsY2eW
         SKg5E4QNFUyQ4oZ1J2riCCHUAXKht0Y5tb3EWHnYnwCaTPAzZOIjQ9MKrrnDSlGi5uqT
         180g==
X-Gm-Message-State: AOJu0YzTQRYkvjeLAUisbeUogdyASBiKWm4sA1xD5mg2a95efaiVjIx7
	w4MR5CR8WJ5j1M+oQTKnJXANWUYr1F/2w2WuTr4thQ==
X-Google-Smtp-Source: AGHT+IEtKGO1yIab3lvfo6J7IHc9cEdvzxFKzgdCy7hRWL9U+Jldi6OQhrIneigiTax1TWBDYvt6iTGW+cnqiHueJdg=
X-Received: by 2002:a2e:b781:0:b0:2ca:1b6:61cc with SMTP id
 n1-20020a2eb781000000b002ca01b661ccmr1539368ljo.100.1701961555147; Thu, 07
 Dec 2023 07:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com> <20231207-iio-backend-prep-v2-4-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-4-a4a33bc4d70e@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 7 Dec 2023 09:05:44 -0600
Message-ID: <CAMknhBGZzgs_EBZL8oPsF+JqKJS968XmAxZ9=TZ=g9-k6RLGGQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] iio: adc: ad9467: fix scale setting
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:39=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> When reading in_voltage_scale we can get something like:
>
> root@analog:/sys/bus/iio/devices/iio:device2# cat in_voltage_scale
> 0.038146
>
> However, when reading the available options:
>
> root@analog:/sys/bus/iio/devices/iio:device2# cat
> in_voltage_scale_available
> 2000.000000 2100.000006 2200.000007 2300.000008 2400.000009 2500.000010
>
> which does not make sense. Moreover, when trying to set a new scale we
> get an error because there's no call to __ad9467_get_scale() to give us
> values as given when reading in_voltage_scale. Fix it by computing the
> available scales during probe and properly pass the list when
> .read_available() is called.
>
> While at it, change to use .read_available() from iio_info. Also note
> that to properly fix this, adi-axi-adc.c has to be changed accordingly.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

