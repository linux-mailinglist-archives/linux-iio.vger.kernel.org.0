Return-Path: <linux-iio+bounces-3524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0072F87C0EA
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8281CB21E70
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C373502;
	Thu, 14 Mar 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YRZ3ERwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1E5C611
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432351; cv=none; b=s4qWfXKH8pDrXjW57P6iYhTAOz4zzJG1uNJofjNfaN8hUNFmrkgPQwXuMsKFw/spfOrkpageiy8HclMgsLjHDGJen9wb7HxWl6DAQWeQ79lB1A4M80kOp9OIoGzxuXkm2p6/dahWB3Zp41ZCoPvopQeux8B7DajKDbwylUbFHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432351; c=relaxed/simple;
	bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPU8Zji2TLyNb8EM2xL2Ns7jvJbVyZjJtfU5hYatcxaDZ3ZfJoCieJrZsmtJjkBm9y5b3N00XtqN0X0N2dJqbjgKPMfNZ2FLsIxdjX57AXbUHgRBb0Efw0+B+kJJMoEyW4JendwKJEbF9rj7g+rQVj6UjRf+afnwncBdhh9B5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YRZ3ERwh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d288bac3caso14304181fa.2
        for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710432348; x=1711037148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
        b=YRZ3ERwhBZzZY50paHZIJSPlOw30kTWZrLCLDDWO3ZCig7FoG3aLJPkR0s4abflecE
         R0OBR39tK5VvoEzg6JyOIGa3VdFfIYAZspq7pR3HsEuAvZ7xTIIjkJkBjzyfeJWysPh2
         Y46bnvJ4BqCVy8Rk1qVRapMbdQ0fPXV0DdOxP6GUKOyYfNaG1ZYIauTSAkdKHgnDg2MJ
         ghGDyFMxEamhRpUi7y1eoGfawi5FgucA6v4c1vaNxa7Y7C5F8njaDUx/IRH68/39ivUC
         TMLGgHvXBTbeZA5wA5GJTbZ9xt0Qlw4FJSbODCsR2Ww2yaGEEQg7/TCcV6y6XWVGTjJj
         Umrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432348; x=1711037148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffDXoKBWQURZ1YqNHkbBDZZhwob9lLULOqQyYM8v64k=;
        b=Jk6uSDcTuk7/dmt3rOSVjwR8djXEpPcC5vz5Mjr0ZkN7vDZU7ZxTbzHempmh4jeL08
         pHdDmIdGfmO0zU7/16AP5P+FNdOkC3CYkD4ZIt3jLhPkD2VYK4OGy0mJUcpo9rlFa6cB
         KIGZ2imoF63AqoCY2Dpggn4Zr9BPDnnA9LjrcutGzBoPxIKf6xBapsik8zI19tNBt78w
         WFrGOrxXXW+HU7C53gt8Wpxd/s3tfnNHBaLuyWizmrdey8Sppcx0wRMFe/CqZRD2/gFf
         oF9WxOSGdoOq2lHvk1b6Cmx5Jd4L+6cWq1KyCIPR6MF9dPPUKN3mPIQ3+iv/3IsYB3rl
         sSyg==
X-Forwarded-Encrypted: i=1; AJvYcCUDh0x5cv/qzGiCNYs70xkmPpl89xEPdglH96LL6quLNh+ZIUHbetPLuirEPpp84GXCNwg8j9jBBmmOh3aqIY+qIEH8qzz7pwKG
X-Gm-Message-State: AOJu0YzC0ssQLh9c/qEYqaJIiulhFnmR3dflVKDSrcj1Mb4E0tCK1yyi
	UITA27FHsir5sCXeAp+o/+X4C4DDTGIN2NXHDVWI5sl7LR92l5/wEb4y3/OzI2Pdum7L9NFAq8B
	oRCbtQaft+mXcgiUmkaxJO+1fPL7dM9TsGu4raLBBDcozGQB6
X-Google-Smtp-Source: AGHT+IEI+R9IwFNzp7XCIfN3Lxbmgb+bzqnuZPvIxGrbMiXAxsfqZXMDZP6WdFW+89spArIFyY6oxXuKf+JhVk8h9Xc=
X-Received: by 2002:a2e:b8d2:0:b0:2d4:375e:9e43 with SMTP id
 s18-20020a2eb8d2000000b002d4375e9e43mr1783013ljp.27.1710432348394; Thu, 14
 Mar 2024 09:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
 <20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com>
 <20240314153049.5895703d@jic23-huawei> <CAMknhBFtN7haURhV-TN13kxtMm1otpAz8UMX7VT1xmxz70nPYg@mail.gmail.com>
 <20240314160143.2ee0cb02@jic23-huawei>
In-Reply-To: <20240314160143.2ee0cb02@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 14 Mar 2024 11:05:36 -0500
Message-ID: <CAMknhBGLk7z1OzXOMrj051BYtXyiOai_T5LB=cxCACH2k29aJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: iio: new docs for ad7944 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bah, I missed the reply-all on this one to, so for the record...

On Thu, Mar 14, 2024 at 11:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 14 Mar 2024 10:47:43 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On Thu, Mar 14, 2024 at 10:31=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Wed, 13 Mar 2024 15:21:52 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >
> > > > This adds a new page to document how to use the ad7944 ADC driver.
> > > >
> > > > Credit: the basic structure and some of the text is copied from the
> > > > adis16475 docs.
> > > >
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > >
> > > In many cases I don't think it's useful to have a per driver doc, but
> >
> > Having upstream docs for each driver is something that Analog Devices
> > has requested. So unless you object, we will be submitting more like
> > this, at least for new drivers.
>
> Keep them focused on the unique aspects and I'm fine with more docs.
> What I don't want to see is too much boilerplate that might rot.
>
> If a whole bunch look very similar see if the docs can be fused even if
> the drivers aren't due to different register interfaces etc (same
> as we do with DT bindings).
>
> >
> > > for this particular part the asci art diagrams make it useful - so th=
anks
> > > for putting this together.
> > >
> > > LGTM, but I'll let it sit on the list for others to take a look.
> > > Poke me if it looks like I've forgotten it (which I used to manage
> > > a lot, but patchwork keeps me organized better these days!)
> > >
> > > Jonathan
> > >
> > >
>

