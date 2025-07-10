Return-Path: <linux-iio+bounces-21519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E9AFFD5D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CC3646BBA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A802291C38;
	Thu, 10 Jul 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndmpyqvk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4429993F;
	Thu, 10 Jul 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137888; cv=none; b=MLv/KRlaQ8p5Xfs9UtwG209EXYdWOfCPkDIeAZU1PTim8tJORiowKIoNui9JSSP/7zyWRrCCyMnBZVKrdY9okCyf40tAwL8zhoC0XMMI0Zg1mDqLj+fYC8NOYC8M2f+jY6CnBFQflpntLcyJ/3Zcu0uKLHd0D2sBdh0CVEfHh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137888; c=relaxed/simple;
	bh=ovY0wUbO/pvaHRTJ3gBlcrmaRXqj/rYP5snoHOc1kdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6+w7k0sKsqFej6drZBSAS1e55I3l2YdKwB+1x/KGWSsLs+1IfOsRkrnqq81W254tK4/BFOCs1i45tHQbYYX7efpizmgBEh7NB/MOcKFIkcewc+P47+kWyBpkqc62vGXwq8xoEZRLs5Yi19L3hnPcawhfnDQccgsmOE+2BHcBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndmpyqvk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade76b8356cso132896766b.2;
        Thu, 10 Jul 2025 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137885; x=1752742685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovY0wUbO/pvaHRTJ3gBlcrmaRXqj/rYP5snoHOc1kdk=;
        b=ndmpyqvk9WuJqukKF3xa5SvB9wrpnj8d/yJt1LMTLO6PV6id0uShr9SxtluSt43eHt
         O6+yjeSuiOkp6jrv0ZoYlH9Gcj/DyoYO9t1Kksd1LSu9CrAunSpU58CxLqYxFUmCuYAJ
         H4+cEmG43rb4VKooGmvHAvzD83kqjgQXhwzTLuuZkSlerfhOjFhwXdy6uECPDl7l6J5N
         U7p/3jJt1niHJd1kpqyIcWQUsJFRIXdu6JUJBIeMXGw1yKtHZ4Rz3mEhCVRU77pbd+qa
         4JR2k0qZsuhIJ+PvRaw8P89wR6dLdxsBF+6QKvCPFrX+aDsfGUvbx4ahBS5aW111UhN8
         CaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137885; x=1752742685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovY0wUbO/pvaHRTJ3gBlcrmaRXqj/rYP5snoHOc1kdk=;
        b=scWyzRQQABROgFdzJcP6PYlJcuAIXKWikJi61RAIBcoCcmp8/q31szYhTPCTwAkq4V
         UmiyyfOzJo0Cw5pZi98+i/J2EsCRw6tRxl9kTbeY1FH5qFyAfLMFGPPrYprpT1fAH2RH
         07UfYLMwPDGXig2kyNfPzDd2IUC8m5M5CzN60fklJm5Q1Yuy3Hf+MDl6uMSt1LpSAWJG
         cxmcMQ3c4+C5rFTWEJ8l+Ud+0MYrAzFWvSyV8q0sh6Q+NnImHcVmt6iRF+6V0j3A4mVc
         BEHBi/vA6mt6lZ0nUdU5U+EidfV9I5J3ObD+WMYuha/wHSoTcSbCL33CJcNim/EjTJJu
         EONQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42flkMPx36FRBrBhlsyrQrGGLgsJ8ge0lZO5eCPEYm9YhZTRGUVYjDQKie4d3k6S57tLy+qwgJ6LvPOmC@vger.kernel.org, AJvYcCUwgntsYln3YZ0l5+DqpdvWfqChbmR7OEOSmWN2gRiCc2ltWYGUdSSvnSREkxHbVrQP6OrebOXRJgc0Ur8k@vger.kernel.org, AJvYcCVBR1KDM/LoJh6pWZKsvtOFEGE2/R7F7586JKznMyhm/VRIZipT1aOi+XBcQW7I+FwAc94391tI6a+2Y8T6@vger.kernel.org, AJvYcCWUCJ2DCwBZNaeIftEj3wzo6FuRhsu1xBYn9+Vu8qoYwdMLXELBtlFsZrcknMG0lqVcPFmTCigV15ql@vger.kernel.org, AJvYcCWXOqgenQjF4+fTPJZO3YRs/i2HeuRvL2JJIrL+bwQbeszw1skoWwnBSEQ9d9fkKp8mJzcvF4zr@vger.kernel.org
X-Gm-Message-State: AOJu0YwCH3woDXeuC4Eud5JgVyu3sDxT5OrQw3HydnmRt5Bzlz5u+iXC
	OL3qOtuVvA5P/Tl5B6nuEdVkgbaWIzON9QpKzUm+IKB/JtMxCiSEaYiQdtJ4GJmOGfMnCDBYmoJ
	OYqtQmx4RnKGRA8KvYV++UbU91Hoe8YE=
X-Gm-Gg: ASbGncugAyc1O2je3NXsoTpzOSILa0ibfZ9BYia63XjNrREV9Zq3IqCTs1/bf7ekfKy
	DcdPc9EjYwKtHQuRtV3/xtcOHVR0eNCFYDF4QpuY6+4XIGQP+70vfvRlFweBUnh+8DYPhzZ8mMd
	laBfRlV3XEWSpDCtPXkgsZfgbTm3iAwddTC92QBzXrIheHrg==
X-Google-Smtp-Source: AGHT+IF4vkQQS93GlTFcXA3IUZu+Ie6aWTqS+ryt/tNRDWHUfU7VoFm+JQoC4Q9KZJPIsOeBw8GwkZX2MWvIWqAsv48=
X-Received: by 2002:a17:907:3f26:b0:ae3:60e5:ece3 with SMTP id
 a640c23a62f3a-ae6e6e308aamr206701866b.6.1752137885114; Thu, 10 Jul 2025
 01:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com> <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
In-Reply-To: <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Jul 2025 11:57:28 +0300
X-Gm-Features: Ac12FXxFEAw7JJzM8ZextWSIZ2sUSr-CBvVZPV0WO2mg2RfGdJ-GJxGQGSEknhU
Message-ID: <CAHp75Vf8NzYRMeM=+S4p9LGnOd4iXcdw93hBjd=Rn=LqBXgwgA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
To: y.oudjana@protonmail.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:06=E2=80=AFAM Yassine Oudjana via B4 Relay
<devnull+y.oudjana.protonmail.com@kernel.org> wrote:
>
> Add a driver for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.

First of all it's almost 2kLoCs, it's on the edge of unreviewable
code. Please, try to make 3+ patches out of this one.
Second, take your time and check what your code is using from the
kernel internal libraries and APIs and follow IWYU principle when
including headers.


--=20
With Best Regards,
Andy Shevchenko

