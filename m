Return-Path: <linux-iio+bounces-4061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB989861F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE419B21B7F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5D839E5;
	Thu,  4 Apr 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlXbY1WY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E027F7C8
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230664; cv=none; b=ncL2c6udU1X8mksKzuLE3Sc3iB96Bd0Mr8yPEmmQWMWCySZsj4OpAK8r+unantrMVl2vuiUmFKCe77yDQyxfC4H4ceTA0ZVYTDgWt3xzuQG0837r7jU+g8HqYBcdRjnV8evN+VDHBH0hq766jf0Kg/BtqTFyNIAf9aQAXra77Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230664; c=relaxed/simple;
	bh=0TxjT53bZ1dq1CHNeD8eIJFhqKeW4Iu7Nye6eOxj58s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quI6TeLkXgDheXoAOfW5nCTFKcAjQHtn6DdNVycmVlUr8NwEKF7bzIPQ1QjVZ8H94h/Ij5hHfqm45qAV85iHA11PVzJdYL6OF31mPg3GR+yiv+Bdp9pZJaGyUjfjEkkf8cnol7W/yEjr06YSNybJgK2i34+4akvQuZ0o7mFe3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YlXbY1WY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6114c9b4d83so8298437b3.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230662; x=1712835462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TxjT53bZ1dq1CHNeD8eIJFhqKeW4Iu7Nye6eOxj58s=;
        b=YlXbY1WYuP+vBADpugJVaxuoJU2vcevIUbNMBeRx1K2W0hHu7ys+qHgwf7y9ozJhP6
         z0HwxZT0te+S8HxvCwiC2sMsPJqxAcI/gK+wXcL6GZ3JY3CyQY3xWy6da9MPT+ydSqff
         Z+oS+RJh/EqOPM/a3IAcbaAgXSf2teL9BPgrAXOVzBWjN/gx8CsGE7X658mUXsleJl6c
         9yHaU+2FHfrIc+0rcCTZ7DI921ocKpVMUsGUyzzP7YwR7dszPb7XRgq27gtBfPUo6Qjh
         +DpMdetDIGLBMJ3RPQxfg032ECMnK4jq1nvuC1WfvqGJbW5eneBzGKAExC1kuFdpgXn/
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230662; x=1712835462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TxjT53bZ1dq1CHNeD8eIJFhqKeW4Iu7Nye6eOxj58s=;
        b=pPWR+GdFCRUlDB83XL3vyOjOSUOm07UDz5gkEgjEAJIpFO5qkdsp0RrDKbZ2uONolz
         vtMeUkqxI74gbMt/FJGKggAMVWeBkBg2TyReZpikXzQR3GIbz4zlETD2jmic1t6l4MTW
         8fMoRfOMEyiWNE77/bkVm3pqX9+08U5EUn8z7Q4+aPmec1aHPz3flIJxp630VuRSx4fG
         2aTNjBTyHAEHQYyxR8cNuJTeSdV75PgD3olty+DlcSBRB2VcuyUGfnyBE2J/RUdZ3fER
         ApTZqpVbJ7Ytt7YfQ8BM8iy09xTIEGKiBjI6+niDbrDcvK/bEuMItcSCAdOoU4/Ck4/S
         kBtw==
X-Gm-Message-State: AOJu0Yz9kxU5PkY/PK3qGzJYZ8Y0icHwQjKFeH3dfsYn/PjaLzesg94O
	A1IfhB9zyuvTeY7rvUNdwP9gECK8oX3daW1KZfoxDpfYwztOF+qfnAtm7ryPyqkNq3fUSYOeTnT
	2uysZ17s94bcXFNSkHJ3Jv3fRQLGaWWivS8D2lA==
X-Google-Smtp-Source: AGHT+IFYEBsIKezbtgKbEawWWwemMnhtBhmtRro2id4I1VHv5fa3egft11jWYpeN/GpHG2ry1obumDH9xjSoWk3os/I=
X-Received: by 2002:a25:bac6:0:b0:dc7:4460:878a with SMTP id
 a6-20020a25bac6000000b00dc74460878amr2069900ybk.3.1712230661955; Thu, 04 Apr
 2024 04:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190849.1321065-1-jic23@kernel.org> <20240330190849.1321065-4-jic23@kernel.org>
In-Reply-To: <20240330190849.1321065-4-jic23@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:37:31 +0200
Message-ID: <CACRpkdbn+5KNu7o4K2+9wNpSjbuXQBgMNPhrM=rM2w_aXXi_8A@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped()
 to simplify erorr paths.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>, 
	Mihail Chindris <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This new loop definition automatically releases the handle on early exit
> reducing the chance of bugs that cause resource leaks.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Neat! I love it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

