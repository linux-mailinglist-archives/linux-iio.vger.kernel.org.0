Return-Path: <linux-iio+bounces-6168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64790263E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E811F21881
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B713E3F2;
	Mon, 10 Jun 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cY7rvHzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34B1DFF7;
	Mon, 10 Jun 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035373; cv=none; b=rBJZCqkHp+IGMVgOG21i1troXsKDAHD4NaCmdeiu5J5UWSAgfhu3PPzbngFvmxnupW28byhHWddtgqzkC5moTWG0GOwG/iyZZyzml2pHij2h06jLHGi0R5LDVu7wp9BHJD58yW6LYtRwvD9cy0DZ094H11nlCUU/6vkk2b33hfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035373; c=relaxed/simple;
	bh=Gcz7fOwlXUqLJ4zlLKeiHljHg40e3aKdlbVyk5EEDGs=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=sRD/Zmf/gv6a9PE2bVHXctVhLET2XMbWc/urS91Guxwfi7zWmTD5uFwMN8y6O6a7BcLZy7ZFTg1XOgnHavXagKYzP97bLwMiDMJW07VhEVMLmDA4t91vgubZ5AbCphZasuOp4ogbN/qByK7olz77oAHKqOMyQMTBRK1QZ5wDR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cY7rvHzp; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1718035360; bh=Gcz7fOwlXUqLJ4zlLKeiHljHg40e3aKdlbVyk5EEDGs=;
	h=Date:From:To:Cc:Subject;
	b=cY7rvHzpRMXwsmhsJSGll6SdR8r8rWnLcNK/KByWC0cvkOBNqbbEWdKBXCMi6eXmz
	 58WCDt/qRq3MjLCflUMzZ04axAo4s47gDgd61ql0YXNsCR8D5PKepW37m9o+F4LHwk
	 bE9FCknKjlm8i/r9YDhc9ROcfatNYcgr5YjEQHQMTMVjjdss6UPoJT6O044T329ed4
	 AzvAQj/WljTusirMKa1s1HwgQfzDUjh32v55kBdpY2fCTQnv5+I7da8/oRqLB8po8G
	 WZQTyby+TuqOhvd/OFbiAQBN/gsLALg8lv0QTnRBqAFjDy5voM7AmSgfTVom+8/n2C
	 WZIZYFgKWbS+Q==
Date: Mon, 10 Jun 2024 16:02:40 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Message-ID: <db376ece42e4eee823212ca3700f3d57@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-06 20:05, Jonathan Cameron wrote:
> On Thu, 06 Jun 2024 10:12:11 +0000
> kauschluss <kauschluss@disroot.org> wrote:
> 
>> On 2024-06-02 08:54, Jonathan Cameron wrote:
>> > On Sat, 1 Jun 2024 20:49:25 +0100
>> > Conor Dooley <conor@kernel.org> wrote:
>> >
>> >> On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:
>> >> > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> >> > index fd3749871121..329a4d6fb2ec 100644
>> >> > --- a/drivers/iio/accel/st_accel_i2c.c
>> >> > +++ b/drivers/iio/accel/st_accel_i2c.c
>> >> > @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
>> >> >  		.compatible = "st,lis2de12",
>> >> >  		.data = LIS2DE12_ACCEL_DEV_NAME,
>> >> >  	},
>> >> > +	{
>> >> > +		.compatible = "st,lis2ds12",
>> >> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
>> >> > +	},
>> >> >  	{
>> >> >  		.compatible = "st,lis2hh12",
>> >> >  		.data = LIS2HH12_ACCEL_DEV_NAME,
>> >>
>> >> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> >> > index f72a24f45322..825adab37105 100644
>> >> > --- a/drivers/iio/accel/st_accel_spi.c
>> >> > +++ b/drivers/iio/accel/st_accel_spi.c
>> >> > @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
>> >> >  		.compatible = "st,lis2dh12-accel",
>> >> >  		.data = LIS2DH12_ACCEL_DEV_NAME,
>> >> >  	},
>> >> > +	{
>> >> > +		.compatible = "st,lis2ds12",
>> >> > +		.data = LIS2DS12_ACCEL_DEV_NAME,
>> >> > +	},
>> >> >  	{
>> >> >  		.compatible = "st,lis3l02dq",
>> >> >  		.data = LIS3L02DQ_ACCEL_DEV_NAME,
>> >>
>> >> Any new compatibles need to be documented in st,st-sensors.yaml
>> >
>> > At the moment the st_sensors core is doing hard matching against whoami values
>> > which isn't good.  That should ideally be fixed and the binding for this
>> > device should use a fallback compatible if the statement about compatibility
>> > is accurate.
>> 
>> I apologize for not wording the description accurately. By 
>> "compatibility",
>> I mean that the sensor settings of LIS2DE12 (such as the gain values) 
>> seem
>> to be well-suited for LIS2DS12, as per my experimentation. Both 
>> devices are
>> manufactured by ST and have no correlation regarding compatibility 
>> whatsoever.
>> In that case, a fallback compatible isn't required, right?
> 
> If only the Who Am I value prevents it working if you give the 
> compatible
> as lisde12 then even though ST rarely if ever identifies it in 
> datasheets, they are
> software compatible.  In that case we should allow for a fallback 
> compatible.
> + fix the driver not to fail on the whoami mismatch.
> Note we don't care if they have totally different packages as long as
> the driver doesn't need to know that.  If they have different numbers
> of interrupts though or power supplies, then they aren't compatible and
> we shouldn't provide a fallback.
> 
> Roughly speaking you have to compare datahsheet sections for pins (not 
> which
> but what) and register maps.

I've thoroughly checked the registers, and indeed, a lot of registers 
addresses
and other settings are different. Although the sensor settings of 
LIS2DE12
"work", they are technically incorrect.

I've fixed it, and will send it with v4 in a day or two.

Thank you!

> That applies even if the current driver will fail to probe (for now)
>> 
>> I'll make sure to rewrite the description more accurately in v4.
>> 
>> > It may just be a case of relaxing the check in st_sensors_verify_id()
>> > to printing a warning not an error message and not returning an error code
>> > (reserving error returns in that function for bus error etc.
>> 
>> I agree, if you want I may send a patch for that after I'm done with 
>> this
>> one.
> Thanks,
> 
> Jonathan
> 
>> 
>> > That doesn't need to be in this patch though.  Just have the fallback
>> > stuff in the binding and for now we can rely on matching the more
>> > precise compatible.
>> >
>> > Jonathan
>> >
>> >
>> >>
>> >> Thanks,
>> >> Conor.
>> >>

