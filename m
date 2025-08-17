Return-Path: <linux-iio+bounces-22866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14403B29423
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39C1189C886
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49972BD5AD;
	Sun, 17 Aug 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSxoGyYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC129A33E
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447949; cv=none; b=fAuh/pgFVhDTsJ5C4Xz5nB8GTfnNsgYmse0K56lYXVaU6hkJtfYr652R5j+g94dVvhxgDyPP6oLrMjVI9gLgFOwMKQ7WQrCuG2moqCjBsrFSCR4XC4ok0JWwZCw3BKNj14M40rooHvvDXMuafk78k5aDTZwLjbrhKgNgbitIKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447949; c=relaxed/simple;
	bh=zmiACXqLpLkcT3ZhmjWahajC8NaTI8Ja3caQeOvtDWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT8L/cHf91QseE4BDxxiGOTd7ZOH/lsQ0wJtPrvu05eiTRwtvHfA5Pbj0F+NwzG+fw8ZN2ZwikB2WS6cktv6HzXxJQqrf8UDtvd5OQudK5+RFJeQh5qPDABnBIjR1pfftdKmXHDk1QNScRtNb6gOqF1bps9VP/BQM4pqr+dR3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSxoGyYk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71e6eb6494eso13699417b3.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755447947; x=1756052747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmiACXqLpLkcT3ZhmjWahajC8NaTI8Ja3caQeOvtDWY=;
        b=NSxoGyYk41xTensKhehoGr5NGm4Vp3tkeuszEypAzbjKK+DcRyE11qMY4vMjbOBq8/
         +aYHaujEfBpLAjHSNF6WrMMB1RKdEqbcpiFAZdHbCUstsV7EDIAmORq2FHTZ8iynAIi/
         2Nhedfplf+Zt8ihhQ6M4oOYWZNk7sgoW7cuRNVqSsoyioHEuM9TCOYEJLl2jBSL5Hcjy
         0tuUZNh764yZtIs66MhVjU/a+eWu5e65POECwXf74GzEsOkjDK8WvdHetXEllyvdqO6k
         3Ed5nJDgzYmmlc22wh9bhB3GtJiERFygvtxg9zuPfiF2nRDl9Sm60FAYoyTjbAEWUmh7
         iJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755447947; x=1756052747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmiACXqLpLkcT3ZhmjWahajC8NaTI8Ja3caQeOvtDWY=;
        b=s3Mcw3dZ2qIZxV7iGFHv1VeVPinqmWwIm6PBJbwhXVvwePcPqJ15InYfChvabx9q+X
         mvFK5Ea31CrpLJkAm0PCk0juLynTA3KcvCl8e9Yd9upo2tRIQRZh26la8wZ9dQ+N3G3c
         DayuDFfYsB0WhKDFxXyg0zbFrK/WXdD8Sxdsb8jtc98beelMim0N3a0FYZz31zTNlLM+
         0PT18NmadJDfulgLrrr6IKce7KgynVd4gwOA9jwSQlav0IbmR22LHTgU9StP4F4Iiz3q
         R6r22BTl8Q75fZZdY61m7YfBsbkEreofoZVF1rBxw7HScVemi15xhTJl7Ks5yGmzDGFM
         tWow==
X-Forwarded-Encrypted: i=1; AJvYcCWB7ABGqHR+h96Lrb7+wYX1I3VCoOMqZDtfL9vpxO7jO59NRkFtz0u5mXS7hT5t4dg/8selpujgtgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDHW3Uuuz3FbrAsQhL6CqtO8heNrNSsbYheDel5+pEuYjZw9S
	qDQU6cTtxHCzrF3D9oXiNl/POHhB9sKO8Ad2LnnCvEk59tjtOML+5h+EdGTbQMTKLdhVl+dsZq+
	MM/Z7bIn+Eh3yA1glhwICcmFQ8mzrFJI=
X-Gm-Gg: ASbGncvEu2sab+MHxS7OrgnuToVYySh3/ydJ94tQwng/9H0uF8SgQG6frWco6zs6zDv
	zHurxSGnne+ndso5L2Pom2nSSm1iPAaBrSHMuLCysG9SLAcelbAw9fe2zEiA+/toVPIbwgJnxi+
	W9pWsDwIw1XwVgqk4sx/h2QMxtcHsnAaE5vgTeyWENz62ynZfkwNpEGqSByT/TdRU0NYHp1uhA0
	6QW2Va3M2jcVSnnVqA18K8NlnxZ0RotgaXwRvte
X-Google-Smtp-Source: AGHT+IG+xBo5puS93TVrmC1TKc+zOuhMMdsgJpXZZxuJXTb0uV6MEJVnYxgB27wUJ/b7OyNuQ8Rh1qY/ThIH3sFXqO0=
X-Received: by 2002:a05:690c:4444:b0:719:5664:87fd with SMTP id
 00721157ae682-71e6de4b18amr115322427b3.37.1755447947121; Sun, 17 Aug 2025
 09:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816133757.98624-1-chandramohan.explore@gmail.com> <20250817153209.560334f5@jic23-huawei>
In-Reply-To: <20250817153209.560334f5@jic23-huawei>
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Date: Sun, 17 Aug 2025 21:55:35 +0530
X-Gm-Features: Ac12FXwfM2kzUpoPyep62s0T0zr3M4VQZhgbIggOLeBRS8_h9-EeAJ_Vuv6Sdpc
Message-ID: <CADBJw5Y=79nc3Hq+g0i6VokkiOuShrJYCXr-CGcTojj+xZ0QfQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: Remove logically dead code
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	shuah@kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 8:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> > Fixes: fb1d3b24ebf5c ("iio: adc: ad7768-1: add filter type and oversamp=
ling ratio attributes")
> Applied but dropped the fixes tag. No need to encourage people to backpor=
t
> this.
Thanks Jonathan.

Regards,
Chandra Mohan Sundar

