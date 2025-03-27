Return-Path: <linux-iio+bounces-17278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E4A72BD4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E64188D5E8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624020B218;
	Thu, 27 Mar 2025 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jpj7/+8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746D20B208
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065644; cv=none; b=MkJFXQl47L9WdK4tAplKEF4nbswMAUpdbNr35uGwzGWyz/RXMROtHslZ7LY5b+GJQP7Vv9nEjMotK979evIOkUC5/iQg/AjhTQB93LNkmHxAPw5cgoslxF16YcBmtMaRS5JHA3+OE3oueNaQ6kw0oNA9/Z4Pz50iqNyOFWxYIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065644; c=relaxed/simple;
	bh=PW/45Pu+M+b6KNAQI6fPCnwWPz3+7C8d0e9+28MR8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFRj2oAuEoTmfmdsSyy74AmFpPKhel9/DHCNaPqVt/oGebf7wZ2JOvN9i8/UjF4Tl9sX4KJ9NuMBCaQ+ZueAdXo4clcIN+L33h2WXGzpJcht2D5hcsrlCCh0TLRkNAUTQyLBA7HoirRcEI2UPLq6lQLwHLJfkQKnbDCnFN1Hwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jpj7/+8Q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-399744f74e9so402436f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743065640; x=1743670440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BySgb+YX1n0zynhi5aTDP7DfGbWcQJepmiGx4Uznek=;
        b=Jpj7/+8Q9CL1DsqmYgXtK759KduLLFncv/EhmtgM+LFRu6zf2ZJ7ar8ax7yi2hpZii
         8Wdipe/bNX8pBgzH4k9VJoVqDytLNVriXGfxS0oukO7qb9GjKQw9s2UWRTnolwd1rcvD
         4pQcoGFRYDmjoz3URNQK/bPHSEYd4Uf5N0PZnVo7q4na1NXQRuxTJ7E5hwiHo9ffcDnZ
         9TPwTqU4NOOfb6XI0VBWD5yHJg6c+VRx5eG2REY+xPjqxNwvG/1X25Z5ASydX0SfDlxV
         9UmSHhdiVgGOfYjqQoD/Ykv3ywWLCT7X2ETnn6euSUkMQwDUdyfQMzuviSjCIhloscnB
         AWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743065640; x=1743670440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BySgb+YX1n0zynhi5aTDP7DfGbWcQJepmiGx4Uznek=;
        b=JkzTKwH0vz7yUK1EXYvYHFYQ4O1iqu02bEm02khuemo3CV46bkL6686jz8BSM9qp7e
         VLWqHwC6LQe2Pzt3aFz0sXaAOURyNv0g84NCR5hNgFYyruG6HuBd8q4VA9HeVTif/awX
         a6fu4E2PbZJxc5MKgEhTdOpBzwR5YpWQ5ReEUtrxUGeNEQmojV1YGKwe5HryVNiKb7/I
         XFsrtSyDOPQiuU0uUFUVxVFig26rlBlhoY2bCZMI0Jn5mZv3GsOn9+2AfAwEzdP8gdqO
         bPNeFo4yVT9g6wNEiXsI/SR/YnXRF4aBkCqzkk7x/3/VTaWe/N9GS6qzUNmm4WgzfrYw
         TvJg==
X-Forwarded-Encrypted: i=1; AJvYcCXXmk4e+NNK8vdhxjdQTUPAYF95QX3SFGqLrEEfpmffanz1049tru5x1rTfNTsKq4CiOF+H7vP9lPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgQAIXNcjoIMdmmEkrKW5/OW8cofuZnEbnEg6n18N9xl9bLRa
	I0/nr7+bsnxR/fZPr1RyW1nnVRTm4oDs8n10Q6Zl6iBLSD2wHhe0zvSoH6fQqZM=
X-Gm-Gg: ASbGnctBlde/2qcRT/rz/PZ/sR9cnJviBcQU5xJJHt7YiRx0zDX+StkohfpBP75KJVE
	c5MOYPv6Z9G4XcDVcLF6evhsUdJsStB7Dnn3s86y+es5Jg9ViyActPc1Pf/rkjjGqHXahrE8bhm
	yZs3p3ZHE9NoMg6ukDT7e7fjGLSh915ey5HLM8aiNtENzchM2MSGfpdA9A1PVD7xpk++kHNUCsV
	NYd7V5BIZGhKi23C4Ui9lNtgnZhLcLe3+ZSgk8v+glzegVPy65ODRcwvc872HmnM5z06fDXB/h/
	VKseXO1jhU171Y3AnOiA4owIpXkMzcY6gTX3siSgLRLCcALTKKF9RSoVNsGk+o/a9UA9mLdMW5V
	h4vGOOQKGsHVUQ0GlB78=
X-Google-Smtp-Source: AGHT+IFyJgQNJ+z2yf/1utBG5Fac687BQ3VUHvz4BzbtEjnzkLxmOA5Hg+XZeYpBEVbRsM1UcB+q0A==
X-Received: by 2002:a5d:64a1:0:b0:391:4674:b103 with SMTP id ffacd0b85a97d-39ad176bad5mr2449680f8f.39.1743065639708;
        Thu, 27 Mar 2025 01:53:59 -0700 (PDT)
Received: from archlinux (host-87-14-238-193.retail.telecomitalia.it. [87.14.238.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6445sm19355197f8f.71.2025.03.27.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 01:53:58 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:52:47 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Corbet <corbet@lwn.net>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: iio: add documentation for ad3552r driver
Message-ID: <uvpbdx7nzydkzigvtkx2loz2swkdrikgcbhgnlnwa3umk6ejk6@miwwdfqy3leu>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>
 <Z-R_fiDpOqV6yXcd@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-R_fiDpOqV6yXcd@debian-BULLSEYE-live-builder-AMD64>

Hi Marcelo,

On 26.03.2025 19:28, Marcelo Schmitt wrote:
> The doc seems to be all about the high-speed setup despite classical SPI support
> being mentioned. It would be interesting to see how the regular SPI and hs
> ad3552r IIO devices differ from each other (wiring connections, IIO device
> interfaces (attributes, debug files, ...), any other relevant peculiarities).
> Some comments about that inline.
> 

had to add this file mainly to describe ramp generator usage.

The ad3552r (classic SPI) is quite old stuff, may work with whatever
controller with classic simple SPI (SDI/SDO/S_CLK/CS) so no particular
wiring diagram or explainations should be needed. 

> On 03/21, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add documentation for ad3552r driver, needed to describe the high-speed
> > driver debugfs attributes and shows how the user may use them.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> ...
> > +==============
> > +AD3552R driver
> > +==============
> > +
> > +Device driver for Analog Devices Inc. AD35XXR series of DACs. The module name
> > +is ``ad3552r``.
> > +With the same module name, two different driver variants are available, the
> > +``generic spi`` variant, to be used with any classic SPI controllers, and the
> > +``hs`` (high speed) variant, for an ADI ``axi-dac`` (IP core) based controller
> > +that allows to reach the maximum sample rate supported from the DACs, using the
> > +DMA transfer and all the SPI lines available (D/QDSPI)..
> Is D/QDSPI about dual and quad SPI? If so, what about saying that more clearly? 
> 
> > +The high speed driver variant is intended to be used with the ``adi-axi-dac``
> > +backend support enabled, that is enabled by default when the driver is selected.
> > +
> > +Supported devices
> > +=================
> > +
> > +* `AD3541R <https://www.analog.com/en/products/ad3541r.html>`_
> > +* `AD3542R <https://www.analog.com/en/products/ad3542r.html>`_
> > +* `AD3551R <https://www.analog.com/en/products/ad3551r.html>`_
> > +* `AD3552R <https://www.analog.com/en/products/ad3552r.html>`_
> > +
> > +Wiring connections
> > +------------------
> > +
> > +::
> > +
> > +    .-----------------.                .-------.
> > +    |                 |--- D/QSPI -----|       |
> > +    |   DAC IP CORE   |--- SPI S_CLK --|  DAC  |
> > +    |                 |--- SPI CS -----|       |
> > +    |                 |--- LDAC -------|       |
> > +    |                 |--- RESET ------|       |
> > +    |_________________|                |_______|
> 
> This only describes how the HDL IP connects to the DAC which is the high speed
> use case. Maybe add a diagram for the regular SPI connection wiring or say that
> the above is only for the hs setup?
> Also, what about adding a link to the HDL documentation page?
> https://analogdevicesinc.github.io/hdl/projects/ad35xxr_evb/index.html
> 
> > +
> > +
> > +High speed features
> > +===================
> > +
> > +Device attributes
> > +-----------------
> This is only describing the debugfs file. What about also listing the usual
> IIO device channels and attributes (out_voltageX_raw, out_voltageX_en, ...)?
> 

they are already documented, since part of the iio stuff.
Please see Documentation/ABI/testing/sysfs-bus-iio.

> > +
> > +The following table shows the ad35xxr related device debug files, found in the
> > +specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
> > +
> > ++----------------------+-------------------------------------------------------+
> > +| Debugfs device files | Description                                           |
> > ++----------------------+-------------------------------------------------------+
> > +| data_source          | The used data source,                                 |
> > +|                      | as ``iio-buffer`` or ``backend-ramp-generator``.      |
> > ++----------------------+-------------------------------------------------------+
> > +

Reagrds,
angelo

