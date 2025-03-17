Return-Path: <linux-iio+bounces-16972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211F3A655C5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B158175FD1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD924888F;
	Mon, 17 Mar 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEH0WgAa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F02459C5;
	Mon, 17 Mar 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225540; cv=none; b=n/syBXVvaE8C0D4U1JWeI9BKZgzZDSna8s9Wkp/sZ9zkSm9OYaYM5fjUHFGX4cwCYD+QhFo/GPd6lq0/+ZXcU/Hida36FJpAdloIDksXDM+ZT2avRANjPVCU7sy8BzF7msk1dBSXO1ooJWmtwiOeaEtdfGanihNwSfA/9U+agLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225540; c=relaxed/simple;
	bh=iip3iQxffkmed+5LadgCoqe6dhIIViTG2VDNzNURDlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpTdaKwQZcsDQ76j0wH1UatY6vQH6RQjI1ZA14ZE43Jbovs68BY904P7WLyOGR1l/+8retl11zITJ0atX2TkS92GEfLEzmOaY8MJe+ZwmJ1tRVpKBsJhx5TDV0RPuj/trB4DVSOuZ0hq+poYNslP5BcKHW1AVlQH2lAzq2T1akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEH0WgAa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22403cbb47fso82183025ad.0;
        Mon, 17 Mar 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225538; x=1742830338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8+ECIM4mItWp86Wdlp4PqB1UN6vacB6ZDTSp/phAEI=;
        b=nEH0WgAaZfnuVZdv8kaHc+nbBFJvR8Ghn4hpqZ5aBO9l8aqeY1NCgVFaYe+EloZEaZ
         5QvCTpQX6rez+RLu0OtokR535LrNgBgBoiPoqiIBbeGIzl6FvP5vZejWsy2L7yd0EmXh
         gCV05+IacaYxmqfRfQyP6b5Z1/ApBVDjF+JBchiTcyilWjH9dWT/NB7BjW5JRQ2aTk4a
         UHLWKmnzTIKATGOlhw6QamaNOdrDvGt1wt561nY9XftgMEVHHZkqA6GAJ101YhswbWTA
         k26PLB6SSsRMFixoVcK2m77bgKQYWTkW9FFlnyRknh/Z2NmTAQUEd2ioQ2KWxVLHttvr
         Hr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225538; x=1742830338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8+ECIM4mItWp86Wdlp4PqB1UN6vacB6ZDTSp/phAEI=;
        b=C7cXqX5dsUlrBtCP/6qbsY3kYB7WEJhOBN7DrYCAwxZZkBJyeV/YU+I7eaLUWH9WqV
         c1KuyZKt4zw3N3iQmUDnfu7KLRMYbwoPR6HAMV5S7KUjVMezxbsq6V3nAMopzpMbumim
         gvmCy7cLH6FRFwDU0L1Y4VQbUFjxUy4aV9Wh+9mLFpR1705lS9APl2KU9AAINobvrFC4
         7Cdyv1Pr1Auu4PDZkkz4ShZQ/UYkYJQt/GNx+xfZZQqXJPeFb+TkOGfTIhtkw689GBov
         HWLuv//hkhxBJolStkET09KqcW+s8AAJemMd1747+ZHIhhEqs7u/+/wl+3upW+rCRvt/
         YHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCULgUVm7KCJuIXYSNkzIkcE96xNBrNj1Dxt7xn8txoMYAArfoeoGHkxWKyY0SySe4VuDkmAotOgDl5t@vger.kernel.org, AJvYcCVC8zDiYGiHxjbTb/BOqwbLINtVVa6R1eOHi2zvG22tgjglIMM359UctFrF0iSaqagWT3UrLvqsctrqQb4n@vger.kernel.org, AJvYcCW9UFVbvUR3o1gpFLtIEptA9bB3AsZ2A83LlheBBzNpMfaoeNmYlpFJ9r6h3rHrPR5G2F4THVuXjtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHAPl9BgEId2ig/vLOyUtNFXZCHik95MKhTQInVIpcYB1meOD
	hrj7dPkdf40CHRODyHSfktyOvagf+lOUoYDO4HTZo0RDJZxqcEO0
X-Gm-Gg: ASbGncsbGB4PenIRAks4RY49UWV6AID70YL7+cW3JUbABOQAPgu+eT6xbNsmQwz/4cT
	sOp3ZvItlWIgd6TVohIwU6pHk64l+f+dQu/ZWJLLl+n/dlx2ZEh3G9Hp2ZmcZRUfTEWXowAmyvs
	jc3QBKqPoSWo2UBoWtE5GjWKkfAGZVZA+dyrMBIeguSPOBcvQ3912L7J55X4vUtLFh3z0JINQqx
	PrP9XT/wYQOUxGEW/IlEg/K5ZKrAIPgYdUGpKwZAM1CcKr3cSrQFJ4NTvCUmfEPdUIT7ASkNhym
	cNhWB1M5PdVp5inMekjOZ9QGDNW7ZNizUTNJhnLJtI6C0caULRx5jQ==
X-Google-Smtp-Source: AGHT+IHV6t35P3yl7wOACXBiuJT67GGIJ7sQKt01gXD0N67ia03V+CPtj5xQqFRrXc/E67wJBv9L5g==
X-Received: by 2002:a17:902:d4c6:b0:224:249f:9734 with SMTP id d9443c01a7336-225e0a5220emr167540965ad.4.1742225537930;
        Mon, 17 Mar 2025 08:32:17 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68aa906sm76946935ad.88.2025.03.17.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:32:17 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:33:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net
Subject: Re: [PATCH v1 4/4] Documentation: iio: ad4000: Describe offload
 support
Message-ID: <Z9hAuk7PTMJsRkay@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
 <18df335c2dd4c4db3bf27d68cbf1852425114131.1741970538.git.marcelo.schmitt@analog.com>
 <20250317103012.0053bb42@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317103012.0053bb42@jic23-huawei>

On 03/17, Jonathan Cameron wrote:
> On Fri, 14 Mar 2025 14:19:33 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > When SPI offloading is supported, the IIO device provides different sysfs
> > interfaces to allow using the adjusting the sample rate. Document SPI
> > offload support for AD4000 and similar devices.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  Documentation/iio/ad4000.rst | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
> > index 468d30dc9214..2d56b0762570 100644
> > --- a/Documentation/iio/ad4000.rst
> > +++ b/Documentation/iio/ad4000.rst
> > @@ -191,3 +191,20 @@ Typical voltage channel attributes of a differential AD4000 series device:
...
> > +SPI offload support
> > +-------------------
> > +
> > +To be able to achieve the maximum sample rate, the driver can be used with the
> > +`AXI SPI Engine`_ to provide SPI offload support.
> 
> Can we make this more generic?  
> "the driver can be used with SPI offload engine, such as the ...
> 
> I'm rather hoping we see others in the long run as useful little things!

Okay, will do.
> > +
> > +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
> > +

