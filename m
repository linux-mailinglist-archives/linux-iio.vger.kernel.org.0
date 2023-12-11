Return-Path: <linux-iio+bounces-814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92C80C6D0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED5CB20F17
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601252554B;
	Mon, 11 Dec 2023 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGjojkRK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC091;
	Mon, 11 Dec 2023 02:38:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso4168466e87.1;
        Mon, 11 Dec 2023 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702291091; x=1702895891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIWZGkYaLiXvO5c8m4S1KNqDxAm4uSiDYBVHbWNi0Xk=;
        b=aGjojkRKhEiNlXURQcZZ1+Gt845Rm7Pyj7G9KVlSNZSqgAJL7ZA6OMP9L7z7cWWW5X
         +5Zma5M6ON5BWcjKf5M71Bk1+PlhgJVmfQ5gQ4HIIORDzgvHWUZy5w7zbhyjGXaHN+JC
         7CcRd2kRVQvTRMGBstb0mSs8ALQvQQ1RdpmKg2WsUX7AUYGJxvtfYKBgQ/jN4vE4cVK8
         ImU9Hhg5EPvELTQ9ClqhqHkiuF34TjFUumqRSo+tqGg/tpQgZR+wxsai6DDXSXnMESpY
         5QeWtwraPgn2GHQpNZP1IWgwwJ8Emt/glDfpILo3qBydtHqwGNACFS7VSyO1qcWAoOYs
         4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291091; x=1702895891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIWZGkYaLiXvO5c8m4S1KNqDxAm4uSiDYBVHbWNi0Xk=;
        b=nKR58tAa1m2fyiTB9FynUqCME6BT9BLEvbynNVbe8Zo1JTWYYfMhGfK70OnwAJJM0+
         YQBpsvBHiYL6ezSQ6H/6P3xUQO0cyDvhLyUx8801cYWV90m42gPs7R2AIMNAbkvTzvFf
         BvKeFvZF2NJ4O2o9xF8QSPlQCf7UbU0fV/x9GjC8qsTLRiZYy8HxtJ37QktkTHZF/XSj
         h5IvpSt5bvuAhRW7xW7Ya/v9ZFJlx3WURyUOqjFAcJwFciMusGKGAjzOT/GcgiW+HoE1
         ompZP7xB7j21bory7WKCPJeRFa/kHm6NISbAQUCa5nS4IXr2kYBrEio3pJrVDX6UNGFU
         IV1A==
X-Gm-Message-State: AOJu0YxkKzRPDOitPimxj0pvHnecWGfxOhQ68Pql0BduU+SBCHQK7NJf
	8+PiReWEZwNL49j1PxYYuuOdCztc825+DETq9xM=
X-Google-Smtp-Source: AGHT+IH4PNWvt6tBdwhsThANC4nGzclaoIAF9vXPA6oGnAJcKp+qYKIkkbYewPVr9w5TYoQtIEbxGx80LcG9uTZ0AME=
X-Received: by 2002:a05:6512:3da9:b0:50b:f776:1d72 with SMTP id
 k41-20020a0565123da900b0050bf7761d72mr3429278lfv.24.1702291090714; Mon, 11
 Dec 2023 02:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206134655.559474-1-579lpy@gmail.com> <20231206135148.559564-1-579lpy@gmail.com>
 <ae0758f3-ccc5-49a2-a37a-42925f4b0944@linaro.org>
In-Reply-To: <ae0758f3-ccc5-49a2-a37a-42925f4b0944@linaro.org>
From: peiyu li <579lpy@gmail.com>
Date: Mon, 11 Dec 2023 18:37:32 +0800
Message-ID: <CAELPsEZEMY27wuQWKQJ5k1qyU9ZvsiT0Lqzqy-MJy69A4v5S_g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: humidity: Add TI HDC302x support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, jic23@kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, lars@metafoo.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:42=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> > +---
> > +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
> > +
> > +maintainers:
> > +  - Li peiyu <579lpy@gmail.com>
> > +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > +
> > +description:
> > +  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> > +
> > +  The HDC302x is an integrated capacitive based relative humidity (RH)
> > +  and temperature sensor.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - ti,hdc3021
> > +              - ti,hdc3022
> > +          - const: ti,hdc3020
> > +      - items:
>
> Drop items

Does that mean just drop the "items" tag or drop the whole items with
"- const: ti,hdc3020"?

Thanks,
Li peiyu

