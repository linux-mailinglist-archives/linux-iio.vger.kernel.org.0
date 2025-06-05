Return-Path: <linux-iio+bounces-20230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB8ACE893
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 05:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20411757F8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 03:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18201F4174;
	Thu,  5 Jun 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRloyi+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9D8462;
	Thu,  5 Jun 2025 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749093221; cv=none; b=LdSo/2+qYluGk3qNYzn3IoxRVanTAD3FEUF1jKCEDuXv9TUCmL33F+V0b2i8cE+5L4Cupk+9+J72F7TxNSpSh4q6BlMn/WyYFZ9oq2PWX/QPy6aCmtLFDwXpozsuDmGuDxlnXnWmDnKbsYqkEoo/DiD2iNGoWBr2q35ygZ+AAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749093221; c=relaxed/simple;
	bh=AOHNhwOqdNxFK1UcPWQGWhaA+2VPHL1baOaJFJ5R9SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdBbf2b5J7oRDo/xm9Gptoaz8/7/oLX+UYkbdXHiduuV+vuPKOt/gR5q4kX1InNsUnfhwuRS9lqaxalUZF0g3b/tMsZkqT1JD91cWJ3+4mUGSIKlQtWEGFEd3ZWkqn8vXjQXTZckiTSd8gk7ribuqVriO6eSIwLT7VWMXDf6kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRloyi+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB772C4CEE4;
	Thu,  5 Jun 2025 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749093220;
	bh=AOHNhwOqdNxFK1UcPWQGWhaA+2VPHL1baOaJFJ5R9SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRloyi+dAVCZkdWUyAAczT9xLiSd17d2Di2GR3ieza5VaDMTww+xhDJrL+1BTf1HF
	 q7xWzDtg3Vq4TwypKNR8bAx3o6srV+wLdB303FsF/YTbR9cnP6AlK+ggj5mQBBUir8
	 ATUly/gNyqD6E7HAEKpDGHANvgPPtS503al5sYSdy3HiHWWjb5D5acpZZK3fo2Xvmx
	 1HwsAY335uhI9qg7pPddTPEyAkCZtvHYLi4jlMcRuk0ykHivftK9omCVHQun8xo2mf
	 hOIWdrVM1kBl/juSv+KNv3SJhYh1Ohwvx7Ye8EoQwUEF8t8stNH3iEWpTDpywpjqiS
	 RTKstH7D0K/nA==
Date: Thu, 5 Jun 2025 03:13:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: cros_ec_sensors: add cros_ec_activity driver
Message-ID: <aEELYUvKZ8FYLqPU@google.com>
References: <20250523172727.2654957-1-gwendal@google.com>
 <20250525144233.13df701f@jic23-huawei>
 <CAMHSBOUb-HPqmW3CFspipNGQGzbYUV+oqVw-Cbw0Bk4Huwz-QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHSBOUb-HPqmW3CFspipNGQGzbYUV+oqVw-Cbw0Bk4Huwz-QQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 10:41:25PM -0700, Gwendal Grignou wrote:
> > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> [...]
> > > @@ -2716,6 +2728,14 @@ struct ec_params_motion_sense {
> > >                        */
> > >                       int16_t hys_degree;
> > >               } tablet_mode_threshold;
> > > +
> > > +             /*
> > > +              * Used for MOTIONSENSE_CMD_GET_ACTIVITY.
> >
> > Single line comment works fine here and fits with local style.
> >                 /* Used for MOTIONSENSE_CMD_GET_ACTIVITY */
> >
> > > +              */
> > > +             struct __ec_todo_unpacked {
> > > +                     uint8_t sensor_num;
> > > +                     uint8_t activity;  /* enum motionsensor_activity */
> > > +             } get_activity;
> > >       };
> > >  } __ec_todo_packed;
> > >
> > > @@ -2833,6 +2853,10 @@ struct ec_response_motion_sense {
> > >                       uint16_t hys_degree;
> > >               } tablet_mode_threshold;
> > >
> > > +             /* USED for MOTIONSENSE_CMD_GET_ACTIVITY. */
> >
> > Maybe no fullstop is more consistent with local style? Only a bit visible
> > in this patch and I'm lazy  :)
> It is a mix and match in this file. Full stop is supposed to be the
> norm, but it was not always been the case. Remove full stop to blend
> with other commands.

It seems the full stop is still in v5.

Just a side note: people manually synchronizes the header with [1] when
needed.  I wouldn't bother with the details in the header as long as the
struct content is the same with [1].  Fix it or leave it as is are both
fine for me.

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

