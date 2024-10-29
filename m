Return-Path: <linux-iio+bounces-11568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20749B4C3F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AF71C20E63
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38067206E6D;
	Tue, 29 Oct 2024 14:39:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073211361;
	Tue, 29 Oct 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212741; cv=none; b=RYGEqshdzQzEQYP6tu3gCx0h5hOePNsHbekkmhD8v1oAcof6GaKji6j+hEgpH9kHB9T6Ng2D7cIHY7clUnohT7k9OmHX3KcuprDpZOj57ihPQZ7/yURtI2X3wBIQWWq24XQAL0SYSwkOeDdUWfBCUJzx6j4c6vU6E6wm+NQ1Yd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212741; c=relaxed/simple;
	bh=aynmu0lhtRjGShVIoDYmCDwfmt4sXOBsD7bTpRyCQME=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4JStiqsP4JU2JNUZGHiPClBlumDxEfMVgripMKZ5SUA3udosQnowyzqcZSVlDO/JeUhMn7sW811ZsBl4S62ENP6scXPMJ4yim/m+aGt4mJGb4UH10Ul4lSOfVchwd1i8mhTle97NXoqPwsAw7aALBSsgccCohsftVi/X4m8mf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdCVz3w5Bz6J6cH;
	Tue, 29 Oct 2024 22:36:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D04D140393;
	Tue, 29 Oct 2024 22:38:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 15:38:49 +0100
Date: Tue, 29 Oct 2024 14:38:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ricardo Ribalda <ribalda@chromium.org>
CC: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Harvey Yang <chenghaoyang@google.com>, <linux-input@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: Add channel type for attention
Message-ID: <20241029143847.00004392@Huawei.com>
In-Reply-To: <CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
	<20241028-hpd-v2-3-18f6e79154d7@chromium.org>
	<20241028203437.3eb5268d@jic23-huawei>
	<CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 13:20:06 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Jonathan
> 
> On Mon, 28 Oct 2024 at 21:34, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 28 Oct 2024 10:12:23 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > Add a new channel type representing if the user's attention state to the
> > > the system. This usually means if the user is looking at the screen or
> > > not.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> > >  drivers/iio/industrialio-core.c         | 1 +
> > >  include/uapi/linux/iio/types.h          | 1 +
> > >  tools/iio/iio_event_monitor.c           | 2 ++
> > >  4 files changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 89943c2d54e8..d5a2f93bd051 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -2339,3 +2339,10 @@ KernelVersion: 6.10
> > >  Contact:     linux-iio@vger.kernel.org
> > >  Description:
> > >               The value of current sense resistor in Ohms.
> > > +
> > > +What:                /sys/.../iio:deviceX/in_attention_raw
> > > +KernelVersion:       6.13
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Boolean value representing the user's attention to the system.
> > > +             This usually means if the user is looking at the screen or not.  
> >
> > Hmm. I should have thought of this when I replied to suggest a new channel type.
> > The question is 'units' for a decision.
> >
> > Last time we hit something like this where processing is used to make a decision
> > we decided to at least allow for the concept of 'certainty'.
> >
> > The idea being that smarter sensors would tell us something about how sure they
> > are that the attention is on the device.
> > The analogy being with activity detection. See in_activity_walking_input
> > in Documentation/ABI/testing/sysfs-bus-iio
> >
> > Do you think that would be appropriate here as well?  For this device
> > it would take the values 0 and 100 rather than 0 and 1.  
> 
> For the particular device that I want to support, they are giving me a
> value of 1 and 0, and the example from usb.org seems to work the same
> way (Logical Maximum of 1)
> https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf
> 
> I have no problem multiplying my value by 100 if you think there will
> be a use case for that. It will not have a major performance impact on
> the driver.
Same was true (0 or 1) for the activity classification but I'm not
keen on certainty :)  So lets' copy that precedence and *100


> You decide ;)
> 
> >
> >  
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 6a6568d4a2cb..bdfb51275b68 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -95,6 +95,7 @@ static const char * const iio_chan_type_name_spec[] = {
> > >       [IIO_DELTA_VELOCITY] = "deltavelocity",
> > >       [IIO_COLORTEMP] = "colortemp",
> > >       [IIO_CHROMATICITY] = "chromaticity",
> > > +     [IIO_ATTENTION] = "attention",
> > >  };
> > >
> > >  static const char * const iio_modifier_names[] = {
> > > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > > index f2e0b2d50e6b..12886d4465e4 100644
> > > --- a/include/uapi/linux/iio/types.h
> > > +++ b/include/uapi/linux/iio/types.h
> > > @@ -51,6 +51,7 @@ enum iio_chan_type {
> > >       IIO_DELTA_VELOCITY,
> > >       IIO_COLORTEMP,
> > >       IIO_CHROMATICITY,
> > > +     IIO_ATTENTION,
> > >  };
> > >
> > >  enum iio_modifier {
> > > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > > index 8073c9e4fe46..ed9a677f1028 100644
> > > --- a/tools/iio/iio_event_monitor.c
> > > +++ b/tools/iio/iio_event_monitor.c
> > > @@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
> > >       [IIO_DELTA_VELOCITY] = "deltavelocity",
> > >       [IIO_COLORTEMP] = "colortemp",
> > >       [IIO_CHROMATICITY] = "chromaticity",
> > > +     [IIO_ATTENTION] = "attention",
> > >  };
> > >
> > >  static const char * const iio_ev_type_text[] = {
> > > @@ -183,6 +184,7 @@ static bool event_is_known(struct iio_event_data *event)
> > >       case IIO_DELTA_VELOCITY:
> > >       case IIO_COLORTEMP:
> > >       case IIO_CHROMATICITY:
> > > +     case IIO_ATTENTION:
> > >               break;
> > >       default:
> > >               return false;
> > >  
> >  
> 
> 


