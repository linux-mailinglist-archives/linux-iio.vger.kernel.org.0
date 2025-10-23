Return-Path: <linux-iio+bounces-25399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07943C031D2
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDC644F7BF3
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8B34C12E;
	Thu, 23 Oct 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or2B9GkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CE3431E2;
	Thu, 23 Oct 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245935; cv=none; b=mw9s/bQoz/ovcIcKHq0x4H0i/dd02Y75oI1xPZ7rGBItFZagKYAisTsdVWSviZZZBX5roAv8M7TUOUKd9aM776DNPXTBsFmC9998QwFl6Wc4EHVHyRIXd3lTQVKwQKkx+r8JbORkApZbfdaqSjjmWQod1OQU4wxw67dxS6xinvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245935; c=relaxed/simple;
	bh=hK3K5Gzeg2JY/s9NsO/6Gk0B3y2knjEROaamIYrBoVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3w9M9SXXHW/M1R0+7wEQzZH5809GcBSjQSzB/udnNAtQLH3qrIyWqrJSHTkdWE3c2I0Uve6SA6HH5LyoixAbX5xRs+jjUU5On+hSWOuNoKLC0bhm8b0DAWi/sxujnV7v6f6hwmXxIwj2abp35o0wC22djIC2/y7g2crGTNpkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or2B9GkW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761245933; x=1792781933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hK3K5Gzeg2JY/s9NsO/6Gk0B3y2knjEROaamIYrBoVo=;
  b=Or2B9GkWYoORLrmFN183Z28gQmiFpz1QAn/cULSsrNtpMsnx2hgmDx9T
   uzehwejclBqEm6V7UwmTCtgyQSRO0aXEFJ4VTwfaY+Be8q+5DSepdW+da
   CmXfx3t/I9XmlHVrqmNgfg+/oEo4BMUrffeVGyyjM5tl7PHp4+gco/Nun
   pkU3/NyCxFNBU5o8ZmwCs6mKqsUBGA24OvFBhuWznkH+r8heZqCBCvHEZ
   bcDd8NHEgg2XUsLmp273PTGdMV1MIlmwOra8QZfWnVhIBmOd4m8myO0X+
   VqvCnq6n4fnNPk22H6i2lqyltC3P5IJJJjQUBicqmfDA9L6PYiSJ3/fNI
   Q==;
X-CSE-ConnectionGUID: O14/w7oeRLmfBDpuGxdv1A==
X-CSE-MsgGUID: 9uN6LVWxSSWyBZN1qD+fNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63350268"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63350268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:58:52 -0700
X-CSE-ConnectionGUID: wgrtrZS3TjWza+BE0gQl3A==
X-CSE-MsgGUID: NFRSOuszT1GX2YbffD7r+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="184130975"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:58:49 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vC0WM-0000000213t-0B1z;
	Thu, 23 Oct 2025 21:58:46 +0300
Date: Thu, 23 Oct 2025 21:58:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <aPp65bmTGk1qfPSE@smile.fi.intel.com>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <20251013-144614-1551316@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013-144614-1551316@bhairav-test.ee.iitb.ac.in>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 13, 2025 at 08:16:14PM +0530, Akhilesh Patil wrote:
> On Sat, Oct 11, 2025 at 05:10:58PM +0300, Andy Shevchenko wrote:
> > On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

...

> > > +struct adp810_read_buf {
> > > +       u8 dp_msb;
> > > +       u8 dp_lsb;
> > > +       u8 dp_crc;
> > > +       u8 tmp_msb;
> > > +       u8 tmp_lsb;
> > > +       u8 tmp_crc;
> > > +       u8 sf_msb;
> > > +       u8 sf_lsb;
> > > +       u8 sf_crc;
> > > +} __packed;
> > 
> > Why __packed?
> 
> Yes. This is the structure used as a buffer to store sensor values read.
> Each entry in this structure should be contiguous in the memory because
> reference of this structure will be passed to i2c_master_recv() to
> receive and fill the data.
> __packed will avoid any compiler generated paddings in the structure to
> force alignments on certain architectures. We do not want these paddings
> and want our struct members to be sequentially ordered as shown, with
> no padding and size of the struct should also be 9 bytes as only 9 bytes of
> data should be read from the sensor as per the specification.
> 
> I could have used array here. But I preferred strcture for better
> readability of the code as one can easily see what values are expected
> from sensor while reading and in which order.

Right, but in this form packed only affects the last member size (due to
alignment), in any case since it's HW mandated requirement, perhaps add a
comment. (Since we also going to use __be16 types, the __packed is required
for that to be properly placed in the memory.)


...

> > > +struct adp810_data {
> > > +       struct i2c_client *client;
> > > +       /* Use lock to synchronize access to device during read sequence */
> > > +       struct mutex lock;
> > > +};
> > 
> > Is there a deliberate choice to not use regmap I²C APIs?
> 
> Yes. I explored that possibility. However this sensor follows simple I2C
> client protocol. It does not expose the concept of I2C registers. It
> does not follow smbus. Specifically, while reading the measurement from
> the sensor, we need to only send the device address with read bit on the bus,
> and start reading 9 bytes following that. That is, no register address
> should be sent. I am not sure if regmap API has some hack to achive
> similar because these APIs expect register addresses to read/write which
> this sensor does not follow. Hence using raw i2c functions. I also
> thought regmap abstraction is not needed here as this sensor has very
> limited commands to send and not many command/configurations.

Ah, makes sense.

-- 
With Best Regards,
Andy Shevchenko



