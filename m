Return-Path: <linux-iio+bounces-9580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D56979222
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C872840E1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08BB1D0DDB;
	Sat, 14 Sep 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqaDsRsR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463A1D094F;
	Sat, 14 Sep 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332134; cv=none; b=ejUfg0cJvChGwLuV89VDZt1AuucqgRWQxKOfa1zD1CT2Jpvg35nwv2zgXdF12wNLtPAcPa//P6K1sRlhehrUMiOdqTPzT1e81uXXkBp2kq919O7XF0vcvdrU8/j3QkpMzCVgqME0XLbgGkWLv+cZ8xFAP6I5OAWoNEr3TVn06ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332134; c=relaxed/simple;
	bh=BehrkSCy4k+5P5Tq7BeB4SFRZoIjZMsgSUukxU0feWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6SdBKTHEi77XjJEiNbPyY0XWVcbHpTBgMtPfNpnyO0RDjBZyH8yodktk0RkbQPBTpuO5jAZQzA2CnGSnb5/bpZqS32WDJVrOWJIqE/eqCwxssJSZ0wkfnb9/vqLykabDFfmJDsRqYqHrE+koamCy4OPfT162k+PiihiIBE/rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqaDsRsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A453DC4CEC0;
	Sat, 14 Sep 2024 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726332134;
	bh=BehrkSCy4k+5P5Tq7BeB4SFRZoIjZMsgSUukxU0feWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqaDsRsRqBjzICFbFBW2zQ+cHLqGlvWAB8xYIRldpSg/IrVwjVJfOesGPeqROS16t
	 mQ4Y091mSD/vX4HwgT4Nf7ukWpH4wnjOnqMewM6w0VnNIPrG2+sSRkPF0dupcvcNoT
	 XwUeNA5pWHQacW/SkTekXtZLKMguUshPlkFbC8EocvkxumgwrsjpKSv0+TSctYBhLq
	 +cLz6JqZMYowhkilnXLm2hLVLwHRa6SjTjmIrbY/UraQ9cdAS/TxMELxZzxs2T01Fx
	 /Xg3psgq1tTePSDxwdQGoVaEN6Lr8iRqNlZVai6yunFEeslv7v2ITA4HilTbQKdly4
	 um4IaZoluBfYQ==
Date: Sat, 14 Sep 2024 17:42:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Nechita, Ramona" <Ramona.Nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20240914174203.352b139b@jic23-huawei>
In-Reply-To: <ZuR4IE-mwhL27ZG0@smile.fi.intel.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-3-ramona.nechita@analog.com>
	<CAHp75VdOjodDaz6J4sWOiT2HHmdXpOPcWeS5kz4e3rB_=gh3xw@mail.gmail.com>
	<SN6PR03MB4320EC2760F85BB6B0DDEED4F3652@SN6PR03MB4320.namprd03.prod.outlook.com>
	<ZuR4IE-mwhL27ZG0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 20:36:32 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 13, 2024 at 02:06:48PM +0000, Nechita, Ramona wrote:
> > >>
> > >> The filter mode / filter type property is used for ad4130 and ad7779
> > >> drivers, therefore the ABI doc file for ad4130 was removed, merging
> > >> both of them in the sysfs-bus-iio.  
> 
> ...
> 
> > >> +What:          /sys/bus/iio/devices/iio:deviceX/filter_type_available
> > >> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> > >> +KernelVersion: 6.1  
> > >
> > >I believe I have already commented on this. The commit message keeps silent about version changes. Why?  
> > 
> > I mentioned it in the cover-letter, since the attributes of two devices were
> > merged, and one of them was available in 6.1 ad the other in 6.2, it felt
> > appropriate to leave it as 6.1.
> > I was wondering if this is ok or if it should be kept as 6.2. Should this be
> > mentioned in the commit message as well?  
> 
> Please, mention in the commit message.
> 
> > >> +Contact:       linux-iio@vger.kernel.org
> > >> +Description:
> > >> +               Reading returns a list with the possible filter modes. Options
> > >> +               for the attribute:
> > >> +                       * "sinc3"       - The digital sinc3 filter. Moderate 1st conversion time.
> > >> +                   Good noise performance.
> > >> +                       * "sinc4"       - Sinc 4. Excellent noise performance. Long
> > >> +                       1st conversion time.
> > >> +                       * "sinc5"       - The digital sinc5 filter. Excellent noise performance
> > >> +                       * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> > >> +                   time.
> > >> +                       * "sinc3+rej60" - Sinc3 + 60Hz rejection.
> > >> +                       * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> > >> +                   time.
> > >> +                       * "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
> > >> +                       * "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
> > >> +                       * "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
> > >> +                       * "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.  
> > >
> > >Also, the original file was more verbose for the complex cases, like
> > >"sinc3+pfX", why has this been changed?  
> > 
> > Since this is a more generic file I was advised to leave out specific
> > details, should I include them just as they were in the original file?  
> 
> I would leave the examples for the mentioned chip in the parentheses. But it's
> up to Jonathan, I have no such device anyway, so personally I'm not affected
> :-)

It gets tricky as we gain more and more devices.  Nice to have that data somewhere, but
maybe a device specific document is more appropriate than keeping it in here?
(i.e. not in the ABI docs, but in general IIO per device documentation similar to the
 docs added recently for various other ADI parts).

Jonathan

> 


