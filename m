Return-Path: <linux-iio+bounces-8911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4596715C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9CF1C212A9
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA217DFF8;
	Sat, 31 Aug 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/H5u7Bv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D36A8CF;
	Sat, 31 Aug 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104478; cv=none; b=Pv9rZ61zgBhaI4To/2KW+IXvuJToREdAqDdTbE8JOklUmJq+jzDYYc65w9TBtGcdqMYk9paR7iQFfRdJuwdXSkIXLB48cOg9YS5hRD/g8QY5CpJOUMLIKboJ3ZLYBCts6Daet1+h+LYXcyABPANw8wOrAEmc1vNj9PMPZx1ZuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104478; c=relaxed/simple;
	bh=dzfg5AAPQBP7IxGhqH2LJ3n1Dw2NUaBeXGeXvnIpsVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCWYqwJ/VMcj80JsYF56DeFvo9kQHIipRGBuiddkkQ1I2zi/eMMNpa5SU4zRY/JOdfLgCiquotn8PpXjHhiiNBlzwYNtmBaNw+qWyG0IV+8bE+D4xFcckbqthMNC54kUb8soemM3PXic4mpb0JrD6/OnbU4tLpp/keYrfEG6/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/H5u7Bv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so2726123a12.0;
        Sat, 31 Aug 2024 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725104475; x=1725709275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzfg5AAPQBP7IxGhqH2LJ3n1Dw2NUaBeXGeXvnIpsVA=;
        b=A/H5u7BvNlhcL9Etw75OzNdY8nYEjDHkvzstsQ3YfWkHK0x/uNH2eqM0KSemyZp7Cw
         Az73wkliG4BwayzdLY1vc3uXYzzjhnq4Vc7EBiFpD8URyo0zSAE78+p7yIy8WBA8WmHj
         2/I5av316XuvYCRUOr7iWY09CuHL1Y0ZuZrZCJ/uzcfb9LEsNZYltP4jzS8Fr2SzNO48
         70lhNNeE34qJQT13wWVPWYRgRfhmxfuYEoCazwha7LuHVh5COQdl7PY2px0b/UVZbV+f
         MAWbz4gea5Mpl5ONrtZE15hYR3q2eSwp3vrcMn7Pz8XSTVkuvHc+nDB/WhimxxYa0HJZ
         A/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725104475; x=1725709275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzfg5AAPQBP7IxGhqH2LJ3n1Dw2NUaBeXGeXvnIpsVA=;
        b=EZG0AWojcbvmV+fSSiixcplcFMn2GmUa+CLXVJsKK3GEUNb9p46oPUjaVnXFPTmUtw
         f1/7gTK66sD8GFu5v+qEHsDnzm5n4lho4jqsOqAwTBWkzN737DuHRHpeJcOoP132vkG/
         X1bguGLZLoljGShT2u3GQEgKGyN6byDAA86zRL9hLdePRVQ2xsqUVWe4i0Gst55lwWhf
         sgXDU9D99uEiPR70SJHyGA/nIn7BxQmZ+sZqw/nibwmdyJ0gyj37Yey64MAr5mNj6Z2d
         Gh8zhg/5GF9+7vwvd3G9GcCDTQwbOIOZHtqBMnURCtM2xBGChisWO8wFxWROvzxlxD/O
         jwyg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNQ7NoiTDszDMYhg3vZxLrRrazmEev5VenckpuiP+94NiOLlXCGIJX+mmVS9tidH/arRwvXMsZX0=@vger.kernel.org, AJvYcCVrMpKBsXyKcckmHiEFlHQb4Pk8Q4bxjKqJylJW/ujBd9ifzB0SkIlq3NZ23M4cKh8HUVMLPtMTqHj9xngp@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSoS3tROlJwOhjvant2Akr+7jU8fyBlufjt8xkN5Q/0hOfY3q
	mioX584ysHqxR7zIpnChPEKKmgHcqzSj7U8pPn+m5kX/B43Zq3QiiqEmFLe1Pg2dJrH8n2jdH2/
	H3jqxTbUHCwicksXZ2ZzemQ6e5DQ=
X-Google-Smtp-Source: AGHT+IFyquyaYAKRcJU4KGIAwFgdI7SC3dKZUTalVzMf8x3+nH6tfUdud/w9VNB4qkeRJVPINcOulPJzYR0cflsoO8k=
X-Received: by 2002:a17:907:7da3:b0:a7a:b385:37c5 with SMTP id
 a640c23a62f3a-a897f811cc2mr712228366b.17.1725104474690; Sat, 31 Aug 2024
 04:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826212344.866928-1-andy.shevchenko@gmail.com> <20240831115343.775c6167@jic23-huawei>
In-Reply-To: <20240831115343.775c6167@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Aug 2024 14:40:38 +0300
Message-ID: <CAHp75VcZBAkpr==gwXohhHLZfTGpwQdtyOH_A3xkz12qV4Nvrw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] iio: imu: st_lsm6dsx: Clean up ACPI/fwnode code paths
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Tue, 27 Aug 2024 00:22:38 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > Here is a couple of cleanups that should not affect any functionality.

...

> Applied the obvious fix for the bot error messages &drdy_pin
> and applied to the togreg branch of iio.git (pushed out as testing)

Thank you and sorry for the inconvenience.

--=20
With Best Regards,
Andy Shevchenko

