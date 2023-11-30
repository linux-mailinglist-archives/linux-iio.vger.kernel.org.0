Return-Path: <linux-iio+bounces-517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93347FFDC2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E4D1C20ECA
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C895A10D;
	Thu, 30 Nov 2023 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gGjZzwia"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F710F9
	for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 13:44:28 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9cb021d5bso14862271fa.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701380667; x=1701985467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZqiHLWoReq83Cxef52pZESC4paMXVnCulpFCcMJGI=;
        b=gGjZzwiaGXEFeRkNwS0s1Jf1Q9LfP397rmDZkkjcz467+1msr+lBUBNhldQJyqR6JO
         MXlJIJtSV7fnPmAqmFJnGh3URwijaT4sUI0GKcyyw9uadU1ZAaBMXrQTT+BhlkIljKhD
         7M+rM/MiPWyN4CpXQ3QI5umIuDDSsqsrDiBsn4CXYkoIP2DiuMlgpnBtC+YCChjhaNBz
         NyQRltzYvmupPkA/KmCvGfGr5ByVcbzwOQQf96uefxxw8658BPVqnPGJwS7ZIQf/Y4ey
         HSXhAuvy7OK5GrbZLjMWe1v7omYdj6Q1p5CdYvXhGbVLD1+KAU8GZUWq0r5xbJ8IIdbm
         jAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380667; x=1701985467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcZqiHLWoReq83Cxef52pZESC4paMXVnCulpFCcMJGI=;
        b=srsWsaCMvr1cI2EXLFXHMM/hXkB5SUQQRCk2YlYEMiQ2TrmtDARmCdauOhoyp1N77H
         Ccagc1vnyInAbctYLttXDzrznQ3INy2fjCP2vhDFXT7fXB6LQZn8gEIsLFy30QIj7mPs
         QxRAXLHt7Bys+XFQUJWofzd/qhhptUKt234fBs2ymWihPgP0h+/FWYKGJjMnl4pVgLVI
         MwAi3c/TIdX6AVSrLJltImkCRfN0dxGtOYgxZJv0ZnUzcC/fiJup2Tv5IHeSOkdDtlet
         5tiWl4krpKpbOPQ1hBep0TS5u7eTWxoxJh6hEAAhDDXRW0y9KZ6jKXlaEi108PHHovAD
         ExJQ==
X-Gm-Message-State: AOJu0YxUcWag8O7AhXVvwkL8Vgv99Mr/qvhzKwE+uz5iH9uxt7hz8h/w
	00Jx5q9l3gQnY7iryUNtQ0hT+DSOAcKLmy02IpNZTg==
X-Google-Smtp-Source: AGHT+IHLWvfu/I4foDw3iXqoTYiQCncxW1ovcM/HPP3NH1jlHK/mie5mYCLySX0I3tqh8iKe6sLn7oyeamwjSluzVSU=
X-Received: by 2002:a2e:a3d2:0:b0:2c9:d872:abe8 with SMTP id
 w18-20020a2ea3d2000000b002c9d872abe8mr130629lje.102.1701380666724; Thu, 30
 Nov 2023 13:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 30 Nov 2023 15:44:16 -0600
Message-ID: <CAMknhBG6Ji2JwPvmBQQkReTf2ocfypOpbVBHK1s27=myeQERTg@mail.gmail.com>
Subject: Re: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
To: nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Make sure functions that return errors are not ignored.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 368ea57be117..04474dbfa631 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mutex.h>

This looks like an unrelated change (should probably be in a separate commi=
t).

>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>

