Return-Path: <linux-iio+bounces-8465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3683951B52
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82181C215C7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511641B0115;
	Wed, 14 Aug 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gqe7U6Ab"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9B1E485
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640570; cv=none; b=UsJ0J1yitLu1RZX8wOgc8WImZTQAlH8aoO1ZiDtdPtP2tBAi6KyYqEwpsE0qL3u0MN/EhYzgGv6peAn2rj93TO+L7gesijroZum/0cCiHY4ZeN79XZoFUu4GjCbAxVaOD3rAZx6GE6W3zwo7Ta0eKVmnpYaNV4xWNivwhOiHTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640570; c=relaxed/simple;
	bh=NT+wGZ9R/+yI3DIAo9Gmeit9wV4Vawzv31a8JT9RhX4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WoGRCuJws4oo5CTD5p+OmzKk+wyyi+TsT6Pj+kCHUtnpEghFMJ3JYga8k/VgN6CDZGMnVYIN5986eOvu8KFJYrUFBOmz2BV9UjCf5FkZRZe9QU+GfESalCm03/X1P4y/OifgwLQPcmkeHI2mFhl1V8+T3tkzQfM47Y6MnGpFOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gqe7U6Ab; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso5128535e9.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723640566; x=1724245366; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4K4BDaLCEtdbulY6HtobHdsh36KQUSnYp7/rzF5PLA=;
        b=gqe7U6AbuiiG03QJujRb18WTRgcI1loYGO2DdPtPX+l4oMNGikH3gKC6FQ0G1Vh2MW
         RovaleWSzXqeSiE55LQjdgREpvfJpuhhibALpgeowscT0qJCEz0YOgcdFbt+wzGqZfky
         Ks6+Xh9UkckYm55GSmgLaLNdnLxvnyXOngdLPhPVZc1YQDYf1VMtmlbJ8+XmOhz5HURI
         SQt8jF+OoIHE3AAi1k6k/FUW7CEplqMVy+j8/+JyKWrFS8W9Lms5a/xHPOCStY3GFgi+
         xCQee99xylX0ZoqJ6bpCI8byvWzBVWiRTKJL935G/XSS2r48QXz4cjIe5caKPNdjueZ0
         gFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640566; x=1724245366;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4K4BDaLCEtdbulY6HtobHdsh36KQUSnYp7/rzF5PLA=;
        b=C4tpaYx5iZ2btzTQ+Idzfz/gtkUZNxK7MMhTxyrdxJjp1Y5qrLYqEiE5zSlYC6n3FQ
         RFchMj6dl578Icb4TgYSwzE2cIEXM33qYVUTOwzTeUmS+uLnfVMOIAc2lZcPGCkFqwKi
         7XfiHMj2IjqLirA/iWh1TLRF7y4swOEEyaT0zEVR8IZmh+qgOwkw864qHkbDU22z9v5N
         QTClRg6tgZurQKe4y2a4OEnf1iqbilBiH5XSk1dXh+UcPTzke2qJyJPlAzZtDVlcgYc7
         VC9xXI5jFPqU4AKJGhnhDAvaPf8aYHi7QlC4oUowbSvL5TdrJJPHK2/mItGzamHmzV2o
         hLow==
X-Forwarded-Encrypted: i=1; AJvYcCVRqJp7R7pOR/rp5mAR/Bexs+bkc5C2qItlC9QD5XG/LBDzXCMcNdJ5E7OQkgfoIE7Y6sAA7/2Zm0bokuuiF6QZR3nSrFdx/xN7
X-Gm-Message-State: AOJu0Yy8MI9qvPEzGbylQLyM2JPZ5cloR4xjNiREp7xYjjN06IVyZ5qq
	c39CCEiykAeFsMa64o4mhE2P/i9Sf3yaDfr3qogHi8D6uvrjoGd2hxt0uAAoZE0=
X-Google-Smtp-Source: AGHT+IEiuMuerzIZhsH7pz9MJFOaYB3RXunMQWiFhAXvL252urYZEie5hvV1BugT/j84AicdA4rzZA==
X-Received: by 2002:a05:600c:19c9:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-429d62fe113mr51591955e9.17.1723640563879;
        Wed, 14 Aug 2024 06:02:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:3b04:df6a:3044:6b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded327f8sm19376945e9.18.2024.08.14.06.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 06:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Aug 2024 15:02:42 +0200
Message-Id: <D3FNL323ZXLQ.2D0QLACO67VTP@baylibre.com>
Subject: Re: [PATCH RFC 0/5] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240629174039.3e6053e5@jic23-huawei>
In-Reply-To: <20240629174039.3e6053e5@jic23-huawei>

On Sat Jun 29, 2024 at 6:40 PM CEST, Jonathan Cameron wrote:
> On Thu, 27 Jun 2024 13:59:11 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This is adding DT bindings and a new driver for AD4030, AD4630 and
> > AD4632 ADCs.
> >=20
> > This work is being done in collaboration with Analog Devices Inc.,
> > hence they are listed as maintainers rather than me.
> >=20
> > The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> > an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> > board for AD4632 the support can't be tested at the moment. The main
> > difference is the reduced throughput.
> >=20
> > This series is taged as RFC because I think I'm misusing
> > IIO_CHAN_INFO_CALIB*. For CALIBBIAS the doc in sysfs-bus-iio says
> > "Hardware applied calibration offset (assumed to fix production
> > inaccuracies)" but AD4030 offset in on 24bits and I would argue that at
> > this point it's not just here to fix production inaccuracies. Same this
> > for CALIBSCALE. What IIO attributes should I use instead?
>
> Interesting.   So awkward question for you.  What's the point in applying
> a digital offset?  calibbias is normally about tweaking the Analog side.
> This just seems to be adding a value on.  I'm not sure it affects what
> can actually be captured without saturation.

True, both scale and offset applied with thoses registers can lead to
saturation.

> Maybe it has influence by changing the input range and scale for the
> block averaging filter?  I'm not sure.
>
> You can use offset for this given it's a simple linear value and not
> anything to do with calibration. It's a little awkward though as that
> is post scale rather than the other way around which is rather more
> common.
> Controls are in the form
> voltage =3D (raw + offset) * scale=20
>
> So here
> voltage =3D (raw + offset_reg / (gain_reg * other scaling)) * gain_reg * =
otherscaling.
>
> Hence your offset is a bit fiddly to compute.

After talking to ADI engineer about this, the conclusion is that I was
wrong and this is indeed mostly for calibration. They left the range
of values quite wide in case a user wanted to use this to apply an
offset or scale to the raw value directly in order to avoid doing some
post processing later on. But the main goal is calibration.

If that's ok with you I will keep CALIBBIAS and CALIBSCALE for the next
round and remove the RFC tag.

Thanks for your time and sorry for the confusion,

--=20
Esteban "Skallwar" Blanc
BayLibre


