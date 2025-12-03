Return-Path: <linux-iio+bounces-26663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3AC9E6E1
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D5644E065D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495762D7DDC;
	Wed,  3 Dec 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV53UnzK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851A2BEC2C
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753429; cv=none; b=LpIYYK1rRdecnb+Qb8TIOWE2DLwIu4cqmseQepI8XU0YzFR3zbMotHooDH/3JtaB9PrSUoSG0P+qHeXYhQzFtyesTo88vbuW5c33w5oh9o7BvycYxlTPnuHK0aWQSfZNiFp9dpoqTSWv/p4wjKZPdj1bXqStCbHGORfO/725Iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753429; c=relaxed/simple;
	bh=1kPmDdDU1xVZtJJcyPGg23TEhqlkgn7AeJk/PIWhlQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzqFUy8ObM+9Cq3ePdk0v4vTpyuTaTTcPiVNHeYb6LpFGL/S66GW2BdKd5AI3pJbYQFU42NnA0JtSAJx5rrBIx8Ocfun5c8GvsTvXFaL5XhFx9h50ITfnOXFN5ENhjDXNWcjmboHpSlZdA2f443zhx+dR1XOqtSIilTIXYOZayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV53UnzK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so11129986a12.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753423; x=1765358223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kPmDdDU1xVZtJJcyPGg23TEhqlkgn7AeJk/PIWhlQI=;
        b=mV53UnzKZ/mvRjwP7bN6l1pCGWpAMlyarlM4MRVjdw+d6OwOE36wQREW9xjQEO7US+
         IrT9sJPNID+FGRDa+9lkFlTaIbr/Q3E1xyLuN2RL+uU1qbqs2WzEV95VtvjXspCujMqn
         E7LiI9tTqjGOsfqTV/xRcC5TafOFuzOPWbok5gzz4DaHfsmUHHpCs8OKd8z4oeL2xt45
         zjbBVpvoj8fF90QK4sMJdf81fkAf93KQ/qZNfZ73MzNoU9H/WRtBAc5dAuueYRvEzFyg
         xxS4SwOxumUfrEI2mWNfTi1N3NKb5t/ctFm2tfB+hgI8qH1WAsV4fzicVVBOQMLeqmRm
         IAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753423; x=1765358223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1kPmDdDU1xVZtJJcyPGg23TEhqlkgn7AeJk/PIWhlQI=;
        b=kW+AtxqGHwoCFDzG31ws1yTOoQChpl8ctsKkDiG9DAnPjHRiV8fbmRiflFtTSIUEUh
         Lf7+NrdwiCJDkAAXjw7nH5Hr504arfAzhmKqR38RRUseIxK9vwBk5Y9AVhoJjhBqwZfJ
         NNRmc0+BmpqdW3/YIqzBEO23T0hXCh3Vbe+egR8tEaWMtozvS8Y5riPFSjcmuOPV9LQ+
         uRrlJKP3DMa7Jh6fADbIWRX9xzQIBjamZ7U3m9mqBxJc0893F0zgUdju5TNtZqkLCLNO
         n8XS/hBRvRxm2cIvdSnLJ3CLqZuBY2Lv+kzcUa+IBazxiK3p66hfKxujHKVRZueD5Nfo
         rbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRKuolnP8lpVDWqF9eFH0kvFEYm8OdagbBWNh43xb5uSere5WAuz+huf2e8xpnDbZ68fqpp1cnv0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz718s+M3jpmnbGdZni67UKS+syof/qR3grNmuXCcb9YGVTOqw7
	VuApZsOLMhX3sfIF+07xeMfxWkFcs3siq8jIgMaR1U9Wan9jhUhcRIMEhpTZx8mNA3ZbR7vtjc3
	yyNSfupvSUEHyPtFTNrdyBeoMXvSX5v0=
X-Gm-Gg: ASbGnctp8/LPRpE1BFvszXy0EgkWhqCL5TdircyX8jeYfjyKuKSvuTCh9yeblNMCirt
	MGtwIhXj7t+CreV4RNrJi7USuEwQ+6lD5rpxRtwpSxKe9NcAGKtnmZGSBJr5Q0zt6Xq08xJIGC3
	IJLqviWJLYGUhb22RXA96BDnkaLOc1+u7fxXPxYRARcML7lgZk7+sUmf6YTLgh9teEbKLX6Ayxz
	H34jZtZzDRqyC6J3RPt184LuhPP60f/ULBM+YvhVR5jrNFV7ysz77f9/UH6AQdEvnEEU4FtF8lS
	2dpyQy+R3/WAopSM8t9L3J+mE2TP1cmkp12KvtLt/+pjT/y6kANJh6btHSGqUIB1DYQd00c=
X-Google-Smtp-Source: AGHT+IGMngDD2xi+lWZU8ugTjaML5M+Z+itTwCcU+b3Krr1DkJCQyxEvz5cWx/Fv67yxX/QQuUgc1pz0lQ3MyD74zbs=
X-Received: by 2002:a17:907:3f22:b0:b72:a5bd:c585 with SMTP id
 a640c23a62f3a-b79dc77d819mr155154266b.46.1764753422602; Wed, 03 Dec 2025
 01:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203050844.330-1-vulab@iscas.ac.cn>
In-Reply-To: <20251203050844.330-1-vulab@iscas.ac.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:16:26 +0200
X-Gm-Features: AWmQ_bmG9s4b7cWRUr-mXnXr6Vq5uHaWGLKrAPRh0GE1LEES_sdPFg38WA1dR0M
Message-ID: <CAHp75Vf=GOsvXsCmbKzpiui2=jbetTkm9Yru9ZCp9T0+txMF-g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7606: Fix incorrect type for error return variable
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 7:09=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> wr=
ote:
>
> The variable ret is declared as unsigned int but is used to store return
> values from functions returning int, which may be negative error codes.
>
> Change ret from unsigned int to int.

> Fixes: 849cebf8dc67 ("iio: adc: ad7606: Add iio-backend support")

Since it returns an int, it is just double conversion (however in the
standard promotion from unsigned to signed is UB if I remember
correctly). That said, I am not sure this justifies the Fixes tag, but
I'm not against it.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

