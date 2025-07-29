Return-Path: <linux-iio+bounces-22128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BDFB14DE1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ECE54413D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5A1D6AA;
	Tue, 29 Jul 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn3qDQ2c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FB182D0;
	Tue, 29 Jul 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793371; cv=none; b=GdTseqNRIBF89eFx2s6QgrC5bBICftgfypTINOWyCo4MNw67aFC6l2cP6HIuICPD5zh099C0+S940YWDvB2Vw9CsIMlae3YA+PR/466C2Ld5Xeo1UMnvBAfqC9IBkNNCrOOy+xFjJw02A7ig8ztMpOPJIk+lMIEQh7W74SWkCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793371; c=relaxed/simple;
	bh=l5P0dNeZ5wcvR4EUiVuiINTGf7hsTEkrz1gyFJ8cNLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QybFxpt9HeSxThfxhetnzZnBoAPGfPD5A+UrCVgEd1oresJS/AwnMERyApejFJUCygrLcbpt0qNUYySE+mrN/hQ0W+1HCFyFrSwCAFhFF2SPc010YKaA5WGdsOXkjRiTlU5QEXdgeBRgsc/MCVdavw+THhPBwdovyeUeb714EIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn3qDQ2c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so60351735e9.1;
        Tue, 29 Jul 2025 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753793368; x=1754398168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VqGsps1bpTn3A7l4UO8XlQOO9RuaumaS8UOurdem0XM=;
        b=Tn3qDQ2cYqCu2Yy/e9LhokFZwjLyOy5lyjYODR70lQ3cw9Jk8wbb+MEAvRcFdVeGLI
         O9xHgK6MyonS85gcSghHqA9KTqHxPNUa8p2fLeWj44gNkt9u9JSN2LqWB7GDeyOVRG0u
         /P7MamFrgsciBvC6rQKvUrvo9614Ji8DBmndUpNeQoSYSUktLjFd/JHph+Oq8z1t3Ygr
         CQsywK3rvVpz6W5i3JYKJ4gGffaJx6LktsHnae5j3qJeRgOLL1Nep5Rf8imN/UYGHO8S
         FHEdZGRr/4z/toqc6LQyus2zjKgIeuwSUfWYZ38zdFMzAaSXDvdcLRfzovAZOFVqo7gy
         p9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753793368; x=1754398168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqGsps1bpTn3A7l4UO8XlQOO9RuaumaS8UOurdem0XM=;
        b=WVWp+2gBRPAAlCFVMFWCAP90yQBM+5aMM9/iQgGUuEjDLVbVgCfvYWWNr1dhJ5TxlL
         ZKDrZfjTvd5w2rJr1oWA1sIo8hpGtq9hWn+0Ayx5BHtw73UMgkc/An1p1pQWqF4F1VJs
         VQej9eASkm/0mdG+3pat9Hxw0egHT9Zzj+aMyOnAFkF3vHpYo00oUyhFLMWwhlCwadMy
         GYCZUxbAbZMVjb5cWR+N04BeNf4AjWBKPJ+FBBsxUOCegTOeT14c3OG2o9voEeSbH7K0
         EqrKPNGtP8IW1NElG8qnL8e8MQFx3nBphTbdEXvZgM9rYU4GoMhIMWku3gMXSBpYYNo7
         mOeA==
X-Forwarded-Encrypted: i=1; AJvYcCW+rdizO7ryGQP+2eS1l4Y6O3rlQv7EOlLecY3YoSoQhntCl1ud4n0cLerYb/8xZyfowDoIPTCZTEU=@vger.kernel.org, AJvYcCXWxNMlil3mzD/ficyUcOTqi+dctxgsIsCLtMm/CZGVWzLz8JarOJxEzphflJVBS6Loj750FmlHKCe2D1wC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5a/E9xbUzXlD4yLlE7M8E/g6uJOMn4Td5hiAR3Ghh8d4gmfiY
	cuqK0+Va18IZ8ttIi9jcfiDtHXsaawcMMO7YULjfj/BadqcL+mc1Y3m2
X-Gm-Gg: ASbGncshvWYBHBQm0axt2ZEYhPfFUFiltsd8lCYj0kA3KOfCL0EkyHtZWLerUgFsprt
	WONvN6WZlpLzOmLaDlf5x2AkicaHQwDHYcwi67v/RACFnJMBmOx6nuId2syIHDQMuxMaGMmq80h
	nZNvy9tcotPXo+cUbfwIGODTfVAkpCMcmSW+w1W3GkT4Ky+uRmRHkN/7gJTUWFtnSlNHyqPpR7/
	Uyukf8/mem9ypXiTNill7FT8OKoXKJo0QOI8CzeEVH5WwPzrpaEoipFzAvBYa9sgKRgBku8Ph96
	rOnbFI8Vm+188NhLvZJl/Q8rzEBgAcmN9cmwC/kpXT/KuzbOfh9QYb1o+4xN+nHgRg7G/UMqHFl
	scEC7GaSwJVpKXE8OtmUJauQxOHWjaYywYd9Bt+rUoA4=
X-Google-Smtp-Source: AGHT+IFD7B43eEU2jm0IpByGFoMGJ8ott9UA/rXP+woI9geBR9xtKpcmGIxrLSMuA3OA46DdjK/42Q==
X-Received: by 2002:a05:600c:3e10:b0:458:6733:fb5d with SMTP id 5b1f17b1804b1-458838ca95cmr74959765e9.32.1753793367370;
        Tue, 29 Jul 2025 05:49:27 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5d05f0sm24379625e9.21.2025.07.29.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:49:27 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:49:23 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, "git (AMD-Xilinx)" <git@amd.com>, 
	"Simek, Michal" <michal.simek@amd.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>, 
	"jic23@kernel.org" <jic23@kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>, 
	"andy@kernel.org" <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, 
	"Goud, Srinivas" <srinivas.goud@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Message-ID: <5pmqumpue7h4us265co6pya37434t4jvf3b655gtjcohlyhash@3ggx7e2maud6>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>

On Tue, Jul 29, 2025 at 12:02:56PM +0000, Guntupalli, Manikanta wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi @Jorge Marques,
> 
> > -----Original Message-----
> > From: Jorge Marques <gastmaier@gmail.com>
> > Sent: Tuesday, July 22, 2025 1:27 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
> > interface
> >
> > On Tue, Jul 22, 2025 at 07:32:54AM +0000, Guntupalli, Manikanta wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi @David Lechner,
> > >
> > > > -----Original Message-----
> > > > From: David Lechner <dlechner@baylibre.com>
> > > > Sent: Tuesday, July 22, 2025 2:31 AM
> > > > To: Andy Shevchenko <andriy.shevchenko@intel.com>; Guntupalli,
> > > > Manikanta <manikanta.guntupalli@amd.com>
> > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > > > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Pandey, Radhey Shyam
> > > > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > > <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > > support for I3C interface
> > > >
> > > > On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> > > > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> > > > >> Add a shutdown handler for the ST LSM6DSx I3C driver to perform a
> > > > >> hardware reset during system shutdown. This ensures the sensor is
> > > > >> placed in a well-defined reset state, preventing issues during
> > > > >> subsequent reboots, such as kexec, where the device may fail to
> > > > >> respond correctly during enumeration.
> > > > >
> > > > > Do you imply that tons of device drivers missing this? I don't
> > > > > think we have even 5% of the drivers implementing the feature.
> > > > >
> > > > In the IIO drivers I've worked on, we always do reset in the probe()
> > > > function. The
> > > > shutdown() function might not run, e.g. if the board loses power, so
> > > > it doesn't fix 100% of the cases.
> > >
> > > Thank you for the input.
> > >
> > > You're absolutely right — shutdown() may not cover all cases like power loss.
> > However, in scenarios such as a warm reboot (kexec), the situation is different.
> > >
> > > Before the probe is called in the next boot, device enumeration takes place. During
> > this process, the I3C framework compares the device’s PID, BCR, and DCR values
> > against the ones registered in the driver:
> > >
> > > static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
> > >         I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > >         I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> > >         { }
> > > };
> > >
> > > Only if this matching succeeds, the probe will be invoked.
> > >
> > > Since the sensor reset logic is placed inside the probe, the device must be in a
> > responsive state during enumeration. In the case of kexec, we observed that the
> > sensor does not respond correctly unless it is explicitly reset during shutdown().
> > Hence, adding the reset in shutdown() addresses this specific case where the probe
> > isn't reached due to failed enumeration.
> > >
> > Hi Manikanta,
> >
> > During i3c bus init, the CCC RSTDAA is emitted to reset all DAs of all devices in the
> > bus (drivers/i3c/master.c@i3c_master_bus_init -> i3c_master_rstdaa_locked). Is the
> > LSM6DSX not compliant with that?
> LSM6DSX is compliant with RSTDAA CCC.
> 
> >
> > I get your solution but find odd to use the same method as in the probe.
> > In the probe, you would, in general, reset the device logic, but leave the i3c
> > peripheral logic intact, because you don't want to undo whatever the controller has
> > set-up for the current bus attached devices (ibi config, da, max devices speed, all the
> > good i3c stuff).
> > For this device, the st_lsm6dsx_reset_device seems to flush a FIFO, do a software
> > reset, and reload a trimming parameter; which are necessary to solve the bug you
> > are observed?
> Only software reset necessary to solve the bug.
> 
> >
> > If possible, please explain better why the device won't enumerate correctly after a
> > reboot without the reset. If it is a device bug, explicitly state that and that it is not
> > compliant. Also, take a look at fig.100 of the i3c spec basic 1.1.1.
> >
> > Thank you for looking into this, this type of corner case is usually overlooked.
> It appears that the sensor device is entering a deep sleep or low-power state and is not responding to CCC commands. However, after a software reset, the sensor starts responding to CCCs as expected.
It should, from the silicon pov, definitely respond to CCCs, even on
low-power states.
Could you confirm with stm32 the behaviour you are observing?
Inform them if it occurs under under i2c/i3c dual support, only i3c, or
both.
It sounds a little the messages are being filtered by the spike filter
when it shouldn't?
> 
> Shall we proceed with only the software reset changes along with an improved description, or do you recommend any additional modifications?
Confirm if this is a silicon issue first, if so, a note from st should
be issued also.
> 
> Thanks,
> Manikanta.

Best regards,
Jorge

