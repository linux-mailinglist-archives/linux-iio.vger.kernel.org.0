Return-Path: <linux-iio+bounces-21337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A9AF8C92
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8BB6E29D2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37812EACE9;
	Fri,  4 Jul 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLGEwzJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3D2EA750
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618531; cv=none; b=NdjVGkNBG9/frtQsNabieZUAEYv5XpMGZfQspi5hJ4ydLClADmSVdWqLqXZTrHp8iOt35MFRVCNywYHdVP+4OM31zJ+AcObKizgvjrWZL1mRM/Li1/YHJDerobaHvnvJpIQl8hFONoiD7ebOUPemTU7hCQopPaZVKNmPYj2QDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618531; c=relaxed/simple;
	bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7GmB+dYjCFlO5/ZnaQex8pp/G/aJhDC8VMkHdMICuZgjgfvGOGKA6W1yIEt2MUJ+/wd+U+J9j29cxiDJuueQXnHghK3VNd3IOzqQXwO7rnMK9WVN/ia5b//YltahJXc3QH438nXLfi/lhAKjmpOhFCFonuFAkd/tNzQQMfEJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLGEwzJ4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1023227e87.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751618528; x=1752223328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=gLGEwzJ4MKhRRfmtktXR+ZuemV9IpXsYkkNPIHZEgUvE5NSrFC8uCw9veHSSgAfTPD
         XSQnNEG/FM2Ids/72MiTwqxtzYPVdOBNzACTZk681CIkwIQl4J7ALUso0/7AWgP4AR+t
         sW2nXdJB9+Zyt9ZjvJ0QtRxfgaROFy7aMUztnQygs0StKppssY/uNNY1Lvp6qnvMuiA5
         s1hKKBuQ3jHQ5sLUitk9v67i6Cy440E5bT07INkFBM3Jg1SAMNjPcNUZOac0p43eNkdq
         9tX/8ws/j4NqGB0Yl3Jl6fC95FqnCku7m+Vt5vMQ+Src5pKSJ4W32ahjr49l5PRbfeNK
         AIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618528; x=1752223328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=m3clkXMAnSQJ5mos5t7DzdO+U48cRmrozXxJ0xXCbzuMWXJisoWJ/Xk/WX2884wKTa
         /oZhhnI6p558GnOorkhokwURESgLYjiB0F8I1ts8piTPGq6elZ6Qv+YhnBO3BMtVNT8l
         EE5aL0PjZuUJmQ0qZOfJ/jolaCk43+W0N+lGezg7+Kz2tndc2as1jyVU3XNqn/QQF72l
         5mnBEkiMdlyaLwEguSgn6cFcUO/RiJU8s1yDGEKHWBh7yvJ+Mq7c+IOXeyhWf563I6IR
         ozyY1GasqA/texgE33NLYdAcBPxnQP4TMeKkrXPxYnqMuWV55EpbyPhM6SVdye+YnecH
         KJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVGniaRw4aiwWNwTCu/83s1uB4LrqAujYBEwJEcxz+lpghpUv4qxMPkOl+SC8ZgcdVhf6Vp6COYc0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6f+H297Sdb6Wl4J3/SCee2gd5wVoVB/lNskRh/7wkg3VlFHJ4
	n+CQhZuX2pfCZ/TM5HA9pNgoiPIMkPv2ehtvuoCfcl7noQbExn7fR0+fPEzQN4fuPwCJnYAKeAt
	82tdKSjeyzDb4W5+AMNiwd+TFNilUoESZK1I4oBMp5g==
X-Gm-Gg: ASbGncuPN/bbQ34sw2AXL81ccFhZWuQhUWYQHYO0p0ZiLo4Iqx25NbKD+e+56xpDckU
	PuHk5Cf8OKE7cJaMqFWCN3bobdGc7D1nRoAbJghUXiGDpLRAyo+42dHjwjR7UFEaXHSAX1iFQwG
	ifFBvyVXXYsq7p+/0f0d9nFg9MYrU6G7mIT9V2PXQH6pc=
X-Google-Smtp-Source: AGHT+IEIeiS5+KZyaGhCBBX+93N/pubVgGcVYQr2W6OG8DuFwjazUKd24Jxz7fX4vBW8k0oDMf7CGp3FusWtoChh9hw=
X-Received: by 2002:a05:6512:12c9:b0:54b:117b:b54e with SMTP id
 2adb3069b0e04-556e6e31219mr538577e87.57.1751618527728; Fri, 04 Jul 2025
 01:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075422.3219401-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075422.3219401-1-sakari.ailus@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:41:56 +0200
X-Gm-Features: Ac12FXzMLrUX6BaflkS-OvifdrPlGBvZOznKCQ7FBkMZw8cOBeFq-unkAG4IUhs
Message-ID: <CACRpkdZdwh=gpkpeePVFNJGTBFdyjku+SwMrsYGM22ezO82__g@mail.gmail.com>
Subject: Re: [PATCH 32/80] iio: gyro: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rui Miguel Silva <rmfrfs@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, Hans de Goede <hansg@kernel.org>, 
	Waqar Hameed <waqar.hameed@axis.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 9:54=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

