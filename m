Return-Path: <linux-iio+bounces-5309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD768CF42C
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935091F217D9
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEFD266;
	Sun, 26 May 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKDr8sDO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80623C129;
	Sun, 26 May 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716725466; cv=none; b=vFwWpzRaZX/KlhQVRNuXwSBOzYIaUY/rjavu2wZVWi4fMmp2dVbiNlp9V4WafYO3tCu+5TWgIUBGecxwewsiPlII/Sq6KLsk5WL7KQhX1l+jrZET93saPV6CwFvd1JqzcrZVdC+tG5boHZoASDH5j11nwn/8q5Z7o98ci0mIhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716725466; c=relaxed/simple;
	bh=yxbwdeN2PxOOqOT+5MlpJZncAZLYV0mSBdHIDQMdQYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0IiobFHvoCabloubo2HSDUWOjiYiekUow7qWj5Fcd6V1tna3i9Pr4rDYcrJEVFQ2fuuvHU5WAYuTIyhIZH5GPIB2rB5xc9cR3dwmZVgZmMJsMoCRA00i5oQYQSZ0R1Qbvp+tVm0gKwX+SBc7rA3VsGuPi8Hw51EpR6UuX08So0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKDr8sDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE04C32782;
	Sun, 26 May 2024 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716725466;
	bh=yxbwdeN2PxOOqOT+5MlpJZncAZLYV0mSBdHIDQMdQYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKDr8sDOduDKwIX6vlohITrFLG+PK9X4u+UDxseik1BmHh9y4YT1xgaNuC1EZMMWj
	 MbEHyO9bzJKJNMCdrxZHFj0O3dsIJ9XaeIrz0lXf/ftJBJMIbpQ43jo2o8hz0b7qd3
	 lMb5QVrXHLx0NP8gj8er3hi9wz+aZLF6uq7zLGYJ8zyJTX5ZvZgPQo2fwiCURB/mDk
	 FwFn96/7Fgwg4sgNZRWqfzJlyjOzlHJzWWMww7mfg6VSL/W2BS95lrz+ZdtRXt1+zP
	 4rx072GpLSosfansU+u1ksfkNNXoUtrAgUUNQujLXECi7gn8brAVKw/KFfqPLRmG6L
	 yO82VBWJpuhIQ==
Date: Sun, 26 May 2024 13:10:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
Message-ID: <20240526131018.40c772d6@jic23-huawei>
In-Reply-To: <003d0998-dd25-45ab-9bb1-feda2d0f91a3@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
	<20240519201241.7c60abac@jic23-huawei>
	<ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
	<20240520171205.000035b0@Huawei.com>
	<5cf036d5-1eb3-4f63-82f9-d01b79b7fe47@baylibre.com>
	<20240525171408.36bda583@jic23-huawei>
	<003d0998-dd25-45ab-9bb1-feda2d0f91a3@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 May 2024 12:04:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/25/24 11:14 AM, Jonathan Cameron wrote:
> > On Fri, 24 May 2024 10:56:55 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 5/20/24 11:12 AM, Jonathan Cameron wrote:  
> >>> On Mon, 20 May 2024 08:51:52 -0500
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>     
> >>>> On 5/19/24 2:12 PM, Jonathan Cameron wrote:    
> >>>>> On Tue,  7 May 2024 14:02:07 -0500
> >>>>> David Lechner <dlechner@baylibre.com> wrote:
> >>>>>       
> >>>>>> This adds new fields to the iio_channel structure to support multiple
> >>>>>> scan types per channel. This is useful for devices that support multiple
> >>>>>> resolution modes or other modes that require different data formats of
> >>>>>> the raw data.
> >>>>>>
> >>>>>> To make use of this, drivers can still use the old scan_type field for
> >>>>>> the "default" scan type and use the new scan_type_ext field for any
> >>>>>> additional scan types.      
> >>>>>
> >>>>> Comment inline says that you should commit scan_type if scan_type_ext
> >>>>> is provided.  That makes sense to me rather that a default no one reads.
> >>>>>
> >>>>> The example that follows in patch 4 uses both the scan_type and
> >>>>> the scan_type_ext which is even more confusing.
> >>>>>       
> >>>>>> And they must implement the new callback
> >>>>>> get_current_scan_type() to return the current scan type based on the
> >>>>>> current state of the device.
> >>>>>>
> >>>>>> The buffer code is the only code in the IIO core code that is using the
> >>>>>> scan_type field. This patch updates the buffer code to use the new
> >>>>>> iio_channel_validate_scan_type() function to ensure it is returning the
> >>>>>> correct scan type for the current state of the device when reading the
> >>>>>> sysfs attributes. The buffer validation code is also update to validate
> >>>>>> any additional scan types that are set in the scan_type_ext field. Part
> >>>>>> of that code is refactored to a new function to avoid duplication.
> >>>>>>
> >>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>>>> ---      
> >>>>>       
> >>>>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> >>>>>> index 19de573a944a..66f0b4c68f53 100644
> >>>>>> --- a/include/linux/iio/iio.h
> >>>>>> +++ b/include/linux/iio/iio.h
> >>>>>> @@ -205,6 +205,9 @@ struct iio_scan_type {
> >>>>>>   * @scan_index:		Monotonic index to give ordering in scans when read
> >>>>>>   *			from a buffer.
> >>>>>>   * @scan_type:		struct describing the scan type
> >>>>>> + * @ext_scan_type:	Used in rare cases where there is more than one scan
> >>>>>> + *			format for a channel. When this is used, omit scan_type.      
> >>>>>
> >>>>> Here is the disagreement with the patch description.
> >>>>>       
> >>>>>> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
> >>>>>>   * @info_mask_separate: What information is to be exported that is specific to
> >>>>>>   *			this channel.
> >>>>>>   * @info_mask_separate_available: What availability information is to be
> >>>>>> @@ -256,6 +259,8 @@ struct iio_chan_spec {
> >>>>>>  	unsigned long		address;
> >>>>>>  	int			scan_index;
> >>>>>>  	struct iio_scan_type scan_type;
> >>>>>> +	const struct iio_scan_type *ext_scan_type;
> >>>>>> +	unsigned int		num_ext_scan_type;      
> >>>>>
> >>>>> Let's make it explicit that you can't do both.
> >>>>>
> >>>>> 	union {
> >>>>> 		struct iio_scan_type scan_type;
> >>>>> 		struct {
> >>>>> 			const struct iio_scan_type *ext_scan_type;
> >>>>> 			unsigned int num_ext_scan_type;
> >>>>> 		};
> >>>>> 	};
> >>>>> should work for that I think.
> >>>>>
> >>>>> However this is I think only used for validation. If that's the case
> >>>>> do we care about values not in use?  Can we move the validation to
> >>>>> be runtime if the get_current_scan_type() callback is used.      
> >>>>
> >>>> I like the suggestion of the union to use one or the other. But I'm not
> >>>> sure I understand the comments about validation.
> >>>>
> >>>> If you are referring to iio_channel_validate_scan_type(), it only checks
> >>>> for programmer error of realbits > storagebits, so it seems better to
> >>>> keep it where it is to fail as early as possible.    
> >>>
> >>> That requires the possible scan masks to be listed here but there is
> >>> nothing enforcing the callback returning one from here.  Maybe make it
> >>> return an index instead?
> >>>     
> >>
> >> Sorry, still not understanding what we are trying to catch here. Why
> >> would the scan mask have any effect of checking if realbits > storagebits?  
> > Hmm. I seem to be failing to explain this!    
> 
> Maybe we are talking about two different things but calling them the same thing?

I'm not sure.  Sounds like we both think our point is entirely obvious and clearly
it isn't :(

> > Key is the complete lack of
> > association between what is returned by the get_current_scan_type() callback
> > and this ext_scan_type array.  
> 
> Why would the caller of get_current_scan_type() need to know that the
> returned value is associated with ext_scan_type?

Because you are validating ext_scan_type, not the return of get_current_scan_type().
They may or may not include the same data - to make this a good interface, that isn't
error prone, get_current_scan_type() must return one that has been validated - i.e.
is in the ext_scan_type array.

I've looked several times and maybe I'm just failing to spot what ensures the validation
is sufficient.

> 
> > 
> > So either:
> > 1) Make it do so - easiest being to return an index into the array rather than
> >    a possibly unrelated scan_type -  
> 
> Unrelated to what?

Unrelated to anything the IIO core is currently aware of. You could have a list
of types of cats that you've validated for feline characteristics
and this callback returns a donkey.

> 
> > that would guarantee the scan_type returned
> >    by the callback was one that has been validated.  
> 
> Since all scan types are const data and not changed after the iio device
> is registered, the validation done at registration seems sufficient to
> me (validation happens in __iio_buffer_alloc_sysfs_and_mask()). All scan
> types are validated at this time, including all ext_scan_types. So all
> are guaranteed to be validated already when the get_current_scan_type
> callback is called.
> 
> What other validation would need to be done later?

What makes get_current_scan_type() return a scan type that is in the ext_scan_type
array?

A possible implementation (which should not be possible!) is

static const struct iio_scan_type scan_type_A = {
	.sign = 's',
	.realbits = 16,
	.storagebits = 16,
	.endianness = IIO_CPU,
};

static const struct iio_scan_type scan_type_B = {
	.sign = 's',
	.realbits = 18,
	.storagebits = 16,
	.endianness = IIO_CPU,
};

.ext_scan_type = &ad7380_scan_type_A,


static const struct iio_scan_type *get_current_scan_type(
		const struct iio_dev *indio_dev, struct iio_chan_spec const *chan)
{
	//some stuff to select

	return scan_type_B; 
}

> 
> > or
> > 2) Drop validation at initial probe because you are validating something
> >    that is irrelevant to what actually gets returned later. Validate>    when the scan type is read back via get_current_scan_type()  
> 
> The validation is just checking for programmer error, so it seems better
> to catch that at probe where we are guaranteed to catch it for all scan
> types. If the driver fails to probe, the programmer should notice this and
> fix their mistake, but if we don't validate until later, the programmer
> might not check every single configuration every time a change is made.

I agreed - but today that isn't happening in the above example.
You need to enforce that the scan_type returned is one that has been validated.

Maybe I'm missing that validation occurring somewhere?

Jonathan


> 
> > 
> > I prefer option 1.  
> >>  
> >   
> 
> 


