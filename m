Return-Path: <linux-iio+bounces-13492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627689F23BB
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F9D164019
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE96154C12;
	Sun, 15 Dec 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L27GElyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD11E526
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265982; cv=none; b=Ek7srwre09H5KR73FoNlNzxSihVsKgfyUrmsjHnW3zqN6Yn2aPTKfudGIEJtZV6n1RaGnXv4m3PICYNF1crvjZJUtLULNgxSWDskP9p/iEHmrw6uqZhN+EGQGjv3rwTV2TgXRMiKggeI3U8aAB7ns/g+oQ5ahNH3U/Ana9F1yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265982; c=relaxed/simple;
	bh=JIx0rLINXbgd9neWFOSUmtXYUngt7eeJ2/WeLfSNdb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnAwmnCm0MzRDpNvFegBnLMQIDlDZk8EFvMvun/2aavr6CXsTtLdtgf07QktbYJowHidLULiUlE8HQK1xAWOt7YC56Mt7eV4HY8ZUGdpMy37sD8FxtnxL6sLbx2T9uLCgTN0GkSMHKiD0jIkF7yTlB+JVE26GrWlZ8mu/whYDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L27GElyd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53f757134cdso3756144e87.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734265978; x=1734870778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIx0rLINXbgd9neWFOSUmtXYUngt7eeJ2/WeLfSNdb0=;
        b=L27GElydkwMvO3lZlbjpGwrU5mK+zgOeEKKxgvEiHc6n7GISqxgDoBVzK/Xa5HlvUt
         tByxc1iMxTqAvZ5w0grxXlVyCb0lx88T7RYZRX7F8qWz2Lh8M9YjkSveatb5nyeqw9qU
         WxlApGfqekTg1uTOrx8UucQi/naWMiZCc1yZoxrsQJbb5ygOTDYy3tj+94QDGyrm/hyN
         9wj+Qh2FmKPPA5cTCKv6KIM/zA6qxeELZr7ztIlrzcqgP/1J3Ahg3KGUOiTaLGKySH3u
         +qgbdYO89fadseLyZYJi3CYjuFa2+fWtEt18Rgs7MoWkYo/4KtNGWT1MettDL421AdOI
         H74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734265978; x=1734870778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIx0rLINXbgd9neWFOSUmtXYUngt7eeJ2/WeLfSNdb0=;
        b=cmJw46dvqFRhuqnR5rNv/V1mCJDC9RxMBa5Rchz5GAHbRxCsUPtL8hF1WfjOW0l3F1
         WE1bs9yuoQyih8JjFtOzD7WUBQMqzj9NuhHg1AkHK/kjEDaMiEE8gO2XEUuB6i70vI05
         UMZYJ6Ohet2NEL6g4uK6f9peI0BesYhwO/st8Z+RCxTTrUQx+xIHniypDsWCDwWCqTsh
         cWGySgLm70fohI+1kMOoELgfhvlv1HWNodDrbwWoWD2ArPgBX/Sy2dmYNyUctAo42sls
         4t243uwt+FOg3npkn6ucyxrE4qtaMF/9uZ2d1zISh0J+ms0VBAZ7P46A3xOtSZvzlBOS
         know==
X-Gm-Message-State: AOJu0YwSvYUnPb+B9SuQFwC+8svojoY5r8bZDS+6q54/bGUHXPk98K3M
	j6LjrNdr73M+rzZNt/sYUbfb40fs4WWp6upyt6dClgEUI2GsKm19t51vIpqogcuCvljgXV5cx0V
	J5ewTwJsHrjw9ww5scS875K9QqD0=
X-Gm-Gg: ASbGncvkAGrftWRUs5crPMWn935KPIlph+tFulyiZrnR2YhxJbjgXXUyXcrDuPbVsJ0
	3dUIHIFlWVmIIUEc9pemuvulhXDk+Ycy158w8+twy3GuuhiL3zYWeDeInYdI7DzBhtmRP
X-Google-Smtp-Source: AGHT+IHAZ0idgIWYtudUjVT4Mn7Fz1OybCrurS/CEysYPNKuEOEbbjYG53jlcrIl9Z5WTTsjemAxzUZXXkg2+xBXAkE=
X-Received: by 2002:a05:6512:138b:b0:540:75d3:95ba with SMTP id
 2adb3069b0e04-5408b80077amr2830116e87.6.1734265978244; Sun, 15 Dec 2024
 04:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209181624.1260868-1-festevam@gmail.com> <20241215123040.36d60bd7@jic23-huawei>
In-Reply-To: <20241215123040.36d60bd7@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 15 Dec 2024 09:32:47 -0300
Message-ID: <CAOMZO5BHw_dUKVnhE6F0nKp2OfC4Pi43ndfh6LMSU64MbxzNhg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads124s08: Switch to fsleep()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, andriy.shevchenko@intel.com, 
	Fabio Estevam <festevam@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Dec 15, 2024 at 9:30=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> If the two had been together I'd have included this as well, but now
> it's just an optimization so needs to go the slow route.

That's OK. This one is just an improvement and can wait.

Thanks

