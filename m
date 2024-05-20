Return-Path: <linux-iio+bounces-5146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9948CA08E
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1021C20ED7
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A941136E3D;
	Mon, 20 May 2024 16:12:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A80137740;
	Mon, 20 May 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221534; cv=none; b=IfLxqPDyIAcJUy4bVcF+wFakOHfKwAp0dP3i0HUnXbe2JJkOg0/EVNkqwbZkRBJTGEBTze90WyVwfOV4IeQqJtw9bqDJGOTUaZLbEiIlSxdNYrRJNaQV22uza9okL79xHr201yXf6EcHekWnUVaEkuOiuwmChQd/BrIILlxiz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221534; c=relaxed/simple;
	bh=TGRn8nQiBIP7pFxI0vEU7EOZ9M0KlisQD3v6znpQzhQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOy40CsjIpud/rj8bdkuUZ++QvB9fO7817hm2fjqvGxyaDSgrhWMckPPowAgaaWIKnbb+2as3BSm0jGyH1KbRFP59u4FR4plwf+oklBvhX/MKLIF2U8wwuhIdXeCrsPwR1jcmv4SLhovamL2Al/RHkwAVk3HZr/hp7WstvGNiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjjD12x13z6JBjm;
	Tue, 21 May 2024 00:08:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B7F1400DD;
	Tue, 21 May 2024 00:12:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 17:12:06 +0100
Date: Mon, 20 May 2024 17:12:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
	<eblanc@baylibre.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
Message-ID: <20240520171205.000035b0@Huawei.com>
In-Reply-To: <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
	<20240519201241.7c60abac@jic23-huawei>
	<ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 20 May 2024 08:51:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/19/24 2:12 PM, Jonathan Cameron wrote:
> > On Tue,  7 May 2024 14:02:07 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> This adds new fields to the iio_channel structure to support multiple
> >> scan types per channel. This is useful for devices that support multiple
> >> resolution modes or other modes that require different data formats of
> >> the raw data.
> >>
> >> To make use of this, drivers can still use the old scan_type field for
> >> the "default" scan type and use the new scan_type_ext field for any
> >> additional scan types.  
> > 
> > Comment inline says that you should commit scan_type if scan_type_ext
> > is provided.  That makes sense to me rather that a default no one reads.
> > 
> > The example that follows in patch 4 uses both the scan_type and
> > the scan_type_ext which is even more confusing.
> >   
> >> And they must implement the new callback
> >> get_current_scan_type() to return the current scan type based on the
> >> current state of the device.
> >>
> >> The buffer code is the only code in the IIO core code that is using the
> >> scan_type field. This patch updates the buffer code to use the new
> >> iio_channel_validate_scan_type() function to ensure it is returning the
> >> correct scan type for the current state of the device when reading the
> >> sysfs attributes. The buffer validation code is also update to validate
> >> any additional scan types that are set in the scan_type_ext field. Part
> >> of that code is refactored to a new function to avoid duplication.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---  
> >   
> >> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> >> index 19de573a944a..66f0b4c68f53 100644
> >> --- a/include/linux/iio/iio.h
> >> +++ b/include/linux/iio/iio.h
> >> @@ -205,6 +205,9 @@ struct iio_scan_type {
> >>   * @scan_index:		Monotonic index to give ordering in scans when read
> >>   *			from a buffer.
> >>   * @scan_type:		struct describing the scan type
> >> + * @ext_scan_type:	Used in rare cases where there is more than one scan
> >> + *			format for a channel. When this is used, omit scan_type.  
> > 
> > Here is the disagreement with the patch description.
> >   
> >> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
> >>   * @info_mask_separate: What information is to be exported that is specific to
> >>   *			this channel.
> >>   * @info_mask_separate_available: What availability information is to be
> >> @@ -256,6 +259,8 @@ struct iio_chan_spec {
> >>  	unsigned long		address;
> >>  	int			scan_index;
> >>  	struct iio_scan_type scan_type;
> >> +	const struct iio_scan_type *ext_scan_type;
> >> +	unsigned int		num_ext_scan_type;  
> > 
> > Let's make it explicit that you can't do both.
> > 
> > 	union {
> > 		struct iio_scan_type scan_type;
> > 		struct {
> > 			const struct iio_scan_type *ext_scan_type;
> > 			unsigned int num_ext_scan_type;
> > 		};
> > 	};
> > should work for that I think.
> > 
> > However this is I think only used for validation. If that's the case
> > do we care about values not in use?  Can we move the validation to
> > be runtime if the get_current_scan_type() callback is used.  
> 
> I like the suggestion of the union to use one or the other. But I'm not
> sure I understand the comments about validation.
> 
> If you are referring to iio_channel_validate_scan_type(), it only checks
> for programmer error of realbits > storagebits, so it seems better to
> keep it where it is to fail as early as possible.

That requires the possible scan masks to be listed here but there is
nothing enforcing the callback returning one from here.  Maybe make it
return an index instead?

> 
> > 
> >   
> >>  	long			info_mask_separate;
> >>  	long			info_mask_separate_available;
> >>  	long			info_mask_shared_by_type;
> >> @@ -435,6 +440,9 @@ struct iio_trigger; /* forward declaration */
> >>   *			for better event identification.
> >>   * @validate_trigger:	function to validate the trigger when the
> >>   *			current trigger gets changed.
> >> + * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
> >> + *			in the channel spec to return the currently active scan
> >> + *			type based on the current state of the device.
> >>   * @update_scan_mode:	function to configure device and scan buffer when
> >>   *			channels have changed
> >>   * @debugfs_reg_access:	function to read or write register value of device
> >> @@ -519,6 +527,9 @@ struct iio_info {
> >>  
> >>  	int (*validate_trigger)(struct iio_dev *indio_dev,
> >>  				struct iio_trigger *trig);
> >> +	const struct iio_scan_type *(*get_current_scan_type)(
> >> +					const struct iio_dev *indio_dev,
> >> +					const struct iio_chan_spec *chan);
> >>  	int (*update_scan_mode)(struct iio_dev *indio_dev,
> >>  				const unsigned long *scan_mask);
> >>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
> >> @@ -804,6 +815,28 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
> >>  }
> >>  #endif
> >>  
> >> +/**
> >> + * iio_get_current_scan_type - Get the current scan type for a channel
> >> + * @indio_dev:	the IIO device to get the scan type for
> >> + * @chan:	the channel to get the scan type for
> >> + *
> >> + * Most devices only have one scan type per channel and can just access it
> >> + * directly without calling this function. Core IIO code and drivers that
> >> + * implement ext_scan_type in the channel spec should use this function to
> >> + * get the current scan type for a channel.
> >> + *
> >> + * Returns: the current scan type for the channel
> >> + */
> >> +static inline const struct iio_scan_type *iio_get_current_scan_type(
> >> +					const struct iio_dev *indio_dev,
> >> +					const struct iio_chan_spec *chan)
> >> +{
> >> +	if (indio_dev->info->get_current_scan_type)
> >> +		return indio_dev->info->get_current_scan_type(indio_dev, chan);
> >> +
> >> +	return &chan->scan_type;
> >> +}
> >> +
> >>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
> >>  
> >>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
> >>  
> >   
> 
> 


