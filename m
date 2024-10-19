Return-Path: <linux-iio+bounces-10763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A89A4CF4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D758C2842EF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABB1DE4FE;
	Sat, 19 Oct 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR60Y4xt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7317BB3F;
	Sat, 19 Oct 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336342; cv=none; b=Vi96WJdV6LdPG+M029u81yvzBAGL/Uym0VIXSBeHxgpfwxdSFaYufO0HlAo68SbQ/brbOA08fSU1iYjV+a/9omffYkBLTwt0V/ku6tMiyDscM1o0V154YTYwomf27Lst0NDSDBUkT1LqgPrfJPcwjV3ZeF7heEk0r1ep67cKnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336342; c=relaxed/simple;
	bh=TqgsntDo86/XPtJOfcK/dtla1EZezr99AZKkx6rJncw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WszUNxOcaL16IrNxDlD8Ea1TmAMdI8wb1sqyWwtP6OkiBADrdp6p/kFET8yEopEt1nh/WCAmIFtszOuCYNoV3XhVuZb4XoddvZOP3dMbHnw2T7dvUOlI4vCX30CFRul1QF/IwkCQOFSYJcwpi6OUv2EKPg/hB36dw0R2i5nglYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR60Y4xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3DDC4CEC5;
	Sat, 19 Oct 2024 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729336342;
	bh=TqgsntDo86/XPtJOfcK/dtla1EZezr99AZKkx6rJncw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bR60Y4xtH5/bADxOrujSsV2mSA9H3OJRyG13NZBmkBYHHjcG5qCFMcADRSZYPabxJ
	 sdYov5km3gc9RqGfgmPWZbkS6Ui+97CSkMf6xKv8I0pQNiz5Tg4pm63/wKPlUczQ16
	 ehK6m1ItPlQvn5CLqdSl2vBnlXzj2OdlKijw8wFHNc2duuFViEbed19zbD5rydXrRG
	 hAAkpfZhFGWI3a1RL9TpF0oBfVGXzjh+gkqNPUdWqftWsqaS3FrfYG0ZJ0RRaUCMIu
	 4YwIkWJS40ilwiTL6PYZyPvNfY2kdw56NeqMGj+sENFTWcWKDCwPfmp4CGFiBofv90
	 vsF1IJ9D0t0sg==
Date: Sat, 19 Oct 2024 12:12:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI
 IDs
Message-ID: <20241019121214.262af972@jic23-huawei>
In-Reply-To: <aa7f2214-203d-4b7d-82f3-188fdc6b8673@redhat.com>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
	<aa7f2214-203d-4b7d-82f3-188fdc6b8673@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 12:33:55 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 18-Oct-24 4:57 PM, Andy Shevchenko wrote:
> > The commits in question do not proove that ACPI IDs exist.
> > Quite likely it was a cargo cult addition while doing that
> > for DT-based enumeration. Drop most likely fake ACPI IDs.
> > 
> > The to be removed IDs has been checked against the following resources:
> > 1) DuckDuckGo
> > 2) Google
> > 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> > This gives no useful results in regard to DSDT, moreover, the official
> > vendor IDs in the registry for Bosh are BSG and BOSC.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/gyro/bmg160_i2c.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> > index 672d0b720f61..a81814df5205 100644
> > --- a/drivers/iio/gyro/bmg160_i2c.c
> > +++ b/drivers/iio/gyro/bmg160_i2c.c
> > @@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
> >  
> >  static const struct acpi_device_id bmg160_acpi_match[] = {
> >  	{"BMG0160", 0},
> > -	{"BMI055B", 0},
> > -	{"BMI088B", 0},
> >  	{},
> >  };
> >    
> 
> Doing a grep on my acpidump collection shows that the BMI prefix is used
> for some Bosch IMU-s. It seems that some of the Bosch ACPI HID
> prefixes are like this:
> 
> Bosch Measurement Accel -> BMAxxxx
> Bosch Measurement Gyro  -> BMGxxxx
> Bosch Measurement IMU   -> BMIxxxx
> 
> In itself these 3 non official vendor prefixis seem to be quite
> wildly used and such are not an indication that a HID is not in use.
> 
> But using BMI which is for IMU-s in a non IMU driver is suspect.
> Note that has Jonathan has pointed out there is a valid BMI0160
> HID used by the drivers/iio/imu/bmi160/ code.
> 
> I also notice a "BMI055A" HID in the bmc150-accel-[i2c|spi].c drivers,
> which seems equally wrong.
> 
> It seems that if anything there should be a "BMI055" (no suffix) HID
> for drivers/iio/imu/bno055/bno055_i2c.c, but we should only add that
> if we actually encounter it in the wild.
> 
> TL;DR:
> 
> I agree with the removal of the "BMI055B" and "BMI088B" ACPI HIDs
> from this driver, because if these are valid for anything they
> are valid for the bno055 + some unknown 088 IMU drivers and not
> for a gyro driver.

Not so simple.  The BMI055 is a multi sensor package. So two
MEMS devices shoved in the same chip package. Bus is shared, but separate
chip selects and entirely unrelated register sets. We handle these
in DT via _gyro / _accel postfixes on the compatible.

These used to be common in IMUs though it seems fully integrated
ones have replaced them.

https://lore.kernel.org/all/1409655597-28781-1-git-send-email-irina.tirdea@intel.com/

The A/B thing makes me particularly suspicious as that's a novel
invention for something not in the wild.

Still, if we have no evidence this one is actually used (and it's an
ancient device so I doubt we'll get new users!) I'm not against
removing the IDs and see if anyone shouts.  On that basis I'll queue
this up.

Jonathan


> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 


