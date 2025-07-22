Return-Path: <linux-iio+bounces-21855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B425B0D3F6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BA188A8F4
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15328AAE7;
	Tue, 22 Jul 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzAW2O7m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE43289340;
	Tue, 22 Jul 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171008; cv=none; b=F/lu0+gJe/Xx4RhUsrNMs4DULy6em2fGytdBNWBFX4fQQoHtcvYfOALyrotljRAc9JRdEwUH4FVfHMRwo/VsHe4JOfGEZgwRFPMFqSXT778nuED0hqdOmlxw2EgKEnrI/V+DKFJ/UnTZor2MYCq+Ktdvc544XQI0inqA2McF5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171008; c=relaxed/simple;
	bh=3Mq8C1u4uiVOenLn4D4MoCQKayAJRO/M2RtqmPGx1NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGr/zZKj84BOr87E0M/ZioHBiMebN8ejx0fvqsK/HB86Vbh/Yr2AZ/ne8dZqxibIzsNohjeJVgV0PZdDO4ySer/RKaOezlFw8/dNIyWArKrW1fyDHPLmVHRvCwoUghi9Gosf/LWCyo0WS3yABnNW5GShE+jVylE5FUfnMyHg9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzAW2O7m; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1132414766b.0;
        Tue, 22 Jul 2025 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171005; x=1753775805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unD8x7uEw9NRMW10AGCq7RHtH0IeVfWW1oGZH9PpU7w=;
        b=fzAW2O7m2KynRiBwvyXd8ChdiieuHjEBvOlJc3MMfTgXCRS92/jIx7eIce8K+wc78w
         VunmgZMqYy5zSOcRuxAJcqNoEXTils3/CVwUpCXvfliPQa/4b24uL97Ff/CCQtJM4W+a
         Aml+libqU/WsolfitI7xGa5JA/c4srRjh9DQTlrd2+vWC9TqaTVNTm302QBZgJfoO6pu
         SxFPid8MJoJkSFDmMTpeqZfip8ed8lYE5O3suga+t7GQuNivgZ9en+KW+gr38PcNk/KY
         JKLKbLUyJvT5vMWfTsSd40xL/l9lfBKt92Jn1c5usQziy8YlR1l/gffQpiQ6+VqIvPX/
         Sqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171005; x=1753775805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unD8x7uEw9NRMW10AGCq7RHtH0IeVfWW1oGZH9PpU7w=;
        b=GNVOi1x5GC1a3cIHxFLpJiwe6pPxbCrml7C+glxdYak4wqZ5K2l8oNw3cgPwjx3Pki
         85bu66RdxVmRIA/jVN9VxfoBc6plQdiagCmqT5kwhLgr8+w2sAd8SQKsu+VR2o9f6bGT
         0RlkqC1rBCdQTk7mp+STV/hD7GQ7omEP7/jUofJR2iHclJzPR6Q0MicgAS+2PJ+AP+tQ
         yJYSwMxXlUzf9fk65bXUr02L45xx6pBurHwuUXKdzc+44IdeAt1+Mk/rhnnoxtUyPyZx
         PY/ZYERoAN1J43zUw5ELO9KCoIZ6HxHURFOBLx2gl5oXZKkjkeLNRkXyQQXsqruxxhfe
         AfvA==
X-Forwarded-Encrypted: i=1; AJvYcCUlPNLYKK6Ptw0vSkh9NeehntAGCHt7rTfm8HdrpvwDXSoPEdvSby6e6nhgg2gc9jv4KL14rfzAcyGV3y4P@vger.kernel.org, AJvYcCWqM3OLNhFs4Fb+i0imQuGBpgCjZIXYFALK+cOv+9fHFAG7SoC80dG9LD1JN5oGpLbntgQe6V0XKBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlu7p7IlAIdN9sFdkDtRLWe/m5CaOf1wVsL/hg9ycvMcMdvGwa
	U/TVRaDW7ft03FPAHmhdcMaYHjVBDcj1/+g4GRG7/fwDU7wAcMTgyUrO
X-Gm-Gg: ASbGncsbSxftWV68Eo7bEcJJqBN2PxIbsQ4bRhRBn988atMyZzTXdYB7epn/6AGxHBd
	SKVmpXBVjVGyeKINpJKOiY+5n3meiusTJRIvrnIVAq7/smZ0O7L6VrsJk+MLJgjw8JjkGPmZWG+
	iGdad2ibMa+5+QcNI3XPhL5vT2Zj8SokTlkVqZSBkgoOMtv+3EZoK9JU+tQoxyy0C3VLzbVKjJM
	QJ+ptwPUY8zod8u5zFZ7fwCH2DMZTFTAl2sfWABBLzjdxcY8tWyQc9zx2ndKOVbX5iY6aFIs/qS
	5Kp7n3r9TSvxPOrB2NlO2SJfmM1yFgtyticrpLVAGktrKEnooGy1r4SK0VjxfYIZyp65bdFjuxz
	B7pWSrEe+hY8xCiJVNQWQDaoRmntWS9X+kW91EPms7Rg=
X-Google-Smtp-Source: AGHT+IE9Tt3yHLnFYuZt7ysenasNtrJZi9n6PvwKoOLgTsyUs4RdX++j7gPboADxbM0FqIPSi0xqHg==
X-Received: by 2002:a17:907:2683:b0:af1:4c23:c8c8 with SMTP id a640c23a62f3a-af152bfacdbmr291849166b.12.1753171004719;
        Tue, 22 Jul 2025 00:56:44 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af244a659a4sm4369166b.22.2025.07.22.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:56:44 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:56:41 +0200
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
Message-ID: <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>

On Tue, Jul 22, 2025 at 07:32:54AM +0000, Guntupalli, Manikanta wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi @David Lechner,
> 
> > -----Original Message-----
> > From: David Lechner <dlechner@baylibre.com>
> > Sent: Tuesday, July 22, 2025 2:31 AM
> > To: Andy Shevchenko <andriy.shevchenko@intel.com>; Guntupalli, Manikanta
> > <manikanta.guntupalli@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>;
> > lorenzo@kernel.org; jic23@kernel.org; nuno.sa@analog.com; andy@kernel.org;
> > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
> > interface
> >
> > On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> > >> Add a shutdown handler for the ST LSM6DSx I3C driver to perform a
> > >> hardware reset during system shutdown. This ensures the sensor is
> > >> placed in a well-defined reset state, preventing issues during
> > >> subsequent reboots, such as kexec, where the device may fail to
> > >> respond correctly during enumeration.
> > >
> > > Do you imply that tons of device drivers missing this? I don't think
> > > we have even 5% of the drivers implementing the feature.
> > >
> > In the IIO drivers I've worked on, we always do reset in the probe() function. The
> > shutdown() function might not run, e.g. if the board loses power, so it doesn't fix
> > 100% of the cases.
> 
> Thank you for the input.
> 
> You're absolutely right — shutdown() may not cover all cases like power loss. However, in scenarios such as a warm reboot (kexec), the situation is different.
> 
> Before the probe is called in the next boot, device enumeration takes place. During this process, the I3C framework compares the device’s PID, BCR, and DCR values against the ones registered in the driver:
> 
> static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
>         I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
>         I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
>         { }
> };
> 
> Only if this matching succeeds, the probe will be invoked.
> 
> Since the sensor reset logic is placed inside the probe, the device must be in a responsive state during enumeration. In the case of kexec, we observed that the sensor does not respond correctly unless it is explicitly reset during shutdown(). Hence, adding the reset in shutdown() addresses this specific case where the probe isn't reached due to failed enumeration.
> 
Hi Manikanta,

During i3c bus init, the CCC RSTDAA is emitted to reset all DAs of all
devices in the bus (drivers/i3c/master.c@i3c_master_bus_init ->
i3c_master_rstdaa_locked). Is the LSM6DSX not compliant with that?

I get your solution but find odd to use the same method as in the probe.
In the probe, you would, in general, reset the device logic, but leave
the i3c peripheral logic intact, because you don't want to undo whatever
the controller has set-up for the current bus attached devices (ibi
config, da, max devices speed, all the good i3c stuff).
For this device, the st_lsm6dsx_reset_device seems to flush a FIFO,
do a software reset, and reload a trimming parameter; which are necessary
to solve the bug you are observed?

If possible, please explain better why the device won't enumerate
correctly after a reboot without the reset. If it is a device bug,
explicitly state that and that it is not compliant. Also, take a look
at fig.100 of the i3c spec basic 1.1.1.

Thank you for looking into this, this type of corner case is usually
overlooked.

Best regards,
Jorge

> Thanks,
> Manikanta.

