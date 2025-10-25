Return-Path: <linux-iio+bounces-25434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE02C08BB3
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 07:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD1794E5D72
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB082D2495;
	Sat, 25 Oct 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="gua/ijhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D92D0C62
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371722; cv=none; b=tX13geZ4PVKoAZgcFHY9lnYx5BCC0SUC1LHZ8XcjVkmr38fzXvJX9N3ly0EMGq7ggotLTEAvumNNnSzBgJt/J9dnMOTX7XjwyIo2oyx7y6jL7jjLF+myKkY3LTthcykvtEsluVsCK6LCme5SZM9kEZb9vYg3iLy3bp95YGKPMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371722; c=relaxed/simple;
	bh=wstOIFFDyXnvi2d4rVVhQL2Pc9EfHyUwIfCTnxK+RNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huDWUDJtZizrt8iMft9Kz2DV/9ojtVdBhx9zSjl1AMil4fN2gPNdYT73JfyTd6FZQr5iaO0Peqhp08NMrkEeqz4AQlH3FqedV0miu8NaaljZMQ7OydpaNW7ATWieJ//6XICbzZysQgMW5QSA/0jhR46hVuuBgZaSweS7+iGZM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=gua/ijhQ; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 9B6BE104CBAB
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 11:25:17 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 9B6BE104CBAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761371717; bh=wstOIFFDyXnvi2d4rVVhQL2Pc9EfHyUwIfCTnxK+RNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gua/ijhQuNYdFNDPD8+HMJLp+gXmu8Jckj6dpvnmttQJ1PG6h6m1qABEaA2r5GPGc
	 v/GRFxtPLE0T4D1Bg31shLR5ts91mFejH/sAzaPcJLH6P0j7cnFnyVCv697xxg7HO5
	 lZE+/F7WKqf3Yjk5tEh9bjJ3mOWq0+nBLFt1CqQU=
Received: (qmail 20775 invoked by uid 510); 25 Oct 2025 11:25:17 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.445197 secs; 25 Oct 2025 11:25:17 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 25 Oct 2025 11:25:14 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 3D9453414DF;
	Sat, 25 Oct 2025 11:25:13 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id EDBC41E8160F;
	Sat, 25 Oct 2025 11:25:12 +0530 (IST)
Date: Sat, 25 Oct 2025 11:25:06 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <20251025-5556-944955@bhairav-test.ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
 <20251013-144614-1551316@bhairav-test.ee.iitb.ac.in>
 <aPp65bmTGk1qfPSE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPp65bmTGk1qfPSE@smile.fi.intel.com>

On Thu, Oct 23, 2025 at 09:58:45PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 13, 2025 at 08:16:14PM +0530, Akhilesh Patil wrote:
> > On Sat, Oct 11, 2025 at 05:10:58PM +0300, Andy Shevchenko wrote:
> > > On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> 
> ...
> 
> > > > +struct adp810_read_buf {
> > > > +       u8 dp_msb;
> > > > +       u8 dp_lsb;
> > > > +       u8 dp_crc;
> > > > +       u8 tmp_msb;
> > > > +       u8 tmp_lsb;
> > > > +       u8 tmp_crc;
> > > > +       u8 sf_msb;
> > > > +       u8 sf_lsb;
> > > > +       u8 sf_crc;
> > > > +} __packed;
> > > 
> > > Why __packed?
> > 
> > Yes. This is the structure used as a buffer to store sensor values read.
> > Each entry in this structure should be contiguous in the memory because
> > reference of this structure will be passed to i2c_master_recv() to
> > receive and fill the data.
> > __packed will avoid any compiler generated paddings in the structure to
> > force alignments on certain architectures. We do not want these paddings
> > and want our struct members to be sequentially ordered as shown, with
> > no padding and size of the struct should also be 9 bytes as only 9 bytes of
> > data should be read from the sensor as per the specification.
> > 
> > I could have used array here. But I preferred strcture for better
> > readability of the code as one can easily see what values are expected
> > from sensor while reading and in which order.
> 
> Right, but in this form packed only affects the last member size (due to
> alignment), in any case since it's HW mandated requirement, perhaps add a
> comment. (Since we also going to use __be16 types, the __packed is required
> for that to be properly placed in the memory.)

Sure. Added comment explaning this in v4.

Regards,
Akhilesh

> 
> 
> ...
> 
> > > > +struct adp810_data {
> > > > +       struct i2c_client *client;
> > > > +       /* Use lock to synchronize access to device during read sequence */
> > > > +       struct mutex lock;
> > > > +};
> > > 
> > > Is there a deliberate choice to not use regmap I²C APIs?
> > 
> > Yes. I explored that possibility. However this sensor follows simple I2C
> > client protocol. It does not expose the concept of I2C registers. It
> > does not follow smbus. Specifically, while reading the measurement from
> > the sensor, we need to only send the device address with read bit on the bus,
> > and start reading 9 bytes following that. That is, no register address
> > should be sent. I am not sure if regmap API has some hack to achive
> > similar because these APIs expect register addresses to read/write which
> > this sensor does not follow. Hence using raw i2c functions. I also
> > thought regmap abstraction is not needed here as this sensor has very
> > limited commands to send and not many command/configurations.
> 
> Ah, makes sense.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

