Return-Path: <linux-iio+bounces-18158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E1A8B27E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5727C3A7505
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 07:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4F822D7A1;
	Wed, 16 Apr 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw9rziFQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67922D4DC
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789453; cv=none; b=bR+Er4wSDR50ixD/LrAe0DhtZugOJgJaJ9V+rqulsoULEQR6iwENx5eqYhQEs5WLBnrEM1kI5lrOWISVm/8BydN86492FJciNUWBxnNS1almqdNt+EL8CfbQxmqYh2V1UC/clD4Hf4bFUYXxXDXIAUcsOFt/M7/RuIe6tU2aSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789453; c=relaxed/simple;
	bh=w7BUvBYqTMm1Ze0afEibdThADpsOyoFKneytr7BCkqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQfUrEYhrv2YBXkvnibMFkY0U4nDZ/clxOi9lhDRyzajZzVU5wPposT49hW3JNJtO0FkjjyMJDv/fVFALp5ngkLCFIm5LSiiV+Wh6s+RuLQhKtTURKAnae84IxDmmAIMgHhi+7HFXcksh9HoKRO51p4j6t8lCS04RUPTms9Fb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw9rziFQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54998f865b8so1485840e87.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744789449; x=1745394249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7BUvBYqTMm1Ze0afEibdThADpsOyoFKneytr7BCkqU=;
        b=Iw9rziFQ0zflq0thJE07XZeRtG5fvZ/UHqo7sL7GBaNh2gWnF/3MHaGz5+4ixr6pk7
         V/lAf/TNIXxPlzuBL7+uhsdWqGzWGj7dwoqFVbnrMFQkCdgF4tI+lx0ay5Nv0HdfTtDw
         IgM1sFW6iPaEc89Yr3Lvnus9Qb7n33KGMypsVe+P4GyClXjIeNd1O/WfNBG/nroXjPjn
         hn69/rtZhnOSiBg5G5lv+cL+yi7nOjttmz01oO0VGhGF2fkXXj2k4D1SJxveuHxvt6hr
         owg1y23r5FbLoiRiMFV48r048dIcmIc8SfiRqGQ8KCxFcDxZGW5bJZbjWeoNbSpHUeQp
         U60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744789449; x=1745394249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7BUvBYqTMm1Ze0afEibdThADpsOyoFKneytr7BCkqU=;
        b=lekEDyug5R1Z7BtoghuwTJxP5L9+sskK0hN90U2LxBmB9T3vWSWC+RLg61SkA+Deb5
         Yg1uyT19yrATcOUlH2nQU+DdYgApIGhF2HI4c6CVLZgdi93Uu/V0FyYfrxAQ+ZonUQq5
         UoNHxBJVRVF1jgM0TtaMzNNqdRVvQHZe6bYjqeVPA49h4SpFz6mh6JdG1MrnGNz6wLH6
         Ui5d8RKwxEIYdV1Rr9JeJ9Le9r9l/yDhB2NPcv6a1gqPDuU4yoEZHSEOzKRd1KO7kb9w
         8ST9sA+dUv3Ac1FtuzQ3maRavoYM1W6xBJXIvwCod4IAneWtJbSWqNzsYO309LKxMdIy
         k8Gw==
X-Gm-Message-State: AOJu0YzVIoBsLE2BWTzMPS+Pmx5o0Ztl4UE7eHeRY5xnHxmpp/1wEALd
	xN4rQ2u4n4OWjcsgfC92G1txW5b+hjWM86e7xw1PfPJdSSNH93VPaCGrTiWZztXrcNwsgkONJTU
	B44p7QZXKJxVaZE9GXGgkrFCp4juWG0SqWDBQzQ==
X-Gm-Gg: ASbGncuVlEzIVVCMn0yZGKCn0Ez5Op+Hj3ixFjoTNJJUxKYXqGBVtLhW3vjSmG5Lh+n
	sDS2u1vU8vmvTMvAdDwjyStOXKPoT31ubXPl8iagojKKLBIS9wW4yBjnPo9FSvN1ASt6nUppgsL
	zUi0XQapacq76YM5/GSERgsA==
X-Google-Smtp-Source: AGHT+IG0Lwyub0udHPr2t5fpOsIZ2RLg7Lkae30HWcbs+tlOsVB08fWQavStEVsRHF6ju8VE3aya9e5Yj0LjLkUgobg=
X-Received: by 2002:a05:6512:118e:b0:546:2f4c:7f4f with SMTP id
 2adb3069b0e04-54d64ab0b47mr201581e87.28.1744789449414; Wed, 16 Apr 2025
 00:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744325346.git.Jonathan.Santos@analog.com> <414f5b60b81f87f99b4e18b9a55eb51f29d2225a.1744325346.git.Jonathan.Santos@analog.com>
In-Reply-To: <414f5b60b81f87f99b4e18b9a55eb51f29d2225a.1744325346.git.Jonathan.Santos@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Apr 2025 09:43:58 +0200
X-Gm-Features: ATxdqUFrHLfUgDMhA2bIeO0emn67mugRA29Aq8hS3KKX_3FOQ4i_PWerQ3Zb48o
Message-ID: <CACRpkdauyPb3bhgK4MTYN4Xq0cM80vwT8i_jcKoQcicpvMo7yg@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] dt-bindings: trigger-source: add generic GPIO
 trigger source
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, brgl@bgdev.pl, lgirdwood@gmail.com, 
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

thanks for your patch!

On Fri, Apr 11, 2025 at 5:56=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:

> Inspired by pwn-trigger, create a new binding for using a GPIO
> pin as a trigger source.
>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Is this actually documenting the trigger sources I implemented for LED
here?
https://lore.kernel.org/all/20230926-gpio-led-trigger-dt-v2-0-e06e458b788e@=
linaro.org/

Then maybe put this in as Link:

I tried to figure out how to properly document it but I think it was part o=
f
dtsschema and that may have confused me.

> +title: Generic trigger source using GPIO
> +
> +description: Remaps a GPIO pin as a trigger source.

Please write "GPIO line" instead of "GPIO pin".

The reason is that not all GPIOs are pins. Some are other stuff.

Yours,
Linus Walleij

