Return-Path: <linux-iio+bounces-9634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E697C095
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BCA1C21108
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810F1CA68A;
	Wed, 18 Sep 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxgwLGGo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C812B17C;
	Wed, 18 Sep 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688252; cv=none; b=kDUKIVdNIbq+kF1z3Hln7R6B5CXESD6BNnNqDco6HrWGrIWdMUbOoVj7cE8hTGH5FWMKzNzVnDr6KMRR3YWsNKpdmgkCKpp+/HfjyFOkM+uWazSnehUtEkSKzge2pC8b4HPbqx92+F4+5m6xbvRnuyG+vMpdnItRNEsVPLkgMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688252; c=relaxed/simple;
	bh=zDYQWTIhiMYMR0EoY4sA61Ow0Qr/uf931f6PnGZyfDA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tktm5S1GfsWzXIrtmxa/wFkwAhIJDtW6kMmVPgq71SzUaOsYOU6oI98xMAVTGXeYBjXcpKGxsyApsBfq2z3ceIX7bTGsmZ2dei3GC31pv6AZj/KdQ/O3XDtSvQwB7/xCX57C0/wGGPmsHpH9krDcCvpJELnzt1AiQx3CBQINJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxgwLGGo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c43003a667so98643a12.3;
        Wed, 18 Sep 2024 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726688249; x=1727293049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ujqP7vqwBnjKwxl4b+luXJQe0AwUfMaVjEiTFXQJ9s=;
        b=PxgwLGGomFKpbXxgWiXDCdJKyfh6sD7gxJ9aValQEJdFcQ0OPcNaxILf5gmYm0vGEs
         NsftEYMZbl81z2T/rVO9SeXebA9X53pyacBsoUYuuVLl4a+GAf2P3qMBAVy1PBtR+UAF
         EYjXNSKKqscv8/YBjxlMI5YQLKeW0nLInTNYbxMvX/vuTXGx99gwe/e47fdy0RNyrIeJ
         CxkeZ9NNEfPZddfvZGw8mcdosnxnXLN8JetBYvhzgebm5iL1SXoj+pO3qpvv9vt037nu
         jZppz/D/LmQBxFLdUqkW/DZukwOBPHo+L0sqEYax+L003qQuEoQv1DYZQ1q3TkNIjOkl
         +IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726688249; x=1727293049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ujqP7vqwBnjKwxl4b+luXJQe0AwUfMaVjEiTFXQJ9s=;
        b=Qe317vol9dcVs0V0adMO+OwVAyz5pKAret5omZEKJ6SMQwzH24dReeeihr1Uum8IBE
         aOkNDtOeFjjpwF3RubCIcoWHs7U5ykJil5K2eX4gSSGPSr4FNrp4hnKyCsUCrMVOC/0c
         eMQcNit05Vcwqb6yiD0qE1IsUzbICDVVuAenGKbT6CVDCNo5J3h7aNoubLxWfx8XoikG
         VxELjth5Owd/zNwGQf1HGIPToGCxi1Hu1hOaKI4mzQASy61p4fqKIgIWBb037bR8ibNj
         Me3V3sIRCoPQ9VVsq5aWBeToXcQjJ2zi/SK2PGqlNRZufnLiWCp21Nhlpn/H6GE81bd0
         e0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbd+lFeP7yEEzwfBMDbcR35LXz1FbGQgKOBo1AVfqw3dmbDRohPE9KNr0toE4LGeV0uBKdtumX71cx@vger.kernel.org, AJvYcCW9yJoafTKl4vnrA+7HegGrqW8jP1G/MHN7TDcLAQtx/BqB8SrL6nq0QQfPsjDBKKCi0b5pTvW5A2dhVc/K@vger.kernel.org, AJvYcCX/p4KQmaLBdgjHUYb8lVp9LNsxi3nppBz4h/FowVbbzIZGIr3V8Kinc5NUqme95ZJhJKsmahSXCbIS@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUppi1YcMwMX1tInxWznZGrOZsIcdElDIp3VG5KtP/V37N4VC
	JC9E4+dCzJnVyaKMnP4YaxDCP/TGFTwHYCBsrvRtx14gU9k1oTLZ
X-Google-Smtp-Source: AGHT+IE6MwOYmrR5JAvsCAMsqZ5wy8jRYmQKd4xqJ2jgpqcvWiS/qqeLD5b/WOYHFfzpCY/wc5fS8Q==
X-Received: by 2002:a05:6402:3549:b0:5c0:b793:df4e with SMTP id 4fb4d7f45d1cf-5c41e1b25afmr12822139a12.22.1726688248213;
        Wed, 18 Sep 2024 12:37:28 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:13df:f4c:7014:ee36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb60aecsm5542028a12.55.2024.09.18.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:37:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 18 Sep 2024 21:37:24 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v7 0/4] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240918193724.GA6917@vamoiridPC>
References: <20240914002900.45158-1-vassilisamir@gmail.com>
 <20240914153617.3f816e5a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914153617.3f816e5a@jic23-huawei>

On Sat, Sep 14, 2024 at 03:36:17PM +0100, Jonathan Cameron wrote:
> On Sat, 14 Sep 2024 02:28:56 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com
> > 
> This looks fine, but given outstanding comments on that patch I can't
> take it quite yet.
> 
> Jonathan

Hi Jonathan,

Thanks for the review. I will fix the other patch and poke you again on
this one, you don't have to keep a note. In case, I could rebase this
patch-series, without the depended patch since they are not related
functionally in order for you to be able to pick up this series while
we still review the depended patch. Let me know how you feel.

Cheers,
Vasilis

> 
> > Changes in v7:
> > 
> > [PATCH 1/4]:
> > 	- Use 5ms instead of 5000us in comment
> > 	- Use USEC_PER_MSEC
> > 	- Move parenthesis to make checkpatch.pl --strict happy
> > 
> > [PATCH 2/4]:
> > 	- Remove interrupt description since enforcement was added.
> > 
> > Added also review tags for patches 1,3 and ack tag for patch 2.
> > 
> > ---
> > v6: https://lore.kernel.org/linux-iio/20240912233234.45519-1-vassilisamir@gmail.com
> > v5: https://lore.kernel.org/linux-iio/20240902184222.24874-1-vassilisamir@gmail.com
> > v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
> > v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
> > v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
> > v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com
> > 
> > Vasileios Amoiridis (4):
> >   iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
> >   dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
> >     BMP5xx devices
> >   iio: pressure: bmp280: Add data ready trigger support
> >   iio: pressure: bmp280: Move bmp085 interrupt to new configuration
> > 
> >  .../bindings/iio/pressure/bmp085.yaml         |  22 +-
> >  drivers/iio/pressure/bmp280-core.c            | 580 ++++++++++++++++--
> >  drivers/iio/pressure/bmp280-i2c.c             |   4 +-
> >  drivers/iio/pressure/bmp280-spi.c             |   4 +-
> >  drivers/iio/pressure/bmp280.h                 |  43 ++
> >  5 files changed, 612 insertions(+), 41 deletions(-)
> > 
> > 
> > base-commit: fec496684388685647652ab4213454fbabdab099
> > prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
> 

