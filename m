Return-Path: <linux-iio+bounces-22615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CCCB2226C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897B8189445A
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E342E7643;
	Tue, 12 Aug 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM9EJ0C3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048702E7628;
	Tue, 12 Aug 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989625; cv=none; b=QFB7EZzWYsFsk1mivtZ/usTM4xM2h+purqJK6imDesZhFsiWvtmG2pnh5xRnixoW68VjU4CQPE8NFr0wMPI1vJOyJFOYZpz5GThXq5SZvnBW1uf2FrMLL8/Y9/QNPlKvoTODIT8sY7mLuRRsH3DeCbXYK97B7svmmhX2Tjj9bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989625; c=relaxed/simple;
	bh=aELAU0xO9WCQzlDQodYCe/e/6u4XRmODgZyX3/n+xdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl04TMK2gUudM0zgefypnxR0cTUGE1quw/dTH8fv1Im27Lj5XFKgjb60FZ/HDEULzVuVLnvE3GXHCGkDhoS0qVMak/n1DLLMFepCN4zzTjdsCIaADOeHHt5upYeKWbS0ZVebGQ9MBGSDRfj+GhURlDQPOdarUuP5ik6VUFFplSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM9EJ0C3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af95b919093so771908966b.2;
        Tue, 12 Aug 2025 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754989622; x=1755594422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aELAU0xO9WCQzlDQodYCe/e/6u4XRmODgZyX3/n+xdA=;
        b=hM9EJ0C3aWC1chkYt9W1M2ktaJDojLNB5bVuUHMN1pOueHo21JgwebkO2uzuj6t7B3
         gbyihX8A1RblEgZySoEBOvyirywp93OL/2Y9Oy0XSOcFe2+8xaCAcimNr0fgCOrCaWC9
         awcF8USIL1aIJyCvS3Gc9k+/qT3irg0c0S+v0nIcdsnvO6Vb6IltTLRwQU5D+V+h+u9R
         OnCp/A7vQBY2RWwmhJm5NKMvTPA4wmoTvTsMTVVzCbN9F+jcXEFCmT5JQWcxvF+17nL4
         XLzYYMNe+oNbUer3Hi645sJXqf5WQdUseGn2tRHhbA7XljTEN6oYvmpeLF7+6dC90vMJ
         yzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989622; x=1755594422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aELAU0xO9WCQzlDQodYCe/e/6u4XRmODgZyX3/n+xdA=;
        b=KJ5RJsr0qs+qciYyFlzc4haaIIZmz3LRTFSS/N11LYJRPi+q6WaR0KsMev1TCDmhDy
         8DZwYuju0TEuu2pGKuM4O3Z7sJlZXMHI2bHBM055PKNIgoe0tRgc38wqFCoQXeHIK8Uy
         DNlxDzrH48lVB1Aa4obMfsp6mxm0NDs46FNpJSJtWnwHmcLXq2g0D3/KQrNZoWl5zpBa
         AktjOeE3lA4BOAhxfAJU3HfCDloW2lyneRBLkU7aULR/NcL4vtGBsyt6S0eIR2vc3wDT
         HqONCXEwd200jv9NcyZz8h7OxZJ3PW5ts/rv1osTyL+3JVFNdYkgLSNQH2xSR0Cev2a6
         IghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcdSXglw6Db70k11DrUPv6zfrBphB57E+qrgy/M/ft5xhP12OzoSsr0wFKL10vY3t1BTYUDrBPXTo=@vger.kernel.org, AJvYcCWl9Ked2fRfSzpDBKfEBoJvlg/DDJhLjOMLBkzXZsbfkwFq0kO8SZ7uLe5XIcEZeFzirZFUn4Y4ZndcSTWI@vger.kernel.org
X-Gm-Message-State: AOJu0YzGj8pOO5SdqD7Q0sQsogE7xGWTsj3tSLwHMYzLGxFMaLh4mKll
	viPjx61WIN6Z+PkAN1Z9hD2YsCjM0SQXQGCDi4NsGwToYEtcapW27qPn9AnBDubt1a49prhliB/
	VZF7pbZvwp1b3HAu+RiXscQ7g7goOOGo=
X-Gm-Gg: ASbGncswhv1zyeUjLkQd7HzRzSdCbj0R0WgRVggGlQwv6mx9PqpKi4jDepvJwQIEb+t
	reS6cHA8TZvbdWipQVq+f4AQ1lOo3gwqrA289g1LEQXI+ulqQYrKsmDzY+YqHT4Xf90BVSPN+Yy
	gVlUnmcpN9r4l6BS4W9D/WCjyudSOs86eYOf3RlJwK1NSR4DfwgdpNj8QoRGl2QTOSw8ncwUOuy
	XArhXnrXA==
X-Google-Smtp-Source: AGHT+IHwJkNNhHLywqfSPYJXYdJDdl65CBIyoMCDmR0B39XH1dI9WmEu3RjwIKF0CFgvYLwlX3o/8962BYxHWt6bfIM=
X-Received: by 2002:a17:907:787:b0:af9:45ad:2a3e with SMTP id
 a640c23a62f3a-afa1e10105dmr246353266b.44.1754989622099; Tue, 12 Aug 2025
 02:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-adc-v2-0-0260833f13b8@nxp.com> <20250812-adc-v2-1-0260833f13b8@nxp.com>
In-Reply-To: <20250812-adc-v2-1-0260833f13b8@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 Aug 2025 11:06:25 +0200
X-Gm-Features: Ac12FXyX_4FNVjRioSrZAzjWhbMWY63pybVPFgJ1OZyn5mocEBo4lC_tirfWAEc
Message-ID: <CAHp75VeYxLBwH10Z38Ez_TOu4B=1hW+TR+=2wFJHur65toCJUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: imx93_adc: keep one style of the hex values
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, primoz.fiser@norik.com, linux-iio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:05=E2=80=AFAM Haibo Chen <haibo.chen@nxp.com> wr=
ote:
>
> Use capital letters consistently for hex values.

Suggested-by?
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

