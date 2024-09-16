Return-Path: <linux-iio+bounces-9602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F34979B3C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2761F2357D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E284120B;
	Mon, 16 Sep 2024 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mfKtvdJQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE27FBD1
	for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468716; cv=none; b=EZ425PmmWKrd46BHuaAL0dJFLwZaGa9iwz3PUz0KL7uu/hRO9i39U1cakKdqkKmIP6aqKgxG8r3A9fBQbjctLeEA+wq1PnHJQQeADZTOdflE0XylyrGN2eJoSsa1Jh9Ii/HGSDi6Vif5Zx7UqXOwlLsaaD6gY9yar59x+B8UmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468716; c=relaxed/simple;
	bh=oig6OXmQgvNTyN0YeW/XhB+rJsuKLxXsCUs6pJ0VQV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB3xSPvf3IwSPl6lFrGo+cZ7f7/PTC7+8CXcdWy2S+XeFxJWDvXbgytNQUwlEIp3PD7U5cIMyS7gbsjk1qRqZl5OuMYp+PyuIZGxWtd0PF7u7Z9hQ8msgvOdntsyyHAaf7mDpijfrskSRtUoNH3Yx/Th2mto5yupaUbxcLiaL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mfKtvdJQ; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bcfbc732eso893420137.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Sep 2024 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726468713; x=1727073513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10j703qh//5/vCeG2Vxz+iNKLUAfZSd9B8Dsv2NLu0s=;
        b=mfKtvdJQ8+UpjuiJb+iUdhhD7B6Z90qGkk0TlQJbImAxfqSwSvtj4jKMxWLxaXi1rG
         IEHZaQF+/6kjBtjdS05zkKvTut4QPeFUUmRl3qXSTKM5tA0/ofRl82dtBmgC8byYG6NR
         e0LUfaW54WsdH6VL3l3XZVOaA9EMYr9iTUFb+1alg8VBhl4SPXCmfH+DudyHM9OtIMhK
         CCP8rYmAzw+pMIxSRoEKTKOq0Q3bR6EjasFtKshHWKQpmX/3v6sUT1Pr8y4uERndDUcX
         zEUO5Us7v1S+buMqs7wvYR94shHuqpem8/UVH9E1OZx88M5nUbflSHm0m/Gfb847F9LQ
         SlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726468713; x=1727073513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10j703qh//5/vCeG2Vxz+iNKLUAfZSd9B8Dsv2NLu0s=;
        b=jjzrKNSyGztaI+oW+MX/7C2WeTeEhoU4GRj7QNoOSN0VF7/Xio4LI3hNc4fBLLFvjB
         M2kQ77Qu6SyKHdvPQSqGIXyZXfmHxPdvl/h+Mu5dWkcn0/mLU+ZDBUnfq8AM16zq+3j8
         xYfPgTj7hoZFn3IIGZb3VMbisR5lRfBWOh7gojBQ9cIzg68Sj6ES3nesC5rjtXT3ckki
         hkaNjQjqiioAyKqhqOTEzGKEZjEHnEQ2ojLvuaqwWKUQEjXI513lQuFp7S1S6oOPOOsA
         aMlD1HkNTNJLBzDJpD/hdJJnj4tQhZ0GuGmOIMUtm7EwLrWmfTm1Sq1zP7seP9urT8kF
         /0DA==
X-Forwarded-Encrypted: i=1; AJvYcCXMKcHU+/vAccuY51BIc+J8nBm5nFc1qdCummhvRw7k8FY4TKuuj1su3AqtciysKNgifFlR9BVXGF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2poPLgFy8qH8V3obmxHQWxTSh97t8htNkA1HlQt8mniVCDtJU
	E3VWLGkByw6NqUVHohuA83MWaaVpPT1oJYkjErm8vdSmh7wTgUpCT9k/4UvzdNhD3yfyCvV+GVU
	AQfKjtyQSEwTa3t3oFlFg21NYRSow2r9Ci5jG3w==
X-Google-Smtp-Source: AGHT+IGtd0SK9AEqDNAuLnHCjyOPOiPAieSmbNE5lyxyJmSOIeTqsd9D4ZiH8UMYGHfxo8r0SBQHAvZPHYjlCrnqlsQ=
X-Received: by 2002:a05:6102:304c:b0:49d:4812:913f with SMTP id
 ada2fe7eead31-49d4f6b2837mr6684015137.23.1726468712746; Sun, 15 Sep 2024
 23:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913135744.152669-9-aardelean@baylibre.com>
 <202409140416.KWHXjFSv-lkp@intel.com> <20240914154150.6ce9c1b6@jic23-huawei>
In-Reply-To: <20240914154150.6ce9c1b6@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Mon, 16 Sep 2024 09:38:23 +0300
Message-ID: <CA+GgBR_OE3E7FwcAVy+hD51OPP4wcrSuEWh_9YCtH+fwTwAQLQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 5:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 14 Sep 2024 04:30:42 +0800
> kernel test robot <lkp@intel.com> wrote:
>
> > Hi Alexandru,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on jic23-iio/togreg]
> > [also build test WARNING on next-20240913]
> > [cannot apply to linus/master v6.11-rc7]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Ardele=
an/iio-adc-ad7606-add-bits-parameter-to-channels-macros/20240913-220501
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git t=
ogreg
> > patch link:    https://lore.kernel.org/r/20240913135744.152669-9-aardel=
ean%40baylibre.com
> > patch subject: [PATCH v6 8/8] iio: adc: ad7606: add support for AD7606C=
-{16,18} parts
> > config: arm-randconfig-001-20240914 (https://download.01.org/0day-ci/ar=
chive/20240914/202409140416.KWHXjFSv-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240914/202409140416.KWHXjFSv-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409140416.KWHXjFSv-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/iio/adc/ad7606.c:39:27: warning: 'ad7606_18bit_hw_scale_avai=
l' defined but not used [-Wunused-const-variable=3D]
> >       39 | static const unsigned int ad7606_18bit_hw_scale_avail[2] =3D=
 {
> >          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >
> > vim +/ad7606_18bit_hw_scale_avail +39 drivers/iio/adc/ad7606.c
> >
> >     38
> >   > 39        static const unsigned int ad7606_18bit_hw_scale_avail[2] =
=3D {
> >     40                38147, 76294
> >     41        };
> >     42
> Hmm. Seems like there is no code that would use this, so what is it
> and where did the numbers come from?

Oh that's a good catch from the CI bot.
While reworking the SW scales for AD7606C-{16,18} I dropped the HW scales.
Oddly enough, I don't get the error building locally, I may need to
add more flags to the build.
Will re-spin.

>
> Jonathan
>
> >
>

