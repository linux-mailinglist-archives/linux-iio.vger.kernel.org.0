Return-Path: <linux-iio+bounces-12958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237389E0AB0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D83160732
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE361DDA33;
	Mon,  2 Dec 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+RUxXSV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5D1DB34E;
	Mon,  2 Dec 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163040; cv=none; b=PhgeKP6tUhVXr4x9SQDFTAzS7TMYnmm5aqS9OglpQAZxoOBcVL5ot1QCI3XjYNzhD2EF6BJI192dyAj7yAQJtOJXpNouLCMDhdjFlXTvjVWsGwE9j1Udzc8/z+yFG56gZcYW/c+UcMcYCX61CJrD4c8W2jTjIGyt5ynYjISGyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163040; c=relaxed/simple;
	bh=JCcBmHRjBUUPP3F7jh1ScH6I0yX/hoBPdtcZGSXJlEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrfWkguVgCYDsGl7WLPrzFl850jmYZ4bDvkfbAsSKDJTjIAaH92AclBansASLrslvsIYSpTcCSOMl3kA6wFHX/cJOOXQPXtxEaGGEchjaPZvS/v8cjlUZRIA2GGGLryHwZZPw0SjG58BRbHPI9Y4BcaKf8ngxER869ZG7tm+8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+RUxXSV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so39151845e9.0;
        Mon, 02 Dec 2024 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733163037; x=1733767837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/bDUOUKCdfAWxBGqG/NiOfHdEF6PadteEpEhnTmruM=;
        b=I+RUxXSVSXdEw43VPnMhGYOxGMUKQPwXGt06gIN995MwGawbPCvg5eCG8ZxF29s9M5
         ocWZjdcJ8CzYDsG1VSK2pvttWAii1HDpKEQIsgslS6+paQEo9WXKVgPl5QR81+512DTs
         xpKP/xkkzLaKtshuj50h8ufJ3SXqYgfBgTd9EGFK8g0sDVyNUIcHCgwqRMTP6k0PwFpL
         sM6KdMmI6DmXwoT0cBE6If4xYXmX0s9Ui6wCCjvLzXFbq3lFS0O7Q3RYE4jlsnixrMfd
         Mj1t75aF0X4Qn68BJZHoS6v7X/4VRDGUr6+wrWARCDuyKonMs8gLqnvncTgNSgbaFAmK
         1tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163037; x=1733767837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/bDUOUKCdfAWxBGqG/NiOfHdEF6PadteEpEhnTmruM=;
        b=i+RQTM1BN4SpBuB/xkZdyQKau8OdSODFAR88Sx47m9fXo09noHkQ22oJNlDXKv3XIT
         qmf4L+H18CPk6VHZzXDZVOpPdnNSRO20iKUQ3Gr43yCqlWpMDbZ/H7q//NRt0i6Kfja4
         uK/6KqfbaGsjJBhQFMCh+gabh67eXwjsZ2LHo5gCniaN3lrOIwPmOzx5e+4RXaXXVTCs
         4QrgcJuMSx24ssQmtEakZNqLwTnJ3FL/99t6xpTJgqisSqf/rEiA17GQpT/ZTUy/UKHL
         d/hbj/Icu3YDMtw0piOL1/pAuJMmqh+K7DPor/LvIllo9IJUYiRybJevfNgnaUsA7sYG
         Xvow==
X-Forwarded-Encrypted: i=1; AJvYcCU76NODZwqnHiHGWkq0gUIBIcpZ/rRrc0pBb3VCsd6PffMyiS/EYBCvJJ+MHhTXloUVt/Hkgw3Ko6WL@vger.kernel.org, AJvYcCVHcBmNvMmHiarCHgfLxyKYKMmbYikivPDVujHBbVU8mP8NpVB+EafbA7cujGYU5vXTHf6o87g8xNQqpQfy@vger.kernel.org, AJvYcCXqfHdbS9qmjVGfM0cRI4SkQfETwjuen0JBFaltpSSRSzn9iK5A9aCWem28LTAJRCAt2Va71A/7oj7+@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPQgTHjSiZGDryomJlLKq4f49VTIfLPL47he7bFIHnyAa0Nxg
	PWgvpP6e0yhI/iwtEM4NA8UUawGU+nBw12YN0Uywibsury6vr26+MkXzU5Sf
X-Gm-Gg: ASbGncvSQKiuwnwpCfblwEKebUpi9z6w1lDAQ51SbnZMLDyIqOTgDyZfYEipsx+MIER
	rpQFcaYRKdRGMeSmiMSgfdMjqqUw1caJAVxYNKw32J0sthe+tM7h5XCN+NJM6o0Alu1TQD5YEoB
	2XoDW0TO5pK6F+QP/QeJioHboC3IsugyTQmyKG/nN81yZZtccLwlnNnn0QjwQgwWpo2L7HVm2x3
	DKTZT9IuTit4guFgP9sdX0FMOx07TBBhlK7FfxNVlbgGDqE3ytMwdA0OJko
X-Google-Smtp-Source: AGHT+IFjaXRrWoOQtwQmNtzgxkLgfhXJKuT2fz0Zc260lgPH3GXXNS2j4U/sm42npOv+ehz+32iBhA==
X-Received: by 2002:a7b:c8d7:0:b0:431:5863:4240 with SMTP id 5b1f17b1804b1-434bac069a2mr125481295e9.24.1733163036753;
        Mon, 02 Dec 2024 10:10:36 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm191051565e9.37.2024.12.02.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:10:36 -0800 (PST)
Date: Mon, 2 Dec 2024 19:10:34 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ajarizzo@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] iio: pressure: bmp280: Minor cleanup
Message-ID: <Z034GpIBvW7yR4x4@vamoirid-laptop>
References: <20241128232450.313862-1-vassilisamir@gmail.com>
 <20241130143035.03218d3b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130143035.03218d3b@jic23-huawei>

On Sat, Nov 30, 2024 at 02:30:35PM +0000, Jonathan Cameron wrote:
> On Fri, 29 Nov 2024 00:24:47 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > This series adds the SPI interface description on the device-tree file
> > of the sensor, adds proper self-described sized variables and performs
> > a minor optimization in time variable names.
> > 
> > Vasileios Amoiridis (3):
> >   dt-bindings: iio: pressure: bmp085: Add SPI interface
> >   iio: pressure: bmp280: Use sizeof() for denominator
> >   iio: pressure: bmp280: Make time vars intuitive and move to fsleep
> Hi Vasileios,
> 
> I took a quick look and nothing to add to the other reviews.
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Thanks, I will go on with a v2.

Cheers,
Vasilis

> > 
> >  .../bindings/iio/pressure/bmp085.yaml         | 35 +++++++++++++++++
> >  drivers/iio/pressure/bmp280-core.c            | 39 ++++++++++---------
> >  drivers/iio/pressure/bmp280.h                 |  8 ++--
> >  3 files changed, 59 insertions(+), 23 deletions(-)
> > 
> > 
> > base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
> 

