Return-Path: <linux-iio+bounces-20883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE291AE32D1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 00:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA311886CEF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE941E0DEA;
	Sun, 22 Jun 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYqhQsge"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236B18A6A7;
	Sun, 22 Jun 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631686; cv=none; b=Ep6yGwtkP+9AZrbkCuq/vtOmJ+m4gNqQKoWRU/7veq+BsyFlxO/FnR4h8t7rBxh8Pa9L5XgLVvNkUbanCm2o8hu0ZDYrhj2qsIiq8ZCkJR0qLdzCTvy7HwrBGV1HXL6VYnH2hZDBOFPykdRPde10E32YIR5xy4cJE3aaTpsdQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631686; c=relaxed/simple;
	bh=56FZmOTINatnI4N0dc4uZPzjt2cQHrnFdILnNRAdDig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5a7fGr2ykubB0/OBJXzgHKYXi0vCqBQLRsxYFPW9vp3CfMIEAqVy2YjT7yo4lnufcEz73FJYYmZWrBiKnXAl80Ih97PtyrihNpxrOm9fg/VQZ7wAVDBdqL3QB7f9A9eoh8VyvkmlIrjgcIvyCAjrPUG42fIcoWQa02RF30i5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYqhQsge; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so2812535f8f.2;
        Sun, 22 Jun 2025 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750631683; x=1751236483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6dyzT+DnAtOOjIPu21CtuI3EkXm3MN9Tfc0lly+C/6s=;
        b=KYqhQsge/q0Xwjccco8+BhsIldnc2B/RQOxOd0jqbINbjslNx/xnrvCNXSG1vMDR4k
         nSgedjogQF1bVI3IxvM39G1P4ufM6d4l1mekL4Ipx0jSJQ3sY6vQpTRytzCNmgaOQKQx
         BtRPdDlRrTCDmVHkt3NuA0H5CutSL5RlFTbwVRtCJSlJweS813O4IiAcKHQAMsjZb+zM
         SqLrd/yxKebffirCqaVsxBuUUScKJgo+9xrIRU7jUIMFGl5ii4O5Kp5dD0GpbzYvYRpx
         YPnjiA7v/hm8Xu9RYZzsYjOCfZ2/p7GN5R/HmVaOM5etqBesS0mh09WSDCVeJMEtZzcc
         0wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750631683; x=1751236483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dyzT+DnAtOOjIPu21CtuI3EkXm3MN9Tfc0lly+C/6s=;
        b=Phk94sSlIMj7Fu3DkTFjIUiQr0v0Wuy9zW4weMiiONIWlXuh8yU3pZA2XWDfC4vAe7
         5Be60QN4jjMnLvkq81orE4Pw6/j/Cb3RsWaVZjahC89/yFZf+Mq7nJYV9QKkbxtF+42N
         bUharXVlf1pGO0t5flciRb9xnVZjZfqJ4XiR9OA8n0xU/htNSELj+buYN0Did0/ozlh3
         /W8KKj2JHnsdqSfgt3oPYdjWhrTuRlmgoEaBvapnwZnOb1WHp0z+pcOcxGS4sryufE9z
         BBiLF+CyxgBoPYtwJltHr3jkaEhG2i2Dm3uwlJvwkVuLPjqGD+1WaUp2F+Ck4lpYra1U
         FwpA==
X-Forwarded-Encrypted: i=1; AJvYcCVdRsI04va+PV+hN0JW39+GM5mWp/Y0NqwrM4p7eMmeEQ7tiksVkxzIO4Ct+qU2VctyXGUmixOKf9k=@vger.kernel.org, AJvYcCXLFqGb+W33LqAGbd+Pog2PTdf++CRFawtLw1NQ2QRdHEtxdOzm+IvDLzyUamdoKA7Yeufynm5P5zh4raEc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0dHbtXSbCB0Jc+cHV7Zd/yXQv1wXXDDefPslH8UJRnDBhFpf
	YrHk8syunQfG0SsHhGaaf5MFZx7qBVP/nqDFulgAvYv9ZkkTXWgLF2Te
X-Gm-Gg: ASbGncvThWKT2i4doK/By4bQd70TqwJd2qiG6WTpLnOlFp8ofZr9se2jfJbMn5eft/X
	ZtvOmyZuvC/w0qzQUJ4So1rgR7e5SUr7ZdWMi9OxTpTSsfRn6awo3e48u9UGifFq9Lw9JJ7L5Mi
	67YsMV+qFzUKRtbbeNAqaVjPCRG4A4gs0rze8H0WBMIR6QdXv2GQunD+H6x5AtVOaWe7np+Qz8r
	MdlJhPnzvTvkOEGcSKJa/zP90Qq5JCA/WCZJTnddW12kAineMgILM4dxAY/qz1KIx0nOnfzklD0
	L7beF7XKYQev30BxqSbBieRHb+O48zhwyoiZDvQbChHRM4enQHnPusbjOLIuFBeFNV9xmjyC/2k
	xxwNuXA==
X-Google-Smtp-Source: AGHT+IF9BKjS8kYWw0g6v/2eyrOc8smZVIaGMFgbkK+T3A0YK8lvhJPTkhIWJaHaC2S7zAWDIBQlMA==
X-Received: by 2002:a05:6000:188c:b0:3a5:39e9:7997 with SMTP id ffacd0b85a97d-3a6d12de854mr7826876f8f.34.1750631683033;
        Sun, 22 Jun 2025 15:34:43 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:67ea:4395:411c:f77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364708297sm92052065e9.35.2025.06.22.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 15:34:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:34:40 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: liquancin.mereenamathai@in.bosch.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
	javier.carrasco.cruz@gmail.com, Xu.Zhang@cn.bosch.com,
	Maoting.Bian@cn.bosch.com
Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Message-ID: <aFiFACUn2z5jD3WN@vamoirid-laptop>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
 <20250622160637.554b1953@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622160637.554b1953@jic23-huawei>

On Sun, Jun 22, 2025 at 04:06:37PM +0100, Jonathan Cameron wrote:
> On Fri, 20 Jun 2025 10:24:53 +0530
> <liquancin.mereenamathai@in.bosch.com> wrote:
> 
> > From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> > 
> > This patch series adds support for the Bosch BMP390 pressure sensor to the
> > Linux IIO subsystem. It includes the main driver implementation as well as
> > the necessary device tree bindings for integration on supported platforms.
> 
> Hi Liquancin, 
> 
> Great to see this driver.  However, it is huge which will make it very challenging
> to review.  I'll take a first look but in general you need to break this up
> into more manageable steps of building up driver complexity.  The driver
> must work and be useful at each step, but the usual approach is to introduce
> first a fairly minimal driver that does basic measurements only and then build
> up from there.  If any patch is getting substantially over 1000 lines of code
> then it becomes unmanageable without reviewers dedicating a significant chunk
> of their day to that review and hence them finding that time can take a while
> if it happens at all.
> 
> Only exception to this is that the dt binding should be as complete
> as possible from the start.
> 
> Jonathan
> 

Hi all,

The BMP39x sensor is almost 100% identical to the BMP38x sensor for
which there is a driver under drivers/iio/pressure/bmp280-core.c. This
driver also supports the previous BMP28x, the next generation BMP58x and
the humidity sensor BME280.

The register maps betweem BMP384, BMP388 and BMP390 look almost 100%
identical. You can check also here [1,2,3].

Liquacin, did you try to see if you could use the aforementioned driver
to control your BMP390 device?

Cheers,
Vasilis

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp384-ds003.pdf#page=29
[2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf#page=30
[3]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp390-ds002.pdf#page=30

> > 
> > Patch 1 adds the IIO driver for the BMP390 pressure sensor.
> > Patch 2 introduces the device tree bindings documentation.
> > 
> > Liquancin Mereena Mathai (2):
> >   Add the iio driver for bosch pressure sensor bmp390. The bmp390 is a
> >     pressure sensor module. It will support SPI and I2C protocol based
> >     on configuration.
> >   dt-bindings: iio driver: Add BMP390 pressure sensor device tree
> >     binding
> > 
> >  .../bindings/iio/pressure/bosch,bmp390.yaml   |   65 +
> >  MAINTAINERS                                   |    7 +
> >  drivers/iio/pressure/Kconfig                  |   26 +
> >  drivers/iio/pressure/Makefile                 |    1 +
> >  drivers/iio/pressure/bmp390/Kconfig           |   29 +
> >  drivers/iio/pressure/bmp390/Makefile          |   32 +
> >  drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
> >  drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
> >  drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
> >  drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
> >  drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
> >  .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
> >  drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
> >  drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
> >  drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
> >  drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
> >  16 files changed, 7296 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
> >  create mode 100644 drivers/iio/pressure/bmp390/Kconfig
> >  create mode 100644 drivers/iio/pressure/bmp390/Makefile
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp3.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp3.h
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.h
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp390_i2c.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp390_spi.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp3_defs.h
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.c
> >  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.h
> > 
> 

