Return-Path: <linux-iio+bounces-10952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900F9AB6EB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7611F2360D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3D1C1AB6;
	Tue, 22 Oct 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh6y53OV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F51465A5;
	Tue, 22 Oct 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625662; cv=none; b=n6EI7DKaJLDQnhoMIAsDY/otFmDFsJqKD4RRQJfKpMNfToB7/GfUqDn3Dw05/5KAM2eWex0TTgE2HNTcm6dzdN7C1gBHOe302aWPTs5QfriyX/V/6MxGnqG6PS51V1aMoaiLatONrc56cnYXEs6OLVrzhEmGOnGqic3Eo8bZGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625662; c=relaxed/simple;
	bh=f8Llfb60xnUCcsnQgDguTbS4h0QP87LhUpUACf2PFv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+3QsAg7Q4l7bqPzcXb+tlm2IDeMLPAyJsrVxMtzjhyP8p2XgmUP9qGTqIHH9MmpRm/impoN+68TMs/+YPBBTtjxEiRxBZjo6L0kcoUnOHkuGoOM7fFAj+2p1CSw6tft5dzTPkHvVlC4z4IWVXqqBoj2KeXt7ORASv8HrgT3bN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh6y53OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0973C4CEC3;
	Tue, 22 Oct 2024 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625662;
	bh=f8Llfb60xnUCcsnQgDguTbS4h0QP87LhUpUACf2PFv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dh6y53OVytZiq8/L4tqm1pAmzweL7rSzbRciRovOGS1wXmRooWEnGzo6khEpGCXKL
	 vE2t4DdBfnRoVHq+dAAFX3yDgEAULpByHad+U1sReTCccJ4dveVRMBXw3RiWEaXZWc
	 KXOrslumJ2Dml3VrMdGoWGx+MwoVukch4bmNIElexOD4+M3LiKP+2aXUa2QmQutKgv
	 Fi/dqBnkXIZWBN34vjj2nYPZxM7y2u05mBxHg1Gex6YzkjK5/dbX8b3FlKSbn9ANyr
	 foNZ25a+obBiZ5csoqKFhOQr4fb2kXO2FcQ+uNpsk3yO11DoyB34HNVtKL+j1wqYKF
	 Sc6Y/6dikofqg==
Date: Tue, 22 Oct 2024 20:34:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>, Alex Lanzano <lanzano.alex@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: imu: bmi270: Add support for BMI260
Message-ID: <20241022203417.30971eea@jic23-huawei>
In-Reply-To: <ZxfYq1Eo2xhVhIei@smile.fi.intel.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-5-justin@justinweiss.com>
	<87msiwm90s.fsf@justinweiss.com>
	<ZxfYq1Eo2xhVhIei@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 19:54:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Oct 22, 2024 at 08:50:43AM -0700, Justin Weiss wrote:
> > Justin Weiss <justin@justinweiss.com> writes:  
> 
> ...
> 
> > The ACPI IDs with device pointers are here:
> >   
> > > +static const struct acpi_device_id bmi270_acpi_match[] = {
> > > +	/* OrangePi NEO */
> > > +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
> > > +	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
> > > +	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> > > +	/* GPD Win Max 2 */
> > > +	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },
> > > +	{ }  
> 
> Cool! But please, keep them alphabetically ordered by ID.
> 
> Can we push OrangePI NED to go and fix ACPI IDs eventually?
> 
> > > +};  
> > 
> > I pulled DSDT device excerpts for the GPD Win Mini (which uses the
> > BMI0160 ACPI ID, even though it has a bmi260) and the OrangePi NEO
> > (which uses the BMI0260 ACPI ID).
> > 
> > I couldn't find a shipping device with a bmi260 using the 10EC5280 ACPI
> > ID. Some prototype devices with the bmi260 may have used them:
> > https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
> > 
> > I can remove that ID from this changeset for now.  
> 
> Yes, please do not add anything that has no evidence of existence in the wild
> or approved vendor allocated ID.
> 
> > GPD Win Mini:  
> 
> Add short parts of these to the commit message, or better split these to two
> patches each of them adding a new ID to the table.
> 
> See below what I do want to see there (no need to have everything),
> i.e. I removed unneeded lines:
> 
> > Device (BMI2)
> > {
> >     Name (_ADR, Zero)  // _ADR: Address  
> 
> My gosh, can this be fixed (seems rhetorical)? The _ADR must NOT be present
> together with _HID.  It's against the ACPI specifications.
> 
> >     Name (_HID, "BMI0160")  // _HID: Hardware ID
> >     Name (_CID, "BMI0160")  // _CID: Compatible ID
> >     Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> >     Name (_UID, One)  // _UID: Unique ID
> >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >     {
> >         Name (RBUF, ResourceTemplate ()
> >         {
> >             I2cSerialBusV2 (0x0068, ControllerInitiated, 0x00061A80,
> >                 AddressingMode7Bit, "\\_SB.I2CB",
> >                 0x00, ResourceConsumer, , Exclusive,
> >                 )
> >             GpioInt (Edge, ActiveLow, Exclusive, PullDefault, 0x0000,
> >                 "\\_SB.GPIO", 0x00, ResourceConsumer, ,
> >                 )
> >                 {   // Pin list
> >                     0x008B
> >                 }
> >         })
> >         Return (RBUF) /* \_SB_.I2CB.BMI2._CRS.RBUF */
> >     }  
>       ...
> > }
> >   
> 
> > OrangePi NEO:  
> 
> Same comments for this device.
> 
> ...
> 
> > > +static const struct acpi_device_id bmi270_acpi_match[] = {
> > > +	{ "BOSC0260",  (kernel_ulong_t)&bmi260_chip_info },
> > > +	{ }
> > > +};  
> > 
> > I can't find any evidence of BOSC0260 being used, besides existing in
> > the Windows driver. As suggested in an earlier review, I added it here
> > to encourage people looking at this driver in the future to use the
> > correct ACPI ID.  
> 
> Are you official representative of Bosch or do you have a proof by the vendor
> that they allocated this ID? Otherwise we may NOT allocate IDs on their behalf
> and has not to be added.
Fair point. The provenance of the driver is a little disconnected from Bosch:
https://ayaneo-1305909189.cos.accelerate.myqcloud.com/ayaneo_com/download/2023/UMDF2.0_BMI260_V1.0.23_5ID_signed_20H1.zip

Justin, if you have contacts at ayaneo, maybe they can confirm if the IDs come
from Bosch. Or maybe we can find someone at Bosch?

Jonathan


> 


