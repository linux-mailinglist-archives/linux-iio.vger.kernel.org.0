Return-Path: <linux-iio+bounces-22556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E7B20415
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A6C175DAB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD5122425E;
	Mon, 11 Aug 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO4NWGX4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745423B610
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905437; cv=none; b=sgVye0AKEcogoQzaVaM+xr8ZtorKIejxLHDJM6tR5m7B32naWJFERUBQCCx4qzHR2zBVqU9A2rch9sJxEARMHT7hAabz4X9XCmxzdtzWVJBJ2ie5JnYMUwAdDm0cgnf2wPLks06qc/CmH/4XEqv9AjFh+xPlhCYbtGyt9YAS6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905437; c=relaxed/simple;
	bh=ZEXXCgjLQIpfDDScD5PEZTYren34TCt1pQpqiKMk/Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB/WM6Ipw6Gf1RXOmrBH9OnyW9WpYNW0nCzEaUcLdMwP/L4mMXSGXQ3p95Qnc1H2e5ytV2pA3B7qUzvYpzjL6qyNKlJ74MdAYso/cMJFmbZGPgKySHw4AKFkjEcPb+kivs7ONILJZUdvP6rHzSgrnKp1xoABcmu8ZQA6J61ZDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO4NWGX4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78bca0890so1986175f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754905434; x=1755510234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rvlODK4gc0WfxHOqcBI+Ukql766uR9jRxYafgBiY7JA=;
        b=KO4NWGX4iUoOLzghhz+Abbp4UpxaSkjwZbwiLdSMS9PbKqcUiDYxLiLSRXVVDqYzop
         KYfZDoMb3DAvtpxVftsrAzi+0BO5L9np7Z7MPRNHwV0Tel2Q9Ms/O369socEUrK+DY3e
         tPGumW+kBvZgm3FsY3ZXUbXrmp7y8RWJ8RaIHeht56QLiDFMw5mUQJERTOrfM8F/P+0h
         gVFsf/mWttvwQteEEkivYR24iL/0QL0B66w4FzhSQ4UXD22KW7RO/NPXv8z/sVGJZXqD
         IY1F0fmynAQzrxbQsbDHyBjfRM3TGc32NI0GnJuISvYAsv/04sAYHEFpMn6qi27r2XwV
         pWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905434; x=1755510234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvlODK4gc0WfxHOqcBI+Ukql766uR9jRxYafgBiY7JA=;
        b=v6RyyanuHX98LHz7DQRVtMresiCiclScp5Xx/sCT2hexHc1Lxi2/b9SHlDS98YNXWf
         VnRDjaTQifawcw1SuUMe27myAa5IVKHdQZn1G4fslxEqOUeeyxjn35hQdtzgTZ4LpQ1x
         YUBrelhpN2kd/BASiOyWgFLYlR51E+jl8AuLySdrvoarRuTO2rxaPako2a1pJpbfqqpg
         jnJ48sp4vLDtCaE7vX5BXvqMbxHTbodUZYv/mEBJ9OJ3n+Siwpx8hjA30GuacXOYFe/C
         MQWLBthH+t0zWKeAwpVmd4wXzMWQtfVsU15rUS6bx1cRcpSAsRkF9wnXdPWttCMU1psz
         AyFA==
X-Forwarded-Encrypted: i=1; AJvYcCXy5hR0CccD+NH+UzS4Oja7FAm6XFBYGgn8OP8RM4H0wURVxzhu9vcUjhmo6wxrLoSV2S2pXxn52no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zIgImis9wVz7joQKPcXydiJFNiGpURhmt6hrf3N3504TIfLh
	HF/WzZGSIwrG0lZOeAnh4OMdIYiBtVtJJE0e9ln/UtLoAbdm/O2PgreC8qG9Dtl34A5EJA==
X-Gm-Gg: ASbGnctLe8o7cowxzqKv9TNBcWg+FCZQTJv3Y4zAdZq+U14qvpGTdlzxy7ujXn1g/lB
	0z3ocwGg0o/T9dB66RPAGhg+/QBpdkANv/IbpbOeL8IkQljAuf5ksKY/hox/7Wdzokz/t9oBLp1
	wIlmo8vpJjL1+gjrvBsyFaZ0gvqPF4zD6+uY6i7piQA4QeyU41Ex2IBTWYaZ9eoU4EIGcJiS2W8
	3FoDgHgQhdeNQEqkr8Iu2pzHiPPAxl+Ri7iqbk/OTFVlaFXAntMOu85KDzvFp8C3O/Zx5j1P4xA
	o2BmwdfjDP7hboBcWJDcc284V7r2lKoILOvjfkLBWUjKgMT58/lHrU7tPRcVHEW7QHKIP5M/VPi
	GYtAcwkY5k3IyJg==
X-Google-Smtp-Source: AGHT+IE5tIfyNEfJvF1e3GCPF8HCi0DAjMCgZxf+5tt/K0WXW6xKTM357rTxnAtF5MvBH2MSSpRpBQ==
X-Received: by 2002:a05:6000:1445:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3b900b510f4mr9203693f8f.39.1754905433996;
        Mon, 11 Aug 2025 02:43:53 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586a011sm266865245e9.19.2025.08.11.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:43:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:44:11 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: imu: adis16475: remove extra line
Message-ID: <jqgk5pboyya5reoznimit6njg4hy2drw23ir7dbjtclmkwemxk@3ugl7nlhbqqu>
References: <20250808-adis15475-extraline-v1-1-e3259a466e95@analog.com>
 <20250809184913.4a1ec14d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250809184913.4a1ec14d@jic23-huawei>

On Sat, Aug 09, 2025 at 06:49:13PM +0100, Jonathan Cameron wrote:
> On Fri, 08 Aug 2025 17:12:33 +0100
> Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > Remove extra line before adis16475_probe().
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> Normally we'd not bother with this sort of thing unless otherwise working
> on the driver, but given it's you and you are very active in general, applied.

Ahh I see. Thanks for applying. I realized this extra line so I felt the
need to clean it up :)

- Nuno Sá
> 
> > ---
> >  drivers/iio/imu/adis16475.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 924395b7e3b45dd3a6459d6eb788fa2ec86c4a29..ab39bea1e729ea8abb56dbbca3d5305dc1973083 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -1930,7 +1930,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
> >  	return 0;
> >  }
> >  
> > -
> >  static int adis16475_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > 
> > ---
> > base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> > change-id: 20250808-adis15475-extraline-534e5698f3a7
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
> > 
> 

