Return-Path: <linux-iio+bounces-17597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63FA7A78A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5471897CF8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D22512C1;
	Thu,  3 Apr 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3e6gLeQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B30250C02;
	Thu,  3 Apr 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696368; cv=none; b=KYoAsQPcO/hwpXVlMIvfyNOMZeU7FUy/0uOH50vAdYge/daRAbYO1J57QtXjOUPdjIQZTg9ssUvJsrbWY3+7JM4oNtemAy4yRN/1vNQnsEuZuxu6pkGbTQJGlfV32L2lHSnk1AKUO65I/+qhe53h8rd+5X/AbgT3cEkoIRVHvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696368; c=relaxed/simple;
	bh=YjGjdrzIlECzocgsLLX2osfw8C9zWevju6nHuE11dbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZjwoAvVQa5hK62cEDUsVQpzviTj+QlqqnW/RFCPyWZg1nnUEA8tMbtEFhMDTsrqdH6ZOECbGKESlE+0y5uFscEU49x0hSQ3ClXtwR/moFmf42tJSHy0shr3kyg+ttk26/HTbeitAi4ZYzlJO8KD1cU1c169TSvOAn/H9pctiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3e6gLeQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736ee709c11so996855b3a.1;
        Thu, 03 Apr 2025 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743696366; x=1744301166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CUM1YGBsiV36kXf/ewqX0Mf86Kw8OHi0hTrNzy0FCQ=;
        b=A3e6gLeQUQfUwEmR7vLNzul8A0YWMzx8NanbyERcUp8vB9o7UXJaYEY0d+fwdYrNIV
         432orqrlW8OidnfIY5hv1zASHHbSRdyyEoUTIKKCSlj1tQQeFpaVK3zZIgYZAFCWpqqB
         HhY2mVdY7Xdx0nZQTBR+394I/ccH0zpkHlzz88UPuMK/E69kOPQCj8zrcZP5fwyl16qe
         A5/4xeR5kPgdSsxCc9MDUwT6pjlAHbn0KcthUkDuxPHCCOHxBiWbOzMwvn5D0fiash1l
         cgveInlft3JA9yh5vyNU/mVnx9QnkYc/mgqMSXGlhRVnL+BrjQWXXJaH6ZWxJKCfHdR8
         G8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696366; x=1744301166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CUM1YGBsiV36kXf/ewqX0Mf86Kw8OHi0hTrNzy0FCQ=;
        b=DxhX1+4yxOJr59Dbo96PItwKvE2SmoFLWfyOBHDyDTCuzkRKZM9C5MXfI6bCYm6wk3
         dh/BEyM/XumguKxuguFoJVxb+eqNABWXrwi/tf6XUCiMtzBUVQSTkfrlAYpHhvdJM/Cc
         RxqAndsq8Hphf+2qzKWJOJTtIgI7cGUD/97VWhFbjPR7Z6/Xd0nYERmGB3DemjkuSE7k
         QDNSg4Uasz9IPIP9nP9RsyxTZyhnU8dBD+36jwdAHf0ywn+4btzcwcYYTVDZsXeGybET
         bxFBn/1OUyMsbE+HkGVtvc3HuCl2xnLTjCYYbKcNC4kYX/4tOhv4BYRLQcRQkvJD7aE7
         adbA==
X-Forwarded-Encrypted: i=1; AJvYcCUkU+4hnaLEVS7LEWuNhGI4eDRDeCNrcQKRXTynwVlExL5JnddIirpBepdt9Rb8uUVOZjkusKfYrz9SyjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPVvJ2OBJuwUi26Lbrf05hEaNvcz2H5IbpHX5G6E6TVg8o/eZ
	4RxpisnlH5q6bwuAXuaPvxMjv10UQuouOIzVxDEqWA4yFbeM1BId
X-Gm-Gg: ASbGncsX7/t43yRyad1FwmGwDQcRLKE46A1pIVhFQ/wC6+q3vELs2ivXY+FWkGcn8x+
	G0EpHaF3zgvPdf6ljtncFZLFPrLKLw6hEEQR0pfr/ci/+occG4XKRGK2RmvX+tLg9NhrJ6W+IP3
	v2eMRZGrE5jgtoqiZEy54+HgZXXVFhCc5Hu6n4JF/EoylmgG01W6Lq7J8K5D6c5cZyDf2b6YUuW
	kGnAufwe/ND+yC/Q43v/bcMu1tKF0PU796DzE+nV0rTrbGFrWkc5ywjDX8dxhJ2XnG6R+hr0Ai4
	cNuujtHMMpcHebPhn0HIQ5f1SwrphdwTezyF8P6C/QD1ZzJxHT61qBM=
X-Google-Smtp-Source: AGHT+IFuyj8PnUH67QJmQuVRh5chNtphraUZc7jj56nG+Xj2gh/lxU2i3HorqQk0IXcClAQRgY6fUg==
X-Received: by 2002:a05:6a00:c8b:b0:736:3954:d78c with SMTP id d2e1a72fcca58-739e4b49da9mr162206b3a.6.1743696365725;
        Thu, 03 Apr 2025 09:06:05 -0700 (PDT)
Received: from localhost ([2804:30c:1f4f:6800:9245:316f:6226:cc1e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d97effb7sm1736215b3a.60.2025.04.03.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:06:04 -0700 (PDT)
Date: Thu, 3 Apr 2025 13:07:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
	jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z-6yLe1GyNsFJlph@debian-BULLSEYE-live-builder-AMD64>
References: <20250330135402.105418-1-simeddon@gmail.com>
 <Z-lm8l1ILFuJE5YS@debian-BULLSEYE-live-builder-AMD64>
 <CAGd6pzPe71oY=+cy3WqKPyZ150q3pOM3LrPE0_ENeKgd+OvnfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGd6pzPe71oY=+cy3WqKPyZ150q3pOM3LrPE0_ENeKgd+OvnfQ@mail.gmail.com>

On 04/02, Siddharth Menon wrote:
> On Sun, 30 Mar 2025 at 21:13, Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> > The previous implementation would set ctrl_fp if val == 1 and unset it if val == 0.
> > This patch seems to be doing the reverse (setting ctrl_fp if val == 0, and
> > unsetting it if val != 0). Was the previous implementation potentially buggy?
> 
> My apologies, I seem to have made a mistake here.

No worries. It's okay to change/update device drivers to make them better (e.g.
implement new features, fix bugs). If the proposed change was fixing something,
then it could be put into a separate patch with a Fixes tag. Though, I had
another look at the datasheet and my understanding is that the freq bit (bit 11)
should be set if the user writes 1 to out_altvoltageX_frequencysymbol (ABI
documented in drivers/staging/iio/Documentation/sysfs-bus-iio-dds).
By the way, I now think my suggestion of doing
st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, !!val) was not a good idea since that
wouldn't follow the proposed ABI.
Anyway, it's okay to propose more changes/patches if you want. Just separate the
patches according to their logical change if you make more changes to the driver.

Regards,
Marcelo

