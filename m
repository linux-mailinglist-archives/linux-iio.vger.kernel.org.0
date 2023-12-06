Return-Path: <linux-iio+bounces-698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E179807C78
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398EF282558
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034B30321;
	Wed,  6 Dec 2023 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="TRXGwz5R"
X-Original-To: linux-iio@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F680181;
	Wed,  6 Dec 2023 15:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1701905968; bh=2dQNcN7bdjM98HXiyjnbSaNvqgEGnqu2nNK9lirrTl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRXGwz5RkVLWxNG6YEipwg4w/8wXef8IX6NUiHREhFfhwECx7632KXgaYaEICLafp
	 Bw6jaQY4cztX6aqeIvN3DCEnkX5LPcJ23+D2qyjKGBcTu0/BNkdzwUMVgTeGfx9c6b
	 tuv6L0rLP4861XJ4+ZpZ0Vhl+8cWQXsdi/H3qeDY=
Date: Thu, 7 Dec 2023 00:39:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org, 
	lars@metafoo.de, srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
Message-ID: <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>

Hi everybody,

On 2023-09-19 13:40:45+0530, Basavaraj Natikar wrote:
> This series adds support for light color temperature and chromaticity.
> 
> v1->v2:
> *Rename the series.
> *Rename als_illum to als channel as it supports other channels.
> *Update patch description to include same reading for the two existing
>  channels to use channel index to support more hub attributes.
> *Keep line length under 80chars in hid-sensor-als.
> *Add new channel type IIO_COLORTEMP.
> *Update patch description and its subject to add channel type for 
>  chromaticity. 
> 
> Basavaraj Natikar (9):
>   iio: hid-sensor-als: Use channel index to support more hub attributes
>   iio: Add channel type light color temperature
>   iio: hid-sensor-als: Add light color temperature support
>   HID: amd_sfh: Add support for light color temperature
>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>   iio: Add channel type for chromaticity
>   iio: hid-sensor-als: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity support
>   HID: amd_sfh: Add light chromaticity for SFH1.1

This series is breaking probing of hid-sensor-als on Framework 13 AMD
laptops [0].
The problem is that the patches require hid-sensors-als sensors to also
report chromaticity and color temparature which they don't.

When I remove the 'if (ret < 0) return ret;' checks in
als_parse_report() probing works and the illuminance/intensity channels
that show up behave as expected.
Unfortunately this still leaves behind a bunch of unusable channels.
A nice fix would be to have something like sysfs/hwmon .is_visible()
callback but that's not supported by IIO.

One aproach would be to detect the usable channels in als_parse_report()
and then adapt the indio_dev->channels based on that information.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=218223

#regzbot introduced: 5f05285df691b1e82108eead7165feae238c95ef
#regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=218223

