Return-Path: <linux-iio+bounces-6350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C490B208
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8771C21380
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F81B3753;
	Mon, 17 Jun 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W9xz3IF4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE619B3FD
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632045; cv=none; b=qMOlhJyi4kdqtMUgvOpKR/BADD0tmsjDk8+X37S83P0tJVk1jtFvJbJuIQkfxQjfZdhV43/MVyxgcqAt3dmbcQR2mDIYNanjmIXHNKjOdYafle5R91VDNoYqN2P7LSqZkk2SnMVylRClrWqBvbwKfst98h9dE7wqJI8OT9ig0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632045; c=relaxed/simple;
	bh=3SUojPKHMWFnVEtUmzCvJ0XJVYHWg9uufwDXcUrW4n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0YfYHu0rFWVDf9widP3QPRZ8PIjMnG5rHsScJDszpvoiZvhcVT1Tnhoh48ELae2CaLLvxWlI2oYgjzLUYAH0irOyyWbmn3rUFIwLzscv3JL541Ug1qNavQSya4QDViEoFBdALtcU1MbjP5u7/7PNv6M4TH5v2lBFl/7vqjxm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W9xz3IF4; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so4455108276.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718632043; x=1719236843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HcMYFgMjLj9bfVN/vNd/auegls9+ix6qtJM9yIB3tE=;
        b=W9xz3IF4q30Y9JGoyzWMVfSyeJQDF1fEcKZQ7iDP7StZe/MxTyAu8blo380UCRG+B7
         xhUAVS7A/cf0N91guFIRNQNveTVJfYyHq9VQYs0EMSa6NYruFWr+DiUdSAVJpG3a46sf
         L5xyzERHe1pgihny+UUvxtEoCEUcSFjGsBUgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632043; x=1719236843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HcMYFgMjLj9bfVN/vNd/auegls9+ix6qtJM9yIB3tE=;
        b=DKQfQlr7bLamplzPw/TAjSrwrueozcRBO2oCeBOi5TMoUVISH918Cgqz4YXhCseh/P
         I4mjNy5WoEv0xpE0KpApSkEREkFG7etlGXxZoVWFR4t+lYUMO2MtZgm0tABcKwHvOpVR
         HH0+w+/oBzwhnc9qNtS6pqFIghYhe34Dwe3eB1/3ldM9P3JyepCkXmcg9ePBt6RbgmCz
         6fcij1Llv2eWzc7Jf+JJjmWF5K9Aom8yONLUYYi8dC42uoAq3FO1hejlMoHVVo44nxyP
         ehDgs0rsonL5RYu9aBHChnhrwS7rz7wXiR/HcDTA5Jm8EuZJlRUcaL9qaFYgJhlnck7m
         x0fw==
X-Forwarded-Encrypted: i=1; AJvYcCXrxUO+OWG3GDfiSD0eUo8rqzv69ysd/kfwO15Vq7UqXb5jZCoL7ySSzGGLiRUbPIScc0EP6S1W00rLxXJk2uY+5Q2MaObdTF1y
X-Gm-Message-State: AOJu0YzMjWN2btu63oOftPITAbzX06mjd2WGoeXdc5d18nbled5nIPET
	GSz6GD7hB4VVdzAKdfdUp/NYbpxTWuCtytH8OrcQYlMn3s8eb4G8v5MPuiCaZflFGSTHg7XuafE
	tbwymrAyK7elpdP0ghYYG3mW3v3WyH9XiZicZ
X-Google-Smtp-Source: AGHT+IEn0uy3dwK2KhLXw7MEv8zGGNIiTaQBsPR2kW9tDB4MUQUymoB6SG2mXCXggR/NMBj1eOnEsZO0JKSQmlhOkf0=
X-Received: by 2002:a25:df48:0:b0:df7:7a90:26c5 with SMTP id
 3f1490d57ef6-dff153b3999mr8205865276.32.1718632042819; Mon, 17 Jun 2024
 06:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406152104.FxakP1MB-lkp@intel.com> <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local> <20240617100150.GDZnAJjoH5wZKu2OAV@fat_crate.local>
In-Reply-To: <20240617100150.GDZnAJjoH5wZKu2OAV@fat_crate.local>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 17 Jun 2024 09:47:12 -0400
Message-ID: <CABQX2QNT+rDC3M7UPWwT_XRb8iXiihk4iczfcO9iokUFhn0DJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
To: Borislav Petkov <bp@alien8.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, linux-kernel@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, lkp@intel.com, 
	dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, jic23@kernel.org, 
	lars@metafoo.de, nuno.sa@analog.com, dragos.bogdan@analog.com, 
	anshulusr@gmail.com, andrea.collamati@gmail.com, 
	oe-kbuild-all@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:02=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Jun 17, 2024 at 11:07:09AM +0200, Borislav Petkov wrote:
> > On Sat, Jun 15, 2024 at 06:25:10PM -0700, Alexey Makhalov wrote:
> > > VMWARE_HYPERCALL alternative will not work as intended without
> > > VMware guest code initialization.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-l=
kp@intel.com/
> > > Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > > ---
> > >  drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/=
Kconfig
> > > index faddae3d6ac2..6f1ac940cbae 100644
> > > --- a/drivers/gpu/drm/vmwgfx/Kconfig
> > > +++ b/drivers/gpu/drm/vmwgfx/Kconfig
> > > @@ -2,7 +2,7 @@
> > >  config DRM_VMWGFX
> > >     tristate "DRM driver for VMware Virtual GPU"
> > >     depends on DRM && PCI && MMU
> > > -   depends on X86 || ARM64
> > > +   depends on (X86 && HYPERVISOR_GUEST) || ARM64
> > >     select DRM_TTM
> > >     select DRM_TTM_HELPER
> > >     select MAPPING_DIRTY_HELPERS
> > > --
> >
> > Right, I'll queue this soon but it doesn't reproduce here with gcc-11 o=
r gcc-13.
> > This must be something gcc-9 specific or so...
>
> Actually, that's a DRM patch.
>
> Folks in To: ok to carry this though the tip tree?

That's fine with me. Thanks.

z

