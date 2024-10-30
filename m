Return-Path: <linux-iio+bounces-11640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A89B6992
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591091C20F2E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E2215027;
	Wed, 30 Oct 2024 16:51:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9021502A;
	Wed, 30 Oct 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307061; cv=none; b=M7dCFZEYi8YJbYE8V/CV+giesS8jbT6dFMnA2x5RHy06MbsQ1qzFCa1O30Y/GJMhipvZTw1LEuJLCddrNUFPKntQp7Mp/eve4ne/u1FXLX/FxgtJd5V9R5GS8OGXHmlHTOWILoLwpVZ9Uzklycxn59RqlHToyDPuMmAhA/F07I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307061; c=relaxed/simple;
	bh=bOTH/OjrpnC8FNfhLzXIlR186DhrR59YRd1DzOWN72Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTkWLs64FNzeNUpRIDXUhpLoZmdTGmHsSo6GLUWw2b3pOY5dANxwYrxsw70GiN+gdosoQA1CzzIOgmX/FQElOeKMUnmulL86Cuw8gL2iaHPx/gcWy73RuKjzGS6RxrhdoLh3nehAesQhhcJlc7tFQmwA9IPDuamzBNLsM0Ylamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdtQ70XY1z6K5VJ;
	Thu, 31 Oct 2024 00:49:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A9119140B39;
	Thu, 31 Oct 2024 00:50:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:50:53 +0100
Date: Wed, 30 Oct 2024 16:50:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Ricardo Ribalda <ribalda@chromium.org>, Jonathan Cameron
	<jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Harvey Yang <chenghaoyang@google.com>, <linux-input@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: Add channel type for attention
Message-ID: <20241030165051.000023a1@Huawei.com>
In-Reply-To: <b9da1c5e-3177-4bd1-abb2-5e92b0c2fb4c@baylibre.com>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
	<20241028-hpd-v2-3-18f6e79154d7@chromium.org>
	<20241028203437.3eb5268d@jic23-huawei>
	<CANiDSCu7G8gDKaY5jJR+JGyqGDobkDPRG+9NOfpXvVviqkQizA@mail.gmail.com>
	<20241029143847.00004392@Huawei.com>
	<b9da1c5e-3177-4bd1-abb2-5e92b0c2fb4c@baylibre.com>
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

On Tue, 29 Oct 2024 17:26:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/29/24 9:38 AM, Jonathan Cameron wrote:
> > On Tue, 29 Oct 2024 13:20:06 +0100
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >   
> >> Hi Jonathan
> >>
> >> On Mon, 28 Oct 2024 at 21:34, Jonathan Cameron <jic23@kernel.org> wrote:  
> >>>
> >>> On Mon, 28 Oct 2024 10:12:23 +0000
> >>> Ricardo Ribalda <ribalda@chromium.org> wrote:
> >>>    
> >>>> Add a new channel type representing if the user's attention state to the
> >>>> the system. This usually means if the user is looking at the screen or
> >>>> not.
> >>>>
> >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>> ---
> >>>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
> >>>>  drivers/iio/industrialio-core.c         | 1 +
> >>>>  include/uapi/linux/iio/types.h          | 1 +
> >>>>  tools/iio/iio_event_monitor.c           | 2 ++
> >>>>  4 files changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> >>>> index 89943c2d54e8..d5a2f93bd051 100644
> >>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >>>> @@ -2339,3 +2339,10 @@ KernelVersion: 6.10
> >>>>  Contact:     linux-iio@vger.kernel.org
> >>>>  Description:
> >>>>               The value of current sense resistor in Ohms.
> >>>> +
> >>>> +What:                /sys/.../iio:deviceX/in_attention_raw
> >>>> +KernelVersion:       6.13
> >>>> +Contact:     linux-iio@vger.kernel.org
> >>>> +Description:
> >>>> +             Boolean value representing the user's attention to the system.
> >>>> +             This usually means if the user is looking at the screen or not.    
> >>>
> >>> Hmm. I should have thought of this when I replied to suggest a new channel type.
> >>> The question is 'units' for a decision.
> >>>
> >>> Last time we hit something like this where processing is used to make a decision
> >>> we decided to at least allow for the concept of 'certainty'.
> >>>
> >>> The idea being that smarter sensors would tell us something about how sure they
> >>> are that the attention is on the device.
> >>> The analogy being with activity detection. See in_activity_walking_input
> >>> in Documentation/ABI/testing/sysfs-bus-iio
> >>>
> >>> Do you think that would be appropriate here as well?  For this device
> >>> it would take the values 0 and 100 rather than 0 and 1.    
> >>
> >> For the particular device that I want to support, they are giving me a
> >> value of 1 and 0, and the example from usb.org seems to work the same
> >> way (Logical Maximum of 1)
> >> https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf
> >>
> >> I have no problem multiplying my value by 100 if you think there will
> >> be a use case for that. It will not have a major performance impact on
> >> the driver.  
> > Same was true (0 or 1) for the activity classification but I'm not
> > keen on certainty :)  So lets' copy that precedence and *100
> > 
> >   
> And I assume we would want this to be in_attention_input (processed),
> not in_attention_raw.
Good point. Yes.
> 


