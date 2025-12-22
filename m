Return-Path: <linux-iio+bounces-27309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B390BCD5504
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 10:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701283019B46
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AB3112C2;
	Mon, 22 Dec 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPRRKjgN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD530CD95
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395463; cv=none; b=hZNE/8bgsQOSSU4rf+fjUX5s3gB4W0r1XYlBJ65s87Gx0qP9HuaJ1M8m1QsHeRkSXUOg+id8p6xj1z21AQ7zx8Hh30Nmv8WiAXAIfhvZNr/f6N3LExYDO+0KUmNld28ifQaPvXiluvhbSpUZ3ybyVteYg2WEHTcxVxD5wRcsHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395463; c=relaxed/simple;
	bh=bAyLP6n1PUSnQP/5Sor/5DmDifmF7sxR57YXwCBKk8A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq6tK2OqJWRm5FyzS1YwjeUDHPd0uhZ3Jq8QWCKBmAgT2ysocaYfUYaPp7uyDCuof+lz/YYvpzr6QCHgjMU3Jlhw22lGYiisD/Ar3V+eSfTYRvMkPQ01OolxU0WzHBaq0l20oLBlRZu23Xq0FzIgauD9Xdums1k0STLL6k96g9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPRRKjgN; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8ba0d6c68a8so414570085a.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 01:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766395459; x=1767000259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmZHUHsU4s7pfLTXA++XjM3WOwGAV+1VFEV7wMCCv8=;
        b=LPRRKjgNhaTitcxJy+stnIJf8tDwhJhz7lljQYnZ6dy71OVmG6MeEGyb73SRL+Iwe4
         E5reR1RLOGk1yx842mX+R0Fs0OXxquWaNUadBDf5WGiqnM6QzcJXOYo/SdUdtf2SAERL
         5uPcDZnzOauAjKCQkjFvfzpmi90+6hpMM20BbcDfIi4Gv92+ZOTQCKE+H2lfpCI4RlnU
         gCg3Askw8TbAKimSJIbYamILj0a8GjUWoXogcZoN+CE+mRg34Ty9qrNO9umMhbEvkLwg
         SspaQCaIS0ggWNaaWc5KEIAMKVRkE/u1C8UVd/BtIX7PkM+/BGWA6ze/QqNwlnn1X294
         13Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766395459; x=1767000259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvmZHUHsU4s7pfLTXA++XjM3WOwGAV+1VFEV7wMCCv8=;
        b=QWJBvDiUQ8eSM9lCQ5bvnDethwel0t+HP5Vbgk0qswNXjZ9unDDVyTmp2f1TuuJkrL
         AMr1hEcEW9TsZXR801lIhGq6XY4xGXV3llXr8oQ5pZ80U3ukHp8Dap+NJsqZc49m4EQG
         uJ1h+6Tfk45GSMSC0h3LETR/RY6tXYCglBEornT9Lxaan6QUDo2+2CuMgHpMO3LIyaDT
         hEXfcq9J8z7dWem1PDvY/HSkXxMtAanwhPG7TfVrIX92r05BR2bqcYNMu4rQmRceo64K
         Wg6dk7XDNszJmXHWFqOVPXq1lKNH75ZcTUU7f4CIG+Yi521Qm0o1MrUMlEbp+qZiW7iw
         5yxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4VrrC1AQzqBwnyXezXvRY2ZQYOWLmN2eG1zY/QbY528C3UBdDFiGnGaxSo8+dHac2vpaQqn717ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8pCQ0GHumJJdcMoWajFbaOT3lLWYZIOkLut9hyhGNT0cfmMS
	snXyu9QR1ST4Kt18LGY9EvaMcxT6/V38sMx1pPHLLBSsjcDwEX9rc8n1
X-Gm-Gg: AY/fxX4MfSd8hOSNindM0DTU8YuYeIP8gZj1mzWY+4G8IpDZSSp6TLrIOtLNlfBVQIC
	g0hD0RqQ8m4qSa47syJVXjWqwZEjcnP0EvaMUfUYYouj229tcqtVA68HCSHeGwe5lzdDLszQ7+I
	aP+aHUFWWMyae8aV5GpOuZS8ic3/FWosG3TVUUcFe6Cx+vuHJ2574jq7ZfGSnxiN/dp8KU/NxEb
	waPRahfW3P8qamlrqU7iHTGV70DrgQjOqqCJh2ZHjtd14+ZRlz7OaQyxab1rm1Q9lQC84txlz5K
	uMi0LQE1KmrsGz3/JGKUp5xfk2RR7SvuJ/Cz4mT3G0lxrVsSOgUAtdX/0kpgQ1MTinuyO7d1BUo
	84trAEwKjIlqVO53Oo0EKhlb81QPM5S2ObGTXZrNXVzlMiIcij6RDdJxrsb0xz/kqg80BWvS27o
	FJCZlI5kfV/vW+8kiisdoh3y4HDZXBid7wGHLUhm36uJ+Ww2CIx1y0TvJuL9/45cXG1hw5kVZ5q
	v44M8cJM9sXN0w=
X-Google-Smtp-Source: AGHT+IGcUkieeN5SMBrYzsLDCuuaXwX0HW9pDymSmeokduZF4f2T9HBSmI5nY2mxs5I2NKVprEKeNg==
X-Received: by 2002:a05:620a:28cb:b0:89e:d562:7b93 with SMTP id af79cd13be357-8c08fbd210bmr1650156785a.83.1766395459535;
        Mon, 22 Dec 2025 01:24:19 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975eeb4bsm798522785a.52.2025.12.22.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 01:24:19 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 22 Dec 2025 09:24:13 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 6/6] Documentation: ABI: testing: add support for
 ADF41513
Message-ID: <eefdt4y56c3mh653kcker2t6sfpb2wu6kcahqnkgf2mqjfotbj@owcdihpzibkb>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-6-be29a83d5793@analog.com>
 <20251221175249.11b5ff02@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221175249.11b5ff02@jic23-huawei>

On 25/12/21 05:52PM, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 12:34:53 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add ABI documentation for ADF41513 PLL sysfs interfaces
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Do this in the patches that add the ABI, or in a patch before them.
> 
> Also try building docs.  Unless something changed recently that will
> moan about duplication.
> 
> When ABI is generalized from one driver to many we have to move
> the documentation (and make it generic) such that is is shared by
> the relevant drivers. In this case
> sysfs-bus-iio-frequency is probably the appropriate file.

that makes sense, will do. thanks.
 
> > ---
> >  .../ABI/testing/sysfs-bus-iio-frequency-adf41513   | 27 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
> > new file mode 100644
> > index 000000000000..11ffd248eedb
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
> > @@ -0,0 +1,27 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> > +KernelVersion:	6.20
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Stores channel Y frequency resolution/channel spacing in Hz.
> > +		The value given directly influences the choice of operation:
> > +
> > +		- integer-N: requested frequency is a multiple of the Phase Detector
> > +		frequency.
> > +		- fixed modulus: fractional-N mode with fixed modulus.
> > +		- variable modulus: dual-modulus fractional-N mode with extra variable
> > +		modulus added on top of the fixed one.
> > +
> > +		It is assumed that the algorithm that is used to compute the various
> > +		dividers, is able to generate proper values for multiples of channel
> > +		spacing.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
> > +KernelVersion:	6.20
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Sets channel Y REFin frequency in Hz. In some clock chained
> > +		applications, the reference frequency used by the PLL may change during
> > +		runtime. This attribute allows the user to adjust the reference
> > +		frequency accordingly.
> > +		To avoid glitches in the RF output, consider using out_altvoltageY_powerdown
> > +		to power down the PLL and its RFOut buffers during REFin changes.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c536c3afc1ae..48fa1011b797 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1606,6 +1606,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
> >  F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> >  F:	Documentation/iio/adf41513.rst
> >  F:	drivers/iio/frequency/adf41513.c
> > 
> 

